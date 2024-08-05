/*
 * @Package Name : com.dkitec.barocle.admin.system.MenuMgmt.controller
 * @파일명          : MenuMgmtController.java
 * @작성일          : 2015. 4. 7.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 7.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.system.MenuMgmt.controller;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService;
import com.dkitec.barocle.admin.system.MenuMgmt.validator.MenuValidator;
import com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO;
import com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuUrlVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;
import com.dkitec.barocle.util.webutil.StringUtil;

import egovframework.rte.fdl.cmmn.exception.EgovBizException;

/**
 * @파일명          : MenuMgmtController.java
 * @작성일          : 2015. 4. 7.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 7.   |   ymshin   |  최초작성
 */
@Controller
@RequestCategory(value="MenuMgmtController")
public class MenuMgmtController extends BaseController {

	@Resource(name = "menuMgmtService") private MenuMgmtService menuMgmtService;
	private static final String RETUR_URL = "/admin/system/menu/";
    private MenuValidator menuValidator = new MenuValidator();
	protected static Logger log = LoggerFactory.getLogger(MenuMgmtController.class);
	
	 /**
     * 메뉴목록를 조회한다.
     * @param menuVO MenuMgmtVO
     * @return 출력화면정보 "/menu/menuList"
	 * @throws SQLException 
     * @exception Exception
     */
    @RequestMapping(value="/getMenuList.do")
    @RequestName("getMenuList")
    public String getMenuList(@ModelAttribute  MenuMgmtVO menuVO, HttpServletRequest request,ModelMap model) throws EgovBizException, SQLException {

        String bizName = "메뉴관리 목록 조회";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
        boolean bResult = false;
        try {
        	List<MenuMgmtVO> list_menulist = menuMgmtService.getMenuList(menuVO);
        	model.addAttribute("menuListData", list_menulist);
        	bResult = true;
        } catch(Exception e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
        
        return bResult ? RETUR_URL.concat("sys_menu_list") : ERROR_PAGE;
    }

    /**
     * 상위 메뉴목록를 가져온다.
     * @param menuVO MenuMgmtVO
     * @return 출력화면정보 "/menu/menuList"
     * @exception Exception
     */
    @RequestMapping(value="/upperMenuPop.do", method = RequestMethod.GET)
    @RequestName("getUpperMenuPop")
    public String getUpperMenuPop(@ModelAttribute MenuMgmtVO menuVO,HttpServletRequest request,ModelMap model) throws Exception {

        String bizName = "상위 메뉴 목록 조회";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
        boolean bResult = false;
        try {
        	
        	List<MenuMgmtVO> list_menulist = menuMgmtService.getMenuList(menuVO);
        	model.addAttribute("menuListData", list_menulist);
        	bResult = true;
        } catch(Exception e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
        return bResult ? RETUR_URL.concat("sys_menu_pop") : ERROR_PAGE;
    }

    /**
     * 메뉴목록를 수정한다.
     * @param menuVO MenuMgmtVO
     * @return 출력화면정보 "/menu/menuList"
     * @exception Exception
     */
    @RequestMapping(value="/menuUpdateAjax.do")
    @RequestName("menuUpdateAjax")
    public String menuUpdateAjax(@ModelAttribute @Valid MenuMgmtVO menuVO,BindingResult bindingResult,HttpServletRequest request,ModelMap model)throws Exception {

        String bizName = "메뉴 수정";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
        String resultMsg = "수정에 성공했습니다.";
        int result = 0;
        try {
        	UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
        	
        	String admin = userSessionVO == null ? "test" :userSessionVO.getUsrId();
        	
        	if(bindingResult.hasErrors()) {
				for(FieldError fe : bindingResult.getFieldErrors()) {
					resultMsg = fe.getDefaultMessage();
				}
			} else {
				menuVO.setRegUsrId(admin);
	        	MenuMgmtVO getOldData = menuMgmtService.getMenuInfo(menuVO);
	        	result = menuMgmtService.setMenu(menuVO, getOldData);
	        	
	        	if( result < 0) {
	        		result = 0;
	        		resultMsg = "수정에 실패 했습니다.";
	        	}
			}
        	
        	model.addAttribute(RESULT_MESSAGE,resultMsg);
        	model.addAttribute(CHECK_RESULT,result);
        	
        } catch(Exception e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
        return JSONVIEW;

    }
    
    /**
     * 메뉴목록를 등록한다.
     * @param menuVO MenuMgmtVO
     * @return 출력화면정보 "/menu/menuList"
     * @exception Exception
     */
    @RequestMapping(value="/menuInsertAjax.do")
    @RequestName("menuInsertAjax")
    public String  menuInsertAjax(@ModelAttribute @Valid MenuMgmtVO menuVO,BindingResult bindingResult,HttpServletRequest request,ModelMap model)throws Exception {

        String bizName = "메뉴 등록";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
        String resultMsg = "메뉴 등록에 성공했습니다.";
        int result = 0; 
        try {
        	UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
        	String admin = userSessionVO.getUsrId() == null ? "test" :userSessionVO.getUsrId();
        	menuVO.setRegUsrId(admin);
        	if(bindingResult.hasErrors()) {
				for(FieldError fe : bindingResult.getFieldErrors()) {
					resultMsg = fe.getDefaultMessage();
				}
			} else {
				// 동일한 메뉴코드의 메뉴 존재 체크
				//만약에 upMenu 가 빈값이경우는 대메뉴이므로 
				MenuMgmtVO resultData =  menuMgmtService.getMenuInfo(menuVO);
				if( !menuVO.getDownMenuCd().equals("")  && resultData != null ) {
					resultMsg = "동일한 메뉴가 존재합니다.";
				} else {
					int underCount = menuMgmtService.getMenuUnderCount(menuVO);
					if(underCount == 0){
						underCount = Integer.parseInt(menuVO.getMenuOrd());
					}
					menuVO.setMenuOrd(String.valueOf(underCount));
					
					if(StringUtil.isEmpty(menuVO.getMenuDetailCd())) {
						menuVO.setMenuDetailCd(menuVO.getDownMenuCd());
					} else {
						menuVO.setMenuDetailCd(menuVO.getMenuDetailCd() + "/" + menuVO.getDownMenuCd());
					}
					
					result = menuMgmtService.addMenu(menuVO);
				}
				
			}
        	model.addAttribute(RESULT_MESSAGE, resultMsg);
        	model.addAttribute(CHECK_RESULT, result);
        
        } catch(Exception e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
        return JSONVIEW;
    }

    /**
     * 메뉴의 하위 메뉴 존재 체크.
     * @param menuVO MenuMgmtVO
     * @return JSONView
     * @exception Exception
     */
    @RequestMapping(value="/menuUnderCountAjax.do")
    @RequestName("menuUnderCount")
    public  String menuUnderCount(@ModelAttribute @Valid MenuMgmtVO menuVO,BindingResult bResult, HttpServletRequest request, ModelMap model) throws Exception {
        String bizName = "하위 메뉴 여부 체크";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
        
        try {
        	//menuValidator.menuUnderCountCheck(menuVO);
        	int result = menuMgmtService.getMenuUnderCount(menuVO);
        	model.addAttribute("menuUnderCount", result);
        	
        } catch(Exception e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
      	return  JSONVIEW;
    }

    /**
     * 메뉴 삭제.
     * @param menuVO MenuMgmtVO
     * @return JSONView
     * @exception Exception
     */
    @RequestMapping(value="/menuDeleteAjax.do")
    @RequestName("menuDeleteAjax")
    public String menuDeleteAjax(@ModelAttribute  @Valid MenuMgmtVO menuVO, BindingResult bResult, HttpServletRequest request,ModelMap model)throws Exception {

        String bizName = "메뉴 삭제";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
        String resultMsg = "삭제에 성공했습니다.";
        int result = 0;
        try {
        	
        	if(bResult.hasErrors()) {
				for(FieldError fe : bResult.getFieldErrors()) {
					resultMsg = fe.getDefaultMessage();
				}
			} else {
				int underCount = 0;
				underCount = menuMgmtService.getMenuUnderCount(menuVO);
				menuVO.setDownCnt(underCount);
				MenuMgmtVO getOldData = menuMgmtService.getMenuInfo(menuVO);
				result = menuMgmtService.delMenu(menuVO ,getOldData);
				
			}
        	
            model.addAttribute(CHECK_RESULT,result);
            model.addAttribute(RESULT_MESSAGE,resultMsg);
        	
        } catch(Exception e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
      	return JSONVIEW ;

    }

    /**
     * 메뉴의 URL 목록 가져오기
     * @param menuVO MenuMgmtVO
     * @return JSONView
     * @exception Exception
     */
    @RequestMapping(value="/menuUrlAjax.do")
    @RequestName("menuUrlAjax")
    public String menuUrlAjax(@ModelAttribute @Valid MenuMgmtVO menuVO, BindingResult bResult, HttpServletRequest request, ModelMap model) throws Exception {
    	
        String bizName = "메뉴 URL 조회";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
        
        List<MenuUrlVO> result = null;
        try {
        	boolean hasUrl = menuValidator.getMenuUrlCheck(menuVO);
        	if(hasUrl) {
        		result = menuMgmtService.getMenuUrlList(menuVO);
        	}
        	model.addAttribute("resultData", result);
        } catch(Exception e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
      	return JSONVIEW; 
    }

    /**
     * 메뉴의 URL 수정하기
     * @param menuVO MenuMgmtVO
     * @return JSONView
     * @exception Exception
     */
    @RequestMapping(value="/menuUrlUpdateAjax.do")
    @RequestName("menuUrlUpdateAjax")
    public String menuUrlUpdateAjax(@ModelAttribute @Valid MenuUrlVO menuUrlVO,BindingResult bResult, HttpServletRequest request, ModelMap model) throws Exception {

        String bizName = "메뉴 URL 수정";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
        String resultMsg = "수정에 성공했습니다.";
        int result = 0;
        try {
        	if(bResult.hasErrors()) {
        		for(ObjectError error : bResult.getAllErrors()) {
        			resultMsg = error.getDefaultMessage();
        		}
        	} else {
        		result= menuMgmtService.setMenuUrl(menuUrlVO);
        		
        	}
        	model.addAttribute(RESULT_MESSAGE,resultMsg);
        	model.addAttribute(CHECK_RESULT,result);
        	
        } catch(Exception e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
      	return JSONVIEW ;
    }
	
}
