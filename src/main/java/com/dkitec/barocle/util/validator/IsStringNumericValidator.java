package com.dkitec.barocle.util.validator;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import com.dkitec.barocle.util.validator.annotation.IsStringNumeric;

public class IsStringNumericValidator implements ConstraintValidator<IsStringNumeric,String>{
	
	@Override
	public void initialize(IsStringNumeric constraintValidator) {}
	
	@Override
	public boolean isValid(String isStringNumeric, ConstraintValidatorContext arg0) {
		if(isStringNumeric!=null&&!"".equals(isStringNumeric)&&isStringNumeric.trim().length()>=0) return isStringNumeric.matches("^[0-9]*$");
		return false;
	}

}
