package com.dkitec.barocle.admin.manage.stationmgmt.service;

import java.util.List;
import java.util.Map;

import com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService;
import com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO;
import com.dkitec.barocle.admin.manage.stationgroup.vo.StationGroupMgmtVO;
import com.dkitec.barocle.admin.manage.stationmgmt.vo.StationMgmtVO;
import com.dkitec.barocle.admin.repairBikeMall.manageMall.vo.ManageMallVo;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.barocle.util.sms.vo.SmsMessageVO;

public interface StationMgmtService {

	public void stationGroupModify(StationMgmtVO stationVo, ApService apService);
	public void stationGrpRemoteReturnGroupModify(StationMgmtVO stationVo);
	public void insertStationGrpRemoteReturnInfo(StationMgmtVO stationVo);
	public void updateStationGrpRemoteReturnInfo(StationMgmtVO stationVo);
	
	
	//public void stationGroupModify(StationMgmtVO stationVo);

	public String stationNumberCheck(StationMgmtVO stationVo);
	
	public String remoteStationNumberCheck(StationMgmtVO stationVo);

	public List<StationMgmtVO> getGroupStationList(StationMgmtVO vo);

	public List<ApVO> getApList();

	public int getStationListCnt(StationMgmtVO stationVo);
	public int getStationGrpRemoteReturnListCnt(StationMgmtVO stationVo);
	public List<StationMgmtVO> getStationList(StationMgmtVO stationVo);
	public List<StationMgmtVO> getStationGrpRemoteReturnList(StationMgmtVO stationVo);
	public List<StationMgmtVO> getStationGrpRemoteReturnList1(StationMgmtVO stationVo);
	
	public StationMgmtVO getStationInfo(StationGroupMgmtVO stationVo);
	public StationMgmtVO getStationGrpRemoteReturnInfo(StationGroupMgmtVO stationVo);
	public StationMgmtVO getStationGrpRemoteReturnInfo1(StationMgmtVO stationVo);
	
	public List<StationMgmtVO> getStationNameInfo(StationGroupMgmtVO stationVo);
	
	public List<StationMgmtVO> groupStationList(StationMgmtVO stationVo);
	
	public int getStationUseListCnt(StationMgmtVO vo);
	
	public List<StationMgmtVO> getStationUseList(StationMgmtVO vo);
	
	public String beaconCheck(StationMgmtVO stationVo);

	public void stationGroupModify05(StationMgmtVO stationVo);

	public void updateStation05(StationMgmtVO stationVo);

	public int addTmpCloseSmsHist(StationMgmtVO stationVo);

	public void addTmpCloseNoti(StationMgmtVO stationVo);

	public void addTmpCloseSms(SmsMessageVO smsMsgVo);

	public List<SmsMessageVO> getUsrList(StationMgmtVO stationVo);

	public void NoTmpCloseNoti(StationMgmtVO stationVo);

	public void deleteTmpCloseSms(SmsMessageVO smsMsgVo);

	public void addTmpCloseSmsDtl(SmsMessageVO smsMsgVo);

	public void editTmpCloseNoti(StationMgmtVO stationVo);

	public void insertTmpCloseSmsAdm(StationMgmtVO stationVo);
	
	// 20210118
	public int getStationNotiCnt(StationMgmtVO stationVo);
	public void deleteTbOprStationNoti(StationMgmtVO stationVo);
	public void insertTbOprStationNoti(StationMgmtVO stationVo);
	public void insertTB_OPR_RACK_LOCATE_INFO(StationMgmtVO stationVo);
	
}