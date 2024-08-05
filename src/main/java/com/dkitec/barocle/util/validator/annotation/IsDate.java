package com.dkitec.barocle.util.validator.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

import com.dkitec.barocle.util.validator.IsDateValidator;

/**
 * @purpose	입력한 날짜가 "yyyy-MM-dd" 형식이 맞는지 검사한다.
 * @target	String
 * @null	true
 * @author	sickdog
 * @note	공백을 허용한다.
 */
@Documented
@Constraint(validatedBy={IsDateValidator.class})
@Target({ElementType.FIELD, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface IsDate {
	
	String message() default "{com.dkitec.barocle.util.validator.annotation.IsDate.message}";
	
	Class<?>[] groups() default {};
	
	Class<? extends Payload>[] payload() default {};

}
