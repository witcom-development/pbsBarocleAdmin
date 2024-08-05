/*
 * Copyright 2011 MOPAS(Ministry of Public Administration and Security).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.dkitec.barocle.admin.system.usermgmt.service.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.system.teammgmt.vo.TeamMgmtVO;
import com.dkitec.barocle.admin.system.usermgmt.controller.UserMgmtController;
import com.dkitec.barocle.admin.system.usermgmt.service.UserMgmtMapper;
import com.dkitec.barocle.admin.system.usermgmt.service.UserMgmtService;
import com.dkitec.barocle.admin.system.usermgmt.vo.UserMgmtVO;
import com.dkitec.barocle.datasource.AES256anicar;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.manage.stationmgmt.vo.StationMgmtVO;
import com.dkitec.barocle.base.IConstants;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 카테고리에 관한 비지니스클래스를 정의한다.
 * @author 실행환경 개발팀 신혜연
 * @since 2011.07.11
 * @version 1.0
 * @see 
 * <pre>
 *  == 개정이력(Modification Information) ==
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2011.07.11  신혜연          최초 생성
 * 
 * </pre>
 */
@Service("userMgmtService")
public class UserMgmtSeviceImpl extends EgovAbstractServiceImpl implements UserMgmtService {

    @Autowired private UserMgmtMapper userMapper; //데이터베이스 접근 클래스

	protected static Logger log = LoggerFactory.getLogger(UserMgmtController.class);
    
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<UserMgmtVO> getAdminManagerList(UserMgmtVO usrVO) throws Exception {
		
		List<UserMgmtVO> result = null;
		
			result = userMapper.getAdminManagerList(usrVO);
			
//			for(int i = 0; i < result.size(); i++){
//				log.debug(result.get(i).getPhoneNo());
//				log.debug(AES256anicar.decrypt(result.get(i).getPhoneNo()));
//				result.get(i).setPhoneNo(AES256anicar.decrypt(result.get(i).getPhoneNo()));
//			}

   		return result;
   		
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getAdminManagerCount(UserMgmtVO usrVO) throws Exception {
		
		int result = 0;
		
			
			result = userMapper.getAdminManagerCount(usrVO);

   		return result;
   		
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<UserMgmtVO> getAdminManagerPopList(UserMgmtVO usrVO) throws Exception {
		
		List<UserMgmtVO> result = null;
		
			result = userMapper.getAdminManagerPopList(usrVO);

   		return result;
   		
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getAdminManagerPopCount(UserMgmtVO usrVO) throws Exception {
		
		int result = 0;
		
			
			result = userMapper.getAdminManagerPopCount(usrVO);
			

   		return result;
   		
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public UserMgmtVO getUsrInfo(UserMgmtVO usrVO) throws Exception {
		
		UserMgmtVO result = null;
		
			
			result = userMapper.getUsrInfo(usrVO);
			
			/*if(result != null){
				result.setEmail(AES256anicar.decrypt(result.getEmail()));
				result.setPhoneNo(AES256anicar.decrypt(result.getPhoneNo()));
				result.setMpnNo(AES256anicar.decrypt(result.getMpnNo()));
			}*/
			

   		return result;
   		
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int usrIdCheck(UserMgmtVO usrVO) throws Exception {
		
		int result = 0;
		
			
			result = userMapper.idCheck(usrVO);
			

   		return result;
   		
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int insertUsr(UserMgmtVO usrVO) throws Exception {
		
		int result = 0;
		
			
			result = userMapper.insertUsr(usrVO);
			
			log.debug("##### impl ===> " + result);
			

   		return result;
   		
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int updateUsr(UserMgmtVO usrVO) throws Exception {
		
		int result = 0;
		
			
			result = userMapper.updateUsr(usrVO);
			/*로그인 실패 수 reset*/
			UserSessionVO userVO = new UserSessionVO();
			userVO.setUsrId(usrVO.getUsrId());
			/*loginDAO.updateLoginFailReset(userVO);*/

   		return result;
   		
	}

	@Override
	public String cardNumCheck(UserMgmtVO usrVO) throws Exception {
		String returnStr = IConstants.OK;
		if( userMapper.cardNumCheck(usrVO)>0){
			returnStr = "DUPLICATED_CARD";
		}else{
			if(userMapper.userCardNumCheck(usrVO) >0){
				returnStr = "REGISTERD_USER_CARD";
			}
		}
		
		return returnStr;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<UserMgmtVO> getAdminAllSmsList(UserMgmtVO usrVO) {
	     
		return userMapper.getAdminAllSmsList(usrVO);
	}

	/**
	 * 관리자 정보 삭제_20161026_JJH
	 */
	public int deleteAdminAjax(String param) {
		return userMapper.deleteAdminAjax(param);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int insertUsrHistory(UserMgmtVO usrVO) throws Exception {
		
		int result = 0;
		
			result = userMapper.insertUsrHistory(usrVO);
			/*로그인 실패 수 reset*/
			
			/*loginDAO.updateLoginFailReset(userVO);*/

   		return result;
   		
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<UserMgmtVO> getAdminUseList(UserMgmtVO usrVO) throws Exception {
		
		List<UserMgmtVO> result = null;
		
			
			result = userMapper.getAdminUseList(usrVO);
			
			

   		return result;
   		
	}
	
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<TeamMgmtVO> teamList(TeamMgmtVO teamVo) throws Exception {
		List<TeamMgmtVO> result = null;
		result = userMapper.teamList(teamVo);
		return result;
	}
}
