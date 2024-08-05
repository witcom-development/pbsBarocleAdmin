package com.dkitec.barocle.admin.manage.stationgroup.service;

import java.util.List;

import com.dkitec.barocle.admin.manage.stationgroup.vo.StationGroupMgmtVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("stationGroupMgmtMapper")
public interface StationGroupMgmtMapper {

	public int getStationGroupListCnt(StationGroupMgmtVO stationVo);

	public List<StationGroupMgmtVO> getStationGroupList(StationGroupMgmtVO stationVo);

	public int stationGroupNameCheck(StationGroupMgmtVO stationVo);

	public void insertStationGroup(StationGroupMgmtVO stationVo);

	public void insertStationGroupName(StationGroupMgmtVO stationVo);

	public StationGroupMgmtVO getstationGroupInfo(StationGroupMgmtVO stationVo);

	public List<StationGroupMgmtVO> getMultiStationGroupList(StationGroupMgmtVO stationVo);

	public void deleteStationGroupName(StationGroupMgmtVO stationVo);

	public void deleteStationGroup(StationGroupMgmtVO stationVo);

	public void updateStationGroup(StationGroupMgmtVO stationVo);

	public void updateStationGroupName(StationGroupMgmtVO stationVo);

	public List<StationGroupMgmtVO> getStationGroupNameList(StationGroupMgmtVO stationVo);

	public List<StationGroupMgmtVO> getHumanStationGroupNameList(StationGroupMgmtVO stationVo);
	
}
