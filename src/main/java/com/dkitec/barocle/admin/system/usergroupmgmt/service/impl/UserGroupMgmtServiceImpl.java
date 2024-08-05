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
package com.dkitec.barocle.admin.system.usergroupmgmt.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.admin.system.usergroupmgmt.service.UserGroupMgmtMapper;
import com.dkitec.barocle.admin.system.usergroupmgmt.service.UserGroupMgmtService;
import com.dkitec.barocle.admin.system.usergroupmgmt.vo.UserGroupMgmtVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

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
@Service("userGroupMgmtService")
public class UserGroupMgmtServiceImpl extends EgovAbstractServiceImpl implements UserGroupMgmtService {

	@Autowired private UserGroupMgmtMapper groupMapper; //데이터베이스 접근 클래스
    

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<UserGroupMgmtVO> selectGroList(UserGroupMgmtVO groVO) throws Exception {
		
		List<UserGroupMgmtVO> result = null;
		
		result = groupMapper.getGroList(groVO);

   		return result;
   		
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<UserGroupMgmtVO> getGroList(UserGroupMgmtVO groVO) throws Exception {
		
		List<UserGroupMgmtVO> result = null;
		
		result = groupMapper.getGroList(groVO);
			
   		return result;
   		
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<UserGroupMgmtVO> getGroupNameList(UserGroupMgmtVO groVO) throws Exception {
		
		List<UserGroupMgmtVO> result = null;
		
		result = groupMapper.getGroupNameList(groVO);
		
		return result;
		
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getGroCount(UserGroupMgmtVO groVO) throws Exception {
		
		int result = 0;
		
		result = groupMapper.getGroCount(groVO);
			

   		return result;
   		
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public UserGroupMgmtVO getGroInfo(UserGroupMgmtVO groVO) throws Exception {
		
		UserGroupMgmtVO result = null;
		
			
			result = groupMapper.getGroInfo(groVO);

   		return result;
   		
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int insertGro(UserGroupMgmtVO groVO) throws Exception {
		
		int result = 0;
		
			
			result = groupMapper.insertGro(groVO);
			

   		return result;
   		
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int updateGro(UserGroupMgmtVO groVO) throws Exception {

		int result = 0;
		
			
			result = groupMapper.updateGro(groVO);
			

   		return result;
   		
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int deleteGro(UserGroupMgmtVO groVO) throws Exception {

		int result = 0;
		
			
			result = groupMapper.deleteGroAuth(groVO);
			
			result = groupMapper.deleteGro(groVO);
			

   		return result;
   		
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<UserGroupMgmtVO> getAdminGroCodeList() throws Exception{
		
		List<UserGroupMgmtVO> result = null;
		
			
			result = groupMapper.getAdminGroCodeList();
			

   		return result;
   		
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<UserGroupMgmtVO> getPatnrGroCodeList() throws Exception {
		List<UserGroupMgmtVO> result = null;
		
			
			result = groupMapper.getPatnrGroCodeList();
			

   		return result;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<CommonCodeVO> getGroCdList() throws Exception {
		List<CommonCodeVO> result = null;
		
			
			result = groupMapper.getGroCdList();
			

   		return result;
	}
}
