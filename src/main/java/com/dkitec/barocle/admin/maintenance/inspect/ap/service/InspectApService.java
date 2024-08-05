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
package com.dkitec.barocle.admin.maintenance.inspect.ap.service;

import java.sql.SQLException;
import java.util.List;

import com.dkitec.barocle.admin.maintenance.inspect.ap.vo.InspectApVO;

public interface InspectApService {

	List<InspectApVO> getInspectApList(InspectApVO inspectApVo) throws SQLException;

	int getInspectApListCount(InspectApVO inspectApVO)  throws SQLException;
	
	int insertInspectAp(InspectApVO inspectApVo);

}
