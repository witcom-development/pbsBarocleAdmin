package com.dkitec.barocle.admin.system.commonCodeMgmt.validator;

import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.webutil.StringUtil;

import egovframework.rte.fdl.cmmn.exception.EgovBizException;

public class CommonCodeValidator extends BaseController{
	public void checkParam(CommonCodeVO vo) throws Exception {
		//null 체크
		if(StringUtil.isEmpty(vo.getComCd())) throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"공통 코드"}, null);
		else{
			if(!StringUtil.bigEngAndNumber(vo.getComCd(), 2)){
				throw new EgovBizException(messageSource, "fail.input.param.error", new Object[] {"공통 코드 입력 값을 확인하세요."}, null);
			}
		}
		if(StringUtil.isEmpty(vo.getComCdName())) throw new EgovBizException(messageSource, "fail.input.emptyValue1", new String[]{"공통 코드명"}, null);
		else{
			if(!StringUtil.codeName(vo.getComCdName(), 20)){
				throw new EgovBizException(messageSource, "fail.input.param.error", new Object[] {"공통 코드명  값을 확인하세요."}, null);
			}
		}
		//if(StringUtil.isEmpty(vo.getGrpFix())) throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"하위 코드 약어"}, null);
		if(!StringUtil.isEmpty(vo.getCdDesc1()) && vo.getCdDesc1().length() > 45) throw new EgovBizException(messageSource, "fail.input.param.error", new Object[] {"코드설명1은 45자 이하만 가능합니다."}, null);
		if(!StringUtil.isEmpty(vo.getCdDesc2()) && vo.getCdDesc2().length() > 45) throw new EgovBizException(messageSource, "fail.input.param.error", new Object[] {"코드설명2는 45자 이하만 가능합니다."}, null);
		
		//하위코드 중 공통코드명 및 표시여부,순서 항목중 미입력항목이 존재하는지 검사
		
		/*String[] com_cd_list = vo.getComCdList();
		String[] com_cd_name_list = vo.getComCdNameList();
		String[] use_yn_list = vo.getUseYnList().split(",");
		String[] dsp_order_list = vo.getDspOrderList();
		String[] crud_type_list = vo.getCrudTypeList();
		String[] cd_desc1_list = vo.getCdDesc1List();
		String[] cd_desc2_list = vo.getCdDesc2List();
		if(com_cd_list != null) {
			for(int i=0; i<com_cd_list.length; i++) {
				if(StringUtil.isEmpty(com_cd_list[i])) throw new EgovBizException(messageSource, "fail.list.emptyValue2", new String[]{"공통코드"}, null);
				if(StringUtil.isEmpty(com_cd_name_list[i])) throw new EgovBizException(messageSource, "fail.list.emptyValue1", new String[]{"공통코드명"}, null);
				if(StringUtil.isEmpty(use_yn_list[i])) throw new EgovBizException(messageSource, "fail.list.emptyValue2", new String[]{"표시여부"}, null);
				if(StringUtil.isEmpty(dsp_order_list[i])) throw new EgovBizException(messageSource, "fail.list.emptyValue2", new String[]{"순서"}, null);
			}
		}
		if(dsp_order_list != null){
			boolean overlap = false;
			boolean isNum = false;
			for(String dsp : dsp_order_list) {
				int i=0;
				for(String dsp2 : dsp_order_list) {
					if(dsp.equals(dsp2)) i++;
				}
				if(i>1){
					overlap = true; 
					break;
				}
				if(!StringUtil.isNumeric(dsp)){
					isNum = true;
					break;
				}
			}
			
			if(overlap) throw new EgovBizException(messageSource, "fail.input.overlap", new String[]{"순서"}, null);
			if(isNum) throw new EgovBizException(messageSource, "fail.input.param.error", new Object[] {"순서 값은 숫자만 가능합니다."}, null);
		}
		
		if(com_cd_list != null){
			boolean overlap = false;
			boolean isCode = false;
			String crudType = "";
			String comCd = "";
			for(int j=0; j < com_cd_list.length ; j++) {
				int i=0;
				comCd = com_cd_list[j];
				crudType = crud_type_list[j];
				if(crudType.equals(IConstants.CRUD_C)){
					comCd = vo.getComCd() + comCd;
					com_cd_list[j] = comCd;
					if(!StringUtil.engAndNumber(comCd, 10)){
						isCode = true;
					}
				}
				for(String comCd2 : com_cd_list) {
					if(comCd.equals(comCd2)) i++;
				}
				if(i>1){
					overlap = true; 
					break;
				}
			}
			if(isCode) throw new EgovBizException(messageSource, "fail.input.param.error", new Object[] {"하위 공통 코드 입력 값을 확인하세요."}, null);
			if(overlap) throw new EgovBizException(messageSource, "fail.input.overlap", new String[]{"하위 코드"}, null);
		}
		
		if(com_cd_name_list != null){
			boolean isName = false;
			for(String comCdName : com_cd_name_list){
				if(!StringUtil.codeName(comCdName, 20)){
					isName = true;
					break;
				}
			}
			if(isName) throw new EgovBizException(messageSource, "fail.input.param.error", new Object[] {"하위 공통 코드명 입력 값을 확인하세요."}, null);
		}
		
		if(cd_desc1_list != null){
			boolean  isDesc = false;
			for(String desc1 : cd_desc1_list){
				if(desc1!= null && desc1.length() > 45){
					isDesc = true;
					break;
				}
			}
			if(isDesc) throw new EgovBizException(messageSource, "fail.input.param.error", new Object[] {"하위 공통 코드 설명1 값을 확인하세요."}, null);
		}
		
		if(cd_desc2_list != null){
			boolean  isDesc = false;
			for(String desc2 : cd_desc2_list){
				if(desc2!= null && desc2.length() > 45){
					isDesc = true;
					break;
				}
			}
			if(isDesc) throw new EgovBizException(messageSource, "fail.input.param.error", new Object[] {"하위 공통 코드 설명2 값을 확인하세요."}, null);
		}*/
		
	}
	
	public void checkCodeParam(CommonCodeVO vo) throws Exception {
		//null 체크
		if(StringUtil.isEmpty(vo.getComCd())) throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"공통 코드"}, null);
		else{
			if(!StringUtil.bigEngAndNumber(vo.getComCd(), 2)){
				throw new EgovBizException(messageSource, "fail.input.param.error", new Object[] {"공통 코드 입력 값을 확인하세요."}, null);
			}
		}
	}
	
	
	public void checkInsertParam(CommonCodeVO vo) throws Exception {
		//null 체크
		if(StringUtil.isEmpty(vo.getComCd())) throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"공통 코드"}, null);
		else{
			if(!StringUtil.bigEngAndNumber(vo.getComCd(), 2)){
				throw new EgovBizException(messageSource, "fail.input.param.error", new Object[] {"공통 코드 입력 값을 확인하세요."}, null);
			}
		}
		if(StringUtil.isEmpty(vo.getComCdName())) throw new EgovBizException(messageSource, "fail.input.emptyValue2", new String[]{"공통 코드명"}, null);
		else{
			if(!StringUtil.codeName(vo.getComCdName(), 20)){
				throw new EgovBizException(messageSource, "fail.input.param.error", new Object[] {"공통 코드명  값을 확인하세요."}, null);
			}
		}
		if(!StringUtil.isEmpty(vo.getCdDesc1()) && vo.getCdDesc1().length() > 45) throw new EgovBizException(messageSource, "fail.input.param.error", new Object[] {"코드설명1은 45자 이하만 가능합니다."}, null);
		if(!StringUtil.isEmpty(vo.getCdDesc2()) && vo.getCdDesc2().length() > 45) throw new EgovBizException(messageSource, "fail.input.param.error", new Object[] {"코드설명2는 45자 이하만 가능합니다."}, null);
	}
}
