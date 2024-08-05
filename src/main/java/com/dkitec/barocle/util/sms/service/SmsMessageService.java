package com.dkitec.barocle.util.sms.service;

import java.util.List;

import com.dkitec.barocle.util.sms.vo.SmsMessageVO;

public interface SmsMessageService {
	public List<SmsMessageVO> failSmsList();
	public void updateAutoSendResult(SmsMessageVO smsMessageVO);
	public int insertSmsMessage(SmsMessageVO smsMessageVO);
	public String getSmsBody(String code);
	
	public void insertSmsHistory(SmsMessageVO msg);		//sms_history 등록_cms_20161209
}
