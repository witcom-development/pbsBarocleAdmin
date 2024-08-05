package com.dkitec.barocle.util.payment;

import java.io.IOException;
import java.net.URL;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class NiceCheckUtil {
	
	private static final String niceUid   	= "NID204689";		// NICE에서 발급받은 사이트코드
	private static final String svcPwd   	= "78950274";		// NICE에서 발급받은 사이트 패스워드
	private static final String strCharset  = "UTF-8";		 	// 인증서버의 한글 인코딩 (EUC-KR, UTF-8)
	private static final String service		= "2";		// request.getParameter("service");		// 서비스구분 ( 1:소유주, 2: 예금주명, 3 : 계좌유효성 )
	private static final String svcGbn		= "2"; 		// request.getParameter("svcGbn");		// 업무구분    ( 5:소유주, 2: 예금주명, 4 : 계좌유효성 )
	private static final String strGbn		= "1";		// request.getParameter("strGbn");		// 계좌구분 (1:개인계좌, 2:법인계좌)
	private static final String inq_rsn 	= "90";		// 조회사유 설정 (10:회원가입 20:기존회원인증 30:성인인증 40:비회원확인 90:기타)
	
	//생성자
	public NiceCheckUtil(String serverType){
		
	}
	

	//계좌인증 소켓-POST 함수
	/**
	 * @param strBankCode	은행코드
	 * @param strAccountNo	계좌번호
	 * @param strNm			이름
	 * @param strResId		생년월일 ( "" 이더도 가능 )
	 * @return
	 * @throws Exception 
	 */
	public static Map<String, String> bankCheck( String strBankCode, String strAccountNo, String strNm, String strResId ) throws Exception  
	{
		String strOrderNo = new SimpleDateFormat("yyyyMMdd").format(new Date()) + (Math.round(Math.random() * 10000000000L) + "");
		
		// 결과값 초기화
		String result = "";
		
		// NICE 계좌인증 호스트
		String host = "secure.nuguya.com";

		// NICE 계좌인증 URL(EUC-KR)																													
		
		String target = "https://secure.nuguya.com/nuguya/service/realname/sprealnameactconfirm.do";
		if (strCharset.equals("UTF-8")){
			// NICE 계좌인증 URL(UTF-8)
			target = "https://secure.nuguya.com/nuguya2/service/realname/sprealnameactconfirm.do";
		}	
		
		// 계좌인증 파라미터 설정
		String postValues = "niceUid" 				+ "=" + niceUid	
							+ "&" + "svcPwd"		+ "=" + svcPwd	
							+ "&" + "service"		+ "=" + service	
							+ "&" + "svcGbn"		+ "=" + svcGbn	
							+ "&" + "strGbn"		+ "=" + strGbn	
							+ "&" + "strBankCode"	+ "=" + strBankCode	
							+ "&" + "strAccountNo"	+ "=" + strAccountNo	
							+ "&" + "strNm"			+ "=" + strNm	
							+ "&" + "strResId"		+ "=" + strResId	
							+ "&" + "inq_rsn"		+ "=" + inq_rsn	
							+ "&" + "strOrderNo"	+ "=" + strOrderNo;
		
		// URL 및 파라미터 확인
		// System.out.println("URL:\n" + target);
		// System.out.println("POST:\n" + postValues);
		
		// 소켓 포트 설정 (HTTP:80, HTTPS:443)
		int port = 443;
		
		// 소켓 타임아웃 (10초)
		int timeout = 10;
		
		String rs = null;
		try {
			rs = getSSLConnection(target, postValues);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Map<String, String> rsMap = new HashMap<String, String>();
		String resultCode = ""; 
		String resultOrderNo = "";
		String resultMsg = "";
		
		
		if ( rs != null ) {
			String[] bcResults = rs.split("\\|");
	 		// 결과값 추출
	 		resultOrderNo = bcResults[0];	// 주문번호
	 		resultCode    = bcResults[1];	// 결과코드
	 		resultMsg     = bcResults[2];	// 결과메세지
	      	
	 		
	 		if( "0000".equals(resultCode) ) {
	 			rsMap.put("IS_SUCCESS", "1");	// 성공
	 		} else {
	 			rsMap.put("IS_SUCCESS", "0");	// 실패
	 		}
		} else {
			rsMap.put("IS_SUCCESS", "0");	// 실패
		}
 		String errMsg = getErrorMessage( resultCode);
 		
 		rsMap.put("RESULT_CODE", ( errMsg == "" ? resultMsg : errMsg  ));
 		rsMap.put("RESULT_MSG" , resultMsg);
 		
		return rsMap;
	}
	
	public static String getErrorMessage( String errorCode ) {
		
		String rsMsg ="";
		
		switch ( errorCode ) {
		case "0000" :	rsMsg = "정상처리 ";						break;
		case "DB01" :	rsMsg = "해당 데이터가 존재하지 않음 "; 		break;
		case "DB02" :	rsMsg = "실명조회 DB 에러 "; 				break; 	// “계좌 소유주 확인” 가능 은행이 아니면 NICE의 실명DB를 참조하게 됨. 실명정보 등록 필요 (www.niceid.co.kr 참조)
		case "D100" :	rsMsg = "ID에 할당된 사업자번호 오류 "; 		break; 
		case "D200" :	rsMsg = "주민번호 오류 "; 					break; 
		case "D300" :	rsMsg = "사업자번호 오류"; 					break;
		case "D400" :	rsMsg = "계좌구분 오류 "; 					break; 
		case "D500" :	rsMsg = "서비스 구분 오류 "; 				break;
		case "D600" :	rsMsg = "LG데이콤 Key 오류"; 				break;
		case "D700" :	rsMsg = "거래일자오류"; 					break; 
		case "D800" :	rsMsg = "거래시간오류"; 					break; 
		case "D900" :	rsMsg = "조회은행코드오류 "; 				break;
		case "D101" :	rsMsg = "조회 생년월일 오류 "; 				break;
		case "D102" :	rsMsg = "조회 사업자번호 오류 "; 				break; 
		case "D103" :	rsMsg = "조회 계좌번호 오류 "; 				break;
		case "D104" :	rsMsg = "Flag오류"; 						break; 
		case "D105" :	rsMsg = "구분 오류 "; 						break; 
		case "TIME" :	rsMsg = "TIMEOUT(응답지연)"; 				break; 
		case "DSYS" :	rsMsg = "금융 공동망 시스템 장애 "; 			break;
		case "OVER" :	rsMsg = "동시 접속자수 초과 "; 				break;	// 동시 접속자 수를 30 이하로 유지
		case "D888" :	rsMsg = "당행서비스가 불가능함";				break;
		case "D999" :	rsMsg = "서비스 시간 아님 "; 				break;
		case "B004" :	rsMsg = "예금주명-불일치"; 					break;	// 1) 일부 고객 발생 시 계좌정보 확인2) 모든 고객 발생 시 한글인코딩 확인
		case "B005" :	rsMsg = "미등록코드"; 						break;	// 인증결과의 “내용” 확인 필요
		case "B101" :	rsMsg = "타행(공동망) or 은행시스템오류" ; 	break; 
		case "B102" :	rsMsg = "계좌오류"; 						break; 	// 계좌정보 확인 필요
		case "B103" :	rsMsg = "생년월일 or 사업자번호 불일치" ; 		break;	// 계좌정보 확인 필요
		case "B104" :	rsMsg = "예금주명-불일치"; 					break;	// 계좌정보 확인 필요
		case "B199" :	rsMsg = "계좌번호/은행 확인";				break; 	// 인증 가능한 계좌인지 은행에 문의,	(가상계좌나 일부 증권계좌 인증불가)

		case "C001" :	rsMsg = "ConnectionFail "; 				break;	// Nice 통신 상태 확인 필요
		case "C002" :	rsMsg = "DataWrite Fail "; 				break;	// Nice 통신 상태 확인 필요
		case "C003" :	rsMsg = "DataRead Fail"; 				break;	// Nice 통신 상태 확인 필요
		case "S606" :	rsMsg = "계좌소유주명 오류"; 				break;	// 외국인은 오류 아님 (성공으로 처리)
		case "E999" :	rsMsg = "내부 오류 "; 						break;	// 1) 파라미터 누락 확인	2) 생년월일/사업자번호 자릿수 확인 3) NICE 기술지원팀에 POST 요청에 실린 값 발송해 지원요청
		// NICE 전산 담당자에게 문의 (02-2122-4872)
		default : rsMsg = "";
		}            
		return rsMsg;
	}
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
			
		/************************************************************************************************
		NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
		
		서비스명 : 계좌확인 서비스 
		페이지명 : 계좌확인 인증요청 페이지

		방화벽 이용 시 아래 IP와 Port를 오픈해주셔야 합니다
		IP : 121.162.155.160 / Port : 80, 443
		*************************************************************************************************/
		String niceUid = "NID204689";				// NICE에서 발급받은 사이트코드
		String svcPwd  = "78950274";				// NICE에서 발급받은 사이트 패스워드
		String strCharset = "UTF-8";		// 인증서버의 한글 인코딩 (EUC-KR, UTF-8)
		
		// 한글 인코딩 설정
		// request.setCharacterEncoding("utf-8");
		// request.setCharacterEncoding("euc-kr");
		
		// 입력 페이지에서 전달된 입력값 취득
		String service		= "3";	// request.getParameter("service");		// 서비스구분 ( 1:소유주, 2: 예금주명, 3 : 계좌유효성 )
		String svcGbn		= "4"; 	// request.getParameter("svcGbn");		// 업무구분    ( 5:소유주, 2: 예금주명, 4 : 계좌유효성 )
		String strGbn		= "1";	// request.getParameter("strGbn");		// 계좌구분 (1:개인계좌, 2:법인계좌)
		String strBankCode	= "003";// request.getParameter("strBankCode");	// 은행코드
		String strAccountNo	= "48420201266649";	// request.getParameter("strAccountNo");	// 계좌번호
	
		
	    // 예금주명 초기화 및 취득
		String strNm = "양재영";
		 
		// 생년월일 초기화 및 취득 (개인-생년월일 6자리, 법인-사업자번호 10자리)
		String strResId = "820215";
		 
		// 주문번호 설정 (중복값 설정 불가, 소스 수정 불필요)	
		String strOrderNo = new SimpleDateFormat("yyyyMMdd").format(new Date()) + (Math.round(Math.random() * 10000000000L) + "");  	
	
		// 조회사유 설정 (10:회원가입 20:기존회원인증 30:성인인증 40:비회원확인 90:기타)	
		String inq_rsn = "90";			
	
		// 계좌인증 처리
		/*String bcResult = bankCheck(strBankCode, strAccountNo, strNm, strResId); 
	
		// 결과값 분할
		String[] bcResults = bcResult.split("\\|");
		
		// 결과값 추출
		String resultOrderNo = bcResults[0];	// 주문번호
		String resultCode    = bcResults[1];	// 결과코드
		String resultMsg     = bcResults[2];	// 결과메세지
		
		// 결과값 출력
		System.out.println("주문번호  : "  + resultOrderNo + "<br>");
		System.out.println("결과코드  : "  + resultCode + "<br>");
		System.out.println("결과메시지 : " + resultMsg + "<br>");*/
		
	}
	

	public static String getSSLConnection(String apiUrl, String arrayObj ) throws Exception{
		
		URL url 			   = new URL(apiUrl); 	// 요청을 보낸 URL
		String sendData 	   = arrayObj;   // TODO arrayObj.replace("{", "").replace("}", "");
		String returnStr 	   = "";
		try {
			
			// Create a trust manager that does not validate certificate chains
	        final TrustManager[] trustAllCerts = new TrustManager[]{
	                new X509TrustManager() {
	                    @Override
	                    public void checkClientTrusted(java.security.cert.X509Certificate[] chain,
	                                                   String authType) throws CertificateException {
	                    }

	                    @Override
	                    public void checkServerTrusted(java.security.cert.X509Certificate[] chain,
	                                                   String authType) throws CertificateException {
	                    }

	                    @Override
	                    public java.security.cert.X509Certificate[] getAcceptedIssuers() {
	                        return new X509Certificate[0];
	                    }
	                }
	        };
	        
	     // Install the all-trusting trust manager
	        final SSLContext sslContext = SSLContext.getInstance("SSL");
	        
	        sslContext.init(null, trustAllCerts, new java.security.SecureRandom());
	        final SSLSocketFactory sslSocketFactory = sslContext.getSocketFactory();
	        
	        OkHttpClient client = new OkHttpClient.Builder()
            .sslSocketFactory(sslSocketFactory, (X509TrustManager) trustAllCerts[0])
            .hostnameVerifier(new HostnameVerifier() {
                @Override
                public boolean verify(String hostname, SSLSession session) {
                    return true;
                }
            })
            .connectTimeout(1, TimeUnit.MINUTES)
            .readTimeout(30, TimeUnit.SECONDS)
            .writeTimeout(15, TimeUnit.SECONDS)
            .build();
	        
			/*OkHttpClient client = new OkHttpClient().newBuilder()
					  .connectTimeout(1, TimeUnit.MINUTES)
					  .readTimeout(30, TimeUnit.SECONDS)
					  .writeTimeout(15, TimeUnit.SECONDS)
					  .build();*/
			
			MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
			//RequestBody body = RequestBody.create(mediaType, "productCode=BIL_001&productName=바로클_일년권&totalPayAmount=30000&returnUrl=http://175.125.130.68/app/mybike/addpay/addAutoPayMethod.do&actionType=NEW");
			RequestBody body = RequestBody.create(mediaType, sendData);
			Request request = new Request.Builder()
			  .url(apiUrl)
			  .method("POST", body)
			  .addHeader("Content-Type", "application/x-www-form-urlencoded")
			  .build();
			Response response = client.newCall(request).execute();
			
			if (response.code() != 200) {
				
				returnStr = "|9999|[계좌확인 기타오류] 계좌검증사이트 오류";
				
			    throw new IOException(
			     String.format(
			      "Failed to change log level in Compute Engine. Code was '%s' and response was '%s' for url '%s'",
			      response.code(),
			      response.body().string(),
			      url));
			   } else {
				   returnStr = response.body().string();
				   System.out.println(returnStr);
			   }
		    
		} catch ( Exception e) {
			System.out.println(e.getLocalizedMessage());
			e.printStackTrace();
			//int result = 0;
		} finally {
		}
		
		//return returnStr;
		return returnStr;
	}
	

}
