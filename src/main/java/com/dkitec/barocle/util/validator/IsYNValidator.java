package com.dkitec.barocle.util.validator;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import com.dkitec.barocle.util.validator.annotation.IsYN;

public class IsYNValidator implements ConstraintValidator<IsYN,String>{

	@Override
	public void initialize(IsYN constraintValidator) {}

	@Override
	public boolean isValid(String isYN, ConstraintValidatorContext context) {
		if(isYN!=null&&!"".equalsIgnoreCase(isYN)&&isYN.length()>0){ return isYN.matches("^[Y|N]*$"); }
		return true;
	}

}
