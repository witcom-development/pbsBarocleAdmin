package com.dkitec.barocle.admin.login.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.login.vo.LoginHistoryVO;
import com.dkitec.barocle.admin.login.vo.MenuAuthVO;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;

public interface LoginService extends UserDetailsService {
	public UserDetails loadUserByUsername(String usrId) throws UsernameNotFoundException;
	
	public UserSessionVO getLoginInfo(UserSessionVO userSessionVO) throws CfoodException;
	public int setLoginFailCnt(UserSessionVO userSessionVO) throws CfoodException;
	public int getLoginFailCnt(UserSessionVO userSessionVO) throws CfoodException;
	public int setLoginFailReset(UserSessionVO userSessionVO) throws CfoodException;
	public int addLoginHistory(UserSessionVO userSessionVO) throws CfoodException;
	public List<LoginHistoryVO> getLoginHistoryList(LoginHistoryVO loginHistoryVO) throws CfoodException;
	public int getLoginHistoryListCount(LoginHistoryVO loginHistoryVO) throws CfoodException;
	public ArrayList<MenuAuthVO> getMenuAuthList(MenuAuthVO menuAuthVo) throws CfoodException;
	public MenuAuthVO getMenuUrlAuth(MenuAuthVO menuAuthVo) throws CfoodException;
	public String getDGaurdEncodePassword(String tempPassword) throws CfoodException;
}
