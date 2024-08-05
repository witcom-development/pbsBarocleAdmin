package com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.service.impl;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.service.DistributionDiaryMapper;
import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.service.DistributionDiaryService;
import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.vo.DistCoWorkDtlVO;
import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.vo.DistCoWorkVO;
import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.vo.DistWorkVO;
import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.vo.DistributionDiaryVO;
import com.dkitec.barocle.admin.status.rentStatus.service.RentStatusService;
import com.dkitec.barocle.admin.status.rentStatus.vo.BikeRentalVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.barocle.util.webutil.DateUtil;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="distributionDiaryService")
public class DistributionDiaryServiceImpl extends EgovAbstractServiceImpl implements DistributionDiaryService {

	@Autowired private DistributionDiaryMapper distributionDiaryMapper;

	@Resource(name="rentStatusService") private RentStatusService rentStatusService;

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)	
	public List<DistributionDiaryVO> getDistInfo(DistributionDiaryVO distributionDiaryVo) {
		return distributionDiaryMapper.getDistInfo(distributionDiaryVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)	
	public List<DistCoWorkVO> getDistMemberInfo(DistCoWorkVO vo) {
		return distributionDiaryMapper.getDistMemberInfo(vo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)	
	public List<DistCoWorkVO> getCoworkDtlList(DistCoWorkVO vo) {
		return distributionDiaryMapper.getCoworkDtlList(vo);
	}
	
 
	@Override 
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)		
	public String getModifyDate(DistributionDiaryVO distributionDiaryVo) {
		return distributionDiaryMapper.getModifyDate(distributionDiaryVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)	
	public List<DistributionDiaryVO> getDairyReport(DistributionDiaryVO distributionDiaryVo) {
		return distributionDiaryMapper.getDairyReport(distributionDiaryVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)	
	public List<DistributionDiaryVO> getStaMemList(DistributionDiaryVO distributionDiaryVo) {
		return distributionDiaryMapper.getStaMemList(distributionDiaryVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.STATICS)	
	public List<DistributionDiaryVO> getStaCenterList(DistributionDiaryVO distributionDiaryVo) {
		return distributionDiaryMapper.getStaCenterList(distributionDiaryVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)	
	public List<DistributionDiaryVO> getDairyVcle(DistributionDiaryVO distributionDiaryVo) {
		return distributionDiaryMapper.getDairyVcle(distributionDiaryVo);
	}
	
	@Override
	@Transactional(readOnly=false,propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)	
	public String setDaiaryBikeStatus(DistributionDiaryVO vo) {
		
		StringBuilder sb = new StringBuilder();
		int enfrcCnt   = 0;
		int neglectCnt = 0;
		int faultCnt = 0;
		int lostCnt = 0;
		int bks016Cnt = 0;
		
		// 강반건 조회 완료코드(1:재배치 2:회수후재배치 3:센터입고 4:정상대기중 5:자전거 없음 6:대여중 7:자동조치)
		// vo.setComptCd("5");
		//작업구분 DAR_TP_003 ㅣ : 없음
		// vo.setWorkClassifi("DAR_TP_003");
		// 고장처리건수
		faultCnt = distributionDiaryMapper.updateFault(vo);
		
		switch ( vo.getWorkClassifi() ) {
		// 이동
		case "DAR_TP_001" :
			// 배치이동
			//bikeVO.setBikeStatusCd("BKS_011");
			// exeQrMoveProc 에서 호출
			vo.setComptCd("1");	// 재배치(강반)
			
			break;
		// 재배치완료	
		case "DAR_TP_002" :
			// exeQRBikeRelocate 에서 호출
			vo.setComptCd("1");	// 재배치(강반)
			break;
		// 자전거없음	
		case "DAR_TP_003" :
			// 대여중 : 분실
			if( "BKS_010".equals( vo.getCurrBikeStatuCd())
					|| "BKS_012".equals( vo.getCurrBikeStatuCd())
					) {
				// bikeVO.setBikeStatus("BKS_007");	
			// 그 이외 
			} else {
				
				vo.setComptCd("5");	// 자전거없음(강반)
				
				// 도난추정
				BikeRentalVO rentalVo = new BikeRentalVO();
				rentalVo.setRentBikeId(vo.getBikeId());
				rentalVo.setAdminId(vo.getAdminId());
				rentalVo.setReportNm(vo.getAdminName());
				rentalVo.setRtrvlDate(DateUtil.getSystemDate("yyyy-MM-dd"));
				rentalVo.setReportCd("3");	//분배원처리
				rentStatusService.addBikeRobbedHistory(rentalVo);
			}
			distributionDiaryMapper.insertDairyReport(vo);
			break;	
		// 	경정비
		case "DAR_TP_004" :
			distributionDiaryMapper.insertDairyReport(vo);
			break;
		// 입고	
		case "DAR_TP_005" :
			// bikeVO.setBikeStatus("BKS_005");
			vo.setComptCd("3");	// 센터입고(강반)
			distributionDiaryMapper.insertDairyReport(vo);
			break;	
		}
		// 강반건수
		enfrcCnt = distributionDiaryMapper.updateEnfrc(vo);
		
		// 방치신고건수
		neglectCnt = distributionDiaryMapper.updateNeglect(vo);
		
		// 강반처리
		if( enfrcCnt   > 0 ) {
			vo.setWorkClassifi("DAR_TP_006");
			distributionDiaryMapper.insertDairyReport(vo);
		}
		
		// 방치처리
		if( neglectCnt > 0 ) {
			vo.setWorkClassifi("DAR_TP_007");
			distributionDiaryMapper.insertDairyReport(vo);
		}
		
		// 고장처리
		if( faultCnt   > 0 ) {
			vo.setWorkClassifi("DAR_TP_008");
			distributionDiaryMapper.insertDairyReport(vo);
		}
		
        // TODO 도난추정, 회수처리
		if ( "yang1004".equals(vo.getAdminId())) {
			// 자전거 없음 제외
			if ( ! "DAR_TP_002".equals(vo.getWorkClassifi()) 
					&&  ! "DAR_TP_003".equals(vo.getWorkClassifi())
					) {
				
				// 분실, 도난추정건일 경우
				if( "BKS_007".equals(vo.getCurrBikeStatuCd())
						|| "BKS_016".equals(vo.getCurrBikeStatuCd())) {
					// 회수이력 등록
					BikeRentalVO rentalVo = new BikeRentalVO();
					rentalVo.setAdminId(vo.getAdminId());
					rentalVo.setRentBikeId(vo.getBikeId());
					rentalVo.setRtrvlDate( DateUtil.getSystemDate("yyyy-MM-dd") );		// 회수일자
					
					int seq = rentStatusService.addBikeRtrvlHistory(rentalVo);
				}
				
				// 분실
				lostCnt = distributionDiaryMapper.delTbOprBikeLost(vo);
				 
				// 도난추정 해제 TB_OPR_BIKE_ROB
				bks016Cnt = distributionDiaryMapper.delTbOprBike016(vo);
				
				if( lostCnt   > 0 ) {
					vo.setWorkClassifi("DAR_TP_009");
					distributionDiaryMapper.insertDairyReport(vo);
				}
				 
				if( bks016Cnt   > 0 ) {
					vo.setWorkClassifi("DAR_TP_010");
					distributionDiaryMapper.insertDairyReport(vo);
				}
			}	
		}
				
		
		if( enfrcCnt   > 0 ) sb.append( "강반 : " + enfrcCnt   +" \r\n" );
		if( neglectCnt > 0 ) sb.append( "방치 : " + neglectCnt +" \r\n" );
		if( faultCnt   > 0 ) sb.append( "고장 : " + faultCnt +" \r\n" );
		if( lostCnt   > 0 ) sb.append( "분실 : " + lostCnt +" \r\n" );
		
		return sb.toString();
	}
	
	@Override
	@Transactional(readOnly=false,propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public void insertDistWork(DistWorkVO distWorkVO) {// 분배원 근태 입력
		
			distWorkVO.setCenterId(getInsertWrkCenterId(distWorkVO));
			
			String workSeq = checkDistWork(distWorkVO);
			
			//등록으로 들어왔지만 request가 두번 들어왔다던지 하는 예외상황으로
			//이미 등록 되어있는지 확인하여 등록되어있다면 수정처리
			if(workSeq != null){
				
				updateDistWork(distWorkVO);
				
			}else if(workSeq == null){
				
				distributionDiaryMapper.insertDistWork(distWorkVO);
				distributionDiaryMapper.insertDistWorkDtl(distWorkVO);
				
				if ( ( distWorkVO.getMoveBikeCd() != null && !"".equals(distWorkVO.getMoveBikeCd()  )  )
						|| 
						( distWorkVO.getRelocateBikeCd() != null &&  !"".equals(distWorkVO.getRelocateBikeCd()  )   )
						) {	
					
					if ( distWorkVO.getMoveBikeCnt() == null ) distWorkVO.setMoveBikeCnt("0");
					if ( distWorkVO.getRelocateBikeCnt() == null ) distWorkVO.setRelocateBikeCnt("0");
					
					distributionDiaryMapper.insertDistWorkEtcBike(distWorkVO);
				} 
					
			}
	}
	

	@Override
	@Transactional(readOnly=false,propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public void updateDistWorkAprvd(DistWorkVO distWorkVO) {//승인여부 수정
		
		if(distWorkVO.getApprovedArr() != null){
			
			int cnt = distWorkVO.getApprovedArr().length;
			
			for(int i = 0; i<cnt; i++){
				
				DistWorkVO rVO = new DistWorkVO();
				
				String workSeq = distWorkVO.getWorkSeqArr()[i];
				String approved = distWorkVO.getApprovedArr()[i];
				String approverId = distWorkVO.getApproverId();
				
				rVO.setWorkSeq(workSeq);
				rVO.setApproved(approved);
				rVO.setApproverId(approverId);
				
				distributionDiaryMapper.updateDistWorkAprvd(rVO);
				
				// 과거건 입력
				distributionDiaryMapper.insertTbStaRelocateeHistHH(rVO);
				
			}
			
		}
		
	}

	@Override
	@Transactional(readOnly=false,propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)	
	public void updateDistWork(DistWorkVO distWorkVO) {//근태입력 수정
		
		if( distWorkVO.getWorkSeq() == null || "0".compareTo( distWorkVO.getWorkSeq()) <= 0 ) {
			String attSeq = getInsertWrkSeq(distWorkVO);
			distWorkVO.setWorkSeq(attSeq);
		}
		distributionDiaryMapper.updateDistWork(distWorkVO);
		distributionDiaryMapper.updateDistWorkDtl(distWorkVO);

		if ( ( distWorkVO.getMoveBikeCd() != null && !"".equals(distWorkVO.getMoveBikeCd()  )  )
				|| 
				( distWorkVO.getRelocateBikeCd() != null &&  !"".equals(distWorkVO.getRelocateBikeCd()  )   )
				) {
			
			if ( distWorkVO.getMoveBikeCnt() == null ) distWorkVO.setMoveBikeCnt("0");
			if ( distWorkVO.getRelocateBikeCnt() == null ) distWorkVO.setRelocateBikeCnt("0");
			
			if( distWorkVO.getEtcBikeSeq() == null || "".equals( distWorkVO.getEtcBikeSeq()) || "0".compareTo( distWorkVO.getEtcBikeSeq()) >= 0 ) {
				
				// 화면에서 seq 제대로 못 읽어오는 경ㅇ
				int pk = distributionDiaryMapper.getInsertEtcWorkSeq(distWorkVO);
				
				if ( pk > 0 ) {
					distributionDiaryMapper.updateDistWorkEtcBike(distWorkVO);
				} else {
					distributionDiaryMapper.insertDistWorkEtcBike(distWorkVO);
				}
				
			} else {
				distributionDiaryMapper.updateDistWorkEtcBike(distWorkVO);
			}	
		}
	}
	
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public String checkDistWork(DistWorkVO distWorkVO) {// 당일 workSeq 조회
		return distributionDiaryMapper.checkDistWork(distWorkVO);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public String getAdminGrpName(DistWorkVO distWorkVO) {//관리자 그룹 네임 가져오기
		return distributionDiaryMapper.getAdminGrpName(distWorkVO);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public String getInsertWrkCenterId(DistWorkVO distWorkVO) {//정비원 근태 입력시 centerId 가져오기
		return distributionDiaryMapper.getInsertWrkCenterId(distWorkVO);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<DistWorkVO> getMaintenWrkerAtt(DistWorkVO distWorkVO) {//정비원 근태 조회
		return distributionDiaryMapper.getMaintenWrkerAtt(distWorkVO);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getMaintenWrkerAttCnt(DistWorkVO distWorkVO) {//정비원 근태 총 건수 
		return distributionDiaryMapper.getMaintenWrkerAttCnt(distWorkVO);
	}

	
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public String getInsertWrkSeq(DistWorkVO distWorkVO) {// 최근 workSeq 조회
		return distributionDiaryMapper.getInsertWrkSeq(distWorkVO);
	}


	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public DistWorkVO getMaintenWrkerAttD(DistWorkVO distWorkVO) {// 정비원 당일 근태 정보 조회
		return distributionDiaryMapper.getMaintenWrkerAttD(distWorkVO);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public String getCenterNameWithCenterCode(DistWorkVO distWorkVO) {// 엑셀용 : centerCode 로 centerName 조회
		return distributionDiaryMapper.getCenterNameWithCenterCode(distWorkVO);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<DistCoWorkVO> getDistCoWork(DistCoWorkVO vo) {
		return distributionDiaryMapper.getDistCoWork(vo);
	}  
	  
	@Override
	@Transactional(readOnly=false,propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public void insertDistCoWork(DistCoWorkVO vo) {
		 distributionDiaryMapper.insertDistCoWork(vo);
	}
	@Override
	@Transactional(readOnly=false,propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public void deleteDistCoWork(DistCoWorkDtlVO vo) {
		distributionDiaryMapper.deleteDistCoWorkDtl(vo);
		distributionDiaryMapper.deleteDistCoWork(vo);
	}
	
	@Override
	@Transactional(readOnly=false,propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public void deleteDistCoWorkDtl(DistCoWorkDtlVO vo) {
		distributionDiaryMapper.deleteDistCoWorkDtl(vo);
		distributionDiaryMapper.updateDistCoWorkCnt(vo);	// 인원 업데이트
	}
	
	@Override
	@Transactional(readOnly=false,propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public void updateDistCoWork(DistCoWorkVO vo) {
		distributionDiaryMapper.updateDistCoWork(vo);
	}
	
	@Override
	@Transactional(readOnly=false,propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public void insertDistCoWorkDtl(DistCoWorkDtlVO vo) {
		 distributionDiaryMapper.insertDistCoWorkDtl(vo);	// dtl 등록
		 distributionDiaryMapper.updateDistCoWorkCnt(vo);	// 인원 업데이트
	}
	
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<DistCoWorkVO> getCoworkList(DistCoWorkVO vo) {// 최근 workSeq 조회
		return distributionDiaryMapper.getCoworkList(vo);
	}
	
	// 2022-01-06 순회정비반 추가
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<DistWorkVO> getRoundMaintenWrkerAtt(DistWorkVO distWorkVO) {//정비원 근태 조회
		return distributionDiaryMapper.getRoundMaintenWrkerAtt(distWorkVO);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getRoundMaintenWrkerAttCnt(DistWorkVO distWorkVO) {//정비원 근태 총 건수 
		return distributionDiaryMapper.getRoundMaintenWrkerAttCnt(distWorkVO);
	}
	
}
