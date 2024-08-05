/*
 * @Package Name : com.dkitec.barocle.admin.system.MenuMgmt.service
 * @파일명          : MenuMgmtService.java
 * @작성일          : 2015. 4. 7.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 7.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.system.MenuMgmt.service;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO;
import com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuOpenHistVO;
import com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuUrlVO;

/**
 * @파일명          : MenuMgmtService.java
 * @작성일          : 2015. 4. 7.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 7.   |   ymshin   |  최초작성
 */
public interface MenuMgmtService {
	
	public ArrayList<MenuMgmtVO> getMenuList(MenuMgmtVO menuVo) throws SQLException;
	public MenuMgmtVO getMenuInfo(MenuMgmtVO menuVo) throws SQLException;
	public int getMenuUnderCount(MenuMgmtVO menuVo) throws SQLException;
	public int setMenuOrder(MenuMgmtVO menuVo) throws SQLException;
	public int setMenu(MenuMgmtVO menuVo, MenuMgmtVO getOldData) throws SQLException;
	public int addMenu(MenuMgmtVO menuVo) throws SQLException;
	public int delMenu(MenuMgmtVO menuVo, MenuMgmtVO getOldData) throws SQLException;
	public ArrayList<MenuUrlVO> getMenuUrlList(MenuMgmtVO menuVo) throws SQLException;
	public int addMenuUrl(MenuUrlVO menuUrlVO) throws SQLException;
	public int setMenuUrl(MenuUrlVO menuUrlV) throws SQLException;
	public int delMenuSeqALLUrlDelete(MenuUrlVO menuUrlVO) throws SQLException;
	public int delMenuUrlDelete(MenuUrlVO menuUrlVO) throws SQLException;
	public ArrayList<MenuMgmtVO> getMenuTop(MenuMgmtVO menuVo) throws SQLException;
	public ArrayList<MenuMgmtVO> getMenuLeft(MenuMgmtVO menuVo) throws SQLException;
	public ArrayList<MenuMgmtVO> getMenuGrpList(MenuMgmtVO menuVo) throws SQLException;
	public int addMenuGrp(MenuMgmtVO menuVo) throws SQLException;
	public int setMenuGrp(MenuMgmtVO menuVo) throws SQLException;
	public int delMenuGrp(MenuMgmtVO menuVo) throws SQLException;
	public int getMenuGrpUrlNotLogin(MenuUrlVO menuUrlVO) throws SQLException;
	public MenuMgmtVO getMenuGrpUrlCheck(MenuUrlVO menuVo) throws SQLException;
	
	 public int addMenuOpenHist(HttpServletRequest request);
}
