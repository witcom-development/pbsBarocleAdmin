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
import javax.validation.ReportAsSingleViolation;
import javax.validation.constraints.NotNull;

import com.dkitec.barocle.util.validator.IsStringNumericValidator;

/**
 * @purpose	값이 존재하며 범위가 0~2147483647인지 검사한다.
 * @target	String
 * @null	false
 * @author	sickdog
 */
@Documented
@Constraint(validatedBy={IsStringNumericValidator.class})
@Target({ANNOTATION_TYPE, CONSTRUCTOR, FIELD, METHOD, PARAMETER})
@Retention(RUNTIME)
@ReportAsSingleViolation
@NotNull
public @interface IsStringNumeric {
	
	String message() default "{com.dkitec.barocle.util.validator.annotation.IsStringNumeric.message}";
	
	Class<?>[] groups() default {};
	
	Class<? extends Payload>[] payload() default {};
	
}
