/*
 * @Package Name : com.dkitec.barocle.admin.manage.deviceMgmt.common.service.serviceImpl
 * @파일명          : CommonPopupServiceImpl.java
 * @작성일          : 2015. 4. 24.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 24.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.common.service.serviceImpl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.common.service.CommonPopupMapper;
import com.dkitec.barocle.admin.common.service.CommonPopupService;
import com.dkitec.barocle.admin.common.vo.FindOutDeviceVO;
import com.dkitec.barocle.admin.common.vo.RegularChkVO;
import com.dkitec.barocle.admin.common.vo.SmsSendVo;
import com.dkitec.barocle.admin.common.vo.TroubleReportVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeMapper;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO;
import com.dkitec.barocle.admin.service.paymentmgmt.mileage.vo.MileageVO;
import com.dkitec.barocle.admin.status.rentHistory.vo.PenaltyVO;
import com.dkitec.barocle.admin.status.rentStatus.service.RentStatusMapper;
import com.dkitec.barocle.admin.status.rentStatus.vo.BikeRentalVO;
import com.dkitec.barocle.admin.system.teammgmt.vo.TeamMgmtVO;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @파일명          : CommonPopupServiceImpl.java
 * @작성일          : 2015. 4. 24.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 24.   |   ymshin   |  최초작성
 */
@Service("commonPopupService")
public class CommonPopupServiceImpl extends EgovAbstractServiceImpl implements CommonPopupService {

	@Autowired private CommonPopupMapper commonPopupMapper;
	@Autowired private BikeMapper bikeMapper;
	@Autowired private RentStatusMapper rentStatusMapper;
	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.common.service.serviceImpl.CommonPopupService.addRegularCheckUpDevice
	 * @writeDay   : 2015. 4. 24. 오후 2:13:21
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.common.service.CommonPopupService#addRegularCheckUpDevice(com.dkitec.barocle.admin.manage.deviceMgmt.common.vo.RegularChkVO)
	 * @Todo       : 정기점검 등록처리 팝업 공통 서비스.
	 *             1) deviceType에 따라 장치 테이블에 최종 점검일자를 갱신
	 *             2) 정기 점검 정보 테이블에 등록.
	 */ 
	@Override
	@Transactional(readOnly=false,propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int addRegularCheckUpDevice(RegularChkVO rVo) {
		
		int result = 0;
		if(rVo.getEquipmentClsCd().equalsIgnoreCase(IConstants.DEVICE_AP)) {
			result =  commonPopupMapper.setApLastChkDttm(rVo);
		} else if(rVo.getEquipmentClsCd().equalsIgnoreCase(IConstants.DEVICE_ARM)) {
			result =  commonPopupMapper.setArmLastChkDttm(rVo);
		} else if(rVo.getEquipmentClsCd().equalsIgnoreCase(IConstants.DEVICE_BIKE)) {
			result =  commonPopupMapper.setBikeLastChkDttm(rVo);
		} else {
			result =  commonPopupMapper.setTerminalLastChkDttm(rVo);
		}
		/**TODO:점검 테이블에 입력처리*/ 
		result = commonPopupMapper.addRegularChkUpInfo(rVo);
		if(rVo.getMode().equals("M")){
			result = commonPopupMapper.updateFaultType(rVo);
		}
		
		return result;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.common.service.serviceImpl.CommonPopupService.getFindOutDevice
	 * @writeDay   : 2015. 4. 24. 오후 2:16:29
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.common.service.CommonPopupService#getFindOutDevice(com.dkitec.barocle.admin.manage.deviceMgmt.common.vo.FindOutDeviceVO)
	 * @Todo       :장치찿기 공통팝업 서비스
	 * 
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<FindOutDeviceVO> getFindOutDevice(FindOutDeviceVO foVo) {
		
		List<FindOutDeviceVO> resultList = null;
		if(foVo.getDeviceType().equalsIgnoreCase(IConstants.DEVICE_AP)) {
			
			resultList =  commonPopupMapper.getApDeviceInfo(foVo);
		} else if(foVo.getDeviceType().equalsIgnoreCase(IConstants.DEVICE_ARM)) {
			
			resultList =  commonPopupMapper.getArmDeviceInfo(foVo);
		} else if(foVo.getDeviceType().equalsIgnoreCase(IConstants.DEVICE_BIKE)) {
			
			resultList =  commonPopupMapper.getBikeDeviceInfo(foVo);
		} else {
			
			resultList =  commonPopupMapper.getTerminalDeviceInfo(foVo);
		}
		
		return resultList;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.common.service.serviceImpl.CommonPopupService.getBeforeChkInfo
	 * @writeDay   : 2015. 4. 27. 오전 11:42:23
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.common.service.CommonPopupService#getBeforeChkInfo(com.dkitec.barocle.admin.manage.deviceMgmt.common.vo.RegularChkVO)
	 * @Todo       : 해당기기의 기존 정기점검  
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public RegularChkVO getBeforeChkInfo(RegularChkVO rVo) {
		// TODO Auto-generated method stub
		return commonPopupMapper.getBeforeChkInfo(rVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.serviceImpl.BikeService.setBikeMissingCondition
	 * @writeDay   : 2015. 4. 23. 오후 1:29:45
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService#setBikeMissingCondition(com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO)
	 * @Todo       :대여현황에서 대여테이블 삭제,대여이력으로 등록,주차 테이블 삭제.
	 */ 
	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor = {Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int setBikeMissingCondition(BikeVO bikeVo) {
		int result = -1;
		//자전거 상태 변경 
		if(bikeVo.getChkType().equals("I")) {
			boolean isParking = Boolean.valueOf(bikeMapper.isBikeParking(bikeVo));
		    if(isParking) {
		    	result = bikeMapper.delBikeParking(bikeVo);
		    }
		    //단말기 이력 변경(분실로 처리)
		    result = bikeMapper.setMissingTerminal(bikeVo);
		    //장애 테이블에 있을경우 현황 -> 이력으로 
		    result = bikeMapper.setMissingMtcFaultStatus(bikeVo);
		} else {
			//자전거 배치 상태를 센터로
			bikeVo.setLocateClsCd("C");
			bikeVo.setLocateId(bikeVo.getCenterId());
			result = bikeMapper.setBikeHistoryInfo(bikeVo);
			result = bikeMapper.addBikeLocateHist(bikeVo);
		}
		result = bikeMapper.setBikeDevice(bikeVo);
		return result;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.common.service.serviceImpl.CommonPopupService.getBikeHistoryInfo
	 * @writeDay   : 2015. 5. 14. 오후 8:19:04
	 * @overridden : @see com.dkitec.barocle.admin.common.service.CommonPopupService#getBikeHistoryInfo(com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<BikeRentalVO> getBikeHistoryInfo(BikeVO bikeVo) {
		// TODO Auto-generated method stub
		return  bikeMapper.getBikeHistoryInfo(bikeVo);
	}
	/**
	 * @location   : com.dkitec.barocle.admin.common.service.serviceImpl.CommonPopupService.getPenaltyDetailInfo
	 * @writeDay   : 2015. 5. 14. 오후 8:19:04
	 * @overridden : @see com.dkitec.barocle.admin.common.service.CommonPopupService#getBikeHistoryInfo(com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO)
	 * @Todo       : 벌점 상세내역 취득 .
	 */
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public PenaltyVO getPenaltyDetailInfo(PenaltyVO penaltyVo) {
		// TODO Auto-generated method stub
		return commonPopupMapper.getPenaltyDetailInfo(penaltyVo);
	}

	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int addRentPenaltyImpose(PenaltyVO penaltyVo) {
		// TODO Auto-generated method stub
		return commonPopupMapper.addRentPenaltyImpose(penaltyVo);
	}

	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int delRentPenaltyImpose(PenaltyVO penaltyVo) {
		// TODO Auto-generated method stub
		return commonPopupMapper.delRentPenaltyImpose(penaltyVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.common.service.serviceImpl.CommonPopupService.getSmsMessageList
	 * @writeDay   : 2015. 5. 18. 오전 10:06:14
	 * @overridden : @see com.dkitec.barocle.admin.common.service.CommonPopupService#getSmsMessageList()
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<SmsSendVo> getSmsMessageList() {
		// TODO Auto-generated method stub
		return commonPopupMapper.getSmsMessageList();
	}

	/**
	 * @location   : com.dkitec.barocle.admin.common.service.serviceImpl.CommonPopupService.setBikeMissingRentStatus
	 * @writeDay   : 2015. 5. 27. 오후 1:44:47
	 * @overridden : @see com.dkitec.barocle.admin.common.service.CommonPopupService#setBikeMissingRentStatus(com.dkitec.barocle.admin.status.rentStatus.vo.BikeRentalVO)
	 * @Todo       :1)대여 테이블에서 삭제 대여 이력에 등록 자전거 단말기 상태 변경.(BKS_007,DES_004)
	 */ 
	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int setBikeMissingRentStatus(BikeRentalVO current) {
		int result =0;
		
		result = rentStatusMapper.delCurrnetRentData(current);
		result = rentStatusMapper.addRentHistory(current);
		
		return result;
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public TroubleReportVO getTroubleReportInfo(TroubleReportVO troubleReportVo) {
		// TODO Auto-generated method stub
		return commonPopupMapper.getTroubleReportInfo(troubleReportVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public String getStationName(TroubleReportVO troubleReportVo) {
		// TODO Auto-generated method stub
		return commonPopupMapper.getStationName(troubleReportVo);
	}
	
	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int insertTrouble(TroubleReportVO troubleReportVo) {
		
		return commonPopupMapper.insertTrouble(troubleReportVo);
	}
	
	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int insertTroubleType(TroubleReportVO troubleReportVo) {
		
		return commonPopupMapper.insertTroubleType(troubleReportVo);
	}
	
	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int updateTrouble(TroubleReportVO troubleReportVo) {
		
		return commonPopupMapper.updateTrouble(troubleReportVo);
	}
	
	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int insertTroubleDetail(TroubleReportVO troubleReportVo) {
		
		return commonPopupMapper.insertTroubleDetail(troubleReportVo);
	}
	
	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int deleteTroubleDetail(TroubleReportVO troubleReportVo) {
		
		return commonPopupMapper.deleteTroubleDetail(troubleReportVo);
	}
	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int updateDeviceStatus(TroubleReportVO troubleReportVo) {

		if(troubleReportVo.getDeviceType().equals("DEV_003")){
			troubleReportVo.setDeviceStatus("APS_001");
			return commonPopupMapper.updateApStatus(troubleReportVo);
		}else if(troubleReportVo.getDeviceType().equals("DEV_001")){
			troubleReportVo.setDeviceStatus("BKS_001");
			return commonPopupMapper.updateBikeStatus(troubleReportVo);
		}else{
			troubleReportVo.setDeviceStatus("RAS_001");
			return commonPopupMapper.updateLockStatus(troubleReportVo);
		}
	}
	
	/**
	 * @location   : com.dkitec.barocle.admin.common.service.serviceImpl.CommonPopupService.isBlackList
	 * @writeDay   : 2015. 7. 9. 오후 4:30:44
	 * @overridden : @see com.dkitec.barocle.admin.common.service.CommonPopupService#isBlackList(com.dkitec.barocle.admin.status.rentHistory.vo.PenaltyVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean isBlackList(PenaltyVO penaltyVo) {
        int result = commonPopupMapper.isBlackList(penaltyVo);
		return result > 0 ? true : false;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.common.service.serviceImpl.CommonPopupService.existBlackUsr
	 * @writeDay   : 2015. 7. 9. 오후 6:09:28
	 * @overridden : @see com.dkitec.barocle.admin.common.service.CommonPopupService#existBlackUsr(com.dkitec.barocle.admin.status.rentHistory.vo.PenaltyVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean existBlackUsr(PenaltyVO penaltyVo) {
		return  commonPopupMapper.existBlackUsr(penaltyVo) > 0 ? true : false;
	}

	@Override
	public boolean chkFaultExist(TroubleReportVO troubleReportVo) {
		// TODO Auto-generated method stub
		int result = commonPopupMapper.chkFaultExist(troubleReportVo);
		return result > 0 ? true : false;
	}
	
	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int addMileageImpose(MileageVO mileageVo) {
		// TODO Auto-generated method stub
		return commonPopupMapper.addMileageImpose(mileageVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<TeamMgmtVO> getFindOutTeam(TeamMgmtVO teamVo) {
		
		List<TeamMgmtVO> resultList = null;
		resultList =  commonPopupMapper.getTeamInfo(teamVo);
		
		return resultList;
	}

	/*
	 * 2020-07-06
	 * 자전거 수리입력 개선 페이지에서 사용
	 * @see com.dkitec.barocle.admin.common.service.CommonPopupService#getBikeDeviceDtlObsInfo(com.dkitec.barocle.admin.common.vo.FindOutDeviceVO)
	 */
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<FindOutDeviceVO> getBikeDeviceDtlObsInfo(FindOutDeviceVO foVo) {
		
		return commonPopupMapper.getBikeDeviceDtlObsInfo(foVo);
		
	}
}
