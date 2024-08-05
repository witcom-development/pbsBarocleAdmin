/*
 * @Package Name : com.dkitec.barocle.admin.manage.DeviceMgmt.service.serviceImpl
 * @파일명          : DeviceMgmtServiceImpl.java
 * @작성일          : 2015. 4. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 15.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.maintenance.inspect.bike.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.common.service.CommonPopupMapper;
import com.dkitec.barocle.admin.common.vo.RegularChkVO;
import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;
import com.dkitec.barocle.admin.customer.opinionboard.vo.OpinionBoardVO;
import com.dkitec.barocle.admin.maintenance.inspect.bike.service.InspectBikeMapper;
import com.dkitec.barocle.admin.maintenance.inspect.bike.service.InspectBikeService;
import com.dkitec.barocle.admin.maintenance.inspect.bike.vo.InspectBikeVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper;
import com.dkitec.barocle.admin.manage.deviceMgmt.terminal.vo.TerminalVO;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="inspectBikeService")
public class InspectBikeServiceImpl extends EgovAbstractServiceImpl implements InspectBikeService {

	@Autowired private InspectBikeMapper inspectBikeMapper;
	@Autowired private CommonPopupMapper commonPopupMapper;
	@Autowired private TerminalMapper terminalMapper;

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<InspectBikeVO> getInspectBikeList(InspectBikeVO inspectBikeVo) {
		// TODO Auto-generated method stub
		return inspectBikeMapper.getInspectBikeList(inspectBikeVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getInspectBikeListCount(InspectBikeVO inspectBikeVo) {
		// TODO Auto-generated method stub
		return inspectBikeMapper.getInspectBikeListCount(inspectBikeVo);
	}

	/*
	 * 자전거 장애건_현황 _cms_20161123
	 */

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getObstacleCnt() throws SQLException {
		// TODO Auto-generated method stub
		return inspectBikeMapper.getObstacleCnt();
	}

	/*
	 * 자전거 장애건_현황 _리스트_cms_20161123
	 */
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<InspectBikeVO> getObstacleList(InspectBikeVO inspectBikeVo) {
		// TODO Auto-generated method stub
		return inspectBikeMapper.getObstacleList(inspectBikeVo);
	}
	
	/*
	 * 자전거 장애건_주기 조회_cms_20161124
	 */
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public CategoryVO getObstacleTime() {
		// TODO Auto-generated method stub
		return inspectBikeMapper.getObstacleTime();
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int insertTeamInfo(InspectBikeVO inspectBikeVo) {
		return inspectBikeMapper.insertTeamInfo(inspectBikeVo);
	}

}
