package com.dkitec.barocle.admin.maintenance.repair.division.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.repair.division.vo.RepairDivisionVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("repairDivisionMapper")
public interface RepairDivisionMapper {

	int getCodeListCnt(RepairDivisionVO repairDivisionVo);					//수리구분코드수 조회

	List<RepairDivisionVO> getCodeList(RepairDivisionVO repairDivisionVo); 	//수리구분코드 조회

	RepairDivisionVO getDivisionUdtList(RepairDivisionVO repairDivisionVo); //수리구분코드 수정

	int getDivisionCodeNmCnt(RepairDivisionVO repairDivisionVo);			//코드명 체크

	void getDivisionCode2Add(RepairDivisionVO repairDivisionVo);			//공통 코드명 영문 등록

	void getDivisionCode2Udt(RepairDivisionVO repairDivisionVo);			//공통 코드명 영문 수정

	void getDivisionCode3Add(RepairDivisionVO repairDivisionVo);			//공통 코드명 일어 등록

	void getDivisionCode3Udt(RepairDivisionVO repairDivisionVo);			//공통 코드명 일어 수정

	void getDivisionCode4Add(RepairDivisionVO repairDivisionVo);			//공통 코드명 중국어 등록

	void getDivisionCode4Udt(RepairDivisionVO repairDivisionVo);			//공통 코드명 중국어 수정

	void getDivisionUdt(RepairDivisionVO repairDivisionVo);					//수리구분 수정.

	void getDivisionUdt2(RepairDivisionVO repairDivisionVo);				//수리구분 다국어 수정

	RepairDivisionVO getDivisionCodeCnt(RepairDivisionVO repairDivisionVo);	//코드명(영문/일어/중국어) 조회

	String getDivisionSeqNo(RepairDivisionVO repairDivisionVo);				//시퀀스값 가져오기(max)

	void getDivisionAdd(RepairDivisionVO repairDivisionVo);					//공통코드명 다국어(한글) 등록

	void getDivisionAdd2(RepairDivisionVO repairDivisionVo);				//수리구분 등록

	void getDivisionDel(RepairDivisionVO repairDivisionVo);					//수리구분(다국어) 삭제

	void getDivisionDel2(RepairDivisionVO repairDivisionVo);				//수리구분 삭제

}
