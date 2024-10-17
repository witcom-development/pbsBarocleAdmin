package com.dkitec.barocle.util.sms;

public enum SendType {

	DEFAULT(""),
	SMS_001("SMS_001"), //회원가입
	SMS_002("SMS_002"), //회원탈퇴
	SMS_003("SMS_003"), //대여안내
	SMS_004("SMS_004"), //반납안내
	SMS_005("SMS_005"), //대여종료 이전 안내
	SMS_006("SMS_006"), //대여종료 초과안내 - 추가요금 발생안내
	SMS_007("SMS_007"), //최대 대여시간 초과안내 - 장기미반납
	SMS_008("SMS_008"), //추가요금 자동결재
	SMS_009("SMS_009"), //미납요금 안내 - 대여불가
	SMS_010("SMS_010"), //강제회원탈퇴 안내
	SMS_011("SMS_011"), //회원확인
	SMS_012("SMS_012"), //일일권 구매 - 비회원
	SMS_013("SMS_013"), //강제 반납
	SMS_014("SMS_014"), //예약 취소
	SMS_015("SMS_015"), //회원재동의자 안내
	
	SMS_090("SMS_090"), //반납안내
	
	SMS_099("SMS_099"), //대여소 임시폐쇄 사전예고 
	SMS_097("SMS_097"); //대여소 임시폐쇄 안내
	
	private String code;
	
	public String toString(){
		return SmsSender.getMsg(code);
	}
	
	public String getCode() {
		return code;
	}

	private SendType(String code){
		this.code = code;
	}
}
