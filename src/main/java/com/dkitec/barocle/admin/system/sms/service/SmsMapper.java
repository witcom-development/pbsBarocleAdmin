package com.dkitec.barocle.admin.system.sms.service;

import java.util.List;

import com.dkitec.barocle.admin.common.vo.SmsSendVo;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.system.sms.vo.AdminSmsVO;
import com.dkitec.barocle.admin.system.sms.vo.SmsVO;
import com.dkitec.barocle.admin.system.usergroupmgmt.vo.UserGroupMgmtVO;
import com.dkitec.barocle.admin.system.usermgmt.vo.UserMgmtVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("smsMapper")
public interface SmsMapper {
	
	public int listSmsCount(SmsVO smsVO);
	
	public java.util.List<SmsVO> listSms(SmsVO smsVO);
	
	public SmsVO viewSms(SmsVO smsVO);
	
	public int getNextSmsID(SmsVO smsVO);
	
	public int insertSms(SmsVO smsVO);
	
	public int updateSms(SmsVO smsVO);
	
	public int deleteSms(SmsVO smsVO);

	public int insertReqAdmSms(AdminSmsVO admSmsVo);
	
	public int updateReqAdmMmsSeq(AdminSmsVO admSmsVo);
	
	public int updateReqAdmSendYn(AdminSmsVO admSmsVo);

	public int insertReqAdmSmsDtl(AdminSmsVO admSmsVo);
	
	public int getReqAdmSmsListCnt(AdminSmsVO admSmsVo);

	public List<AdminSmsVO> getReqAdmSmsList(AdminSmsVO admSmsVo);

	public AdminSmsVO getReqAdmSmsDtl(AdminSmsVO admSmsVo);

	public List<AdminSmsVO> getReqAdmSmsDtlName(String reqSmsSeq);

	public List<UserGroupMgmtVO> getGroupNameList();

	public List<UserMgmtVO> getAdminList();

	public List<UserMgmtVO> getReqDtlAdminList();

	public List<SmsSendVo> getAdminSmsTpl(SmsSendVo smsVo);

	public String getAdminSmsAgtSendYn(AdminSmsVO smsVo);

	public int updateReqAdmDtlSendResCd(AdminSmsVO admSmsVo);

	public List<String> getAdminGrpNameCnt(String reqSmsSeq);
	
	public String getSendAdminTelNo(String adminId);

	public void sendChiefAdminLogin(UserSessionVO userSessionVO);
	
}
