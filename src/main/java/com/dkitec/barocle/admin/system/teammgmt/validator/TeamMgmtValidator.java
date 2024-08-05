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
package com.dkitec.barocle.admin.system.teammgmt.validator;

import org.springframework.stereotype.Service;

import com.dkitec.barocle.admin.system.teammgmt.vo.TeamMgmtVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.StringUtil;

import egovframework.rte.fdl.cmmn.exception.EgovBizException;

@Service("teamMgmtValidator")
public class TeamMgmtValidator extends BaseController {

	public boolean teamInfoCheck(TeamMgmtVO teamVO) throws Exception{
			boolean result = false;
			
			
			//필수 파라메터 체크: 팀 SEQ
			if(StringUtil.isEmpty(teamVO.getTeamSeq()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"배송 센터"}, null);
			
			result = true;
			
			return result;
	}

	public boolean teamInsertCheck(TeamMgmtVO teamVO) throws Exception{
			boolean result = false;
			
			//필수 파라메터 체크: 센터, 팀, 휴대폰 번호
			if(StringUtil.isEmpty(teamVO.getCenterId()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"배송 센터"}, null);
			
			if(StringUtil.isEmpty(teamVO.getTeamId()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"팀"}, null);
			
			if(StringUtil.isEmpty(teamVO.getMpnNo1()) && StringUtil.isEmpty(teamVO.getMpnNo2()) )		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"대표 전화번호"}, null);
			
			result = true;
			
			return result;
	}

	public boolean teamUpdateCheck(TeamMgmtVO teamVO) throws Exception{
			boolean result = false;

			//필수 파라메터 체크: 센터, 팀, 휴대폰 번호
			if(StringUtil.isEmpty(teamVO.getCenterId()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"배송 센터"}, null);
			
			if(StringUtil.isEmpty(teamVO.getTeamId()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"팀"}, null);
			
			if(StringUtil.isEmpty(teamVO.getMpnNo1()) && StringUtil.isEmpty(teamVO.getMpnNo2()) )		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"대표 전화번호"}, null);
			
			result = true;
			
			return result;
	}


}
