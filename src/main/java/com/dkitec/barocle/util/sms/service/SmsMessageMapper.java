package com.dkitec.barocle.util.sms.service;

import java.util.List;

import com.dkitec.barocle.util.sms.vo.SmsBodyVO;
import com.dkitec.barocle.util.sms.vo.SmsMessageVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("smsMessageMapper")
public interface SmsMessageMapper {
	public List<SmsMessageVO> failSmsList();
	public void updateAutoSendResult(SmsMessageVO smsMessageVO);
	public int insertSmsMessage(SmsMessageVO smsMessageVO);
	public List<SmsBodyVO> getSmsMessageList();
	public SmsBodyVO getSmsBody(String code);
	
	public void insertSmsHistory(SmsMessageVO smsMessageVO);		// sms_history 등록 _cms_20161209
}
