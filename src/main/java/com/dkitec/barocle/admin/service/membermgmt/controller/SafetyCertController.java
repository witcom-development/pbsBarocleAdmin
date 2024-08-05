package com.dkitec.barocle.admin.service.membermgmt.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.TreeSet;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

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
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.common.controller.chkDupID;
import com.dkitec.barocle.admin.common.vo.TreeVO;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO;
import com.dkitec.barocle.admin.service.membermgmt.service.SafetyCertDiscountService;
import com.dkitec.barocle.admin.service.membermgmt.service.SafetyCertPaymentService;
import com.dkitec.barocle.admin.service.membermgmt.service.SafetyCertService;
import com.dkitec.barocle.admin.service.membermgmt.service.SafetyCertUserService;
import com.dkitec.barocle.admin.service.membermgmt.vo.MemberMgmtVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.MemberPaymentVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.SafetyCertUserVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.sms.SmsSender;
import com.dkitec.barocle.util.sms.vo.SmsMessageVO;
import com.dkitec.barocle.util.webutil.DateUtil;
import com.dkitec.barocle.util.webutil.HttpUtil;
import com.dkitec.barocle.util.webutil.StringUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="SafetyCertController")
@RequestMapping(value="/admin/service/safetycert")
public class SafetyCertController extends BaseController {
	
	private static final String RETURN_URL = "/admin/service/safetycert";

	protected static Logger log = LoggerFactory.getLogger(SafetyCertController.class);
		
	
	@Resource(name = "safetyCertService") private SafetyCertService safetyCertService;
	@Resource(name="commonCodeService") private CommonCodeService commonCodeService;
	@Resource(name = "safetyCertPaymentService") private SafetyCertPaymentService safetyCertPaymentService;
	@Resource(name = "safetyCertDiscountService") private SafetyCertDiscountService safetyCertDiscountService;
	@Resource(name = "safetyCertUserService") private SafetyCertUserService safetyCertUserService;
	

	protected static Logger logger = LoggerFactory.getLogger(SafetyCertController.class);
	
	private static String[] COLUMN_NAME= {"certNum", "usrName", "usrMpnNo", "usrPrvCd", "certDate", "certCls", "certOrg", "certEdDate", "mbId"};//,  "disSDttm", "disEDttm"
	private static boolean[] NULLABLE = {false, false, false, false, false, false, false, false, true};
	private static final int CELLSIZE = 9;
	
	/**
	 * 공통 리턴화면 
	 * @param methodName
	 * @return
	 */
	protected String getReturnUrl(String methodName) {
		return "/admin/service/safetycert/" + methodName;
	}
	
	/**
	 * 회원 정보 목록 조회
	 * @param safetyCertUserVO
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="safetyCertUserList")
	@RequestMapping(value="safetyCertUserList")
	public String safetyCertUserList(  SafetyCertUserVO safetyCertUserVO, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		log.debug(result.hasErrors() + "");
		if (!result.hasErrors()) {
			model.put("result", "");
		} else {
			log.debug( result.getAllErrors().get(0).getDefaultMessage());
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("svc_sft_cert_usr_list");
		}
		
		
		safetyCertUserVO.setLang(request.getLocale().getLanguage());
		
		boolean bResult = false;
		List<SafetyCertUserVO> safetyCertUserList = null;
		
		safetyCertUserVO.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
		safetyCertUserVO.setPageSize(propertiesService.getInt("pageSize"));
		// 페이징 처리
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(safetyCertUserVO.getCurrentPageNo());
		
		paginationInfo.setRecordCountPerPage(safetyCertUserVO.getPageSize());
		paginationInfo.setPageSize(safetyCertUserVO.getRecordCountPerPage());
		safetyCertUserVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
		safetyCertUserVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		
		try {
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			cal.add(Calendar.DAY_OF_MONTH, -90); //shoh2999 기본 일주일전
			String strDay = sdf.format(cal.getTime());
			
			if(safetyCertUserVO.getSearchStartDate() == null){
				//safetyCertUserVO.setSearchStartDate(strDay);
				// 20200811 변경
				safetyCertUserVO.setSearchStartDate(strDay);
				//safetyCertUserVO.setSearchStartDate("2015-09-01");
			}
			if(safetyCertUserVO.getSearchEndDate() == null){
				safetyCertUserVO.setSearchEndDate(nowDay);
			}
			 
			// 7일이상등 날짜 기간 제약
//			if( !"".equals(StringUtil.nullToBlank( safetyCertUserVO.getSearchValue()))
//				) {
//				safetyCertUserVO.setSearchStartDate("2015-09-01");	
//			} else {
//				if(  diffOfDate(safetyCertUserVO.getSearchStartDate(), safetyCertUserVO.getSearchEndDate()) > 7 ) {
//					safetyCertUserVO.setSearchStartDate( strDay );
//				}	
//			}
			
			// total count
			paginationInfo.setTotalRecordCount(safetyCertUserService.safetyCertUserListCnt(safetyCertUserVO));
			// 목록 조회
			safetyCertUserList = safetyCertUserService.safetyCertUserList(safetyCertUserVO);
						
			model.put("safetyCertUserList", safetyCertUserList);
			model.put("paginationInfo", paginationInfo);
			model.put("form", safetyCertUserVO);
			
			bResult = true;
			
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.service.safetycert.safetyCertUserList");
		}
		
		return bResult? getReturnUrl("svc_sft_cert_usr_list") : ERROR_PAGE;
		
	}
	
	public static long diffOfDate(String begin, String end) throws Exception
	{
	    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

	    Date beginDate = formatter.parse(begin);
	    Date endDate = formatter.parse(end);

	    long diff = endDate.getTime() - beginDate.getTime();
	    long diffDays = diff / (24 * 60 * 60 * 1000);

	    return diffDays;
	}
	
	@RequestMapping(value = "/openUploadPop.do")
	@RequestName("openUploadPop")
	public String openUploadPop(@ModelAttribute ApVO apVo, ModelMap model, HttpServletRequest request )  throws Exception {
		String bizName = "인증제 합격자 excel등록 팝업 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
//		model.addAttribute("excelFlg", deviceType);
		model.addAttribute("errorList", new ArrayList<String>());
		return RETURN_URL.concat("/sft_cert_usr_opr_ex_up");
	}
	
	@SuppressWarnings("rawtypes")
	@RequestMapping("/insertSafetyCertUserWithExcel.do")
	@RequestName("insertSafetyCertUserWithExcel")
	public String insertSafetyCertUserWithExcel(@RequestParam("bulkFile")MultipartFile bulkFile, ModelMap model, HttpServletRequest request)  throws Exception, IOException, ClassNotFoundException {
		
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
		int cellSize = CELLSIZE;//this.getDeviceTypeCellSize(devType);
		int errorChk =0;
		int lineChk=0;
		try {
			
			if(fName != null && !"".equals(fName)) {
				String surffix = fName.split("\\.")[1];
				if(surffix.equalsIgnoreCase("xlsx")) {
					@SuppressWarnings("resource")
					XSSFWorkbook xssf = new XSSFWorkbook(file.getInputStream());
					XSSFSheet sheet = xssf.getSheetAt(0);
					rowSize = sheet.getPhysicalNumberOfRows();
					for(int i=1; i<rowSize ; i++) {
						dataMap = new HashMap<String, String>();
//						dataMap.put("DEV_TYPE", devType);
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
								errorMap = this.validXssfChk(cellStr , i, cellColum);//, devType);
								if(errorMap != null) {
									erroList.add(errorMap);
								}
								if(cellStr != null && cellColum == 8){
									if(StringUtil.isEmpty(cellStr)) {
										treeId.add(new TreeVO(UUID.randomUUID().toString())); //빈값은 랜덤 값 넣어줌
									}else {
										treeId.add(new TreeVO(cellStr)); //아이디	
									}
								}
								if(cellStr != null && cellColum == 2) {
									treeNo.add(new TreeVO(cellStr));//전화번호
								}
								if(cellStr != null && cellColum == 0 ) {
									treeSerial.add(new TreeVO(cellStr));//응시번호
								}
								String[] columns = COLUMN_NAME;
								dataMap.put(columns[cellColum], cellStr);
								if((rowCnt+1) == cellSize) {
									erroList.remove((erroList.size()-1));
								}
							}
							
							//날짜 체크
							dataMap = addAdditionalData(dataMap, i);  //error check(전번과 다른 id) 동시에 
						}
						if (dataMap.containsKey("ERROR_MSG")) {
							erroList.add(dataMap);
						}else {
							addList.add(dataMap);	
						}
					}
				} else {
					@SuppressWarnings("resource")
					HSSFWorkbook hssf = new HSSFWorkbook(file.getInputStream());
					HSSFSheet sheet = hssf.getSheetAt(0);
					rowSize = sheet.getPhysicalNumberOfRows();
					for(int i=1; i<rowSize ; i++) {
						erroList = new ArrayList<HashMap<String,String>>();
						dataMap = new HashMap<String, String>();
//						dataMap.put("DEV_TYPE", devType);
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
							cellSize = CELLSIZE;//this.getDeviceTypeCellSize(devType);
							for(int cellColum=0; cellColum<cellSize; cellColum++ ) {
								HSSFCell cell =  row.getCell(cellColum);
								String cellStr = StringUtil.hssfCellTypeChkToString(cell);
								errorMap = this.validXssfChk(cellStr , i, cellColum);//, devType);
								if(errorMap != null) {
									erroList.add(errorMap);
								}
								if(cellStr != null && cellColum == 8){
									if(StringUtil.isEmpty(cellStr)) {
										treeId.add(new TreeVO(UUID.randomUUID().toString())); //빈값은 랜덤 값 넣어줌
									}else {
										treeId.add(new TreeVO(cellStr)); //아이디	
									}
								}
								if(cellStr != null && cellColum == 2 ) {
									treeNo.add(new TreeVO(cellStr));
								}
								if(cellStr != null && cellColum == 0 ) {
									treeSerial.add(new TreeVO(cellStr));
								}
								String[] columns = COLUMN_NAME;
								dataMap.put(columns[cellColum], cellStr);
								if((rowCnt+1) == cellSize) {
									erroList.remove((erroList.size()-1));
								}
							}
							//날짜 체크
							dataMap = addAdditionalData(dataMap, i);  //error check(전번과 다른 id) 동시에 
						}
						if (dataMap.containsKey("ERROR_MSG")) {
							erroList.add(dataMap);
						}else {
							addList.add(dataMap);	
						}
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
				    log.debug("mbId==["+t1.getCHECKID()+"]");
				    chkDupId++;
			    }
				if(chkDupId != (rowSize-1)) { //addList.size()) {
					arguments[0]= "아이디";
					errorMap = new HashMap<String, String>();
					errorMap.put("LINE_NO", "");
					errorMap.put("ERROR_MSG", getMessage("error.excel.data.dup", arguments));
					erroList.add(errorMap);
				}
		    }
		    if(treeNo.size() > 1) {// &&  devType.equals(DEVICE_BIKE)) {
		    	for(Iterator<TreeVO> it = treeNo.iterator(); it.hasNext();) {
				    TreeVO t1 = (TreeVO)it.next();
				    log.debug("usrMpNo==["+t1.getCHECKID()+"]");
				    chkDupNo++;
			    }
				if(chkDupNo != (rowSize-1)) { //addList.size()) {
					arguments[0]= "전화번호";
					errorMap = new HashMap<String, String>();
					errorMap.put("LINE_NO", "");
					errorMap.put("ERROR_MSG", getMessage("error.excel.data.dup", arguments));
					erroList.add(errorMap);
				}
		    }
			
			if(treeSerial != null && treeSerial.size() > 1 ){
				for(Iterator<TreeVO> it = treeSerial.iterator(); it.hasNext();) {
					TreeVO t1 = (TreeVO)it.next();
					log.debug("certNum==["+t1.getCHECKID()+"]");
					chkDupSerial++;
				}
				if(chkDupSerial != (rowSize-1)) { //addList.size()) {
					arguments[0] = "응시번호";
					errorMap = new HashMap<String, String>();
					errorMap.put("LINE_NO", "");
					errorMap.put("ERROR_MSG", getMessage("error.excel.data.dup", arguments));
					erroList.add(errorMap);
				}
			}
			
			
			if(erroList.size() == 0) {
				result = safetyCertUserService.addSafetyCertUserExcelData(addList);
				
				//sms로 시작 문자 넣어 줌
				for(HashMap<String, String> map : addList) {        
					SmsMessageVO msg = new SmsMessageVO();
					msg.setTitle(CERT_DIS_START_MSG_TITLE);
					msg.setMsg(CERT_DIS_START_MSG);
					msg.setDestno(map.get("usrMpnNo"));
//					msg.setAutoSendId(SendType.SMS_016.getCode());
					SmsSender.sender(msg);
		        }
				
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch(Exception ee) {
		    ee.printStackTrace();
		} finally {
		}
//		model.addAttribute("excelFlg", devType);
		model.addAttribute(IConstants.CHECK_RESULT, result);
		model.addAttribute("erroList", erroList);
		return result > -1 ? "/admin/service/safetycert/sft_cert_usr_opr_ex_up": ERROR_PAGE;
	}
	
	private HashMap<String, String> validXssfChk(String cellStr , int idx, int idxCell){//, String devType) {
		HashMap<String, String> errorMap = null;
		HashMap<String, String> pMap = null;
		String[] msg = {String.valueOf((idxCell+1)) };
		String resultMsg = "";
		//공백
		if((cellStr== null || cellStr.equals("")) && !NULLABLE[idxCell]) {
			resultMsg =  getMessage("error.excel.empty",msg);
		} else {
			if(!cellStr.equals("") && idxCell == 0) { //응시번호 체크
				pMap =  new HashMap<String, String>();
				//이미 DB에 등록되어있을경우.
				pMap.put("certNum", cellStr);
				boolean isExistDeviceId = safetyCertUserService.chkCertNum(pMap);
				if(isExistDeviceId) {
					msg[0] = "응시번호";
					resultMsg = getMessage("error.excel.id.dup",msg);
				}
			}
			
			//연락처
			if(!cellStr.equals("") && idxCell == 2) { //연락처 체크
				pMap =  new HashMap<String, String>();
				//이미 DB에 등록되어있을경우.
				pMap.put("usrMpnNo", cellStr);
				boolean isExistDeviceId = safetyCertUserService.chkUsrMpnNo(pMap);
				if(isExistDeviceId) {
					msg[0] = "연락처";
					resultMsg = getMessage("error.excel.id.dup",msg);
				}
				String regExp = "^\\d{3}-\\d{3,4}-\\d{4}$";
				if(!StringUtil.isRegexPatternInclude(cellStr, regExp)) {
					resultMsg = "유효하지 않은 전화번호입니다.";
				}
			}
			
			//날짜 포맷-응시일
			if(idxCell == 4) {
				boolean chk = StringUtil.isLastChkDttm(cellStr);
				if(!chk) {
					resultMsg = "[응시일]의 형식은  YYYY-MM-DD 입니다. 확인 바랍니다.";//getMessage("error.excel.lastchk.date");
				}
			}
			
			//날짜 포맷-안전교육일
			if(idxCell == 7) {
				boolean chk = StringUtil.isLastChkDttm(cellStr);
				if(!chk) {
					resultMsg = "[안전교육일자]의 형식은  YYYY-MM-DD 입니다. 확인 바랍니다.";//getMessage("error.excel.lastchk.date");
				}
			}
			
			if(!cellStr.equals("") && idxCell == 8) { //아이디
				pMap =  new HashMap<String, String>();
				//이미 DB에 등록되어있을경우.
				pMap.put("certNum", cellStr);
				boolean isExistDeviceId = safetyCertUserService.chkCertNum(pMap);
				if(isExistDeviceId) {
					msg[0] = "아이디";
					resultMsg = getMessage("error.excel.id.dup",msg);
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
	
	private HashMap<String,String> addAdditionalData(HashMap<String,String> orgData, int idx){
		HashMap<String,String> tempData = orgData;
		HashMap<String, String> errorMap = null;
		String mpnNo = orgData.get("usrMpnNo");
		String mbId = orgData.get("mbId");
		SafetyCertUserVO safetyCertUser = safetyCertUserService.getCertInfoWithMpnNo(mpnNo);
		if (safetyCertUser != null) {
			if (StringUtil.isEmpty(safetyCertUser.getMbId()) || !safetyCertUser.getMbId().equals(mbId)) {
				String resultMsg = "전화번호와 ID가 다릅니다.";
				errorMap = new HashMap<String, String>();
				errorMap.put("LINE_NO", "- "+String.valueOf((idx+1))+" Line");
				errorMap.put("ERROR_MSG",resultMsg);
				return errorMap;
			}
			tempData.put("usrUsrSeq", safetyCertUser.getUsrUsrSeq());
			tempData.put("mbYn", "Y");
		}else {
			tempData.put("mbYn", "N");
		}
		String certEdDate = orgData.get("certEdDate");
		String disStartDate = DateUtil.formatDateTime(certEdDate,"yyyy-MM-dd","yyyyMMdd");
		tempData.put("disSDttm", disStartDate);
		String disEDttm = DateUtil.advance(DateUtil.advance(disStartDate,2,2),5,-1) + "235959";
		tempData.put("disEDttm", disEDttm);
		return tempData;
	}
	
	/**
	 * 회원 정보 목록 조회
	 * @param safetyCertUser
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="safetyCertUserListExcel")
	@RequestMapping(value="safetyCertUserListExcel")
	public String safetyCertUserListExcel(  SafetyCertUserVO safetyCertUser, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		log.debug(result.hasErrors() + "");
		if (!result.hasErrors()) {
			model.put("result", "");
		} else {
			log.debug( result.getAllErrors().get(0).getDefaultMessage());
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("svc_usr_list");
		}
		
		safetyCertUser.setLang(request.getLocale().getLanguage());
		
		boolean bResult = false;
		List<SafetyCertUserVO> safetyCertUserList = null;
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		try {
			safetyCertUser.setExcel("EXCEL");
			
			log.debug(safetyCertUser.toString());
			
			// total count
			paginationInfo.setTotalRecordCount(safetyCertUserService.safetyCertUserListCnt(safetyCertUser));
			// 목록 조회
			safetyCertUserList = safetyCertUserService.safetyCertUserList(safetyCertUser);
			
			model.put("safetyCertUserList", safetyCertUserList);
			model.put("paginationInfo", paginationInfo);
			model.put("form", safetyCertUser);
			
			bResult = true;
			
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.service.safetycert.safetyCertUserListExcel");
		}
		
		return bResult? getReturnUrl("svc_sft_cert_usr_list_excel") : ERROR_PAGE;
		
	}
	
	@RequestMapping(value = "/safetyCertUserDetail.do")
	@RequestName("safetyCertUserDetail")
	public String safetyCertUserDetail(@ModelAttribute SafetyCertUserVO safetyCertUserVo, ModelMap model, HttpServletRequest request ) throws Exception {
		String bizName = "인증제 상세 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		SafetyCertUserVO resultVo = null;
//		if(safetyCertUserVo.getViewFlg().equals(CRUD_C)) {
//			resultVo = new SafetyCertUserVO();
//		} else {
			resultVo = safetyCertUserService.getSafetyCertUserInfo(safetyCertUserVo);
//		}
		model.addAttribute("safetyCertUser", safetyCertUserVo);
		model.addAttribute("safetyCertUserInfo", resultVo);
		
		return RETURN_URL.concat("/svc_sft_cert_usr_detail");
	}
	
	@SuppressWarnings("unused")
	@RequestMapping(value="/certMbIdCheckAjax.do")
	@RequestName("certMbIdCheckAjax")
	public String certMbIdCheckAjax(@RequestParam(value="usrMpnNo") String usrMpnNo, @RequestParam(value="mbId") String mbId, ModelMap model, HttpServletRequest request ) throws Exception {
		String bizName = "인증제 합격자 ID 체크 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
		boolean isWrongID = true;
		boolean isMember = false;
		try {
			SafetyCertUserVO safetyCertUser = safetyCertUserService.getCertInfoWithMpnNo(usrMpnNo);
			if (safetyCertUser != null) {
				if (StringUtil.isEmpty(safetyCertUser.getMbId()) || !safetyCertUser.getMbId().equals(mbId)) {
					String resultMsg = "전화번호와 ID가 다릅니다.";
				}else {
					isWrongID = false;
					isMember = true;
				}
			}else {
				isWrongID = false;
			}
			model.addAttribute("isWrongID", String.valueOf(isWrongID));
			model.addAttribute("isMember", String.valueOf(isMember));
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		return JSONVIEW;
	}
	
	@RequestMapping(value="/setSafetyCertUserAjax.do")
	@RequestName("setSafetyCertUser")
	public String setSafetyCertUser(@ModelAttribute @Valid SafetyCertUserVO safetyCertUserVo, BindingResult bResult, ModelMap model, HttpServletRequest request ) throws Exception {
		String bizName = "인증제합격자 수정 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		int result = 0;
		//TODO: session에 등록된 관리자 ID로 셋팅.
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
//		String admin = userSessionVO == null ? "test" :userSessionVO.getUsrId();
		String resultMsg = "저장에 성공했습니다.";
		
		try {
			if(bResult.hasErrors()) {
				for(ObjectError e :  bResult.getAllErrors()) {
					resultMsg = e.getDefaultMessage();
				}
			} else {
				boolean isWrongID = true;
				boolean isMember = false;
				SafetyCertUserVO safetyCertUser = safetyCertUserService.getCertInfoWithMpnNo(safetyCertUserVo.getUsrMpnNo());
				if (safetyCertUser != null) {
					if (StringUtil.isEmpty(safetyCertUser.getMbId()) || !safetyCertUser.getMbId().equals(safetyCertUserVo.getMbId())) {
						resultMsg = "전화번호와 ID가 다릅니다.";
					}else {
						isWrongID = false;
						isMember = true;
					}
				}else {
					resultMsg = "회원이 아닙니다.";
					isWrongID = false;
				}
				
				if (!isWrongID && isMember) {
					if (!StringUtil.isEmail(safetyCertUserVo.getMbId())) {	safetyCertUserVo.setMbYn("Y");	}
					result = safetyCertUserService.setSafetyCertUser(safetyCertUserVo);	
				}
			}
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		
		model.addAttribute(RESULTMSG, resultMsg);
		model.addAttribute(CHECK_RESULT, result);
		return JSONVIEW;
	}
	
	@RequestMapping(value="/delSafetyCertUserAjax.do")
	@RequestName("delSafetyCertUser")
	public String delSafetyCertUser(@ModelAttribute @Valid SafetyCertUserVO safetyCertUserVo, BindingResult bResult, ModelMap model, HttpServletRequest request ) throws Exception {
		String bizName = "인증제합격자 삭제 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		int result = 0;
		//TODO: session에 등록된 관리자 ID로 셋팅.
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
//		String admin = userSessionVO == null ? "test" :userSessionVO.getUsrId();
		String resultMsg = "삭제에 실패했습니다.";
		
		try {
			if(bResult.hasErrors()) {
				for(ObjectError e :  bResult.getAllErrors()) {
					resultMsg = e.getDefaultMessage();
				}
			} else {
				result = safetyCertUserService.delSafetyCertUser(safetyCertUserVo);	
				resultMsg= "삭제에 성공했습니다.";
			}
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		
		model.addAttribute(RESULTMSG, resultMsg);
		model.addAttribute(CHECK_RESULT, result);
		return JSONVIEW;
	}
	
	
	@RequestMapping(value="/getSafetyCertPaymentInfoList.do")
	@RequestName(value="getSafetyCertPaymentInfoList")
	public String getSafetyCertPaymentInfoList(@ModelAttribute @Valid MemberPaymentVO memberPaymentVO, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("/sft_cert_payment_list");
		String bizName = "인증제 합격자 세부 내역 ";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
//			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			cal.add(Calendar.DAY_OF_MONTH, -90); //shoh2999 기본 일주일전
			String strDay = sdf.format(cal.getTime());
			
			if(memberPaymentVO.getSearchStartDate() == null){
				memberPaymentVO.setSearchStartDate(strDay);
			}
			if(memberPaymentVO.getSearchEndDate() == null){
				memberPaymentVO.setSearchEndDate(nowDay);
			}
			
			int totCnt = 0;
			int targetMemberNum = 0;
			int totalFee = 0;
			
			totCnt = safetyCertPaymentService.safetyCertPaymentInfoListCnt(memberPaymentVO);
			if (totCnt > 0) {
				targetMemberNum = safetyCertPaymentService.safetyCertPaymentInfoListMemberCnt(memberPaymentVO);
				totalFee = safetyCertPaymentService.safetyCertPaymentInfoListDisAmtSum(memberPaymentVO);
			}
			
			
			PaginationInfo paginationInfo = getPagingInfo(memberPaymentVO.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(memberPaymentVO.getCurrentPageNo(), totCnt);
			
			memberPaymentVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			memberPaymentVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<MemberPaymentVO> resultList = null;
			
			resultList = safetyCertPaymentService.getSafetyCertPaymentInfoList(memberPaymentVO);
			model.addAttribute("searchCondition", memberPaymentVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("targetMemberNum", targetMemberNum);
			model.addAttribute("totalFee", totalFee);
			model.addAttribute("dataList", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.getSafetyCertPaymentInfoList");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/getSafetyCertPaymentInfoListExcel.do")
	@RequestName(value="getSafetyCertPaymentInfoListExcel")
	public String getSafetyCertPaymentInfoListExcel(@ModelAttribute @Valid MemberPaymentVO memberPaymentVO, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("/sft_cert_payment_list_excel");
		String bizName = "인증제 합격자 세부 내역 excel";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
//			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			cal.add(Calendar.DAY_OF_MONTH, -90); //shoh2999 기본 일주일전
			String strDay = sdf.format(cal.getTime());
			
			if(memberPaymentVO.getSearchStartDate() == null){
				memberPaymentVO.setSearchStartDate(strDay);
			}
			if(memberPaymentVO.getSearchEndDate() == null){
				memberPaymentVO.setSearchEndDate(nowDay);
			}
			
			int totCnt = 0;
			int targetMemberNum = 0;
			int totalFee = 0;
			
			totCnt = safetyCertPaymentService.safetyCertPaymentInfoListCnt(memberPaymentVO);
			if (totCnt > 0) {
				targetMemberNum = safetyCertPaymentService.safetyCertPaymentInfoListMemberCnt(memberPaymentVO);
				totalFee = safetyCertPaymentService.safetyCertPaymentInfoListDisAmtSum(memberPaymentVO);
			}
			
			PaginationInfo paginationInfo = getPagingInfo(memberPaymentVO.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(memberPaymentVO.getCurrentPageNo(), totCnt);
			
			memberPaymentVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			memberPaymentVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<MemberPaymentVO> resultList = null;

			resultList = safetyCertPaymentService.getSafetyCertPaymentInfoList(memberPaymentVO);
			model.addAttribute("searchCondition", memberPaymentVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("targetMemberNum", targetMemberNum);
			model.addAttribute("totalFee", totalFee);
			model.addAttribute("dataList", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.getSafetyCertPaymentInfoListExcel");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/getSafetyCertPaymentStatistics.do")
	@RequestName(value="getSafetyCertPaymentStatistics")
	public String getSafetyCertPaymentStatistics(@ModelAttribute @Valid MemberPaymentVO memberPaymentVO, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("/sft_cert_payment_statistics");
		String bizName = "인증제 합격자  연월통계 ";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
//			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			cal.add(Calendar.DAY_OF_MONTH, -90); //shoh2999 기본 일주일전
			String strDay = sdf.format(cal.getTime());
			
			if(memberPaymentVO.getSearchStartDate() == null){
				memberPaymentVO.setSearchStartDate(strDay);
			}
			if(memberPaymentVO.getSearchEndDate() == null){
				memberPaymentVO.setSearchEndDate(nowDay);
			}
			
			
			
			int totCnt = 0;
			int targetMemberNum = 0;
			int totalFee = 0;
			int totalDetailCount =0;
			
			totalDetailCount = safetyCertPaymentService.safetyCertPaymentInfoListCnt(memberPaymentVO);
			totCnt = safetyCertPaymentService.safetyCertPaymentStatisticsCnt(memberPaymentVO);
			if (totCnt > 0) {
				targetMemberNum = safetyCertPaymentService.safetyCertPaymentInfoListMemberCnt(memberPaymentVO);
				totalFee = safetyCertPaymentService.safetyCertPaymentInfoListDisAmtSum(memberPaymentVO);
			}
			
			PaginationInfo paginationInfo = getPagingInfo(memberPaymentVO.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(memberPaymentVO.getCurrentPageNo(), totCnt);
			
			memberPaymentVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			memberPaymentVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<MemberPaymentVO> resultList = null;

			resultList = safetyCertPaymentService.getSafetyCertPaymentStatistics(memberPaymentVO);
			model.addAttribute("searchCondition", memberPaymentVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("targetMemberNum", targetMemberNum);
			model.addAttribute("totalFee", totalFee);
			model.addAttribute("totalDetailCount", totalDetailCount);
			model.addAttribute("dataList", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.getSafetyCertPaymentStatistics");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/getSafetyCertPaymentStatisticsExcel.do")
	@RequestName(value="getSafetyCertPaymentStatisticsExcel")
	public String getSafetyCertPaymentStatisticsExcel(@ModelAttribute @Valid MemberPaymentVO memberPaymentVO, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("/sft_cert_payment_statistics_excel");
		String bizName = "인증제 합격자 연월통계 Excel";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
//			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			cal.add(Calendar.DAY_OF_MONTH, -90); //shoh2999 기본 일주일전
			String strDay = sdf.format(cal.getTime());
			
			if(memberPaymentVO.getSearchStartDate() == null){
				memberPaymentVO.setSearchStartDate(strDay);
			}
			if(memberPaymentVO.getSearchEndDate() == null){
				memberPaymentVO.setSearchEndDate(nowDay);
			}
			
			
			
			int totCnt = 0;
			int targetMemberNum = 0;
			int totalFee = 0;
			int totalDetailCount =0;
			
			totalDetailCount = safetyCertPaymentService.safetyCertPaymentInfoListCnt(memberPaymentVO);
			totCnt = safetyCertPaymentService.safetyCertPaymentStatisticsCnt(memberPaymentVO);
			if (totCnt > 0) {
				targetMemberNum = safetyCertPaymentService.safetyCertPaymentInfoListMemberCnt(memberPaymentVO);
				totalFee = safetyCertPaymentService.safetyCertPaymentInfoListDisAmtSum(memberPaymentVO);
			}
			
			PaginationInfo paginationInfo = getPagingInfo(memberPaymentVO.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(memberPaymentVO.getCurrentPageNo(), totCnt);
			
			memberPaymentVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			memberPaymentVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<MemberPaymentVO> resultList = null;

			resultList = safetyCertPaymentService.getSafetyCertPaymentStatistics(memberPaymentVO);
			model.addAttribute("searchCondition", memberPaymentVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("targetMemberNum", targetMemberNum);
			model.addAttribute("totalFee", totalFee);
			model.addAttribute("totalDetailCount", totalDetailCount);
			model.addAttribute("dataList", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.getSafetyCertPaymentStatisticsExcel");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	/*
	 * SMS 발송 상세정보 
	 */
	@RequestMapping(value="/sendSafetyUserSmsList.do")
	@RequestName("sendSafetyUserSmsList")
	public String sendSafetyUserSmsList(@ModelAttribute MemberMgmtVO memberVo, BindingResult bResult, ModelMap model, HttpServletRequest request){
		boolean result = false;
    	String targetUrl = "/admin/service/safetycert/sys_sft_usr_sms_send_list";
    	String bizName = "인증제 합격자 sms 발송내역";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        List<MemberMgmtVO> memberMgmtVO = null;
        
        Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		if(memberVo.getSearchStartDate() == null && memberVo.getSearchEndDate() == null){
			memberVo.setSearchEndDate(sdf.format(cal.getTime()));
			memberVo.setSearchStartDate(sdf.format(cal.getTime()));
		}
		
        if(!bResult.hasErrors()) {
        	memberVo.setTotalRecordCount(safetyCertService.smsSendListCnt(memberVo));
	
	        PaginationInfo paginationInfo = getPagingInfo(memberVo.getCurrentPageNo(), memberVo.getTotalRecordCount());
	        PaginationInfo paginationMobileInfo = getPagingMobileInfo(memberVo.getCurrentPageNo(), memberVo.getTotalRecordCount());
	        memberVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
	        memberVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	        
	        memberMgmtVO = safetyCertService.smsSendList(memberVo);
	        model.addAttribute("searchParam", memberVo);
	        model.addAttribute("smsList", memberMgmtVO);
	        model.addAttribute("paginationInfo", paginationInfo);
	        model.addAttribute("paginationMobileInfo", paginationMobileInfo);
	        
	        result = true;
        }
        
        return result ? targetUrl : ERROR_PAGE;
	}
	
}