package com.dkitec.barocle.admin.login.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.login.service.LoginMapper;
import com.dkitec.barocle.admin.login.service.LoginService;
import com.dkitec.barocle.admin.login.vo.LoginHistoryVO;
import com.dkitec.barocle.admin.login.vo.MenuAuthVO;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service("loginService")
public class LoginServiceImpl implements LoginService {
	
	@Autowired LoginMapper loginMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public UserDetails loadUserByUsername(String usrId) throws UsernameNotFoundException {
		
		UserDetails userDetails = null;
		
		UserSessionVO userSessionVO = loginMapper.getLoginInfo(usrId);
		
		if(userSessionVO != null){
			
			String password = userSessionVO.getEncPasswd();
			List<GrantedAuthority> list = new ArrayList<GrantedAuthority>();
	
			String[]roles = userSessionVO.getUsrGrpCd().split(",");
			
			byte b;
		    int i;
		    String[] arrayOfString1;
		    
		    for (i = (arrayOfString1 = roles).length, b = 0; b < i; ) {
		    	
		      String role = arrayOfString1[b];
		      
		      list.add(new SimpleGrantedAuthority(role));
		      
		      b++;
		      
		    } 
		    
			userDetails = new User(usrId, password, list);
			
		}
		
		if(userDetails == null) throw new UsernameNotFoundException("사용자를 알 수 없습니다.");
		
		return userDetails;
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public UserSessionVO getLoginInfo(UserSessionVO userSessionVO) throws CfoodException {
		return loginMapper.getLoginInfo(userSessionVO.getUsrId());
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int setLoginFailCnt(UserSessionVO userSessionVO) throws CfoodException {
		return loginMapper.setLoginFailCnt(userSessionVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getLoginFailCnt(UserSessionVO userSessionVO) throws CfoodException {
		return loginMapper.getLoginFailCnt(userSessionVO);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int setLoginFailReset(UserSessionVO userSessionVO) throws CfoodException {
		return loginMapper.setLoginFailReset(userSessionVO);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int addLoginHistory(UserSessionVO userSessionVO) throws CfoodException {
		return loginMapper.addLoginHistory(userSessionVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<LoginHistoryVO> getLoginHistoryList(LoginHistoryVO loginHistoryVO) throws CfoodException {
		return loginMapper.getLoginHistoryList(loginHistoryVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getLoginHistoryListCount(LoginHistoryVO loginHistoryVO) throws CfoodException {
		return loginMapper.getLoginHistoryListCount(loginHistoryVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public ArrayList<MenuAuthVO> getMenuAuthList(MenuAuthVO menuAuthVo) {
   		return loginMapper.getMenuAuthList(menuAuthVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public MenuAuthVO getMenuUrlAuth(MenuAuthVO menuAuthVo) {
   		return loginMapper.getMenuUrlAuth(menuAuthVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public String getDGaurdEncodePassword(String tempPassword) {
		return loginMapper.getDGaurdEncodePassword(tempPassword);
	}
	
}
