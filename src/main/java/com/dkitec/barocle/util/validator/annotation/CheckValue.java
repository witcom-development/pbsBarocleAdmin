package com.dkitec.barocle.util.validator.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

import com.dkitec.barocle.util.validator.CheckValueValidator;

/**
 * @purpose	null/공백을 검사 한다.(null," ","" 과 같은 내용에 대해서 false를 반환나다.)
 * @target	String
 * @null	false
 * @author	sickdog
 */
@Documented
@Constraint(validatedBy={CheckValueValidator.class})
@Target({ElementType.FIELD, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface CheckValue {
	
	String message() default "{com.dkitec.barocle.util.validator.annotation.CheckValue.message}";
	
	Class<?>[] groups() default {};
	
	Class<? extends Payload>[] payload() default {};

}
