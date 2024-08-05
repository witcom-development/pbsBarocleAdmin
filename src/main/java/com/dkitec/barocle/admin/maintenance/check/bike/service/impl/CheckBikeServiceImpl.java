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
package com.dkitec.barocle.admin.maintenance.check.bike.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.common.service.CommonPopupMapper;
import com.dkitec.barocle.admin.maintenance.check.bike.service.CheckBikeMapper;
import com.dkitec.barocle.admin.maintenance.check.bike.service.CheckBikeService;
import com.dkitec.barocle.admin.maintenance.check.bike.vo.CheckBikeVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="checkBikeService")
public class CheckBikeServiceImpl extends EgovAbstractServiceImpl implements CheckBikeService {

	@Autowired private CheckBikeMapper checkBikeMapper;
	@Autowired private CommonPopupMapper commonPopupMapper;
	@Autowired private TerminalMapper terminalMapper;

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<CheckBikeVO> getCheckBikeList(CheckBikeVO checkBikeVo) {
		// TODO Auto-generated method stub
		return checkBikeMapper.getCheckBikeList(checkBikeVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getCheckBikeListCount(CheckBikeVO checkBikeVo) {
		// TODO Auto-generated method stub
		return checkBikeMapper.getCheckBikeListCount(checkBikeVo);
	}

	@Override
	@Transactional(readOnly= false)
	@DataSource(DataSourceType.MASTER)
	public int exeBikeSelectCheck(CheckBikeVO checkBikeVo) {
		// TODO Auto-generated method stub
		int result = 0;
		String[] faultSeqArr = checkBikeVo.getFaultSeq().split(",");
		for (int i = 0; i < faultSeqArr.length; i++) {
			checkBikeVo.setFaultSeq(faultSeqArr[i]);
			result = checkBikeMapper.exeBikeCheck(checkBikeVo);
		}
		return result;
	}

	@Override
	@Transactional(readOnly= false)
	@DataSource(DataSourceType.MASTER)
	public int exeBikeAllCheck(CheckBikeVO checkBikeVo, List<CheckBikeVO> resultList) {
		// TODO Auto-generated method stub
		int result = 0;
		
		for (int i = 0; i < resultList.size(); i++) {
			checkBikeVo.setFaultSeq(resultList.get(i).getFaultSeq());
			result = checkBikeMapper.exeBikeCheck(checkBikeVo);
		}
		return result;
	}
}
