package com.dkitec.barocle.admin.manage.stationgroup.service;

import java.util.List;

import com.dkitec.barocle.admin.manage.stationgroup.vo.StationGroupMgmtVO;

public interface StationGroupMgmtService {

	public int getStationGroupListCnt(StationGroupMgmtVO stationVo);

	public List<StationGroupMgmtVO> getStationGroupList(StationGroupMgmtVO stationVo);

	public void stationGroupModify(StationGroupMgmtVO stationVo);

	public String stationGroupNameCheck(StationGroupMgmtVO stationVo);

	public StationGroupMgmtVO getstationGroupInfo(StationGroupMgmtVO stationVo);

	public List<StationGroupMgmtVO> getMultiStationGroupList(StationGroupMgmtVO stationVo);

	public List<StationGroupMgmtVO> getStationGroupNameList(StationGroupMgmtVO stationVo);
	
	public List<StationGroupMgmtVO> getHumanStationGroupNameList(StationGroupMgmtVO stationVo);

}
