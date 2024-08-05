package com.dkitec.barocle.admin.system.sms.service;

import java.util.List;

import com.dkitec.barocle.admin.common.vo.SmsSendVo;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.system.sms.vo.AdminSmsVO;
import com.dkitec.barocle.admin.system.sms.vo.SmsVO;
import com.dkitec.barocle.admin.system.usergroupmgmt.vo.UserGroupMgmtVO;
import com.dkitec.barocle.admin.system.usermgmt.vo.UserMgmtVO;

public interface SmsService {
	
	//sms
	public int listSmsCount(SmsVO smsVO);
	
	public java.util.List<SmsVO> listSms(SmsVO smsVO);
	
	public SmsVO viewSms(SmsVO smsVO);
	
	public SmsVO insertSms(SmsVO smsVO);
	
	public SmsVO updateSms(SmsVO smsVO);
	
	public int deleteSms(SmsVO smsVO);

	//관리자 SMS
	public int insertReqAdmSms(AdminSmsVO admSmsVo);
	
	public int updateReqAdmMmsSeq(AdminSmsVO admSmsVo);
	
	public int updateReqAdmSendYn(AdminSmsVO admSmsVo);
	
	public int updateReqAdmDtlSendResCd(AdminSmsVO admSmsVo);

	public void insertReqAdmSmsDtl(AdminSmsVO admSmsVo);

	public int getReqAdmSmsListCnt(AdminSmsVO admSmsVo);

	public List<AdminSmsVO> getReqAdmSmsList(AdminSmsVO admSmsVo);

	public AdminSmsVO getReqAdmSmsDtl(AdminSmsVO admSmsVo);

	public List<AdminSmsVO> getReqAdmSmsDtlName(String reqSmsSeq);

	public List<UserGroupMgmtVO> getGroupNameList();

	public List<UserMgmtVO> getAdminList();

	public List<SmsSendVo> getAdminSmsTpl(SmsSendVo smsVo);
	
	public String getAdminSmsAgtSendYn(AdminSmsVO smsVo);

	public List<String> getAdminGrpNameCnt(String reqSmsSeq);
	
	public String getSendAdminTelNo(String adminId);

	public void sendChiefAdminLogin(UserSessionVO userSessionVO);

	}
