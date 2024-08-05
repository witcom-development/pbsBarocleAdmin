/*
 * @Package Name : com.dkitec.barocle.admin.manage.DeviceMgmt.service.serviceImpl
 * @파일명          : DeviceMgmtServiceImpl.java
 * @작성일          : 2015. 4. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 15.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.serviceImpl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.common.service.CommonPopupMapper;
import com.dkitec.barocle.admin.common.vo.RegularChkVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeMapper;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper;
import com.dkitec.barocle.admin.manage.deviceMgmt.terminal.vo.TerminalVO;
import com.dkitec.barocle.admin.status.rentStatus.vo.BikeRentalVO;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @파일명          : DeviceMgmtServiceImpl.java
 * @작성일          : 2015. 4. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 15.   |   ymshin   |  최초작성
 */
@Service(value="bikeService")
public class BikeServiceImpl extends EgovAbstractServiceImpl implements BikeService {

	@Autowired private BikeMapper bikeMapper;
	@Autowired private CommonPopupMapper commonPopupMapper;
	@Autowired private TerminalMapper terminalMapper;
	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.serviceImpl.BikeService.getBikeList
	 * @writeDay   : 2015. 4. 21. 오후 7:44:02
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService#getBikeList(com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<BikeVO> getBikeList(BikeVO bikeVo) {
		// TODO Auto-generated method stub
		return bikeMapper.getBikeList(bikeVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.serviceImpl.BikeService.getBikeInfo
	 * @writeDay   : 2015. 4. 21. 오후 7:44:02
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService#getBikeInfo(com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public BikeVO getBikeInfo(BikeVO bikeVo) {
		// TODO Auto-generated method stub
		return bikeMapper.getBikeInfo(bikeVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public BikeVO getBikeCurrentInfo(BikeVO bikeVo) {
		// TODO Auto-generated method stub
		return bikeMapper.getBikeCurrentInfo(bikeVo);
	}

	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor = {Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int addNewBikeDevice(BikeVO bikeVo) {
		int result = 0;
		//bike 최초 등록시 단말기 Id로 단말기이력 정보도 같이 수정.
		//자전거 등록
		result = bikeMapper.addNewBikeDevice(bikeVo);
		//최초 자전거 배치이력 등록
		result = bikeMapper.addBikeLocateHist(bikeVo);

		//단말기 배치이력 수정. 등록
		if( bikeVo.getTerminalId() != null && !bikeVo.getTerminalId().equals("")) {
			TerminalVO tVo = new TerminalVO();
			tVo.setDeviceId(bikeVo.getTerminalId());
			tVo.setLocateClsCd("B");
			tVo.setLocateId(bikeVo.getBikeId());
			tVo.setLocateAdminId(bikeVo.getAdminId());
			
			result = terminalMapper.setTerminalLocateInfo(tVo);
			result = terminalMapper.addTerminalLocateHist(tVo);
			//단말기 상태 변경.
			tVo.setDeviceStatusCd("DES_002");
			result = terminalMapper.setTerminalData(tVo);
			
		}
		return result;
	}

	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int setBikeDevice(BikeVO bikeVo, BikeVO oldVo) {
		int result = 0;
		//기존 센터-> 다른 센터, 대여소 -> 센터 
		//자전거의 이력이 바뀌면 단말기의 이력도 같이 갱신.
		//대여소->센터로
		if(oldVo.getCenterId() != null && (!oldVo.getCenterId().equals(bikeVo.getCenterId()) || (!oldVo.getCenterId().equals("") && bikeVo.getCenterId().equals("")))) {
			
			result = bikeMapper.setBikeHistoryInfo(oldVo);
			result = bikeMapper.addBikeLocateHist(bikeVo);
			if(oldVo.getIsParking().equals("P")){
				result = bikeMapper.delBikeParking(bikeVo);
			}
			
		} else if(!oldVo.getTerminalId().equals(bikeVo.getTerminalId())) {
			TerminalVO tVo = new TerminalVO();
			//기존 단말기
			tVo.setLocateAdminId(bikeVo.getAdminId());
			tVo.setDeviceId(oldVo.getTerminalId());
			if(oldVo.getTerminalId().equals("")) {
				tVo.setDeviceId(bikeVo.getTerminalId());
			}
			result = terminalMapper.setTerminalLocateInfo(tVo);
			//새 장착 단말기
			tVo.setDeviceId(bikeVo.getTerminalId());
			tVo.setBikeId(bikeVo.getBikeId());
			tVo.setLocateClsCd("B");
			tVo.setLocateId(bikeVo.getBikeId());
			result = terminalMapper.addTerminalLocateHist(tVo);
			tVo.setDeviceStatusCd("DES_002");
			
			result = terminalMapper.setTerminalData(tVo);
			
			
		} 
		result = bikeMapper.setBikeDevice(bikeVo);
		
		
		return result;
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getBikeListCount(BikeVO bikeVo) {
		// TODO Auto-generated method stub
		return bikeMapper.getBikeListCount(bikeVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.serviceImpl.BikeService.getChkBikeIDnNo
	 * @writeDay   : 2015. 4. 23. 오후 1:15:37
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService#getChkBikeIDnNo(com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public BikeVO getChkBikeIDnNo(BikeVO bikeVo) {
		// TODO Auto-generated method stub
		return bikeMapper.getChkBikeIDnNo(bikeVo);
	}


	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.serviceImpl.BikeService.getBikeHistoryInfoCount
	 * @writeDay   : 2015. 4. 23. 오후 2:02:34
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService#getBikeHistoryInfoCount(java.lang.String)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getBikeHistoryInfoCount(BikeVO bikeVo) {
		// TODO Auto-generated method stub
		return bikeMapper.getBikeHistoryInfoCount(bikeVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<String> getStation(String searchWord) {
		// TODO Auto-generated method stub
		return bikeMapper.getStation(searchWord);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.serviceImpl.BikeService.setBikeLasChkDttm
	 * @writeDay   : 2015. 5. 4. 오전 10:58:20
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService#setBikeLasChkDttm(java.util.List)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=false, propagation= Propagation.REQUIRED, rollbackFor ={SQLException.class, Exception.class})
	@DataSource(DataSourceType.MASTER)
	public int setBikeLasChkDttm(List<BikeVO> resultList, String adminId) {
		int result = 0;
		if(resultList.size() > 0) {
			RegularChkVO chkVo = null;
			for(BikeVO vo : resultList)	{
				chkVo = new RegularChkVO();
				chkVo.setEquipmentClsCd(IConstants.DEVICE_BIKE);
				chkVo.setEquipmentId(vo.getBikeNo());
				chkVo.setAdminId(adminId);
				
				result = commonPopupMapper.setBikeLastChkDttm(chkVo);
				result = commonPopupMapper.addRegularChkUpInfo(chkVo);
			}
			
		}
		
		return result;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.serviceImpl.BikeService.getOldBikeInfo
	 * @writeDay   : 2015. 5. 8. 오전 9:44:59
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService#getOldBikeInfo(java.lang.String)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public BikeVO getOldBikeInfo(String bikeId) {
		// TODO Auto-generated method stub
		return bikeMapper.getOldBikeInfo(bikeId);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.serviceImpl.BikeService.getBikeHistoryInfo
	 * @writeDay   : 2015. 5. 18. 오전 11:06:47
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService#getBikeHistoryInfo(com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<BikeRentalVO> getBikeHistoryInfo(BikeVO bikeVo) {
		// TODO Auto-generated method stub
		return bikeMapper.getBikeHistoryInfo(bikeVo);
	}

	@Override
	public int getBikeRobListCount(BikeVO bikeVo) {
		// TODO Auto-generated method stub
		return bikeMapper.getBikeRobListCount(bikeVo);
	}

	@Override
	public List<BikeVO> getBikeRobList(BikeVO bikeVo) {
		// TODO Auto-generated method stub
		return bikeMapper.getBikeRobList(bikeVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public BikeVO getQRBikeInfo(BikeVO bikeVo) {
		return bikeMapper.getQRBikeInfo(bikeVo);
	}
	
	@Override
	@Transactional(readOnly=false, propagation= Propagation.REQUIRED, rollbackFor={SQLException.class, Exception.class})
	@DataSource(DataSourceType.MASTER)
	public int exeQrMoveProc(BikeVO bikeVo) {
		int result = 0;
		// 자전거 상태 업데이트
		result = bikeMapper.setBikeStatus(bikeVo);
		
		// 배치 이력 업데이트
		result = bikeMapper.setBikeHistoryInfo(bikeVo);
		
		// 주차 정보 삭제
		result = bikeMapper.delBikeParking(bikeVo);
		
		// 배치이력 체크
		if (bikeMapper.chkRelocateHist(bikeVo) == 0) {
			// 배치이력 입력
			result = bikeMapper.addBikeRelocateHist(bikeVo);
		}
		 
		return result;
	}

	@Override
	@Transactional(readOnly=false, propagation= Propagation.REQUIRED, rollbackFor={SQLException.class, Exception.class})
	@DataSource(DataSourceType.MASTER)
	public int setBikeRelocateHistNew(BikeVO bikeVo) {
		int result = 0;
  
		result = bikeMapper.setBikeRelocateHistNew(bikeVo);
	 
		return result;
	}
	
	
	// 2021 10 26 update Lock 방지를 위해 개별건 조회
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE02)
	public List<BikeVO> selectBikeRelocateTarget(BikeVO bikeVo) {
		int result = 0;
		BikeVO selectVo = bikeMapper.selectRelocateStationId(bikeVo); 
		return bikeMapper.selectRelocateSeq(selectVo);
	}
	
	// 2021 10 26 update Lock 방지를 위해 개별건 업데이트
	@Override
	@Transactional(readOnly=false, propagation= Propagation.REQUIRED, rollbackFor={SQLException.class, Exception.class})
	@DataSource(DataSourceType.MASTER)
	public int updateBikeRelocateSeq(BikeVO bikeVo) {
		int result = 0;
  
		result = bikeMapper.updateBikeRelocateSeq(bikeVo);
	 
		return result;
	}
	
	
	
	
	@Override
	@Transactional(readOnly=false, propagation= Propagation.REQUIRED, rollbackFor={SQLException.class, Exception.class})
	@DataSource(DataSourceType.MASTER)
	public int exeQRBikeRelocate(BikeVO bikeVo) {
		int result = 0;
		
		result = bikeMapper.addDairyRelocate(bikeVo);		// 배치 이력 업데이트
		result = bikeMapper.setBikeRelocateHist(bikeVo);
		
		return result;
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public BikeVO getBikeLog(BikeVO bikeVo) {
		// TODO Auto-generated method stub
		return bikeMapper.getBikeLog(bikeVo);
	}

	@Override
	public List<BikeVO> getBikeLostLog() {
		// TODO Auto-generated method stub
		return bikeMapper.getBikeLostLog();
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.serviceImpl.BikeService.getQRBikeStatusCd
	 * @writeDay   : 2020. 11. 16. 오후 15:45:00
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService#getQRBikeStatusCd(com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO)
	 * @Todo       :
	 */ 	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)	
	public BikeVO getQRBikeStatusCd(BikeVO bikeVo) {
		// TODO Auto-generated method stub
		return bikeMapper.getQRBikeStatusCd(bikeVo);
	}

	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)	
	public BikeVO getQRBikeInfoPhone(BikeVO bikeVo)  {
		// TODO Auto-generated method stub
		return bikeMapper.getQRBikeInfoPhone(bikeVo);
	}
 
}
