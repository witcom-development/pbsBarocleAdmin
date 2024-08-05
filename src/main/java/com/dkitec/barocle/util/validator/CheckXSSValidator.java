package com.dkitec.barocle.util.validator;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import com.dkitec.barocle.util.validator.annotation.CheckXSS;

public class CheckXSSValidator implements ConstraintValidator<CheckXSS,String>{

	@Override
	public void initialize(CheckXSS constraintAnnotation) {}
	
	@Override
	public boolean isValid(String checkXSS, ConstraintValidatorContext context) {
		if(checkXSS!=null&&!"".equals(checkXSS)&&checkXSS.trim().length()>=0){ return !(checkXSS.indexOf("<script")>-1||checkXSS.indexOf("<SCRIPT")>-1); }
		return true;
	}

}
