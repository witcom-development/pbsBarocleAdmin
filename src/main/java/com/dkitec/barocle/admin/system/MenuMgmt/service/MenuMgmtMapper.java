/*
 * @Package Name : com.dkitec.barocle.admin.system.MenuMgmt.service
 * @파일명          : MenuMgmtMapper.java
 * @작성일          : 2015. 4. 7.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 7.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.system.MenuMgmt.service;

import java.util.ArrayList;

import com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO;
import com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuOpenHistVO;
import com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuUrlVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * @파일명          : MenuMgmtMapper.java
 * @작성일          : 2015. 4. 7.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 7.   |   ymshin   |  최초작성
 */
@Mapper("menuMgmtMapper")
public interface MenuMgmtMapper {

	public ArrayList<MenuMgmtVO> getMenuList(MenuMgmtVO menuVo);
	public MenuMgmtVO getMenuInfo(MenuMgmtVO menuVo);
	public int getMenuUnderCount(MenuMgmtVO menuVo);
	public int setMenuOrder(MenuMgmtVO menuVo);
	public int setMenu(MenuMgmtVO menuVo);
	public int addMenu(MenuMgmtVO menuVo);
	public int delMenu(MenuMgmtVO menuVo);
	public ArrayList<MenuUrlVO> getMenuUrlList(MenuMgmtVO menuVo);
	public int addMenuUrl(MenuUrlVO menuUrlVO);
	public int setMenuUrl(MenuUrlVO menuUrlV);
	public int delMenuSeqALLUrlDelete(MenuUrlVO menuUrlVO);
	public int delMenuUrlDelete(MenuUrlVO menuUrlVO);
	public ArrayList<MenuMgmtVO> getMenuTop(MenuMgmtVO menuVo);
	public ArrayList<MenuMgmtVO> getMenuLeft(MenuMgmtVO menuVo);
	public ArrayList<MenuMgmtVO> getMenuGrpList(MenuMgmtVO menuVo);
	public int addMenuGrp(MenuMgmtVO menuVo);
	public int setMenuGrp(MenuMgmtVO menuVo);
	public int delMenuGrp(MenuMgmtVO menuVo);
	public int getMenuGrpUrlNotLogin(MenuUrlVO menuUrlVO);
	public MenuMgmtVO getMenuGrpUrlCheck(MenuUrlVO menuUrlVO);
	
	public int addMenuOpenHist(MenuOpenHistVO menuOpenHistVO);
	
}
