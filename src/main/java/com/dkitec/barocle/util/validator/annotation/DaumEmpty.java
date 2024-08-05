package com.dkitec.barocle.util.validator.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

import com.dkitec.barocle.util.validator.DaumEmptyValidator;

/**
 * @purpose	다음 에디터 "내용" 부분의 입력 여부를 검사한다.
 * @target	String
 * @null	false
 * @author	sickdog
 * @note	다음 에디터에 입력을 하지 않아도 <p><br/></p>와 같이 테그내용을 넘긴다.
 */
@Documented
@Constraint(validatedBy={DaumEmptyValidator.class})
@Target({ElementType.FIELD, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface DaumEmpty {
	
	String message() default "{com.dkitec.barocle.util.validator.annotation.DaumEmpty.message}";
	
	Class<?>[] groups() default {};
	
	Class<? extends Payload>[] payload() default {};

}
