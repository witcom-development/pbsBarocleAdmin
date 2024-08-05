/*
 * @Package Name : com.dkitec.barocle.admin.status.relocationBikeStatus.controller
 * @파일명          : RelocationBikeStatusController.java
 * @작성일          : 2015. 5. 21.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 21.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.status.relocationBikeStatus.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.manage.relocationcar.vo.RelocationCarVO;
import com.dkitec.barocle.admin.status.relocationBikeStatus.service.RelocationBikeStatusService;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;


/**
 * @파일명          : RelocationBikeStatusController.java
 * @작성일          : 2015. 5. 21.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 21.   |   ymshin   |  최초작성
 */
@Controller
@RequestCategory(value="RelocationBikeStatusController")
public class RelocationBikeStatusController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(RelocationBikeStatusController.class);
	
	@Resource(name="relocationBikeStatusService") private RelocationBikeStatusService relocationBikeStatusService;
	
	@RequestMapping(value="/movetRelocationBikeStatusList.do")
	@RequestName("moveRelocationBikeStatusList")
	public String moveRelocationBikeStatusList(@ModelAttribute RelocationCarVO relocationVo, ModelMap model, HttpServletRequest request) {
		String bizName = "재배치 차량 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        try {
        	
        } catch(CfoodException e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        model.addAttribute("naverMapApiKey",super.propertiesService.getString("naverMapApiKey"));
		return "/admin/status/relocationBikeStatus/pre_loc_state";
	}
	@RequestMapping(value="/getRelocationBikeStatusList.do")
	@RequestName("getRelocationBikeStatusList")
	public String getRelocationBikeStatusList(@ModelAttribute RelocationCarVO relocationVo, ModelMap model, HttpServletRequest request) {
		String bizName = "재배치 차량 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		try {
			List<RelocationCarVO> relocationList =  relocationBikeStatusService.getRelocationBikeStatusList();
			
			model.addAttribute("relocationList", relocationList);
			
		} catch(CfoodException e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		return JSONVIEW;
	}
	
	
	
}
