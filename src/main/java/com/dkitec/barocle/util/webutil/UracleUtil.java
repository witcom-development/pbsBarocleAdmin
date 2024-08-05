package com.dkitec.barocle.util.webutil;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.HttpClientConnectionManager;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.BasicHttpClientConnectionManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.security.GeneralSecurityException;
import java.security.KeyStore;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateEncodingException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.TrustManagerFactory;
import javax.net.ssl.X509TrustManager;
import javax.security.cert.Certificate;
import javax.security.cert.CertificateException;

import java.lang.StringBuilder;
/**
 * UMS 푸시>알림톡>SMS 회원발송 예제
 */
public class UracleUtil {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public static void sendPush(String cuid, String msg, String subTitle, String ext) {
		BufferedReader in = null;
		String API_URL = "https://api.message-ai.net/api/send/potalSendApi.ums";
		
	  //발송 대상 서비스그룹에서 생성한 API Key를 입력하세요.
		String apiKey = "401d2178e32a4046b25a65512f194cfd";
		//발송 대상 서비스그룹의 서비스그룹ID를 입력하세요.
		String projectId = "ebde79b15f284b69a6cd00cf9ec7d43c";
		//발송자는 서버관리를 위한 회원님 고유의 아이디를 입력하세요.
		String senderId = "barocle";
		//발송 대상 서비스그룹의 서비스그룹ID를 입력하세요.
		String appId = "ebde79b15f284b69a6cd00cf9ec7d43c";
		//푸시 발송 제목을 입력하세요.
		String messageTitle = subTitle;
		//푸시 발송 내용을 입력하세요.
		String messageContent = msg;
		
		//String cuids ="{\"user1\":[\"01094184422\",\"홍길동\"]}";
		String cuids ="{\"user1\":[\"" + cuid + "\",\"홍길동\"]}";
		
		try {
			SSLContext sslContext = SSLContext.getInstance("TLSv1.2");
			TrustManagerFactory trustManagerFactory = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
			trustManagerFactory.init((KeyStore) null);
			sslContext.init(null, (TrustManager[]) trustManagerFactory.getTrustManagers(), null);
			SSLSocketFactory sslSocketFactory = sslContext.getSocketFactory();
			
			HashMap<String, Object> params = new HashMap<String, Object>();
			
			params.put("APIKEY", apiKey);
			params.put("PROJECT_ID", projectId);
			params.put("REQ_TRAN_TYPE", "REAL");
			params.put("TARGET_USER_TYPE", "NM");
			params.put("SENDERID", senderId);
			params.put("APP_ID", appId);
			params.put("TITLE", messageTitle);
			params.put("PUSH_MSG", messageContent);
			params.put("CUIDS", cuids);
			params.put("CALLBACK_NUM", "025427781");
			StringBuilder postData = new StringBuilder();
			for(Map.Entry<String,Object> param : params.entrySet())
			{
				if(postData.length() != 0)
					postData.append('&');
				postData.append(param.getKey());
				postData.append('=');
				postData.append(String.valueOf(param.getValue()));
			}

 			System.out.println("Send Data " + postData.toString());
			
 			byte[] postDataBytes = postData.toString().getBytes();
 			
 			URL obj = new URL(API_URL); // 호출할 URL
			HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();
			con.setSSLSocketFactory(sslSocketFactory);
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
			con.setDoOutput(true);
			con.getOutputStream().write(postDataBytes); // POST 호출

 			
 			//httpPost.setEntity(new UrlEncodedFormEntity(nvps, "UTF-8"));
 			
			in = new BufferedReader(new InputStreamReader(con.getInputStream(), StandardCharsets.UTF_8));
			String line;
			while ((line = in.readLine()) != null) {
				System.out.println(line);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}


	}
	
	public static void sendMessage(String cuid, String msg, String subTitle) {
		BufferedReader in = null;
		String API_URL = "https://api.message-ai.net/api/send/potalSendApi.ums";
		String apiKey = "401d2178e32a4046b25a65512f194cfd";		//발송 대상 서비스그룹에서 생성한 API Key를 입력하세요.
		String projectId = "ebde79b15f284b69a6cd00cf9ec7d43c";	//발송 대상 서비스그룹의 서비스그룹ID를 입력하세요.
		String senderId = "barocle";	//발송자는 서버관리를 위한 회원님 고유의 아이디를 입력하세요.
		String appId = "ebde79b15f284b69a6cd00cf9ec7d43c";		//발송 대상 서비스그룹의 서비스그룹ID를 입력하세요.
		String messageTitle = subTitle;		//푸시 발송 제목을 입력하세요.
		String messageContent = msg;		//푸시 발송 내용을 입력하세요.
		String cuids ="{\"user1\":[\"" + cuid + "\",\"홍길동\"]}";	//String cuids ="{\"user1\":[\"01094184422\",\"홍길동\"]}";
		
		try {
			SSLContext sslContext = SSLContext.getInstance("TLSv1.2");
			TrustManagerFactory trustManagerFactory = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
			trustManagerFactory.init((KeyStore) null);
			sslContext.init(null, (TrustManager[]) trustManagerFactory.getTrustManagers(), null);
			SSLSocketFactory sslSocketFactory = sslContext.getSocketFactory();
			
			HashMap<String, Object> params = new HashMap<String, Object>();
			
			params.put("APIKEY", apiKey);
			params.put("PROJECT_ID", projectId);
			params.put("REQ_TRAN_TYPE", "REAL");
			params.put("TARGET_USER_TYPE", "NM");
			params.put("SENDERID", senderId);
			params.put("APP_ID", appId);
			params.put("SMS_TITLE", messageTitle);
			params.put("SMS_MSG", messageContent);
			params.put("CUIDS", cuids);
			params.put("CALLBACK_NUM", "025427781");
			StringBuilder postData = new StringBuilder();
			for(Map.Entry<String,Object> param : params.entrySet()){
				if(postData.length() != 0)
					postData.append('&');
				postData.append(param.getKey());
				postData.append('=');
				postData.append(String.valueOf(param.getValue()));
			}
			
 			System.out.println("Send Data " + postData.toString());
			
 			byte[] postDataBytes = postData.toString().getBytes();
 			
 			URL obj = new URL(API_URL); // 호출할 URL
			HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();
			con.setSSLSocketFactory(sslSocketFactory);
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
			con.setDoOutput(true);
			con.getOutputStream().write(postDataBytes); // POST 호출
 			
 			//httpPost.setEntity(new UrlEncodedFormEntity(nvps, "UTF-8"));
 			
			in = new BufferedReader(new InputStreamReader(con.getInputStream(), StandardCharsets.UTF_8));
			String line;
			while ((line = in.readLine()) != null) {
				System.out.println(line);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	
	public static void sendAlimTalkMessage(String cuid, String msg, String subTitle,String AlimTemplateCode) {
		BufferedReader in = null;
		String API_URL = "https://api.message-ai.net/api/send/potalSendApi.ums";
		
	  //발송 대상 서비스그룹에서 생성한 API Key를 입력하세요.
		String apiKey = "401d2178e32a4046b25a65512f194cfd";
		//발송 대상 서비스그룹의 서비스그룹ID를 입력하세요.
		String projectId = "ebde79b15f284b69a6cd00cf9ec7d43c";
		//발송자는 서버관리를 위한 회원님 고유의 아이디를 입력하세요.
		String senderId = "barocle";
		//발송 대상 서비스그룹의 서비스그룹ID를 입력하세요.
		String appId = "ebde79b15f284b69a6cd00cf9ec7d43c";
		String alimId = "00182fcd6c320ed0f976ab189e95e468ca0be6bf";
		//푸시 발송 제목을 입력하세요.
		String messageTitle = subTitle;
		//푸시 발송 내용을 입력하세요.
		String messageContent = msg;
		
		//String cuids ="{\"user1\":[\"01094184422\",\"홍길동\"]}";
		String cuids ="{\"user1\":[\"" + cuid + "\",\"홍길동\"]}";
		
		try {
			SSLContext sslContext = SSLContext.getInstance("TLSv1.2");
			TrustManagerFactory trustManagerFactory = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
			trustManagerFactory.init((KeyStore) null);
			sslContext.init(null, (TrustManager[]) trustManagerFactory.getTrustManagers(), null);
			SSLSocketFactory sslSocketFactory = sslContext.getSocketFactory();
			
			HashMap<String, Object> params = new HashMap<String, Object>();
			
			params.put("APIKEY", apiKey);
			params.put("PROJECT_ID", projectId);
			params.put("REQ_TRAN_TYPE", "REAL");
			params.put("TARGET_USER_TYPE", "NM");
			params.put("SENDERID", senderId);
			params.put("APP_ID", appId);
			//params.put("KKO_TITLE", messageTitle);
			params.put("ALLIMTALK_MSG", messageContent);
			params.put("CUIDS", cuids);
			params.put("CALLBACK_NUM", "01065564022");
			params.put("KKOALT_SVCID", alimId);
			params.put("ALLIMTOLK_TEMPLCODE", AlimTemplateCode);
			
			StringBuilder postData = new StringBuilder();
			for(Map.Entry<String,Object> param : params.entrySet())
			{
				if(postData.length() != 0)
					postData.append('&');
				postData.append(param.getKey());
				postData.append('=');
				postData.append(String.valueOf(param.getValue()));
			}

 			System.out.println("Send Data " + postData.toString());
			
 			byte[] postDataBytes = postData.toString().getBytes();
 			
 			URL obj = new URL(API_URL); // 호출할 URL
			HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();
			con.setSSLSocketFactory(sslSocketFactory);
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
			con.setDoOutput(true);
			con.getOutputStream().write(postDataBytes); // POST 호출

 			
 			//httpPost.setEntity(new UrlEncodedFormEntity(nvps, "UTF-8"));
 			
			in = new BufferedReader(new InputStreamReader(con.getInputStream(), StandardCharsets.UTF_8));
			String line;
			while ((line = in.readLine()) != null) {
				System.out.println(line);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

}
