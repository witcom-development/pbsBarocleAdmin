package com.dkitec.barocle.admin.manage.stationmgmt.service;

import java.util.List;
import java.util.Map;

import com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO;
import com.dkitec.barocle.admin.manage.stationgroup.vo.StationGroupMgmtVO;
import com.dkitec.barocle.admin.manage.stationmgmt.vo.StationMgmtVO;
import com.dkitec.barocle.util.sms.vo.SmsMessageVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("stationMgmtMapper")
public interface StationMgmtMapper {

	public int stationNumberCheck(StationMgmtVO stationVo);
	public int stationDuplNameCheck(StationMgmtVO stationVo);
	public int getStationNo(StationMgmtVO stationVo);
	public int getStationGrpRemoteReturnNo(StationMgmtVO stationVo);
	public List<StationMgmtVO> getGroupStationList(StationMgmtVO vo);
	public List<ApVO> getApList();
	public void insertStation(StationMgmtVO stationVo);
	public void insertStationGrpRemoteReturn(StationMgmtVO stationVo);
	public void insertStationName(StationMgmtVO stationVo);
	public void insertStationGrpRemoteReturnName(StationMgmtVO stationVo);
	public int getStationListCnt(StationMgmtVO stationVo);
	public int getStationGrpRemoteReturnListCnt(StationMgmtVO stationVo);
	public List<StationMgmtVO> getStationList(StationMgmtVO stationVo);
	public List<StationMgmtVO> getStationGrpRemoteReturnList(StationMgmtVO stationVo);
	public List<StationMgmtVO> getStationGrpRemoteReturnList1(StationMgmtVO stationVo);
	public void updateApHist(ApVO apVo);
	public StationMgmtVO getStationInfo(StationMgmtVO vo);
	public StationMgmtVO getStationGrpRemoteReturnInfo(StationMgmtVO vo);
	public List<StationMgmtVO> getStationNameInfo(StationMgmtVO vo);
	public String getStationRockCnt(StationMgmtVO vo);
	public String getStationDeviceID(StationMgmtVO vo);
	public void updateStation(StationMgmtVO stationVo);
	public void updateStationGrpRemoteReturn(StationMgmtVO stationVo);
	public void updateStationName(StationMgmtVO stationVo);
	public void updateStationGrpRemoteReturnName(StationMgmtVO stationVo);
	public String getCenterId();
	public List<StationMgmtVO> groupStationList(StationMgmtVO stationVo);
	public void deleteStation(StationMgmtVO stationVo);
	public void deleteStationGrpRemoteReturn(StationMgmtVO stationVo);
	public void deleteStationName(StationMgmtVO stationVo);
	public void insertStationHist(StationMgmtVO stationVo);
	public int getStationUseListCnt(StationMgmtVO stationVo);
	public List<StationMgmtVO> getStationUseList(StationMgmtVO stationVo);
	public void updateStationVersion(StationMgmtVO stationVo);
	public void insertStationVersion(StationMgmtVO stationVo);
	public void insertNewStationRack1(StationMgmtVO stationVo);
	public void insertNewStationRack2(StationMgmtVO stationVo);
	public void updateStation05(StationMgmtVO stationVo);
	public void stationGroupModify(StationMgmtVO stationVo);
	public void stationGroupModify05(StationMgmtVO stationVo);
	public int addTmpCloseSmsHist(StationMgmtVO stationVo);
	public void addTmpCloseNoti(StationMgmtVO stationVo);
	public void editTmpCloseNoti(StationMgmtVO stationVo);
	public void addTmpCloseSms(SmsMessageVO smsMsgVo);
	public void addTmpCloseSmsDtl(SmsMessageVO smsMsgVo);
	public void NoTmpCloseNoti(StationMgmtVO stationVo);
	public List<SmsMessageVO> getUsrList(StationMgmtVO stationVo);
	public void insertTmpCloseSmsAdm(StationMgmtVO stationVo);
	public void deleteTmpCloseSms(SmsMessageVO smsMsgVo);
	public int getStationNotiCnt(StationMgmtVO stationVo); // 20210118
	public void deleteTbOprStationNoti(StationMgmtVO stationVo); 
	public void insertTbOprStationNoti(StationMgmtVO stationVo);
	public void insertTB_OPR_RACK_LOCATE_INFO(StationMgmtVO stationVo);
}