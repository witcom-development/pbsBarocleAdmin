/*
 * @Package Name : com.dkitec.barocle.admin.manage.common
 * @파일명          : DeviceCommonController.java
 * @작성일          : 2015. 4. 20.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 20.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.common.controller;


/*import java.math.BigInteger;*/
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.KeyStore;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
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
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dkitec.barocle.admin.common.service.CommonPopupService;
import com.dkitec.barocle.admin.common.vo.FindOutDeviceVO;
import com.dkitec.barocle.admin.common.vo.LocationVo;
import com.dkitec.barocle.admin.common.vo.RegularChkVO;
import com.dkitec.barocle.admin.common.vo.SmsSendVo;
import com.dkitec.barocle.admin.common.vo.TroubleReportVO;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO;
import com.dkitec.barocle.admin.service.membermgmt.service.MemberMgmtService;
import com.dkitec.barocle.admin.service.membermgmt.vo.MemberMgmtVO;
import com.dkitec.barocle.admin.service.paymentmgmt.failpayment.service.FailPaymentService;
import com.dkitec.barocle.admin.service.paymentmgmt.failpayment.vo.FailPaymentVO;
import com.dkitec.barocle.admin.service.paymentmgmt.mileage.vo.MileageVO;
import com.dkitec.barocle.admin.service.paymentmgmt.payment.ToSHA256Hex;
import com.dkitec.barocle.admin.service.paymentmgmt.payment.service.PaymentService;
import com.dkitec.barocle.admin.service.paymentmgmt.payment.vo.PaymentVO;
import com.dkitec.barocle.admin.status.rentHistory.vo.PenaltyVO;
import com.dkitec.barocle.admin.status.rentStatus.service.RentStatusService;
import com.dkitec.barocle.admin.status.rentStatus.vo.BikeRentalVO;
import com.dkitec.barocle.admin.status.stationStatus.service.StationStatusService;
import com.dkitec.barocle.admin.status.stationStatus.vo.StationStatusVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonStationVO;
import com.dkitec.barocle.admin.system.teammgmt.vo.TeamMgmtVO;
import com.dkitec.barocle.admin.system.usermgmt.vo.UserMgmtVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.sms.SendType;
import com.dkitec.barocle.util.sms.SmsSender;
import com.dkitec.barocle.util.sms.vo.SmsMessageVO;
import com.dkitec.barocle.util.webutil.HttpUtil;
import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.mainpay.sdk.utils.MakeID;
import com.mainpay.sdk.utils.ParseUtils;


/**
 * @파일명          : DeviceCommonController.java
 * @작성일          : 2015. 4. 20.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 20.   |   ymshin   |  최초작성
 */
@Controller
@RequestMapping(value="/common/pop")
@RequestCategory("CommonPopupController")
public class CommonPopupController extends BaseController {
	
	protected static Logger log = LoggerFactory.getLogger(CommonPopupController.class);
	
	@Resource(name="commonPopupService") private CommonPopupService commonPopupService;
	@Resource(name="rentStatusService") private RentStatusService rentStatusService;
	@Resource(name="memberMgmtService") private MemberMgmtService memberMgmtService;
	@Resource(name="bikeService") private BikeService bikeService;
	@Resource(name = "failPaymentService") private FailPaymentService failPaymentService;
	@Resource(name="commonCodeService") private CommonCodeService commonCodeService;
	@Resource(name="stationStatusService") private StationStatusService stationStatusService;
	@Resource(name="paymentService") private PaymentService paymentService;
	
	
	private static final String RETURN_URL = "/admin/common/popup/";
	
	/**
	 * 정기점검 팝업 저장process
	 * */
	@RequestMapping(value="/{deviceType}/regularChkupReg.do")
	@RequestName("regularChkupReg")
	public String regularChkupReg( @PathVariable("deviceType") String deviceType
			                     , @ModelAttribute @Valid RegularChkVO rVo
			                     , BindingResult bindingResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "장치 정기점검 공통 팝업";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        String messageResult = "저장이 성공 했습니다.";
        int result = 0;

        try {
            UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
            if(userSessionVO == null){
            	throw new CfoodException(getMessage("error.invalidSession"));
            }
            
        	List<ObjectError> errorList = bindingResult.getAllErrors();
     		if(errorList.size() > 0) {
     			for(ObjectError err : errorList) {
     				messageResult = err.getDefaultMessage();
     			}
     		} else {
     			rVo.setEquipmentClsCd(deviceType);
     			rVo.setModId(userSessionVO.getUsrId());
     			result = commonPopupService.addRegularCheckUpDevice(rVo);
     		}
     		
		} catch (Exception e) {
			throw new CfoodException("fail.common.msg",e.getMessage());
		}
       
		model.addAttribute(RESULT_MESSAGE, messageResult);
		model.addAttribute(CHECK_RESULT, result);
		
		return JSONVIEW;
	}
	@RequestMapping(value = "/{deviceType}/openUploadPop.do")
	@RequestName("openUploadPop")
	public String openUploadPop(@PathVariable("deviceType") String deviceType,@ModelAttribute ApVO apVo, ModelMap model, HttpServletRequest request )  throws Exception {
		String bizName = "장치 일괄등록 팝업 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		model.addAttribute("excelFlg", deviceType);
		model.addAttribute("errorList", new ArrayList<String>());
		return RETURN_URL.concat("opr_ex_up");
	}
	
	@RequestMapping(value="/findOutDeviceInfo.do")
	@RequestName("findOutDeviceInfo")
	public String findOutDeviceInfo( @ModelAttribute @Valid FindOutDeviceVO foVo
								   , BindingResult bindingResult, ModelMap model, HttpServletRequest req) {

		String bizName = "장치찿기 공통 팝업 검색";
        HttpUtil.printServiceLogStart(bizName, log, req);	// 서비스로그 시작 출력
		String messageResult = "";
		List<FindOutDeviceVO> deviceList = null;
		List<ObjectError> errorList = bindingResult.getAllErrors();
		try {
		    if(errorList.size() > 0) {
				for(ObjectError err : errorList) {
					messageResult = err.getDefaultMessage();
				}
			} else {
			    deviceList = commonPopupService.getFindOutDevice(foVo);
			}	
		} catch (Exception e) {
		    throw new CfoodException("fail.common.msg",e.getMessage());
		}
		model.addAttribute(RESULT_MESSAGE, messageResult);
		model.addAttribute("deviceList", deviceList);
		return JSONVIEW;
	}
	/*
	 * 2020-07-06
	 * 자전거수리입력 개선 화면에서 사용
	 * findOutDeviceInfo 과 차이점 : 자전거 번호를 검색 시 장애내역,신고내역도 보여준다
	 * 2020-10-06
	 * 배터리 교체일자를 자전거 찾기시에 얻는다  
	 */
	@RequestMapping(value="/findOutDeviceInfoDtlObs.do")
	@RequestName("findOutDeviceInfoDtlObs")
	public String findOutDeviceInfoDtlObs( @ModelAttribute @Valid FindOutDeviceVO foVo
			, BindingResult bindingResult, ModelMap model, HttpServletRequest req) {
		
		String bizName = "장치찿기 공통 팝업 검색";
		HttpUtil.printServiceLogStart(bizName, log, req);	// 서비스로그 시작 출력
		String messageResult = "";
		List<FindOutDeviceVO> deviceList = null;
		List<ObjectError> errorList = bindingResult.getAllErrors();
		try {
			if(errorList.size() > 0) {
				for(ObjectError err : errorList) {
					messageResult = err.getDefaultMessage();
				}
			} else {
				deviceList = commonPopupService.getBikeDeviceDtlObsInfo(foVo);
			}	
		} catch (Exception e) {
			throw new CfoodException("fail.common.msg",e.getMessage());
		}
		model.addAttribute(RESULT_MESSAGE, messageResult);
		model.addAttribute("deviceList", deviceList);
		return JSONVIEW;
	}
   
	@RequestMapping(value="/showBikeMissingPop.do")
	@RequestName("showBikeMissingPop")
    public String showBikeMissingPop(@ModelAttribute BikeVO bikeVo, ModelMap model,HttpServletRequest request) throws Exception {
    	String bizName = "자전거 분실 등록 popup";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
        if(userSessionVO == null){
        	throw new CfoodException(getMessage("error.invalidSession"));
        }
        bikeVo.setAdminId(userSessionVO.getUsrId());
    	model.addAttribute("bikeInfo", bikeVo);
    	return  RETURN_URL.concat("pop_lose_pro");
    }
    
	@RequestMapping(value="/missingBikeReg.do")
	@RequestName("missingBikeReg")
	public String missingBikeReg(@ModelAttribute BikeVO bikeVo, ModelMap model,HttpServletRequest request) throws Exception {
		String bizName = "자전거 분실 등록";
		String message = "";
		int result  =0;
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
    	UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
    	if(userSessionVO == null){
            throw new CfoodException(getMessage("error.invalidSession"));
        }
	    try {
	    	bikeVo.setAdminId(userSessionVO.getUsrId());
			BikeRentalVO rentalVo = new BikeRentalVO();
			rentalVo.setRentBikeId(bikeVo.getBikeId());
			
			if(bikeVo.getChkType().equals("I")) {
				BikeRentalVO current = rentStatusService.getCurrentRentData(rentalVo);
				if( current != null){
					result = commonPopupService.setBikeMissingRentStatus(current);
				}
				message = "분실등록이 되었습니다.";
			} else {
				message = "분실해제가 되었습니다.";
			}
			result = commonPopupService.setBikeMissingCondition(bikeVo);
		} catch (Exception e) {
			throw new CfoodException("fail.common.msg",e.getMessage());
		}
		
		model.addAttribute(RESULT_MESSAGE, message);
		model.addAttribute(CHECK_RESULT, result);
		return JSONVIEW;
	}
	@RequestMapping(value="/{deviceType}/showFODevicePop.do")
	@RequestName("showFODevicePop")
	public String showFODevicePop( @PathVariable("deviceType") String deviceType, @ModelAttribute FindOutDeviceVO foVo, ModelMap model, HttpServletRequest req) {

		String bizName = "장치찿기 공통 팝업";
        HttpUtil.printServiceLogStart(bizName, log, req);	// 서비스로그 시작 출력
		String targetUrl ="";
		if(deviceType.equals(IConstants.DEVICE_AP)){
			//무선ap
			targetUrl = RETURN_URL.concat("pop_ap_sch");
		} else if(deviceType.equals(IConstants.DEVICE_ARM)) {
			//거치대
			targetUrl = RETURN_URL.concat("pop_lock_sch");
		} else if(deviceType.equals(IConstants.DEVICE_BIKE)) {
			//자전거
			targetUrl = RETURN_URL.concat("pop_bike_sch");
		} else {
			//단말기
			targetUrl = RETURN_URL.concat("pop_dev_sch");
		}
		
        model.addAttribute("deviceType", deviceType);
        model.addAttribute("searchType", foVo.getSearchType());
        
		return targetUrl;
	}
	/*
	 * 2020-07-06
	 * 자전거수리입력 개선 화면에서 사용
	 * showFODevicePop 과 차이점 : 이 메소드의 리턴 팝업은 장애내역,신고내역도 보여준다 
	 */
	@RequestMapping(value="/{deviceType}/showFODevicePopDtlObs.do")
	@RequestName("showFODevicePopDtlObs")
	public String showFODevicePopDtlObs( @PathVariable("deviceType") String deviceType, @ModelAttribute FindOutDeviceVO foVo, ModelMap model, HttpServletRequest req) {
		
		String bizName = "장치찿기 공통 팝업 : 장애내역,신고내역 ";
		HttpUtil.printServiceLogStart(bizName, log, req);	// 서비스로그 시작 출력
		String targetUrl ="";
		
		if(deviceType.equals(IConstants.DEVICE_BIKE)) {
			//자전거
			targetUrl = RETURN_URL.concat("pop_bike_dtl_obs_sch");
		}
		
		model.addAttribute("deviceType", deviceType);
		model.addAttribute("searchType", foVo.getSearchType());
		
		return targetUrl;
	}
	// ,
	@RequestMapping(value="/{deviceType}/showRegularChkPop.do")
	@RequestName("getBeforeChkInfo")
	public String getBeforeChkInfo(@PathVariable("deviceType") String deviceType
								  ,@ModelAttribute @Valid RegularChkVO chkVo
								  ,BindingResult bResult
								  ,ModelMap model, HttpServletRequest req) {
		String bizName = "정기점검 데이터 검색후 정기점검 등록";
        HttpUtil.printServiceLogStart(bizName, log, req);	// 서비스로그 시작 출력
		//String equipmentId = req.getParameter("equipmentId");
        List<ObjectError> errorList =bResult.getAllErrors();
        String resultMessage = "";
        String result = OK;
        RegularChkVO resultVo = null;
        if(errorList.size() > 0) {
     	   for(ObjectError err : errorList) {
     	       resultMessage = err.getDefaultMessage();
     	       result = ERROR;
     	   }
        } else {
           RegularChkVO rVo = new RegularChkVO();
           
           rVo.setEquipmentClsCd(deviceType);
           rVo.setEquipmentId(chkVo.getEquipmentId());
           resultVo = commonPopupService.getBeforeChkInfo(rVo);
           
        }
       
        model.addAttribute( RESULT, result);
        model.addAttribute( RESULT_MESSAGE, resultMessage);
        model.addAttribute("resultVo", resultVo);
        model.addAttribute("deviceType", deviceType);
        model.addAttribute("equipmentId", chkVo.getEquipmentId());
        model.addAttribute("mode", chkVo.getMode());
        model.addAttribute("faultSeq", chkVo.getFaultSeq());
        
        return  RETURN_URL.concat("pop_rgl_chk");
	}
	
	@RequestMapping(value="/rentDetailPop.do")
	@RequestName("showRentDetailPop")
	public String showRentDetailPop(@ModelAttribute @Valid BikeRentalVO rentVo, BindingResult bResult, ModelMap model,HttpServletRequest request) throws SQLException {
		String bizName = "대여 상세화면 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		BikeVO bVo = new BikeVO();
		bVo.setRentHistSeq(rentVo.getRentHistSeq());
		bVo.setPagingYn(N);
		//대여중인 자전거를 구분하기 위해_2017.02.27_JHN
		bVo.setRackId(rentVo.getReturnRackId());
		MemberMgmtVO mbVo = new MemberMgmtVO();
		String rentYn = "";
		BikeRentalVO rRentVo = null;
		FailPaymentVO failPaymentVO = new FailPaymentVO();
		List<FailPaymentVO> resultList = null;
		BigInteger rentHistseqBi = new BigInteger(rentVo.getRentHistSeq());
		
		failPaymentVO.setRentHistSeq(rentHistseqBi);
		
		if(rentVo.getReturnRackId() == null){
			rentVo.setReturnRackId("unneeded");
		} else {
			mbVo.setUsr_seq(rentVo.getUsrSeq());
			if(bVo.getRackId().equals("-")){
				rentYn = memberMgmtService.getRentYn(mbVo);
			}
		}
		
		if(rentYn.equals("N")){
			rentVo.setRentClsCdName("-");
			rRentVo = rentVo;
		} else {
/*			
			rRentVo = commonPopupService.getBikeHistoryInfo(bVo).get(0);
			failPaymentVO.setStartPaymentDttm(rRentVo.getRentDttm());
			failPaymentVO.setEndPaymentDttm(rRentVo.getReturnDttm());
			resultList = failPaymentService.getFailPaymentList(failPaymentVO);
*/			
			List<BikeRentalVO> rs = commonPopupService.getBikeHistoryInfo(bVo);
			
			if ( rs.size() > 0 ) {
				rRentVo = rs.get(0);
				failPaymentVO.setStartPaymentDttm(rs.get(0).getRentDttm());
				failPaymentVO.setEndPaymentDttm(rs.get(0).getReturnDttm());
				resultList = failPaymentService.getFailPaymentList(failPaymentVO);
			} else {
				rRentVo = rentVo;
			}
			
		}
		//추가 및 변경  end 2017.02.27
		
//		BikeRentalVO rRentVo = commonPopupService.getBikeHistoryInfo(bVo).get(0);//원본_2017.02.27
		
		model.addAttribute("detailInfo", rRentVo);
		model.addAttribute("failInfo", resultList);
		
		return  RETURN_URL.concat("pop_rent_detail");
	}
	
	@RequestMapping(value="/showPenaltyImpose.do")
	@RequestName("showPenaltyImpose")
	public String showPenaltyImpose(@ModelAttribute PenaltyVO penaltyVo, ModelMap model, HttpServletRequest request) {
		
		String bizName = "벌점 부과 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		PenaltyVO info = null;
		if(penaltyVo.getViewType().equals(MODE_UPDATE) || penaltyVo.getViewType().equals(MODE_VIEW)) {
			info = commonPopupService.getPenaltyDetailInfo(penaltyVo);
		}
		
		model.addAttribute("penaltyVo", penaltyVo);
		model.addAttribute("penaltyInfo", info);
		return RETURN_URL.concat("pop_pen_pro");
	}
    
	@RequestMapping(value="/showSmsPopup.do")
	@RequestName("showSmsPopup")
	public String showSmsPopup(@RequestParam("UsrMpnNo") String usrMpnNo, ModelMap model, HttpServletRequest request) {
		
		String bizName = "sms 발송 모달 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		try {
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		model.addAttribute("UsrMpnNo", usrMpnNo);
		model.addAttribute("smsList", null);
		
		return RETURN_URL.concat("pop_sms_pro");
	}
	
	@RequestMapping(value="/showCompulsionBikeReturn.do")
	@RequestName("showCompulsionBikeReturn")
    public String showCompulsionBikeReturn(@ModelAttribute @Valid BikeRentalVO rentalVo, BindingResult bindingResult, ModelMap model, HttpServletRequest request) throws Exception {
		
		String bizName = "강제 반납";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		UserSessionVO user = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		StationStatusVO statusVo = new StationStatusVO();
		
		List<StationStatusVO> stationList = null;
		if(user == null){
            throw new CfoodException(getMessage("error.invalidSession"));
        }
		String resultMessage = "";
		BikeRentalVO compulsionInfo = null;
		try {
			if(bindingResult.hasErrors()) {
				for(ObjectError error : bindingResult.getAllErrors()) {
					resultMessage = error.getDefaultMessage();
				}
			} else {
				compulsionInfo = rentStatusService.getCompulsionInfo(rentalVo);	
				if(compulsionInfo == null ){
					resultMessage = "이미 강제 반납된 대여입니다.";
				}
				
			}
			
			stationList  = stationStatusService.getStationNameList(statusVo);	
			CommonCodeVO cVo = new CommonCodeVO();
        	cVo.setComUpCd("NRR");
        	List<CommonCodeVO> codeList = commonCodeService.getComCodeInfo(cVo);
     	    model.addAttribute("codeList", codeList);
			
			
			
		} catch (Exception e) {
			throw new CfoodException("fail.common.msg",e.getMessage());
		}
		model.addAttribute(RESULT_MESSAGE, resultMessage);
		model.addAttribute("adminId", user.getUsrId());
		model.addAttribute("info"   , compulsionInfo);
		model.addAttribute("stationList"   , stationList);
		
		return RETURN_URL.concat("pop_re_pro");
	}
	@RequestMapping(value="/showBikeParkingLocation.do")
	@RequestName("showBikeParkingLocation")
    public String showBikeParkingLocation(@ModelAttribute @Valid BikeRentalVO rentalVo, BindingResult bindingResult, ModelMap model, HttpServletRequest request) throws Exception {

		String bizName = "임의장소 요청";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		UserSessionVO user = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		StationStatusVO statusVo = new StationStatusVO();
		
		List<StationStatusVO> stationList = null;
		if(user == null){
            throw new CfoodException(getMessage("error.invalidSession"));
        }
		String resultMessage = "";
		//BikeRentalVO compulsionInfo = null;
		try {
			if(bindingResult.hasErrors()) {
				for(ObjectError error : bindingResult.getAllErrors()) {
					resultMessage = error.getDefaultMessage();
				}
			}
			
			stationList  = stationStatusService.getStationNameList(statusVo);	
			
			
		} catch (Exception e) {
			throw new CfoodException("fail.common.msg",e.getMessage());
		}
		model.addAttribute(RESULT_MESSAGE, resultMessage);
		model.addAttribute("adminId", user.getUsrId());
		model.addAttribute("info"   , rentalVo);
		model.addAttribute("stationList"   , stationList);
		
		return RETURN_URL.concat("pop_parkLoc_pro");
	}
	@RequestMapping(value="/exeEditPenalty.do")
	@RequestName("exeEditPenalty")
	public String exeEditPenalty(@ModelAttribute @Valid PenaltyVO penaltyVo,  BindingResult bindingResult, ModelMap model, HttpServletRequest request ) throws Exception {
		String bizName = "벌점 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		String resultMessage = "수정에 성공했습니다.";
		UserSessionVO user = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		if(user == null){
            throw new CfoodException(getMessage("error.invalidSession"));
        }
		int result = 0;
		try {
			if(bindingResult.hasErrors()) {
				for(ObjectError error : bindingResult.getAllErrors()) {
					resultMessage = error.getDefaultMessage();
				}
			} else {
				if(penaltyVo.getViewType().equals(MODE_INSERT)) {
					penaltyVo.setAdminId(user.getUsrId());
					result = commonPopupService.addRentPenaltyImpose(penaltyVo);
					/*if(result > 0){
						//블랙리슽에 해당 유무 체크
						boolean existBlack = commonPopupService.existBlackUsr(penaltyVo);
						if(!existBlack) {
							
							boolean isBlackList = commonPopupService.isBlackList(penaltyVo);
							if(isBlackList) {
								//블랙목록 등록.
								BlackListMgmtVO blVo = new BlackListMgmtVO();
								blVo.setUsrSeq(penaltyVo.getUsrSeq());
								blVo.setBlkListReasonCd("BLA_001");
								blVo.setAuth_di_val(memberMgmtService.getMemberUsrAuthVal(blVo));
								result = memberMgmtService.regBlackList(blVo) ? 1 : 0;
							}
						} 
					}*/
				} else {
					result = commonPopupService.delRentPenaltyImpose(penaltyVo);
				}
			}
		} catch (Exception e) {
			
			e.printStackTrace();
			
			throw new CfoodException("fail.common.msg",e.getMessage());
		}
		model.addAttribute(RESULT_MESSAGE, resultMessage);
		model.addAttribute(RESULT, result);
		
		return JSONVIEW;
	}
	@RequestMapping(value="/getSmsMessageList.do")
	@RequestName("getSmsMessageList")
	public String getSmsMessageList(@ModelAttribute SmsSendVo smsVo, ModelMap model, HttpServletRequest request) {
		
		String bizName = "SMS 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		List<SmsSendVo> smsList = commonPopupService.getSmsMessageList();
		model.addAttribute("smsMsgList", smsList);
		
		return JSONVIEW;
	}
	/**
	 * TODO :강제 반납처리
	 * 현재 대여현황을 삭제.대여이력 생성. 대여금액 처리와 정기권 이용자일 경우의 처리.
	 * */
/*	@RequestMapping(value="/exeImpulseBikeReturn.do")
	@RequestName("exeImpulseBikeReturn")
	public String exeImpulseBikeReturn(@ModelAttribute @Valid BikeRentalVO rentalVo, BindingResult bindingResult, ModelMap model, HttpServletRequest request) {
		String bizName = "강제 반납처리";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        int result = 0;
        String resultMessage = "강제 반납처리에 성공했습니다.";
		try {
			BikeRentalVO currentInfo = rentStatusService.getCurrentRentData(rentalVo);
			//반납스테이션, 반납 거치대 정보는??? 빈값으로
			//1)대여 테이블 삭제
			//2)대여 이력 등록
			if(currentInfo != null){
				currentInfo.setUseMi(rentalVo.getUseMi());
				currentInfo.setAdminId(rentalVo.getAdminId());
				currentInfo.setOverFeeYn("N");
				currentInfo.setOverMi("0");
				currentInfo.setOverFee("0");
				if(Integer.parseInt(rentalVo.getUseMi()) > Integer.parseInt(currentInfo.getBaseRentTime())) {
					currentInfo.setOverFee(String.valueOf( this.getOverFee( currentInfo.getPaymentClsCd() ,Integer.parseInt(rentalVo.getUseMi()))));
					currentInfo.setOverFeeYn("Y");
					currentInfo.setOverMi(String.valueOf(Integer.parseInt(rentalVo.getUseMi()) - Integer.parseInt(currentInfo.getBaseRentTime())));
				}
				
				//강제 반납 추가정보 입력
				currentInfo.setEnfrcReturnStationId(rentalVo.getEnfrcReturnStationId());
				currentInfo.setDeviceCnncCd(rentalVo.getDeviceCnncCd());
				currentInfo.setEnfrcReturnCd(rentalVo.getEnfrcReturnCd());
				//currentInfo.setParkingLocation(rentalVo.getParkingLocation());
				currentInfo.setParkingLocation(new String(rentalVo.getParkingLocation().getBytes("ISO-8859-1"), "UTF-8"));
				currentInfo.setPhotoYn(rentalVo.getPhotoYn());
				currentInfo.setEmrgncyYn(rentalVo.getEmrgncyYn());
				currentInfo.setParkingLocationYn(rentalVo.getParkingLocationYn());
				currentInfo.setLatitude(rentalVo.getLatitude());
				currentInfo.setLongitude(rentalVo.getLongitude());
				
				
				result = rentStatusService.exeImpulseBikeReturn(currentInfo);
				log.debug("강제 반납 결과 :::::"+result);
				if(result > 0) {
					if(currentInfo.getUsrMpnNo() != null && !currentInfo.getUsrMpnNo().equals("")) {
						SmsMessageVO smsVo = new SmsMessageVO();
						smsVo.setDestno(currentInfo.getUsrMpnNo());
						smsVo.setMsg(SendType.SMS_008, currentInfo.getRentBikeNo());
						SmsSender.sender(smsVo);
					}
				}
			} else {
				resultMessage = "대여 이력이 없습니다.";
			}
			
		} catch (Exception e) {
			resultMessage = "강제 반납처리에 실패했습니다.:" + e.getMessage() ;
			throw new CfoodException("service error", e);
		} finally{
			if(result < 0){
				resultMessage = "강제 반납처리에 실패했습니다.";
			}
		}
		model.addAttribute(CHECK_RESULT, result);
		model.addAttribute(RESULT_MESSAGE, resultMessage);
		return JSONVIEW;
	}*/
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/exeImpulseBikeReturn.do")
	@RequestName("exeImpulseBikeReturn")
	public String exeImpulseBikeReturn(@ModelAttribute @Valid BikeRentalVO rentalVo, BindingResult bindingResult, ModelMap model, HttpServletRequest request) {
		String bizName = "강제 반납처리";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        int result = 0;
        String resultMessage = "강제 반납처리에 성공했습니다.";
		try {
			BikeRentalVO currentInfo = rentStatusService.getCurrentRentData(rentalVo);
			//반납스테이션, 반납 거치대 정보는??? 빈값으로
			//1)대여 테이블 삭제
			//2)대여 이력 등록
			if(currentInfo != null){
				currentInfo.setUseMi(rentalVo.getUseMi());
				currentInfo.setAdminId(rentalVo.getAdminId());
				currentInfo.setOverFeeYn("N");
				currentInfo.setOverMi("0");
				currentInfo.setOverFee("0");
				if(Integer.parseInt(rentalVo.getUseMi()) > Integer.parseInt(currentInfo.getBaseRentTime())) {
					currentInfo.setOverFee(String.valueOf( this.getOverFee( currentInfo.getPaymentClsCd() ,Integer.parseInt(rentalVo.getUseMi()))));
					currentInfo.setOverFeeYn("Y");
					currentInfo.setOverMi(String.valueOf(Integer.parseInt(rentalVo.getUseMi()) - Integer.parseInt(currentInfo.getBaseRentTime())));
				}
					
				//강제 반납 추가정보 입력
				currentInfo.setReturnStationId(rentalVo.getEnfrcReturnStationId());
				currentInfo.setEnfrcReturnStationId(rentalVo.getEnfrcReturnStationId());
				currentInfo.setDeviceCnncCd(rentalVo.getDeviceCnncCd());
				currentInfo.setEnfrcReturnCd(rentalVo.getEnfrcReturnCd());
				currentInfo.setParkingLocation(rentalVo.getParkingLocation());
				//currentInfo.setParkingLocation(new String(rentalVo.getParkingLocation().getBytes("ISO-8859-1"), "UTF-8"));
				currentInfo.setPhotoYn(rentalVo.getPhotoYn());
				currentInfo.setEmrgncyYn(rentalVo.getEmrgncyYn());
				currentInfo.setParkingLocationYn(rentalVo.getParkingLocationYn());
				currentInfo.setLatitude(rentalVo.getLatitude());
				currentInfo.setLongitude(rentalVo.getLongitude());
				currentInfo.setLostBikeYn(rentalVo.getLostBikeYn());
					
				// 상용에 올릴때 변경 하고 업로드 해야함
				//currentInfo.setEnfrcReturnDesc(new String(rentalVo.getEnfrcReturnDesc().getBytes("ISO-8859-1"), "UTF-8"));
				currentInfo.setEnfrcReturnDesc(rentalVo.getEnfrcReturnDesc());
				//currentInfo.setAddr(new String(rentalVo.getAddr().getBytes("ISO-8859-1"), "UTF-8"));
				currentInfo.setAddr(rentalVo.getAddr());
				currentInfo.setEnfrcGubunCd(rentalVo.getEnfrcGubunCd());
					
				if(currentInfo.getLatitude().equals("")){
					currentInfo.setLatitude(null);
					currentInfo.setLongitude(null);
				}
				//파일 관련
				currentInfo.setEnfrcFile(rentalVo.getEnfrcFile());
				currentInfo.setEnfrcFileNoList(rentalVo.getEnfrcFileNoList());
				currentInfo.setEnfrcFileStateList(rentalVo.getEnfrcFileStateList());
				
				// 해당 변수에 값이 있으면 rentHistSeq를 반환한다.
				currentInfo.setViewFlg("enf");
				
				result = rentStatusService.exeImpulseBikeReturn(currentInfo);

				//result = 1;
				log.debug("강제 반납 결과 rentHistSeq :::::"+result);
				if(result > 0) {
					
					// 결제 할 금액이 있다면 결제 진행
					if("Y".equals(currentInfo.getOverFeeYn())){
					
						// 대여완료 처리 되었으니 빌링키 조회 후 이용금액 결제 진행
						PaymentVO addPayMethodVO = new PaymentVO();
						FailPaymentVO failPaymentVO = new FailPaymentVO();
						BigInteger myBigIntegerValue = new BigInteger( rentalVo.getUsrSeq() );
						System.out.println("myBigIntegerValue========>"+myBigIntegerValue);
						addPayMethodVO.setUsrSeq(myBigIntegerValue);
			        	PaymentVO AddPayMethod = paymentService.getAddPayMethod(addPayMethodVO);
			        	
			        	// 빌링키 없으므로 결제 실패 처리
			        	if( AddPayMethod.getBillingKey() == null && "".equals(AddPayMethod.getBillingKey()) ){
			        		// 결제 실패 hist 등록
			        		failPaymentVO.setUsrSeq(myBigIntegerValue);
			        		failPaymentVO.setPaymentMethodCd("BIM_008");
			        		failPaymentVO.setPaymentAmt(Integer.parseInt(currentInfo.getOverFee()));
			        		failPaymentVO.setErrCd("enfErr");
			        		failPaymentVO.setErrMsg("cannot find BillingKey");
			        		
			        		result = failPaymentService.addTicketPaymentFail(failPaymentVO);
			        		
			        		resultMessage = "반납처리는 성공하였으나, 빌링키조회가 되지 않아 결제 실패하였습니다.";
			        		
			        		model.addAttribute(RESULT_MESSAGE, resultMessage);
			        		return RETURN_URL.concat("pop_re_pro");
			        	}
			        	
						HashMap<String, String> info_param = new HashMap<String, String>();
						info_param.put("totAmt", currentInfo.getOverFee());
						info_param.put("billingKey", AddPayMethod.getBillingKey());
						
						HashMap<String, String> chargeResult = new HashMap<String, String>();
						chargeResult = mainPayChargeAPI(info_param);
						
						if("200".equals(chargeResult.get("resultCode"))){
							// 결제 성공 데이터 넣기
							chargeResult.put("usrSeq", rentalVo.getUsrSeq());
							chargeResult.put("paymentMethodCd", "BIM_001");
							chargeResult.put("processReasonDesc", "정상처리");
							chargeResult.put("rentHistSeq", Integer.toString(result));
							
							// insert payment update overFee table
							result = paymentService.addChargeInfo(chargeResult);
													
							resultMessage = "강제반납 처리 및 이용결제가 완료되었습니다.";
						}else{
							// 결제 실패 데이터 넣기
							failPaymentVO.setUsrSeq(myBigIntegerValue);
			        		failPaymentVO.setPaymentMethodCd("BIM_008");
			        		failPaymentVO.setPaymentAmt(Integer.parseInt(currentInfo.getOverFee()));
			        		failPaymentVO.setErrCd(chargeResult.get("resultCode"));
			        		failPaymentVO.setErrMsg(chargeResult.get("resultMessage"));
			        		
			        		result = failPaymentService.addTicketPaymentFail(failPaymentVO);
							resultMessage = "강제반납 처리는 완료되었으나 결제가 실패하였습니다.";
						}
					}else{
						// 이용관련 결제 금액 없음
					}
					// 문자에 보낼 날짜 구하기
					Date now = new Date();
					SimpleDateFormat formatter = new SimpleDateFormat("MM월dd일 HH시 mm분 ss초");
					String formatedNow = formatter.format(now);
					
					if(currentInfo.getUsrMpnNo() != null && !currentInfo.getUsrMpnNo().equals("")) {
						SmsMessageVO smsVo = new SmsMessageVO();
						smsVo.setDestno(currentInfo.getUsrMpnNo());
						smsVo.setMsg(SendType.SMS_090, currentInfo.getRentBikeNo(), formatedNow, currentInfo.getReturnStationName());
						SmsSender.sender(smsVo);
					}
				}else{
					resultMessage = "강제반납처리에 실패했습니다.\n반넙처리 도중 오류가 발생했습니다.";
				}
				
			} else {
				resultMessage = "대여 이력이 없습니다.";
			}
			
		} catch (Exception e) {
			resultMessage = "강제 반납처리에 실패했습니다.:" + e.getMessage() ;
			throw new CfoodException("fail.common.msg", e);
		} finally{
			if(result < 0){
				resultMessage = "강제 반납처리에 실패했습니다.";
			}
		}
		model.addAttribute(CHECK_RESULT, result);
		model.addAttribute(RESULT_MESSAGE, resultMessage);
		return RETURN_URL.concat("pop_re_pro");
	}
	
	/*@RequestMapping(value="/exeBikeParkingLocation.do")
	@RequestName("exeBikeParkingLocation")
	public String exeBikeParkingLocation(@ModelAttribute @Valid BikeRentalVO rentalVo, BindingResult bindingResult, ModelMap model, HttpServletRequest request) {
		String bizName = "임의장소 요청 등록";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        int result = 0;
        String resultMessage = "임의장소 요청 등록에 성공했습니다.";
		try {
			// 상용에 올리면 깨지므로 나중에 지우기
			rentalVo.setParkingLocation(new String(rentalVo.getParkingLocation().getBytes("ISO-8859-1"), "UTF-8"));
			rentalVo.setParkingLocationDesc(new String(rentalVo.getParkingLocationDesc().getBytes("ISO-8859-1"), "UTF-8"));
			result = rentStatusService.exeBikeParkingLoication(rentalVo);
			log.debug("임의장소 요청 결과 :::::"+result);
				
			
		} catch (Exception e) {
			resultMessage = "임의장소 요청 등록에 실패했습니다.:" + e.getMessage() ;
			throw new CfoodException("service error", e);
		} finally{
			if(result < 0){
				resultMessage = "임의장소 요청 등록에 실패했습니다.";
			}
		}
		model.addAttribute(CHECK_RESULT, result);
		model.addAttribute(RESULT_MESSAGE, resultMessage);
		return JSONVIEW;
	}*/
	
	@RequestMapping(value="/exeBikeParkingLocation.do")
	@RequestName("exeBikeParkingLocation")
	public String exeBikeParkingLocation(@ModelAttribute @Valid BikeRentalVO rentalVo, BindingResult bindingResult, ModelMap model, HttpServletRequest request) {
		String bizName = "임의장소 요청 등록";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        int result = 0;
        String resultMessage = "임의장소 요청 등록에 성공했습니다.";
		try {
			// 상용에 올리면 깨지므로 나중에 지우기
			//rentalVo.setParkingLocation(new String(rentalVo.getParkingLocation().getBytes("ISO-8859-1"), "UTF-8"));
			//rentalVo.setParkingLocationDesc(new String(rentalVo.getParkingLocationDesc().getBytes("ISO-8859-1"), "UTF-8"));
			//rentalVo.setAddr(new String(rentalVo.getAddr().getBytes("ISO-8859-1"), "UTF-8"));
			
			rentalVo.setParkingLocation(rentalVo.getParkingLocation());
			rentalVo.setParkingLocationDesc(rentalVo.getParkingLocationDesc());
			rentalVo.setAddr(rentalVo.getAddr());
			
			if(rentalVo.getLatitude().equals("")){
				rentalVo.setLatitude(null);
				rentalVo.setLongitude(null);
			}
			
			result = rentStatusService.exeBikeParkingLoication(rentalVo);
			log.debug("임의장소 요청 결과 :::::"+result);
				
			
		} catch (Exception e) {
			resultMessage = "임의장소 요청 등록에 실패했습니다.:" + e.getMessage() ;
			throw new CfoodException("fail.common.msg", e);
		} finally{
			if(result < 0){
				resultMessage = "임의장소 요청 등록에 실패했습니다.";
			}
		}
		model.addAttribute(CHECK_RESULT, result);
		model.addAttribute(RESULT_MESSAGE, resultMessage);
		return RETURN_URL.concat("pop_parkLoc_pro");
	}
	
	
	/**
	 * @location : com.dkitec.barocle.admin.common.controller.CommonPopupController.getOverFee
	 * @writeDay : 2015. 7. 22. 오후 4:58:17
	 * @return   : String
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 7. 22.   |   ymshin   |  최초작성
	 */ 
	private int getOverFee(String paymentClsCd  ,int useMin) {
		Map<String, Object> fee = new HashMap<String, Object>();
		//fee.put("ADD_FEE_CLS", this.getAddFeeClsCd(paymentClsCd));
		fee.put("ADD_FEE_CLS", "H");
		fee.put("POLICY_TYPE", "Min");
		fee.put("USE_MIN", useMin);
		Map<String, Object> minPolicy = rentStatusService.getOverFeePolicy(fee);
		fee.put("POLICY_TYPE", "Max");
		Map<String, Object> maxPolicy = rentStatusService.getOverFeePolicy(fee);
		
		//int overPay = new OverFeeCalcUtil().getPay(minPolicy, maxPolicy, useMin);
		fee.put("POLICY_TYPE", "");
		Map<String, Object> policy = rentStatusService.getOverFeePolicy(fee);
		int overPay = Integer.parseInt(policy.get("ADD_FEE").toString());
		
		return overPay;
	}
	/**
	 * @location : com.dkitec.barocle.admin.common.controller.CommonPopupController.getAddFeeClsCd
	 * @writeDay : 2015. 7. 22. 오후 6:03:22
	 * @return   : Object
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 7. 22.   |   ymshin   |  최초작성
	 */ 
	private Object getAddFeeClsCd(String paymentClsCd) {
		String addFee = "";
		if(paymentClsCd.equals("BIL_007")){
			addFee = "N";
		} else if(paymentClsCd.equals("BIL_006") || paymentClsCd.equals("BIL_008")){
			addFee = "M";
		} else if(paymentClsCd.equals("BIL_011") || paymentClsCd.equals("BIL_012") || paymentClsCd.equals("BIL_013") || paymentClsCd.equals("BIL_014") || paymentClsCd.equals("BIL_015") || paymentClsCd.equals("BIL_016") || paymentClsCd.equals("BIL_017")){
			addFee = "P";
		} else {
			addFee = "S";
		}
		return addFee;
	}
	@RequestMapping(value="/showStationStatusPop.do")
	@RequestName("showStationStatusPop")
	public String showStationStatusPop(@RequestParam("defaultLevel")String defaultLevel , ModelMap model, HttpServletRequest request){
		String bizName = "대여소 현황 전체 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		model.addAttribute("naverMapApiKey",super.propertiesService.getString("naverMapApiKey"));
		model.addAttribute("defaultLevel", defaultLevel);
		return RETURN_URL.concat("pop_sta_state");
	}
	
	@RequestMapping(value="/showLocationMapPop.do")
	@RequestName("showLocationMapPop")
	public String showLocationMapPop(@ModelAttribute @Valid LocationVo locationVo, ModelMap model, HttpServletRequest request){
		String bizName = "위치 지도 찾기 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		model.addAttribute("latitude", locationVo.getLatitude());
		model.addAttribute("longitude", locationVo.getLongitude());
		model.addAttribute("naverMapApiKey",super.propertiesService.getString("naverMapApiKey"));
		
		return RETURN_URL.concat("pop_map_sch");
	}
	
	@RequestMapping(value="/showUserFindPop.do")
	@RequestName("showUserFindPop")
	public String showUserFindPop(@ModelAttribute @Valid UserMgmtVO userMgmtVo, ModelMap model, HttpServletRequest request){
		String bizName = "운영자찾기 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		model.addAttribute("userMgmtVo", userMgmtVo);
		return RETURN_URL.concat("pop_men_sch");
	}
	
	@RequestMapping(value = "/{deviceType}/showTroubleReportPop.do")
	@RequestName("showTroubleReportPop")
	public String showTroubleReportPop(@PathVariable("deviceType") String deviceType,
			@ModelAttribute @Valid TroubleReportVO troubleReportVo, ModelMap model,
			HttpServletRequest request) {
		String bizName = "고장신고 공통 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		String targetUrl = "";

		try{
			troubleReportVo.setReportId((String) com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			troubleReportVo.setDeviceType(deviceType);
			
			if (deviceType.equals(IConstants.DEVICE_AP)) {
				// 무선ap
				troubleReportVo.setApId(troubleReportVo.getEquipmentId());
				targetUrl = RETURN_URL.concat("pop_ap_rep");
			} else if (deviceType.equals(IConstants.DEVICE_ARM)) {
				// 거치대
				troubleReportVo.setRackId(troubleReportVo.getEquipmentId());
				targetUrl = RETURN_URL.concat("pop_lock_rep");
			} else if(deviceType.equals(IConstants.DEVICE_BIKE)) {
				// 자전거
				troubleReportVo.setBikeNo(troubleReportVo.getEquipmentId());
				targetUrl = RETURN_URL.concat("pop_bike_rep");
			}
			
			if(troubleReportVo.getFaultSeq() == null){
				troubleReportVo.setStationName(commonPopupService.getStationName(troubleReportVo));
			}else{
				TroubleReportVO resultVo = commonPopupService.getTroubleReportInfo(troubleReportVo);
				
				model.addAttribute("resultVo", resultVo);
			}
			model.addAttribute("troubleReportVo", troubleReportVo);
			model.addAttribute("mode", troubleReportVo.getMode());
			model.addAttribute("deviceType", deviceType);
			
			
		} catch (Exception e) {
			throw new CfoodException("admin.common.popup.showTroubleReportPop",e.getMessage());
		}
		
		return targetUrl;
	}
	
	@RequestMapping(value="/exeTroubleAjax.do")
	@RequestName("exeTroubleAjax")
	public String exeTroubleAjax(@ModelAttribute @Valid TroubleReportVO troubleReportVo, ModelMap model, HttpServletRequest request){
		String bizName = "고장신고 등록 Ajax";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		try{
			if(troubleReportVo.getMode().equals("insert")){
				//만약 이미 신고가 들어가 있을경우 CHK
				boolean isFaultExist = commonPopupService.chkFaultExist(troubleReportVo); 
				if(isFaultExist) {
					model.addAttribute(RESULT_MESSAGE, "Insert");
					model.addAttribute(CHECK_RESULT, "-1");
					return JSONVIEW;
				}
				
				TroubleReportVO tmpVo = troubleReportVo;
				String[] tmpFaultCode = troubleReportVo.getFaultCode().split(",");
				commonPopupService.insertTrouble(troubleReportVo);
				commonPopupService.updateDeviceStatus(troubleReportVo);

				commonPopupService.insertTroubleType(troubleReportVo);
				
				commonPopupService.deleteTroubleDetail(troubleReportVo);
				for(int i = 0; i < tmpFaultCode.length; i++){
					tmpVo.setFaultCode(tmpFaultCode[i]);
					commonPopupService.insertTroubleDetail(tmpVo);
				}
				model.addAttribute(RESULT_MESSAGE, "Insert");
				model.addAttribute(CHECK_RESULT, 0);
				return JSONVIEW;
			}else if(troubleReportVo.getMode().equals("update")){
				TroubleReportVO tmpVo = troubleReportVo;
				String[] tmpFaultCode = troubleReportVo.getFaultCode().split(",");
				commonPopupService.updateTrouble(troubleReportVo);
				commonPopupService.deleteTroubleDetail(troubleReportVo);
				for(int i = 0; i < tmpFaultCode.length; i++){
					tmpVo.setFaultCode(tmpFaultCode[i]);
					commonPopupService.insertTroubleDetail(tmpVo);
				}
				model.addAttribute(RESULT_MESSAGE, "Update");
				model.addAttribute(CHECK_RESULT, 0);
				return JSONVIEW;
			}
			
		} catch (Exception e) {
			throw new CfoodException("admin.common.popup.exeTroubleAjax",e.getMessage());
		}
		return JSONVIEW;
	}
	
	@RequestMapping(value="/sendSmsMessage.do")
	@RequestName("sendSmsMessage")
	public String sendSmsMessage(@ModelAttribute MemberMgmtVO memberVo, ModelMap model, HttpServletRequest request){
		String bizName = "SMS 전송.";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		List<SmsMessageVO> smsMsgList = new ArrayList<SmsMessageVO>();
		SmsMessageVO smsMsgVo = null;
		boolean result = false;
		try {
			if(memberVo.getMprNoList().size() > 0) {
    			for(String telNo : memberVo.getMprNoList()) {
    				smsMsgVo = new SmsMessageVO();
    				smsMsgVo.setDestno(telNo);
    				smsMsgVo.setReqdttm(memberVo.getBookDate());
    				smsMsgVo.setMsg(memberVo.getSmsMsg());
    				smsMsgList.add(smsMsgVo);
    			}
    			SmsSender.sender(smsMsgList);
    			result = true;	
    		}
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.sms.send"),e);
		}
		model.addAttribute(CHECK_RESULT, result);
		
		return JSONVIEW;
	}
	
	@RequestMapping(value="/sendAllSmsMessage.do")
	@RequestName("sendAllSmsMessage")
	public String sendAllSmsMessage(@ModelAttribute MemberMgmtVO memberVo, ModelMap model, HttpServletRequest request){
		String bizName = "SMS 전송.";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		boolean result = false;
		try {
			int smsList = memberMgmtService.addSmsAllMBMpnNo(memberVo);
			if(smsList > 0){
				result = true;
			}
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.sms.send"),e);
		}
		model.addAttribute(CHECK_RESULT, result);
		model.addAttribute("memberVo", memberVo);
		
		return "/admin/common/popup/pop_sms_pro";
	}
	
	@RequestMapping(value="/showMileageImpose.do")
	@RequestName("showMileageImpose")
	public String showMileageImpose(@ModelAttribute MileageVO mileageVo, ModelMap model, HttpServletRequest request) {
		
		String bizName = "마일리지 추가 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		MileageVO info = null;
		/*if(mileageVo.getViewType().equals(MODE_UPDATE) || mileageVo.getViewType().equals(MODE_VIEW)) {
			info = commonPopupService.getMileageDetailInfo(mileageVo);
		}*/
		
		model.addAttribute("mileageVo", mileageVo);
		//model.addAttribute("penaltyInfo", info);
		return RETURN_URL.concat("pop_mil_pro");
	}
	
	@RequestMapping(value="/exeEditMileage.do")
	@RequestName("exeEditMileage")
	public String exeEditMileage(@ModelAttribute @Valid MileageVO mileageVo,  BindingResult bindingResult, ModelMap model, HttpServletRequest request ) throws Exception {
		String bizName = "마일리지 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		String resultMessage = "저장에 성공했습니다.";
		UserSessionVO user = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		if(user == null){
            throw new CfoodException(getMessage("error.invalidSession"));
        }
		int result = 0;
		try {
			if(bindingResult.hasErrors()) {
				for(ObjectError error : bindingResult.getAllErrors()) {
					resultMessage = error.getDefaultMessage();
				}
			} else {
				if(mileageVo.getViewType().equals(MODE_INSERT)) {
					mileageVo.setUserId(user.getUsrId());
					result = commonPopupService.addMileageImpose(mileageVo);
					/*if(result > 0){
						//블랙리슽에 해당 유무 체크
						boolean existBlack = commonPopupService.existBlackUsr(penaltyVo);
						if(!existBlack) {
							
							boolean isBlackList = commonPopupService.isBlackList(penaltyVo);
							if(isBlackList) {
								//블랙목록 등록.
								BlackListMgmtVO blVo = new BlackListMgmtVO();
								blVo.setUsrSeq(penaltyVo.getUsrSeq());
								blVo.setBlkListReasonCd("BLA_001");
								blVo.setAuth_di_val(memberMgmtService.getMemberUsrAuthVal(blVo));
								result = memberMgmtService.regBlackList(blVo) ? 1 : 0;
							}
						} 
					}*/
				} else {
					//result = commonPopupService.delRentPenaltyImpose(penaltyVo);
				}
			}
		} catch (Exception e) {
			throw new CfoodException("fail.common.msg",e.getMessage());
		}
		model.addAttribute(RESULT_MESSAGE, resultMessage);
		model.addAttribute(RESULT, result);
		
		return JSONVIEW;
	}
	
	@RequestName(value="groupStationList")
	@RequestMapping(value="/groupStationList.do")
	public String groupStationList(CommonStationVO statioGroupnVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		//statioGroupnVo.setLang(request.getLocale().getLanguage());
		statioGroupnVo.setLang("LAG_001");
		List<CommonStationVO> group = null;
		
		group = commonCodeService.getComStation(statioGroupnVo);
		
		model.put("groupList", group);		
		
		return IConstants.JSONVIEW;
	}
	
	// 시민의견수렴 담당자 팝업
	@RequestMapping(value="/adminSchPop.do")
	@RequestName("adminSchPop")
	public String adminSchPop(@RequestParam("qnaSeq")String qnaSeq, @ModelAttribute UserMgmtVO userMgmtVo, ModelMap model, HttpServletRequest req) {

		String bizName = "담당자찿기 팝업";
        HttpUtil.printServiceLogStart(bizName, log, req);	// 서비스로그 시작 출력
		String targetUrl = RETURN_URL.concat("pop_admin_sch");        
		
		model.addAttribute("qnaSeq", qnaSeq);
		model.addAttribute("userMgmtVo", userMgmtVo);
		return targetUrl;
	}
	
	
	// 장애관리 담당자 팝업
	@RequestMapping(value="/teamSchPop.do")
	@RequestName("teamSchPop")
	public String teamSchPop(@RequestParam("faultSeq")String faultSeq, @ModelAttribute TeamMgmtVO teamMgmtVO, ModelMap model, HttpServletRequest req) {

		String bizName = "장애관리 담당자찿기 팝업";
		HttpUtil.printServiceLogStart(bizName, log, req);	// 서비스로그 시작 출력
		String targetUrl = RETURN_URL.concat("pop_team_sch");
		
		CommonCodeVO cVo = new CommonCodeVO();
    	List<CommonCodeVO> codeList = null;
    	cVo.setComUpCd("DEC");
    	cVo.setLang(IConstants.LANG_KR);
    	
    	// 배송 팀 공통코드 조회
    	codeList = commonCodeService.getComCodeInfo(cVo);
    	
    	// 팀 공통코드 조회
    	List<CommonCodeVO> teamList = null;
    	cVo.setComUpCd("TEAM");
    	teamList = commonCodeService.getComCodeInfo(cVo);
    	
 	
    	model.addAttribute("type", IConstants.CRUD_C);
    	model.addAttribute("centerList", codeList);
    	model.addAttribute("teamList", teamList);
    	
		model.addAttribute("faultSeq", faultSeq);
		model.addAttribute("teamMgmtVO", teamMgmtVO);
		return targetUrl;
	}
	
	@RequestMapping(value="/findOutTeamInfo.do")
	@RequestName("findOutTeamInfo")
	public String findOutTeamInfo( @ModelAttribute @Valid TeamMgmtVO foVo, BindingResult bindingResult, ModelMap model, HttpServletRequest req) {

		String bizName = "팀 찾기";
        HttpUtil.printServiceLogStart(bizName, log, req);	// 서비스로그 시작 출력
		String messageResult = "";
		List<TeamMgmtVO> teamList = null;
		try {
			teamList = commonPopupService.getFindOutTeam(foVo);
		} catch (Exception e) {
		    throw new CfoodException("fail.common.msg",e.getMessage());
		}
		model.addAttribute(RESULT_MESSAGE, messageResult);
		model.addAttribute("teamList", teamList);
		return JSONVIEW;
	}
	
	@RequestMapping(value="/findStationAllInfo.do")
	@RequestName("findStationAllInfo")
	public String findStationAllInfo( @ModelAttribute StationStatusVO statusVo, BindingResult bindingResult, ModelMap model, HttpServletRequest req) {
		String bizName = "팀 찾기";
        HttpUtil.printServiceLogStart(bizName, log, req);	// 서비스로그 시작 출력
		String messageResult = "";
		List<StationStatusVO> stationList = null;
		try {
			stationList  = stationStatusService.getStationNameList(statusVo);	
		} catch (Exception e) {
		    throw new CfoodException("fail.common.msg",e.getMessage());
		}
		model.addAttribute(RESULT_MESSAGE, messageResult);
		model.addAttribute("stationList", stationList);
		return JSONVIEW;
	}
	
	@RequestMapping(value="/entrcReutnListPop.do")
	@RequestName("entrcReutnListPop")
	public String entrcReutnListPop(@ModelAttribute BikeRentalVO rentVo, BindingResult bResult, ModelMap model,HttpServletRequest request) throws SQLException {
		String bizName = "강제반납목록화면 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		
		BikeRentalVO resultVo = null;
		
		//rentStatusService.getCompulsionInfo
		resultVo = rentStatusService.getExeImpulseCntInfo(rentVo);
	
		
		model.addAttribute("resultVo", resultVo);
		
		return  RETURN_URL.concat("pop_re_list");
	}
	
	@RequestMapping(value="/entrcReutnListPop.do")
	@RequestName("entrcReutnListPop")
	public String entrcReutnListPop(@ModelAttribute BikeRentalVO rentVo, BindingResult bResult, ModelMap model,HttpServletRequest request) throws SQLException {
		String bizName = "강제반납목록화면 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		
		BikeRentalVO resultVo = null;
		
		//rentStatusService.getCompulsionInfo
		resultVo = rentStatusService.getExeImpulseCntInfo(rentVo);
	
		
		model.addAttribute("resultVo", resultVo);
		
		return  RETURN_URL.concat("pop_re_list");
	}
	@RequestMapping(value="/updLocationMapPop.do")
	@RequestName("updLocationMapPop")
	public String updLocationMapPop(@ModelAttribute @Valid LocationVo locationVo, ModelMap model, HttpServletRequest request){
		String bizName = "위치 지도 찾기 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		model.addAttribute("latitude", locationVo.getLatitude());
		model.addAttribute("longitude", locationVo.getLongitude());
		model.addAttribute("naverMapApiKey",super.propertiesService.getString("naverMapApiKey"));
		
		return RETURN_URL.concat("pop_map_upd");
	}
	

	@RequestMapping(value="/entrcReutnViewPop.do")
	@RequestName("entrcReutnViewPop")
	public String entrcReutnViewPop(@ModelAttribute @Valid BikeRentalVO rentVo, ModelMap model, HttpServletRequest request){
		String bizName = "강제반납 지도 사진 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		BikeRentalVO resultVo = null;
		
		// getEnfrcViewInfo
		
		// 강제반납 seq로 정보 긁어오기
		resultVo = rentStatusService.getEnfrcViewInfo(rentVo);
		
		// 사진 목록 가져오기
		List<BikeRentalVO> enfrcFileList = rentStatusService.listEnfrcFile(rentVo);
		
		model.addAttribute("info", resultVo);
		model.addAttribute("latitude", resultVo.getLatitude());
		model.addAttribute("longitude", resultVo.getLongitude());
		model.addAttribute("naverMapApiKey",super.propertiesService.getString("naverMapApiKey"));
		
		model.addAttribute("enfrcFileList", enfrcFileList);
		
		return RETURN_URL.concat("pop_re_view");
	}
	
	@RequestMapping(value="/searchPlaces.do")
	@RequestName("searchPlace")
	public String searchPlace(@ModelAttribute @Valid BikeRentalVO rentVo, ModelMap model, HttpServletRequest request){
		
		String clientId = "4791tlnwi5";//애플리케이션 클라이언트 아이디값";
        String clientSecret = "1uv78Iuscuefyaj3Oq4H5pzMcQAXo559PSMiiqXC";//애플리케이션 클라이언트 시크릿값";
        try {
            String text = URLEncoder.encode(rentVo.getSearchWord(), "UTF-8");
            //String apiURL = "https://naveropenapi.apigw.ntruss.com/nmt/v1/translation";
            String apiURL = "https://naveropenapi.apigw.ntruss.com/map-place/v1/search?query="+text+"&coordinate=126.9773356,37.5675451";
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("Content-Type", "application/json");
            con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", clientId);
            con.setRequestProperty("X-NCP-APIGW-API-KEY", clientSecret);
            // post request
            //String postParams = "coordinate=126.9773356,37.5675451&query=" + text;
            //con.setDoOutput(true);
            con.connect();
           //InputStreamReader in = new InputStreamReader(con.getInputStream());
           // DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            //wr.writeBytes(postParams);
            //wr.flush();
            //wr.close();
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            System.out.println(response.toString());
            //model.addAttribute("data", response.toString());
            model.addAttribute("response", response);
            model.addAttribute("response2", response.toString());
            //String response_body = json.loads(response);
            
            
        } catch (Exception e) {
            System.out.println(e);
        }

		
		
		//model.addAttribute(CHECK_RESULT, result);
		return JSONVIEW;
	}
	
	@RequestMapping(value="/geocode.do")
	@RequestName("geocode")
	public String geocode(@ModelAttribute @Valid BikeRentalVO rentVo, ModelMap model, HttpServletRequest request){
		
		String clientId = "4791tlnwi5";//애플리케이션 클라이언트 아이디값";
        String clientSecret = "1uv78Iuscuefyaj3Oq4H5pzMcQAXo559PSMiiqXC";//애플리케이션 클라이언트 시크릿값";
        try {
            String text = URLEncoder.encode(rentVo.getSearchWord(), "UTF-8");
            //String apiURL = "https://naveropenapi.apigw.ntruss.com/nmt/v1/translation";
            String apiURL = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query="+text+"&coordinate=126.9773356,37.5675451";
            
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("Content-Type", "application/json");
            con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", clientId);
            con.setRequestProperty("X-NCP-APIGW-API-KEY", clientSecret);
            // post request
            //String postParams = "coordinate=126.9773356,37.5675451&query=" + text;
            //con.setDoOutput(true);
            con.connect();
           //InputStreamReader in = new InputStreamReader(con.getInputStream());
           // DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            //wr.writeBytes(postParams);
            //wr.flush();
            //wr.close();
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            System.out.println(response.toString());
            //model.addAttribute("data", response.toString());
            model.addAttribute("response", response);
            model.addAttribute("response2", response.toString());
            //String response_body = json.loads(response);
            
            
        } catch (Exception e) {
            System.out.println(e);
        }

		
		
		//model.addAttribute(CHECK_RESULT, result);
		return JSONVIEW;
	}
	
	@RequestMapping(value="/findTeamName.do")
	@RequestName("findTeamName")
	public String findTeamName(@ModelAttribute @Valid BikeRentalVO rentVo, ModelMap model, HttpServletRequest request){
		
		String bizName = "배정팀 조회";
        try {
    		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
    		System.out.println("findTeamName  ");
    		// 배정팀 조회
    		String teamName = rentStatusService.getTeamName(rentVo);
    		System.out.println("##getTeamName = "+teamName);
    		
    		model.addAttribute("teamName", teamName);
    		
            
        } catch (Exception e) {
            System.out.println(e);
        }

		return JSONVIEW;
	}
	
	
	@RequestMapping(value="/showBikeRobbedPop.do")
	@RequestName("showBikeRobbedPop")
    public String showBikeRobbedPop(@ModelAttribute @Valid BikeRentalVO rentalVo, BindingResult bindingResult, ModelMap model, HttpServletRequest request) throws Exception {
		
		String bizName = "도난추정 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		UserSessionVO user = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		StationStatusVO statusVo = new StationStatusVO();
		
		
		List<StationStatusVO> stationList = null;
		if(user == null){
            throw new CfoodException(getMessage("error.invalidSession"));
        }
		String resultMessage = "";
		//BikeRentalVO compulsionInfo = null;
		CommonCodeVO cVo = new CommonCodeVO();
    	List<CommonCodeVO> codeList = null;
    	cVo.setComUpCd("DEC");
    	cVo.setLang(IConstants.LANG_KR);
		
		try {
			if(bindingResult.hasErrors()) {
				for(ObjectError error : bindingResult.getAllErrors()) {
					resultMessage = error.getDefaultMessage();
				}
			}
			
			

        	// 배송 센터 공통코드 조회
        	codeList = commonCodeService.getComCodeInfo(cVo);
        	
        
			stationList  = stationStatusService.getStationNameList(statusVo);	
			
		} catch (Exception e) {
			throw new CfoodException("fail.common.msg",e.getMessage());
		}
		model.addAttribute(RESULT_MESSAGE, resultMessage);
		model.addAttribute("codeList", codeList);
		model.addAttribute("adminId", user.getUsrId());
		model.addAttribute("info"   , rentalVo);
		model.addAttribute("stationList"   , stationList);
		
		return RETURN_URL.concat("pop_robbed_pro");
	}
	
	@RequestMapping(value="/exeBikeRobbed.do")
	@RequestName("exeBikeRobbed")
	public String exeBikeRobbed(@ModelAttribute @Valid BikeRentalVO rentalVo, BindingResult bindingResult, ModelMap model, HttpServletRequest request) throws Exception {
		String bizName = "도난추정 등록";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		int result = 0;
		System.out.println("rentalVo.getRentBikeId()>> "+rentalVo.getRentBikeId());
		System.out.println("rentalVo.getRegId()>> "+rentalVo.getRegId());
		if(rentalVo.getRegId() == null){
			UserSessionVO user = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
			System.out.println("user.getUsrId()>>> "+user.getUsrId());
			rentalVo.setAdminId(user.getUsrId());
		}
		
        String resultMessage = "도난추정 등록에 성공했습니다.";
        
        
		try {
			/*
			System.out.println("####adminId "+rentalVo.getAdminId());
			System.out.println("####getRentBikeId "+rentalVo.getRentBikeId());
			System.out.println("####getRentBikeNo "+rentalVo.getRentBikeNo());
			System.out.println("####getReportDate "+rentalVo.getReportDate());
			System.out.println("####getManageCenter "+rentalVo.getManageCenter());
			System.out.println("####getReportCd "+rentalVo.getReportCd());
			System.out.println("####getReportNm "+rentalVo.getReportNm());
			System.out.println("####getReportPno "+rentalVo.getReportPno());
			System.out.println("####getReportDetail "+rentalVo.getReportDetail());
			*/
			
			result = rentStatusService.addBikeRobbedHistory(rentalVo);
			log.debug("도난추정 결과 :::::"+result);
			
		} catch (Exception e) {
			resultMessage = "도난추정 등록에 실패했습니다.:" + e.getMessage() ;
			throw new CfoodException("9999", e);
			
		} finally{
			if(result < 0){
				resultMessage = "도난추정 등록에 실패했습니다.";
			}
		}
		model.addAttribute(CHECK_RESULT, result);
		model.addAttribute(RESULT_MESSAGE, resultMessage);

		return JSONVIEW;
	}
	
	
	@RequestMapping(value="/showBikeRetrievalPop.do")
	@RequestName("showBikeRetrievalPop")
    public String showBikeRetrievalPop(@ModelAttribute @Valid BikeRentalVO rentalVo, BindingResult bindingResult, ModelMap model, HttpServletRequest request) throws Exception {
		String bizName = "회수 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		UserSessionVO user = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		StationStatusVO statusVo = new StationStatusVO();
		
		
		List<StationStatusVO> stationList = null;
		if(user == null){
            throw new CfoodException(getMessage("error.invalidSession"));
        }
		String resultMessage = "";
		//BikeRentalVO compulsionInfo = null;
		CommonCodeVO cVo = new CommonCodeVO();
    	List<CommonCodeVO> codeList = null;
    	cVo.setComUpCd("DEC");
    	cVo.setLang(IConstants.LANG_KR);
		
		try {
			if(bindingResult.hasErrors()) {
				for(ObjectError error : bindingResult.getAllErrors()) {
					resultMessage = error.getDefaultMessage();
				}
			}
			
			

        	// 배송 센터 공통코드 조회
        	codeList = commonCodeService.getComCodeInfo(cVo);
        	
        
			stationList  = stationStatusService.getStationNameList(statusVo);	
			
		} catch (Exception e) {
			throw new CfoodException("fail.common.msg",e.getMessage());
		}
		model.addAttribute(RESULT_MESSAGE, resultMessage);
		model.addAttribute("codeList", codeList);
		model.addAttribute("adminId", user.getUsrId());
		model.addAttribute("info"   , rentalVo);
		model.addAttribute("stationList"   , stationList);
		
		return RETURN_URL.concat("pop_retrieval_pro");
	}
	
	@RequestMapping(value="/exeBikeRtrvl.do")
	@RequestName("exeBikeRtrvl")
	public String exeBikeRtrvl(@ModelAttribute @Valid BikeRentalVO rentalVo, BindingResult bindingResult, ModelMap model, HttpServletRequest request) {
		String bizName = "회수 등록";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        int result = 0;
        String resultMessage = "회수 등록에 성공했습니다.";
        
        
		try {
			/*
			System.out.println("####adminId "+rentalVo.getAdminId());
			System.out.println("####getRentBikeId "+rentalVo.getRentBikeId());
			System.out.println("####getRentBikeNo "+rentalVo.getRentBikeNo());
			System.out.println("####getRtrvlDate "+rentalVo.getRtrvlDate());
			System.out.println("####getRtrvlPlace "+rentalVo.getRtrvlPlace());
			System.out.println("####getRtrvlCd "+rentalVo.getRtrvlCd());
			System.out.println("####getRtrvlNm "+rentalVo.getRtrvlNm());
			System.out.println("####getRtrvlDetail "+rentalVo.getRtrvlDetail());
			*/
			
			result = rentStatusService.addBikeRtrvlHistory(rentalVo);
			log.debug("회수 결과 :::::"+result);
				
			
		} catch (Exception e) {
			resultMessage = "회수 등록에 실패했습니다.:" + e.getMessage() ;
			throw new CfoodException("9999", e);
			
		} finally{
			if(result < 0){
				resultMessage = "회수 등록에 실패했습니다.";
			}
		}
		model.addAttribute(CHECK_RESULT, result);
		model.addAttribute(RESULT_MESSAGE, resultMessage);

		return JSONVIEW;
	}
	
	@RequestMapping(value="/showBikeMap.do")
	@RequestName("showBikeMap")
    public String showBikeMap(@ModelAttribute BikeRentalVO rentalVo, ModelMap model,HttpServletRequest request) throws Exception {
    	String bizName = "자전거 위치 찾기 popup";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
        if(userSessionVO == null){
        	throw new CfoodException(getMessage("error.invalidSession"));
        }
        rentalVo.setAdminId(userSessionVO.getUsrId());
    	model.addAttribute("bikeInfo", rentalVo);
    	
    	BikeRentalVO resultVo = new BikeRentalVO();
		resultVo = rentStatusService.getBikeMapInfo(rentalVo);
		
		model.addAttribute("info", resultVo);
		//model.addAttribute("latitude", resultVo.getLatitude());
		//model.addAttribute("longitude", resultVo.getLongitude());
		//model.addAttribute("naverMapApiKey",super.propertiesService.getString("naverMapApiKey"));
    			
    	return  RETURN_URL.concat("pop_bike_view");
    }
	
	// 바로클포 운영자찾기 팝업
	@RequestMapping(value="/showRepBikMAllAdminFindPop.do")
	@RequestName("showRepBikMAllAdminFindPop")
	public String showRepBikMAllAdminFindPop(@ModelAttribute @Valid UserMgmtVO userMgmtVo, ModelMap model, HttpServletRequest request){
		String bizName = "바로클포 운영자찾기 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		model.addAttribute("userMgmtVo", userMgmtVo);
		return RETURN_URL.concat("pop_repBikMallAdmin_sch");
	}
	
	// 시민의견수렴 답변기한 팝업
	@RequestMapping(value="/deadlineSchPop.do")
	@RequestName("deadlineSchPop")
	public String deadlineSchPop(@RequestParam("qnaSeq")String qnaSeq, ModelMap model, HttpServletRequest req) {

		String bizName = "답변기한 수정팝업";
		HttpUtil.printServiceLogStart(bizName, log, req);	// 서비스로그 시작 출력
		String targetUrl = RETURN_URL.concat("pop_deadline_sch");        
				
		model.addAttribute("qnaSeq", qnaSeq);
		return targetUrl;
	}
	
	// 관리자 SMS 전송오류 건 팝업
	@RequestMapping(value="/getReqAdminDtlPop.do")
	@RequestName("getReqAdminDtlPop")
	public String getReqAdminDtlPop(ModelMap model, HttpServletRequest req) {
		
		String bizName = "관리자 SMS 전송오류 건";
		HttpUtil.printServiceLogStart(bizName, log, req);	// 서비스로그 시작 출력
		String targetUrl = RETURN_URL.concat("pop_sys_sms_admin_detail");        
		
		return targetUrl;
	}
	
	// 배송원 찾기 팝업
	@RequestMapping(value="/showMassMoveAdminFindPop.do")
	@RequestName("showMassMoveAdminFindPop")
	public String showMassMoveAdminFindPop(@ModelAttribute @Valid UserMgmtVO userMgmtVo, ModelMap model, HttpServletRequest request){
		String bizName = "배송원 찾기 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		model.addAttribute("userMgmtVo", userMgmtVo);
		return RETURN_URL.concat("pop_massMoveAdmin_sch");
	}
	
	@SuppressWarnings("rawtypes")
	public HashMap mainPayChargeAPI (Map<String, String> parmaMap) {
		
		HashMap<String, String> resultMap = new HashMap<String, String>();
		
		try {		
			
			//String API_BASE = "https://test-relay.mainpay.co.kr";				// TEST API URL
			//String mbrNo = "100011"; // 테스트 가맹점 번호
			//String apiKey = "U1FVQVJFLTEwMDAxMTIwMTgwNDA2MDkyNTMyMTA1MjM0"; // 테스트 apiKey
			
			String API_BASE = "https://relay.mainpay.co.kr";                               // REAL API URL
			String mbrNo = "114549";                                                       // REAL 가맹점번호
			String apiKey = "LovY3SkcSKoB9m3aihyaqw404jgrfsXWedHoUlPOOWlJ";                // REAL apiKey
			
			String apiUrl = API_BASE + "/v1/api/payments/payment/card-auto/trans";			// 신용카드 정기결제 결제 승인 요청 API
			
			Map<String, String> parameters = new HashMap<String, String>();
			
			java.text.SimpleDateFormat format = new java.text.SimpleDateFormat ( "yyyyMMddHHmmss");
			java.text.SimpleDateFormat format2 = new java.text.SimpleDateFormat ( "yyMMddHHmmss");
			Date date = new Date();
			String TODAY = format.format(date);
			
			parameters.put("mbrNo", mbrNo);							// SPC Networks에서 부여한 가맹점번호 (상점 ID)
			parameters.put("paymethod", "CARD");					// 지불수단 (고정값, CARD)
			parameters.put("billkey", parmaMap.get("billingKey"));							// 신용카드 빌키 (approvlUrl에서 저장한 값)
			//parameters.put("billkey", "0O90003090104015S202");	// 정기결제 인증 키
			String mbRefNo = MakeID.orderNo("BRC_"+TODAY, 20);
			parameters.put("mbrRefNo", mbRefNo);	// 가맹점에서 나름대로 정한 중복되지 않는 주문번호
			parameters.put("amount", parmaMap.get("totAmt"));						// 총결제금액
			parameters.put("goodsName", "추가과금");					// 생년월일 6자리 (YYMMDD) 또는 사업자번호 10자리
			parameters.put("timestamp", TODAY);	// 가맹점 시스템 시각 (yyyyMMddHHmmssSSS)
			String key = mbrNo+"|"+mbRefNo+"|"+parmaMap.get("totAmt")+"|"+apiKey+"|"+TODAY;
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
            
            System.out.printf("[" +TODAY + "][결제요청] " +"[callUrl :" + apiUrl +" ] " + parameters.toString() , "Y");
            System.out.printf("[" +TODAY + "][결제요청 결과] " + returnStr , "Y");
			
			Map responseMap = ParseUtils.fromJson(returnStr, Map.class);
			String resultCode = (String) responseMap.get("resultCode");
			String resultMessage = (String) responseMap.get("resultMessage");
	
			if( ! "200".equals(resultCode)) {	// API 호출 실패		
				System.out.println(returnStr);
				resultMap.put("resultCode", resultCode);
				resultMap.put("resultMessage", resultMessage);
			} else {
				 Map<String,String> data = (Map<String,String>)responseMap.get("data");
				resultMap.put("resultCode", resultCode);
				resultMap.put("resultMessage", resultMessage);				
				resultMap.put("mbrRefNo", (String)data.get("mbrRefNo"));
				resultMap.put("refNo", (String)data.get("refNo"));
				resultMap.put("tranDate", (String)data.get("tranDate"));
				resultMap.put("payType", (String)data.get("payType"));
				resultMap.put("totAmt", parmaMap.get("totAmt"));
			}
			
			//responseJson = HttpSendTemplate.post(apiUrl, parameters, apiKey);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return resultMap;
	}
	
}
