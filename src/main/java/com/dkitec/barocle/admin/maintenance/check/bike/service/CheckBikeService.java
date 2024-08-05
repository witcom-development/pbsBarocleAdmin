/*
 * @Package Name : com.dkitec.barocle.admin.manage.DeviceMgmt.service
 * @파일명          : DeviceMgmtService.java
 * @작성일          : 2015. 4. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 15.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.maintenance.check.bike.service;

import java.sql.SQLException;
import java.util.List;

import com.dkitec.barocle.admin.maintenance.check.bike.vo.CheckBikeVO;

public interface CheckBikeService {

	List<CheckBikeVO> getCheckBikeList(CheckBikeVO checkBikeVo) throws SQLException;

	int getCheckBikeListCount(CheckBikeVO checkBikeVO)  throws SQLException;

	int exeBikeSelectCheck(CheckBikeVO checkBikeVO) throws SQLException;

	int exeBikeAllCheck(CheckBikeVO checkBikeVO, List<CheckBikeVO> resultList) throws SQLException;
	
}
