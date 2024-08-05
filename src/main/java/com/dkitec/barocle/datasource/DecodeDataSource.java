package com.dkitec.barocle.datasource;

import com.dkitec.barocle.datasource.AES256anicar;

/**
 * 암호화된 접속 계정 정보를 처리하는 데이터베이스 풀 클래스
 */
public class DecodeDataSource extends org.apache.commons.dbcp.BasicDataSource {

	/**
	 * 암호화된 사용자 계정을 지정하는 함수
	 * @param username 암호화된 사용자 계정
	 */
	@Override
	public void setUsername(String username) {

		try {
			super.setUsername(username);
			System.out.println("########################## check getUserName ====>" + super.getUsername());//디컴파일러 : 디컴파일러 없음_2016.08.11_by_JHN
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 암호화된 비밀번호를 지정하는 함수
	 * @param password 암호화된 비밀번호
	 */
	@Override
	public void setPassword(String password) {

		try {
			super.setPassword(password);
			System.out.println("########################## check getPassword ====>" + super.getPassword());//디컴파일러 : 디컴파일러 없음_2016.08.11_by_JHN
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
}
