package com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.vo.DistCoWorkDtlVO;
import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.vo.DistCoWorkVO;
import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.vo.DistWorkVO;
import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.vo.DistributionDiaryVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("distributionDiaryMapper")
public interface DistributionDiaryMapper {                                     
	
	List<DistributionDiaryVO> getDistInfo(DistributionDiaryVO distributionDiaryVo);
	
	List<DistCoWorkVO> getDistMemberInfo(DistCoWorkVO vo);
	List<DistCoWorkVO> getCoworkDtlList(DistCoWorkVO vo);

	String getModifyDate(DistributionDiaryVO distributionDiaryVo);
	
	List<DistributionDiaryVO> getDairyReport(DistributionDiaryVO distributionDiaryVo);
	
	
	List<DistributionDiaryVO> getStaMemList(DistributionDiaryVO distributionDiaryVo);
	
	List<DistributionDiaryVO> getDairyVcle(DistributionDiaryVO distributionDiaryVo) ;
	
	List<DistributionDiaryVO> getStaCenterList(DistributionDiaryVO distributionDiaryVo) ;
	
	
	
	
	
	
	int updateEnfrc(DistributionDiaryVO vo);
	int updateNeglect(DistributionDiaryVO vo);
	int updateFault(DistributionDiaryVO vo);
	int insertDairyReport(DistributionDiaryVO vo);
	
	int delTbOprBikeLost(DistributionDiaryVO vo);
	int delTbOprBike016(DistributionDiaryVO vo);

	
	int getInsertEtcWorkSeq(DistWorkVO vo);
	
	int insertTbStaRelocateeHistHH(DistWorkVO vo);
	
	
	DistWorkVO getMaintenWrkerAttD(DistWorkVO distWorkVO);

	void updateDistWork(DistWorkVO distWorkVO);

	void insertDistWork(DistWorkVO distWorkVO);

	
	void updateDistWorkEtcBike(DistWorkVO distWorkVO);

	void insertDistWorkEtcBike(DistWorkVO distWorkVO);
	void deleteDistWorkEtcBike(DistWorkVO distWorkVO);

	
	
	void updateDistWorkAprvd(DistWorkVO distWorkVO);

	String getCenterNameWithCenterCode(DistWorkVO distWorkVO);

	String getAdminGrpName(DistWorkVO distWorkVO);

	String getInsertWrkCenterId(DistWorkVO distWorkVO);

	int getMaintenWrkerAttCnt(DistWorkVO distWorkVO);

	List<DistWorkVO> getMaintenWrkerAtt(DistWorkVO distWorkVO);

	String getInsertWrkSeq(DistWorkVO distWorkVO);

	void updateDistWorkDtl(DistWorkVO distWorkVO);

	String checkDistWork(DistWorkVO distWorkVO);


	void insertDistWorkDtl(DistWorkVO distWorkVO);
	
	
	List<DistCoWorkVO> getDistCoWork(DistCoWorkVO vo);
	void insertDistCoWork(DistCoWorkVO vo);
	void updateDistCoWork(DistCoWorkVO vo);
	
	void deleteDistCoWork(DistCoWorkDtlVO vo);
	void deleteDistCoWorkDtl(DistCoWorkDtlVO vo);
	
	
	void insertDistCoWorkDtl(DistCoWorkDtlVO vo);
	void updateDistCoWorkCnt(DistCoWorkDtlVO vo);
	
	
	List<DistCoWorkVO> getCoworkList(DistCoWorkVO vo) ;
	
	int getRoundMaintenWrkerAttCnt(DistWorkVO distWorkVO);
	List<DistWorkVO> getRoundMaintenWrkerAtt(DistWorkVO distWorkVO);
}
