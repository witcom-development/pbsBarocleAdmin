package com.dkitec.barocle.admin.service.push.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.service.push.service.PushUserInfoService;
import com.dkitec.barocle.admin.service.push.vo.PushUserInfoVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.webutil.HttpUtil;

@Controller
@RequestCategory(value="PushUserInfoController")
@RequestMapping(value="/admin/service/push")
public class PushUserInfoController extends BaseController{
	
	@Resource(name = "pushUserInfoService")
    protected PushUserInfoService pushUserInfoService;
	
	protected static Logger log = LoggerFactory.getLogger(PushUserInfoController.class);
	
	
	@RequestName(value="pushUserInfo")
	@RequestMapping(value="/pushUserInfo.do")
	public String pushUserInfoAjax(@ModelAttribute PushUserInfoVO pushUserInfoVO, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		String bizName = "push 정보조회";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
		try {
			model.addAttribute("pushUser", pushUserInfoService.getUserInfo(pushUserInfoVO));
			model.put("resultMsg", "성공");
			return IConstants.JSONVIEW;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return IConstants.JSONVIEW;
	}
	
	@RequestName(value="pushSuccessList")
	@RequestMapping(value="/pushSuccessList.do")
	public String getPushSuccessListAjax(@ModelAttribute PushUserInfoVO pushUserInfoVO, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		String bizName = "push 정보조회";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
		try {
			model.addAttribute("pushSuccessList", pushUserInfoService.getPushSuccessList(pushUserInfoVO));
			model.put("resultMsg", "성공");
			return IConstants.JSONVIEW;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return IConstants.JSONVIEW;
	}
	
	@RequestName(value="getPushFailList")
	@RequestMapping(value="/getPushFailList.do")
	public String getPushFailListAjax(@ModelAttribute PushUserInfoVO pushUserInfoVO, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		String bizName = "push 정보조회";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		try {
			model.addAttribute("pushSuccessList", pushUserInfoService.getPushFailList(pushUserInfoVO));
			model.put("resultMsg", "성공");
			return IConstants.JSONVIEW;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return IConstants.JSONVIEW;
	}
	
	
}

