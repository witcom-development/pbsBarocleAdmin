package com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.vo.DistCoWorkDtlVO;
import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.vo.DistCoWorkVO;
import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.vo.DistWorkVO;
import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.vo.DistributionDiaryVO;

public interface DistributionDiaryService {

	List<DistributionDiaryVO> getDistInfo(DistributionDiaryVO distributionDiaryVo);

	List<DistCoWorkVO> getDistMemberInfo(DistCoWorkVO vo);
	
	String getModifyDate(DistributionDiaryVO distributionDiaryVo);
	
	List<DistributionDiaryVO> getDairyReport(DistributionDiaryVO distributionDiaryVo) ;
	
	List<DistributionDiaryVO> getStaMemList(DistributionDiaryVO distributionDiaryVo) ;
	
	List<DistCoWorkVO> getCoworkDtlList(DistCoWorkVO vo);
	
	String setDaiaryBikeStatus(DistributionDiaryVO vo);
	
	List<DistributionDiaryVO> getDairyVcle(DistributionDiaryVO distributionDiaryVo) ;
	
	List<DistributionDiaryVO> getStaCenterList(DistributionDiaryVO distributionDiaryVo) ;
	
	DistWorkVO getMaintenWrkerAttD(DistWorkVO distWorkVO);

	void updateDistWork(DistWorkVO distWorkVO);

	void insertDistWork(DistWorkVO distWorkVO);

	void updateDistWorkAprvd(DistWorkVO distWorkVO);

	String getCenterNameWithCenterCode(DistWorkVO distWorkVO);

	String getAdminGrpName(DistWorkVO distWorkVO);

	String getInsertWrkCenterId(DistWorkVO distWorkVO);

	int getMaintenWrkerAttCnt(DistWorkVO distWorkVO);

	List<DistWorkVO> getMaintenWrkerAtt(DistWorkVO distWorkVO);

	List<DistCoWorkVO> getDistCoWork(DistCoWorkVO vo);
	void insertDistCoWork(DistCoWorkVO vo);
	void updateDistCoWork(DistCoWorkVO vo);
	void deleteDistCoWork(DistCoWorkDtlVO vo);
	
	void insertDistCoWorkDtl(DistCoWorkDtlVO vo);
	void deleteDistCoWorkDtl(DistCoWorkDtlVO vo);
	
	List<DistCoWorkVO> getCoworkList(DistCoWorkVO vo) ;
	
	
	// 2022-01-06 순회정비반 추가
	int getRoundMaintenWrkerAttCnt(DistWorkVO distWorkVO);

	List<DistWorkVO> getRoundMaintenWrkerAtt(DistWorkVO distWorkVO);
}
