package com.dkitec.barocle.admin.maintenance.distMgmt.vcleMgmt.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.maintenance.distMgmt.vcleMgmt.service.VcleMgmtMapper;
import com.dkitec.barocle.admin.maintenance.distMgmt.vcleMgmt.service.VcleMgmtService;
import com.dkitec.barocle.admin.maintenance.distMgmt.vcleMgmt.vo.VcleMgmtVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.hazelcast.util.StringUtil;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="vcleMgmtService")
public class VcleMgmtServiceImpl extends EgovAbstractServiceImpl implements VcleMgmtService {

	@Autowired private VcleMgmtMapper vcleMgmtMapper;
	

	@Override
	@Transactional(readOnly=false,propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public void insertDistVcleAll(VcleMgmtVO vcleMgmtVO)  {// 분배원 차량정보 등록
		
		
		
		if ( vcleMgmtVO.getVcleNo() != null && !"".equals( vcleMgmtVO.getVcleNo().trim() ) && 
				
				vcleMgmtVO.getDelYN() != null && !"1".equals( vcleMgmtVO.getDelYN()) ) {
				
			System.out.println("전체 등록 >>>>>>>>>");
			
				// 등록
				vcleMgmtMapper.insertVcleDispatch(vcleMgmtVO);
				
				// 삭제
				vcleMgmtMapper.deleteDispatchDtl(vcleMgmtVO);
				
				// 기본 저장
				vcleMgmtMapper.insertVcleDispatchDtl(vcleMgmtVO);
				
				// 1번 저장
				if ( vcleMgmtVO.getVcleNo1() != null && !"".equals( vcleMgmtVO.getVcleNo1().trim() ) && 
						
						
						
					vcleMgmtVO.getDelYN1() != null && !"1".equals( vcleMgmtVO.getDelYN1()) ) {
					
					System.out.println("1 번등록 >>>>>>>>>");
					vcleMgmtVO.setVcleNo    ( vcleMgmtVO.getVcleNo1()      );
					vcleMgmtVO.setAfMileage ( vcleMgmtVO.getAfMileage1()   );
					vcleMgmtVO.setBfMileage ( vcleMgmtVO.getBfMileage1()   );
					vcleMgmtVO.setDriverType( vcleMgmtVO.getDriverType1()  );
					vcleMgmtVO.setStartTime ( vcleMgmtVO.getStartTime1()   );
					vcleMgmtVO.setEndTime   ( vcleMgmtVO.getEndTime1()     );
					vcleMgmtVO.setNotice   ( vcleMgmtVO.getNotice1()     );
					
					vcleMgmtMapper.insertVcleDispatchDtl(vcleMgmtVO);
				}
				
				// 2번 저장
				if ( vcleMgmtVO.getVcleNo2() != null && !"".equals( vcleMgmtVO.getVcleNo2().trim() ) && 
						
						
					vcleMgmtVO.getDelYN2() != null && !"1".equals( vcleMgmtVO.getDelYN2())) {
					
					System.out.println("2 번등록 >>>>>>>>>");
					vcleMgmtVO.setVcleNo    ( vcleMgmtVO.getVcleNo2()      );
					vcleMgmtVO.setAfMileage ( vcleMgmtVO.getAfMileage2()   );
					vcleMgmtVO.setBfMileage ( vcleMgmtVO.getBfMileage2()   );
					vcleMgmtVO.setDriverType( vcleMgmtVO.getDriverType2()  );
					vcleMgmtVO.setStartTime ( vcleMgmtVO.getStartTime2()   );
					vcleMgmtVO.setEndTime   ( vcleMgmtVO.getEndTime2()     );
					vcleMgmtVO.setNotice    ( vcleMgmtVO.getNotice2()     );
					vcleMgmtMapper.insertVcleDispatchDtl(vcleMgmtVO);
				}
			
		} else {
			
			System.out.println("전체 삭제 >>>>>>>>>");
			
			vcleMgmtMapper.deleteDispatchDtl(vcleMgmtVO);
			vcleMgmtMapper.deleteDispatch(vcleMgmtVO);
		}
	}
	
	@Override
	public void updateVcleDispatchAll(VcleMgmtVO vcleMgmtVO) {// 분배원 수정 로직
		
		updateVcleDispatch(vcleMgmtVO);
		updateVcleDispatchDtl(vcleMgmtVO);
		
		if("VSC_001".equals(vcleMgmtVO.getVcleStusCd()) || ( vcleMgmtVO.getAfMileage() != null && !"".equals(vcleMgmtVO.getAfMileage()) ) ){
			
			vcleMgmtVO.setVcleStusCd("VSC_001");
			vcleMgmtVO.setVcleNoSeq(vcleMgmtVO.getVcleNo());
			updateVcleStusCd(vcleMgmtVO);
			
		}
		
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public VcleMgmtVO getTodayDistVcle(VcleMgmtVO vcleMgmtVO) {// 분배원 당일 차량 정보 조회
		List<VcleMgmtVO> list = vcleMgmtMapper.getTodayDistVcle(vcleMgmtVO);
		
		if ( list.size() > 1 ) {
			
			if ( list.size() == 3 ) {
				list.get(0).setVcleNo2     (list.get(2).getVcleNo()     ); 
				list.get(0).setVcleNoSeq2  (list.get(2).getVcleNoSeq()  ); 
				list.get(0).setAfMileage2  (list.get(2).getAfMileage()  ); 
				list.get(0).setBfMileage2  (list.get(2).getBfMileage()  ); 
				list.get(0).setDriverType2 (list.get(2).getDriverType() );
				list.get(0).setStartTime2  (list.get(2).getStartTime()  ); 
				list.get(0).setEndTime2    (list.get(2).getEndTime()    );   
				list.get(0).setNotice2    (list.get(2).getNotice()    );   
			}
			
			list.get(0).setVcleNo1     (list.get(1).getVcleNo()     );    
			list.get(0).setVcleNoSeq1  (list.get(1).getVcleNoSeq()  );    
			list.get(0).setAfMileage1  (list.get(1).getAfMileage()  ); 
			list.get(0).setBfMileage1  (list.get(1).getBfMileage()  ); 
			list.get(0).setDriverType1 (list.get(1).getDriverType() );
			list.get(0).setStartTime1  (list.get(1).getStartTime()  ); 
			list.get(0).setEndTime1    (list.get(1).getEndTime()    );   
			list.get(0).setNotice1     (list.get(1).getNotice()    );
			return list.get(0);
			
		} else if ( list.size() == 1 ) {
			return list.get(0);
		} else {
			VcleMgmtVO		 vo   = new VcleMgmtVO();
			return vo;
		}
		
	}
	
	@Override
	@Transactional(readOnly= false)
	@DataSource(DataSourceType.MASTER)
	public void insertVcleDispatch(VcleMgmtVO vcleMgmtVO) {// 분배원 차량 정보 등록
		vcleMgmtMapper.insertVcleDispatch(vcleMgmtVO);
	}
	
	@Override
	@Transactional(readOnly= false)
	@DataSource(DataSourceType.MASTER)
	public void insertVcleDispatchDtl(VcleMgmtVO vcleMgmtVO) {// 분배원 차량 상세 정보 등록
		
		
	}
	
	@Override
	@Transactional(readOnly= false)
	@DataSource(DataSourceType.MASTER)
	public void updateVcleDispatch(VcleMgmtVO vcleMgmtVO) {// 분배원 차량 정보 수정
		vcleMgmtMapper.updateVcleDispatch(vcleMgmtVO);
	}
	
	@Override
	@Transactional(readOnly= false)
	@DataSource(DataSourceType.MASTER)
	public void updateVcleDispatchDtl(VcleMgmtVO vcleMgmtVO) {// 분배원 차량 상세 정보 수정
		vcleMgmtMapper.updateVcleDispatchDtl(vcleMgmtVO);
	}
	
	@Override
	@Transactional(readOnly= false)
	@DataSource(DataSourceType.MASTER)
	public void updateVcleStusCd(VcleMgmtVO vcleMgmtVO) {// 차량 상태 수정
		vcleMgmtMapper.updateVcleStusCd(vcleMgmtVO);
	}
	 
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public String checkVcleDispatch(VcleMgmtVO vcleMgmtVO) {// 당일 차량 조회
		return vcleMgmtMapper.checkVcleDispatch(vcleMgmtVO);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public VcleMgmtVO checkVcleDispatchDtl(VcleMgmtVO vcleMgmtVO) {// 당일 차량 탑승자 조회
		return vcleMgmtMapper.checkVcleDispatchDtl(vcleMgmtVO);
	}

	
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<VcleMgmtVO> getVcleInfoList(VcleMgmtVO vcleMgmtVO) {// 차량 현황 정보 조회
		return vcleMgmtMapper.getVcleInfoList(vcleMgmtVO);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<VcleMgmtVO> getDistVcleList(VcleMgmtVO vcleMgmtVO) {// 분배원 차량 정보 조회
		return vcleMgmtMapper.getDistVcleList(vcleMgmtVO);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)	
	public int getDistVcleListCnt(VcleMgmtVO vcleMgmtVO) {// 분배원 차량 정보 건 조회
		return vcleMgmtMapper.getDistVcleListCnt(vcleMgmtVO);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)	
	public String getCenterIdByTeamSeq(String teamSeq) {// 분배원 팀 시퀀스로 센터아이디 조회
		return vcleMgmtMapper.getCenterIdByTeamSeq(teamSeq);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)		
	public List<VcleMgmtVO> getShiftWorkCdList() {// 교대근무 공통코드(SWK) 조회
		return vcleMgmtMapper.getShiftWorkCdList();
	}
	
	
	
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)	
	public int getRoundVcleListCnt(VcleMgmtVO vcleMgmtVO) {// 분배원 차량 정보 건 조회
		return vcleMgmtMapper.getRoundVcleListCnt(vcleMgmtVO);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<VcleMgmtVO> getRoundVcleList(VcleMgmtVO vcleMgmtVO) {// 분배원 차량 정보 조회
		return vcleMgmtMapper.getRoundVcleList(vcleMgmtVO);
	}	

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<VcleMgmtVO> getRoundInfoList(VcleMgmtVO vcleMgmtVO) {// 차량 현황 정보 조회
		return vcleMgmtMapper.getRoundInfoList(vcleMgmtVO);
	}	
	
}
