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
package com.dkitec.barocle.admin.maintenance.inspect.bike.service;

import java.sql.SQLException;
import java.util.List;

import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;
import com.dkitec.barocle.admin.customer.opinionboard.vo.OpinionBoardVO;
import com.dkitec.barocle.admin.maintenance.inspect.bike.vo.InspectBikeVO;

public interface InspectBikeService {

	List<InspectBikeVO> getInspectBikeList(InspectBikeVO inspectBikeVo) throws SQLException;

	int getInspectBikeListCount(InspectBikeVO inspectBikeVO)  throws SQLException;

	int getObstacleCnt() throws SQLException;														//자전거 장애건_현황_카운트 _cms_20161123

	List<InspectBikeVO> getObstacleList(InspectBikeVO inspectBikeVo)throws SQLException;			//자전거 장애건_현황_리스트 _cms_20161123

	CategoryVO getObstacleTime()throws SQLException;												//자전거 장애건 주기 조회 _cms_20161124
	
	public int insertTeamInfo(InspectBikeVO inspectBikeVo);	// 담당자 등록 180828

}
