package com.dkitec.barocle.util.payment;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import com.fasterxml.jackson.databind.ObjectMapper;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import okhttp3.ResponseBody;
import org.apache.http.HttpResponse;
import okhttp3.internal.http.HttpHeaders;

import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.TrustStrategy;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.ssl.SSLContexts;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

public class NaverPayUtil {
	
	//private static final String FILE_PATH   = "D:/logs";
	private static final String FILE_PATH   = "/naverPayLogs";
	
	private String RESERVE_URI    			= "";
	private String APPROVAL_URI				= "";
	private String EXPIRE_URI      			= "";
	private String INFO_URI					= "";
	private String PAY_RESERVE_URI			= "";
	private String PAYMENT_URI				= "";
	private String MOBILE_PAYMENT_URI		= "";
	private String CANCEL_URI      			= "";
	private String LIST_URI      			= "";

	//생성자
	public NaverPayUtil(String serverType){
		
		if(serverType.equals("DEV")){
			RESERVE_URI 		= "https://dev.apis.naver.com/np_etlod545733/naverpay/payments/recurrent/regist/v1/reserve";
			PAY_RESERVE_URI 	= "https://dev.apis.naver.com/np_etlod545733/naverpay/payments/recurrent/pay/v3/reserve";
			APPROVAL_URI		= "https://dev.apis.naver.com/np_etlod545733/naverpay/payments/recurrent/regist/v1/approval";
			EXPIRE_URI			= "https://dev.apis.naver.com/np_etlod545733/naverpay/payments/recurrent/expire/v1/request";
			LIST_URI			= "https://dev.apis.naver.com/np_etlod545733/naverpay/payments/recurrent/list";
			INFO_URI			= "https://dev.apis.naver.com/np_etlod545733/naverpay/payments/info";
			PAYMENT_URI 		= "https://dev.apis.naver.com/np_etlod545733/naverpay/payments/recurrent/pay/v3/approval";
			MOBILE_PAYMENT_URI 	= "https://test-m.naver.com/payments/";
			CANCEL_URI 			= "https://dev.apis.naver.com/np_etlod545733/naverpay/payments/v1/cancel";
		} else {
			RESERVE_URI 		= "https://apis.naver.com/np_etlod545733/naverpay/payments/recurrent/regist/v1/reserve";
			PAY_RESERVE_URI 	= "https://apis.naver.com/np_etlod545733/naverpay/payments/recurrent/pay/v3/reserve";
			APPROVAL_URI 		= "https://apis.naver.com/np_etlod545733/naverpay/payments/recurrent/regist/v1/approval";
			EXPIRE_URI 			= "https://apis.naver.com/np_etlod545733/naverpay/payments/recurrent/expire/v1/request";
			LIST_URI			= "https://apis.naver.com/np_etlod545733/naverpay/payments/recurrent/list";
			INFO_URI			= "https://apis.naver.com/np_etlod545733/naverpay/payments/info";
			PAYMENT_URI 		= "https://apis.naver.com/np_etlod545733/naverpay/payments/recurrent/pay/v3/approval";
			MOBILE_PAYMENT_URI 	= "https://m.pay.naver.com/payments/";
			CANCEL_URI 			= "https://apis.naver.com/np_etlod545733/naverpay/payments/v1/cancel";
		}
	}
	
	ObjectMapper mapper = new ObjectMapper();
	java.text.SimpleDateFormat dateformat = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss");
	
	/**
	 * 자동결제 등록요청
	 * @param map
	 * @param logYn : Y/N
	 * @return
	 */            
	public String paymentReserve(Map<String, Object> map, String clinetId, String clientSecret, String logYn){ 
		
	    String returnStr = "";
	    
	    try {
	    	
			//returnStr = getSSLConnection( RESERVE_URI, mapper.writeValueAsString(map), clinetId, clientSecret);
	    	returnStr = getSSLConnection( RESERVE_URI, makeQueryString(map), clinetId, clientSecret);
	    	
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][자동결제 등록요청] " +"[callUrl :" + RESERVE_URI +" ] " + mapper.writeValueAsString(map), logYn);
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][자동결제 등록요청 결과] " + returnStr, logYn);
	    	
	    } catch (Exception e){
	    	returnStr = "{\"code\":\"9999\",\"message\":\""+e.getMessage()+"\"}";
	    }
	    return returnStr;
	}
	
	/**
	 * 자동결제 등록완료
	 * @param map
	 * @param logYn : Y/N
	 * @return
	 */            
	public String paymentApproval(Map<String, Object> map, String clinetId, String clientSecret, String logYn){ 
		
	    String returnStr = "";
	    
	    try {
	    	
	    	returnStr = getSSLConnection( APPROVAL_URI, makeQueryString(map), clinetId, clientSecret);
	    	
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][자동결제 등록완료] " +"[callUrl :" + APPROVAL_URI +" ] " + mapper.writeValueAsString(map), logYn);
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][자동결제 등록완료 결과] " + returnStr, logYn);
	    	
	    } catch (Exception e){
	    	returnStr = "{\"code\":\"9999\",\"message\":\""+e.getMessage()+"\"}";
	    }
	    return returnStr;
	}
	
	/**
	 * 자동결제 해지
	 * @param map
	 * @param logYn : Y/N
	 * @return
	 */            
	public String paymentExpire(Map<String, Object> map, String clinetId, String clientSecret, String logYn){ 
		
	    String returnStr = "";
	    
	    try {
	    	
	    	returnStr = getSSLConnection( EXPIRE_URI, makeQueryString(map), clinetId, clientSecret);
	    	
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][자동결제 해제요청] " +"[callUrl :" + EXPIRE_URI +" ] " + mapper.writeValueAsString(map), logYn);
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][자동결제 해제요청 결과] " + returnStr, logYn);
	    	
	    } catch (Exception e){
	    	returnStr = "{\"code\":\"9999\",\"message\":\""+e.getMessage()+"\"}";
	    }
	    return returnStr;
	}
	
	/**
	 * 자동결제 등록 리스트
	 * @param map
	 * @param logYn : Y/N
	 * @return
	 */            
	public String paymentList(Map<String, Object> map, String clinetId, String clientSecret, String logYn){ 
		
	    String returnStr = "";
	    
	    try {
	    	
	    	returnStr = getSSLConnection( LIST_URI, makeQueryString(map), clinetId, clientSecret);
	    	
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][자동결제 등록 리스트] " +"[callUrl :" + LIST_URI +" ] " + mapper.writeValueAsString(map), logYn);
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][자동결제 등록 리스트 요청 결과] " + returnStr, logYn);
	    	
	    } catch (Exception e){
	    	returnStr = "{\"code\":\"9999\",\"message\":\""+e.getMessage()+"\"}";
	    }
	    return returnStr;
	}
	
	/**
	 * 자동결제 등록완료
	 * @param map
	 * @param logYn : Y/N
	 * @return
	 */            
	public String payReserve(Map<String, Object> map, String clinetId, String clientSecret, String logYn){ 
		
	    String returnStr = "";
	    
	    try {
	    	
	    	returnStr = getSSLConnection( PAY_RESERVE_URI, makeQueryString(map), clinetId, clientSecret);
	    	
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][자동결제 예약] " +"[callUrl :" + PAY_RESERVE_URI +" ] " + mapper.writeValueAsString(map), logYn);
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][자동결제 얘역요청 결과] " + returnStr, logYn);
	    	
	    } catch (Exception e){
	    	returnStr = "{\"code\":\"9999\",\"message\":\""+e.getMessage()+"\"}";
	    }
	    return returnStr;
	}
	
	/**
	 * 자동결제 정보조회 
	 * @param map
	 * @param logYn : Y/N
	 * @return
	 */
	public String paymentInfo(Map<String, Object> map, String clinetId, String clientSecret, String logYn){
		
	    String returnStr = "";
	    
	    try {
	    	returnStr = getSSLConnection( INFO_URI, makeQueryString(map), clinetId, clientSecret);
    		
	    	makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][자동결제 정보조회] " +"[callUrl :" + INFO_URI +" ] " + mapper.writeValueAsString(map), logYn);
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][자동결제 정보조회 결과] " + returnStr, logYn);
	    } catch (Exception e){
	    	returnStr = "{\"code\":\"9999\",\"message\":\""+e.getMessage()+"\"}";
	    }
	    return returnStr;
	}
	
	/**
	 * 자동결제 결제요청
	 * @param map
	 * @param logYn : Y/N
	 * @return
	 */
	public String payPayment(Map<String, Object> map, String clinetId, String clientSecret, String logYn){
		String returnStr = "";
		
		try {
	    	returnStr = getSSLConnection( PAYMENT_URI, makeQueryString(map), clinetId, clientSecret);
	    	
	    	makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][자동결제 결제요청] " +"[callUrl :" + PAYMENT_URI +" ] " + mapper.writeValueAsString(map), logYn);
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][자동결제 결제요청 결과] " + returnStr, logYn);
	    } catch (Exception e){
	    	returnStr = "{\"code\":\"9999\",\"message\":\""+e.getMessage()+"\"}";
	    }
		
		return returnStr;
	}
	
	/**
	 * 주문취소
	 * @param map
	 * @param logYn : Y/N
	 * @return
	 */
	public String payCancel(Map<String, Object> map, String clinetId, String clientSecret, String logYn){
		String returnStr = "";
		
		try {
	    	returnStr = getSSLConnection( CANCEL_URI, makeQueryString(map), clinetId, clientSecret);
	    	
	    	makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][주문취소요청] " +"[callUrl :" + CANCEL_URI +" ] " + mapper.writeValueAsString(map), logYn);
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][주문취소결과] " + returnStr, logYn);
	    } catch (Exception e){
	    	returnStr = "{\"code\":\"9999\",\"message\":\""+e.getMessage()+"\"}";
	    }
		
		return returnStr;
	}
	
	
	public String getConnection(String apiUrl, String arrayObj) throws Exception{
		
		URL url 			  = new URL(apiUrl); 	// 요청을 보낸 URL
		String sendData 	  = arrayObj;
		HttpURLConnection con = null;
		StringBuffer buf 	  = new StringBuffer();
		String returnStr 	  = "";
		
		try {
			con = (HttpURLConnection)url.openConnection();
			
			con.setConnectTimeout(30000);		//서버통신 timeout 설정. 페이코 권장 30초
			con.setReadTimeout(30000);			//스트림읽기 timeout 설정. 페이코 권장 30초
			
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
		    con.setDoOutput(true);
		    con.setRequestMethod("POST");
		    con.connect();
		    
		    // 송신할 데이터 전송.
		    DataOutputStream dos = new DataOutputStream(con.getOutputStream());
		    dos.write(sendData.getBytes("UTF-8"));
		    dos.flush();
		    dos.close();
		    
		    int resCode = con.getResponseCode();
		    
		    if (resCode == HttpURLConnection.HTTP_OK) {
		    
		    	BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			   	
				int c;
			    
			    while ((c = br.read()) != -1) {
			    	buf.append((char)c);
			    }
			    
			    returnStr = buf.toString();
			    br.close();
			    
		    } else {
		    	returnStr = "{ \"code\" : 9999, \"message\" : \"Connection Error\" }";
		    }
		    
		} catch (IOException e) {
			int result = 0;
		} finally {
		    con.disconnect();
		}
		
		return returnStr;
	}
	
	public String getSSLConnection(String apiUrl, String arrayObj, String clinetId, String clientSecret) throws Exception{
		
		URL url 			   = new URL(apiUrl); 	// 요청을 보낸 URL
		String sendData = arrayObj.replace("{", "").replace("}", "");
		HttpsURLConnection con = null;
		StringBuffer buf 	   = new StringBuffer();
		String returnStr 	   = "";
		
		HttpClient httpClient;
		StringBuffer result = new StringBuffer();
		
		try {
			
			OkHttpClient client = new OkHttpClient().newBuilder()
					  .connectTimeout(1, TimeUnit.MINUTES)
					  .readTimeout(30, TimeUnit.SECONDS)
					  .writeTimeout(15, TimeUnit.SECONDS)
					  .build();
			
			MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
			//RequestBody body = RequestBody.create(mediaType, "productCode=BIL_001&productName=바로클_일년권&totalPayAmount=30000&returnUrl=http://175.125.130.68/app/mybike/addpay/addAutoPayMethod.do&actionType=NEW");
			RequestBody body = RequestBody.create(mediaType, sendData);
			Request request = new Request.Builder()
			  .url(apiUrl)
			  .method("POST", body)
			  .addHeader("X-Naver-Client-Id", clinetId)
			  .addHeader("X-Naver-Client-Secret", clientSecret)
			  .addHeader("Content-Type", "application/x-www-form-urlencoded")
			  .build();
			Response response = client.newCall(request).execute();
			
			System.out.println(response.toString());
			
			if (response.code() != 200) {
				
				ResponseBody responseBody = response.body();
				   
				   returnStr = response.body().string();
				   System.out.println(returnStr);
				   
				returnStr = "{ \"code\" : 9999, \"message\" : \"Connection Error\" }";
				
			    throw new IOException(
			     String.format(
			      "Failed to change log level in Compute Engine. Code was '%s' and response was '%s' for url '%s'",
			      response.code(),
			      response.body().string(),
			      url));
			   } else {
				   
				   ResponseBody responseBody = response.body();
				   
				   returnStr = response.body().string();
				   System.out.println(returnStr);
			   }
		    
		} catch (IOException e) {
			//int result = 0;
		} finally {
		    //con.disconnect();
		}
		
		//return returnStr;
		return returnStr;
	}
	
	public static void makeServiceCheckApiLogFile(String logText, String logYn) {
		
		if(logYn.equals("Y")){
			String filePath   = FILE_PATH;
		  	java.text.SimpleDateFormat dateformat = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss");
		  	String nowTotDate = dateformat.format(new java.util.Date());
		  	Integer nowdate = Integer.parseInt( nowTotDate.substring(0, 8) );
		   
			String fileName = "naverPay_check_log_" + nowdate + ".txt"; //생성할 파일명
		  	String logPath = filePath + File.separator + fileName; 
		  
		  	File folder = new File(filePath); //로그저장폴더
		  	File f 		= new File(logPath);  //파일을 생성할 전체경로
		  
		  	try{
		  	
		  		if(folder.exists() == false) {
		   			folder.mkdirs();
				}

		   		if (f.exists() == false){
		    		f.createNewFile(); //파일생성
		   		}

		   		// 파일쓰기
		   		FileWriter fw = null;

		   		try {

		   			fw = new FileWriter(logPath, true); //파일쓰기객체생성
		   			fw.write(logText +"\n"); //파일에다 작성

		   		} catch(IOException e) {
		   			throw e;
		   		} finally {
		   			if(fw != null) fw.close(); //파일핸들 닫기
		   		}

		  	}catch (IOException e) { 
		  		int result = 0;
		   		//System.out.println(e.toString()); //에러 발생시 메시지 출력
		  	}
		}else{
			return;
		}
	}
	
	public static String makeQueryString (Map<String, Object> parameter) {
		String param = "";
		
		if (parameter != null) {
			StringBuffer sb = new StringBuffer();
			for (String key : parameter.keySet()) {
				if (sb.length() > 0) {
					sb.append("&");
				}
				sb.append(key);
				sb.append("=");
				sb.append(parameter.get(key));
			}
			param = sb.toString();
		} else {
			param = "";
		}
		return param;
	}
		
}

