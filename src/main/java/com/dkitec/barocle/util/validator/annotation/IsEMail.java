package com.dkitec.barocle.util.validator.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

import com.dkitec.barocle.util.validator.IsEMailValidator;

/**
 * @purpose	입력한 이메일이 형식에 맞는지 검사한다.
 * @target	String
 * @null	true
 * @author	sickdog
 */
@Documented
@Constraint(validatedBy=IsEMailValidator.class)
@Target({ElementType.FIELD, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface IsEMail {
	
	String message() default "{com.dkitec.barocle.util.validator.annotation.IsEMail.message}";
	
	Class<?>[] groups() default {};
	
	Class<? extends Payload>[] payload() default {};

}
