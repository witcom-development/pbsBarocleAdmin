package com.dkitec.barocle.util.validator.annotation;

import static java.lang.annotation.ElementType.ANNOTATION_TYPE;
import static java.lang.annotation.ElementType.CONSTRUCTOR;
import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.ElementType.PARAMETER;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

import com.dkitec.barocle.util.validator.IsStringNotNullNumericValidator;

/**
 * @purpose	값이 존재하며 범위가 0~2147483647인지 검사한다.
 * @target	String
 * @null	true
 * @author	sickdog
 */
@Documented
@Constraint(validatedBy={IsStringNotNullNumericValidator.class})
@Target({ANNOTATION_TYPE, CONSTRUCTOR, FIELD, METHOD, PARAMETER})
@Retention(RUNTIME)
public @interface IsStringNotNullNumeric {
	
	String message() default "{com.dkitec.barocle.util.validator.annotation.IsStringNotNullNumeric.message}";
	
	Class<?>[] groups() default {};
	
	Class<? extends Payload>[] payload() default {};
	
}
