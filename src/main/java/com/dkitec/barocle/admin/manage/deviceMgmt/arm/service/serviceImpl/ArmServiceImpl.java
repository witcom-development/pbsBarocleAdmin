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
package com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.serviceImpl;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.common.service.CommonPopupMapper;
import com.dkitec.barocle.admin.common.vo.RegularChkVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmMapper;
import com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmService;
import com.dkitec.barocle.admin.manage.deviceMgmt.arm.vo.ArmVO;
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
@Service(value = "armService")
public class ArmServiceImpl extends EgovAbstractServiceImpl implements ArmService {

	@Autowired private ArmMapper armMapper;
	@Autowired private CommonPopupMapper commonPopupMapper;
	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.serviceImpl.ArmService.getStation
	 * @writeDay   : 2015. 4. 21. 오후 7:34:11
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmService#getStation(java.lang.String)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<String> getStation(String stationGrpSeq)  {
		// TODO Auto-generated method stub
		return armMapper.getStation(stationGrpSeq);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.serviceImpl.ArmService.getArmList
	 * @writeDay   : 2015. 4. 21. 오후 7:34:12
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmService#getArmList(com.dkitec.barocle.admin.manage.deviceMgmt.arm.vo.ArmVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<ArmVO> getArmList(ArmVO armVo) {
		// TODO Auto-generated method stub
		
		List<ArmVO> resultList = armMapper.getArmList(armVo);
		
		return resultList;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.serviceImpl.ArmService.getArmListCount
	 * @writeDay   : 2015. 4. 21. 오후 7:34:12
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmService#getArmListCount(com.dkitec.barocle.admin.manage.deviceMgmt.arm.vo.ArmVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getArmListCount(ArmVO armVo)  {
		// TODO Auto-generated method stub
		
		return armMapper.getArmListCount(armVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.serviceImpl.ArmService.getArmInfo
	 * @writeDay   : 2015. 4. 21. 오후 7:34:12
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmService#getArmInfo(com.dkitec.barocle.admin.manage.deviceMgmt.arm.vo.ArmVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public ArmVO getArmInfo(ArmVO armVo)  {
	
		ArmVO resultVO = armMapper.getArmInfo(armVo);
		
		return resultVO;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.serviceImpl.ArmService.setArmDevice
	 * @writeDay   : 2015. 4. 21. 오후 7:34:12
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmService#setArmDevice(com.dkitec.barocle.admin.manage.deviceMgmt.arm.vo.ArmVO)
	 * @Todo       : 거치대 갱신. 기존 이력의 거치대 현 위치가 (센터,스테이션,거치대번호) 상이할 경우에 기존 이력을 갱신 그리고 새로운 이력 등록
	 *               거치대 정보 갱신.
	 */ 
	@Override
	@Transactional(propagation = Propagation.REQUIRED ,readOnly = false, rollbackFor= {Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int setArmDevice(ArmVO armVo, ArmVO oldInfo)  {
		int result = 0;
		
		if(!oldInfo.getLocateId().equals(armVo.getLocateId())) {
			result = armMapper.setArmLocateHistory(oldInfo);
			result = armMapper.setArmDevice(armVo);
			result = armMapper.addArmLocateHistory(armVo);
		} else {
			result = armMapper.setArmDevice(armVo);
		}
		
		return result;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.serviceImpl.ArmService.isChkIdDup
	 * @writeDay   : 2015. 4. 21. 오후 7:34:12
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmService#isChkIdDup(java.lang.String)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean isChkIdDup(String apId)  {
		// TODO Auto-generated method stub
		boolean isChk = armMapper.isChkIdDup(apId) > 0 ? true : false;
		
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
	public int addArmDevice(ArmVO armVo)   {
		int result = 0;
		
		result = armMapper.addArmDevice(armVo);
		result = armMapper.addArmLocateHistory(armVo);
		
		return result;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.serviceImpl.ArmService.setArmLasChkDttm
	 * @writeDay   : 2015. 5. 6. 오후 7:59:10
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmService#setArmLasChkDttm(java.util.List)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(propagation = Propagation.REQUIRED ,readOnly = false, rollbackFor= {Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int setArmLasChkDttm(List<ArmVO> resultList, String adminId) {
		// TODO Auto-generated method stub
		int result = 0;
		if(resultList.size() > 0) {
			RegularChkVO chkVo = null;
			for(ArmVO vo : resultList)	{
				chkVo = new RegularChkVO();
				chkVo.setEquipmentClsCd(IConstants.DEVICE_ARM);
				chkVo.setEquipmentId(vo.getRackId());
				chkVo.setAdminId(adminId);
				
				result = commonPopupMapper.setArmLastChkDttm(chkVo);
				result = commonPopupMapper.addRegularChkUpInfo(chkVo);
			}
			
		}
		
		return result;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.serviceImpl.ArmService.isEquipExist
	 * @writeDay   : 2015. 5. 7. 오후 3:43:09
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmService#isEquipExist(com.dkitec.barocle.admin.manage.deviceMgmt.arm.vo.ArmVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean isEquipExist(ArmVO armVo) {
		
		int result = armMapper.isEquipExist(armVo);
		
		return result> 0 ? true : false;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.serviceImpl.ArmService.getArmLocateInfo
	 * @writeDay   : 2015. 5. 7. 오후 4:25:29
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmService#getArmLocateInfo(java.lang.String)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public ArmVO getArmLocateInfo(String rackId) {
		// TODO Auto-generated method stub
		return armMapper.getArmLocateInfo(rackId);
	}

}
