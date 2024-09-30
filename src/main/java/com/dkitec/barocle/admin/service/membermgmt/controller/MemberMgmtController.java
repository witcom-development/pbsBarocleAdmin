package com.dkitec.barocle.admin.service.membermgmt.controller;

import java.io.File;
import java.math.BigInteger;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.service.membermgmt.service.MemberMgmtService;
import com.dkitec.barocle.admin.service.membermgmt.service.SafetyCertService;
import com.dkitec.barocle.admin.service.membermgmt.vo.BlackListMgmtVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.BlackListMgmtVO.blackListDeleteValid;
import com.dkitec.barocle.admin.service.membermgmt.vo.BlackListMgmtVO.blackListInsertValid;
import com.dkitec.barocle.admin.service.membermgmt.vo.CouponVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.MemberMgmtVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.MemberPaymentVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.MobileSmsAuthVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.RentSerialNumVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.ReturnListMgmtVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.SafetyCertInfoVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.TransitMgmtVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.UserOutMgmtVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.VoucherMgmtVO;
import com.dkitec.barocle.admin.service.paymentmgmt.payment.service.PaymentService;
import com.dkitec.barocle.admin.service.paymentmgmt.payment.vo.PaymentVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.payment.AutoPayment_Util;
import com.dkitec.barocle.util.payment.KakaoPayUtil;
import com.dkitec.barocle.util.push.PushSendProc;
import com.dkitec.barocle.util.push.PushVO;
import com.dkitec.barocle.util.sms.SendType;
import com.dkitec.barocle.util.sms.SmsSender;
import com.dkitec.barocle.util.sms.vo.SmsMessageVO;
import com.dkitec.barocle.util.webutil.HttpUtil;
import com.dkitec.barocle.util.webutil.StringUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="MemberMgmtController")
@RequestMapping(value="/admin/service/member")
public class MemberMgmtController extends BaseController{

	
	@Resource(name = "memberMgmtService")
    protected MemberMgmtService memberMgmtService;
	@Resource(name = "commonCodeService") private CommonCodeService commonCodeService;
	@Resource(name = "paymentService") private PaymentService paymentService;
	@Resource(name = "safetyCertService") private SafetyCertService safetyCertService;
	
	//private Logger log = Logger.getLogger(this.getClass());
	protected static Logger log = LoggerFactory.getLogger(MemberMgmtController.class);
	
	/**
	 * 공통 리턴화면 
	 * @param methodName
	 * @return
	 */
	protected String getReturnUrl(String methodName) {
		return "/admin/service/member/" + methodName;
	}
	
	private static final String POP_URL = "/admin/common/popup/";
	
	/**
	 * 회원 정보 목록 조회
	 * @param memberVo
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="memberList")
	@RequestMapping(value="memberList")
	public String memberList(  MemberMgmtVO memberVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		log.debug(result.hasErrors() + "");
		if (!result.hasErrors()) {
			model.put("result", "");
		} else {
			log.debug( result.getAllErrors().get(0).getDefaultMessage());
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("svc_usr_list");
		}
		
		
		memberVo.setLang(request.getLocale().getLanguage());
		
		boolean bResult = false;
		List<MemberMgmtVO> memberList = null;
		
		memberVo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
		memberVo.setPageSize(propertiesService.getInt("pageSize"));
		// 페이징 처리
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(memberVo.getCurrentPageNo());
		
		paginationInfo.setRecordCountPerPage(memberVo.getPageSize());
		paginationInfo.setPageSize(memberVo.getRecordCountPerPage());
		memberVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
		memberVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		
		try {
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			cal.add(Calendar.DAY_OF_MONTH, -1);
			String strDay = sdf.format(cal.getTime());
			
			if(memberVo.getSearchStartDate() == null){
				//memberVo.setSearchStartDate(strDay);
				// 20200811 변경
				memberVo.setSearchStartDate(strDay);
				//memberVo.setSearchStartDate("2015-09-01");
			}
			if(memberVo.getSearchEndDate() == null){
				memberVo.setSearchEndDate(nowDay);
			}
			 
			// 2020-08-11 변경
			if( !"".equals(StringUtil.nullToBlank( memberVo.getSearchValue()))
				) {
				memberVo.setSearchStartDate("2023-09-01");	
			}/* else {
				if(  diffOfDate(memberVo.getSearchStartDate(), memberVo.getSearchEndDate()) > 7 ) {
					memberVo.setSearchStartDate( strDay );
				}	
			}*/
			
			// total count
			paginationInfo.setTotalRecordCount(memberMgmtService.memberListCnt(memberVo));
			// 목록 조회
			memberList = memberMgmtService.memberList(memberVo);
						
			model.put("memberList", memberList);
			model.put("paginationInfo", paginationInfo);
			model.put("form", memberVo);
			
			bResult = true;
			
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.service.member.memberList");
		}
		
		return bResult? getReturnUrl("svc_usr_list") : ERROR_PAGE;
		
	}
	
	  public static long diffOfDate(String begin, String end) throws Exception
	  {
	    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

	    Date beginDate = formatter.parse(begin);
	    Date endDate = formatter.parse(end);

	    long diff = endDate.getTime() - beginDate.getTime();
	    long diffDays = diff / (24 * 60 * 60 * 1000);

	    return diffDays;
	  }
	
	/**
	 * 회원 정보 목록 조회
	 * @param memberVo
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="memberListExcel")
	@RequestMapping(value="memberListExcel")
	public String memberListExcel(  MemberMgmtVO memberVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		log.debug(result.hasErrors() + "");
		if (!result.hasErrors()) {
			model.put("result", "");
		} else {
			log.debug( result.getAllErrors().get(0).getDefaultMessage());
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("svc_usr_list");
		}
		
		memberVo.setLang(request.getLocale().getLanguage());
		
		boolean bResult = false;
		List<MemberMgmtVO> memberList = null;
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		try {
			memberVo.setExcel("EXCEL");
			
			log.debug(memberVo.toString());
			
			// total count
			paginationInfo.setTotalRecordCount(memberMgmtService.memberListCnt(memberVo));
			// 목록 조회
			memberList = memberMgmtService.memberList(memberVo);
			
			model.put("memberList", memberList);
			model.put("paginationInfo", paginationInfo);
			model.put("form", memberVo);
			
			bResult = true;
			
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.service.member.memberListExcel");
		}
		
		return bResult? getReturnUrl("svc_usr_list_excel") : ERROR_PAGE;
		
	}
	
	
	
	
	/**
	 * 회원 정보 상세조회 
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="memberInfo")
	@RequestMapping(value="memberInfo", method = RequestMethod.POST)
	public String memberInfo(MemberMgmtVO memberVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		
		log.debug(result.hasErrors() + "");
		if (!result.hasErrors()) {
			model.put("result", "");
		} else {
			log.debug( result.getAllErrors().get(0).getDefaultMessage());
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("svc_usr_list");
		}
		boolean bResult = false;
		
		
		try {
		    	
			MemberMgmtVO info = memberMgmtService.getMemberInfo(memberVo);
			MemberMgmtVO addCharge = memberMgmtService.getMemberAddChargeInfo(memberVo);
			
			memberVo.setCard_use_cls_cd("R");
			MemberMgmtVO rentCardInfo = memberMgmtService.getMemberCardInfo(memberVo);
			memberVo.setCard_use_cls_cd("M");
			MemberMgmtVO transCardInfo = memberMgmtService.getMemberCardInfo(memberVo);
			
	    	model.put("info", info);
	    	model.put("cardInfo", rentCardInfo);
	    	model.put("transCardInfo", transCardInfo);
	    	model.put("addCharge", addCharge);
	    	model.put("listType", memberVo.getListType());

 	        String rentYn = memberMgmtService.getRentYn(memberVo);
 	        String remainPayYn = memberMgmtService.getRemainPayYn(memberVo);
 	        //String remainPayYn = "Y";
	    	String useVoucherYn = memberMgmtService.getUseVoucher(memberVo);
 	        String remainVoucherYn = memberMgmtService.getRemainVoucher(memberVo);
 	        String blackListYn = memberMgmtService.getBlackListYn(memberVo);
 	        
	    	model.put("rentYn", rentYn);
	    	model.put("remainPayYn", remainPayYn);
	    	model.put("useVoucherYn", useVoucherYn);
	    	model.put("remainVoucherYn", remainVoucherYn);
	    	model.put("blackListYn", blackListYn);
	    	
	    	bResult = true;
	    	
		} catch (Exception e) {
			throw new CfoodException("fail.common.msg" );
		}
		
		return bResult? getReturnUrl("svc_usr_detail") : IConstants.ERROR_PAGE;
		
	}
	
	/**
	 * 회원 벌점 이력 살세 조회 
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="memberPenalty")
	@RequestMapping(value="memberPenalty", method = RequestMethod.POST)
	public String memberPenalty(MemberMgmtVO memberVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		
		log.debug(result.hasErrors() + "");
		if (!result.hasErrors()) {
			model.put("result", "");
		} else {
			log.debug( result.getAllErrors().get(0).getDefaultMessage());
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("svc_usr_list");
		}
		
		memberVo.setLang(request.getLocale().getLanguage());
		
		boolean bResult = false;
		List<MemberMgmtVO> penaltyList = null;
		MemberMgmtVO totalPenalty = null;
		
		memberVo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
		memberVo.setPageSize(propertiesService.getInt("pageSize"));
		// 페이징 처리
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(memberVo.getCurrentPageNo());
		
		paginationInfo.setRecordCountPerPage(memberVo.getPageSize());
		paginationInfo.setPageSize(memberVo.getRecordCountPerPage());
		memberVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
		memberVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		
		try {
			if(memberVo.getReadClsCd() == null) {
				memberVo.setReadClsCd("S");
			}
			MemberMgmtVO info = memberMgmtService.getMemberInfo(memberVo);
			
			paginationInfo.setTotalRecordCount(memberMgmtService.penaltyListCnt(memberVo));
			// 목록 조회
			penaltyList = memberMgmtService.penaltyList(memberVo);
			
			totalPenalty = memberMgmtService.totalPenaltyBlackList(memberVo);
			log.debug(totalPenalty +"");
			
	    	
			model.put("penaltyList", penaltyList);
			model.put("paginationInfo", paginationInfo);
			model.put("info", info);
			model.put("totalPenalty", totalPenalty);
			model.put("form", memberVo);
			bResult = true;
			
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.manage.stationgroup.stationGroupInfo");
		}
		
		
		return bResult? getReturnUrl("svc_usr_pen") : IConstants.ERROR_PAGE;
		
	}
	
	
	
	/**
	 * 초과요금 삭제 
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="deleteAddPayMethod")
	@RequestMapping(value="deleteAddPayMethod", method = RequestMethod.POST)
	public String deleteAddPayMethod(MemberMgmtVO memberVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		try {
			memberMgmtService.deleteAddPayMethod(memberVo);
			model.put("resultMsg", "삭제성공");
		} catch (Exception e) {
			model.put("resultMsg", "실패");
			e.printStackTrace();
			new CfoodException("admin.manage.stationgroup.deletePenalty");
		}
		
		return IConstants.JSONVIEW;
	}
	
	/**
	 * 벌점 삭제 
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="deletePenalty")
	@RequestMapping(value="deletePenalty", method = RequestMethod.POST)
	public String deletePenalty(MemberMgmtVO memberVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		log.debug(memberVo+"");
		
		// 그룹명 중복검사
		try {
			memberMgmtService.deletePenalty(memberVo);
			
			CommonCodeVO cVo = new CommonCodeVO();
			List<CommonCodeVO> codeList = null;
			
	    	cVo.setComUpCd("MSI");
	    	cVo.setLang(IConstants.LANG_KR);
	    	codeList = commonCodeService.getComCodeInfo(cVo);

	    	int rfpPoint = 0;
	    	for (int i = 0; i < codeList.size(); i++) {
	    		if(codeList.get(i).getComCd().equals("MSI_002")){
	    			rfpPoint = Integer.parseInt(codeList.get(i).getAddVal1());
	    		}
			}
	    	memberVo.setReadClsCd("S");
	    	MemberMgmtVO totalPenalty = memberMgmtService.totalPenaltyBlackList(memberVo);
	    	
	    	String blaType = memberMgmtService.getBlaTypeClsCd(memberVo);
	    	
	    	if(rfpPoint > 0 & (blaType != null && blaType.equals("BLA_001"))){
	    		if(rfpPoint > Integer.parseInt(totalPenalty.getPenalty_point())){
	    			BlackListMgmtVO blackListMgmtVO = new BlackListMgmtVO();
	    			blackListMgmtVO.setUsrSeq(memberVo.getUsr_seq());
	    			memberMgmtService.delBlackList(blackListMgmtVO);
	    			
	    		}
	    	}
			
			model.put("resultMsg", "삭제성공");
		} catch (Exception e) {
			model.put("resultMsg", "실패");
			e.printStackTrace();
			new CfoodException("admin.manage.stationgroup.deletePenalty");
		}
		
		return IConstants.JSONVIEW;
	}
	
	
	/**
	 * 강제 회원 탈퇴 
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="memberUnsubscribe")
	@RequestMapping(value="memberUnsubscribe", method = RequestMethod.POST)
	public String memberUnsubscribe(MemberMgmtVO memberVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		log.debug(memberVo+"");
		
		// 그룹명 중복검사
		try {
			
			PaymentVO addPayMethodVO = new PaymentVO();
			BigInteger myBigIntegerValue = new BigInteger("" + Integer.parseInt(memberVo.getUsr_seq()));
        	addPayMethodVO.setUsrSeq(myBigIntegerValue);
        	addPayMethodVO.setPagingYn("Y");
        	
        	
        	PaymentVO AddPayMethod = paymentService.getAddPayMethod(addPayMethodVO);
        	
        	if (AddPayMethod != null && AddPayMethod.getPaymentMethodCd().equals("BIM_007")) {
        		// payco 삭제 처리
        		String sellerKey 		= super.propertiesService.getString("paycoSellerKey");     	// 가맹점 코드 - 파트너센터에서 알려주는 값으로, 초기 연동 시 PAYCO에서 쇼핑몰에 값을 전달한다.
        		String serverType 		= super.propertiesService.getString("paycoServerType");		// 서버유형. DEV:개발, REAL:운영
        		String logYn 			= super.propertiesService.getString("paycoLogYn");			// 로그Y/N

        		Map<String,Object> cancelInfo = new HashMap<String,Object>();
        		cancelInfo.put("sellerKey", sellerKey);											//[필수]판매자Key
        		cancelInfo.put("sellerAutoPaymentReferenceKey", AddPayMethod.getBillingKey()); //[필수]외부가맹점의 자동결제 관리번호
        		cancelInfo.put("autoPaymentCertifyKey", AddPayMethod.getBillingCertifyKey());  				//[필수]자동결제 인증 키
        		
        		AutoPayment_Util paycoUtil = new AutoPayment_Util(serverType);
        		paycoUtil.autoPayment_cancel(cancelInfo, logYn);
        		
        	} else if (AddPayMethod != null && AddPayMethod.getPaymentMethodCd().equals("BIM_010")) {
        		// kakao 삭제 처리
        		String kakao_cid 			= super.propertiesService.getString("kakao_cid");     			// 가맹점 코드
        		String kakao_logYn 			= super.propertiesService.getString("kakao_log_yn");			// 로그Y/N
        		String kakaoAK				= super.propertiesService.getString("kakao_admin_key");			// admin_key
        		
        		KakaoPayUtil kakaoPayUtil = new KakaoPayUtil();
				  
				HashMap<String, String> info_param = new HashMap<String, String>();
				info_param.put("cid", kakao_cid);
				info_param.put("sid", AddPayMethod.getBillingKey());
				
				kakaoPayUtil.delete(info_param, kakaoAK, kakao_logYn);
        	}
			
			
			memberMgmtService.memberUnsubscribe(memberVo);
			
			model.put("resultMsg", "성공");
		} catch (Exception e) {
			model.put("resultMsg", "실패");
			e.printStackTrace();
			new CfoodException("admin.manage.stationgroup.memberUnsubscribe");
		}
		
		return IConstants.JSONVIEW;
	}
	/**
	 * 회원 마일리지 이력 조회 
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="memberMileage")
	@RequestMapping(value="memberMileage", method = RequestMethod.POST)
	public String memberMileage(MemberMgmtVO memberVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		
		log.debug(result.hasErrors() + "");
		if (!result.hasErrors()) {
			model.put("result", "");
		} else {
			log.debug( result.getAllErrors().get(0).getDefaultMessage());
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("svc_usr_list");
		}
		
		memberVo.setLang(request.getLocale().getLanguage());
		
		boolean bResult = false;
		List<MemberMgmtVO> mileageList = null;
		
		memberVo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
		memberVo.setPageSize(propertiesService.getInt("pageSize"));
		// 페이징 처리
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(memberVo.getCurrentPageNo());
		
		paginationInfo.setRecordCountPerPage(memberVo.getPageSize());
		paginationInfo.setPageSize(memberVo.getRecordCountPerPage());
		memberVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
		memberVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		CommonCodeVO cVo = new CommonCodeVO();
		List<CommonCodeVO> codeList = null;
		
    	cVo.setComUpCd("MIG");
    	cVo.setLang(IConstants.LANG_KR);
    	
    	try {
    		// 마일리지 이용구분 공통코드 조회
    		codeList = commonCodeService.getComCodeInfo(cVo);
			
			MemberMgmtVO info = memberMgmtService.getMemberInfo(memberVo);
			MemberMgmtVO cardInfo = memberMgmtService.getMemberCardInfo(memberVo);
			
			paginationInfo.setTotalRecordCount(memberMgmtService.mileageListCnt(memberVo));
			// 목록 조회
			mileageList = memberMgmtService.mileageList(memberVo);
			///MemberMgmtVO cardInfo = memberMgmtService.getMemberCardInfo(memberVo);
			
			// 2020 10 10
			memberVo.setCard_use_cls_cd("M");
			model.put("cardList", memberMgmtService.getMemberCardInfoList(memberVo));
			
			model.put("mileageList", mileageList);
			model.put("paginationInfo", paginationInfo);
			model.put("info", info);
			model.put("cardInfo", cardInfo);
			model.put("codeList", codeList);
			model.put("form", memberVo);
			bResult = true;
			
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.manage.stationgroup.memberMileage");
		}
		return bResult? getReturnUrl("svc_usr_mil") : IConstants.ERROR_PAGE;
		
	}
	/**
	 * 회원 결제이력 조회 
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="memberPaymentList")
	@RequestMapping(value="memberPaymentList", method = RequestMethod.POST)
	public String memberPaymentList(MemberPaymentVO paymentVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		
		log.debug(result.hasErrors() + "");
		if (!result.hasErrors()) {
			model.put("result", "");
		} else {
			log.debug( result.getAllErrors().get(0).getDefaultMessage());
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("svc_usr_list");
		}
		
		boolean bResult = false;
		List<MemberPaymentVO> payList = null;
		
		paymentVo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
		paymentVo.setPageSize(propertiesService.getInt("pageSize"));
		// 페이징 처리
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(paymentVo.getCurrentPageNo());
		
		paginationInfo.setRecordCountPerPage(paymentVo.getPageSize());
		paginationInfo.setPageSize(paymentVo.getRecordCountPerPage());
		paymentVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
		paymentVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		log.debug("###################"+paymentVo.getRecordCountPerPage());
		try {
			
			MemberMgmtVO memberVo = new MemberMgmtVO();
			memberVo.setUsr_seq(paymentVo.getUsr_seq());
			
			MemberMgmtVO info = memberMgmtService.getMemberInfo(memberVo);
			
			paginationInfo.setTotalRecordCount(memberMgmtService.memberPaymentListCnt(paymentVo));
			// 목록 조회
			payList = memberMgmtService.memberPaymentList(paymentVo);
			
			model.put("payList", payList);
			model.put("paginationInfo", paginationInfo);
			model.put("info", info);
			model.put("form", paymentVo);
			bResult = true;
			
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.manage.stationgroup.memberPaymentList");
		}
		
		
		return bResult? getReturnUrl("svc_usr_pay") : IConstants.ERROR_PAGE;
		
	}
	/**
	 * 회원 이용 이력 조회 
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="memberUseList")
	@RequestMapping(value="memberUseList", method = RequestMethod.POST)
	public String memberUseList(MemberPaymentVO paymentVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		
		log.debug(result.hasErrors() + "");
		if (!result.hasErrors()) {
			model.put("result", "");
		} else {
			log.debug( result.getAllErrors().get(0).getDefaultMessage());
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("svc_usr_list");
		}
		
		boolean bResult = false;
		List<MemberPaymentVO> list = null;
		
		paymentVo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
		paymentVo.setPageSize(propertiesService.getInt("pageSize"));
		// 페이징 처리
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(paymentVo.getCurrentPageNo());
		
		paginationInfo.setRecordCountPerPage(paymentVo.getPageSize());
		paginationInfo.setPageSize(paymentVo.getRecordCountPerPage());
		paymentVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
		paymentVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		log.debug("###################"+paymentVo.getRecordCountPerPage());
		try {
			
			MemberMgmtVO memberVo = new MemberMgmtVO();
			memberVo.setUsr_seq(paymentVo.getUsr_seq());
			
			MemberMgmtVO info = memberMgmtService.getMemberInfo(memberVo);
			
			paginationInfo.setTotalRecordCount(memberMgmtService.memberUseListCnt(paymentVo));
			// 목록 조회
			list = memberMgmtService.memberUseList(paymentVo);
			
			model.put("list", list);
			model.put("paginationInfo", paginationInfo);
			model.put("info", info);
			model.put("form", paymentVo);
			bResult = true;
			
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.manage.stationgroup.memberUseList");
		}
		return bResult? getReturnUrl("svc_use_list") : IConstants.ERROR_PAGE;
		
	}
	/**
	 * 회원 환불 이력 조회 
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="memberRefundList")
	@RequestMapping(value="memberRefundList", method = RequestMethod.POST)
	public String memberRefundList(MemberPaymentVO paymentVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		
		log.debug(result.hasErrors() + "");
		if (!result.hasErrors()) {
			model.put("result", "");
		} else {
			log.debug( result.getAllErrors().get(0).getDefaultMessage());
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("svc_usr_list");
		}
		
		boolean bResult = false;
		List<MemberPaymentVO> list = null;
		
		paymentVo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
		paymentVo.setPageSize(propertiesService.getInt("pageSize"));
		// 페이징 처리
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(paymentVo.getCurrentPageNo());
		
		paginationInfo.setRecordCountPerPage(paymentVo.getPageSize());
		paginationInfo.setPageSize(paymentVo.getRecordCountPerPage());
		paymentVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
		paymentVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		log.debug("###################"+paymentVo.getRecordCountPerPage());
		try {
			
			MemberMgmtVO memberVo = new MemberMgmtVO();
			memberVo.setUsr_seq(paymentVo.getUsr_seq());
			
			MemberMgmtVO info = memberMgmtService.getMemberInfo(memberVo);
			
			paginationInfo.setTotalRecordCount(memberMgmtService.memberRefundListCnt(paymentVo));
			// 목록 조회
			list = memberMgmtService.memberRefundList(paymentVo);
			
			model.put("list", list);
			model.put("paginationInfo", paginationInfo);
			model.put("info", info);
			model.put("form", paymentVo);
			bResult = true;
			
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.manage.stationgroup.memberRefundList");
		}
		
		
		return bResult? getReturnUrl("svc_usr_add") : IConstants.ERROR_PAGE;
		
	}
	/**
	 * 회원 미납 내역  조회 
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="memberUnpaidList")
	@RequestMapping(value="memberUnpaidList", method = RequestMethod.POST)
	public String memberUnpaidList(MemberPaymentVO paymentVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		
		log.debug(result.hasErrors() + "");
		if (!result.hasErrors()) {
			model.put("result", "");
		} else {
			log.debug( result.getAllErrors().get(0).getDefaultMessage());
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("svc_usr_list");
		}
		
		boolean bResult = false;
		List<MemberPaymentVO> list = null;
		
		paymentVo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
		paymentVo.setPageSize(propertiesService.getInt("pageSize"));
		// 페이징 처리
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(paymentVo.getCurrentPageNo());
		
		paginationInfo.setRecordCountPerPage(paymentVo.getPageSize());
		paginationInfo.setPageSize(paymentVo.getRecordCountPerPage());
		paymentVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
		paymentVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		log.debug("###################"+paymentVo.getRecordCountPerPage());
		try {
			
			MemberMgmtVO memberVo = new MemberMgmtVO();
			memberVo.setUsr_seq(paymentVo.getUsr_seq());
			
			MemberMgmtVO info = memberMgmtService.getMemberInfo(memberVo);
			
			paginationInfo.setTotalRecordCount(memberMgmtService.memberUnpaidListCnt(paymentVo));
			// 목록 조회
			list = memberMgmtService.memberUnpaidList(paymentVo);
			
			model.put("list", list);
			model.put("paginationInfo", paginationInfo);
			model.put("info", info);
			model.put("form", paymentVo);
			bResult = true;
			
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.manage.stationgroup.memberRefundList");
		}
		
		return bResult? getReturnUrl("svc_usr_kit") : IConstants.ERROR_PAGE;
		
	}
	/**
	 * 회원 이용권  조회 
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="memberVoucherList")
	@RequestMapping(value="memberVoucherList", method = RequestMethod.POST)
	public String memberVoucherList(MemberPaymentVO paymentVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		
		log.debug(result.hasErrors() + "");
		if (!result.hasErrors()) {
			model.put("result", "");
		} else {
			log.debug( result.getAllErrors().get(0).getDefaultMessage());
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("svc_usr_list");
		}
		
		boolean bResult = false;
		List<MemberPaymentVO> list = null;
		
		paymentVo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
		paymentVo.setPageSize(propertiesService.getInt("pageSize"));
		// 페이징 처리
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(paymentVo.getCurrentPageNo());
		
		paginationInfo.setRecordCountPerPage(paymentVo.getPageSize());
		paginationInfo.setPageSize(paymentVo.getRecordCountPerPage());
		paymentVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
		paymentVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		log.debug("###################"+paymentVo.getRecordCountPerPage());
		try {
			MemberMgmtVO memberVo = new MemberMgmtVO();
			memberVo.setUsr_seq(paymentVo.getUsr_seq());
			
			MemberMgmtVO info = memberMgmtService.getMemberInfo(memberVo);
			MemberPaymentVO voucher = memberMgmtService.getMemberVoucher(paymentVo);
			
			paginationInfo.setTotalRecordCount(memberMgmtService.memberVoucherListCnt(paymentVo));
			// 목록 조회
			list = memberMgmtService.memberVoucherList(paymentVo);
			
			model.put("list", list);
			model.put("paginationInfo", paginationInfo);
			model.put("info", info);
			model.put("form", paymentVo);
			model.put("voucher", voucher);
			bResult = true;
			
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.manage.stationgroup.memberVoucherList");
		}
		return bResult? getReturnUrl("svc_usr_voc") : IConstants.ERROR_PAGE;
		
	}
	
	/**
	 * 회원 받은/건낸 선물(이용권) 조회 _cms_20161104  
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="memberGiftList")
	@RequestMapping(value="memberGiftList", method = RequestMethod.POST)
	public String memberGiftList(CouponVO couponVO, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		log.debug(result.hasErrors() + "");
		if (!result.hasErrors()) {
			model.put("result", "");
		} else {
			log.debug( result.getAllErrors().get(0).getDefaultMessage());
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("svc_usr_list");
		}
		
		boolean bResult = false;

		couponVO.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
		couponVO.setPageSize(propertiesService.getInt("pageSize"));
		// 페이징 처리
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(couponVO.getCurrentPageNo());
		
		paginationInfo.setRecordCountPerPage(couponVO.getPageSize());
		paginationInfo.setPageSize(couponVO.getRecordCountPerPage());
		couponVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
		couponVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		try {
			//이용권 버튼 구분 (1: 받은이용권, 2: 보낸이용권)
			String chk = couponVO.getBtn_chk();
			
			MemberMgmtVO memberVo = new MemberMgmtVO();
			memberVo.setUsr_seq(couponVO.getUsr_seq());
			
			MemberMgmtVO info = memberMgmtService.getMemberInfo(memberVo);
			// 받은 이용권 조회
			if(chk == null || chk.equals("1") || "1".equals(chk)){
				List<CouponVO> recvCouponList = memberMgmtService.getRecvCouponList(couponVO);
				paginationInfo.setTotalRecordCount(memberMgmtService.getRecvCouponListCnt(couponVO));
				model.put("recvCouponList", recvCouponList);
				model.put("btnChk", "1");
			// 보낸 이용권 조회	
			}else if(chk.equals("2") || "2".equals(chk)){
				List<CouponVO> sendCouponList = memberMgmtService.getSendCouponList(couponVO);
				paginationInfo.setTotalRecordCount(memberMgmtService.getSendCouponListCnt(couponVO));
				model.put("sendCouponList", sendCouponList);
				model.put("btnChk", "2");
			}
			model.put("paginationInfo", paginationInfo);
			model.put("info", info);
			model.put("form", couponVO);
			

			bResult = true;
			
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.manage.stationgroup.memberGiftList");
		}
		return bResult? getReturnUrl("svc_usr_gift") : IConstants.ERROR_PAGE;
		
	}
	
	
	/**
	 * 사용중 이용권 기간 변경 
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="memberVoucherUpdate")
	@RequestMapping(value="memberVoucherUpdate", method = RequestMethod.POST)
	public String memberVoucherUpdate(MemberPaymentVO paymentVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		log.debug(paymentVo+"");
		
		try {
			
		//	if(memberMgmtService.memberVoucherUpdateCheck(paymentVo) == 0){
				memberMgmtService.memberVoucherUpdate(paymentVo);
				model.put("resultMsg", "성공");
	//		}else{
	//			model.put("resultMsg", "중복");
		//	}
			
		} catch (Exception e) {
			model.put("resultMsg", "실패");
			e.printStackTrace();
			new CfoodException("admin.manage.stationgroup.memberVoucherUpdate");
		}
		
		return IConstants.JSONVIEW;
	}
	
	@RequestName(value="listUserOut")
	@RequestMapping(value="/listUserOut.do")
	public String listUserOut(@ModelAttribute @Valid UserOutMgmtVO userOutMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		boolean result = false;
    	String targetUrl = "/admin/service/member/userOut/svc_userout_list";
    	String bizName = "탈퇴회원 목록 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
        try {
        	if ( userOutMgmtVO.getMbId() != null || userOutMgmtVO.getLeaveEndDate() != null || userOutMgmtVO.getLeaveStrDate() != null) {

        		// 회원 ID 검색시에는 날짜 검색 조건이 없어야함.
        		// 초기화면에서는 탈퇴회원 쿼리를 조회하지 않음 2019-11-12
        		if(userOutMgmtVO.getMbId()!=null && userOutMgmtVO.getMbId()!=""){
        			userOutMgmtVO.setLeaveStrDate(null);
                	userOutMgmtVO.setLeaveEndDate(null);
        		}
            	userOutMgmtVO.setTotalRecordCount(memberMgmtService.listUserOutCount(userOutMgmtVO));
            	
		        PaginationInfo paginationInfo = getPagingInfo(userOutMgmtVO.getCurrentPageNo(), userOutMgmtVO.getTotalRecordCount());
		        PaginationInfo paginationMobileInfo = getPagingMobileInfo(userOutMgmtVO.getCurrentPageNo(), userOutMgmtVO.getTotalRecordCount());
		        userOutMgmtVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
		        userOutMgmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		        
		        List<UserOutMgmtVO> userOutList = memberMgmtService.listUserOut(userOutMgmtVO);
		    	
		        model.addAttribute("searchParam", userOutMgmtVO);
		        model.addAttribute("userOutList", userOutList);
		        model.addAttribute("paginationInfo", paginationInfo);
		        model.addAttribute("paginationMobileInfo", paginationMobileInfo);
        	}
        	result = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			new CfoodException("admin.service.member.publicTransitList");
		}
        
		return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName(value="listBlackList")
	@RequestMapping(value="/listBlackList.do")
	public String listBlackList(@ModelAttribute @Valid BlackListMgmtVO blackListMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		boolean result = false;
		String targetUrl = "/admin/service/member/black/svc_bla_list";
		String bizName = "블랙목록 회원 목록 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		if(!bResult.hasErrors()) {
			blackListMgmtVO.setTotalRecordCount(memberMgmtService.listBlackListCount(blackListMgmtVO));
			
			PaginationInfo paginationInfo = getPagingInfo(blackListMgmtVO.getCurrentPageNo(), blackListMgmtVO.getTotalRecordCount());
			PaginationInfo paginationMoblieInfo = getPagingMobileInfo(blackListMgmtVO.getCurrentPageNo(), blackListMgmtVO.getTotalRecordCount());
			blackListMgmtVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			blackListMgmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<BlackListMgmtVO> blackListList = memberMgmtService.listBlackList(blackListMgmtVO);
			
			model.addAttribute("searchParam", blackListMgmtVO);
			model.addAttribute("blackListList", blackListList);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMoblieInfo", paginationMoblieInfo);
			
			result = true;
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName(value="delBlackListAjax")
	@RequestMapping(value="/delBlackListAjax.do")
	public String delBlackListAjax(@Validated(blackListDeleteValid.class) BlackListMgmtVO blackListMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "블랙목록 해지";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		boolean isDel = false;
		isDel = memberMgmtService.delBlackList(blackListMgmtVO);
		
		// 벌점 삭제
		memberMgmtService.deletePenatyAll(blackListMgmtVO);
		
		model.addAttribute("isDel", String.valueOf(isDel));
		
		return JSONVIEW;
		
	}
	
	@RequestName(value="blackListRegFormPop")
	@RequestMapping(value="/blackListRegFormPop.do")
	public String blackListRegFormPop(@RequestParam(value="usr_seq") String usr_seq, ModelMap model, HttpServletRequest request) {
		
		String targetUrl = "/admin/common/popup/pop_bla_pro";
		String bizName = "블랙목록 등록 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		List<BlackListMgmtVO> blackListReason = memberMgmtService.listBlackListReason();
		model.addAttribute("blackListReason", blackListReason);
		model.addAttribute("usr_seq", usr_seq);
		
		return targetUrl;
	}
	
	@RequestName(value="regBlackListAjax")
	@RequestMapping(value="/regBlackListAjax.do")
	public String regBlackListAjax(@Validated(blackListInsertValid.class) BlackListMgmtVO blackListMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "블랙목록 등록";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		
		blackListMgmtVO.setAuth_di_val(memberMgmtService.getMemberUsrAuthVal(blackListMgmtVO));
		
		boolean isSuccess = false;
		isSuccess = memberMgmtService.regBlackList(blackListMgmtVO);
		model.addAttribute("isSuccess", String.valueOf(isSuccess));
		
		return JSONVIEW;
		
	}
	
	/**
	 * 회원확인 SMS 발송 
	 * @param memberVo
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="smsSend")
	@RequestMapping(value="/smsSend.do")
	public String smsSend(MemberMgmtVO memberVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		

		String bizName = "회원확인 SMS 발송";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		SmsMessageVO msg = new SmsMessageVO();
		msg.setTitle(bizName);
		msg.setDestno(memberVo.getUsr_mpn_no());
		SmsSender.sender(msg, SendType.SMS_006, memberVo.getMb_id());
		
		boolean isSuccess = true;
		model.addAttribute("isSuccess", String.valueOf(isSuccess));
		
		return JSONVIEW;
		
	}
	@RequestName(value="getSmsAllMBMpnNo")
	@RequestMapping(value="/getSmsAllMBMpnNo.do")
	public String getSmsAllMBMpnNo(MemberMgmtVO memberVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		String bizName = "전체발송 SMS 목록";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		model.addAttribute("memberVo", memberVo);
		return "/admin/common/popup/pop_sms_pro";
	}
	
	/**
	 * 대중교통 이용정보 화면전시_20160907_JJH_START
	 * @param blackListMgmtVO
	 * @param bResult
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestName(value="publicTransitList")
	@RequestMapping(value="/publicTransitList.do")
	public String publicTransitList(TransitMgmtVO transitMgmtVO, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		String targetUrl = "/admin/service/member/svc_transit_list";
		String bizName = "대중교통 이용정보 목록 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
        transitMgmtVO.setLang(request.getLocale().getLanguage());
		
		boolean bResult = false;
		List<TransitMgmtVO> transitList = null;
		
		transitMgmtVO.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
		transitMgmtVO.setPageSize(propertiesService.getInt("pageSize"));
		// 페이징 처리
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(transitMgmtVO.getCurrentPageNo());
		
		paginationInfo.setRecordCountPerPage(transitMgmtVO.getPageSize());
		paginationInfo.setPageSize(transitMgmtVO.getRecordCountPerPage());
		transitMgmtVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
		transitMgmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		
		try {
			log.debug(transitMgmtVO.toString());
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			if(transitMgmtVO.getSearchStartDate() == null){
				//memberVo.setSearchStartDate(strDay);
				transitMgmtVO.setSearchStartDate(nowDay);
			}
			if(transitMgmtVO.getSearchEndDate() == null){
				transitMgmtVO.setSearchEndDate(nowDay);
			}
			
			// total count
			paginationInfo.setTotalRecordCount(memberMgmtService.getTransitListCnt(transitMgmtVO));
			
			// 목록 조회
			transitList = memberMgmtService.getTransitList(transitMgmtVO);
			
			model.put("transitList", transitList);
			model.put("paginationInfo", paginationInfo);
			model.put("form", transitMgmtVO);
			
			bResult = true;
			
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.service.member.publicTransitList");
		}
		
		return bResult? targetUrl : ERROR_PAGE;
	}
	
	
	
	@RequestName(value="memberVoucherReg")
	@RequestMapping(value="/memberVoucherReg.do")
	public String memberVoucherReg(@RequestParam(value="usr_seq") String usr_seq, ModelMap model, HttpServletRequest request) {
		
		String bizName = "이용권 등록 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		UserSessionVO userSessionVO = (UserSessionVO)(request.getSession()).getAttribute("userSessionVO");
		
		List<VoucherMgmtVO> voucherTypeList = memberMgmtService.getVoucherType();
		
		java.util.Map<String, String> memberInfoMap = memberMgmtService.getMemberVoucherInfo(usr_seq);
		
		model.addAttribute("voucherTypeList", voucherTypeList);
		model.addAttribute("memberInfoMap", memberInfoMap);
		model.addAttribute("usr_seq", usr_seq);
		model.addAttribute("admin_ID", String.valueOf(userSessionVO.getUsrId()));
		
		return "/admin/common/popup/pop_vou_reg";
	}
	
	@RequestName(value="memberVoucherExtend")
	@RequestMapping(value="/memberVoucherExtend.do")
	public String memberVoucherExtend(@RequestParam(value="usr_seq") String usr_seq, ModelMap model, HttpServletRequest request) {
		
		String bizName = "이용권 연장 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		UserSessionVO userSessionVO = (UserSessionVO)(request.getSession()).getAttribute("userSessionVO");
		
		Map<String, String> memberInfoMap = memberMgmtService.getMemberVoucherInfo(usr_seq);
		Map<String, String> memberVoucherMap = memberMgmtService.getVoucherPeriodInfo(usr_seq);		
		
		model.addAttribute("memberInfoMap", memberInfoMap);
		model.addAttribute("memberVoucherMap", memberVoucherMap);
		model.addAttribute("usr_seq", usr_seq);
		model.addAttribute("admin_ID", String.valueOf(userSessionVO.getUsrId()));
		
		return "/admin/common/popup/pop_vou_extend";
	}
	
	@RequestName(value="creatVoucherAjax")
	@RequestMapping(value="/creatVoucherAjax.do")
	public String creatVoucherAjax(@ModelAttribute @Valid VoucherMgmtVO voucherMgmtVO, ModelMap model, HttpServletRequest request) {
		String bizName = "이용권 생성 Proc";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		int isCreate = 0;
		
		isCreate = memberMgmtService.creatVoucherProc(voucherMgmtVO);

		model.addAttribute("isCreate", String.valueOf(isCreate));
		
		return JSONVIEW;
		
	}
	
	@RequestName(value="extendVoucherAjax")
	@RequestMapping(value="/extendVoucherAjax.do")
	public String extendVoucherAjax(@ModelAttribute @Valid VoucherMgmtVO voucherMgmtVO, ModelMap model, HttpServletRequest request) {
		String bizName = "이용권 연장 Proc";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		int isUpdate = 0;
		
		isUpdate = memberMgmtService.extendVoucherProc(voucherMgmtVO);
		
		model.addAttribute("isUpdate", String.valueOf(isUpdate));
		
		return JSONVIEW;
		
	}
	
	@RequestName(value="expiryVoucherAjax")
	@RequestMapping(value="/expiryVoucherAjax.do")
	public String expiryVoucherAjax(@ModelAttribute @Valid VoucherMgmtVO voucherMgmtVO, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		try {
			//System.out.println(voucherMgmtVO.toString());
			memberMgmtService.expiryVoucher(voucherMgmtVO);
			model.put("resultMsg", "성공");
		} catch (Exception e) {
			model.put("resultMsg", "이용권 정지 처리를 실패하였습니다.");
			e.printStackTrace();
			new CfoodException("admin.manage.stationgroup.memberUnsubscribe");
		}
		
		return IConstants.JSONVIEW;
	}
	
	/* 추천 반납 대여소 list _ 20170113 _cms */
	@RequestName(value="returnRentalList")
	@RequestMapping(value="/returnRentalList.do")
	public String returnRentalList(@ModelAttribute @Valid ReturnListMgmtVO returnListMgmtVO, BindingResult result, Model model, HttpServletRequest request) {	
		
		boolean bResult = false;
		String targetUrl = "/admin/service/member/return/svc_return_list";
		String bizName = "추천 반납 대여소";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력

		// 날짜조회 (날짜 없을경우 현 날짜로 조회)
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String nowDay = sdf.format(cal.getTime());
		
		//default 한달전 부터 현재일 조회
		cal.add(Calendar.MONTH , -1);
		String nowDay2 = sdf.format(cal.getTime());
		
		if(returnListMgmtVO.getSearchStartDate() == null){
			returnListMgmtVO.setSearchStartDate(nowDay2);
		}
		if(returnListMgmtVO.getSearchEndDate() == null){
			returnListMgmtVO.setSearchEndDate(nowDay);
		}
			
		int totCnt = memberMgmtService.listReturnListCount(returnListMgmtVO);
		
		if(returnListMgmtVO.getPage() == null || returnListMgmtVO.getPage() == ""){
			returnListMgmtVO.setCurrentPageNo(1);
		}else{
			returnListMgmtVO.setCurrentPageNo(Integer.parseInt(returnListMgmtVO.getPage()));
		}
		
		PaginationInfo paginationInfo = getPagingInfo(returnListMgmtVO.getCurrentPageNo(), totCnt);
		
		returnListMgmtVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
		returnListMgmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<ReturnListMgmtVO> returnList = memberMgmtService.listReturnList(returnListMgmtVO);
		
		model.addAttribute("searchParam", returnListMgmtVO);
		model.addAttribute("returnList", returnList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		if(returnList != null)
			bResult = true;

		return bResult ? targetUrl : ERROR_PAGE;
	}
	
	
	/* 추천 반납 대여소 list _ 20170116 _cms */
	@RequestName(value="returnRentalDetail")
	@RequestMapping(value="/returnRentalDetail.do")
	public String returnRentalDetail(@ModelAttribute @Valid ReturnListMgmtVO returnListMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		boolean result = false;
		String targetUrl = "/admin/service/member/return/svc_return_detail";
		String bizName = "추천 반납 대여소 상세정보";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		if(!bResult.hasErrors()) {
			
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
			
			model.addAttribute("searchParam", returnListMgmtVO);
			ReturnListMgmtVO returnList = memberMgmtService.listReturnDetail(returnListMgmtVO);
			
			log.debug("사용자 seq = "+returnList.getUsrSeq());

			model.addAttribute("returnList", returnList);
			model.addAttribute("nowTime", sdf.format(now));
			
			result = true;
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	/* 대여일련번호 list _ 20170511 _JHN */
	@RequestName(value="rentSerialNum")
	@RequestMapping(value="/rentSerialNum.do")
	public String rentSerialNum(@ModelAttribute @Valid RentSerialNumVO rentSerialNumVO, BindingResult result, Model model, HttpServletRequest request) {	
		
		boolean bResult = false;
		String targetUrl = "/admin/service/member/rentSerialNum/svc_rentSerialNum_list";
		String bizName = "대여일련번호 목록";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력

		// 날짜조회 (날짜 없을경우 현 날짜로 조회)
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String nowDay = sdf.format(cal.getTime());
		
		//default 일주전 부터 현재일 조회
		cal.add(Calendar.DATE , -7);
		String nowDay2 = sdf.format(cal.getTime());
		
		if(rentSerialNumVO.getSearchStartDate() == null){
			rentSerialNumVO.setSearchStartDate(nowDay2);
		}
		if(rentSerialNumVO.getSearchEndDate() == null){
			rentSerialNumVO.setSearchEndDate(nowDay);
		}
			
		int totCnt = memberMgmtService.listRentSerialNumCount(rentSerialNumVO);
		
		if(rentSerialNumVO.getPage() == null || rentSerialNumVO.getPage() == ""){
			rentSerialNumVO.setCurrentPageNo(1);
		}else{
			rentSerialNumVO.setCurrentPageNo(Integer.parseInt(rentSerialNumVO.getPage()));
		}
		
		PaginationInfo paginationInfo = getPagingInfo(rentSerialNumVO.getCurrentPageNo(), totCnt);
		
		rentSerialNumVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
		rentSerialNumVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<RentSerialNumVO> rentSerialNumList = memberMgmtService.listRentSerialNum(rentSerialNumVO);
		
		model.addAttribute("searchParam", rentSerialNumVO);
		model.addAttribute("rentSerialNumList", rentSerialNumList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		if(rentSerialNumList != null)
			bResult = true;

		return bResult ? targetUrl : ERROR_PAGE;
	}
	
	/* 대여일련번호 상세 detail _ 20170512_JHN */
	@RequestName(value="rentSerialNumDetail")
	@RequestMapping(value="/rentSerialNumDetail.do")
	public String rentSerialNumDetail(@ModelAttribute @Valid RentSerialNumVO rentSerialNumVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws ParseException {
		
		boolean result = false;
		String targetUrl = "/admin/service/member/rentSerialNum/svc_rentSerialNum_detail";
		String bizName = "대여일련번호 상세정보";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		if(!bResult.hasErrors()) {
			
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
			
			model.addAttribute("searchParam", rentSerialNumVO);
			RentSerialNumVO rentSerialNumDetailList = memberMgmtService.listRentSerialNumDetail(rentSerialNumVO);
			Date dateVoucherEndDttm = null;
			if(rentSerialNumDetailList.getVoucherEndDttm().equals("-")){
				dateVoucherEndDttm = now;
			} else {
				dateVoucherEndDttm = sdf.parse(rentSerialNumDetailList.getVoucherEndDttm());
			}
			
			long nowTimeMillisec = now.getTime();
			long voucherEndDttmMillisec = dateVoucherEndDttm.getTime();
			String voucherCancelAbleYn = voucherEndDttmMillisec - nowTimeMillisec >= 0 ? "Y" : "N";
			
			log.debug("이용권 종료일(date)"+rentSerialNumDetailList.getVoucherEndDttm());
			log.debug("이용권 종료일(ms) = "+ voucherEndDttmMillisec);
			log.debug("현재시간(date) = " + sdf.format(now));
			log.debug("현재시간(ms) = " + nowTimeMillisec);
			log.debug("이용권 만료 가능 유무 = " + voucherCancelAbleYn);
			
			model.addAttribute("rentSerialNumDetailList", rentSerialNumDetailList);
			model.addAttribute("nowTimeDate", sdf.format(now));
			model.addAttribute("nowTimeMillisec", nowTimeMillisec);
			model.addAttribute("voucherEndDttmMillisec", voucherEndDttmMillisec);
			model.addAttribute("voucherCancelAbleYn", voucherCancelAbleYn);
			
			result = true;
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName(value="moveRentSerialNumCancelPop")
	@RequestMapping(value = "/moveRentSerialNumCancelPop.do")
	public String getRentSerialNumCancelInfo(@ModelAttribute RentSerialNumVO rentSerialNumVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		String targetUrl = POP_URL.concat("pop_rentSerialNumCancel_pro");
    	String bizName = "비회원(대여일련번호) 결제 취소 팝업 생성";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        RentSerialNumVO resultVo = null;
        UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
        try {
        	
        	resultVo = memberMgmtService.getCancelInfo(rentSerialNumVO);

        	model.addAttribute("viewFlg", resultVo.getViewFlg());
			model.addAttribute("rentSerialNumVO", resultVo);
			if(resultVo.getCancelAdminId()==""){
				model.addAttribute("userSessionVO", userSessionVO);
			}
			result =true;
        }catch(CfoodException e) {
        	throw new CfoodException("fail.common.msg" );
        }
        
		return result ? targetUrl : ERROR_PAGE;
	}
	
	/* 이용권 1시간 연장 */
	@RequestName(value="serialNoVoucher1HOUR")
	@RequestMapping(value="/serialNoVoucher1HOUR.do")
	public String serialNoVoucher1HOUR(@ModelAttribute @Valid PaymentVO paymentVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		//String targetUrl = "/admin/service/member/rentSerialNum/svc_rentSerialNum_detail";
		String bizName = "대여일련번호 강제 이용권 만료 처리";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		if(!bResult.hasErrors()) {
			
			RentSerialNumVO voucherExpiryParam = new RentSerialNumVO();
			voucherExpiryParam.setSerialNoPaymentSeq(String.valueOf(paymentVO.getPaymentSeq()));
			voucherExpiryParam.setPaymentDttm(paymentVO.getPaymentDttm());
			voucherExpiryParam.setCancelReasonDesc(paymentVO.getCancelReasonDesc());
			voucherExpiryParam.setCancelAdminId(paymentVO.getCancelAdminId());
			int result = memberMgmtService.setVoucherExpiry(voucherExpiryParam);
			model.addAttribute("result", result);
			
		}
		return JSONVIEW;
	}
	
	/* 대여일련번호 강제 이용권 만료 처리 _ 20170512_JHN */
	@RequestName(value="rentSerialNumVoucherExpiry")
	@RequestMapping(value="/rentSerialNumVoucherExpiry.do")
	public String rentSerialNumVoucherExpiry(@ModelAttribute @Valid PaymentVO paymentVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		//String targetUrl = "/admin/service/member/rentSerialNum/svc_rentSerialNum_detail";
		String bizName = "대여일련번호 강제 이용권 만료 처리";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		if(!bResult.hasErrors()) {
			
			RentSerialNumVO voucherExpiryParam = new RentSerialNumVO();
			voucherExpiryParam.setSerialNoPaymentSeq(String.valueOf(paymentVO.getPaymentSeq()));
			voucherExpiryParam.setPaymentDttm(paymentVO.getPaymentDttm());
			voucherExpiryParam.setCancelReasonDesc(paymentVO.getCancelReasonDesc());
			voucherExpiryParam.setCancelAdminId(paymentVO.getCancelAdminId());
			
			int result = memberMgmtService.setVoucherExpiry(voucherExpiryParam);
			model.addAttribute("result", result);
			
		}
		
		return JSONVIEW;
	}
	
	/* 대여일련번호 list _ 20170621 _JHN */
	@RequestName(value="mobileSmsAuth")
	@RequestMapping(value="/listMobileSmsAuth.do")
	public String mobileSmsAuth(@ModelAttribute @Valid MobileSmsAuthVO mobileSmsAuthVO, BindingResult result, Model model, HttpServletRequest request) {	
		
		boolean bResult = false;
		String targetUrl = "/admin/service/member/mobileSmsAuth/svc_mobileSmsAuth_list";
		String bizName = "핸드폰 인증 목록";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력

		// 날짜조회 (날짜 없을경우 현 날짜로 조회)
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String nowDay = sdf.format(cal.getTime());
		
		//default 일주전 부터 현재일 조회  --> default 당일 조회로 변경 2019.10.08
		//cal.add(Calendar.DATE , -7);
		String nowDay2 = sdf.format(cal.getTime());
		
		if(mobileSmsAuthVO.getSearchStartDate() == null){
			mobileSmsAuthVO.setSearchStartDate(nowDay2);
		}
		if(mobileSmsAuthVO.getSearchEndDate() == null){
			mobileSmsAuthVO.setSearchEndDate(nowDay);
		}
			
		int totCnt = memberMgmtService.listMobileSmsAuthCount(mobileSmsAuthVO);
		
		if(mobileSmsAuthVO.getPage() == null || mobileSmsAuthVO.getPage() == ""){
			mobileSmsAuthVO.setCurrentPageNo(1);
		}else{
			mobileSmsAuthVO.setCurrentPageNo(Integer.parseInt(mobileSmsAuthVO.getPage()));
		}
		
		PaginationInfo paginationInfo = getPagingInfo(mobileSmsAuthVO.getCurrentPageNo(), totCnt);
		
		mobileSmsAuthVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
		mobileSmsAuthVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<MobileSmsAuthVO> mobileSmsAuthList = memberMgmtService.listMobileSmsAuth(mobileSmsAuthVO);
		
		model.addAttribute("searchParam", mobileSmsAuthVO);
		model.addAttribute("mobileSmsAuthList", mobileSmsAuthList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		if(mobileSmsAuthList != null)
			bResult = true;

		return bResult ? targetUrl : ERROR_PAGE;
	}
	
	/* 대여일련번호 상세 detail _ 20170512_JHN */
	@RequestName(value="listMobileSmsAuthDetailPop")
	@RequestMapping(value="/listMobileSmsAuthDetailPop.do")
	public String listMobileSmsAuthDetailPop(@ModelAttribute @Valid MobileSmsAuthVO mobileSmsAuthVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws ParseException {
		
		boolean result = false;
		String targetUrl = POP_URL.concat("pop_mobileSmsAuth_info");
		String bizName = "SMS 인증 사용자 입력 번호 목록 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		if(!bResult.hasErrors()) {
			model.addAttribute("searchParam", mobileSmsAuthVO);
			List<MobileSmsAuthVO> mobileSmsAuthDetailList = memberMgmtService.listMobileSmsAuthDetail(mobileSmsAuthVO);
			
			model.addAttribute("mobileSmsAuthDetailList", mobileSmsAuthDetailList);
			
			result = true;
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	/**
	 * 회원정보 저장
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="memberSaveInfo")
	@RequestMapping(value="/memberSaveInfo.do")
	public String memberSaveInfo(MemberMgmtVO memberVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		log.debug(memberVo+"");
		boolean bResult = false;
		 String targetUrl = "redirect:/admin/service/member/memberInfo.do";
		// 그룹명 중복검사
		try {
			memberMgmtService.memberSaveInfo(memberVo);
			
			model.put("resultMsg", "성공");
			bResult = true;
		} catch (Exception e) {
			model.put("resultMsg", "실패");
			e.printStackTrace();
			new CfoodException("admin.manage.stationgroup.memberUnsubscribe");
		}
		//return bResult? targetUrl+= String.valueOf(memberVo.getUsr_seq()) : IConstants.ERROR_PAGE;
		//return bResult? targetUrl : IConstants.ERROR_PAGE;
		return JSONVIEW;
	}
	
	/**
	 * 회원 정보 목록 조회
	 * @param memberVo
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="memberCprList")
	@RequestMapping(value="memberCprList")
	public String memberCprList(  MemberMgmtVO memberVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		log.debug(result.hasErrors() + "");
		if (!result.hasErrors()) {
			model.put("result", "");
		} else {
			log.debug( result.getAllErrors().get(0).getDefaultMessage());
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("svc_usr_cpr_list");
		}
		
		
		memberVo.setLang(request.getLocale().getLanguage());
		
		boolean bResult = false;
		List<MemberMgmtVO> memberList = null;
		
		memberVo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
		memberVo.setPageSize(propertiesService.getInt("pageSize"));
		// 페이징 처리
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(memberVo.getCurrentPageNo());
		
		paginationInfo.setRecordCountPerPage(memberVo.getPageSize());
		paginationInfo.setPageSize(memberVo.getRecordCountPerPage());
		memberVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
		memberVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		
		try {
			log.debug(memberVo.toString());
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			if(memberVo.getSearchStartDate() == null){
				//memberVo.setSearchStartDate(strDay);
				memberVo.setSearchStartDate("2015-09-01");
			}
			if(memberVo.getSearchEndDate() == null){
				memberVo.setSearchEndDate(nowDay);
			}
			
			// total count
			paginationInfo.setTotalRecordCount(memberMgmtService.memberCprListCnt(memberVo));
			// 목록 조회
			memberList = memberMgmtService.memberCprList(memberVo);
			
			model.put("memberList", memberList);
			model.put("paginationInfo", paginationInfo);
			model.put("form", memberVo);
			
			bResult = true;
			
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.service.member.memberList");
		}
		
		return bResult? getReturnUrl("svc_usr_cpr_list") : ERROR_PAGE;
		
	}
	
	@RequestName(value="memberConfirm")
	@RequestMapping(value="/memberConfirm.do")
	public String memberCprConfirm(  MemberMgmtVO memberVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		String bizName = "법인회원 승인";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        
        model.addAttribute(RESULT_MESSAGE, "falut");
		try{
			memberMgmtService.memberCprConfirm(memberVo);
			model.addAttribute(RESULT_MESSAGE, "Success");

		} catch(Exception e){ throw new CfoodException("app.customer.opinionboard.opinionBoardDelete",e); }
		model.addAttribute(CHECK_RESULT, 0);
		
		return JSONVIEW;
	}
	
	/* 파일 다운로드 
	 */
	@RequestName(value="downloadFile")
	@RequestMapping(value="/downloadFile.do")	
	public ModelAndView downloadFile(MemberMgmtVO memberVo, BindingResult result, HttpServletRequest request, Model model) {
		
		ModelAndView mav = new ModelAndView("filedownloadView");
		
		System.out.println("memberVogetUsrSeq:::::::: " + memberVo.getUsr_seq());

		int noticeResult = 1;
		//현화면의 이름를 알려준다(notice)
		String folDer = "usrcpr";
		memberVo.setaFolder(folDer);
		
		try {
			String pathZipNm= memberMgmtService.fileDownloadList(memberVo);
			String fileNm= memberMgmtService.fileDownloadNm(memberVo);
			
			mav.addObject("fileName", new File(pathZipNm));
			mav.addObject("fileNm", new File(fileNm));

		} catch (Exception e) {
			noticeResult = 0;
		}
        return mav;
	}
	
	@RequestName(value="memberVoucherClsReg")
	@RequestMapping(value="/memberVoucherClsReg.do")
	public String memberVoucherClsReg(@RequestParam(value="payment_seq") String payment_seq, ModelMap model, HttpServletRequest request) {
		
		String bizName = "이용권 구분 등록 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
				
		List<VoucherMgmtVO> voucherTypeList = memberMgmtService.getVoucherType();
		
		model.addAttribute("voucherTypeList", voucherTypeList);
		model.addAttribute("payment_seq", payment_seq);
		
		return "/admin/common/popup/pop_vouCls_reg";
	}
	
	@RequestName(value="regVoucherClsAjax")
	@RequestMapping(value="/regVoucherClsAjax.do")
	public String regVoucherClsAjax(@ModelAttribute @Valid MemberPaymentVO paymentVo, ModelMap model, HttpServletRequest request) {
		String bizName = "이용권 구분 등록 Proc";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		int isCreate = 0;
		
		isCreate = memberMgmtService.updateVoucherClsProc(paymentVo);

		model.addAttribute("isCreate", String.valueOf(isCreate));
		
		return JSONVIEW;
		
	}
	
	@RequestName(value="membeRentClsCdReg")
	@RequestMapping(value="/membeRentClsCdReg.do")
	public String membeRentClsCdReg(@ModelAttribute @Valid MemberPaymentVO paymentVo, ModelMap model, HttpServletRequest request) {
		
		String bizName = "대여 구분 등록 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
				
		List<MemberPaymentVO> rentTypeList = memberMgmtService.getRentType();
		
		model.addAttribute("rentTypeList", rentTypeList);
		model.addAttribute("paymentVo", paymentVo);
		
		return "/admin/common/popup/pop_rentCls_reg";
	}
	
	@RequestName(value="regRentClsAjax")
	@RequestMapping(value="/regRentClsAjax.do")
	public String regRentClsAjax(@ModelAttribute @Valid MemberPaymentVO paymentVo, ModelMap model, HttpServletRequest request) {
		String bizName = "대여 구분 등록 Proc";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		int isCreate = 0;
		isCreate = memberMgmtService.updateRentClsProc(paymentVo);

		model.addAttribute("isCreate", String.valueOf(isCreate));
		
		return JSONVIEW;
		
	}
	
	@RequestName(value="delReserveRentAjax")
	@RequestMapping(value="/delReserveRentAjax.do")
	public String delReserveRentAjax(@ModelAttribute @Valid MemberPaymentVO paymentVo, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "예약대여 취소";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		int isCreate = 0;
		isCreate = memberMgmtService.delReserveRentProc(paymentVo);
		
		model.addAttribute("isCreate", String.valueOf(isCreate));
		
		return JSONVIEW;
		
	}
	
	/**
	 * 회원확인 SMS 발송 
	 * @param memberVo
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="pushSend")
	@RequestMapping(value="/pushSend.do")
	public String pushSend(MemberMgmtVO memberVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		

		String bizName = "회원확인 Push 발송";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		String TARGET_URL = "https://www.bikeseoul.com/main.do";
		int isCreate = 0;
		isCreate = memberMgmtService.insertMpnPushProc(memberVo);
		if(isCreate > 1000){
		// push 주석처리
		if("Y".equals( memberVo.getPush_yn())) {
			//push start
			
			
			List<String> pushList = new ArrayList<String>();
			//안드로이드
            if("android".equals( memberVo.getUsr_device_type())) {
            	
	            PushVO gcmVo = new PushVO();
	            //gcmVo.setPushType(IConstants.PUSH_TYPE_GCM);
	            gcmVo.setPushType("android");
	            gcmVo.setMessage("귀하의 현드폰 등록을 확인하여주세요");
	            gcmVo.setPushLinkUrl(TARGET_URL);
	            gcmVo.setUsrSeq(memberVo.getUsr_seq());
	            pushList.add("APA91bF2XR4YCQW1QOZSoCnqyoTYZaSXHaStIZYua5yuSc1ogXHIc0CyziDJi0rJYFRt99HQocbAtYKXpUXv0PpT4CtzRWRPFFl78_indMQlBvzplzQJ8ShmXxYqEvUMpy9Dlr6_trqb");
	            gcmVo.setTokenList(pushList);
                
	            try {
					PushSendProc.exePush(gcmVo);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
            }
            //아이폰
             if("ios".equals( memberVo.getUsr_device_type())) {
	            PushVO apnsVo = new PushVO();
	            //apnsVo.setPushType(IConstants.PUSH_TYPE_APNS);
	            apnsVo.setPushType("ios");
	            apnsVo.setMessage("귀하의 현드폰 등록을 확인하여주세요");
	            apnsVo.setPushLinkUrl(TARGET_URL);
	            apnsVo.setUsrSeq(memberVo.getUsr_seq());
	            pushList.add("APA91bF2XR4YCQW1QOZSoCnqyoTYZaSXHaStIZYua5yuSc1ogXHIc0CyziDJi0rJYFRt99HQocbAtYKXpUXv0PpT4CtzRWRPFFl78_indMQlBvzplzQJ8ShmXxYqEvUMpy9Dlr6_trqb");
	            apnsVo.setTokenList(pushList);
	            try {
					PushSendProc.exePush(apnsVo);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
            }
			
             //testPush
            // List<String> pushList = new ArrayList<String>();
             /*PushVO pushVo = new PushVO();
             pushVo.setPushType(IConstants.PUSH_TYPE_GCM);
             pushVo.setMessage(msg);
             pushVo.setPushLinkUrl(TARGET_URL);
             pushVo.setUsrSeq("841268");
             
             pushList.add("APA91bF2XR4YCQW1QOZSoCnqyoTYZaSXHaStIZYua5yuSc1ogXHIc0CyziDJi0rJYFRt99HQocbAtYKXpUXv0PpT4CtzRWRPFFl78_indMQlBvzplzQJ8ShmXxYqEvUMpy9Dlr6_trqb");
             pushVo.setTokenList(pushList);
             //PushSendProc.exePush(pushVo);
             //일단 공지사항 쪽에 테스트만듬
             int intResult = noticeService.insertPush(pushVo);*/
             
			//push end
	
		}
		}
		/*SmsMessageVO msg = new SmsMessageVO();
		msg.setTitle(bizName);
		msg.setDestno(memberVo.getUsr_mpn_no());
		SmsSender.sender(msg, SendType.SMS_006, memberVo.getMb_id());*/
		
		boolean isSuccess = true;
		model.addAttribute("isSuccess", String.valueOf(isSuccess));
		
		return JSONVIEW;
		
	}
	
	@RequestName(value="resetVoucherAjax")
	@RequestMapping(value="/resetVoucherAjax.do")
	public String resetVoucherAjax(@ModelAttribute @Valid VoucherMgmtVO voucherMgmtVO, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		try {
			memberMgmtService.resetVoucherProc(voucherMgmtVO);
			model.put("resultMsg", "성공");
			return IConstants.JSONVIEW;
		} catch (Exception e) {
			model.put("resultMsg", "이용권 초기화를 실패하였습니다.");
			e.printStackTrace();
		}
		return IConstants.JSONVIEW;
	}
	
	@RequestName(value="resetPasswordAjax")
	@RequestMapping(value="/resetPasswordAjax.do")
	public String resetPasswordAjax(@ModelAttribute @Valid MemberMgmtVO memberVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		try {
			
			memberMgmtService.resetMemberPasswordProc(memberVo);
			model.put("resultMsg", "성공");
			return IConstants.JSONVIEW;
		} catch (Exception e) {
			model.put("resultMsg", "비밀번호 초기화에 실패하였습니다.");
			e.printStackTrace();
		}
		return IConstants.JSONVIEW;
	}
}

