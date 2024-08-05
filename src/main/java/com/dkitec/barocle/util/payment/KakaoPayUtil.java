package com.dkitec.barocle.util.payment;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.databind.ObjectMapper;

import javax.net.ssl.HttpsURLConnection;


public class KakaoPayUtil {
	
	//private static final String FILE_PATH   = "D:/logs";
	private static final String FILE_PATH   = "/kakaoPayLogs";
	
	private String READY_URI    			= "";
	private String INFO_URI					= "";
	private String STATUS_URI				= "";
	private String APPROVE_URI				= "";
	private String SUBSCRIPTION_URI			= "";
	private String ORDER_URI      			= "";
	private String INACTIVE_URI				= "";
	private String CANCEL_URI      			= "";

	//생성자
	public KakaoPayUtil(){
		READY_URI 			= "https://kapi.kakao.com/v1/payment/ready";
		ORDER_URI			= "https://kapi.kakao.com/v1/payment/order";
		STATUS_URI			= "https://kapi.kakao.com/v1/payment/status";
		APPROVE_URI 		= "https://kapi.kakao.com/v1/payment/approve";
		SUBSCRIPTION_URI	= "https://kapi.kakao.com/v1/payment/subscription";
		INACTIVE_URI 		= "https://kapi.kakao.com/v1/payment/inactive";
		CANCEL_URI 			= "https://kapi.kakao.com/v1/payment/cancel";
	}
	
	ObjectMapper mapper = new ObjectMapper();
	java.text.SimpleDateFormat dateformat = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss");
	
	/**
	 * 자동결제 등록요청
	 * @param map
	 * @param logYn : Y/N
	 * @return
	 */            
	public String ready(HashMap<String, String> map, String kakaoAK, String logYn){ 
		
	    String returnStr = "";
	    
	    try {
	    	
			returnStr = getSSLConnection( READY_URI, map, kakaoAK);
	    	 
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][자동결제 등록요청] " +"[callUrl :" + READY_URI +" ] " + mapper.writeValueAsString(map), logYn);
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][자동결제 등록요청 결과] " + returnStr, logYn);
	    	
	    } catch (Exception e){
	    	e.printStackTrace();
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
	public String status(HashMap<String, String> map,String kakaoAK, String logYn){
		
	    String returnStr = "";
	    
	    try {
	    	returnStr = getSSLConnection( STATUS_URI, map, kakaoAK);
    		
	    	makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][자동결제 정보조회] " +"[callUrl :" + INFO_URI +" ] " + mapper.writeValueAsString(map), logYn);
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][자동결제 정보조회 결과] " + returnStr, logYn);
	    } catch (Exception e){
	    	returnStr = "{\"code\":\"9999\",\"message\":\""+e.getMessage()+"\"}";
	    }
	    return returnStr;
	}
	
	/**
	 * 주문상세 정보조회 
	 * @param map
	 * @param logYn : Y/N
	 * @return
	 */
	public String order(HashMap<String, String> map,String kakaoAK, String logYn){
		
	    String returnStr = "";
	    
	    try {
	    	returnStr = getSSLConnection( STATUS_URI, map, kakaoAK);
    		
	    	makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][주문상세 정보조회] " +"[callUrl :" + ORDER_URI +" ] " + mapper.writeValueAsString(map), logYn);
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][주문상세 정보조회 결과] " + returnStr, logYn);
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
	public String approve(HashMap<String, String> map, String kakaoAK, String logYn){
		String returnStr = "";
		
		try {
	    	returnStr = getSSLConnection( APPROVE_URI, map, kakaoAK);
	    	
	    	makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][결제요청] " +"[callUrl :" + APPROVE_URI +" ] " + mapper.writeValueAsString(map), logYn);
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][결제요청 결과] " + returnStr, logYn);
	    } catch (Exception e){
	    	returnStr = "{\"code\":\"9999\",\"message\":\""+e.getMessage()+"\"}";
	    }
		
		return returnStr;
	}
	
	/**
	 * 자동결제 삭제요청
	 * @param map
	 * @param logYn : Y/N
	 * @return
	 */
	public String delete(HashMap<String, String> map, String kakaoAK, String logYn){
		String returnStr = "";
		
		try {
	    	returnStr = getSSLConnection( INACTIVE_URI, map, kakaoAK);
	    	
	    	makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][자동결제 삭제요청] " +"[callUrl :" + INACTIVE_URI +" ] " + mapper.writeValueAsString(map), logYn);
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][자동결제 삭제요청 결과] " + returnStr, logYn);
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
	public String cancel(HashMap<String, String> map, String kakaoAK, String logYn){
		String returnStr = "";
		
		try {
	    	returnStr = getSSLConnection( CANCEL_URI, map, kakaoAK);
	    	
	    	makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][주문취소요청] " +"[callUrl :" + CANCEL_URI +" ] " + mapper.writeValueAsString(map), logYn);
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][주문취소결과] " + returnStr, logYn);
	    } catch (Exception e){
	    	returnStr = "{\"code\":\"9999\",\"message\":\""+e.getMessage()+"\"}";
	    }
		
		return returnStr;
	}
	
	
	public String getConnection(String apiUrl, String arrayObj, String kakaoAK) throws Exception{
		
		URL url 			  = new URL(apiUrl); 	// 요청을 보낸 URL
		String sendData 	  = arrayObj;
		HttpURLConnection con = null;
		StringBuffer buf 	  = new StringBuffer();
		String returnStr 	  = "";
		
		try {
			con = (HttpURLConnection)url.openConnection();
			
			con.setConnectTimeout(30000);		//서버통신 timeout 설정. 페이코 권장 30초
			con.setReadTimeout(30000);			//스트림읽기 timeout 설정. 페이코 권장 30초
			
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
			con.setRequestProperty("Authorization", "KakaoAK " + kakaoAK);
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
	
	public String getSSLConnection(String apiUrl, HashMap<String, String> arrayObj, String kakaoAK) throws Exception{
		
		URL url 			   = new URL(apiUrl); 	// 요청을 보낸 URL
		String sendData 	   = getDataString(arrayObj);
		
		HttpsURLConnection con = null;
		StringBuffer buf 	   = new StringBuffer();
		String returnStr 	   = "";
		
		try {
			con = (HttpsURLConnection)url.openConnection();
			
			con.setConnectTimeout(30000);		//서버통신 timeout 설정. 페이코 권장 30초
			con.setReadTimeout(30000);			//스트림읽기 timeout 설정. 페이코 권장 30초
			con.setRequestProperty("Authorization", "KakaoAK " + kakaoAK);
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
			con.setDoOutput(true);
		    con.setRequestMethod("POST");
		    con.connect();
		    // 송신할 데이터 전송.
		    DataOutputStream dos = new DataOutputStream(con.getOutputStream());
		    dos.write(sendData.getBytes("UTF-8"));
		    dos.flush();
		    dos.close();
		    int resCode = con.getResponseCode();
		    
		    if (resCode == HttpsURLConnection.HTTP_OK) {
		    	BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
				int c;
			    
			    while ((c = br.read()) != -1) {
			    	buf.append((char)c);
			    }
			    returnStr = buf.toString();
			    br.close();
		    } else {
		    	returnStr = "{ \"code\" : "+resCode+", \"message\" : \""+con.getResponseMessage()+"\" }";
		    }
		    
		} catch (IOException e) {
			e.printStackTrace();
			int result = 0;
		} finally {
		    con.disconnect();
		}
		
		return returnStr;
	}
	
	public static void makeServiceCheckApiLogFile(String logText, String logYn) {
		
		if(logYn.equals("Y")){
			String filePath   = FILE_PATH;
		  	java.text.SimpleDateFormat dateformat = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss");
		  	String nowTotDate = dateformat.format(new java.util.Date());
		  	Integer nowdate = Integer.parseInt( nowTotDate.substring(0, 8) );
		   
			String fileName = "service_check_log_" + nowdate + ".txt"; //생성할 파일명
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
		
	private String getDataString(HashMap<String, String> params) throws UnsupportedEncodingException{
	    StringBuilder result = new StringBuilder();
	    boolean first = true;
	    for(Map.Entry<String, String> entry : params.entrySet()){
	        if (first)
	            first = false;
	        else
	            result.append("&");    
	        result.append(URLEncoder.encode(entry.getKey(), "UTF-8"));
	        result.append("=");
	        result.append(URLEncoder.encode(entry.getValue(), "UTF-8"));
	    }    
	    return result.toString();
	}
}

