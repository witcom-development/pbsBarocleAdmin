package com.dkitec.barocle.util.encrypt;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.binary.Hex;

public class Crypto {
	private static final String AES_PRIVATE_KEY="SdsefsGhbbfwsd@~";
	
	public static String encryptAES(String value) {
		return encryptAES(value, AES_PRIVATE_KEY);
	}

	public static String encryptAES(String value, String privateKey) {
		try {
			byte[] raw = privateKey.getBytes();
			SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
			Cipher cipher = Cipher.getInstance("AES");
			cipher.init(Cipher.ENCRYPT_MODE, skeySpec);
			return byteToHexString(cipher.doFinal(value.getBytes()));
		} catch (Exception ex) {
			return null;
		}
	}

	public static String decryptAES(String value) {
		return decryptAES(value, AES_PRIVATE_KEY);
	}

	public static String decryptAES(String value, String privateKey) {
		try {
			byte[] raw = privateKey.getBytes();
			SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
			Cipher cipher = Cipher.getInstance("AES");
			cipher.init(Cipher.DECRYPT_MODE, skeySpec);
			return new String(cipher.doFinal(hexStringToByte(value)));
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}
	}

	private static String byteToHexString(byte[] bytes) {
		return String.valueOf(Hex.encodeHex(bytes));
	}

	private static byte[] hexStringToByte(String hexString) {
		try {
			return Hex.decodeHex(hexString.toCharArray());
		} catch (DecoderException e) {
			return null;
		}
	}
}
