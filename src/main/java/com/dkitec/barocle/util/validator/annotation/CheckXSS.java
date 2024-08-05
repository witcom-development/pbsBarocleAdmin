package com.dkitec.barocle.util.validator.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

import com.dkitec.barocle.util.validator.CheckXSSValidator;

/**
 * @purpose	XSS 검사를 한다.(null,"<script","<SCRIPT" 과 같은 내용에 대해서 false를 반환한다.)
 * @target	String
 * @null	false
 * @author	sickdog
 */
@Documented
@Constraint(validatedBy={CheckXSSValidator.class})
@Target({ElementType.FIELD, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface CheckXSS {
	
	String message() default "{com.dkitec.barocle.util.validator.annotation.CheckXSS.message}";
	
	Class<?>[] groups() default {};
	
	Class<? extends Payload>[] payload() default {};

}
