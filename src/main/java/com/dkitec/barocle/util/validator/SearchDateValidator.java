package com.dkitec.barocle.util.validator;

import java.text.ParseException;

import org.springframework.validation.Errors;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.validator.GroupsSupportedTypeValidator;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.SearchDate;

public class SearchDateValidator extends GroupsSupportedTypeValidator<PagingVO, SearchDate> {

	@Override
	protected Class<PagingVO> getSupportedClass() {
		return PagingVO.class;
	}

	@Override
	protected Class<SearchDate> getSupportedAnnotation() {
		return SearchDate.class;
	}

	@Override
	protected Class<?>[] getAcceptableGroup(SearchDate searchDate) {
		return searchDate.groups();
	}

	@Override
	protected void _validate(PagingVO pagingVO, Errors errors) throws CfoodException {
		
		String searchStartDate = pagingVO.getSearchStartDate();
		String searchEndDate = pagingVO.getSearchEndDate();
		
		if(searchStartDate!=null&&searchEndDate!=null&&!"".equals(searchStartDate)&&!"".equals(searchEndDate)){
			java.text.SimpleDateFormat transFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
			try {
				java.util.Date sDate = transFormat.parse(pagingVO.getSearchStartDate());
				java.util.Date eDate = transFormat.parse(pagingVO.getSearchEndDate());
				if(sDate.after(eDate)){
					// void org.springframework.validation.Errors.rejectValue(String field, String errorCode)
					errors.rejectValue("searchDate", "com.dkitec.barocle.util.validator.SearchDateValidator");
					//errors.rejectValue("searchStartDate", "com.dkitec.barocle.util.validator.SearchDateValidator");
				}
			} catch (ParseException e) {
				errors.rejectValue("searchDate", "SearchDateValidator");
				//throw new CfoodException("com.dkitec.barocle.util.validator.SearchDateValidator.message");
			}
		}
				
	}
}
