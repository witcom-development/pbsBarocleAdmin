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
package com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.serviceImpl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeMapper;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper;
import com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalService;
import com.dkitec.barocle.admin.manage.deviceMgmt.terminal.vo.TerminalVO;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @파일명          : DeviceMgmtServiceImpl.java
 * @작성일          : 2015. 4. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 15.   |   ymshin   |  최초작성
 */
@Service(value = "terminalService")
public class TerminalServiceImpl extends EgovAbstractServiceImpl implements TerminalService {

	@Autowired private TerminalMapper terminalMapper;
	@Autowired private BikeMapper bikeMapper;
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<BikeVO> getTerminalList(TerminalVO terminalVo) {
		// TODO Auto-generated method stub
		return terminalMapper.getTerminalList(terminalVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getTerminalListCount(TerminalVO terminalVo) {
		// TODO Auto-generated method stub
		return terminalMapper.getTerminalCount(terminalVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public TerminalVO getTerminalInfo(TerminalVO terminalVo) {
		// TODO Auto-generated method stub
		return terminalMapper.getTerminalInfo(terminalVo);
	}

	@Override
	@Transactional(readOnly=false, propagation = Propagation.REQUIRED, rollbackFor = {Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int addNewTerminalData(TerminalVO terminalVo, String adminId) {
		int result = 0;
		terminalVo.setLocateAdminId(adminId);
		//terminalVo.setDeviceModlCd(IConstants.DEVICE_MODEL_CD_TERMINAL);		// 단말기 구분이 추가됨으로 고정으로 넣지 않음
		result = terminalMapper.insertDeviceReg(terminalVo);
		result = terminalMapper.addTerminalLocateHist(terminalVo);
		if(terminalVo.getLocateClsCd().equals("B")) {
			 result = setTerminalAddBike(terminalVo, adminId);
		}
		
		return result;
	}
	@Override
	@Transactional(readOnly=false, propagation = Propagation.REQUIRED, rollbackFor = {Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int setTerminalData(TerminalVO terminalVo, String adminId) {
		int result = 0;
		
		//TODO: 로그인한 관리자 id로 셋팅.
		terminalVo.setLocateAdminId(adminId);
		TerminalVO info = terminalMapper.getOldTerminalInfo(terminalVo.getDeviceId());
		if(!info.getLocateClsCd().equals(terminalVo.getLocateClsCd())) {
			 result = terminalMapper.setTerminalLocateInfo(terminalVo);
			 if(terminalVo.getLocateClsCd().equals("C")) {
				 result = terminalMapper.setTRemoveFromBike(terminalVo);
			 }else {
				 result = setTerminalAddBike(terminalVo, adminId);
			 }
			 result = terminalMapper.addTerminalLocateHist(terminalVo);
		} 
		result = terminalMapper.setTerminalData(terminalVo);
		
		return result;
	}
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<TerminalVO> getTerminalAndBikeHistory(TerminalVO terminalVo) {
		// TODO Auto-generated method stub
		return terminalMapper.getTerminalLocateHistory(terminalVo);
	}
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean isChkIdDup(TerminalVO terminalVo) {
		// TODO Auto-generated method stub
		boolean bool = terminalMapper.isChkIdDup(terminalVo) > 0 ? true: false;
		return bool;
	}
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getTerminalAndBikeHistoryCount(TerminalVO terminalVo) {
		// TODO Auto-generated method stub
		return terminalMapper.getTerminalAndBikeHistoryCount(terminalVo);
	}
	/**
	 * @location   : com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.serviceImpl.TerminalService.getFirmwareSeq
	 * @writeDay   : 2015. 5. 27. 오후 2:46:59
	 * @overridden : @see com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalService#getFirmwareSeq(com.dkitec.barocle.admin.manage.deviceMgmt.terminal.vo.TerminalVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public String getFirmwareSeq(TerminalVO terminalVo) {
		// TODO Auto-generated method stub
		return terminalMapper.getFirmwareSeq(terminalVo);
	}
	private int setTerminalAddBike(TerminalVO terminalVo , String adminId) {
		BikeVO bikeVo = new BikeVO();
		bikeVo.setBikeId(terminalVo.getLocateId());
		bikeVo.setTerminalId(terminalVo.getDeviceId());
		bikeVo.setAdminId(adminId);
		return bikeMapper.setBikeDevice(bikeVo);
	}

}
