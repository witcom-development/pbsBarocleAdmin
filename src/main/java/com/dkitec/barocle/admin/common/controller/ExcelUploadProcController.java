/*
 * @Package Name : com.dkitec.barocle.admin.common.controller
 * @파일명          : ExcelUploadProcController.java
 * @작성일          : 2015. 8. 14.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 8. 14.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.common.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.TreeSet;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.common.service.ExcelUploadProcService;
import com.dkitec.barocle.admin.common.vo.TreeVO;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.webutil.StringUtil;

/**
 * @파일명          : ExcelUploadProcController.java
 * @작성일          : 2015. 8. 14.
 * @작성자          : ymshin
 * 장치관리 일괄등록 엑셀 업로드 처리용 
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 8. 14.   |   ymshin   |  최초작성
 */
@Controller
@RequestCategory("ExcelUploadProcController")
@RequestMapping("/excel/")
public class ExcelUploadProcController  extends BaseController{
	
	protected static Logger log = LoggerFactory.getLogger(ExcelUploadProcController.class);
	@Resource(name="excelUploadProcService") private ExcelUploadProcService excelUploadProcService;
	
	private static String[] AP_COLUMN_NAME= {"DEVICE_ID","SERIAL_NO","LOCATE_NAME","ENTRPS_CD","IP_V4_ADDR","LAST_CHK_DTTM"};
	private static String[] TERMINAL_COLUMN_NAME= {"DEVICE_ID","SERIAL_NO","LOCATE_ID","ENTRPS_CD","DEVICE_MODL_CD","LAST_CHK_DTTM"};
	private static String[] ARM_COLUMN_NAME= {"DEVICE_ID","LOCATE_NAME","RACK_ORDER_NO","ENTRPS_CD","LAST_CHK_DTTM"};
	private static String[] BIKE_COLUMN_NAME= {"DEVICE_ID","DEVICE_NO","LOCATE_NAME","ENTRPS_CD","BIKE_SE_CD","LAST_CHK_DTTM"};
	private static String[] STOCK_COLUMN_NAME= {"CENTER_NAME","PART_CD","STOCK_QUNT"};
	private static String[] COUNSEL_COLUMN_NAME= {"CUST_NM","TALK_TNO","CONSL_DATE","TALK_STRT_DT","TALK_END_DT","CONSL_LCD","CONSL_MCD","REQUEST_CONSL_DSCRP"};
	
	@SuppressWarnings("rawtypes")
	@RequestMapping("{devType}/uploadExcel.do")
	@RequestName("insertDeviceReg")
	public String insertDeviceReg(@PathVariable("devType")String devType,@RequestParam("bulkFile")MultipartFile bulkFile, ModelMap model, HttpServletRequest request)  throws Exception, IOException, ClassNotFoundException {
		
		MultipartFile file = bulkFile;
		String fName = file.getOriginalFilename();
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
		String adminId = userSessionVO.getUsrId();
		List<HashMap<String, String>> addList = new ArrayList<HashMap<String,String>>();
		//"LINE_NO" , "ERROR_MSG"
		List<HashMap<String, String>> erroList =  new ArrayList<HashMap<String,String>>();
		HashMap<String, String> errorMap = null;
		HashMap<String, String> dataMap = null;
		int result = 0;
		@SuppressWarnings("unchecked")
		TreeSet<TreeVO> treeId = new TreeSet(new chkDupID());
		@SuppressWarnings("unchecked")
		TreeSet<TreeVO> treeSerial = new TreeSet(new chkDupID());
		@SuppressWarnings("unchecked")
		TreeSet<TreeVO> treeNo = new TreeSet(new chkDupID());
		int rowSize = 0;
		int cellSize = this.getDeviceTypeCellSize(devType);
		int errorChk =0;
		int lineChk=0;
		try {
			
			//AP   :  아이디 , 시리얼번호, 보관센터명, 아이피, 최종점검일
			//BIKE :  아이디, 번호, 보관센터명, 납품처명, 자전거구분, 최종점검일.
			//TERMINAL:아이디 , 시리얼번호, 자전거아이디, 단말기구분코드, 최종점검일
			//RACK : 아이디. 대여소명(?), 거치대번호, 최종점검일
			//COUNSEL : 아이디, 전화번호, 상담일, 통화시작시간, 통화종료시간, 상담유형(대), 상담유형(중), 상담내용
			/*1)컬럼에 공백이 있으면 ERROR
			  2)아이피의 경우는 아이피 포맷체크(xxx.xxx.xxx.xxx), 최종점검일 일자 포맷 체크(xxxx-xx-xx)
			  3)아이디,자전거번호, 시리얼번호 중복체크,거치대번호, 대여소명->대여소아이디. 
			  4)validataion 체크에 통과한 데이터만 실제로 DB입력.
			  5)누락된 데이터는 error Object에 담아서 화면에 돌려줌.
			*/
			if(fName != null && !"".equals(fName)) {
				String surffix = fName.split("\\.")[1];
				if(surffix.equalsIgnoreCase("xlsx")) {
					@SuppressWarnings("resource")
					XSSFWorkbook xssf = new XSSFWorkbook(file.getInputStream());
					XSSFSheet sheet = xssf.getSheetAt(0);
					rowSize = sheet.getPhysicalNumberOfRows();
					for(int i=1; i<rowSize ; i++) {
						dataMap = new HashMap<String, String>();
						dataMap.put("DEV_TYPE", devType);
						dataMap.put("ADMIN_ID", adminId);
						lineChk++;
						XSSFRow row = sheet.getRow(i);
						if(row == null){
							continue;
						}
						if(errorChk > 0){
							break;
						}
						if(row != null) {
							
							int rowCnt = 0;
							for(int cellColum=0; cellColum<cellSize; cellColum++ ) {
								XSSFCell cell =  row.getCell(cellColum);
								String cellStr = StringUtil.xssfCellTypeChkToString(cell);
								if(cellStr == null){
									rowCnt++;
								}
								errorMap = this.validXssfChk(cellStr , i, cellColum, devType);
								if(errorMap != null) {
									erroList.add(errorMap);
								}
								if(cellStr != null && cellColum == 0 && devType.startsWith("DEV")){
									treeId.add(new TreeVO(cellStr));
								}
								if(cellStr != null && (devType.equals(DEVICE_BIKE) && cellColum == 1 )) {
									treeNo.add(new TreeVO(cellStr));
								}
								if(cellStr != null && (devType.equals(DEVICE_AP) || devType.equals(DEVICE_TERMINAL)) && cellColum == 1 ) {
									treeSerial.add(new TreeVO(cellStr));
								}
								String[] columns = this.getDeviceColName(devType);
								dataMap.put(columns[cellColum], cellStr);
								if((rowCnt+1) == cellSize) {
									erroList.remove((erroList.size()-1));
								}
							}
						}
						addList.add(dataMap);
					}
				} else {
					@SuppressWarnings("resource")
					HSSFWorkbook hssf = new HSSFWorkbook(file.getInputStream());
					HSSFSheet sheet = hssf.getSheetAt(0);
					rowSize = sheet.getPhysicalNumberOfRows();
					for(int i=1; i<rowSize ; i++) {
						erroList = new ArrayList<HashMap<String,String>>();
						dataMap = new HashMap<String, String>();
						dataMap.put("DEV_TYPE", devType);
						dataMap.put("ADMIN_ID", adminId);
						lineChk++;
						HSSFRow row = sheet.getRow(i);
						if(row == null){
							continue;
						}
						if(errorChk > 0){
							break;
						}
						if(row != null) {
							int rowCnt = 0;
							cellSize = this.getDeviceTypeCellSize(devType);
							for(int cellColum=0; cellColum<cellSize; cellColum++ ) {
								HSSFCell cell =  row.getCell(cellColum);
								String cellStr = StringUtil.hssfCellTypeChkToString(cell);
								errorMap = this.validXssfChk(cellStr , i, cellColum, devType);
								if(errorMap != null) {
									erroList.add(errorMap);
								}
								if(cellStr != null && cellColum == 0 && devType.startsWith("DEV")){
									treeId.add(new TreeVO(cellStr));
								}
								if(cellStr != null && (devType.equals(DEVICE_BIKE) && cellColum == 1 )) {
									treeNo.add(new TreeVO(cellStr));
								}
								if(cellStr != null && (devType.equals(DEVICE_AP) || devType.equals(DEVICE_TERMINAL)) && cellColum == 1 ) {
									treeSerial.add(new TreeVO(cellStr));
								}
								String[] columns = this.getDeviceColName(devType);
								dataMap.put(columns[cellColum], cellStr);
								if((rowCnt+1) == cellSize) {
									erroList.remove((erroList.size()-1));
								}
							}
						}
						addList.add(dataMap);
					}
				}
			}
			int chkDupId=0;
		    int chkDupSerial=0;
		    int chkDupNo=0;
		    String[] arguments = {""};
		    //중복값이 제거됨. 중복된 아이디가 제거된 길이와 실제 엑셀데이터 길이가 같지 않으면 아이디 중복 error
		    if(treeId.size() > 1){
				for(Iterator<TreeVO> it = treeId.iterator(); it.hasNext();) {
				    TreeVO t1 = (TreeVO)it.next();
				    log.debug("DEVICE_ID==["+t1.getCHECKID()+"]");
				    chkDupId++;
			    }
				if(chkDupId != addList.size()) {
					arguments[0]= "아이디";
					errorMap = new HashMap<String, String>();
					errorMap.put("LINE_NO", "");
					errorMap.put("ERROR_MSG", getMessage("error.excel.data.dup", arguments));
					erroList.add(errorMap);
				}
		    }
		    if(treeNo.size() > 1 &&  devType.equals(DEVICE_BIKE)) {
		    	for(Iterator<TreeVO> it = treeNo.iterator(); it.hasNext();) {
				    TreeVO t1 = (TreeVO)it.next();
				    log.debug("DEVICE_ID==["+t1.getCHECKID()+"]");
				    chkDupNo++;
			    }
				if(chkDupNo != addList.size()) {
					arguments[0]= "자전거 번호";
					errorMap = new HashMap<String, String>();
					errorMap.put("LINE_NO", "");
					errorMap.put("ERROR_MSG", getMessage("error.excel.data.dup", arguments));
					erroList.add(errorMap);
				}
		    }
			if(devType.equals(IConstants.DEVICE_AP) || devType.equals(IConstants.DEVICE_TERMINAL)) {
				if(treeSerial != null && treeSerial.size() > 1 ){
					for(Iterator<TreeVO> it = treeSerial.iterator(); it.hasNext();) {
						TreeVO t1 = (TreeVO)it.next();
						log.debug("SERIAL_NO==["+t1.getCHECKID()+"]");
						chkDupSerial++;
					}
					if(chkDupSerial != addList.size()) {
						arguments[0] = "시리얼번호";
						errorMap = new HashMap<String, String>();
						errorMap.put("LINE_NO", "");
						errorMap.put("ERROR_MSG", getMessage("error.excel.data.dup", arguments));
						erroList.add(errorMap);
					}
				}
			}
			
			//거치대의 경우
			//거치대 대여소,거치대 번호 중복체크
            if(devType.equals(DEVICE_ARM)) {
            	for(int i= 0; i<addList.size(); i++) {
            		HashMap<String,String> arm = addList.get(i); 
	            	int chkOrderNum =  excelUploadProcService.isExistChkEquipOrder(arm);
	        		if(chkOrderNum > 0) {
	        			errorMap = new HashMap<String, String>();
	        			errorMap.put("LINE_NO", "- "+String.valueOf(i+1)+" Line");
	    				errorMap.put("ERROR_MSG", getMessage("error.excel.equiporder.dup"));
						erroList.add(errorMap);
	        		}
            	}
            }
			if(erroList.size() == 0) {
				if(devType.equals(IConstants.STOCK_PART)) {
					result = excelUploadProcService.addDevicePartStock(addList);
				} else if(devType.equals(IConstants.COUNSEL_LIST)){
					result = excelUploadProcService.addDeviceExcelData(addList);
				}else {
					result = excelUploadProcService.addDeviceExcelData(addList);
					
				}
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch(Exception ee) {
		    ee.printStackTrace();
		} finally {
		}
		model.addAttribute("excelFlg", devType);
		model.addAttribute(IConstants.CHECK_RESULT, result);
		model.addAttribute("erroList", erroList);
		return result > -1 ? "/admin/common/popup/opr_ex_up": ERROR_PAGE;
	}
    
	private String[] getDeviceColName(String devType) {
		if(devType.equals(IConstants.DEVICE_AP)) {
			return AP_COLUMN_NAME; 
		}else if(devType.equals(IConstants.DEVICE_TERMINAL)) {
			return TERMINAL_COLUMN_NAME;
		} else if(devType.equals(IConstants.DEVICE_ARM)) {
			return ARM_COLUMN_NAME;
		} else if(devType.equals(IConstants.DEVICE_BIKE)) {
			return BIKE_COLUMN_NAME;
		} else if(devType.equals(IConstants.COUNSEL_LIST)) {
			return COUNSEL_COLUMN_NAME;
		} else {
			return STOCK_COLUMN_NAME;
		}
	}

	private HashMap<String, String> validXssfChk(String cellStr , int idx, int idxCell, String devType) {
		HashMap<String, String> errorMap = null;
		HashMap<String, String> pMap = null;
		String[] msg = {String.valueOf((idxCell+1)) };
		String resultMsg = "";
		//공백
		if(cellStr== null || cellStr.equals("")) {
			resultMsg =  getMessage("error.excel.empty",msg);
		} else {
			if(devType.startsWith("DEV")) {
				//아이디 체크.
				if(!cellStr.equals("") && idxCell == 0) {
					pMap =  new HashMap<String, String>();
					//이미 DB에 등록되어있을경우.
					pMap.put("DEV_TYPE", devType);
					pMap.put("DEVICE_ID", cellStr);
					boolean isExistDeviceId = excelUploadProcService.chkExistDeviceId(pMap);
					if(isExistDeviceId) {
						msg[0] = "아이디";
						resultMsg = getMessage("error.excel.id.dup",msg);
					}
				}
				if(devType.equals(DEVICE_BIKE) && idxCell == 1) {
					boolean isBikeNo = excelUploadProcService.isChkExistBikeNo(cellStr);
					if(isBikeNo) {
						msg[0] = "자전거 번호";
					    resultMsg = getMessage("error.excel.id.dup", msg);
					}
				}
				if(devType.equals(IConstants.DEVICE_AP) && idxCell == 4) {
					boolean isIp = StringUtil.isIPv4Address(cellStr);
					if(!isIp) {
						resultMsg = getMessage("error.excel.ap.ip",msg);
					}
				}
				if((devType.equals(IConstants.DEVICE_AP) || devType.equals(IConstants.DEVICE_TERMINAL)) && idxCell == 1) {
					pMap =  new HashMap<String, String>();
					pMap.put("DEV_TYPE", devType);
					pMap.put("SERIAL_NO", cellStr);
					boolean existSerial = excelUploadProcService.chkSerialNo(pMap);
					if(existSerial) {
						msg[0] = "시리얼넘버";
						resultMsg = getMessage("error.excel.id.dup",msg);
					}
				}
				//대여소명
				if((devType.equals(IConstants.DEVICE_ARM) && idxCell == 1)) {
					boolean existSerial = excelUploadProcService.chkExistStation(cellStr);
					if(!existSerial) {
						msg[0] = "[대여소명]";
						resultMsg = getMessage("error.excel.locate.chk",msg);
					}
				}
				//센터명
				if( (devType.equals(IConstants.DEVICE_BIKE)  || devType.equals(IConstants.DEVICE_AP) )&& idxCell == 2) {
					boolean existSerial = excelUploadProcService.chkExistCenter(cellStr);
					if(!existSerial) {
						msg[0] = "[센터명]";
						resultMsg = getMessage("error.excel.locate.chk",msg);
					}
				}
				
				//납품처명
				if( (devType.equals(IConstants.DEVICE_BIKE)  || devType.equals(IConstants.DEVICE_AP)  || devType.equals(IConstants.DEVICE_TERMINAL) || devType.equals(IConstants.DEVICE_ARM) ) && idxCell == 3) {
					boolean existSerial = excelUploadProcService.chkExistEntrps(cellStr);
					if(!existSerial) {
						msg[0] = "[납품처명]";
						resultMsg = getMessage("error.excel.locate.chk",msg);
					}
				}
				
				//자전거 구분
				if( (devType.equals(IConstants.DEVICE_BIKE)) && idxCell == 4) {
					boolean existSerial = excelUploadProcService.chkExistBikeSeCd(cellStr);
					if(!existSerial) {
						msg[0] = "[자전거구분명]";
						resultMsg = getMessage("error.excel.locate.chk",msg);
					}
				}
				
				//단말기 구분
				if( (devType.equals(IConstants.DEVICE_TERMINAL)) && idxCell == 4) {
					//boolean existSerial = excelUploadProcService.chkExistBikeSeCd(cellStr);
					String existModelCd = cellStr;
					if(!(existModelCd.equals("DM2") || existModelCd.equals("DM4"))) {
						msg[0] = "[단말기구분]";
						resultMsg = getMessage("error.excel.locate.chk",msg);
					}
				}
				
				
				//단말기의 경우 부착 자전거ID가 유효한지 체크.
				if(devType.equals(DEVICE_TERMINAL) && idxCell == 2) {
					String isExistBikeId = excelUploadProcService.isExistBikeId(cellStr);
					
					if(isExistBikeId == null){
						resultMsg = getMessage("error.excel.bike.exist");
					}
					if(isExistBikeId !=null) {
						if(isExistBikeId.equals("")) {
							msg[0] = "[자전거 ID]";
							resultMsg = getMessage("error.excel.locate.chk",msg);
						} else {
							boolean isAlreadyExistBike = excelUploadProcService.isAlreadyExistTeminal(cellStr);
							if(isAlreadyExistBike) {
								resultMsg = getMessage("error.excel.added.terminal");
							}
						}
					} 
				}
				//최종점검일 날짜 포맷.
				int dateIdx = this.getDeviceTypeCellSize(devType);
				if((idxCell+1) == dateIdx) {
					boolean chk = StringUtil.isLastChkDttm(cellStr);
					if(!chk) {
						resultMsg = getMessage("error.excel.lastchk.date");
					}
				}
			} else if(devType.equals(IConstants.COUNSEL_LIST)){	// 티머니고 상담이력 추가
				// 전화번호
				if( idxCell == 0) {
					if(cellStr.equals("")){
						msg[0] = "[전화번호]";
						resultMsg = getMessage("error.excel.locate.chk",msg);
					}
				}
			}else {
				//센터명
				if( idxCell == 0) {
					boolean existSerial = excelUploadProcService.chkExistCenter(cellStr);
					if(!existSerial) {
						msg[0] = "[센터명]";
						resultMsg = getMessage("error.excel.locate.chk",msg);
					}
				}
				//부품명
				if( idxCell == 1) {
					boolean existPart = excelUploadProcService.chkExistParts(cellStr);
					if(!existPart) {
						resultMsg = getMessage("error.excel.part.chk");
					}
				}
				//부품명
				if( idxCell == 2) {
					boolean existPart = StringUtil.isNumeric(cellStr);
					if(!existPart) {
						resultMsg = getMessage("error.excel.number.format");
					}
				}
			}
		}
		if(!resultMsg.equals("")) {
			errorMap = new HashMap<String, String>();
			errorMap.put("LINE_NO", "- "+String.valueOf((idx+1))+" Line");
			errorMap.put("ERROR_MSG",resultMsg);
		}
		return errorMap;
	}

	/**
     * cell size 고정.
     * */
	private int getDeviceTypeCellSize(String devType) {
		int cellSize = 0;
		if(devType.equals(IConstants.DEVICE_AP)) {
			cellSize = 6;
		} else if(devType.equals(IConstants.STOCK_PART)) {
			cellSize = 3;
		} else if(devType.equals(IConstants.DEVICE_BIKE)) {	// 자전거 등록시 자전거 구분 추가로 변경
			cellSize = 6;
		} else if(devType.equals(IConstants.DEVICE_TERMINAL)) {
			cellSize = 6;
		}else if(devType.equals(IConstants.COUNSEL_LIST)) {
			cellSize = 8;
		} else {
			cellSize = 5;
		}
		return cellSize;
	}

}
