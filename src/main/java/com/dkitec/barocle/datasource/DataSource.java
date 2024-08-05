package com.dkitec.barocle.datasource;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
 
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface DataSource {
	com.dkitec.barocle.datasource.DataSourceType value() default com.dkitec.barocle.datasource.DataSourceType.SLAVE01;
}