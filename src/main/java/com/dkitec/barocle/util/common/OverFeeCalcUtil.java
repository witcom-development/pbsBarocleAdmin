/*
 * @Package Name : com.dkitec.barocle.util.common
 * @파일명          : OverFeeCalcUtil.java
 * @작성일          : 2015. 7. 22.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 7. 22.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.util.common;

import java.util.HashMap;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * @파일명          : OverFeeCalcUtil.java
 * @작성일          : 2015. 7. 22.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 7. 22.   |   ymshin   |  최초작성
 */
public class OverFeeCalcUtil {
	
	protected static Logger log = LoggerFactory.getLogger(OverFeeCalcUtil.class);
	
	public int getPay(Map<String, Object> min, Map<String, Object> max, int overFee) {

    	int over = overFee;
    	int pay = 0;
    	
    	int minStr = Integer.parseInt(min.get("OVER_STR_MI").toString());
    	int minEnd = Integer.parseInt(min.get("OVER_END_MI").toString());
    	int minPay = Integer.parseInt(min.get("ADD_FEE").toString());
    	int tempMinEnd = 0;
    	
    	int maxStr = Integer.parseInt(max.get("OVER_STR_MI").toString());
    	int maxPay = Integer.parseInt(max.get("ADD_FEE").toString());
    	int tempmax = 0;
    	
    	String tmp = min.get("ADD_FEE_INTER_MI")==null?"30":min.get("ADD_FEE_INTER_MI").toString();
    	int intervalMin = Integer.parseInt(tmp);
    	
    	tmp = max.get("ADD_FEE_INTER_MI")==null?"30":max.get("ADD_FEE_INTER_MI").toString();
    	int intervalMax = Integer.parseInt(tmp);
    	
		/**
    	 * 기본초과요금 부과
    	 */
    	if(overFee - (minStr-1)>0){
    		/**
    		 * 추과요금 부과
    		 */
    		int overTime = overFee - (maxStr -1) ;
    		if(overTime > 0){
    			// 추과 요금 부과시간
    			int payCount = overTime/intervalMax;
    			if(overTime%intervalMax>0){
    				payCount++;
    			}
    			pay = minPay + (maxPay * payCount);
    			log.debug("기본 초과 + 추가초과 요금 : {}" , pay);
    		}else{
    			/**
    			 * 기본요금만 부과.
    			 */
    			pay = minPay;
    			log.debug("기본 초과 : {}", pay);
    		}
    		
    	}else{
    		log.debug("초과요금 없음");
    	}
		return pay;
	}
	
public static void main(String[] args) {
		
		
		
		Map<String, Object> min = new HashMap<String, Object>();
		
		min.put("OVER_STR_MI", "61");
		min.put("OVER_END_MI", "90");
		min.put("ADD_FEE", "1000");
		min.put("ADD_FEE_INTER_MI", "30");
		
		
		Map<String, Object> max = new HashMap<String, Object>();
		
		max.put("OVER_STR_MI", "91");
		max.put("OVER_END_MI", "0");
		max.put("ADD_FEE", "1000");
		max.put("ADD_FEE_INTER_MI", "30");
		
		System.out.println(new OverFeeCalcUtil().getPay(min, max, 100));
		
	}

}
