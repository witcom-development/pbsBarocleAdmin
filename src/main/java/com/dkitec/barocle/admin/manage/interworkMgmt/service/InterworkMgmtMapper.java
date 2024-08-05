package com.dkitec.barocle.admin.manage.interworkMgmt.service;

import java.util.List;
import java.util.Map;

import com.dkitec.barocle.admin.manage.interworkMgmt.vo.InterworkMgmtVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("interworkMgmtMapper")
public interface InterworkMgmtMapper {

	public List<InterworkMgmtVO> listCritical();
	public int modCritical(InterworkMgmtVO interworkMgmtVO);
	
	public List<InterworkMgmtVO> listFirmware(InterworkMgmtVO interworkMgmtVO);
	public int listFirmwareCount(InterworkMgmtVO interworkMgmtVO);
	public List<InterworkMgmtVO> listFirmwareUpdateResult(InterworkMgmtVO interworkMgmtVO);
	public int listFirmwareUpdateResultCount(InterworkMgmtVO interworkMgmtVO);
	public InterworkMgmtVO getFirmware(InterworkMgmtVO interworkMgmtVO);
	public List<InterworkMgmtVO> listFirmwareFile(InterworkMgmtVO interworkMgmtVO);
	public int updateStartYn(InterworkMgmtVO interworkMgmtVO);
	
	public int insertFirmware(InterworkMgmtVO interworkMgmtVO);
	public int insertFirmwareFile(InterworkMgmtVO interworkMgmtVO);
	public int insertFirmwareFileList(Map<String,List<InterworkMgmtVO>> map);
	public int chkFirmwareVer(InterworkMgmtVO interworkMgmtVO);
	
	public int modFirmware(InterworkMgmtVO interworkMgmtVO);
	public int modFirmwareFile(InterworkMgmtVO interworkMgmtVO);
	public int modFirmwareBinSize(String firmwareSeq);

	public int delFirmware(InterworkMgmtVO interworkMgmtVO);
	public int delFirmwareFile(InterworkMgmtVO interworkMgmtVO);
}
