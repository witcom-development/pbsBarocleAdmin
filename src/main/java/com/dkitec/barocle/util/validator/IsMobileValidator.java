package com.dkitec.barocle.util.validator;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import com.dkitec.barocle.util.validator.annotation.IsMobile;

public class IsMobileValidator implements ConstraintValidator<IsMobile,String>{

	@Override
	public void initialize(IsMobile constraintValidator) {}

	@Override
	public boolean isValid(String isMobile, ConstraintValidatorContext context) {
		if(isMobile!=null&&isMobile.length()>0){ return isMobile.matches("^01(?:0|1[6-9])-([0-9]{3,4})-([0-9]{4})$"); }
		return true;
	}

}
