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
package com.dkitec.barocle.admin.manage.deviceMgmt.beacon.service.serviceImpl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.common.service.CommonPopupMapper;
import com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.arm.vo.ArmVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.beacon.service.BeaconMapper;
import com.dkitec.barocle.admin.manage.deviceMgmt.beacon.service.BeaconService;
import com.dkitec.barocle.admin.manage.deviceMgmt.beacon.vo.BeaconVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper;
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
@Service(value="beaconService")
public class BeaconServiceImpl extends EgovAbstractServiceImpl implements BeaconService {

	@Autowired private BeaconMapper beaconMapper;
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
	public List<BeaconVO> getBeaconList(BeaconVO beaconVo) {
		
		return beaconMapper.getBeaconList(beaconVo);
	}


	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getBeaconListCount(BeaconVO beaconVo) {
		
		return beaconMapper.getBeaconListCount(beaconVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public BeaconVO getBeaconInfo(BeaconVO beaconVo) {
		
		BeaconVO info = beaconMapper.getBeaconInfo(beaconVo);
		
		return info;
	}
	
	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.serviceImpl.ApService.isChkIdDup
	 * @writeDay   : 2015. 4. 19. 오후 8:48:01
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService#isChkIdDup(java.lang.String)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean isChkIdDup(BeaconVO beaconVo) {
		
		boolean isChk  = beaconMapper.isChkIdDup(beaconVo) > 0 ? true : false;
		return isChk;
	}
	
	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.serviceImpl.ArmService.addArmDevice
	 * @writeDay   : 2015. 4. 21. 오후 7:34:12
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmService#addArmDevice(com.dkitec.barocle.admin.manage.deviceMgmt.arm.vo.ArmVO)
	 * @Todo       : 거치대 최초 등록시 
	 */ 
	@Override
	@Transactional(propagation = Propagation.REQUIRED ,readOnly = false, rollbackFor= {Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int addBeaconDevice(BeaconVO beaconVo)   {
		int result = 0;
		
		result = beaconMapper.insertDeviceReg(beaconVo);
		result = beaconMapper.insertBeaconReg(beaconVo);
		
		return result;
	}
	
	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.serviceImpl.ApService.setAPDevice
	 * @writeDay   : 2015. 4. 19. 오후 8:26:13
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService#setAPDevice(com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO)
	 * @Todo       :ap위치가 센터 -> 대여소, 대여소 -> 센터 같은 기존센터에서 다른 센터로 기존 대여소에서 다른 대여소로 이동할 경우에도
	 *              이력을 남김.
	 */ 
	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly=false, rollbackFor= {Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int setBeaconDevice(BeaconVO beaconVo) {
		int result = 0;
		
		result = beaconMapper.setBeaconDevice(beaconVo);
		result = beaconMapper.setQRBeaconDevice(beaconVo);
		
		return result;
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public BeaconVO getBeaconInfoBySerial(BeaconVO beaconVo) {
		
		BeaconVO info = beaconMapper.getBeaconInfoBySerial(beaconVo);
		
		return info;
	}
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly=false, rollbackFor= {Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int matchingBeacon(BeaconVO beaconVo) {
		int result = 0;
		int cnt = 0;
		if (beaconVo.getOldDeviceId()!=null && !beaconVo.getOldDeviceId().equals("")){
			BeaconVO tempBeaconVo = new BeaconVO();
			tempBeaconVo.setDeviceId(beaconVo.getOldDeviceId());
			cnt = beaconMapper.delMatchingBeaconDevice(tempBeaconVo);
		}
		cnt = beaconMapper.delMatchingBeaconDevice(beaconVo);//
		result = cnt;
		cnt = beaconMapper.addMatchingBeaconDevice(beaconVo);//
		result = result + cnt;
		return result;
	}
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly=false, rollbackFor= {Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int delConnBeacon(BeaconVO beaconVo) {
		int result = 0;
		
		result = beaconMapper.delMatchingBeaconDevice(beaconVo);
		
		return result;
	}

}
