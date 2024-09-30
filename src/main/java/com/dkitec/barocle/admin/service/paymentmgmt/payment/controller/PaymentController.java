package com.dkitec.barocle.admin.service.paymentmgmt.payment.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.URI;
import java.net.URL;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.security.KeyManagementException;
import java.security.KeyStore;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.TrustManagerFactory;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import lgdacom.XPayClient.XPayClient;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.converter.FormHttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.service.paymentmgmt.payment.ToSHA256Hex;
import com.dkitec.barocle.admin.service.paymentmgmt.payment.service.PaymentService;
import com.dkitec.barocle.admin.service.paymentmgmt.payment.vo.PaymentStatVO;
import com.dkitec.barocle.admin.service.paymentmgmt.payment.vo.PaymentVO;
import com.dkitec.barocle.admin.service.paymentmgmt.refund.vo.RefundVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.encrypt.AesCtr;
import com.dkitec.barocle.util.encrypt.HmacSha256Enc;
import com.dkitec.barocle.util.payment.AutoPayment_Util;
import com.dkitec.barocle.util.payment.HttpRestClientPay;
import com.dkitec.barocle.util.payment.KakaoPayUtil;
import com.dkitec.barocle.util.payment.NaverPayUtil;
import com.dkitec.barocle.util.payment.TmoneyPayUtil;
import com.dkitec.barocle.util.webutil.HttpUtil;
import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mainpay.sdk.net.HttpSendTemplate;
import com.mainpay.sdk.utils.MakeID;
import com.mainpay.sdk.utils.ParseUtils;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
@RequestCategory(value="PaymentController")
//@RequestMapping(value="/admin/service/paymentmgmt")
public class PaymentController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(PaymentController.class);
	
	@Resource(name = "paymentService") private PaymentService paymentService;
	
	private static final String RETUR_URL = "/admin/service/payment/pay/";
	private static final String POP_URL = "/admin/common/popup/";
	private static String cancelUrl = "https://service.paygate.net/service/cancelAPI.json?callback=callback";
	private String apiSecretKey = "victek1!"; 
	
	@RequestName(value="getPaymentList")
	@RequestMapping(value = "/getPaymentList.do")
	public String getPaymentList(@ModelAttribute @Valid PaymentVO paymentVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		
		String targetUrl = RETUR_URL.concat("svc_pay_list");
		String bizName = "결제내역 조회 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		boolean result = false;
		
		try {
			
			// 결제조회구분에 따른 분
			if ( paymentVO.getIsSearchGb() == null || "1".equals(paymentVO.getIsSearchGb())  || "1".equals( paymentVO.getIsSearchGb().substring( paymentVO.getIsSearchGb().length() -1) ) ) {
				paymentVO.setPagingYn("Y");
				if(paymentVO.getViewFlg() != null && paymentVO.getViewFlg().equals(MODE_EXCEL)) {
					paymentVO.setPagingYn("N");
				} 
				
				int sizeList = paymentService.getPaymentListCount(paymentVO);
				PaginationInfo paginationInfo = getPagingInfo(paymentVO.getCurrentPageNo(), sizeList);
				PaginationInfo paginationMobileInfo = getPagingMobileInfo(paymentVO.getCurrentPageNo(), sizeList);
				paymentVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
				paymentVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
				List<PaymentVO> resultList = paymentService.getPaymentList(paymentVO);
				model.addAttribute("paginationInfo", paginationInfo);
				model.addAttribute("paginationMobileInfo",paginationMobileInfo);
				model.addAttribute("paymentList", resultList);
			} else {
				PaymentStatVO resultStatCol = paymentService.getPaymentStatistics_col(paymentVO);
				model.addAttribute("paymentStatCol", resultStatCol);
			}
//			PaymentStatVO resultCancelStatCol = paymentService.getCancelPaymentStatistics_col(paymentVO);
//			List<PaymentVO> resultStatRow = paymentService.getPaymentStatistics_row(paymentVO);
			
			// 조회구분 초기화
			paymentVO.setIsSearchGb(""); 
			
			model.addAttribute("searchCondition", paymentVO);
//			model.addAttribute("paymentCancelStatCol", resultCancelStatCol);
// 미사용			
//			model.addAttribute("paymentStatRow", resultStatRow);
			result =true;
		} catch(CfoodException e) {
			throw new CfoodException( "fail.common.msg" , e );
		}  catch(Exception e) {
			throw new CfoodException( "fail.common.msg" , e );
		}
		
		if(paymentVO.getViewFlg().equals(MODE_EXCEL)) {
			targetUrl =  RETUR_URL.concat("svc_pay_list_excel");
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName(value="getLatestSms")
	@RequestMapping(value="/getLatestSms.do")
	public String getLatestSms(@ModelAttribute @Valid PaymentVO paymentVO, BindingResult bResult, ModelMap model, HttpServletRequest request ) throws Exception {
		String bizName = "최근 SMS메시지 확인";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		String resultMessage = "Fail";
		
		try {
			String resultSmsMessage = null;
			resultSmsMessage = paymentService.getLatestSms(paymentVO);
			if(resultSmsMessage != null){
				resultMessage = "Success";
			}
			model.addAttribute("smsMessage", resultSmsMessage);
			
		}catch(CfoodException e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		
		model.addAttribute(RESULT_MESSAGE, resultMessage);
		
		return JSONVIEW;
	}
	
	@RequestName(value="getRefundInfo")
	@RequestMapping(value = "/moveRefundPop.do")
	public String getRefundInfo(@ModelAttribute RefundVO refundVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		String targetUrl = POP_URL.concat("pop_rep_pro");
		String bizName = "환불 처리 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		boolean result = false;
		try {
			RefundVO resultVo = null;
			if(refundVO.getViewFlg().equals(MODE_UPDATE) || refundVO.getViewFlg().equals(MODE_VIEW)) {
				resultVo = paymentService.getRefundInfo(refundVO);
			} else {
				refundVO.setRefndAmt(paymentService.getRefundTempAmt(refundVO) + "");
				
				resultVo = refundVO;
			}
			model.addAttribute("refundVO", resultVo);
			model.addAttribute("viewFlg", refundVO.getViewFlg());
			model.addAttribute("couponNo", refundVO.getCouponNo());	//선물받은 쿠폰 NO
			model.addAttribute("useYn", refundVO.getUseYn());		//이용권 사용 유무
			model.addAttribute("paymentClsCd", refundVO.getPaymentClsCd());//결제구분
			model.addAttribute("paymentMethodCd", refundVO.getPaymentMethodCd());//결제방법

			result =true;
			
		}catch(CfoodException e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName(value="addRefund")
	@RequestMapping(value="/addRefund.do")
	public String addRefund(@ModelAttribute @Valid RefundVO refundVO, BindingResult bindingResult, ModelMap model, HttpServletRequest request ) throws Exception {
		String bizName = "환불처리";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		String resultMessage = "수정에 성공했습니다.";
		UserSessionVO user = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		String adminId = user == null ? "test" : user.getUsrId();
		
		String couponNo = refundVO.getCouponNo();
		
		int result = 0;
		if(bindingResult.hasErrors()) {
			
			for(ObjectError error : bindingResult.getAllErrors()) {
				resultMessage = error.getDefaultMessage();
			}
			
		} else {
			if(refundVO.getViewFlg().equals(MODE_INSERT)) {
				
				RefundVO vo = paymentService.getRefundInfo(refundVO);
				
				refundVO.setRefundAdminId(adminId);
				result = paymentService.addRefund(refundVO);
				result = paymentService.setRefundStus(refundVO);
				result = paymentService.insertAccount(refundVO);	// 회원정보 입력
				
				
				if(!(refundVO.getPaymentClsCd().equals("BIL_009"))){		//초과요금 건은 이용권과 무관_2017.06.09_JHN
					result = paymentService.updateVoucherInfo(refundVO);	// 환불 시 이용권정보 만료_20161026_JJH
				}
				
//				if(!"null".equals(couponNo) || !"".equals(couponNo)){	// 환불시 보낸이용권 테이블 사용 Y로 변경_20161116_cms
				if(!"null".equals(couponNo) && !"".equals(couponNo)){	// 수정_JHN_2017.07.02
					paymentService.udtCoupon(couponNo);
				}
				
				
				
			}
		}
		model.addAttribute(RESULT_MESSAGE, resultMessage);
		model.addAttribute(RESULT, result);
		
		return JSONVIEW;
	}
	
	@RequestName(value="moveCancelPop")
	@RequestMapping(value = "/moveCancelPop.do")
	public String getCancelInfo(@ModelAttribute PaymentVO paymentVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		String targetUrl = POP_URL.concat("pop_cac_pro");
		String bizName = "결제 취소 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		boolean result = false;
		System.out.println("paymentVO useYn :: " +paymentVO.getUseYn());
		
		try {
			PaymentVO resultVo = null;
			if(paymentVO.getViewFlg().equals(MODE_UPDATE) || paymentVO.getViewFlg().equals(MODE_VIEW)) {
				resultVo = paymentService.getCancelInfo(paymentVO);
			} else {
				resultVo = paymentVO;
			}
			model.addAttribute("paymentVO", resultVo);
			model.addAttribute("viewFlg", paymentVO.getViewFlg());
			model.addAttribute("couponNo", paymentVO.getCouponNo());	//선물받은 쿠폰 NO
			model.addAttribute("useYn", paymentVO.getUseYn());			//이용권 사용 유무
			
			result =true;
		}catch(CfoodException e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	/**
	 * 페이게이트 결제취소 연동_20160812_JJH
	 * @param paymentVO
	 * @param bindingResult
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestName(value="setPaymentCancel")
	@RequestMapping(value="/setPaymentCancel.do")
	public String setPaymentCancel(@ModelAttribute @Valid PaymentVO paymentVO, BindingResult bindingResult, ModelMap model, HttpServletRequest request ) throws Exception, NoSuchAlgorithmException, KeyManagementException {
		String bizName = "결제취소";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		
		System.out.println("paymentVO.getViewFlg()  :  " + paymentVO.getViewFlg());
		
		String resultMessage = "수정에 성공했습니다.";
		UserSessionVO user = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		String adminId = user == null ? "test" : user.getUsrId();
		
		int result = 0;
		PaymentVO cancleVO = new PaymentVO();
		 
		if(bindingResult.hasErrors()) {
			for(ObjectError error : bindingResult.getAllErrors()) {
				resultMessage = error.getDefaultMessage();
			}
		} else {
			
			if( paymentVO.getViewFlg().equals(MODE_INSERT)
					|| paymentVO.getViewFlg().equals("E")	// 2022.02.11 강제 취소 추가
					) {
				//이용권 체크
				int rentHist =0;
				paymentVO.setCancelAdminId(adminId);
				String voucher = paymentService.chkVoucherStatus(paymentVO);
				
				Map <String, String> paramMap = new HashMap<String, String>();
				paramMap = paymentService.getPaymentCancelInfo(paymentVO);
				paramMap.put("paySeq",String.valueOf(paymentVO.getPaymentSeq()));
				boolean returnVal = false;
				
				// 결제 구분에 따른 취소
				returnVal = canclePayType(paramMap);
				
				if(returnVal){
				
					if(voucher != null) {
						
						rentHist  = paymentService.chkRentHistStatus(voucher);
						// 2022 02 11 강제 취소 또는 대여이력이 없을 때
						if( rentHist == 0 || paymentVO.getViewFlg().equals("E") ) {
							paymentService.delVoucherInfo(paymentVO);
							result = paymentService.setPaymentCancel(paymentVO);
							// 마일리지 원복
							cancleVO = paymentService.getMileChk(paymentVO);
							
							if (cancleVO.getMileagePaymentAmt() > 0) {
								cancleVO.setCancelAdminId(paymentVO.getCancelAdminId());
								result = paymentService.addMileageUse(cancleVO);
							}
							
						} else {
							
							resultMessage = "사용이력이 존재합니다";
							
						}
						
					} else {
						
						paymentService.delVoucherInfo(paymentVO);
						//선물 이용권 체크
						paymentService.delCoupon(paymentVO);
						result = paymentService.setPaymentCancel(paymentVO);
					} 
				} else {
					resultMessage = "결제취소가 완료되지 않았습니다.";
				}
			}
		}
		 
		model.addAttribute(RESULT_MESSAGE, resultMessage);
		model.addAttribute(RESULT, result);
		
		return JSONVIEW;
	}
	
	private boolean canclePayType(Map<String, String> paramMap) {
		boolean returnVal;
		switch( paramMap.get("paymentMethodCd") ) {
		case "BIM_001" :	returnVal = mainPayCancelAPI(paramMap);		break;		// 메인페이 결제 취소 추가
		case "BIM_002" :
		case "BIM_003" :	returnVal = false;	// payGate는 아예 리턴
		case "BIM_007" :	returnVal = paycoCancelAPI(paramMap);		break;
		case "BIM_008" :
		case "BIM_009" :	returnVal = lgUplusCancelAPI(paramMap);		break;
		case "BIM_010" :
			// 2020-10-30 : kakao cancel api에서 필수요구사항 체크
			if( ( paramMap.get("tId") != null && !"".equals(paramMap.get("tId")) ) 
					&& ( paramMap.get("totAmt") != null && !"".equals(paramMap.get("totAmt")) ) ){
				returnVal = kakaoCancelAPI(paramMap);
			}else{
				returnVal = false;
			}															break;
		case "BIM_012" :	returnVal = zeroPayCancelAPI(paramMap);		break;
		case "BIM_013" :	
		case "BIM_014" :	
		case "BIM_015" :	returnVal = naverPayCancelAPI(paramMap);	break;
		case "BIM_016" :	// 20211112 BIM_016 코드 추가
		case "BIM_017" :	
		case "BIM_018" :	
		case "BIM_019" :	returnVal = tmoneyPayCancelAPI(paramMap);	break;
		case "BIM_020" :	returnVal = mainPayCancelAPI(paramMap);	break;
		
		default :	returnVal = false;
		}
		return returnVal;
	}
	
	public boolean mainPayCancelAPI (Map<String, String> parmaMap) {
		
		boolean result = false;

		try {
			
			//String API_BASE = "https://dev-relay.mainpay.co.kr";				// TEST API URL
			//String mbrNo = "100011"; // 테스트 가맹점 번호
			//String apiKey = "U1FVQVJFLTEwMDAxMTIwMTgwNDA2MDkyNTMyMTA1MjM0"; // 테스트 apiKey
					
			String API_BASE = "https://relay.mainpay.co.kr";                               // REAL API URL
			String mbrNo = "114549";                                                       // REAL 가맹점번호
			String apiKey = "LovY3SkcSKoB9m3aihyaqw404jgrfsXWedHoUlPOOWlJ";                // REAL apiKey
			
			
			//String apiUrl = API_BASE + "/v1/api/payments/payment/card-auto/cancel";			// 신용카드 정기결제 결제 취소 요청 API
			String apiUrl = API_BASE + "/v1/api/payments/payment/card-auto/cancel";			// 신용카드 정기결제 결제 취소 요청 API
			java.text.SimpleDateFormat format = new java.text.SimpleDateFormat ( "yyyyMMddHHmmss");
			java.text.SimpleDateFormat format2 = new java.text.SimpleDateFormat ( "yyMMddHHmmss");
			Date date = new Date();
			String TODAY = format.format(date);
			parmaMap.put("mbrNo", mbrNo); // SPC Networks에서 부여한 가맹점번호 (상점 ID)
			parmaMap.put("mbrRefNo", MakeID.orderNo("BRC_"+TODAY, 20)); // 가맹점에서 나름대로 정한 중복되지 않는 주문번호
			parmaMap.put("clinetType","MERCHANT");
			
			Map<String, String> parameters = new HashMap<String, String>();
			
			parameters.put("mbrNo", mbrNo); // SPC Networks에서 부여한 가맹점번호 (상점 ID)
			parameters.put("mbrRefNo", "BRC_"+TODAY); // 가맹점에서 나름대로 정한 중복되지 않는 주문번호
			parameters.put("orgRefNo",parmaMap.get("tId"));	// 원거래 승인번호
			parameters.put("orgTranDate",parmaMap.get("paymentConfmDttm"));	// 원거래 승인일자
			parameters.put("payType",parmaMap.get("paymentConfmPaytype"));
			parameters.put("paymethod","CARD");
			parameters.put("amount",String.valueOf(parmaMap.get("totAmt")));
			parameters.put("timestamp", TODAY);	// 가맹점 시스템 시각 (yyyyMMddHHmmssSSS)+
			// 결제 위변조 방지 서명값 생성
			String key = mbrNo+"|BRC_"+TODAY+"|"+String.valueOf(parmaMap.get("totAmt"))+"|"+apiKey+"|"+TODAY;
			String signature = ToSHA256Hex.toSHA256Hex(key);
			parameters.put("signature",signature);
			
			
			SSLContext sslContext = SSLContext.getInstance("TLSv1.2");
			TrustManagerFactory trustManagerFactory = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
			
			trustManagerFactory.init((KeyStore) null);
            sslContext.init(null, (TrustManager[]) trustManagerFactory.getTrustManagers(), null);
            SSLSocketFactory sslSocketFactory = sslContext.getSocketFactory();
            
            HashMap<String, Object> params = new HashMap<String, Object>();

            StringBuilder postData = new StringBuilder();
            for(Map.Entry<String,String> param : parameters.entrySet())
            {
            	if(postData.length() != 0)
            		postData.append('&');
            	postData.append(param.getKey());
            	postData.append('=');
            	postData.append(String.valueOf(param.getValue()));
            }

 			System.out.println("Send Data " + postData.toString());
            
 			byte[] postDataBytes = postData.toString().getBytes();
 			
 			URL obj = new URL(apiUrl); // 호출할 URL
            HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();
            con.setConnectTimeout(10000); //10초
            con.setReadTimeout(10000); //10초
            con.setSSLSocketFactory(sslSocketFactory);
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
            con.setDoOutput(true);
            con.getOutputStream().write(postDataBytes); // POST 호출

 			
 			//httpPost.setEntity(new UrlEncodedFormEntity(nvps, "UTF-8"));
 			
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream(), StandardCharsets.UTF_8));
            String line;
            String returnStr = "";
            while ((line = in.readLine()) != null) {
            	returnStr = line;
                System.out.println("LINE : " + line);
            }
            System.out.println("returnStr : " + returnStr);
            
            //makeServiceCheckApiLogFile("[" +TODAY + "][결제취소요청] " +"[callUrl :" + apiUrl +" ] " + parameters.toString() , "Y");
    		//makeServiceCheckApiLogFile("[" +TODAY + "][결제취소요청 결과] " + returnStr , "Y");
			
			Map responseMap = ParseUtils.fromJson(returnStr, Map.class);
			String resultCode = (String) responseMap.get("resultCode");
			String resultMessage = (String) responseMap.get("resultMessage");
	
			if( ! "200".equals(resultCode)) {	// API 호출 실패		
				System.out.println(returnStr); 
				result = false;
				
			} else {
				result = true;
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			result = false;
		}
			   	
		return result;
	}
	
	public boolean lgUplusCancelAPI (Map<String, String> parmaMap) {
		
		boolean result = false;
		
		// LGU+ 처리
		String CST_PLATFORM				 = "service";
		//String CST_MID					  = "bike_seoul";
		String CST_MID					  = parmaMap.get("m_id");
		String LGD_MID					  = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;
		
		String configPath = super.propertiesService.getString("LGUPlusConfigPath");
		
		XPayClient xpay = new XPayClient();
		
		boolean isInitOK = xpay.Init(configPath, CST_PLATFORM);   	

	   	if( isInitOK ) {
	   		// 이용권 구매 취소 처리
	   		xpay.Init_TX(LGD_MID);
	   		xpay.Set("LGD_TXNAME", "Cancel");
	   		xpay.Set("LGD_TID", parmaMap.get("tId"));
	   		
	   		log.debug("이용권 구매 취소 처리 [TID:" + parmaMap.get("tId") +"]");

			result = true;
			
			if (xpay.TX() && "0000".equals(xpay.m_szResCode)) {
				result = true;
				log.debug("결제 취소요청이 완료되었습니다. CST_MID = " + CST_MID +" TX Response_code = " + xpay.m_szResCode + " TX Response_msg = " + xpay.m_szResMsg);
			} else {
				result = false;
				log.debug("결제 취소요청이 실패하였습니다. CST_MID = " + CST_MID +" TX Response_code = " + xpay.m_szResCode + " TX Response_msg = " + xpay.m_szResMsg);
			}
	   	} else {
	   		result = false;
	   	}
	   	
		return result;
	}
	
	public boolean paycoCancelAPI (Map<String, String> parmaMap) {
		
		boolean result = false;
		
		// payco 처리
		String sellerKey 		= super.propertiesService.getString("paycoSellerKey");	 	// 가맹점 코드 - 파트너센터에서 알려주는 값으로, 초기 연동 시 PAYCO에서 쇼핑몰에 값을 전달한다.
		String cpId 			= super.propertiesService.getString("paycoCpId");			// 상점ID
		String productId 		= super.propertiesService.getString("paycoProductId");		// 상품ID
		String serverType 		= super.propertiesService.getString("paycoServerType");		// 서버유형. DEV:개발, REAL:운영
		String logYn 			= super.propertiesService.getString("paycoLogYn");			// 로그Y/N
		
		ObjectMapper 	 mapper   	= new ObjectMapper(); 		  			//jackson json object
		AutoPayment_Util util 		= new AutoPayment_Util(serverType);  
		
		/* 설정한 취소요청 정보로 Json String 을 작성합니다. */		
		Map<String,Object> cancelInfo = new HashMap<String,Object>();
		cancelInfo.put("sellerKey", sellerKey);						//[필수]가맹점 코드
		cancelInfo.put("orderNo", parmaMap.get("tId")); 						//[필수]주문번호 자동결제 관리번호
		cancelInfo.put("orderCertifyKey", parmaMap.get("orderCertifyKey"));  		//[필수]주문인증 key
		cancelInfo.put("cancelTotalAmt", String.valueOf(parmaMap.get("totAmt")));  			//[필수]취소할 총 금액
		cancelInfo.put("requestMemo", "이용권 구매 취소");							//[선택]취소처리 요청메모
		
		List<Map<String,Object>> orderProducts = new ArrayList<Map<String,Object>>();
		Map<String,Object> orderProductsInfo = new HashMap<String,Object>();
		orderProductsInfo.put("sellerOrderProductReferenceKey", parmaMap.get("paymentClsCd"));	//[필수]취소상품 연동 키
		
		orderProductsInfo.put("cpId", cpId);														//[필수]상점 ID(common_include.jsp 에 설정)
		orderProductsInfo.put("productId", "BIKESEOUL_BATCHP");												//[필수]상품 ID(common_include.jsp 에 설정)
		orderProductsInfo.put("productAmt", String.valueOf(parmaMap.get("totAmt")));											//[필수]취소상품 금액		orderProductsInfo.put("cancelDetailContent", "이용권 구매 취소");											//[선택]취소 상세 사유
		orderProducts.add(orderProductsInfo);
		
//		if(orderProducts.size() != 0){
//			cancelInfo.put("orderProducts", orderProducts);					//[선택]취소할 상품 List(부분취소인 경우 사용, 입력하지 않는 경우 전체 취소)	
//		}
		
		//자동결제 삭제 API 호출 함수
		log.debug("###payco ### call payco_cancel");
		String paycoResult = util.payco_cancel(cancelInfo,logYn);
		
		/* jackson Tree 이용 */
		JsonNode node;
		try {
			node = mapper.readTree(paycoResult);
			if(!"0".equals(node.path("code").toString())){
				log.debug("###payco ### node.path = "+node.path("code").toString());
				// 취소 실패
				result = false;
			} else {
				// 취소 성공
				result = true;
				log.debug("##### payco cancelPayment result ##### ===> " + node.path("code").toString());
			}
		} catch (JsonProcessingException e) {
			result = false;
			e.printStackTrace();
		} catch (IOException e) {
			result = false;
			e.printStackTrace();
		}
		
		return result;
	}
	
	public boolean kakaoCancelAPI (Map<String, String> parmaMap) {
		
		boolean result = false;
		
		log.debug("###kakao pay ### cancel start");
		
		String kakao_cid 			= super.propertiesService.getString("kakao_cid");	 			// 가맹점 코드
		String kakao_logYn 			= super.propertiesService.getString("kakao_log_yn");			// 로그Y/N
		String kakaoAK				= super.propertiesService.getString("kakao_admin_key");			// admin_key
		
		HashMap<String, String> info_param = new HashMap<String, String>();
		info_param.put("cid", kakao_cid);
		info_param.put("tid", parmaMap.get("tId"));
		info_param.put("cancel_amount", String.valueOf(parmaMap.get("totAmt"))); 
		info_param.put("cancel_tax_free_amount", "0");
		
		ObjectMapper mapper = new ObjectMapper();
		KakaoPayUtil util = new KakaoPayUtil();  
		
		String kakao_pay_result = util.cancel(info_param, kakaoAK, kakao_logYn);
		
		// 결제 결과 처리
		/* jackson Tree 이용 */
		JsonNode kakaoResultNode;
		try {
			kakaoResultNode = mapper.readTree(kakao_pay_result);
			
			if(kakaoResultNode.get("aid").textValue() != null){
				log.debug("**********************kakao ready get tid *****************************");
				// 결제 취소 처리
				if(kakaoResultNode.get("status").textValue().equals("CANCEL_PAYMENT")) {
					// 취소 완료
					result = true;
				} else {
					result = false;
				}
			}
			
		} catch (JsonProcessingException e) {
			result = false;
			e.printStackTrace();
		} catch (IOException e) {
			result = false;
			e.printStackTrace();
		}
		
		return result;
	}

	
	public boolean paygetCancelAPI (Map<String, String> paramMap){
		boolean returnVal = false;
		
		log.debug("**************페이게이트 결제취소 처리_START*************************");
		
		RestTemplate restTemplate = new RestTemplate();
		restTemplate.getMessageConverters().add(new FormHttpMessageConverter());
		restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(Charset.forName("UTF-8")));
		
		try{
			String paramTId = String.valueOf(paramMap.get("tId"));
			String paramMId = String.valueOf(paramMap.get("m_id"));
			
			if(String.valueOf(paramMap.get("usr_cls_cd")).equals("USR_002")){
				apiSecretKey = "barocle@";
				
				log.debug("##### usr_cls_cd ##### ==> USR_002");
			}else{
				apiSecretKey = "victek1!";
				
				log.debug("##### usr_cls_cd ##### ==> !USR_002");
			}
			
			log.debug("**************paramTId ==> " + paramTId);
			log.debug("**************paramMId ==> " + paramMId);
			log.debug("**************apiSecretKey ==> " + apiSecretKey);
			
			String key256 = ToSHA256Hex.toSHA256Hex(apiSecretKey);
			String tidEncrypted = "AES256" + new AesCtr().encrypt(paramTId, key256, 256);
			String paramUrl = cancelUrl + "&mid=" + paramMId + "&tid=" + tidEncrypted + "&amount=F";
			paramUrl = paramUrl.replaceAll("\\s", "");
			
			log.debug("**************페이게이트 결제취소 처리_url ==> " + paramUrl + "*************************");
			
			URI url = new URI(paramUrl);
			String result = restTemplate.postForObject(url, null, String.class);
			String resultAll = result.substring(result.indexOf("(")+1, result.length()-1);
			JSONObject jObject = new JSONObject(resultAll);

			String rMsg = jObject.getString("replyCode");
			
			if(rMsg.equals("0000")){
				returnVal = true;
			}else{
				log.debug("**************페이게이트 결제취소 처리 ==> " + rMsg.toString());
			}
			
			log.debug("**************페이게이트 결제취소 처리_END*************************");
			
		}catch (Exception e){
			e.printStackTrace();
		}

		return returnVal;
	}
	
	public boolean zeroPayCancelAPI (Map<String, String> parmaMap) {
		
		boolean result = false;
		
		// zeroPay 처리
		String zeropayMid			=  super.propertiesService.getString("zeropayMid");
		String zeropayApiKey			=  super.propertiesService.getString("zeropayApiKey");
		String zeroPayPgDomain			=  super.propertiesService.getString("zeroPayPgDomain");
		
		// 취소요청 --------------------------------------------------------------------------
		JSONObject payInfo = new JSONObject();
		payInfo.put("mid", zeropayMid); 
		payInfo.put("payType", "ZP"); 
		payInfo.put("tid", parmaMap.get("tId")); 
		payInfo.put("cancelAmt", String.valueOf(parmaMap.get("totAmt"))); 
		
		String message = parmaMap.get("tId") + zeropayMid + String.valueOf(parmaMap.get("totAmt"));

		HmacSha256Enc hmac = new HmacSha256Enc();
		String checkHash = hmac.getHmac(message, zeropayApiKey);
		payInfo.put("checkHash", checkHash);
		
		// 취소응답 --------------------------------------------------------------------------
		HttpRestClientPay rest = new HttpRestClientPay();
		String apiUrl = zeroPayPgDomain;
		String apiCtxp = "/webpay/cancel.pay";
		
		String zeroPayCancelResult = rest.connect(apiUrl + apiCtxp, payInfo.toString());
		
		ObjectMapper mapper = new ObjectMapper();
		
		/* jackson Tree 이용 */
		JsonNode zeroPayCancelResultNode;
		
		try {
			zeroPayCancelResultNode = mapper.readTree(zeroPayCancelResult);
			
			log.info("**********************zeroPay cancel result "+ zeroPayCancelResult +" *****************************");
			log.info(zeroPayCancelResult);
			
			if(zeroPayCancelResultNode.has("RESULT_CODE") && zeroPayCancelResultNode.get("RESULT_CODE") != null){
				
				log.info("**********************zeroPay cancel result *****************************");
				log.info("*** zeroPay cancel result  ***" + zeroPayCancelResultNode.has("RESULT_CODE"));
				
				if(zeroPayCancelResultNode.get("RESULT_CODE").textValue().equals("EC0000") || zeroPayCancelResultNode.get("RESULT_CODE").textValue().equals("EC1067")) {
					// 취소 완료 기 취소된 경우도 취소 처리 EC1067
					result = true;
				} else {
					result = false;
				}
				
			} else {
				// 취소 실패
				result = false;
				log.debug("##### payco cancelPayment result ##### ===> result none");
			}
		} catch (JsonProcessingException e) {
			result = false;
			e.printStackTrace();
		} catch (IOException e) {
			result = false;
			e.printStackTrace();
		}
		
		return result;
	}
	
	public boolean naverPayCancelAPI (Map<String, String> parmaMap) {
		
		boolean result = false;
		
		log.debug("###naver pay ### cancel start");
		
		String naverClientId 			= super.propertiesService.getString("naverClientId");
		String naverClientSecret 		= super.propertiesService.getString("naverClientSecret");
		String serverType 		= super.propertiesService.getString("naverServerType");		// 서버유형. DEV:개발, REAL:운영
		String logYn 			= super.propertiesService.getString("naverLogYn");	
		
		HashMap<String, Object> info_param = new HashMap<String, Object>();
		info_param.put("paymentId", parmaMap.get("tId"));
		info_param.put("cancelAmount", String.valueOf(parmaMap.get("totAmt")));
		info_param.put("cancelReason", "관리자 결제 취소");
		info_param.put("cancelRequester", 2);
		info_param.put("taxScopeAmount", String.valueOf(parmaMap.get("totAmt")));
		info_param.put("taxExScopeAmount", 0);
		
		ObjectMapper mapper = new ObjectMapper();
		NaverPayUtil naverPayUtil = new NaverPayUtil(serverType); 
		
		String naverPayResult = naverPayUtil.payCancel(info_param, naverClientId, naverClientSecret, logYn);
		
		// 결제 결과 처리
		/* jackson Tree 이용 */
		JsonNode naverPayResultNode;
		
		try {
			naverPayResultNode = mapper.readTree(naverPayResult);
			
			if(naverPayResultNode.has("code")){
				log.debug("**********************naver pay cancel result *****************************");
				// 결제 취소 처리
				
				if("Success".equals(naverPayResultNode.get("code").textValue())) {
					// 취소 완료
					// 자동 결제 등록 취소 처리
					/*AddPayMethodVO oldAddPayMethodVO = new AddPayMethodVO();
					oldAddPayMethodVO.setUsrSeq(usrSeq);
					oldAddPayMethodVO.setPagingYn("Y");
					AddPayMethodVO AddPayMethod = new AddPayMethodVO();
					AddPayMethod = addPayMethodService.getAddPayMethod(oldAddPayMethodVO);*/
					
					PaymentVO addPayMethodVO = new PaymentVO();
					//BigInteger myBigIntegerValue = new BigInteger("" + Integer.parseInt(memberVo.getUsr_seq()));
					addPayMethodVO.setUsrSeq(new BigInteger(String.valueOf(parmaMap.get("usrSeq"))));
					addPayMethodVO.setPagingYn("Y");
					
					
					PaymentVO AddPayMethod = paymentService.getAddPayMethod(addPayMethodVO);
					
					
					// 네이버 페이 결제 진행시 기존 네이버 페이 결제 인 경우 자동 결제 취소 처리 후 진행
					if (AddPayMethod != null && "BIM_015".equals(AddPayMethod.getPaymentMethodCd())) {
						
						NaverPayUtil expireNaverUtil = new NaverPayUtil(serverType);
						
						Map<String, Object> expireParam = new HashMap<String, Object>();
						expireParam.put("recurrentId", AddPayMethod.getBillingKey());			// 정기결제 등록 번호
						expireParam.put("expireRequester", "1");
						expireParam.put("expireReason", "결제 취소");
						
						String expireResult = expireNaverUtil.paymentExpire(expireParam, naverClientId, naverClientSecret, logYn);
						
						// 해제 결과 처리
						JsonNode naverPayExpireResultNode;
						naverPayExpireResultNode = mapper.readTree(expireResult);
						
						if("Success".equals(naverPayExpireResultNode.get("code").textValue())) {
							int intResult = 0;
							
							/*TicketPaymentVO ticketPaymentVO = new TicketPaymentVO();
							ticketPaymentVO.setUsrSeq(String.valueOf(usrSeq));
							
							intResult = ticketPaymentService.delAddPayMethod2(ticketPaymentVO);
					 		log.debug("#### buy ticket naverPay : delete paymentMethod = "+intResult+", 회원 = "+ticketPaymentVO.getUsrSeq()+", tid = "+ticketPaymentVO.getPaymentConfmNo()+" ####");*/
					 		
						} else {
							System.out.println("naverpay 정기 결제 해제 실패 "+naverPayExpireResultNode.get("code").textValue());
						}
						
						System.out.println(expireResult);
					}
					result = true;
				} else {
					result = false;
				}
				
			} else {
				result = false;
			}
			
		} catch (JsonProcessingException e) {
			result = false;
			e.printStackTrace();
		} catch (IOException e) {
			result = false;
			e.printStackTrace();
		}
		
		return result;
	}

public boolean tmoneyPayCancelAPI (Map<String, String> parmaMap) {
		
		boolean result = false;
	
		log.debug("###tmoneyPayCancelAPI ### cancel start");
		
		String tUserSno	 = String.valueOf(parmaMap.get("usrSeq"));
		String pymSno	   = String.valueOf(parmaMap.get("paySeq"));
		String client_id	= super.propertiesService.getString("Client-Id");
		String serverType   = super.propertiesService.getString("TmoneyServerType");			// 서버유형. DEV:개발, REAL:운영
		String logYn 		= super.propertiesService.getString("TmoneyLogYn");
		
		//String serverType   = "DEV";
		//String logYn 		= "Y";

		//JSONObject dtaInfo = new JSONObject();
		HashMap<String, Object> param = new HashMap<String,Object>();
		param.put("tUserSno", tUserSno);	
		param.put("pymSno", pymSno);	
		
		ObjectMapper mapper = new ObjectMapper();
		TmoneyPayUtil TmoneyPayUtil = new TmoneyPayUtil(serverType); 
		String TmoneyPayResult = TmoneyPayUtil.tmoneyCancel(param, logYn);
		
		// 결제 결과 처리
		/* jackson Tree 이용 */
		JsonNode TmoneyPayResultNode;
		
		try {
			TmoneyPayResultNode = mapper.readTree(TmoneyPayResult);
			
				log.debug("**********************tmoneyPay cancel result *****************************");
				// 결제 취소 처리
				if(TmoneyPayResultNode.get("rstCd").textValue().equals("200")) {
					result = true;
				} else {
					result = false;
				}
			
		} catch (JsonProcessingException e) {
			result = false;
			e.printStackTrace();
		} catch (IOException e) {
			result = false;
			e.printStackTrace();
		}
		
		return result;
	}

	/*
	 * 이용권 체크 / 쿠폰번호 조회 _cms_20161205
	 */
	@RequestName(value="getCancelInfo")
	@RequestMapping(value = "/couponYnChk.do")
	public String couponYnChk(@ModelAttribute @Valid PaymentVO paymentVO, HttpServletRequest request, ModelMap model) throws Exception {

		try {
			
			PaymentVO payVO = paymentService.getCouponYnChk(paymentVO);

			model.addAttribute("useYn", payVO.getUseYn());
			model.addAttribute("couponNo", payVO.getCouponNo());
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
		} catch (Exception e) {
			throw new CfoodException("admin.common.controller.obstacleCnt");
		}
		return JSONVIEW;
	}
	
	public void makeServiceCheckApiLogFile(String logText, String logYn) {
		
		if(logYn.equals("Y")){
			String filePath   = "/MainPayLogs";
		  	java.text.SimpleDateFormat dateformat = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss");
		  	String nowTotDate = dateformat.format(new java.util.Date());
		  	Integer nowdate = Integer.parseInt( nowTotDate.substring(0, 8) );
		   
			String fileName = "adminW_check_log_" + nowdate + ".txt"; //생성할 파일명
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
}
