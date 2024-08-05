package com.dkitec.barocle.util.validator;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import com.dkitec.barocle.util.validator.annotation.CheckValue;

public class CheckValueValidator implements ConstraintValidator<CheckValue,String>{

	@Override
	public void initialize(CheckValue constraintAnnotation) {}
	
	@Override
	public boolean isValid(String checkValue, ConstraintValidatorContext context) {
		if(checkValue!=null&&!"".equals(checkValue)&&checkValue.trim().length()>=0) return true;
		return false;
	}

}
