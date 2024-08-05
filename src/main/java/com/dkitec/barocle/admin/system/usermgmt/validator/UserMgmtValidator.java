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
package com.dkitec.barocle.admin.system.usermgmt.validator;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dkitec.barocle.admin.system.usergroupmgmt.vo.UserGroupMgmtVO;
import com.dkitec.barocle.admin.system.usermgmt.vo.UserMgmtVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.StringUtil;

import egovframework.rte.fdl.cmmn.exception.EgovBizException;

@Service("userMgmtValidator")
public class UserMgmtValidator extends BaseController {

	public boolean usrInfoCheck(UserMgmtVO usrVO) throws Exception{
			boolean result = false;

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(usrVO.getUsrId()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"아이디"}, null);
			
			result = true;
			
			return result;
	}

	public boolean usrIdCheck(UserMgmtVO usrVO) throws Exception{
			boolean result = false;

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(usrVO.getUsrId()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"아이디"}, null);
			else if(!StringUtil.isUsrId(usrVO.getUsrId()))	throw new EgovBizException(messageSource, "fail.input.param.error", new Object[] {"아이디 형식을 확인하세요."}, new Exception());
			result = true;
			
			return result;
	}

	public boolean usrInsertCheck(UserMgmtVO usrVO, List<UserGroupMgmtVO> groCodeList) throws Exception{
			boolean result = false;

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(usrVO.getUsrId()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"아이디"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(usrVO.getEncPwd()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"비밀번호"}, null);
			else{
				if(!StringUtil.isPassword(usrVO.getEncPwd(), 20)){
					throw new EgovBizException(messageSource, "fail.input.param.error", new Object[] {"비밀번호 형식을 확인하세요."}, new Exception());
				}
			}
			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(usrVO.getUsrName()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"이름"}, null);
			else{
				if(!StringUtil.isUsrName(usrVO.getUsrName(), 20)){
					throw new EgovBizException(messageSource, "fail.input.param.error", new Object[] {"이름 형식을 확인하세요."}, new Exception());
				}
			}
			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(usrVO.getEmail()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"이메일"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(usrVO.getUsrGrpCd()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"권한코드"}, null);

			boolean grpCheck = true;
			for(int i = 0; i < groCodeList.size(); i++){
				if(usrVO.getUsrGrpCd().equals(groCodeList.get(i).getUsrGrpCd())){
					grpCheck = false;
					break;
				}
			}
			if(grpCheck){
				throw new EgovBizException(messageSource, "fail.input.grpNotEqual", null);
			}
			
			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(usrVO.getDeptName()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"부서"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
//			if(StringUtil.isEmpty(usrVO.getPos()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"직책"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(usrVO.getPhoneNo()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"전화번호"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(usrVO.getMpnNo()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"휴대전화"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(usrVO.getUseYn()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"사용여부"}, null);
			
			result = true;
			
			return result;
	}

	public boolean usrUpdateCheck(UserMgmtVO usrVO, List<UserGroupMgmtVO> groCodeList) throws Exception{
			boolean result = false;

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(usrVO.getUsrId()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"아이디"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
//			if(StringUtil.isEmpty(usrVO.getUsrName()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"이름"}, null);
			
			if(StringUtil.isEmpty(usrVO.getPwdChangeY())){
				usrVO.setEncPwd("");
			}else{
				if(StringUtil.isEmpty(usrVO.getEncPwd()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"비밀번호"}, null);
				else if(!StringUtil.isPassword(usrVO.getEncPwd(), 20))	throw new EgovBizException(messageSource, "fail.input.param.error", new String[]{"비밀번호 형식을 확인해 주세요."}, null);
			}

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(usrVO.getEmail()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"이메일"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(usrVO.getUsrGrpCd()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"권한코드"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(usrVO.getDeptName()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"부서"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
//			if(StringUtil.isEmpty(usrVO.getOprPos()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"직책"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(usrVO.getPhoneNo()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"전화번호"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(usrVO.getMpnNo()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"휴대전화"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(usrVO.getUseYn()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"사용여부"}, null);
			
			result = true;
			
			return result;
	}

	public boolean usrDeleteCheck(UserMgmtVO usrVO, List<UserGroupMgmtVO> groCodeList) throws Exception {
			boolean result = false;

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(usrVO.getUsrId()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"아이디"}, null);

			//필수 파라메터 체크: 제목, 발송범위, 내용
			if(StringUtil.isEmpty(usrVO.getEncPwd()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"비밀번호"}, null);

			result = true;
			
			return result;
	}

	
	public boolean myPatnrUsrUpdateCheck(UserMgmtVO usrVO) throws Exception {
		boolean result = false;

		//필수 파라메터 체크: 제목, 발송범위, 내용
		if(StringUtil.isEmpty(usrVO.getUsrId()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"아이디"}, null);

		if(!StringUtil.isEmpty(usrVO.getPwdChangeY())){
			if(StringUtil.isEmpty(usrVO.getEncPwd()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"비밀번호"}, null);
			else if(!StringUtil.isPassword(usrVO.getEncPwd(), 20))	throw new EgovBizException(messageSource, "fail.input.param.error", new String[]{"비밀번호 형식을 확인해 주세요."}, null);
		}
		
		//필수 파라메터 체크: 제목, 발송범위, 내용
		if(StringUtil.isEmpty(usrVO.getUsrName()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"이름"}, null);

		//필수 파라메터 체크: 제목, 발송범위, 내용
		if(StringUtil.isEmpty(usrVO.getEmail()))		throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"이메일"}, null);


		//필수 파라메터 체크: 제목, 발송범위, 내용
		if(StringUtil.isEmpty(usrVO.getPhoneNo()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"전화번호"}, null);

		//필수 파라메터 체크: 제목, 발송범위, 내용
		if(StringUtil.isEmpty(usrVO.getMpnNo()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"휴대전화"}, null);

		
		result = true;
		
		return result;
		
	}
	
	public boolean patnrUsrDeleteCheck(UserMgmtVO usrVO) throws Exception {
		boolean result = false;

		//필수 파라메터 체크: 제목, 발송범위, 내용
		if(StringUtil.isEmpty(usrVO.getUsrId()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"아이디"}, null);

		result = true;
		
		return result;
	}

	public void usrPwdCheck(UserMgmtVO usrVO) throws Exception {
		if(StringUtil.isEmpty(usrVO.getEncPwd()))		throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"비밀번호"}, null);
		
	}
}
