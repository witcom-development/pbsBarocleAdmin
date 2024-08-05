package com.dkitec.barocle.admin.maintenance.distMgmt.distAction.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.maintenance.distMgmt.distAction.service.DistActionMapper;
import com.dkitec.barocle.admin.maintenance.distMgmt.distAction.service.DistActionService;
import com.dkitec.barocle.admin.maintenance.distMgmt.distAction.vo.DistActionListVO;
import com.dkitec.barocle.admin.maintenance.distMgmt.distAction.vo.DistActionVO;
import com.dkitec.barocle.admin.maintenance.repair.bike.service.RepairBikeService;
import com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO;
import com.dkitec.barocle.admin.status.rentStatus.service.RentStatusService;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="distActionService")
public class DistActionServiceImpl extends EgovAbstractServiceImpl implements DistActionService {

	@Autowired private DistActionMapper distActionMapper;
	
	@Resource(name="repairBikeService") private RepairBikeService repairBikeService;
	@Resource(name="rentStatusService") private RentStatusService rentStatusService;

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)	
	public String distActionInsert(DistActionVO distActionVO) {
		
		String result = "Fail";
		
		RepairBikeVO rBikeVO = new RepairBikeVO();
		rBikeVO.setBikeNo(distActionVO.getBikeNo());
		
		String bikeStusCd = repairBikeService.getBikeStatusCd(rBikeVO);
		
		if(bikeStusCd != null){
			
			distActionMapper.insertDistAct(distActionVO);
			result = "Success";
			
/*			
			if(distActionVO.getActSeq() != null && !"".equals(distActionVO.getActSeq())){
				
				distActionMapper.insertDistActDtl(distActionVO);
				
				if(distActionVO.getDtlSeq() != null && !"".equals(distActionVO.getDtlSeq())){
					
				}
			}
 */
		}
		
		// 자전거 상태 
		if("Success".equals(result)){
			distActionVO.setBikeStusCd("BKS_013");	
			setBikeStusCd(distActionVO);
			
			String faultSeq = getBikeFault(distActionVO);
			if(!"N".equals(faultSeq)){
				distActionVO.setFaultSeq(faultSeq);
				updateFaultType(distActionVO);
			}
			
			/*
			if("A".equals(distActionVO.getActType())){
				
				distActionVO.setBikeStusCd("BKS_003");
				
			}else if("B".equals(distActionVO.getActType())){
				
				distActionVO.setBikeStusCd("BKS_005");
			}
			
			setBikeStusCd(distActionVO);
			
			String faultSeq = getBikeFault(distActionVO);
			if(!"N".equals(faultSeq)){
				
				distActionVO.setFaultSeq(faultSeq);
				updateFaultType(distActionVO);
			}
			*/
		}
		
		return result;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)	
	public void insertDistAct(DistActionVO distActionVO){
		distActionMapper.insertDistAct(distActionVO);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)	
	public void insertDistActDtl(DistActionVO distActionVO){
		distActionMapper.insertDistActDtl(distActionVO);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)	
	public void setBikeStusCd(DistActionVO distActionVO){
		distActionMapper.setBikeStusCd(distActionVO);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)	
	public void updateFaultType(DistActionVO distActionVO){
		distActionMapper.updateFaultType(distActionVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)	
	public String getBikeFault(DistActionVO distActionVO){
		return distActionMapper.getBikeFault(distActionVO);
	}
	
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)	
	public List<DistActionListVO> distActionSelect(DistActionListVO vo){
		return distActionMapper.distActionSelect(vo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)	
	public int distActionListCnt(DistActionListVO vo){
		return distActionMapper.distActionListCnt(vo);
	}
	 
	
}
