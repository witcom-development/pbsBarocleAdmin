/*
 * @Package Name : com.dkitec.barocle.admin.status.stationStaus.service.Impl
 * @파일명          : StationStatusServiceImpl.java
 * @작성일          : 2015. 5. 18.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 18.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.status.stationStatus.service.Impl;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.arm.vo.ArmVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO;
import com.dkitec.barocle.admin.status.rentStatus.service.RentStatusMapper;
import com.dkitec.barocle.admin.status.stationStatus.service.StationStatusMapper;
import com.dkitec.barocle.admin.status.stationStatus.service.StationStatusService;
import com.dkitec.barocle.admin.status.stationStatus.vo.StationStatusVO;
import com.dkitec.barocle.admin.status.stationStatus.vo.StationVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @파일명          : StationStatusServiceImpl.java
 * @작성일          : 2015. 5. 18.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 18.   |   ymshin   |  최초작성
 */
@Service(value="stationStatusService")
public class StationStatusServiceImpl extends EgovAbstractServiceImpl implements StationStatusService {

	@Autowired private StationStatusMapper stationStatusMapper;
	@Resource(name = "propertiesService") private EgovPropertyService propertiesService;

	@Autowired private RentStatusMapper rentStatusMapper;
	
	
	/**
	 * @location   : com.dkitec.barocle.admin.status.stationStaus.service.Impl.StationStatusService.getStationStatusTotCnt
	 * @writeDay   : 2015. 5. 18. 오후 9:30:36
	 * @overridden : @see com.dkitec.barocle.admin.status.stationStaus.service.StationStatusService#getStationStatusTotCnt()
	 * @Todo       : 
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public StationStatusVO getStationStatusTotCnt(String langKr) {
		// TODO Auto-generated method stub
		return stationStatusMapper.getStationStatusTotCnt(langKr);
	}

	/**
	 * @location : com.dkitec.barocle.admin.status.stationStaus.service.StationStatusService.getStationStautsList
	 * @writeDay : 2015. 5. 19. 오전 10:07:13
	 * @return   : List<StationStatusVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 19.   |   ymshin   |  최초작성
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<StationVO> getStationStautsListNew(StationVO mapVo) {
		return stationStatusMapper.getStationStautsListNew(mapVo);
	}	
	
	/**
	 * @location   : com.dkitec.barocle.admin.status.stationStaus.service.Impl.StationStatusService.getBrokenDeviceTotCnt
	 * @writeDay   : 2015. 5. 18. 오후 9:30:36
	 * @overridden : @see com.dkitec.barocle.admin.status.stationStaus.service.StationStatusService#getBrokenDeviceTotCnt()
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public StationStatusVO getBrokenDeviceTotCnt() {
		// TODO Auto-generated method stub
		return stationStatusMapper.getBrokenDeviceTotCnt();
	}

	/**
	 * @location   : com.dkitec.barocle.admin.status.stationStaus.service.Impl.StationStatusService.geBikeStatusTotCnt
	 * @writeDay   : 2015. 5. 18. 오후 9:30:36
	 * @overridden : @see com.dkitec.barocle.admin.status.stationStaus.service.StationStatusService#geBikeStatusTotCnt()
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public StationStatusVO geBikeStatusTotCnt() {
		// TODO Auto-generated method stub
		return stationStatusMapper.geBikeStatusTotCnt();
	}

	/**
	 * @location   : com.dkitec.barocle.admin.status.stationStaus.service.Impl.StationStatusService.getRentStatusTotCnt
	 * @writeDay   : 2015. 5. 18. 오후 9:30:36
	 * @overridden : @see com.dkitec.barocle.admin.status.stationStaus.service.StationStatusService#getRentStatusTotCnt()
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public StationStatusVO getRentStatusTotCnt() {
		// TODO Auto-generated method stub
		return stationStatusMapper.getRentStatusTotCnt();
	}

	/**
	 * @location   : com.dkitec.barocle.admin.status.stationStaus.service.Impl.StationStatusService.getStationStautsList
	 * @writeDay   : 2015. 5. 19. 오전 10:07:22
	 * @overridden : @see com.dkitec.barocle.admin.status.stationStaus.service.StationStatusService#getStationStautsList(com.dkitec.barocle.admin.status.stationStaus.vo.StationStatusVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<StationStatusVO> getStationStautsList(StationStatusVO mapVo) {
		
		List<StationStatusVO> mapList = stationStatusMapper.getStationStautsList(mapVo);
		HashMap<String, String> map = null;
		for(StationStatusVO list : mapList) {
			if(list.getStationImgFileName() != null && !list.getStationImgFileName().equals("")) {
				map = new HashMap<String, String>();
				map.put("FILE_NAME", list.getStationImgFileName());
				map.put("STATION_ID", list.getStationId());
				list.setStationImgFileName(getFileSaveFile(map));
			}
		}
		
		return mapList;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.status.stationStatus.service.Impl.StationStatusService.getCurrentStationDetail
	 * @writeDay   : 2015. 5. 19. 오후 3:54:37
	 * @overridden : @see com.dkitec.barocle.admin.status.stationStatus.service.StationStatusService#getCurrentStationDetail(com.dkitec.barocle.admin.status.stationStatus.vo.StationStatusVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public StationStatusVO getCurrentStationDetail(StationStatusVO mapVo) {
		// TODO Auto-generated method stub
		return stationStatusMapper.getCurrentStationDetail(mapVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.status.stationStatus.service.Impl.StationStatusService.getStationApList
	 * @writeDay   : 2015. 5. 19. 오후 4:32:49
	 * @overridden : @see com.dkitec.barocle.admin.status.stationStatus.service.StationStatusService#getStationApList(java.lang.String)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public ApVO getStationApList(StationStatusVO mapVo) {
		// TODO Auto-generated method stub
		return stationStatusMapper.getStationApList(mapVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.status.stationStatus.service.Impl.StationStatusService.getStationBikeList
	 * @writeDay   : 2015. 5. 19. 오후 4:32:49
	 * @overridden : @see com.dkitec.barocle.admin.status.stationStatus.service.StationStatusService#getStationBikeList(java.lang.String)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<BikeVO> getStationBikeList(StationStatusVO mapVo) {
		// TODO Auto-generated method stub
		return stationStatusMapper.getStationBikeList(mapVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.status.stationStatus.service.Impl.StationStatusService.getStationArmList
	 * @writeDay   : 2015. 5. 19. 오후 4:32:49
	 * @overridden : @see com.dkitec.barocle.admin.status.stationStatus.service.StationStatusService#getStationArmList(java.lang.String)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<ArmVO> getStationArmList(StationStatusVO mapVo) {
		// TODO Auto-generated method stub
		return stationStatusMapper.getStationArmList(mapVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.status.stationStatus.service.Impl.StationStatusService.getStationRackTotInfo
	 * @writeDay   : 2015. 5. 19. 오후 6:10:02
	 * @overridden : @see com.dkitec.barocle.admin.status.stationStatus.service.StationStatusService#getStationRackTotInfo(com.dkitec.barocle.admin.status.stationStatus.vo.StationStatusVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public ArmVO getStationRackTotInfo(StationStatusVO mapVo) {
		// TODO Auto-generated method stub
		return stationStatusMapper.getStationRackTotInfo(mapVo);
	}

	private String getFileSaveFile(HashMap<String, String> pMap){
		//파일 업로드 경로 prefix
		String fileString = "";
		
		if(pMap.get("FILE_NAME") !=null && !pMap.get("FILE_NAME").equals("")){
			String prefix = System.getProperty("os.name").toLowerCase().indexOf("win") >= 0 ? "d:/" : "";
			
			String filePath = prefix+ propertiesService.getString("stationUploadDir") + 
					File.separator + pMap.get("STATION_ID") +File.separator + pMap.get("FILE_NAME");
			
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

	/**
	 * @location   : com.dkitec.barocle.admin.status.stationStatus.service.Impl.StationStatusService.getStationListCount
	 * @writeDay   : 2015. 8. 24. 오후 3:21:45
	 * @overridden : @see com.dkitec.barocle.admin.status.stationStatus.service.StationStatusService#getStationListCount(com.dkitec.barocle.admin.status.stationStatus.vo.StationStatusVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getStationListCount(StationStatusVO mapVo) {
		// TODO Auto-generated method stub
		return stationStatusMapper.getStationListCount(mapVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public StationStatusVO getRealStation(StationStatusVO statusVo) {
		// TODO Auto-generated method stub
		return stationStatusMapper.getRealStation(statusVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<StationStatusVO> getRealStationList(StationStatusVO statusVo) {
		// TODO Auto-generated method stub
		return stationStatusMapper.getRealStationList(statusVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<StationStatusVO> getRealStationList2(StationStatusVO statusVo) {
		// TODO Auto-generated method stub
		return stationStatusMapper.getRealStationList2(statusVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<StationStatusVO> getRealStationList3(StationStatusVO statusVo) {
		// TODO Auto-generated method stub
		return stationStatusMapper.getRealStationList3(statusVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<StationStatusVO> getRealBikeList(StationStatusVO statusVo) {
		// TODO Auto-generated method stub
		return stationStatusMapper.getRealBikeList(statusVo);
	}

	@Override
	public List<StationStatusVO> getNoticeList(StationStatusVO statusVo) {
		// TODO Auto-generated method stub
		return stationStatusMapper.getNoticeList(statusVo);
	}
 	
	@Override
	@Transactional(readOnly=false, propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int exeRentBookingCancelProc(ArmVO armVo) {
        int result = 0;
        armVo.setRackStatusCd("RAS_003");
     	
        result = stationStatusMapper.exeRentBookingCancelProc(armVo);
        result = stationStatusMapper.setCancelUsr(armVo);
        
        
		return result;
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<StationStatusVO> getStationNameList(StationStatusVO statusVo) {
		
		List<StationStatusVO> mapList = stationStatusMapper.getStationNameList(statusVo);
		
		
		return mapList;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)	
	public List<StationStatusVO> getBikeBatLowStationList(StationStatusVO statusVo) {
		// TODO Auto-generated method stub
		return stationStatusMapper.getBikeBatLowStationList(statusVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)	
	public List<StationVO> getStationStautsListRound(StationVO stationVo) {
		// TODO Auto-generated method stub
		return stationStatusMapper.getStationStautsListRound(stationVo);
	}
}
