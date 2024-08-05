package com.dkitec.barocle.util.sms.service.impl;

import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.dkitec.barocle.util.sms.service.SmsMessageMapper;
import com.dkitec.barocle.util.sms.service.SmsMessageService;
import com.dkitec.barocle.util.sms.vo.SmsBodyVO;
import com.dkitec.barocle.util.sms.vo.SmsMessageVO;

@Service("smsMessageService")
public class SmsMessageServiceImpl implements SmsMessageService {

	@Autowired private SmsMessageMapper smsMessageMapper;

	@Autowired
	CacheManager cacheManager;
	
	@PostConstruct
	public void init(){
		System.out.println("=====init smsMessage========");
		List<SmsBodyVO> list =  smsMessageMapper.getSmsMessageList();
		for(SmsBodyVO vo: list){
			if(vo.getAutoSendID() != null && vo.getOrignlMsg() != null){
				cacheManager.getCache("smsMessage").put(vo.getAutoSendID(), vo.getOrignlMsg());
			}
		}
	}
	
	@Override
	public List<SmsMessageVO> failSmsList() {
		
		return smsMessageMapper.failSmsList();
	}

	
	@Override
	public void updateAutoSendResult(SmsMessageVO smsMessageVO) {
		
		smsMessageMapper.updateAutoSendResult(smsMessageVO);
	}

	@Override
	public int insertSmsMessage(SmsMessageVO smsMessageVO) {
		System.out.println("SMS 등록..."+smsMessageVO.toString());
		return smsMessageMapper.insertSmsMessage(smsMessageVO);
	}
	
	@Override
	//@Cacheable(value="smsMessage" , key="#code", unless = "#result == null")
	public String getSmsBody(String code) {
		System.out.println("======DB call start======");
		String result = null;
		
		SmsBodyVO smsVo = smsMessageMapper.getSmsBody(code);
		if(smsVo != null){
			result = smsVo.getOrignlMsg();
		}
		System.out.println("======DB call end======");
		
		return result;
	}

	// sms_history 등록 _cms_20161209
	@Override
	public void insertSmsHistory(SmsMessageVO smsMessageVO) {
		 smsMessageMapper.insertSmsHistory(smsMessageVO);
	}

}
