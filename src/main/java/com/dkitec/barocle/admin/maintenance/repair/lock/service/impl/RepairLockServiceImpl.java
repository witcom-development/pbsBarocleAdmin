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
package com.dkitec.barocle.admin.maintenance.repair.lock.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.common.service.CommonPopupMapper;
import com.dkitec.barocle.admin.maintenance.repair.lock.service.RepairLockMapper;
import com.dkitec.barocle.admin.maintenance.repair.lock.service.RepairLockService;
import com.dkitec.barocle.admin.maintenance.repair.lock.vo.RepairLockVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="repairLockService")
public class RepairLockServiceImpl extends EgovAbstractServiceImpl implements RepairLockService {

	@Autowired private RepairLockMapper repairLockMapper;
	@Autowired private CommonPopupMapper commonPopupMapper;
	@Autowired private TerminalMapper terminalMapper;

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<RepairLockVO> getRepairLockList(RepairLockVO repairLockVo) {
		// TODO Auto-generated method stub
		return repairLockMapper.getRepairLockList(repairLockVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getRepairLockListCount(RepairLockVO repairLockVo) {
		// TODO Auto-generated method stub
		return repairLockMapper.getRepairLockListCount(repairLockVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public RepairLockVO getRepairLockInfo(RepairLockVO repairLockVo) {
		// TODO Auto-generated method stub
		return repairLockMapper.getRepairLockInfo(repairLockVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<String> getRepairCodeList(String repairSeq) {
		// TODO Auto-generated method stub
		return repairLockMapper.getRepairCodeList(repairSeq);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public String getLockMoveYn(RepairLockVO repairLockVo){
		// TODO Auto-generated method stub
		return repairLockMapper.getLockMoveYn(repairLockVo);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int insertRepairLock(RepairLockVO repairLockVo){
		// TODO Auto-generated method stub
		System.out.println("repairLockVo.getViewFlg() : " + repairLockVo.getViewFlg());
		repairLockMapper.updateLockStatus(repairLockVo);
		if(!repairLockVo.getFaultSeq().equals("")){
			repairLockMapper.updateFaultLock(repairLockVo);
		}
		if(repairLockVo.getMoveYn().equals("Y")){
			repairLockMapper.updateLockMoveHistory(repairLockVo);
			repairLockMapper.insertLockMoveHistory(repairLockVo);
		}
		return repairLockMapper.insertRepairLock(repairLockVo);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int updateRepairLock(RepairLockVO repairLockVo){
		// TODO Auto-generated method stub
		repairLockMapper.updateLockStatus(repairLockVo);
		if(repairLockVo.getMoveYn().equals("Y")){
			repairLockMapper.updateLockMoveHistory(repairLockVo);
			repairLockMapper.insertLockMoveHistory(repairLockVo);
		}
		return repairLockMapper.updateRepairLock(repairLockVo);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int deleteRepairLock(RepairLockVO repairLockVo){
		// TODO Auto-generated method stub
		return repairLockMapper.deleteRepairLock(repairLockVo);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int insertRepairLockDetail(RepairLockVO repairLockVo){
		// TODO Auto-generated method stub
		return repairLockMapper.insertRepairLockDetail(repairLockVo);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int deleteRepairLockDetail(RepairLockVO repairLockVo){
		// TODO Auto-generated method stub
		return repairLockMapper.deleteRepairLockDetail(repairLockVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public RepairLockVO getRemainBikeYn(RepairLockVO repairLockVo) {
		// TODO Auto-generated method stub
		return repairLockMapper.getRemainBikeYn(repairLockVo);
	}
}
