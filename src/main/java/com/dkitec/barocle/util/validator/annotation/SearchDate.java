package com.dkitec.barocle.util.validator.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Payload;

/**
 * @purpose	검색 시작일자(searchStartDate)와 종료일자(searchEndDate)를 비교하여 유효성을 검사한다.
 * @target	String
 * @null	true
 * @author	sickdog
 * @note	자식 VO에 '@SearchDate(groups=PagingVO.SearchDateValidator.class)'와 같이 선언한다.
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface SearchDate {

	String message() default "{com.dkitec.barocle.util.validator.annotation.SearchDate.message}";

	Class<?>[] groups() default {};

	Class<? extends Payload>[] payload() default {};
}
