/*
 * Copyright 2008-2009 the original author or authors.
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
package com.dkitec.barocle.admin.system.usergroupmgmt.validator;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO;
import com.dkitec.barocle.admin.system.usergroupmgmt.vo.UserGroupMgmtVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.StringUtil;

import egovframework.rte.fdl.cmmn.exception.EgovBizException;

@Service("userGroupMgmtValidator")
public class UserGroupMgmtValidator extends BaseController {

	public boolean groInfoCheck(UserGroupMgmtVO groVO) throws Exception{
			boolean result = false;
			
			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(groVO.getUsrGrpCd()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"그룹등급"}, null);
			
			result = true;
			
			return result;
	}

	public boolean groInsertCheck(UserGroupMgmtVO groVO) throws Exception{
			boolean result = false;
			
			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(groVO.getUsrGrpCd()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"그룹등급"}, null);
			
			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(groVO.getGrpName()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"권한명"}, null);

			result = true;
			
			return result;
	}

	public boolean groUpdateCheck(UserGroupMgmtVO groVO) throws Exception{
			boolean result = false;

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(groVO.getUsrGrpCd()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"그룹등급"}, null);
			
			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(groVO.getGrpName()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"권한명"}, null);

			result = true;
			
			return result;
	}

	public boolean groDeleteCheck(UserGroupMgmtVO groVO) throws Exception{
			boolean result = false;

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(groVO.getUsrGrpCd()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"그룹등급"}, null);
			
			result = true;
			
			return result;
	}

	public boolean groMenuCheck(UserGroupMgmtVO groVO, MenuMgmtVO menuVO) throws Exception{
			boolean result = false;

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(groVO.getUsrGrpCd()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"그룹등급"}, null);
			
			//필수 파라메터 체크: 제목, 발송범위, 내용
			List<MenuMgmtVO> grpMenuList = menuVO.getMenuGrpList();
			
			if(grpMenuList != null && grpMenuList.size() > 0){
				for(int i = 0; i < grpMenuList.size(); i++){
					if(StringUtil.isEmpty(grpMenuList.get(i).getReadYn()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"메뉴 읽기 권한 정보"}, null);
					if(StringUtil.isEmpty(grpMenuList.get(i).getCreYn()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"메뉴 등록 권한 정보"}, null);
					if(StringUtil.isEmpty(grpMenuList.get(i).getUpdateYn()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"메뉴 수정 권한 정보"}, null);
					if(StringUtil.isEmpty(grpMenuList.get(i).getDelYn()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"메뉴 삭제 권한 정보"}, null);
				}
			}
			
			
			result = true;
			
			return result;
	}

}
