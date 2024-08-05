package com.dkitec.barocle.util.validator.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;
import javax.validation.ReportAsSingleViolation;
import javax.validation.constraints.NotNull;

import com.dkitec.barocle.util.validator.ValModeValidator;

/**
 * @purpose	mode에 값이 존재 및 유효성 여부를 검사한다.
 * 			private String[] valModeList = {"mode","list","view","write","edit","insert","update","delete","comment","reply"};
 * @target	String
 * @null	false
 * @author	sickdog
 */
@Documented
@Constraint(validatedBy={ValModeValidator.class})
@Target({ElementType.FIELD, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@ReportAsSingleViolation	// A constraint annotation hosting this annotation will return the composed annotation error report if any of the composing annotations fail. The error reports of each individual composing constraint is ignored.
@NotNull
public @interface ValMode {
	
	String message() default "{com.dkitec.barocle.util.validator.annotation.ValMode.message}";
	
	Class<?>[] groups() default {};
	
	Class<? extends Payload>[] payload() default {};
	
}
