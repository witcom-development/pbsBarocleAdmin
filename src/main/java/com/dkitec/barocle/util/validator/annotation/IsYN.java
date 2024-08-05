package com.dkitec.barocle.util.validator.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

import com.dkitec.barocle.util.validator.IsYNValidator;

/**
 * @purpose	입력한 문자가 Y 혹은 N 인지 검사한다.
 * @target	String
 * @null	true
 * @author	sickdog
 * @note	null," ",""등의 공백을 허용한다.(VO에서 초기값 설정 필요)
 */
@Documented
@Constraint(validatedBy={IsYNValidator.class})
@Target({ElementType.FIELD, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface IsYN {
	
	String message() default "{com.dkitec.barocle.util.validator.annotation.IsYN.message}";
	
	Class<?>[] groups() default {};
	
	Class<? extends Payload>[] payload() default {};

}
