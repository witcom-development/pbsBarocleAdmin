package com.dkitec.barocle.admin.login.security.encoder;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.dkitec.barocle.admin.login.service.LoginService;

public class DGuardPasswordEncoder implements PasswordEncoder {
	
	protected static Logger log = LoggerFactory.getLogger(DGuardPasswordEncoder.class);

	@Resource(name = "loginService") private LoginService loginService;
	
	@Override
	public String encode(CharSequence rawPassword) {
		if (rawPassword == null) {
			throw new NullPointerException();
		}
		
        String tempPassword = rawPassword.toString();
        String resultPassword = "";
        
        try {
        	resultPassword = loginService.getDGaurdEncodePassword(tempPassword); 
        			
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
        
        return resultPassword;
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
