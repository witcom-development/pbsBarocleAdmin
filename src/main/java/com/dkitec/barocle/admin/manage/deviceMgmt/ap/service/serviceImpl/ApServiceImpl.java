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
package com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.serviceImpl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.common.service.CommonPopupMapper;
import com.dkitec.barocle.admin.common.vo.RegularChkVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApMapper;
import com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService;
import com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO;
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
@Service(value ="apService")
public class ApServiceImpl extends EgovAbstractServiceImpl implements ApService {

	@Autowired private ApMapper apMapper;
	@Autowired private CommonPopupMapper commonPopupMapper;
	

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.serviceImpl.ApService.addAPDevice
	 * @writeDay   : 2015. 4. 19. 오후 8:26:13
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService#addAPDevice(com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly=false, rollbackFor= {Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int addAPDevice(ApVO apVo) {
		int result = 0;
		//최초 등록시.
		result = apMapper.insertDeviceReg(apVo);
		result = apMapper.addApLocateHist(apVo);
		
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
	public int setAPDevice(ApVO apVo, ApVO apOldInfo) {
		int result = 0;
		
		if(!apOldInfo.getLocateClsCd().equals(apVo.getLocateClsCd()) || !apOldInfo.getLocateId().equals(apVo.getLocateId()) ) {
			
			result = apMapper.setApLocateHist(apOldInfo);//기존에 있던 이력을 갱신
			result = apMapper.addApLocateHist(apVo);//새 이력을 등록
			result = apMapper.setAPDevice(apVo);//AP 갱신
		} else {
			result = apMapper.setAPDevice(apVo);//
		}
		
		return result;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.serviceImpl.ApService.getApList
	 * @writeDay   : 2015. 4. 19. 오후 8:26:13
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService#getApList(com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<ApVO> getApList(ApVO apVo) {
		// TODO Auto-generated method stub
		
		List<ApVO> resultList = apMapper.getApList(apVo);
		
		return resultList;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.serviceImpl.ApService.getAPInfo
	 * @writeDay   : 2015. 4. 19. 오후 8:43:20
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService#getAPInfo(com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public ApVO getAPInfo(ApVO apVo) {
		// TODO Auto-generated method stub
		ApVO info = apMapper.getAPInfo(apVo);
		
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
	public boolean isChkIdDup(ApVO apVo) {
		// TODO Auto-generated method stub
		boolean isChk  = apMapper.isChkIdDup(apVo) > 0 ? true : false;
		return isChk;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.serviceImpl.ApService.getApListCount
	 * @writeDay   : 2015. 4. 20. 오후 3:26:03
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService#getApListCount(com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getApListCount(ApVO apVo) {
		// TODO Auto-generated method stub
		return apMapper.getApListCount(apVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.serviceImpl.ApService.getStation
	 * @writeDay   : 2015. 4. 21. 오후 4:06:36
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService#getStation(java.lang.String)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<String> getStation(String stationGrpSeq) {
		// TODO Auto-generated method stub
		return apMapper.getStation(stationGrpSeq);
	}
	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.serviceImpl.ApService.setRegularChkComplete
	 * @writeDay   : 2015. 4. 21. 오후 4:06:36
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService#setRegularChkComplete(java.lang.String[])
	 * @Todo       :
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED ,readOnly = false, rollbackFor= {Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int setRegularChkComplete(List<ApVO> apList, String adminId) {
		int result = 0;
		if(apList.size() > 0) {
			RegularChkVO chkVo = null;
			for(ApVO vo : apList)	{
				chkVo = new RegularChkVO();
				chkVo.setEquipmentClsCd(IConstants.DEVICE_AP);
				chkVo.setEquipmentId(vo.getDeviceId());
				chkVo.setAdminId(adminId);
				
				result = commonPopupMapper.setApLastChkDttm(chkVo);
				result = commonPopupMapper.addRegularChkUpInfo(chkVo);
			}
			
		}
		return result;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.serviceImpl.ApService.getApHistoryInfo
	 * @writeDay   : 2015. 5. 7. 오후 2:07:36
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService#getApHistoryInfo(com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public ApVO getApHistoryInfo(ApVO apVo) {
		// TODO Auto-generated method stub
		return apMapper.getApHistoryInfo(apVo.getDeviceId()); 
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.serviceImpl.ApService.isStationAPExist
	 * @writeDay   : 2015. 5. 7. 오후 2:18:39
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService#isStationAPExist(com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean isStationAPExist(ApVO apVo) {
		// TODO Auto-generated method stub
		int result = apMapper.isStationAPExist(apVo);
		 
		return result > 0 ? true  : false;
	}
}
