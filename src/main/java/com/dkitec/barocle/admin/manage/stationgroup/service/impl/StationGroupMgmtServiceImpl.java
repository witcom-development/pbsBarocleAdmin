package com.dkitec.barocle.admin.manage.stationgroup.service.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.manage.stationgroup.service.StationGroupMgmtMapper;
import com.dkitec.barocle.admin.manage.stationgroup.service.StationGroupMgmtService;
import com.dkitec.barocle.admin.manage.stationgroup.vo.StationGroupMgmtVO;
import com.dkitec.barocle.admin.manage.stationmgmt.service.StationMgmtMapper;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("stationGroupMgmtService")
public class StationGroupMgmtServiceImpl extends EgovAbstractServiceImpl implements StationGroupMgmtService{

	@Autowired
	StationGroupMgmtMapper mapper;
	
	@Autowired
	StationMgmtMapper stationMapper;
	
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getStationGroupListCnt(StationGroupMgmtVO stationVo) {
		return mapper.getStationGroupListCnt(stationVo);
	}


	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<StationGroupMgmtVO> getStationGroupList(StationGroupMgmtVO stationVo) {
		return mapper.getStationGroupList(stationVo);
	}
	
	
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public String stationGroupNameCheck(StationGroupMgmtVO stationVo) {
		if(mapper.stationGroupNameCheck(stationVo) > 0){
			return "중복";
		}
		return IConstants.OK;
	}


	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public void stationGroupModify(StationGroupMgmtVO stationVo) {
		
		if(stationVo.getCmd().equals("INSERT")){
			logger.debug(stationVo);
			try {
				mapper.insertStationGroup(stationVo);
				logger.debug(stationVo);
				
				for(int i=0; i < stationVo.getCodeList().size(); i++){
					
					stationVo.setLang_cls_cd(stationVo.getCodeList().get(i)); 
					stationVo.setStation_grp_name(stationVo.getNameList().get(i));
					mapper.insertStationGroupName(stationVo);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				throw new CfoodException("admin.manage.stationgroup.stationGroupModify");
			}
		}else if(stationVo.getCmd().equals("UPDATE")){
			
			logger.debug("###########################UPDATE"+stationVo );
			try {
				
				mapper.updateStationGroup(stationVo);
				for(int i=0; i < stationVo.getCodeList().size(); i++){
					stationVo.setLang_cls_cd(stationVo.getCodeList().get(i)); 
					stationVo.setStation_grp_name(stationVo.getNameList().get(i));
					mapper.updateStationGroupName(stationVo);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				throw new CfoodException("admin.manage.stationgroup.stationGroupModify");
			}
			
		}else if(stationVo.getCmd().equals("DELETE")){
			
			logger.debug("DELETE");
			try {
				mapper.deleteStationGroupName(stationVo);
				mapper.deleteStationGroup(stationVo);
				
			} catch (Exception e) {
				e.printStackTrace();
				throw new CfoodException("admin.manage.stationgroup.stationGroupModify");
			}
		}
		
	}


	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public StationGroupMgmtVO getstationGroupInfo(StationGroupMgmtVO stationVo) {
		return mapper.getstationGroupInfo(stationVo);
	}


	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<StationGroupMgmtVO> getMultiStationGroupList(StationGroupMgmtVO stationVo) {
		return mapper.getMultiStationGroupList(stationVo);
	}



	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<StationGroupMgmtVO> getStationGroupNameList(StationGroupMgmtVO stationVo) {
		return mapper.getStationGroupNameList(stationVo);
	}

	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<StationGroupMgmtVO> getHumanStationGroupNameList(StationGroupMgmtVO stationVo) {
		return mapper.getHumanStationGroupNameList(stationVo);
	}
	
	
	
	

}
