package com.dkitec.barocle.util.validator;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import com.dkitec.barocle.util.validator.annotation.IsDate;

public class IsDateValidator implements ConstraintValidator<IsDate,String>{

	@Override
	public void initialize(IsDate constraintValidator) {}

	@Override
	public boolean isValid(String isDate, ConstraintValidatorContext context) {
		if(isDate!=null&&isDate.length()>0){ return isDate.matches("\\d{4}-\\d{2}-\\d{2}"); }
		return true;
	}

}
