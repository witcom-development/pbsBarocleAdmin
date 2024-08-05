package com.dkitec.barocle.admin.login.service;

import java.util.ArrayList;
import java.util.List;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.login.vo.LoginHistoryVO;
import com.dkitec.barocle.admin.login.vo.MenuAuthVO;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("loginMapper")
public interface LoginMapper {
	public UserSessionVO getLoginInfo(String usrId);
	public int setLoginFailCnt(UserSessionVO userSessionVO);
	public int getLoginFailCnt(UserSessionVO userSessionVO);
	public int setLoginFailReset(UserSessionVO userSessionVO);
	public int addLoginHistory(UserSessionVO userSessionVO);
	public List<LoginHistoryVO> getLoginHistoryList(LoginHistoryVO loginHistoryVO);
	public int getLoginHistoryListCount(LoginHistoryVO loginHistoryVO);
	public ArrayList<MenuAuthVO> getMenuAuthList(MenuAuthVO menuAuthVo);
	public MenuAuthVO getMenuUrlAuth(MenuAuthVO menuAuthVo);
	public String getDGaurdEncodePassword(String tempPassword);
}
