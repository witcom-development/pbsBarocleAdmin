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
package com.dkitec.barocle.admin.maintenance.repair.ap.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.common.service.CommonPopupMapper;
import com.dkitec.barocle.admin.maintenance.repair.ap.service.RepairApMapper;
import com.dkitec.barocle.admin.maintenance.repair.ap.service.RepairApService;
import com.dkitec.barocle.admin.maintenance.repair.ap.vo.RepairApVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="repairApService")
public class RepairApServiceImpl extends EgovAbstractServiceImpl implements RepairApService {

	@Autowired private RepairApMapper repairApMapper;
	@Autowired private CommonPopupMapper commonPopupMapper;
	@Autowired private TerminalMapper terminalMapper;

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<RepairApVO> getRepairApList(RepairApVO repairApVo) {
		// TODO Auto-generated method stub
		return repairApMapper.getRepairApList(repairApVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getRepairApListCount(RepairApVO repairApVo) {
		// TODO Auto-generated method stub
		return repairApMapper.getRepairApListCount(repairApVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public RepairApVO getRepairApInfo(RepairApVO repairApVo) {
		// TODO Auto-generated method stub
		return repairApMapper.getRepairApInfo(repairApVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<String> getRepairCodeList(String repairSeq) {
		// TODO Auto-generated method stub
		return repairApMapper.getRepairCodeList(repairSeq);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public String getApMoveYn(RepairApVO repairApVo){
		// TODO Auto-generated method stub
		return repairApMapper.getApMoveYn(repairApVo);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int insertRepairAp(RepairApVO repairApVo){
		// TODO Auto-generated method stub
		repairApMapper.updateApStatus(repairApVo);
		if(!repairApVo.getFaultSeq().equals("")){
			repairApMapper.updateFaultAp(repairApVo);
		}
		if(repairApVo.getMoveYn().equals("Y")){
			repairApMapper.updateApMoveHistory(repairApVo);
			repairApMapper.insertApMoveHistory(repairApVo);
		}
		return repairApMapper.insertRepairAp(repairApVo);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int updateRepairAp(RepairApVO repairApVo){
		// TODO Auto-generated method stub
		repairApMapper.updateApStatus(repairApVo);
		if(repairApVo.getMoveYn().equals("Y")){
			repairApMapper.updateApMoveHistory(repairApVo);
			repairApMapper.insertApMoveHistory(repairApVo);
		}
		return repairApMapper.updateRepairAp(repairApVo);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int deleteRepairAp(RepairApVO repairApVo){
		// TODO Auto-generated method stub
		return repairApMapper.deleteRepairAp(repairApVo);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int insertRepairApDetail(RepairApVO repairApVo){
		// TODO Auto-generated method stub
		return repairApMapper.insertRepairApDetail(repairApVo);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int deleteRepairApDetail(RepairApVO repairApVo){
		// TODO Auto-generated method stub
		return repairApMapper.deleteRepairApDetail(repairApVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public String getRegId(RepairApVO repairApVo) {
		// TODO Auto-generated method stub
		return repairApMapper.getRegId(repairApVo);
	}
}
