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
package com.dkitec.barocle.admin.maintenance.check.lock.service;

import java.sql.SQLException;
import java.util.List;

import com.dkitec.barocle.admin.maintenance.check.lock.vo.CheckLockVO;

public interface CheckLockService {

	List<CheckLockVO> getCheckLockList(CheckLockVO checkLockVo) throws SQLException;

	int getCheckLockListCount(CheckLockVO checkLockVO)  throws SQLException;

	int exeLockSelectCheck(CheckLockVO checkLockVO) throws SQLException;

	int exeLockAllCheck(CheckLockVO checkLockVO, List<CheckLockVO> resultList) throws SQLException;

}
