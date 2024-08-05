package com.dkitec.barocle.util.validator;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import com.dkitec.barocle.util.validator.annotation.IsEMail;

public class IsEMailValidator implements ConstraintValidator<IsEMail,String>{

	@Override
	public void initialize(IsEMail constraintAnnotation) {}
	
	@Override
	public boolean isValid(String emailVal, ConstraintValidatorContext context) {
		if(emailVal!=null&&emailVal.length()>0){ return emailVal.matches("^[a-zA-Z0-9_\\-]+@[a-zA-Z0-9_\\-]+.[a-zA-Z\\.]*$"); }
		return true;
	}

}
