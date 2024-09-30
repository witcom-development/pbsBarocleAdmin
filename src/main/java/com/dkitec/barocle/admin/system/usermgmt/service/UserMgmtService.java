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
package com.dkitec.barocle.admin.system.usermgmt.service;

import java.util.List;

import com.dkitec.barocle.admin.system.teammgmt.vo.TeamMgmtVO;
import com.dkitec.barocle.admin.system.usermgmt.vo.UserMgmtVO;

/**
 * 카테고리에 관한 인터페이스클래스를 정의한다.
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
public interface UserMgmtService {

	List<UserMgmtVO> getAdminManagerList(UserMgmtVO usrVO) throws Exception;
	
	int getAdminManagerCount(UserMgmtVO usrVO) throws Exception;
	
	List<UserMgmtVO> getAdminManagerPopList(UserMgmtVO usrVO) throws Exception;
	
	int getAdminManagerPopCount(UserMgmtVO usrVO) throws Exception;

	UserMgmtVO getUsrInfo(UserMgmtVO usrVO) throws Exception;
	
	int usrIdCheck(UserMgmtVO usrVO) throws Exception;

	int insertUsr(UserMgmtVO usrVO) throws Exception;
	
	int updateUsr(UserMgmtVO usrVO) throws Exception;
	
	String cardNumCheck(UserMgmtVO usrVO) throws Exception;

	List<UserMgmtVO> getAdminAllSmsList(UserMgmtVO usrVO);
	
	//int deleteUsr(UsrVO usrVO) throws Exception;
	
	int deleteAdminAjax(String param);	// 관리자정보 삭제_20161026_JJH
	
	public int insertUsrHistory(UserMgmtVO usrVO) throws Exception;

	List<UserMgmtVO> getAdminUseList(UserMgmtVO usrVO) throws Exception;

	List<TeamMgmtVO> teamList(TeamMgmtVO stationVo) throws Exception;
	
	List<UserMgmtVO> getAptGrpList() throws Exception;
	
}
