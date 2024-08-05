/**
 * 파일명 : ResultMap.java
 * 작성자 : 김병기(Kim Byoung Ki) 차장
 * 작성일 : 2014 2014. 5. 7. 오후 8:21:52
 */

/**
 * 
 */
package com.dkitec.barocle.util.webutil;

/**
 * @author 김병기 차장(Kim Byoung Ki - Administrator)
 *
 */
import java.util.HashMap;

@SuppressWarnings ("rawtypes")
public class ResultMap extends HashMap {


     /**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 4912476180217044733L;

	@SuppressWarnings( "unchecked")
     public Object put(Object key, Object value ) {
           return super.put(String.valueOf( key).toLowerCase(), value );
     }

}
