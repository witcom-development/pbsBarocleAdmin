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
package com.dkitec.barocle.admin.system.teammgmt.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.admin.system.teammgmt.service.TeamMgmtMapper;
import com.dkitec.barocle.admin.system.teammgmt.service.TeamMgmtService;
import com.dkitec.barocle.admin.system.teammgmt.vo.TeamMgmtVO;
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
@Service("teamMgmtService")
public class TeamMgmtServiceImpl extends EgovAbstractServiceImpl implements TeamMgmtService {

	@Autowired private TeamMgmtMapper teamMapper; //데이터베이스 접근 클래스
    
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<TeamMgmtVO> selectTeamList(TeamMgmtVO teamVO) throws Exception {
		
		List<TeamMgmtVO> result = null;
		
		result = teamMapper.getTeamList(teamVO);

   		return result;
   		
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<TeamMgmtVO> getTeamList(TeamMgmtVO teamVO) throws Exception {
		
		List<TeamMgmtVO> result = null;
		
		result = teamMapper.getTeamList(teamVO);
			
   		return result;
   		
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getTeamCount(TeamMgmtVO teamVO) throws Exception {
		
		int result = 0;
		
		result = teamMapper.getTeamCount(teamVO);
			

   		return result;
   		
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public TeamMgmtVO getTeamInfo(TeamMgmtVO teamVO) throws Exception {
		
		TeamMgmtVO result = null;
		
			
			result = teamMapper.getTeamInfo(teamVO);

   		return result;
   		
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int insertTeam(TeamMgmtVO teamVO) throws Exception {
		
		int result = 0;
		
			
			result = teamMapper.insertTeam(teamVO);
			

   		return result;
   		
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int updateTeam(TeamMgmtVO teamVO) throws Exception {

		int result = 0;
		
			
			result = teamMapper.updateTeam(teamVO);
			

   		return result;
   		
	}



	@Override
	public int deleteTeam(TeamMgmtVO teamVO) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<TeamMgmtVO> getTeamNameList(TeamMgmtVO teamVO) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
}
