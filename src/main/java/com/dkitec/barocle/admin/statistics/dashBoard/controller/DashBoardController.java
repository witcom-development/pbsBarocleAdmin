package com.dkitec.barocle.admin.statistics.dashBoard.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.statistics.dashBoard.service.DashBoardService;
import com.dkitec.barocle.admin.statistics.dashBoard.vo.DashBoardVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

@Controller
@RequestCategory(value="DashBoardController")
public class DashBoardController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(DashBoardController	.class);

	@Resource(name="dashBoardService") private DashBoardService dashBoardService;
	
	private static final String RETURN_URL = "/admin/statistics/";

	@RequestMapping(value="/use/dashBoard.do")
	@RequestName(value="dashBoard")
	public String dashBoardController(@ModelAttribute @Valid DashBoardVO vo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("dashBoard/stt_dashBoard");
		String bizName = "총괄현황";
		HttpUtil.printServiceLogStart(bizName, log, request);
		 
		
		try{
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			  
			model.addAttribute("dataList", dashBoardService.getDashBoardMain(vo));
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("fail.common.msg");
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/use/updateDashBoardMain.do")
	@RequestName(value="dashBoard")
	public String updateDashBoardMain(@ModelAttribute @Valid DashBoardVO vo, BindingResult bindingResult, HttpServletRequest request, Model model) throws Exception {
		
		int result = 0;
		
		try {
	        
			UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
            if(userSessionVO == null){
            	throw new CfoodException(getMessage("error.invalidSession"));
            }
            
            //checkBikeVo.setModId(userSessionVO.getUsrId());
            vo.setRegId(userSessionVO.getUsrId());
			
	        result = dashBoardService.updateDashBoardMain(vo);
	        model.addAttribute("result", result);
			
        }catch(CfoodException e) {
        	result = 0;
        	model.addAttribute(RESULT_MESSAGE, result);
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
		
		model.addAttribute(RESULT_MESSAGE, result);
		
		return JSONVIEW;
	}
	
	
}
