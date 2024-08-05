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
package com.dkitec.barocle.admin.system.MenuMgmt.validator;

import java.util.List;

import com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO;
import com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuUrlVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.StringUtil;

import egovframework.rte.fdl.cmmn.exception.EgovBizException;
public class MenuValidator extends BaseController {
	
	public boolean upperMenuPopCheck(MenuMgmtVO menuVO) throws Exception{
			boolean result = false;
			
			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(menuVO.getMenuCd()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"메뉴코드"}, null);
			
			result = true;
			
			return result;
	}

	public boolean menuUpdateCheck(MenuMgmtVO menuVO) throws Exception{
			boolean result = false;

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(menuVO.getMenuCd()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"메뉴코드"}, null);
			
			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(menuVO.getMenuName()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"메뉴명"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(menuVO.getUpMenu()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"상위코드"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(menuVO.getMenuLevel()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"메뉴 레벨"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(menuVO.getMenuOrd()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"메뉴 순서"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(menuVO.getRegUsrId()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"생성자 ID"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(menuVO.getHiddenYn()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"히든 여부"}, null);

			result = true;
			
			return result;
	}

	public boolean menuInsertCheck(MenuMgmtVO menuVO) throws Exception{
			boolean result = false;

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(menuVO.getMenuCd()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"메뉴코드"}, null);
			
			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(menuVO.getMenuName()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"메뉴명"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(menuVO.getUpMenu()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"상위코드"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(menuVO.getMenuLevel()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"메뉴 레벨"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(menuVO.getRegUsrId()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"생성자 ID"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(menuVO.getHiddenYn()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"히든 여부"}, null);

			result = true;
			
			return result;
	}

	public boolean menuUnderCountCheck(MenuMgmtVO menuVO) throws Exception{
			boolean result = false;
			
			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(menuVO.getMenuCd()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"메뉴코드"}, null);
			
			result = true;
			
			return result;
	}

	public boolean menuDeleteCheck(MenuMgmtVO menuVO) throws Exception{
			boolean result = false;
			
			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(menuVO.getMenuCd()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"메뉴코드"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(menuVO.getDownCnt() > 0)		throw new EgovBizException(messageSource, "fail.input.emptyValue2", null);
			
			result = true;
			
			return result;
	}

	public boolean getMenuUrlCheck(MenuMgmtVO menuVO) throws Exception{
			boolean result = false;
			
			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(menuVO.getMenuCd()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"메뉴코드"}, null);
			
			result = true;
			
			return result;
	}

	public boolean menuUrlUpdateCheck(MenuUrlVO menuUrlVO) throws Exception{
			boolean result = false;
			
			List<MenuUrlVO> menuUrlList = menuUrlVO.getUrlList();
			
			if(menuUrlList != null && menuUrlList.size() > 0){
				for(int i = 0; i < menuUrlList.size(); i++){

					if(StringUtil.isEmpty(menuUrlList.get(i).getMenuCd()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"메뉴코드"}, null);		
					if(StringUtil.isEmpty(menuUrlList.get(i).getMenuUrl()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"메뉴 URL"}, null);
					if(StringUtil.isEmpty(menuUrlList.get(i).getMenuCrud()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"메뉴 CRUD"}, null);
					
				}
			}
			
			result = true;
			
			return result;
	}

}
