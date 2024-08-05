package com.dkitec.barocle.util.validator.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

import com.dkitec.barocle.util.validator.IsMobileValidator;

/**
 * @purpose	입력한 휴대폰 번호가 "0[0|1][6-9]-xxx-xxxx" or "0[0|1][6-9]-xxxx-xxxx" 형식에 맞는지 검사한다.
 * @target	String
 * @null	true
 * @author	sickdog
 */
@Documented
@Constraint(validatedBy=IsMobileValidator.class)
@Target({ElementType.FIELD, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface IsMobile {
	
	String message() default "{com.dkitec.barocle.util.validator.annotation.IsMobile.message}";
	
	Class<?>[] groups() default {};
	
	Class<? extends Payload>[] payload() default {};

}
