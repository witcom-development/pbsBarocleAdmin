package com.dkitec.barocle.util.validator;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import com.dkitec.barocle.util.validator.annotation.DaumEmpty;

public class DaumEmptyValidator implements ConstraintValidator<DaumEmpty,String>{

	@Override
	public void initialize(DaumEmpty constraintAnnotation) {}
	
	@Override
	public boolean isValid(String daumEmpty, ConstraintValidatorContext context) {
		if(daumEmpty==null||"".equals(daumEmpty)||((daumEmpty.replaceAll("<[^>]*>", "").replaceAll("&nbsp;", "")).trim()).length()<=0) return false;
		return true;
	}

}
