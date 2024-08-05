package com.dkitec.barocle.admin.system.mainset.controller;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;
import com.dkitec.barocle.admin.system.mainset.service.MainSetService;
import com.dkitec.barocle.admin.system.mainset.vo.MainSetVO;
import com.dkitec.barocle.admin.system.mainset.vo.MainSetVO.MainSetEditVal;
import com.dkitec.barocle.admin.system.mainset.vo.MainSetVO.MainSetUpdateVal;
import com.dkitec.barocle.base.BaseController;

@Controller
@RequestCategory(value="MainSetController")
@RequestMapping(value="/admin/system/mainSet")
public class MainSetController extends BaseController {
	
	@Resource(name = "mainSetService") private MainSetService mainSetService;
	
	protected static Logger log = LoggerFactory.getLogger(MainSetController.class);
		
	@RequestName(value="editMainSet")
	@RequestMapping(value="/mainSetEdit.do")
	public String editMainSet(@Validated(MainSetEditVal.class) MainSetVO mainSetVO, BindingResult result, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){ throw new CfoodException("admin.system.mainset.mainSetEdit.bindingexception"); }
		
		boolean bResult = false;
		String resultPage = "/admin/system/mainSet/sys_set_detail";
		
		try{
			// 목록 가져오기
			CategoryVO categoryVO = new CategoryVO();
			categoryVO.setComCD("MSI");
			categoryVO.setComUpCD("MSI");
			categoryVO.setLangClsCD("LAG_001");
			java.util.List<CategoryVO> listCategoryVO = mainSetService.listMainSet(categoryVO);
			/*
			 * 주의 : 순차적을 받은 목록가 순차적으로 vo에 입력된다!!!
			 */			
			mainSetVO.setMsiList(listCategoryVO);
			
			// 재배치 유도 관련 list
			String[] arr = null;
			// 탄소절감 관련 list
			String[] arr2 = null;
			// QR자전거 상태주기보고 관련 list
			String[] arr3 = null;
			
			for(int i = 0; i< listCategoryVO.size(); i++){
				if(listCategoryVO.get(i).getComCD().toString().equals("MSI_025")){
					if(listCategoryVO.get(i).getAddVal1().toString().length() > 0){
						arr = listCategoryVO.get(i).getAddVal1().toString().split(",");
					}
				}
				if(listCategoryVO.get(i).getComCD().toString().equals("MSI_030")){
					if(listCategoryVO.get(i).getAddVal1().toString().length() > 0){
						arr2 = listCategoryVO.get(i).getAddVal1().toString().split(",");
					}
				}
				if(listCategoryVO.get(i).getComCD().toString().equals("MSI_035")){
					if(listCategoryVO.get(i).getAddVal1().toString().length() > 0){
						arr3 = listCategoryVO.get(i).getAddVal1().toString().split(",");
					}
				}
			}

			
			// return
			model.addAttribute("mainSetList",mainSetVO);
			model.addAttribute("mainSetView",listCategoryVO);
			
			// 재배치 유도
			if(arr.length > 0){
				//재배치 유도 점유율
				model.addAttribute("mainVal1",arr[0]);
				//재배치 유도 반경
				model.addAttribute("mainVal2",arr[1]);
				//재배치 유도 마일리지 (1회 적립 point)
				model.addAttribute("mainVal3",arr[2]);
				//재배치 유도 마일리지 (일 최대 적립 point)
				model.addAttribute("mainVal4",arr[3]);
				//재배치 유도 open 유무
				if(arr.length == 5){
					model.addAttribute("mainVal5",arr[4]);
				}
			}
			
			// 탄소절감
			if(arr2.length > 0){

				//재배치 유도 마일리지 (1회 적립 point)
				model.addAttribute("mainVal7",arr2[0]);
				//재배치 유도 마일리지 (일 최대 적립 point)
				model.addAttribute("mainVal8",arr2[1]);
				//재배치 유도 open 유무
				if(arr2.length == 3){
					model.addAttribute("mainVal9",arr2[2]);
				}
			}
			
			// 사용자
			if(arr3.length > 0){
				
				// 대여
				model.addAttribute("mainVal11", arr3[0]);
				// 반납
				model.addAttribute("mainVal12", arr3[1]);
				// 이동
				model.addAttribute("mainVal13", arr3[2]);
				// 설치
				if(arr3.length == 4){
					model.addAttribute("mainVal14", arr3[3]);
				}
			}
			
			
			bResult = true;		// 정상
			
		} catch (Exception e) {
			throw new CfoodException("admin.system.mainset.mainSetEdit",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="updateMainSet")
	@RequestMapping(value="/mainSetUpdate.do")
	public String updateMainSet(@Validated(MainSetUpdateVal.class) MainSetVO mainSetVO, BindingResult result, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("mainSetList",mainSetVO);
			model.addAttribute("resultError",super.setResultMessage(result));
			return "/admin/system/appVersion/sys_ver_detail";
		}
		
		boolean bResult = false;
		
		try{
			/*
			 * 서비스 운영시간에 시와 분을 같은 변수명으로 받아온다.
			 * 변수는 [00,00]와 같은 형식으로 들어와서 [00:00]으로 변경해야 한다.
			 */
			String str1 = mainSetVO.getMsiList().get(0).getAddVal1();
			String str2 = mainSetVO.getMsiList().get(0).getAddVal2();
			str1 = str1.substring(0,2) + ":"+ str1.substring(3,5);
			str2 = str2.substring(0,2) + ":"+ str2.substring(3,5);
			mainSetVO.getMsiList().get(0).setAddVal1(str1);
			mainSetVO.getMsiList().get(0).setAddVal2(str2);
			
			@SuppressWarnings("unused") MainSetVO returnVO  = mainSetService.updateMainSet(mainSetVO);
			
			bResult = true;		// 정상
			
		} catch (Exception e) {
			throw new CfoodException("admin.system.mainset.mainSetUpdate",e);
		}
			
		return bResult ? "redirect:/admin/system/mainSet/mainSetEdit.do" : ERROR_PAGE;
	}

}
