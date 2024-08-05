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
package com.dkitec.barocle.admin.maintenance.inspect.lock.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.common.service.CommonPopupMapper;
import com.dkitec.barocle.admin.maintenance.inspect.lock.service.InspectLockMapper;
import com.dkitec.barocle.admin.maintenance.inspect.lock.service.InspectLockService;
import com.dkitec.barocle.admin.maintenance.inspect.lock.vo.InspectLockVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="inspectLockService")
public class InspectLockServiceImpl extends EgovAbstractServiceImpl implements InspectLockService {

	@Autowired private InspectLockMapper inspectLockMapper;
	@Autowired private CommonPopupMapper commonPopupMapper;
	@Autowired private TerminalMapper terminalMapper;

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<InspectLockVO> getInspectLockList(InspectLockVO inspectLockVo) {
		// TODO Auto-generated method stub
		return inspectLockMapper.getInspectLockList(inspectLockVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getInspectLockListCount(InspectLockVO inspectLockVo) {
		// TODO Auto-generated method stub
		return inspectLockMapper.getInspectLockListCount(inspectLockVo);
	}

}
