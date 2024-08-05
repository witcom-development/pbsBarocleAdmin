package com.dkitec.barocle.admin.login.security.encoder;

import java.security.GeneralSecurityException;
import java.security.MessageDigest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;

public class MySqlPasswordEncoder implements PasswordEncoder {
	/*
	MySQL PASSWORD() 함수로 암호화된 로그인 비밀번호 비교 처리 함수
	
	MySQL 4.0.x 이하 버전
	  - PASSWORD()
	  - OLD_PASSWORD() 함수는 없음

	  mysql> SELECT PASSWORD('mypass');
	  +--------------------+
	  | PASSWORD('mypass') |
	  +--------------------+
	  | 6f8c114b58f2ce9e   |
	  +--------------------+

	MySQL 4.1.x 이상 버전 (Maria DB 포함)
	  - PASSWORD()         ==> 버전업된 암호화 함수
	  - OLD_PASSWORD()     ==> 기존 암호화 (MySQL 4.0.x의 PASSWORD()와 동일)

	  mysql>select PASSWORD('mypass');
	  +-------------------------------------------+
	  | password('mypass')                        |
	  +-------------------------------------------+
	  | *6C8989366EAF75BB670AD8EA7A7FC1176A95CEF4 |
	  +-------------------------------------------+
	  
	  mysql>select OLD_PASSWORD('mypass');
	  +------------------------+
	  | old_password('mypass') |
	  +------------------------+
	  | 6f8c114b58f2ce9e       |
	  +------------------------+
	*/
	
	protected static Logger log = LoggerFactory.getLogger(MySqlPasswordEncoder.class);
	
	@Override
	public String encode(CharSequence rawPassword) {
		if (rawPassword == null) {
			throw new NullPointerException();
		}

		byte[] bpara = new byte[rawPassword.length()];
		byte[] rethash;
		int i;
		
		for (i = 0; i < rawPassword.length(); i++)
			bpara[i] = (byte) (rawPassword.charAt(i) & 0xff);
		try {
			MessageDigest sha1er = MessageDigest.getInstance("SHA1");
			rethash = sha1er.digest(bpara); 	// stage1
			rethash = sha1er.digest(rethash); 	// stage2
		} catch (GeneralSecurityException e) {
			throw new RuntimeException(e);
		}
		
		StringBuffer r = new StringBuffer(41);
		r.append("*");
		
		for (i = 0; i < rethash.length; i++) {
			String x = Integer.toHexString(rethash[i] & 0xff).toUpperCase();
			if (x.length() < 2)
				r.append("0");
			r.append(x);
		}
		
		return r.toString();
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		if (encodedPassword == null || rawPassword == null) {
			return false;
		}

		if (!encodedPassword.equals(encode(rawPassword))) {
			return false;
		}

		return true;
	}
}