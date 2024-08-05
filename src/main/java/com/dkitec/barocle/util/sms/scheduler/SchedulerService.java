package com.dkitec.barocle.util.sms.scheduler;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.dkitec.barocle.admin.service.membermgmt.service.SafetyCertMapper;
import com.dkitec.barocle.admin.service.membermgmt.vo.SafetyCertUserVO;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.sms.SendType;
import com.dkitec.barocle.util.sms.SmsSender;
import com.dkitec.barocle.util.sms.service.SmsMessageMapper;
import com.dkitec.barocle.util.sms.vo.SmsMessageVO;
import com.dkitec.barocle.util.webutil.DateUtil;

import egovframework.rte.fdl.property.EgovPropertyService;

@Component
public class SchedulerService {
	
	@Autowired private SmsMessageMapper smsMessageMapper;
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertiesService;
	
	public void reSendScheduler(){
		System.out.println("Resend failed SMS.every 10 seconds.. Current time is :: "+ new Date());
		List<SmsMessageVO> list = smsMessageMapper.failSmsList();
		for(SmsMessageVO msgVO:list){
			smsMessageMapper.updateAutoSendResult(msgVO);
			smsMessageMapper.insertSmsMessage(msgVO);
		}
		
	}
	
	@Autowired SafetyCertMapper safetyCertMapper;

//	@Scheduled(cron="*/30 * * * * *")
	@Scheduled(cron="0 0 10 * * *")
    public void TestScheduler(){
//        System.out.println("스케줄링 테스트");
        SafetyCertUserVO safetyCertUserVo = new SafetyCertUserVO();
        List<SafetyCertUserVO> userList = safetyCertMapper.safetyCertEndUserList(safetyCertUserVo);
      //sms로 종료 문자 예약 넣어 줌
		String disEDttm = DateUtil.formatDate(DateUtil.getToday(), "yyyy-MM-dd") + " 10:00";
		for(SafetyCertUserVO map : userList) {        
			SmsMessageVO msg = new SmsMessageVO();
			msg.setTitle(IConstants.CERT_DIS_END_MSG_TITLE);
			msg.setMsg(IConstants.CERT_DIS_END_MSG);
			msg.setDestno(map.getUsrMpnNo());
			msg.setReqdttm(disEDttm);
			SmsSender.sender(msg);
        }
    }	
}
