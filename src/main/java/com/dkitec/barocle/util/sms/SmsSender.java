package com.dkitec.barocle.util.sms;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.dkitec.barocle.util.sms.service.SmsMessageService;
import com.dkitec.barocle.util.sms.vo.SmsMessageVO;

@Component
public class SmsSender {

	private static SmsMessageService smsMessageService;
	
	@Autowired
	SmsSender(SmsMessageService smsMessageService){
		SmsSender.smsMessageService = smsMessageService;
	}
	
	public static String getMsg(String code){
		return smsMessageService.getSmsBody(code);
	}
	
	/**
	 * 단건 전송
	 * @param msg
	 */
	public static void sender(SmsMessageVO msg){
		System.out.println("SMS 등록");
		smsMessageService.insertSmsMessage(msg);
	}
	
	/**
	 * 다건 전송
	 * @param list
	 */
	public static void sender(List<SmsMessageVO> list){
		for(SmsMessageVO msg:list){
			sender(msg);
		}
	}
	
	/**
	 * 자동전송..
	 * 
	 * Sms에 직접 인자를 넣고..sender(sms)를 호출해도 된다.
	 * 
	 */
	public static void sender(SmsMessageVO msg, SendType sendType, String ... args){
		System.out.println("##### sender ==> " + sendType);
		
		msg.setMsg(sendType, args);
		
		//msg.setMsg(getMsg(msg.getAutoSendId()));
		System.out.println("##### sender ==> " + msg.toString());
		sender(msg);
	}

	
	/**
	 * sms_history 등록 _cms_20161209 
	 */
	public static void senderHistory(List<SmsMessageVO> smsMsgList) {
		// TODO Auto-generated method stub
		for(SmsMessageVO msg:smsMsgList){
			smsMessageService.insertSmsHistory(msg);
		}
		
		
	}
	
	
}
