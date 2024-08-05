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
package com.dkitec.barocle.admin.system.usergroupmgmt.service;

import java.util.List;

import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.admin.system.usergroupmgmt.vo.UserGroupMgmtVO;

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
public interface UserGroupMgmtService {

	List<UserGroupMgmtVO> selectGroList(UserGroupMgmtVO groVO) throws Exception;
	
	List<UserGroupMgmtVO> getGroupNameList(UserGroupMgmtVO groVO) throws Exception;

	List<UserGroupMgmtVO> getGroList(UserGroupMgmtVO groVO) throws Exception;

	int getGroCount(UserGroupMgmtVO groVO) throws Exception;

	//List<GroVO> getGroList(GroVO groVO) throws Exception;
	
	UserGroupMgmtVO getGroInfo(UserGroupMgmtVO groVO) throws Exception;

	int insertGro(UserGroupMgmtVO groVO) throws Exception;

	int updateGro(UserGroupMgmtVO groVO) throws Exception;

	int deleteGro(UserGroupMgmtVO groVO) throws Exception;
	
	List<UserGroupMgmtVO> getAdminGroCodeList() throws Exception;

	List<UserGroupMgmtVO> getPatnrGroCodeList() throws Exception;
	
	List<CommonCodeVO> getGroCdList() throws Exception;
}
