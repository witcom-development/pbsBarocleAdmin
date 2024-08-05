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
package com.dkitec.barocle.admin.maintenance.repair.bike.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.maintenance.repair.bike.service.RepairBikeMapper;
import com.dkitec.barocle.admin.maintenance.repair.bike.service.RepairBikeService;
import com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO;
import com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairPartsVO;
import com.dkitec.barocle.admin.maintenance.stockMgmt.invent.vo.InventVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.google.gson.Gson;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="repairBikeService")
public class RepairBikeServiceImpl extends EgovAbstractServiceImpl implements RepairBikeService {

	@Autowired private RepairBikeMapper repairBikeMapper;

	
	
	// 20210608 운장자 자전거 수리이력
	public int getRepairBikeLisHistCount(RepairBikeVO repairBikeVO)  throws SQLException {
		// TODO Auto-generated method stub
		return repairBikeMapper.getRepairBikeLisHistCount(repairBikeVO);
	}
	
	public List<RepairBikeVO> getRepairBikeHistList(RepairBikeVO repairBikeVo) throws SQLException {
		// TODO Auto-generated method stub
		return repairBikeMapper.getRepairBikeHistList(repairBikeVo);
	}
	// 20210608 end	
	
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<RepairBikeVO> getRepairBikeList(RepairBikeVO repairBikeVo) {
		// TODO Auto-generated method stub
		return repairBikeMapper.getRepairBikeList(repairBikeVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getRepairBikeListCount(RepairBikeVO repairBikeVo) {
		// TODO Auto-generated method stub
		return repairBikeMapper.getRepairBikeListCount(repairBikeVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public RepairBikeVO getRepairBikeInfo(RepairBikeVO repairBikeVo) {

		List<RepairPartsVO> partsList = repairBikeMapper.getRepairPartsChgInfo(repairBikeVo);
		RepairBikeVO resultVo = repairBikeMapper.getRepairBikeInfo(repairBikeVo);
		
		if(partsList.size() != 0){
			Gson gson = new Gson();
			resultVo.setPartsData(gson.toJson(partsList));
		}
		return resultVo;
	}
	 
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<String> getRepairCodeList(String repairSeq) {
		// TODO Auto-generated method stub
		return repairBikeMapper.getRepairCodeList(repairSeq);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public String getBikeMoveYn(RepairBikeVO repairBikeVo){
		// TODO Auto-generated method stub
		return repairBikeMapper.getBikeMoveYn(repairBikeVo);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int insertRepairBike(RepairBikeVO repairBikeVo){
		// TODO Auto-generated method stub
		
		int result = 0;
		RepairBikeVO tmpVo = repairBikeVo;
		String[] tmpRepairCode = repairBikeVo.getRepairCode().split(",");
		
		JSONArray partsJson = null;
		if(repairBikeVo.getPartsData() != null && repairBikeVo.getPartsData() != ""){
			
			try {
				partsJson = new JSONArray(repairBikeVo.getPartsData());
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
			
		}
		JSONArray modifyPartsJson = null;
		if(repairBikeVo.getModifyPartsData() != null && repairBikeVo.getModifyPartsData() != ""){
			
			try {
				modifyPartsJson = new JSONArray(repairBikeVo.getModifyPartsData());
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		result = repairBikeMapper.insertRepairBike(repairBikeVo);
		
		result = repairBikeMapper.updateBikeStatus(repairBikeVo);
		if(!repairBikeVo.getFaultSeq().equals("")){
			result = repairBikeMapper.updateFaultBike(repairBikeVo);
		}
		
		if(repairBikeVo.getMoveYn().equals("Y")){
			result = repairBikeMapper.deleteBikeParkingInfo(repairBikeVo);
			result = repairBikeMapper.updateBikeMoveHistory(repairBikeVo);
			result = repairBikeMapper.insertBikeMoveHistory(repairBikeVo);
			result = repairBikeMapper.updateBikeLocationInfo(repairBikeVo);
		}
		
		if(repairBikeVo.getCenterId() != null && repairBikeVo.getCenterId() != "" && repairBikeVo.getRepairCmptYn().equals("Y")){
			result = repairBikeMapper.updateBikeStatusCmi(repairBikeVo);
			result = repairBikeMapper.insertBikeStatusHistory(repairBikeVo);
		}
		
		// 2020-02-14 변경
		insertRepairDetail(repairBikeVo, tmpVo, tmpRepairCode);
		
		result = repairBikeMapper.deleteChangeParts(repairBikeVo);
		
		if(partsJson != null){
			
			for(int i = 0; i < partsJson.length(); i++){
				RepairPartsVO repairPartsVo = new RepairPartsVO();
				repairPartsVo.setRepairSeq(repairBikeVo.getRepairSeq());
				try {
					repairPartsVo.setPartsName(partsJson.getJSONObject(i).getString("partsName"));
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				try {
					repairPartsVo.setCenterName(partsJson.getJSONObject(i).getString("centerName"));
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				try {
					repairPartsVo.setUsePartsCnt(partsJson.getJSONObject(i).getString("usePartsCnt"));
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				result = repairBikeMapper.insertChangeParts(repairPartsVo);
			}
			
		}
		
		if(modifyPartsJson != null){
			
			for(int i = 0; i < modifyPartsJson.length(); i++){
				RepairPartsVO repairPartsVo = new RepairPartsVO();
				try {
					repairPartsVo.setPartsName(modifyPartsJson.getJSONObject(i).getString("partsName"));
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				try {
					repairPartsVo.setCenterName(modifyPartsJson.getJSONObject(i).getString("centerName"));
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				try {
					repairPartsVo.setChngType(modifyPartsJson.getJSONObject(i).getString("chngType"));
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				try {
					repairPartsVo.setChngCnt(modifyPartsJson.getJSONObject(i).getString("chngCnt"));
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				repairPartsVo.setModId(repairBikeVo.getModId());
				
				result = repairBikeMapper.insertUsePartHistory(repairPartsVo);
				
				result = repairBikeMapper.updateUsePart(repairPartsVo);
			}
			
		}
		return result;
	}
	
	// 2021-09-10 바로클 포 제거
	private void insertRepairDetail(RepairBikeVO repairBikeVo, RepairBikeVO tmpVo, String[] tmpRepairCode) {
		
		if ( !"CEN_003".equals(repairBikeVo.getCenterClsCd()) ) {
			
			for(int i = 0; i < tmpRepairCode.length; i++){
				tmpVo.setRepairCode(tmpRepairCode[i]);
				repairBikeMapper.insertRepairBikeDetail(tmpVo);
				//해당 수리항목이 배터리 교체인지 확인
				String batReplaceYn = checkRepairDtlIsBatReplace(tmpVo);
				if("Y".equals(batReplaceYn)){
					insertBatReplace(tmpVo);
				}
				
			}
			
		} else {
			// 바로클포 관련 로직
			if ( tmpRepairCode != null ) {
				boolean REC_002 = Arrays.asList(tmpRepairCode).contains("REC_002");	// 앞)타이어
				boolean REC_003 = Arrays.asList(tmpRepairCode).contains("REC_003");	// 앞) 펑크(튜브)
				boolean REC_007 = Arrays.asList(tmpRepairCode).contains("REC_007");	// 튀) 타이어
				boolean REC_008 = Arrays.asList(tmpRepairCode).contains("REC_008");	// 뒤) 펑크(튜브)
				boolean REC_014 = Arrays.asList(tmpRepairCode).contains("REC_014");	// 크랭크
				boolean REC_015 = Arrays.asList(tmpRepairCode).contains("REC_015");	// bb
				boolean REC_019 = Arrays.asList(tmpRepairCode).contains("REC_019");	// 크랭크 + BB
				boolean REC_020 = Arrays.asList(tmpRepairCode).contains("REC_020");	// 앞타이어 + 펑크
				boolean REC_021 = Arrays.asList(tmpRepairCode).contains("REC_021");	// 뒤타이어 + 펑크
				
				List<String> list = new ArrayList<>( Arrays.asList(tmpRepairCode));
				
				if ( REC_002 && REC_003 ) {
					list.remove("REC_002");
					list.remove("REC_003");
					list.add("REC_020");		// 앞타이어 펑크
				} else if ( REC_020 && ( REC_002 && !REC_003 ) || ( REC_003 && !REC_002 ) ) {			
					list.remove("REC_020"); 
				}
				
				if ( REC_007 && REC_008 ) {
					list.remove("REC_007");
					list.remove("REC_008");
					list.add("REC_021");		// 뒤타이어 펑크
				} else if ( REC_021 && ( REC_007 && !REC_008 ) || ( REC_008 && !REC_007 ) ) {	
					list.remove("REC_021");
				}
				
				if ( REC_014 && REC_015 ) {
					list.remove("REC_014");
					list.remove("REC_015");
					list.add("REC_019");		// 뒤타이어 펑크
				}  else if ( REC_019 && ( REC_014 && !REC_015 ) || ( REC_015 && !REC_014 )  ) {			
					list.remove("REC_019");
				}
				 
				for ( String code : list ) {
					
					System.out.println("code :  " + code);
					
					tmpVo.setRepairCode(code);
					repairBikeMapper.insertRepairBikeDetail(tmpVo);
					
					//해당 수리항목이 배터리 교체인지 확인
					String batReplaceYn = checkRepairDtlIsBatReplace(tmpVo);
					
					if("Y".equals(batReplaceYn)){
						
						insertBatReplace(tmpVo);
						
					}
					
				}
			}
		}
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int updateRepairBike(RepairBikeVO repairBikeVo){
		// TODO Auto-generated method stub
		int result = 0;
		RepairBikeVO tmpVo = repairBikeVo;
		String[] tmpRepairCode = repairBikeVo.getRepairCode().split(",");
		
		JSONArray partsJson = null;
				
		if(repairBikeVo.getPartsData() != null && repairBikeVo.getPartsData() != ""){
			
			try {
				partsJson = new JSONArray(repairBikeVo.getPartsData());
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
			
		}
		
		
		JSONArray modifyPartsJson = null;
		
		if(repairBikeVo.getModifyPartsData() != null && repairBikeVo.getModifyPartsData() != ""){
			try {
				modifyPartsJson = new JSONArray(repairBikeVo.getModifyPartsData());
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		result = repairBikeMapper.updateBikeStatus(repairBikeVo);
		if(repairBikeVo.getMoveYn().equals("Y")){
			result = repairBikeMapper.deleteBikeParkingInfo(repairBikeVo);
			result = repairBikeMapper.updateBikeMoveHistory(repairBikeVo);
			result = repairBikeMapper.insertBikeMoveHistory(repairBikeVo);
			result = repairBikeMapper.updateBikeLocationInfo(repairBikeVo);
		}
		
		if(repairBikeVo.getCenterId() != null && repairBikeVo.getCenterId() != "" && repairBikeVo.getRepairCmptYn().equals("Y")){
			result = repairBikeMapper.updateBikeStatusCmi(repairBikeVo);
			result = repairBikeMapper.insertBikeStatusHistory(repairBikeVo);
		}
		
		result = repairBikeMapper.deleteRepairBikeDetail(repairBikeVo);
		insertRepairDetail(repairBikeVo, tmpVo, tmpRepairCode);

		result = repairBikeMapper.deleteChangeParts(repairBikeVo);
		
		if(partsJson != null){
			
		
			for(int i = 0; i < partsJson.length(); i++){
				RepairPartsVO repairPartsVo = new RepairPartsVO();
				repairPartsVo.setRepairSeq(repairBikeVo.getRepairSeq());
				try {
					repairPartsVo.setPartsName(partsJson.getJSONObject(i).getString("partsName"));
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				try {
					repairPartsVo.setCenterName(partsJson.getJSONObject(i).getString("centerName"));
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				try {
					repairPartsVo.setUsePartsCnt(partsJson.getJSONObject(i).getString("usePartsCnt"));
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				result = repairBikeMapper.insertChangeParts(repairPartsVo);
			}
		
		}
		
		if(modifyPartsJson != null){
		
			for(int i = 0; i < modifyPartsJson.length(); i++){
				RepairPartsVO repairPartsVo = new RepairPartsVO();
				try {
					repairPartsVo.setPartsName(modifyPartsJson.getJSONObject(i).getString("partsName"));
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				try {
					repairPartsVo.setCenterName(modifyPartsJson.getJSONObject(i).getString("centerName"));
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				try {
					repairPartsVo.setChngType(modifyPartsJson.getJSONObject(i).getString("chngType"));
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				try {
					repairPartsVo.setChngCnt(modifyPartsJson.getJSONObject(i).getString("chngCnt"));
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				repairPartsVo.setModId(repairBikeVo.getModId());
				result = repairBikeMapper.insertUsePartHistory(repairPartsVo);
				result = repairBikeMapper.updateUsePart(repairPartsVo);
			}
		}
		
		result = repairBikeMapper.updateRepairBike(repairBikeVo);
		return result;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int deleteRepairBike(RepairBikeVO repairBikeVo){
		// TODO Auto-generated method stub
		repairBikeMapper.deleteRepairBikeDetail(repairBikeVo);
		repairBikeMapper.deleteChangeParts(repairBikeVo);
		return repairBikeMapper.deleteRepairBike(repairBikeVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public String getRemainPartsCnt(InventVO inventVo) {
		// TODO Auto-generated method stub
		return repairBikeMapper.getRemainPartsCnt(inventVo);
	}

	/*
	 * 20190314
	 * 바로클 포 
	 * @see com.dkitec.barocle.admin.maintenance.repair.bike.service.RepairBikeService#getRepairBikeMallList(com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO)
	 */
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<RepairBikeVO> getRepairBikeMallList(RepairBikeVO repairBikeVo) {
		return repairBikeMapper.getRepairBikeMallList(repairBikeVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getRepairBikeListMallCount(RepairBikeVO repairBikeVo) {
		// TODO Auto-generated method stub
		return repairBikeMapper.getRepairBikeMallListCount(repairBikeVo);
	}

	/*
	 * 20200608
	 * 경정비 수리 센터 고정
	 * @see com.dkitec.barocle.admin.maintenance.repair.bike.service.RepairBikeService#getAdminCenterId(com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO)
	 */
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public String getAdminCenterId(RepairBikeVO repairBikeVo) {
		return repairBikeMapper.getAdminCenterId(repairBikeVo);
	}
	
	/*
	 * 20200706
	 * 자전거 수리완료 등록 시 해당 자전거 이전 수리중 건 수리완료처리
	 * @see com.dkitec.barocle.admin.maintenance.repair.bike.service.RepairBikeService#repairBikeCleanUp(com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO)
	 */
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public void repairBikeCleanUp(RepairBikeVO repairBikeVo) {
		
		repairBikeMapper.repairBikeCleanUp(repairBikeVo);
		
	}
	
	/*
	 * 20200713
	 * 자전거 수리 등록 시 해당 자전거 이전 장애 건 털기
	 * @see com.dkitec.barocle.admin.maintenance.repair.bike.service.RepairBikeService#repairBikeFaultCleanUp(com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO)
	 */
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public void repairBikeFaultCleanUp(RepairBikeVO repairBikeVo) {

		repairBikeMapper.repairBikeFaultCleanUp(repairBikeVo);
		
	}

	/*
	 * 20200714
	 * 자전거 납품처 조회
	 * @see com.dkitec.barocle.admin.maintenance.repair.bike.service.RepairBikeService#getBikeEntrsName(com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO)
	 */
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public String getBikeEntrsName(RepairBikeVO repairBikeVo) {
		return repairBikeMapper.getBikeEntrsName(repairBikeVo);
	}

	/*
	 * 20200724
	 * 자전거 최근 수리완료 시간 조회
	 * @see com.dkitec.barocle.admin.maintenance.repair.bike.service.RepairBikeService#getRepairCmptDttm(com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO)
	 */
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public String getRepairCmptDttm(RepairBikeVO repairBikeVo) {
		return repairBikeMapper.getRepairCmptDttm(repairBikeVo);
	}
	
	/*
	 * 20201006
	 * 자전거 수리항목이 배터리 교체인지 확인
	 * @see com.dkitec.barocle.admin.maintenance.repair.bike.service.RepairBikeService#checkRepairDtlIsBatReplace(com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO)
	 */
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public String checkRepairDtlIsBatReplace(RepairBikeVO repairBikeVo) {
		return repairBikeMapper.checkRepairDtlIsBatReplace(repairBikeVo);
	}	
	
	/*
	 * 20201006
	 * 자전거 수리항목이 배터리 교체일 시 배터리 교체 정보 테이블에 등록
	 * @see com.dkitec.barocle.admin.maintenance.repair.bike.service.RepairBikeService#insertBatReplace(com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO)
	 */
	@Override
	@Transactional(readOnly= false)
	@DataSource(DataSourceType.MASTER)
	public void insertBatReplace(RepairBikeVO repairBikeVo) {
		repairBikeMapper.insertBatReplace(repairBikeVo);
	}

	/*
	 * 20201013
	 * 배터리 교체 내역 조회
	 * @see com.dkitec.barocle.admin.maintenance.repair.bike.service.RepairBikeService#getBatReplaceList(com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO)
	 */
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<RepairBikeVO> getBatReplaceList(RepairBikeVO repairBikeVo) {
		return repairBikeMapper.getBatReplaceList(repairBikeVo);
	}

	/*
	 * 20201020
	 * 센터 구분 코드 조회
	 * @see com.dkitec.barocle.admin.maintenance.repair.bike.service.RepairBikeService#getCenterClsCd(com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO)
	 */
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public String getCenterClsCd(RepairBikeVO repairBikeVo) {
		return repairBikeMapper.getCenterClsCd(repairBikeVo);
	}
	
	/*
	 * 20201117
	 * 자전거 상태(대여중, 대기중...) 코드 조회
	 * @see com.dkitec.barocle.admin.maintenance.repair.bike.service.RepairBikeService#getBikeStatusCd(com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO)
	 */
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)	
	public String getBikeStatusCd(RepairBikeVO repairBikeVo) {
		return repairBikeMapper.getBikeStatusCd(repairBikeVo);
	}	
	

	/*
	 * 20201117
	 * 자전거 상태(대여중, 대기중...) 코드 조회
	 * @see com.dkitec.barocle.admin.maintenance.repair.bike.service.RepairBikeService#getBikeStatusCd(com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO)
	 */
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)	
	public int selectRepairCurrDate(RepairBikeVO repairBikeVo) {
		return repairBikeMapper.selectRepairCurrDate(repairBikeVo);
	}	
	
}
