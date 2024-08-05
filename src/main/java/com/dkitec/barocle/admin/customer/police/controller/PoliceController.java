package com.dkitec.barocle.admin.customer.police.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.customer.donor.vo.DonorVO;
import com.dkitec.barocle.admin.customer.donor.vo.DonorVO.DonorDeleteVal;
import com.dkitec.barocle.admin.customer.donor.vo.DonorVO.DonorEditVal;
import com.dkitec.barocle.admin.customer.donor.vo.DonorVO.DonorListVal;
import com.dkitec.barocle.admin.customer.donor.vo.DonorVO.DonorPersistVal;
import com.dkitec.barocle.admin.customer.police.service.PoliceService;
import com.dkitec.barocle.admin.customer.police.vo.PoliceVO;
import com.dkitec.barocle.admin.common.vo.TroubleReportVO;
import com.dkitec.barocle.admin.customer.donor.service.DonorService;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.maintenance.repair.bike.controller.RepairBikeController;
import com.dkitec.barocle.admin.maintenance.repair.bike.service.RepairBikeService;
import com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO;
import com.dkitec.barocle.admin.status.rentStatus.service.RentStatusService;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;
import com.dkitec.barocle.util.webutil.WebUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="PoliceController")
@RequestMapping(value="/admin/customer/police")
public class PoliceController extends BaseController {
	

	
	
	@Resource(name = "policeService") private PoliceService policeService;
	
	protected static Logger log = LoggerFactory.getLogger(PoliceController.class);
	
	
	//자료 요청 목록 보기
	@RequestName(value="policeList")
	@RequestMapping(value="/policeList.do")
	public String getPoliceList( PoliceVO policeVO,  HttpServletRequest request, Model model) {
		 
		boolean bResult = false;

		String resultPage = "/admin/customer/police/police_list";
		
		try{
			if(MODE_EXCEL.equals(policeVO.getViewFlg())){
				policeVO.setPagingYn("N");
			}else{
				policeVO.setPagingYn("Y");
			}
			
			// 날짜가 미존재시에는 현재일자로 세팅
			Calendar cal = Calendar.getInstance();
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			if(policeVO.getSearchStartDate() == null || "".equals( policeVO.getSearchStartDate() ) ){
				policeVO.setSearchStartDate(nowDay);
			}
			if(policeVO.getSearchEndDate() == null  || "".equals( policeVO.getSearchEndDate() )) {
				policeVO.setSearchEndDate(nowDay);
			}						
			// 총 레코드 개수를 가져온다.
			int cnt = policeService.listPoliceCount(policeVO);
			policeVO.setTotalRecordCount(cnt);
			// 페이징처리
			PaginationInfo paginationInfo			= getPagingInfo		 (policeVO.getCurrentPageNo(), cnt);
			PaginationInfo paginationMobileInfo 	= getPagingMobileInfo(policeVO.getCurrentPageNo(), cnt);
			policeVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			policeVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			// 현재 화면의 정보를 지정한다.
			model.addAttribute("policeView", policeVO);
			// 현재 화면의 레코드 목록을 지정한다. 검색 조건으로 select해 온 데이터들의 List...
			model.addAttribute("policeList",policeService.listPolice(policeVO));
			// 현재 화면에 표시되는 페이징 정보를 지정한다.
			model.addAttribute("paginationInfo",paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			bResult = true;			// 정상
		} catch (Exception e) {
			bResult = false;		// 정상
			throw new CfoodException("fail.common.msg" , e );
		}
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	
	
	// 자료 요청 작성 
	@RequestName(value="policeListWrite")
	@RequestMapping(value="/policeListWrite.do")
	public String policeListWrite( PoliceVO policeVO, BindingResult result, HttpServletRequest request, Model model) throws Exception { 			
		
		/* validator check */
		if(result.hasErrors()){
			model.addAttribute("policeView", policeVO);
			model.addAttribute("resultError", this.setResultMessage(result));
			return "/admin/customer/police/police_list_write";
		}
		
		boolean bResult = false;
		String resultPage = "/admin/customer/police/police_list_write";
		try{
			// 현재 화면의 정보를 지정한다.
			model.addAttribute("policeView", policeVO);
			// 현재 화면의 레코드 목록을 지정한다.			
			
			PoliceVO vo = new PoliceVO();
			
			// 등록버튼 누를 때는, PK를 이용하여, 등록된 내역 조회
			if(CRUD_R.equals(policeVO.getViewFlg())){
				List<PoliceVO> list = policeService.listPolice(policeVO);	
				if( list != null && list.size() > 0)  vo = list.get(0);
			}
			
			model.addAttribute("searchVo", policeVO);
			model.addAttribute("vo"		 , vo);
			// 현재 화면의 검색 파라미터 값을 지정한다.
			bResult = true;		// 정상
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return bResult ? resultPage : ERROR_PAGE;
	}
	

	// 요청 내용을 바탕으로 엑셀 출력
	@RequestName(value="policeListWriteExcel")
	@RequestMapping(value="/policeListWriteExcel.do")
	public String policeListWriteExcel( PoliceVO policeVO, BindingResult result, HttpServletRequest request, Model model) throws Exception { 			
		
		boolean bResult = false;
		String resultPage = "/admin/customer/police/police_list_write_excel";
		try{
			if(MODE_EXCEL.equals(policeVO.getViewFlg())){
				policeVO.setPagingYn("N");
			}else{
				policeVO.setPagingYn("Y");
			}
										

			model.addAttribute("from_Date", policeVO.getFromDate());
			model.addAttribute("to_Date",policeVO.getToDate());
			model.addAttribute("from_Hour",policeVO.getFromHour());
			model.addAttribute("to_Hour",policeVO.getToHour());
			model.addAttribute("bike_No",policeVO.getBikeNo());
			model.addAttribute("station_Id",policeVO.getStationId());
			
			
			//자전거 번호 유무로 엑셀 파일 선택하기	
			if(policeVO.getBikeNo() == null || policeVO.getBikeNo() == "" ) {			
				// 현재 화면의 레코드 목록을 지정한다. 대여 대여소 조건으로 select해 온 데이터들의 List... 
				model.addAttribute("policeExcelList",policeService.listPoliceExcel(policeVO));			
				
				// 현재 화면의 레코드 목록을 지정한다. 반납 대여소 조건으로  select해 온 데이터들의 List... 
				model.addAttribute("policeExcelList2",policeService.listPoliceExcel2(policeVO));
				
				policeService.updateIssueDttm(policeVO);

			}else {
				// 현재 화면의 레코드 목록을 지정한다. 자전거번호 조건으로 select해 온 데이터들의 List... 
				model.addAttribute("policeExcelList3",policeService.listPoliceExcel3(policeVO));
				
				policeService.updateIssueDttm(policeVO);
				
			}
			bResult = true;			// 정상
		} catch (Exception e) {
			bResult = false;		// 정상
			throw new CfoodException("fail.common.msg" , e );
		}
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	
	// DB에 새 요청사항 입력
	@RequestName(value="policeInsert")
	@RequestMapping(value="/policeInsert.do")
	public String policeInsert( PoliceVO policeVO, BindingResult result, HttpServletRequest request, Model model) {
		
		
		String bizName = "수사협조 내역 등록 Ajax";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		try{
			
			// 등록자 정보
			userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
			policeVO.setRegID(userSessionVO.getUsrId());
			
			
			policeService.insertPolice(policeVO);
			model.addAttribute(RESULT_MESSAGE, "Success");
			
			model.addAttribute( "newPolReqSeq" ,  policeVO.getPolReqSeq() );
			
		} catch (Exception e) {
			throw new CfoodException("admin.common.popup.exeTroubleAjax",e.getMessage());
		}
		return JSONVIEW;
	}	
	
	
	// DB에서 해당 자료요청 삭제
	@RequestName(value="deletePolice")
	@RequestMapping(value="/deletePolice.do")
	public String deletePolice(PoliceVO policeVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* validator check */
		if(result.hasErrors()){
			model.addAttribute("resultError", "권한이 없습니다.");
			throw new CfoodException("admin.customer.police.deletePolice.bindingexception");
		}
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/customer/police/policeList.do";
		
		try{
			/* get set session */
			try{
				policeVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e){ throw new CfoodException("admin.customer.police.deletePolice.NullSessionException",e); }
			
			if(policeService.deletePolice(policeVO)>0){ bResult = true; }
			
		} catch(Exception e){
			throw new CfoodException("admin.customer.police.deletePolice",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	
	
	// DB에 요청사항 수정
	@RequestName(value="updatePolice")
	@RequestMapping(value="/updatePolice.do")
	public String updatePolice(PoliceVO policeVO, BindingResult result, HttpServletRequest request, Model model) {
		
		String bizName = "수사협조 내역 수정 Ajax";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		try{
			// 수정자 정보
			userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
			policeVO.setModID(userSessionVO.getUsrId());
			
			
			policeService.updatePolice(policeVO);
			model.addAttribute(RESULT_MESSAGE, "Success");
			
			model.addAttribute( "newPolReqSeq" ,  policeVO.getPolReqSeq() );
			
		} catch (Exception e) {
			throw new CfoodException("admin.common.popup.exeTroubleAjax",e.getMessage());
		}
		
		return JSONVIEW;
		
	}	
	
}
