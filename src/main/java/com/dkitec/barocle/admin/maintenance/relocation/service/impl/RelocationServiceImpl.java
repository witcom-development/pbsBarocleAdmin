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
package com.dkitec.barocle.admin.maintenance.relocation.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.common.service.CommonPopupMapper;
import com.dkitec.barocle.admin.maintenance.relocation.service.RelocationMapper;
import com.dkitec.barocle.admin.maintenance.relocation.service.RelocationService;
import com.dkitec.barocle.admin.maintenance.relocation.vo.RelocationMapVO;
import com.dkitec.barocle.admin.maintenance.relocation.vo.RelocationVO;
import com.dkitec.barocle.admin.maintenance.relocation.vo.RelocationWorkArrangeCallVO;
import com.dkitec.barocle.admin.maintenance.relocation.vo.RelocationWorkArrangeResultVO;
import com.dkitec.barocle.admin.maintenance.relocation.vo.RelocationWorkOrderVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="relocationService")
public class RelocationServiceImpl extends EgovAbstractServiceImpl implements RelocationService {

	@Autowired private RelocationMapper relocationMapper;
	@Autowired private CommonPopupMapper commonPopupMapper;
	@Autowired private TerminalMapper terminalMapper;

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<RelocationVO> getRelocationNeedList(RelocationVO relocationVo) {
		// TODO Auto-generated method stub
		return relocationMapper.getRelocationNeedList(relocationVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getRelocationNeedListCount(RelocationVO relocationVo) {
		// TODO Auto-generated method stub
		return relocationMapper.getRelocationNeedListCount(relocationVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<RelocationVO> getRelocationStateList(RelocationVO relocationVo) {
		// TODO Auto-generated method stub
		return relocationMapper.getRelocationStateList(relocationVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getRelocationStateListCount(RelocationVO relocationVo) {
		// TODO Auto-generated method stub
		return relocationMapper.getRelocationStateListCount(relocationVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<RelocationVO> getRelocationStateDetail(RelocationVO relocationVo){
		// TODO Auto-generated method stub
		return relocationMapper.getRelocationStateDetail(relocationVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getRelocationStateDetailCount(RelocationVO relocationVo){
		// TODO Auto-generated method stub
		return relocationMapper.getRelocationStateDetailCount(relocationVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<RelocationVO> getRelocationStateBike(RelocationVO relocationVo){
		// TODO Auto-generated method stub
		return relocationMapper.getRelocationStateBike(relocationVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getRelocationStateBikeCount(RelocationVO relocationVo){
		// TODO Auto-generated method stub
		return relocationMapper.getRelocationStateBikeCount(relocationVo);
	}
	
	
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<RelocationVO> getRelocationStateStation(RelocationVO relocationVo){
		// TODO Auto-generated method stub
		return relocationMapper.getRelocationStateStation(relocationVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getRelocationStateStationCount(RelocationVO relocationVo){
		// TODO Auto-generated method stub
		return relocationMapper.getRelocationStateStationCount(relocationVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<RelocationMapVO> getRelocationStateStationMap(RelocationVO relocationVo){
		// TODO Auto-generated method stub
		return relocationMapper.getRelocationStateStationMap(relocationVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.DEVDB)
	public List<RelocationWorkOrderVO> getRelocationWorkOrder(RelocationWorkOrderVO relocationVo) {
		// TODO Auto-generated method stub
		return relocationMapper.getRelocationWorkOrder(relocationVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.DEVDB)
	public int getRelocationWorkOrderCount(RelocationWorkOrderVO relocationVo) {
		// TODO Auto-generated method stub
		return relocationMapper.getRelocationWorkOrderCount(relocationVo);
	}
	
	
	@Override
	@DataSource(DataSourceType.DEVDB)
	public int insertRelocationArrangeCall(RelocationWorkArrangeCallVO relocationVo) {
		// TODO Auto-generated method stub
		return relocationMapper.insertRelocationArrangeCall(relocationVo);
	}
	
	
	
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.DEVDB)
	public List<RelocationWorkArrangeCallVO> getRelocationArrangeCall(RelocationWorkArrangeCallVO vo) {
		// TODO Auto-generated method stub
		return relocationMapper.getRelocationArrangeCall(vo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.DEVDB)
	public List<RelocationWorkArrangeResultVO> getRelocationArrangeResult(RelocationWorkArrangeResultVO vo) {
		// TODO Auto-generated method stub
		return relocationMapper.getRelocationArrangeResult(vo);
	}
	
}
