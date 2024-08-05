package com.dkitec.barocle.admin.service.paymentmgmt.payment;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import org.apache.commons.codec.binary.Hex;

public class ToSHA256Hex {
	/**
	 * same javascript
	 * @param password
	 * @return
	 * @throws NoSuchAlgorithmException
	 */
	public static String toSHA256Hex(String password) throws NoSuchAlgorithmException {
		MessageDigest digest;

        try {
            digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes("UTF-8"));
            String output = Hex.encodeHexString(hash);
            return output;
        }catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
