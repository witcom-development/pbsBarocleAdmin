package com.dkitec.barocle.admin.manage.stationmgmt.service.impl;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.codec.binary.Base64;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApMapper;
import com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService;
import com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmMapper;
import com.dkitec.barocle.admin.manage.deviceMgmt.arm.vo.ArmVO;
import com.dkitec.barocle.admin.manage.stationgroup.vo.StationGroupMgmtVO;
import com.dkitec.barocle.admin.manage.stationmgmt.service.StationMgmtMapper;
import com.dkitec.barocle.admin.manage.stationmgmt.service.StationMgmtService;
import com.dkitec.barocle.admin.manage.stationmgmt.vo.StationMgmtVO;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.barocle.util.sms.vo.SmsMessageVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("stationMgmtService")
public class StationMgmtServiceImpl extends EgovAbstractServiceImpl implements StationMgmtService{

	@Autowired
	StationMgmtMapper mapper;
	
	@Autowired private ApMapper apMapper;
	
	@Autowired private ArmMapper armMapper;
	
	@Resource(name = "propertiesService") private EgovPropertyService propertiesService;
	
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getStationListCnt(StationMgmtVO stationVo) {
		return mapper.getStationListCnt(stationVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getStationGrpRemoteReturnListCnt(StationMgmtVO stationVo) {
		return mapper.getStationGrpRemoteReturnListCnt(stationVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<StationMgmtVO> getStationList(StationMgmtVO stationVo) {
		return mapper.getStationList(stationVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<StationMgmtVO> getStationGrpRemoteReturnList(StationMgmtVO stationVo) {
		return mapper.getStationGrpRemoteReturnList(stationVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<StationMgmtVO> getStationGrpRemoteReturnList1(StationMgmtVO stationVo) {
		return mapper.getStationGrpRemoteReturnList1(stationVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public StationMgmtVO getStationInfo(StationGroupMgmtVO stationVo) {
		StationMgmtVO vo = new StationMgmtVO();
		vo.setStation_id(stationVo.getStation_id());
		
		StationMgmtVO result = mapper.getStationInfo(vo); 
		
		if(result != null){
			result.setRockCnt(mapper.getStationRockCnt(vo));
			result.setDevice_id(mapper.getStationDeviceID(vo));
		}
		
		logger.debug(result);
		
		return result;
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public StationMgmtVO getStationGrpRemoteReturnInfo(StationGroupMgmtVO stationVo) {
		StationMgmtVO vo = new StationMgmtVO();
//		vo.setStation_id(stationVo.getStation_id());
		vo.setStation_grp_seq(stationVo.getStation_grp_seq());
		
		StationMgmtVO result = mapper.getStationGrpRemoteReturnInfo(vo); 
		
//		if(result != null){
//			result.setRockCnt(mapper.getStationRockCnt(vo));
//			result.setDevice_id(mapper.getStationDeviceID(vo));
//		}
		
		logger.debug(result);
		
		return result;
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public StationMgmtVO getStationGrpRemoteReturnInfo1(StationMgmtVO stationVo) {
		StationMgmtVO result = mapper.getStationGrpRemoteReturnInfo(stationVo);
		logger.debug(result);
		return result;
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<StationMgmtVO> getStationNameInfo(StationGroupMgmtVO stationVo) {
		StationMgmtVO vo = new StationMgmtVO();
		vo.setStation_id(stationVo.getStation_id());
		return mapper.getStationNameInfo(vo);
	}
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	@DataSource(DataSourceType.MASTER)
	public void stationGroupModify(StationMgmtVO stationVo, ApService apService) {
	//public void stationGroupModify(StationMgmtVO stationVo) {
		
		if(stationVo.getCmd().equals("INSERT")){
			
			try {
				// 대여소 등록 station_no 를 이용하여 station_id 생성 
				int stationNum = mapper.getStationNo(stationVo);
				stationVo.setStation_id("ST-" + stationNum);
				
				mapper.insertStation(stationVo);
				
				for(int i=0; i < stationVo.getCodeList().size(); i++){
					
					stationVo.setLang_cls_cd(stationVo.getCodeList().get(i)); 
					stationVo.setStation_name(stationVo.getNameList().get(i));
					mapper.insertStationName(stationVo);
				}
				
				// 신규 정거장에는 거치대 정보를 넣어준다. 2020-01-13
				// 정거장 구분없이 거치대 정보를 넣어줌 2020-02-04
				mapper.insertNewStationRack1(stationVo);
//				mapper.insertNewStationRack2(stationVo);
				 
				// 2021 01 19 locate_info 등록
				mapper.insertTB_OPR_RACK_LOCATE_INFO(stationVo);
				
			} catch (Exception e) {
				e.printStackTrace();
				throw new CfoodException("admin.manage.station.stationGroupModify");
			}
			
		}else if(stationVo.getCmd().equals("UPDATE")){
			
			try {
				
				mapper.updateStation(stationVo);
				if(stationVo.getHistYn().equals("Y")){
					mapper.insertStationHist(stationVo);
				}
				if (stationVo.getCodeList() != null ){
				for(int i=0; i < stationVo.getCodeList().size(); i++){
					
					stationVo.setLang_cls_cd(stationVo.getCodeList().get(i)); 
					stationVo.setStation_name(stationVo.getNameList().get(i));
					mapper.updateStationName(stationVo);
				}}
				 
			} catch (Exception e) {
				e.printStackTrace();
				throw new CfoodException("admin.manage.station.stationGroupModify");
			}
			
		}else if(stationVo.getCmd().equals("DELETE")){
			
			try {
				String ap = mapper.getStationDeviceID(stationVo);
				if(ap != null){
					ApVO apVo = new ApVO();
					apVo.setDeviceId(ap);
					apVo.setAdminId("TESTER");
					apVo.setLocateClsCd("C");
					apVo.setLocateId(mapper.getCenterId());
					mapper.updateApHist(apVo);
					apMapper.addApLocateHist(apVo);
				}
				
				mapper.deleteStation(stationVo);
				mapper.deleteStationName(stationVo);
				
			} catch (Exception e) {
				e.printStackTrace();
				throw new CfoodException("admin.manage.station.stationGroupModify");
			}
			
		}
		//STATION VER 동록
		try {
			
			mapper.updateStationVersion(stationVo);
			mapper.insertStationVersion(stationVo);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new CfoodException("admin.manage.station.stationGroupModify");
		}
		
	}
	
	

	@Override
	@Transactional(rollbackFor = Exception.class)
	@DataSource(DataSourceType.MASTER)
	public void stationGrpRemoteReturnGroupModify(StationMgmtVO stationVo) {
	//public void stationGroupModify(StationMgmtVO stationVo) {
		System.out.println("getCmd("+stationVo.getCmd()+")");
		if("INSERT".equals(stationVo.getCmd())){
			
			try {
				mapper.insertStationGrpRemoteReturn(stationVo);
				
			} catch (Exception e) {
				e.printStackTrace();
				throw new CfoodException("admin.manage.station.stationGrpRemoteReturnGroupModify");
			}
			
		}else if("UPDATE".equals(stationVo.getCmd())){
			try {
				mapper.updateStationGrpRemoteReturn(stationVo);
				 
			} catch (Exception e) {
				e.printStackTrace();
				throw new CfoodException("admin.manage.station.stationGrpRemoteReturnGroupModify");
			}
			
		}else if("DELETE".equals(stationVo.getCmd())){
			
			try {
				mapper.deleteStationGrpRemoteReturn(stationVo);
				
			} catch (Exception e) {
				e.printStackTrace();
				throw new CfoodException("admin.manage.station.stationGrpRemoteReturnGroupModify");
			}
			
		}
		
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	@DataSource(DataSourceType.MASTER)
	public void insertStationGrpRemoteReturnInfo(StationMgmtVO stationVo) {
		try {
			if(!stationVo.equals("") || stationVo != null){
				for(int i=0; i < stationVo.getStation_grp_seq_list().length; i++){
//					stationVo.setRemote_return_seq(stationVo.getRemote_return_seq_list().get(i));
					
					int stationGrpRemoteReturnNum = mapper.getStationGrpRemoteReturnNo(stationVo);
					String remote_return_seq = Integer.toString(stationGrpRemoteReturnNum);
					stationVo.setRemote_return_seq(remote_return_seq);
					stationVo.setStation_grp_seq(stationVo.getStation_grp_seq_list()[i]);
					stationVo.setRemote_station_name(stationVo.getRemote_station_name_list()[i]);
					stationVo.setRemote_latitude(stationVo.getRemote_latitude_list()[i]);
					stationVo.setRemote_logitude(stationVo.getRemote_logitude_list()[i]);
					stationVo.setRemote_use_yn(stationVo.getRemote_use_yn_list()[i]);
					stationVo.setReg_id(stationVo.getUser());
					stationVo.setMod_id(stationVo.getUser());
//					mapper.insertStationGrpRemoteReturnName(stationVo);
					mapper.insertStationGrpRemoteReturn(stationVo);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new CfoodException("admin.manage.station.insertStationGrpRemoteReturnInfo");
		}
	}
	
	@Override
	public void updateStationGrpRemoteReturnInfo(StationMgmtVO stationVo) {
		// TODO Auto-generated method stub
//		mapper.updateStationGrpRemoteReturnInfo(stationVo);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public void stationGroupModify05(StationMgmtVO stationVo) {
		if(stationVo.getCmd().equals("UPDATE")){
			
			try {
				mapper.updateStation05(stationVo);
				
				if(stationVo.getHistYn().equals("Y")){
					mapper.insertStationHist(stationVo);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				throw new CfoodException("admin.manage.station.stationGroupModify");
			}
		}
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public String stationNumberCheck(StationMgmtVO stationVo) {
		
		logger.debug(stationVo);

		if(stationVo.getStation_no()!=null && !stationVo.getStation_no().equals("")){
			if( mapper.stationNumberCheck(stationVo) > 0 ){
				return "중복";
			}
		}
		
		if(stationVo.getStation_name()!= null && !stationVo.getStation_name().equals("")){
			if( mapper.stationDuplNameCheck(stationVo) > 0 ){
				return "중복";
			}
		}
		
		return IConstants.OK;
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public String remoteStationNumberCheck(StationMgmtVO stationVo) {
		
		logger.debug(stationVo);
		
		if(stationVo.getStation_name()!= null && !stationVo.getStation_name().equals("")){
			if( mapper.remoteStationDuplNameCheck(stationVo) > 0 ){
				return "중복";
			}
		}
		
		return IConstants.OK;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<StationMgmtVO> getGroupStationList(StationMgmtVO vo) {
		return mapper.getGroupStationList(vo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<ApVO> getApList() {
		return mapper.getApList();
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<StationMgmtVO> groupStationList(StationMgmtVO stationVo) {
		return mapper.groupStationList(stationVo);
	}

	private void insertPhysicalSaveFile(StationMgmtVO stationMgmtVO) throws IOException {
				//파일 업로드 경로 prefix
		if(stationMgmtVO.getStation_img_file_name() !=null && !stationMgmtVO.getStation_img_file_name().equals("")){
			MultipartFile file = stationMgmtVO.getStaImgFile();
		
			String prefix = System.getProperty("os.name").toLowerCase().indexOf("win") >= 0 ? "d:/" : "";
			
			String savePath = prefix+ propertiesService.getString("stationUploadDir") + 
					File.separator + stationMgmtVO.getStation_id()  ;
			
			File fileSavePath = new File(savePath);
			
			if(!fileSavePath.exists())
				fileSavePath.mkdirs();
			
			File f = new File(fileSavePath.getAbsolutePath()  + File.separator + stationMgmtVO.getStation_img_file_name());
			
			FileOutputStream fos = new FileOutputStream(f);
			
			fos.write(file.getBytes());
			fos.close();
		}
	}
	
	private String getFileSaveFile(StationMgmtVO stationMgmtVO){
			//파일 업로드 경로 prefix
		String fileString = new String();
		
		if(stationMgmtVO.getStation_img_file_name() !=null && !stationMgmtVO.getStation_img_file_name().equals("")){
			String prefix = System.getProperty("os.name").toLowerCase().indexOf("win") >= 0 ? "d:/" : "";
			
			String filePath = prefix+ propertiesService.getString("stationUploadDir") + 
					File.separator + stationMgmtVO.getStation_id() +File.separator + stationMgmtVO.getStation_img_file_name()  ;
			
			File getFile = new File(filePath);
			
			if(getFile.exists()){
				FileInputStream inputStream =  null;
			    ByteArrayOutputStream byteOutStream = null;
	
			    try {
			        inputStream = new FileInputStream(getFile);
			        byteOutStream = new ByteArrayOutputStream();
			    
					int len = 0;
					byte[] buf = new byte[1024];
			        while ((len = inputStream.read(buf)) != -1) {
			             byteOutStream.write(buf, 0, len);
			        }
	
			        byte[] fileArray = byteOutStream.toByteArray();
			        fileString = new String(Base64.encodeBase64(fileArray));
			        
			    } catch (IOException e) {
			        e.printStackTrace();
			    } finally {
			    	try {
						inputStream.close();
					} catch (IOException e) {
					}
			        try {
						byteOutStream.close();
					} catch (IOException e) {
					}
			    }
			}	
		}
		return fileString;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getStationUseListCnt(StationMgmtVO vo) {
		
		return mapper.getStationUseListCnt(vo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<StationMgmtVO> getStationUseList(StationMgmtVO vo) {
		
		return mapper.getStationUseList(vo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public String beaconCheck(StationMgmtVO stationVo) {
		
		logger.debug(stationVo);

		if(stationVo.getStation_no()!=null && !stationVo.getStation_no().equals("")){
			if( mapper.stationNumberCheck(stationVo) > 0 ){
				return "중복";
			}
		}
		
		if(stationVo.getStation_name()!= null && !stationVo.getStation_name().equals("")){
			if( mapper.stationDuplNameCheck(stationVo) > 0 ){
				return "중복";
			}
		}
		
		return IConstants.OK;
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int addTmpCloseSmsHist(StationMgmtVO stationVo) {
		// TODO Auto-generated method stub
		return mapper.addTmpCloseSmsHist(stationVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public void addTmpCloseSms(SmsMessageVO smsMsgVo) {
		// TODO Auto-generated method stub
		
		mapper.addTmpCloseSms(smsMsgVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public void addTmpCloseSmsDtl(SmsMessageVO smsMsgVo) {
		// TODO Auto-generated method stub
		
		mapper.addTmpCloseSmsDtl(smsMsgVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public void deleteTmpCloseSms(SmsMessageVO smsMsgVo) {
		// TODO Auto-generated method stub
		
		mapper.deleteTmpCloseSms(smsMsgVo);
	}

	@Override
	@DataSource(DataSourceType.MASTER)
	public void addTmpCloseNoti(StationMgmtVO stationVo) {
		// TODO Auto-generated method stub
		mapper.addTmpCloseNoti(stationVo);
		
		System.out.println( stationVo.toString() );
		
	}
	
	@Override
	@DataSource(DataSourceType.MASTER)
	public void editTmpCloseNoti(StationMgmtVO stationVo) {
		// TODO Auto-generated method stub
		mapper.editTmpCloseNoti(stationVo);
		
	}
	
	@Override
	@DataSource(DataSourceType.MASTER)
	public void NoTmpCloseNoti(StationMgmtVO stationVo) {
		// TODO Auto-generated method stub
		mapper.NoTmpCloseNoti(stationVo);
		
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<SmsMessageVO> getUsrList(StationMgmtVO stationVo){
		// TODO Auto-generated method stub
		return mapper.getUsrList(stationVo);
	}

	@Override
	@DataSource(DataSourceType.MASTER)
	public void insertTmpCloseSmsAdm(StationMgmtVO stationVo) {
		// TODO Auto-generated method stub
		mapper.insertTmpCloseSmsAdm(stationVo);
		
	}

	@Override
	public void updateStation05(StationMgmtVO stationVo) {
		// TODO Auto-generated method stub
		mapper.updateStation05(stationVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getStationNotiCnt(StationMgmtVO stationVo) {
		return mapper.getStationNotiCnt(stationVo);
	}
	
	@Override
	@DataSource(DataSourceType.MASTER)
	public void insertTbOprStationNoti(StationMgmtVO stationVo) {
		// TODO Auto-generated method stub
		mapper.insertTbOprStationNoti(stationVo);
		
	}
	
	@Override
	@DataSource(DataSourceType.MASTER)
	public void deleteTbOprStationNoti(StationMgmtVO stationVo) {
		// TODO Auto-generated method stub
		mapper.deleteTbOprStationNoti(stationVo);
		
	}
	
	@Override
	@DataSource(DataSourceType.MASTER)
	public void insertTB_OPR_RACK_LOCATE_INFO(StationMgmtVO stationVo) {
		// TODO Auto-generated method stub
		mapper.insertTB_OPR_RACK_LOCATE_INFO(stationVo);
		
	}
	
	
	
}