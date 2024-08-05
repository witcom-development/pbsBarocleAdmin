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
package com.dkitec.barocle.admin.maintenance.check.lock.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.common.service.CommonPopupMapper;
import com.dkitec.barocle.admin.maintenance.check.lock.service.CheckLockMapper;
import com.dkitec.barocle.admin.maintenance.check.lock.service.CheckLockService;
import com.dkitec.barocle.admin.maintenance.check.lock.vo.CheckLockVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="checkLockService")
public class CheckLockServiceImpl extends EgovAbstractServiceImpl implements CheckLockService {

	@Autowired private CheckLockMapper checkLockMapper;
	@Autowired private CommonPopupMapper commonPopupMapper;
	@Autowired private TerminalMapper terminalMapper;

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<CheckLockVO> getCheckLockList(CheckLockVO checkLockVo) {
		// TODO Auto-generated method stub
		return checkLockMapper.getCheckLockList(checkLockVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getCheckLockListCount(CheckLockVO checkLockVo) {
		// TODO Auto-generated method stub
		return checkLockMapper.getCheckLockListCount(checkLockVo);
	}

	@Override
	@Transactional(readOnly= false)
	@DataSource(DataSourceType.MASTER)
	public int exeLockSelectCheck(CheckLockVO checkLockVo) {
		// TODO Auto-generated method stub
		int result = 0;
		String[] faultSeqArr = checkLockVo.getFaultSeq().split(",");
		for (int i = 0; i < faultSeqArr.length; i++) {
			checkLockVo.setFaultSeq(faultSeqArr[i]);
			result = checkLockMapper.exeLockCheck(checkLockVo);
		}
		return result;
	}

	@Override
	@Transactional(readOnly= false)
	@DataSource(DataSourceType.MASTER)
	public int exeLockAllCheck(CheckLockVO checkLockVo, List<CheckLockVO> resultList) {
		// TODO Auto-generated method stub
		int result = 0;
		
		for (int i = 0; i < resultList.size(); i++) {
			checkLockVo.setFaultSeq(resultList.get(i).getFaultSeq());
			result = checkLockMapper.exeLockCheck(checkLockVo);
		}
		return result;
	}

}
