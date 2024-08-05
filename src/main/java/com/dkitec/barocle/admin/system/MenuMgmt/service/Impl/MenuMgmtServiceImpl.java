/*
 * @Package Name : com.dkitec.barocle.admin.system.MenuMgmt.service.Impl
 * @파일명          : MenuMgmtServiceImpl.java
 * @작성일          : 2015. 4. 7.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 7.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.system.MenuMgmt.service.Impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtMapper;
import com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService;
import com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO;
import com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuOpenHistVO;
import com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuUrlVO;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @파일명          : MenuMgmtServiceImpl.java
 * @작성일          : 2015. 4. 7.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 7.   |   ymshin   |  최초작성
 */
@Service("menuMgmtService")
public class MenuMgmtServiceImpl extends EgovAbstractServiceImpl implements MenuMgmtService {

	@Autowired private MenuMgmtMapper menuMgmtMapper;
	/**
	 * @location   : com.dkitec.barocle.admin.system.MenuMgmt.service.Impl.MenuMgmtService.getMenuList
	 * @writeDay   : 2015. 4. 7. 오후 5:49:17
	 * @overridden : @see com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService#getMenuList(com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO)
	 * @Todo       :
	 */ 
	@SuppressWarnings("unchecked")
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public ArrayList<MenuMgmtVO> getMenuList(MenuMgmtVO menuVo) throws SQLException{
		// TODO Auto-generated method stub
		return  menuMgmtMapper.getMenuList(menuVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.MenuMgmt.service.Impl.MenuMgmtService.getMenuInfo
	 * @writeDay   : 2015. 4. 7. 오후 5:49:17
	 * @overridden : @see com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService#getMenuInfo(com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public MenuMgmtVO getMenuInfo(MenuMgmtVO menuVo)  throws SQLException {
		// TODO Auto-generated method stub
		return menuMgmtMapper.getMenuInfo(menuVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.MenuMgmt.service.Impl.MenuMgmtService.getMenuUnderCount
	 * @writeDay   : 2015. 4. 7. 오후 5:49:17
	 * @overridden : @see com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService#getMenuUnderCount(com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getMenuUnderCount(MenuMgmtVO menuVo) throws SQLException {
		// TODO Auto-generated method stub
		return menuMgmtMapper.getMenuUnderCount(menuVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.MenuMgmt.service.Impl.MenuMgmtService.setMenuOrder
	 * @writeDay   : 2015. 4. 7. 오후 5:49:17
	 * @overridden : @see com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService#setMenuOrder(com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=false, propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int setMenuOrder(MenuMgmtVO menuVo) throws SQLException {
		// TODO Auto-generated method stub
		return menuMgmtMapper.setMenuOrder(menuVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.MenuMgmt.service.Impl.MenuMgmtService.
	 * @writeDay   : 2015. 4. 7. 오후 5:49:17
	 * @overridden : @see com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService#setMenu(com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=false, propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int setMenu(MenuMgmtVO menuVo, MenuMgmtVO getOldData)  throws SQLException {
		// TODO Auto-generated method stub
		int result = 0;
		if(getOldData != null ){
			menuVo.setOldMenuOrd(getOldData.getMenuOrd());
			menuVo.setType("U");
			result = this.setMenuOrder(menuVo);
			result = menuMgmtMapper.setMenu(menuVo);
		}
		return result;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.MenuMgmt.service.Impl.MenuMgmtService.addMenu
	 * @writeDay   : 2015. 4. 7. 오후 5:49:17
	 * @overridden : @see com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService#addMenu(com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=false, propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int addMenu(MenuMgmtVO menuVo) throws SQLException {
		// TODO Auto-generated method stub
		menuVo.setType("I");
		int result = 0;
		if(!menuVo.getMenuCd().equals("")) {
			result = this.setMenuOrder(menuVo);
		}
		result = menuMgmtMapper.addMenu(menuVo);
		return result;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.MenuMgmt.service.Impl.MenuMgmtService.delMenu
	 * @writeDay   : 2015. 4. 7. 오후 5:49:17
	 * @overridden : @see com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService#delMenu(com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=false, propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int delMenu(MenuMgmtVO menuVo, MenuMgmtVO getOldData)  throws SQLException{
		int result =0;
		menuVo.setOldMenuOrd(getOldData.getMenuOrd());
		menuVo.setType("D");
		
		result = this.setMenuOrder(menuVo);
		result = menuMgmtMapper.delMenu(menuVo);
		
		return result;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.MenuMgmt.service.Impl.MenuMgmtService.getMenuUrlList
	 * @writeDay   : 2015. 4. 7. 오후 5:49:17
	 * @overridden : @see com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService#getMenuUrlList(com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public ArrayList<MenuUrlVO> getMenuUrlList(MenuMgmtVO menuVo)  throws SQLException {
		// TODO Auto-generated method stub
		return menuMgmtMapper.getMenuUrlList(menuVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.MenuMgmt.service.Impl.MenuMgmtService.addMenuUrl
	 * @writeDay   : 2015. 4. 7. 오후 5:49:17
	 * @overridden : @see com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService#addMenuUrl(com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuUrlVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=false, propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int addMenuUrl(MenuUrlVO menuUrlVO)  throws SQLException {
		// TODO Auto-generated method stub
		return menuMgmtMapper.addMenuUrl(menuUrlVO);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.MenuMgmt.service.Impl.MenuMgmtService.setMenuUrl
	 * @writeDay   : 2015. 4. 7. 오후 5:49:17
	 * @overridden : @see com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService#setMenuUrl(com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuUrlVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=false, propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int setMenuUrl(MenuUrlVO menuUrlVo)  throws SQLException {
		// TODO Auto-generated method stub
		int result =0;
		List<MenuUrlVO> menuUrlList = menuUrlVo.getUrlList();
    	if(menuUrlList != null){
    		//수정등 구분
    		MenuUrlVO delUrlList = new MenuUrlVO();
    		for(MenuUrlVO pVo : menuUrlList) {
    			pVo.setMenuCd(menuUrlVo.getMenuCd().trim());
    			if(IConstants.CRUD_U.equals(pVo.getCrudFlg())){
    				result = menuMgmtMapper.setMenuUrl(pVo);
    			} else if(IConstants.CRUD_C.equals(pVo.getCrudFlg())){
    				result = menuMgmtMapper.addMenuUrl(pVo);
    			} else {
        			result = menuMgmtMapper.delMenuUrlDelete(pVo);
    			}
    			
    		}
    		if(menuUrlVo.getMenuUrlNotIn() != null && !menuUrlVo.getMenuUrlNotIn().equals("")) {
    			String[] delUrl = menuUrlVo.getMenuUrlNotIn().split(",");
    			delUrlList.setMenuCd(menuUrlVo.getMenuCd().trim());
    			for(int i=0; i<delUrl.length; i++) {
    				delUrlList.setMenuUrlSeq(delUrl[i]);
    				result = menuMgmtMapper.delMenuUrlDelete(delUrlList);
    			}
    		}
	    	
    	}else{
    		//올삭제
    		result = delMenuSeqALLUrlDelete(menuUrlVo);
    	}
    	
		
		return result;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.MenuMgmt.service.Impl.MenuMgmtService.delMenuSeqALLUrlDelete
	 * @writeDay   : 2015. 4. 7. 오후 5:49:17
	 * @overridden : @see com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService#delMenuSeqALLUrlDelete(com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuUrlVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=false, propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int delMenuSeqALLUrlDelete(MenuUrlVO menuUrlVO)  throws SQLException {
		// TODO Auto-generated method stub
		return menuMgmtMapper.delMenuSeqALLUrlDelete(menuUrlVO);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.MenuMgmt.service.Impl.MenuMgmtService.delMenuUrlDelete
	 * @writeDay   : 2015. 4. 7. 오후 5:49:17
	 * @overridden : @see com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService#delMenuUrlDelete(com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuUrlVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=false, propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int delMenuUrlDelete(MenuUrlVO menuUrlVO)  throws SQLException {
		// TODO Auto-generated method stub
		return menuMgmtMapper.delMenuUrlDelete(menuUrlVO);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.MenuMgmt.service.Impl.MenuMgmtService.getMenuTop
	 * @writeDay   : 2015. 4. 7. 오후 5:49:17
	 * @overridden : @see com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService#getMenuTop(com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public ArrayList<MenuMgmtVO> getMenuTop(MenuMgmtVO menuVo)  throws SQLException {
		// TODO Auto-generated method stub
		return menuMgmtMapper.getMenuTop(menuVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.MenuMgmt.service.Impl.MenuMgmtService.getMenuLeft
	 * @writeDay   : 2015. 4. 7. 오후 5:49:17
	 * @overridden : @see com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService#getMenuLeft(com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public ArrayList<MenuMgmtVO> getMenuLeft(MenuMgmtVO menuVo)  throws SQLException {
		// TODO Auto-generated method stub
		return menuMgmtMapper.getMenuLeft(menuVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.MenuMgmt.service.Impl.MenuMgmtService.getMenuGrpList
	 * @writeDay   : 2015. 4. 7. 오후 5:49:17
	 * @overridden : @see com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService#getMenuGrpList(com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public ArrayList<MenuMgmtVO> getMenuGrpList(MenuMgmtVO menuVo)  throws SQLException {
		// TODO Auto-generated method stub
		return menuMgmtMapper.getMenuGrpList(menuVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.MenuMgmt.service.Impl.MenuMgmtService.addMenuGrp
	 * @writeDay   : 2015. 4. 7. 오후 5:49:17
	 * @overridden : @see com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService#addMenuGrp(com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=false, propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int addMenuGrp(MenuMgmtVO menuVo) {
		// TODO Auto-generated method stub
		return menuMgmtMapper.addMenuGrp(menuVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.MenuMgmt.service.Impl.MenuMgmtService.setMenuGrp
	 * @writeDay   : 2015. 4. 7. 오후 5:49:17
	 * @overridden : @see com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService#setMenuGrp(com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=false, propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int setMenuGrp(MenuMgmtVO menuVo)  {
		int result = 0;
		
    	List<MenuMgmtVO> beforeMenuGrp = this.getMenuGrpListInModify(menuVo);
    	
    	List<MenuMgmtVO> menuGrpList = menuVo.getMenuGrpList();

        List<MenuMgmtVO> setMenuGrpList = new ArrayList<MenuMgmtVO>();

        if(menuGrpList != null){
        	for(int i = 0; i < menuGrpList.size() ; i++){
        		
        		menuGrpList.get(i).setRegUsrId(menuVo.getRegUsrId());
        		menuGrpList.get(i).setUsrGrpCd(menuVo.getUsrGrpCd());

        		if(menuGrpList.get(i).getDepth4Cd() != null && !"".equals(menuGrpList.get(i).getDepth4Cd())){
        			
        			setMenuGrpList = this.addMenuGrp(setMenuGrpList, menuGrpList.get(i), 1 , beforeMenuGrp);
        			setMenuGrpList = this.addMenuGrp(setMenuGrpList, menuGrpList.get(i), 2 , beforeMenuGrp);
        			setMenuGrpList = this.addMenuGrp(setMenuGrpList, menuGrpList.get(i), 3 , beforeMenuGrp);
        			setMenuGrpList = this.addMenuGrp(setMenuGrpList, menuGrpList.get(i), 4 , beforeMenuGrp);

        		}else if(menuGrpList.get(i).getDepth3Cd() != null && !"".equals(menuGrpList.get(i).getDepth3Cd())){

        			setMenuGrpList = this.addMenuGrp(setMenuGrpList, menuGrpList.get(i), 1 , beforeMenuGrp);
        			setMenuGrpList = this.addMenuGrp(setMenuGrpList, menuGrpList.get(i), 2 , beforeMenuGrp);
        			setMenuGrpList = this.addMenuGrp(setMenuGrpList, menuGrpList.get(i), 3 , beforeMenuGrp);
        			
        		}else if(menuGrpList.get(i).getDepth2Cd() != null && !"".equals(menuGrpList.get(i).getDepth2Cd())){
        			
        			setMenuGrpList = this.addMenuGrp(setMenuGrpList, menuGrpList.get(i), 1 , beforeMenuGrp);
        			setMenuGrpList = this.addMenuGrp(setMenuGrpList, menuGrpList.get(i), 2 , beforeMenuGrp);
        			
        		}else if(menuGrpList.get(i).getDepth1Cd() != null && !"".equals(menuGrpList.get(i).getDepth1Cd())){
        			
        			setMenuGrpList = this.addMenuGrp(setMenuGrpList, menuGrpList.get(i), 1 , beforeMenuGrp);
        			
        		}
        		
        	}
        	
        	lastMenuGrpCheck(setMenuGrpList, beforeMenuGrp);
        	
        	for(int i = 0; i < setMenuGrpList.size(); i++){
        		
        		if("U".equals(setMenuGrpList.get(i).getType())){
					setMenuGrp(setMenuGrpList.get(i));
				}else{
					addMenuGrp(setMenuGrpList.get(i));
				}
        	}
        }
        
        result = 1;
        
		return menuMgmtMapper.setMenuGrp(menuVo);
	}
	
	/** 세부 메뉴 권한 설정 시 사용하는 이 전 메뉴 권한 정보를 같은 DataSource 에서 가져옴.
	 * @param menuVO
	 * @return
	 * @throws Exception
	 */
	public List<MenuMgmtVO> getMenuGrpListInModify(MenuMgmtVO menuVO) {
   		return menuMgmtMapper.getMenuGrpList(menuVO);
	}

	
	public List<MenuMgmtVO> addMenuGrp(List<MenuMgmtVO> setMenuGrpList, MenuMgmtVO menuInfo, int depth, List<MenuMgmtVO> beforeMenuGrp){

		MenuMgmtVO menuGrp = new MenuMgmtVO();
		
		if(depth == 1)	{
			menuGrp.setMenuCd(menuInfo.getDepth1Cd());
		} else if(depth == 2) {
			menuGrp.setMenuCd(menuInfo.getDepth2Cd());
		} else if(depth == 3) {
			menuGrp.setMenuCd(menuInfo.getDepth3Cd());
		} else if(depth == 4) {
			menuGrp.setMenuCd(menuInfo.getDepth4Cd());
		} else {
			return setMenuGrpList;
		}
		
		boolean equalCheck = true;
		for(int i = 0; i < setMenuGrpList.size(); i++){
			if(menuGrp.getMenuCd().equals(setMenuGrpList.get(i).getMenuCd())){
				equalCheck = false;
				if(!"Y".equals(setMenuGrpList.get(i).getReadYn()) && "Y".equals(menuGrp.getReadYn())  ){
					setMenuGrpList.get(i).setReadYn("Y");
				}
				break;
			}
		}
		
		if(equalCheck){
			for(int i = 0; i < beforeMenuGrp.size(); i++){
				if (menuGrp.getMenuCd().equals(beforeMenuGrp.get(i).getMenuCd()) ){

					menuGrp.setRegUsrId(menuInfo.getRegUsrId());
					menuGrp.setUsrGrpCd(menuInfo.getUsrGrpCd());
					menuGrp.setType(beforeMenuGrp.get(i).getType());
					
					menuGrp.setDownCnt(beforeMenuGrp.get(i).getDownCnt());
					
					if(beforeMenuGrp.get(i).getDownCnt() > 0){
						menuGrp.setReadYn(menuInfo.getReadYn());
						menuGrp.setCreYn("N");
						menuGrp.setUpdateYn("N");
						menuGrp.setDelYn("N");
					}else{
						menuGrp.setReadYn(menuInfo.getReadYn());
						menuGrp.setCreYn(menuInfo.getCreYn());
						menuGrp.setUpdateYn(menuInfo.getUpdateYn());
						menuGrp.setDelYn(menuInfo.getDelYn());
					}

					if("U".equals(menuGrp.getType())){
						if( !menuGrp.getReadYn().equals(beforeMenuGrp.get(i).getReadYn()) 
								|| !menuGrp.getCreYn().equals(beforeMenuGrp.get(i).getCreYn())
								|| !menuGrp.getUpdateYn().equals(beforeMenuGrp.get(i).getUpdateYn())
								|| !menuGrp.getDelYn().equals(beforeMenuGrp.get(i).getDelYn())
								){
							setMenuGrpList.add(menuGrp);
						}
					}else{
						setMenuGrpList.add(menuGrp);
					}

					break;
					
				}
				
			}
		}
				
		return setMenuGrpList;
	}
	
	public List<MenuMgmtVO> lastMenuGrpCheck(List<MenuMgmtVO> setMenuGrpList, List<MenuMgmtVO> beforeMenuGrp){
		
		for(int i = setMenuGrpList.size()-1; i >= 0; i--){
			
			boolean isReadYn = false;
			
			if(setMenuGrpList.get(i).getDownCnt() > 0 && "N".equals(setMenuGrpList.get(i).getReadYn())){
				for(int j = beforeMenuGrp.size()-1; j >= 0 ; j--){
					if( setMenuGrpList.get(i).getMenuCd().equals(beforeMenuGrp.get(j).getUpMenu()) ){
						for(int k = setMenuGrpList.size()-1; k >= 0; k--){
							if(beforeMenuGrp.get(j).getMenuCd().equals(setMenuGrpList.get(k).getMenuCd()) ){
								if( "Y".equals(setMenuGrpList.get(k).getReadYn()) ){
									isReadYn = true;
									break;
								}else{
									isReadYn = false;
									beforeMenuGrp.get(j).setReadYn("N");
								}
							}else if("Y".equals(beforeMenuGrp.get(j).getReadYn())){
								isReadYn = true;
							}
						}
						if(isReadYn) break;
					}
				}
				if(isReadYn){
					setMenuGrpList.get(i).setReadYn("Y");
				}
			}
		}
		
		return setMenuGrpList;
	}
	
	/**
	 * @location   : com.dkitec.barocle.admin.system.MenuMgmt.service.Impl.MenuMgmtService.delMenuGrp
	 * @writeDay   : 2015. 4. 7. 오후 5:49:17
	 * @overridden : @see com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService#delMenuGrp(com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=false, propagation=Propagation.REQUIRED, rollbackFor={SQLException.class, Exception.class})
	@DataSource(DataSourceType.MASTER)
	public int delMenuGrp(MenuMgmtVO menuVo)  throws SQLException {
		// TODO Auto-generated method stub
		return menuMgmtMapper.delMenuGrp(menuVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.MenuMgmt.service.Impl.MenuMgmtService.getMenuGrpUrlNotLogin
	 * @writeDay   : 2015. 4. 7. 오후 5:49:17
	 * @overridden : @see com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService#getMenuGrpUrlNotLogin(com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuUrlVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getMenuGrpUrlNotLogin(MenuUrlVO menuUrlVO)  throws SQLException {
		// TODO Auto-generated method stub
		return menuMgmtMapper.getMenuGrpUrlNotLogin(menuUrlVO);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.MenuMgmt.service.Impl.MenuMgmtService.getMenuGrpUrlCheck
	 * @writeDay   : 2015. 4. 7. 오후 5:49:17
	 * @overridden : @see com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService#getMenuGrpUrlCheck(com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public MenuMgmtVO getMenuGrpUrlCheck(MenuUrlVO menuUrlVO)  throws SQLException {
		// TODO Auto-generated method stub
		return menuMgmtMapper.getMenuGrpUrlCheck(menuUrlVO);
	}

 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int addMenuOpenHist(HttpServletRequest request) {
		
		if ( "/error.do".equals(request.getRequestURI().toString())){
			return 0;
		}
			
		
		String log = HttpUtil.getRequestUriAndParamLog( request);
		
		if ( "".equals(log) || log.length() <= 1 )  return 0 ;
		if( log.contains( "commonCode"  ) ) return 0 ;
		String[] logDiv = log.split("\\?");
		if ( logDiv.length <= 1 )  return 0 ;
		
		MenuOpenHistVO menuOpenHistVO = new MenuOpenHistVO();
		
		try {
			UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");

			menuOpenHistVO.setADMIN_ID(userSessionVO.getUsrId());
			menuOpenHistVO.setADMIN_IP(userSessionVO.getUsrIp());
			if(log.length()>400){
				menuOpenHistVO.setMENU_DESC( log.substring(0, 400) );
			} else {
				menuOpenHistVO.setMENU_DESC( log );
			}
			
		} catch (Exception e) {
			return 0;
		}
		
		return menuMgmtMapper.addMenuOpenHist(menuOpenHistVO);
	}	
	
}
