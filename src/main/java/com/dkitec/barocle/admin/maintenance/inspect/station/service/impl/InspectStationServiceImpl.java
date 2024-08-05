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
package com.dkitec.barocle.admin.maintenance.inspect.station.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.common.service.CommonPopupMapper;
import com.dkitec.barocle.admin.maintenance.inspect.station.service.InspectStationMapper;
import com.dkitec.barocle.admin.maintenance.inspect.station.service.InspectStationService;
import com.dkitec.barocle.admin.maintenance.inspect.station.vo.InspectStationVO;
import com.dkitec.barocle.admin.maintenance.repair.ap.vo.RepairApVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="inspectStationService")
public class InspectStationServiceImpl extends EgovAbstractServiceImpl implements InspectStationService {

	@Autowired private InspectStationMapper inspectStationMapper;

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<InspectStationVO> getInspectStationList(InspectStationVO inspectApVo) {
		// TODO Auto-generated method stub
		return inspectStationMapper.getInspectStationList(inspectApVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getInspectStationListCount(InspectStationVO inspectApVo) {
		// TODO Auto-generated method stub
		return inspectStationMapper.getInspectStationListCount(inspectApVo);
	}

}
