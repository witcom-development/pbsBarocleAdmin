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
package com.dkitec.barocle.admin.maintenance.repair.division.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dkitec.barocle.admin.common.service.CommonPopupMapper;
import com.dkitec.barocle.admin.maintenance.repair.division.service.RepairDivisionMapper;
import com.dkitec.barocle.admin.maintenance.repair.division.service.RepairDivisionService;
import com.dkitec.barocle.admin.maintenance.repair.division.vo.RepairDivisionVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="repairDivisionService")
public class RepairDivisionServiceImpl extends EgovAbstractServiceImpl implements RepairDivisionService {

	@Autowired private RepairDivisionMapper repairDivisionMapper;
	@Autowired private CommonPopupMapper commonPopupMapper;
	@Autowired private TerminalMapper terminalMapper;

	/* 수리구분코드수 조회 */
	@Override
	@DataSource(DataSourceType.SLAVE01)
	public int getCodeListCnt(RepairDivisionVO repairDivisionVo) {
		// TODO Auto-generated method stubㄴ
		return repairDivisionMapper.getCodeListCnt(repairDivisionVo);
	}

	/* 수리구분코드 조회 */
	@Override
	@DataSource(DataSourceType.SLAVE01)
	public List<RepairDivisionVO> getCodeList(RepairDivisionVO repairDivisionVo) {
		// TODO Auto-generated method stub
		return repairDivisionMapper.getCodeList(repairDivisionVo);
	}

	/* 수리구분코드 수정list 목록 */
	@Override
	@DataSource(DataSourceType.SLAVE01)
	public RepairDivisionVO getDivisionUdtList(RepairDivisionVO repairDivisionVo) {
		// TODO Auto-generated method stub
		return repairDivisionMapper.getDivisionUdtList(repairDivisionVo);
	}
	
	/* 수리구분코드 수정 */
	@Override
	@DataSource(DataSourceType.SLAVE01)
	public int getDivisionUdt(RepairDivisionVO repairDivisionVo) {
		// TODO Auto-generated method stub
		int returnCnt = 0;
		
		// 코드명 체크
		if(!repairDivisionVo.getCodeNm1().equals(repairDivisionVo.getChgCodeNm())){
			returnCnt = repairDivisionMapper.getDivisionCodeNmCnt(repairDivisionVo);
			if(returnCnt > 0){
				return returnCnt;
			}
		}
		
		//코드명 count
		
		RepairDivisionVO divisionVoCnt = repairDivisionMapper.getDivisionCodeCnt(repairDivisionVo);
		
		//공통 코드명 영문 추가시/수정시
		/*if("Y".equals(divisionVoCnt.getCnt1())){
			repairDivisionMapper.getDivisionCode2Udt(repairDivisionVo);
		}else{
			repairDivisionMapper.getDivisionCode2Add(repairDivisionVo);
		}*/
		
		//공통 코드명 일어 추가시/수정시
		/*if("Y".equals(divisionVoCnt.getCnt2())){
			repairDivisionMapper.getDivisionCode3Udt(repairDivisionVo);
		}else{
			repairDivisionMapper.getDivisionCode3Add(repairDivisionVo);
		}*/
		
		//공통 코드명 중국어 추가시/수정시
		/*if("Y".equals(divisionVoCnt.getCnt3())){
			repairDivisionMapper.getDivisionCode4Udt(repairDivisionVo);
		}else{
			repairDivisionMapper.getDivisionCode4Add(repairDivisionVo);
		}*/
		
		repairDivisionMapper.getDivisionUdt(repairDivisionVo);
		repairDivisionMapper.getDivisionUdt2(repairDivisionVo);
		
		return returnCnt;
	}

	@Override
	@DataSource(DataSourceType.SLAVE01)
	public int getDivisionAdd(RepairDivisionVO repairDivisionVo) {
		// TODO Auto-generated method stub
		
		int returnCnt = 0;
		
		//시퀀스값 가져오기
		String seqNo = repairDivisionMapper.getDivisionSeqNo(repairDivisionVo);
		
		// 코드명 체크
		returnCnt = repairDivisionMapper.getDivisionCodeNmCnt(repairDivisionVo);
		if(returnCnt > 0){
			return returnCnt;
		}
		
		repairDivisionVo.setComCd(seqNo);

		//공통 코드명 영문 추가
		//repairDivisionMapper.getDivisionCode2Add(repairDivisionVo);
		//공통 코드명 일어 추가
		//repairDivisionMapper.getDivisionCode3Add(repairDivisionVo);
		//공통 코드명 중국어 추가
		//repairDivisionMapper.getDivisionCode4Add(repairDivisionVo);
		
		repairDivisionMapper.getDivisionAdd(repairDivisionVo);
		repairDivisionMapper.getDivisionAdd2(repairDivisionVo);
		
		return returnCnt;
	}
	
	
	@Override
	@DataSource(DataSourceType.SLAVE01)
	public void getDivisionDel(RepairDivisionVO repairDivisionVo) {
		// TODO Auto-generated method stub
		
		repairDivisionMapper.getDivisionDel(repairDivisionVo);
		repairDivisionMapper.getDivisionDel2(repairDivisionVo);
	}
	

}
