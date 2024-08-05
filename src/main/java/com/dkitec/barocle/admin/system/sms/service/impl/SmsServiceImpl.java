package com.dkitec.barocle.admin.system.sms.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.common.vo.SmsSendVo;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.MemberMgmtVO;
import com.dkitec.barocle.admin.system.sms.service.SmsMapper;
import com.dkitec.barocle.admin.system.sms.service.SmsService;
import com.dkitec.barocle.admin.system.sms.vo.AdminSmsVO;
import com.dkitec.barocle.admin.system.sms.vo.SmsVO;
import com.dkitec.barocle.admin.system.usergroupmgmt.vo.UserGroupMgmtVO;
import com.dkitec.barocle.admin.system.usermgmt.vo.UserMgmtVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.barocle.util.sms.SmsSender;
import com.dkitec.barocle.util.sms.service.SmsMessageMapper;
import com.dkitec.barocle.util.sms.vo.SmsMessageVO;
import com.dkitec.barocle.util.webutil.WebUtil;

@Service("smsService")
public class SmsServiceImpl implements SmsService {

	@Autowired SmsMapper smsMapper;
	
	@Autowired private SmsMessageMapper smsMessageMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int listSmsCount(SmsVO smsVO) {
		return smsMapper.listSmsCount(smsVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public java.util.List<SmsVO> listSms(SmsVO smsVO) {
		return smsMapper.listSms(smsVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public SmsVO viewSms(SmsVO smsVO) {
		return (SmsVO)smsMapper.viewSms(smsVO);
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public SmsVO insertSms(SmsVO smsVO) {
		//smsVO.setAutoSendID(WebUtil.getSmsAutoSendId("SMS_",smsMapper.getNextSmsID(smsVO)));
		smsVO.setAutoSendID(null);
		@SuppressWarnings("unused") int resultValue = smsMapper.insertSms(smsVO);
		return smsVO;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public SmsVO updateSms(SmsVO smsVO) {
		@SuppressWarnings("unused") int resultValue = smsMapper.updateSms(smsVO);
		return smsVO;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int deleteSms(SmsVO smsVO) {
		smsVO.setAutoSendID("Y");
		int resultValue = smsMapper.deleteSms(smsVO);
		return resultValue;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)	
	public int insertReqAdmSms(AdminSmsVO admSmsVo) {//관리자SMS 등록
		
		 int i =0;
		 
		 if(admSmsVo.getAdminIdArr() != null){
			 
			 i = smsMapper.insertReqAdmSms(admSmsVo);
			 
			 if(i == 1){
			
				 insertReqAdmSmsDtl(admSmsVo);
				 
			 }
		 
		 }
		 
		 return i;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)		
	public int updateReqAdmMmsSeq(AdminSmsVO admSmsVo) {//관리자 SMS TSMS_AGENT_MESSAGE 테이블 일련번호 저장
		return smsMapper.updateReqAdmMmsSeq(admSmsVo);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)		
	public int updateReqAdmSendYn(AdminSmsVO admSmsVo) {// 관리자SMS 전송상태 업데이트
		return smsMapper.updateReqAdmSendYn(admSmsVo);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)	
	public int updateReqAdmDtlSendResCd(AdminSmsVO admSmsVo) {// 관리자SMS 단건 별 전송상태 업데이트
		return smsMapper.updateReqAdmDtlSendResCd(admSmsVo);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)	
	public void insertReqAdmSmsDtl(AdminSmsVO admSmsVo) {//관리자 SMS DTL 등록 후 SMS전송
		
		int i =0;
		
		String adminIdArr = admSmsVo.getAdminIdArr();
		
		if(adminIdArr.indexOf(",") > -1){
			
			String[] admId = adminIdArr.split(",");
			
			for(String adminId : admId){
				
				admSmsVo.setAdminId(adminId);
				i = smsMapper.insertReqAdmSmsDtl(admSmsVo);
			
			}	
					
		}else{
			
			admSmsVo.setAdminId(adminIdArr);
			i = smsMapper.insertReqAdmSmsDtl(admSmsVo);
			
		}
		
		if(i==1) startSms(admSmsVo);
		
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)	
	public int getReqAdmSmsListCnt(AdminSmsVO admSmsVo) {// 관리자SMS 목록 개수 조회
		return smsMapper.getReqAdmSmsListCnt(admSmsVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)		
	public List<AdminSmsVO> getReqAdmSmsList(AdminSmsVO admSmsVo) {// 관리자SMS 목록 조회
		
		List<AdminSmsVO> rList =  smsMapper.getReqAdmSmsList(admSmsVo);
		rList = editSendYn(admSmsVo,rList);
		
		return rList;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)		
	public AdminSmsVO getReqAdmSmsDtl(AdminSmsVO admSmsVo) {// 관리자SMS 상세 조회
		return smsMapper.getReqAdmSmsDtl(admSmsVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)			
	public List<AdminSmsVO> getReqAdmSmsDtlName(String reqSmsSeq) {// 관리자SMS 발송대상 조회
		return smsMapper.getReqAdmSmsDtlName(reqSmsSeq);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)			
	public List<UserGroupMgmtVO> getGroupNameList() {// 관리자SMS 그룹이름 조회
		return smsMapper.getGroupNameList();
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)		
	public List<UserMgmtVO> getAdminList() {// 관리자SMS 관리자페이지에서 사용중인 관리자 조회
		return smsMapper.getAdminList();
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)		
	public List<SmsSendVo> getAdminSmsTpl(SmsSendVo smsVo) {//문자 템플릿 조회
		return smsMapper.getAdminSmsTpl(smsVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)		
	public String getAdminSmsAgtSendYn(AdminSmsVO admSmsVo) {//문자 전송완료 조회
		return smsMapper.getAdminSmsAgtSendYn(admSmsVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)		
	public List<String> getAdminGrpNameCnt(String reqSmsSeq) {// 수신 대상 조회
		return smsMapper.getAdminGrpNameCnt(reqSmsSeq);
	}	

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)	
	public String getSendAdminTelNo(String adminId) {//발송자 전화번호(휴대폰X)조회
		// TODO Auto-generated method stub
		return smsMapper.getSendAdminTelNo(adminId);
	}
	
	/*
	 * 조회 시(getReqAdmSmsList에서 호출) 전송상태 확인 작업 - 2020.09.22
	 */
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)		
	public List<AdminSmsVO> editSendYn(AdminSmsVO admSmsVo, List<AdminSmsVO> rList){
		
		for(AdminSmsVO vo : rList){
			
			if("N".equals(vo.getReqSendYn())){//조회목록 중 전송상태가 N인 건
				
				vo.setSearchBgnDe(admSmsVo.getSearchBgnDe());
				vo.setSearchEndDe(admSmsVo.getSearchEndDe());
				
				List<AdminSmsVO> dtlList = getReqAdmSmsDtlName(vo.getReqSmsSeq());
				
				boolean chkSend = true;
				for(AdminSmsVO dtlVo : dtlList){
					
					dtlVo.setSearchBgnDe(admSmsVo.getSearchBgnDe());
					dtlVo.setSearchEndDe(admSmsVo.getSearchEndDe());
					
					String sendYn = getAdminSmsAgtSendYn(dtlVo);
					dtlVo.setSendResultCd(sendYn);
					updateReqAdmDtlSendResCd(dtlVo);//전송상태 업데이트
					if(chkSend && sendYn == null){
						chkSend = false;
					}
					
				}
				if(chkSend){//모든 건이 전송 완료일때
					
					updateReqAdmSendYn(vo);//전송상태 업데이트
					
				}
				
			}
			
		}
		
		return smsMapper.getReqAdmSmsList(admSmsVo);
	}

	/*
	 * 최고 관리자(관리운영그룹)이 로그인시 해당 관리자에게 문자 전송 - 2020.10.27
	 * @see com.dkitec.barocle.admin.system.sms.service.SmsService#sendChiefAdminLogin(com.dkitec.barocle.admin.login.vo.UserSessionVO)
	 */
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public void sendChiefAdminLogin(UserSessionVO userSessionVO) {
		
		smsMapper.sendChiefAdminLogin(userSessionVO);
	}
	
	/*
	 * 등록 시(insertReqAdmSmsDtl에서 호출) 관리자SMS 테이블 정보를 조회해 실제로 SMS전송 - 2020.09.21
	 */
	public void startSms(AdminSmsVO admSmsVo){
		
		AdminSmsVO dtlVo = getReqAdmSmsDtl(admSmsVo);
		
		List<AdminSmsVO> adminList = getReqAdmSmsDtlName(admSmsVo.getReqSmsSeq());
		
		List<SmsMessageVO> smsMsgList = new ArrayList<SmsMessageVO>();
		SmsMessageVO smsMsgVo = null;
		
		
		Date dt = new Date();
		SimpleDateFormat sDate = new SimpleDateFormat("yyyy-MM-dd hh:mm");
		
		String nowDateStr = sDate.format(dt);
		
		Date nowDate = null;
		Date reqDate = null;
		
		try {
			
			nowDate = sDate.parse(nowDateStr);
			reqDate = sDate.parse(dtlVo.getReqResDate());
			
			
			
		} catch (Exception e) {
			e.getMessage();
		}
		
		if(nowDate != null && reqDate != null){
			
			for(AdminSmsVO vo : adminList){
				
				String phoneNo = vo.getAdminPno().replace("-", "");
				
				if(vo.getAdminPno() != "" && vo.getAdminPno() != null){
					
					smsMsgVo = new SmsMessageVO();
					
					smsMsgVo.setDestno(phoneNo);
					
					if(nowDate.getTime() < reqDate.getTime()){
						
						smsMsgVo.setReqdttm(dtlVo.getReqResDate());
						
					}else{
						
						smsMsgVo.setReqdttm("");
						
					}
					
					smsMsgVo.setTitle(dtlVo.getReqTitle());
					
					smsMsgVo.setMsg(dtlVo.getReqContent());
					
					smsMsgVo.setCallback(admSmsVo.getReqSendAdmTelNo());
					
					smsMsgVo.setAutoSendId(dtlVo.getReqSendType());
					
					smsMsgVo.setSenderId(dtlVo.getRegId());	//sms 발신인ID_cms_20161209
					
					smsMsgList.add(smsMsgVo);
					
				}
				
			}
			
			int seq = 0;
			for(int i =0; i< smsMsgList.size(); i++){
				
				smsMessageMapper.insertSmsMessage(smsMsgList.get(i));
				seq = smsMsgList.get(i).getSeqno();
				admSmsVo.setMessageSeq(seq+"");
				admSmsVo.setAdminId(adminList.get(i).getAdminId());
				updateReqAdmMmsSeq(admSmsVo);
				
			}
			
			//sms history 테이블 이력
			SmsSender.senderHistory(smsMsgList);
			
			
		}
		
	}

}
