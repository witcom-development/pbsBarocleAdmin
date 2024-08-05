package com.dkitec.barocle.util.encrypt;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;

public class HmacSha256Enc {
	public String getHmac(String message , String apiKey){
		// 암호화키(API_KEY) -> 예시를 위한 코드임-노출되지 않도록 주의필요
		String secretKey = apiKey;
		// Hash값 생성
		String checkHash = null;
		try {
			Mac sha256_HMAC = Mac.getInstance("HmacSHA256");
			SecretKeySpec secret_key = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
			sha256_HMAC.init(secret_key);
			checkHash = Base64.encodeBase64String(sha256_HMAC.doFinal(message.getBytes("UTF-8")));
		} catch (NoSuchAlgorithmException e) {
	        e.printStackTrace();
	    } catch (InvalidKeyException e) {
	        e.printStackTrace();
	    } catch (UnsupportedEncodingException e) {
	        e.printStackTrace();
	    }
		return checkHash;
	}
}