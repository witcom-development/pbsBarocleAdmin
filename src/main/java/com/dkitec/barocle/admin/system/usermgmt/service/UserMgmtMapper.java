package com.dkitec.barocle.admin.system.usermgmt.service;

import java.util.List;

import com.dkitec.barocle.admin.system.teammgmt.vo.TeamMgmtVO;
import com.dkitec.barocle.admin.system.usermgmt.vo.UserMgmtVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("UserMgmtMapper")
public interface UserMgmtMapper {

	
	public int insertUsr(UserMgmtVO usrVO);

	public int updateUsr(UserMgmtVO usrVO);
	
	public int idCheck(UserMgmtVO usrVO);
	
	public List<UserMgmtVO> getAdminManagerList(UserMgmtVO usrVO);
	
	public int getAdminManagerCount(UserMgmtVO usrVO);
	
	public List<UserMgmtVO> getAdminManagerPopList(UserMgmtVO usrVO);
	
	public int getAdminManagerPopCount(UserMgmtVO usrVO);

	public UserMgmtVO getUsrInfo(UserMgmtVO usrVO);
	
	int cardNumCheck(UserMgmtVO usrVO) throws Exception;
	
	int userCardNumCheck(UserMgmtVO usrVO) throws Exception;

	public List<UserMgmtVO> getAdminAllSmsList(UserMgmtVO usrVO);
	
	public int deleteAdminAjax(String adminID);	// 관리자 정보 삭제_20161026_JJH
	
	public int insertUsrHistory(UserMgmtVO usrVO) throws Exception;
	
	public List<UserMgmtVO> getAdminUseList(UserMgmtVO usrVO) throws Exception;
	
	public List<TeamMgmtVO> teamList(TeamMgmtVO teamVO) throws Exception;
	
}
