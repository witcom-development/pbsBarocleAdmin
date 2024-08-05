package com.dkitec.barocle.util.validator;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import com.dkitec.barocle.util.validator.annotation.ValMode;

public class ValModeValidator implements ConstraintValidator<ValMode,String>{

	private String[] valModeList = {"mode","list","view","write","edit","insert","update","delete","comment","reply"};
	
	@Override
	public void initialize(ValMode constraintAnnotation) {}
	
	@Override
	public boolean isValid(String valMode, ConstraintValidatorContext context) {
		if(valMode!=null&&!"".equals(valMode)){
			for(String str : valModeList){ 
				if(valMode.equalsIgnoreCase(str)){ return true; }
			}
		}
		return false;
	}

}
