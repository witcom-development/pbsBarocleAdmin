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


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;
import com.dkitec.barocle.admin.customer.notice.vo.NoticeVO;
import com.dkitec.barocle.admin.maintenance.inspect.bike.controller.InspectBikeController;
import com.dkitec.barocle.admin.maintenance.inspect.bike.service.InspectBikeService;
import com.dkitec.barocle.admin.maintenance.inspect.bike.vo.InspectBikeVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class obstacleController extends BaseController  {

	protected static Logger log = LoggerFactory.getLogger(InspectBikeController.class);
	
	@Resource(name="inspectBikeService") private InspectBikeService inspectBikeService;
	
	@RequestMapping(value = "/obstacleCnt.do")
	@RequestName(value="obstacleCnt")
	public String obstacleCnt(@ModelAttribute @Valid InspectBikeVO inspectBikeVo, HttpServletRequest request, ModelMap model) throws Exception {
        
		try {
			int obsCnt = inspectBikeService.getObstacleCnt();
			model.addAttribute("obsCnt", obsCnt);
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
		} catch (Exception e) {
			throw new CfoodException("admin.common.controller.obstacleCnt");
		}
		return JSONVIEW;
	}
	
	@RequestMapping(value="/obstaclePopup.do")
	public String popupNotice(@ModelAttribute("noticeVO") InspectBikeVO inspectBikeVo, HttpServletRequest request, Model model)throws Exception  {

		String bizName = "자전거 장애체크 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			inspectBikeVo.setPagingYn("Y");

			int totCnt = inspectBikeService.getObstacleCnt();
			PaginationInfo paginationInfo = getPagingInfo(inspectBikeVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(inspectBikeVo.getCurrentPageNo(), totCnt);
			
			inspectBikeVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			inspectBikeVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<InspectBikeVO> resultList = inspectBikeService.getObstacleList(inspectBikeVo);
					
			model.addAttribute("searchCondition", inspectBikeVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("InspectBikeList", resultList);

		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.che_bike_list");
		}
		return "/admin/common/popup/pop_obstacle";
	}
	
	@RequestMapping(value = "/obstacleTimeCnt.do")
	@RequestName(value="obstacleTimeCnt")
	public String obstacleTimeCnt(@ModelAttribute @Valid CategoryVO categoryVO, HttpServletRequest request, ModelMap model) throws Exception {
        
		try {
			categoryVO = inspectBikeService.getObstacleTime();
			model.addAttribute("addVal", categoryVO.getAddVal1());
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
		} catch (Exception e) {
			throw new CfoodException("admin.common.controller.obstacleCnt");
		}
		return JSONVIEW;
	}
	
	
	
}

