package com.dkitec.barocle.admin.repairBikeMall.transferBike.service.impl;

import java.util.List;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.repairBikeMall.transferBike.service.TransferBikeMapper;
import com.dkitec.barocle.admin.repairBikeMall.transferBike.service.TransferBikeService;
import com.dkitec.barocle.admin.repairBikeMall.transferBike.vo.TransferBikeVo;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="transferBikeService")
public class TransferBikeServiceImpl extends EgovAbstractServiceImpl implements TransferBikeService{
	
	@Autowired private TransferBikeMapper transferBikeMapper;
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<TransferBikeVo> getTransferBikeList(TransferBikeVo transferBikeVo) {
		// TODO Auto-generated method stub
		return transferBikeMapper.getTransferBikeList(transferBikeVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getTransferBikeListCount(TransferBikeVo transferBikeVo) {
		// TODO Auto-generated method stub
		return transferBikeMapper.getTransferBikeListCount(transferBikeVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<TransferBikeVo> getBikeMallList(TransferBikeVo transferBikeVo) {
		// TODO Auto-generated method stub
		return transferBikeMapper.getBikeMallList(transferBikeVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<TransferBikeVo> getCheckTransferList(TransferBikeVo transferBikeVo) {
		// TODO Auto-generated method stub
		return transferBikeMapper.getCheckTransferList(transferBikeVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getCheckTransferListCount(TransferBikeVo transferBikeVo) {
		// TODO Auto-generated method stub
		return transferBikeMapper.getCheckTransferListCount(transferBikeVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.MASTER)
	public int updateTransferYn(TransferBikeVo transferBikeVo) {
		// TODO Auto-generated method stub
		
		// 시퀀스 분개 후 업데이트
		String[] infoSeq = transferBikeVo.getRepairOursrcSeq().split(",");
		int result = 0;
		
		for(int i=0;i<infoSeq.length;i++){
			if(! infoSeq[i].equals("")){
				transferBikeVo.setRepairOursrcSeq(infoSeq[i]);
				result = transferBikeMapper.updateTransferYn(transferBikeVo);
			}
		}
		
		return result;
	}
	
	@Override
	@Transactional(readOnly= false)
	@DataSource(DataSourceType.MASTER)
	// public int addTransferBike(TransferBikeVo transferBikeVo) {
	public String addTransferBike(TransferBikeVo transferBikeVo) {
		// TODO Auto-generated method stub
		
		 JSONArray partsJson = null;
 		
		 partsJson = new JSONArray(transferBikeVo.getPartsData());
		 
		 if(transferBikeVo.getViewFlg().equals("C") || transferBikeVo.getViewFlg().equals("list")){	// 새로 등록한다면 mainSeq생성
			 @SuppressWarnings("unused") int resultValue = transferBikeMapper.addTransferBikeMain(transferBikeVo);
		 }else{	// 데이터 수정이라면 기존 info,detl테이블 정보들 삭제
			 List<TransferBikeVo> infoList = transferBikeMapper.getTransferBikeDetail(transferBikeVo);
			 for(int i=0;i<infoList.size();i++){
				 transferBikeMapper.deleteTransferBikeDetl(infoList.get(i).getRepairOursrcSeq());
			 }
			 transferBikeMapper.deleteTransferBikeInfo(transferBikeVo);
		 }
		 
		 String tempBikeNo="";
		 TransferBikeVo infoVo = new TransferBikeVo();
		 TransferBikeVo detlVo = new TransferBikeVo();
		 int resultValue1 =0; 
		 
		 infoVo.setAdminId(transferBikeVo.getAdminId());
		 infoVo.setRepairOutsrcMainSeq(transferBikeVo.getRepairOutsrcMainSeq());
		 infoVo.setTakeId(transferBikeVo.getTakeId());
		 infoVo.setTransYn("Y");
		
		 int discountCd1Cnt = 0;int discountCd2Cnt = 0;int discountCd3Cnt = 0;int discountCd4Cnt = 0;
		 int bikeCnt=0; int cd1Cnt = 0; int cd2Cnt = 0; int cd3Cnt = 0; int cd4Cnt = 0;
		 
		 int[][] disCountCdCnt = new int[99][5];
		 
		 String[][] ratebrokenStatusCdList1 = new String[99][3];
		 String[][] ratebrokenStatusCdList2 = new String[99][3];
		 String[][] ratebrokenStatusCdList3 = new String[99][2];
		 String[][] ratebrokenStatusCdList4 = new String[99][2];
		 
		 
		for(int i = 0; i < partsJson.length(); i++){
			infoVo.setBikeNo(partsJson.getJSONObject(i).getString("bikeNo"));
			if (!tempBikeNo.equals(infoVo.getBikeNo())) {
				resultValue1 = transferBikeMapper.addTransferBikeInfo(infoVo);
				tempBikeNo= partsJson.getJSONObject(i).getString("bikeNo");

				if (i > 0) {
					disCountCdCnt[bikeCnt][0]	= discountCd1Cnt;
					disCountCdCnt[bikeCnt][1]	= discountCd2Cnt;
					disCountCdCnt[bikeCnt][2]	= discountCd3Cnt;
					disCountCdCnt[bikeCnt][3]	= discountCd4Cnt;
					disCountCdCnt[bikeCnt][4]	= Integer.parseInt(detlVo.getRepairOursrcSeq());
					
					discountCd1Cnt = 0; discountCd2Cnt = 0; discountCd3Cnt = 0; discountCd4Cnt = 0;
					cd1Cnt = 0; cd2Cnt = 0; cd3Cnt = 0; cd4Cnt = 0;					
					
				}
				bikeCnt++;
			}
			detlVo.setRepairOursrcSeq(infoVo.getRepairOursrcSeq());
			detlVo.setBrokenStatusCd(partsJson.getJSONObject(i).getString("partsCode"));

			//System.out.println("=======================> ["+i+"] [" + detlVo.getRepairOursrcSeq() + "] [START]");
			//System.out.println("=======================> ["+i+"] [" + detlVo.getBrokenStatusCd() + "] [START]");
			
			if ("REC_012".equals(detlVo.getBrokenStatusCd()) || "REC_013".equals(detlVo.getBrokenStatusCd()) || "REC_014".equals(detlVo.getBrokenStatusCd())     ) {
				discountCd1Cnt++;
				ratebrokenStatusCdList1[bikeCnt][cd1Cnt++] = detlVo.getBrokenStatusCd();
			}
			if ("REC_016".equals(detlVo.getBrokenStatusCd()) || "REC_017".equals(detlVo.getBrokenStatusCd()) || "REC_018".equals(detlVo.getBrokenStatusCd())     ) {
				discountCd2Cnt++;
				ratebrokenStatusCdList2[bikeCnt][cd2Cnt++] = detlVo.getBrokenStatusCd();
			}
			if ("REC_021".equals(detlVo.getBrokenStatusCd()) || "REC_022".equals(detlVo.getBrokenStatusCd()) ) {
				discountCd3Cnt++;
				ratebrokenStatusCdList3[bikeCnt][cd3Cnt++] = detlVo.getBrokenStatusCd();
			}
			if ("REC_024".equals(detlVo.getBrokenStatusCd()) || "REC_025".equals(detlVo.getBrokenStatusCd()) ) {
				discountCd4Cnt++;
				ratebrokenStatusCdList4[bikeCnt][cd4Cnt++] = detlVo.getBrokenStatusCd();
			}
			//System.out.println("=======================> ["+i+"] [" + detlVo.getBrokenStatusCd() + "] [STOP]");
			
			// 사용자 세팅 
			
			detlVo.setAdminId(transferBikeVo.getAdminId());
			//System.out.println("=======================> [transferBikeVo.getAdminId()] [" + transferBikeVo.getAdminId() + "] ");
			//System.out.println("=======================> [detlVo.getAdminId()] [" + detlVo.getAdminId() + "] ");
			transferBikeMapper.addTransferBikeDetl(detlVo);
			
			if (i == (partsJson.length()-1)) { // LAST
				disCountCdCnt[bikeCnt][0]	= discountCd1Cnt;
				disCountCdCnt[bikeCnt][1]	= discountCd2Cnt;
				disCountCdCnt[bikeCnt][2]	= discountCd3Cnt;
				disCountCdCnt[bikeCnt][3]	= discountCd4Cnt;
				disCountCdCnt[bikeCnt][4]	= Integer.parseInt(detlVo.getRepairOursrcSeq());	
				bikeCnt++;
			}
		}
		
		
		//------------------------------------------
		// 할인율 처리
		//------------------------------------------
		System.out.println("=====================> bikeCnt = " + bikeCnt);
		
		for(int i = 0; i < bikeCnt; i++){
			
//			System.out.println("\n=====================> disCountCdCnt["+i+"][0] = " + disCountCdCnt[i][0]);
//			System.out.println("=====================> disCountCdCnt["+i+"][1] = " + disCountCdCnt[i][1]);
//			System.out.println("=====================> disCountCdCnt["+i+"][2] = " + disCountCdCnt[i][2]);
//			System.out.println("=====================> disCountCdCnt["+i+"][3] = " + disCountCdCnt[i][3]);
//			System.out.println("=====================> disCountCdCnt["+i+"][4] = " + disCountCdCnt[i][4]);
			
			if (disCountCdCnt[i][0] > 1) {
				int listCnt=0;
				String[] ratebrokenStatusCdList = new String[3];
				for(int j=0; j < disCountCdCnt[i][0]; j++) {
					ratebrokenStatusCdList[listCnt++] = ratebrokenStatusCdList1[i][j];
				}	

				TransferBikeVo disCountDetlVo = new TransferBikeVo();
				disCountDetlVo.setRepairOursrcSeq(String.valueOf(disCountCdCnt[i][4]));
				disCountDetlVo.setDiscountRate(transferBikeVo.getDiscountRate());
				disCountDetlVo.setBrokenStatusCdList(ratebrokenStatusCdList);
				transferBikeMapper.updateTransferBikeDetl(disCountDetlVo);
				
			}
			
			if (disCountCdCnt[i][1] > 1) {
				int listCnt=0;
				String[] ratebrokenStatusCdList = new String[3];
				for(int j=0; j < disCountCdCnt[i][1]; j++) {
					ratebrokenStatusCdList[listCnt++] = ratebrokenStatusCdList2[i][j];
				}	

				TransferBikeVo disCountDetlVo = new TransferBikeVo();
				disCountDetlVo.setRepairOursrcSeq(String.valueOf(disCountCdCnt[i][4]));
				disCountDetlVo.setDiscountRate(transferBikeVo.getDiscountRate());
				disCountDetlVo.setBrokenStatusCdList(ratebrokenStatusCdList);
				transferBikeMapper.updateTransferBikeDetl(disCountDetlVo);
			}
			if (disCountCdCnt[i][2] > 1) {
				int listCnt=0;
				String[] ratebrokenStatusCdList = new String[2];
				for(int j=0; j < disCountCdCnt[i][2]; j++) {
					ratebrokenStatusCdList[listCnt++] = ratebrokenStatusCdList3[i][j];
				}	

				TransferBikeVo disCountDetlVo = new TransferBikeVo();
				disCountDetlVo.setRepairOursrcSeq(String.valueOf(disCountCdCnt[i][4]));
				disCountDetlVo.setDiscountRate(transferBikeVo.getDiscountRate());
				disCountDetlVo.setBrokenStatusCdList(ratebrokenStatusCdList);
				transferBikeMapper.updateTransferBikeDetl(disCountDetlVo);			
			}
			if (disCountCdCnt[i][3] > 1) {
				int listCnt=0;
				String[] ratebrokenStatusCdList = new String[2];
				for(int j=0; j < disCountCdCnt[i][3]; j++) {
					ratebrokenStatusCdList[listCnt++] = ratebrokenStatusCdList4[i][j];
				}	

				TransferBikeVo disCountDetlVo = new TransferBikeVo();
				disCountDetlVo.setRepairOursrcSeq(String.valueOf(disCountCdCnt[i][4]));
				disCountDetlVo.setDiscountRate(transferBikeVo.getDiscountRate());
				disCountDetlVo.setBrokenStatusCdList(ratebrokenStatusCdList);
				transferBikeMapper.updateTransferBikeDetl(disCountDetlVo);			
			}
			
			
		}
		
		// return 1;
		return transferBikeVo.getRepairOutsrcMainSeq();
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<TransferBikeVo> getTransferBikeListExcel(TransferBikeVo transferBikeVo) {
		// TODO Auto-generated method stub
		return transferBikeMapper.getTransferBikeListExcel(transferBikeVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public TransferBikeVo getTransInfo(TransferBikeVo transferBikeVo) {
		// TODO Auto-generated method stub
		return transferBikeMapper.getTransInfo(transferBikeVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<TransferBikeVo> getBrokenInfo(TransferBikeVo transferBikeVo) {
		// TODO Auto-generated method stub
		return transferBikeMapper.getBrokenInfo(transferBikeVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public TransferBikeVo getTransferBikeInfo(TransferBikeVo transferBikeVo) {
		// TODO Auto-generated method stub
		return transferBikeMapper.getTransferBikeInfo(transferBikeVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<TransferBikeVo> getTransferBikeDetail(TransferBikeVo transferBikeVo) {
		// TODO Auto-generated method stub
		return transferBikeMapper.getTransferBikeDetail(transferBikeVo);
	}
	
	@Override
	@Transactional(readOnly= false)
	@DataSource(DataSourceType.MASTER)
	public int updateBrokenInfo(TransferBikeVo transferBikeVo) {
		// TODO Auto-generated method stub
		
//		// 시퀀스 분개 후 업데이트
//		String[] brokenPart = transferBikeVo.getBrokenStatusCd().split(",");
//		int result = 0;
//		
//		// 기존 부품 정보 삭제
//		transferBikeMapper.deleteTransferBikeDetl(transferBikeVo.getRepairOursrcSeq());
//		
//		 int rateBrokenStatusCd1 = 0;
//		 int rateBrokenStatusCd2 = 0;
//		 int rateBrokenStatusCd3 = 0;
//		 int rateBrokenStatusCd4 = 0;
//		 
//		 int cd1Cnt = 0; int cd2Cnt = 0; int cd3Cnt = 0; int cd4Cnt = 0;
//		 String[] ratebrokenStatusCdList = new String[10];
//		 String[] ratebrokenStatusCdList1 = new String[3];
//		 String[] ratebrokenStatusCdList2 = new String[3];
//		 String[] ratebrokenStatusCdList3 = new String[2];
//		 String[] ratebrokenStatusCdList4 = new String[2];
//		
//		// 부품정보 새로 넣어주기
//		for(int i=0;i<brokenPart.length;i++){
//			if(! brokenPart[i].equals("")){
//				transferBikeVo.setBrokenStatusCd(brokenPart[i]);
//				result = transferBikeMapper.addTransferBikeDetl(transferBikeVo);
//				//result = transferBikeMapper.updateTransferYn(transferBikeVo);
//				
//				System.out.println("=======================> ["+i+"] [" + transferBikeVo.getBrokenStatusCd() + "] [START]");
//				
//				if ("REC_012".equals(transferBikeVo.getBrokenStatusCd()) || "REC_013".equals(transferBikeVo.getBrokenStatusCd()) || "REC_014".equals(transferBikeVo.getBrokenStatusCd())     ) {
//					rateBrokenStatusCd1++;
//					ratebrokenStatusCdList1[cd1Cnt++] = transferBikeVo.getBrokenStatusCd();
//				}
//				if ("REC_016".equals(transferBikeVo.getBrokenStatusCd()) || "REC_017".equals(transferBikeVo.getBrokenStatusCd()) || "REC_018".equals(transferBikeVo.getBrokenStatusCd())     ) {
//					rateBrokenStatusCd2++;
//					ratebrokenStatusCdList2[cd2Cnt++] = transferBikeVo.getBrokenStatusCd();
//				}
//				if ("REC_021".equals(transferBikeVo.getBrokenStatusCd()) || "REC_022".equals(transferBikeVo.getBrokenStatusCd()) ) {
//					rateBrokenStatusCd3++;
//					ratebrokenStatusCdList3[cd3Cnt++] = transferBikeVo.getBrokenStatusCd();
//				}
//				if ("REC_024".equals(transferBikeVo.getBrokenStatusCd()) || "REC_025".equals(transferBikeVo.getBrokenStatusCd()) ) {
//					rateBrokenStatusCd4++;
//					ratebrokenStatusCdList4[cd4Cnt++] = transferBikeVo.getBrokenStatusCd();
//				}
//				System.out.println("=======================> ["+i+"] [" + transferBikeVo.getBrokenStatusCd() + "] [STOP]");				
//				
//			}
//		}
//		
//		//------------------------------------------
//		// 할인율 처리
//		//------------------------------------------
//		int listCnt = 0;
//		if (rateBrokenStatusCd1 > 1) {
//			for(int i=0; i < rateBrokenStatusCd1; i++) {
//				ratebrokenStatusCdList[listCnt++] = ratebrokenStatusCdList1[i];
//			}
//		}
//		if (rateBrokenStatusCd2 > 1) {
//			for(int i=0; i < rateBrokenStatusCd2; i++) {
//				ratebrokenStatusCdList[listCnt++] = ratebrokenStatusCdList2[i];
//			}
//		}
//		if (rateBrokenStatusCd3 > 1) {
//			for(int i=0; i < rateBrokenStatusCd3; i++) {
//				ratebrokenStatusCdList[listCnt++] = ratebrokenStatusCdList3[i];
//			}
//		}
//		if (rateBrokenStatusCd4 > 1) {
//			for(int i=0; i < rateBrokenStatusCd4; i++) {
//				ratebrokenStatusCdList[listCnt++] = ratebrokenStatusCdList4[i];
//			}
//		}		
//		
//		if (listCnt > 0) {
//			transferBikeVo.setBrokenStatusCdList(ratebrokenStatusCdList);
//			transferBikeMapper.updateTransferBikeDetl(transferBikeVo);
//		}
		
		int result = 0;
		
		if ( "U".equals( transferBikeVo.getMode()) ) {
			transferBikeMapper.addTransferBikeDetl(transferBikeVo);
		} else if ( "D".equals( transferBikeVo.getMode()) ) {
			transferBikeMapper.deleteTransferBikeDtl(transferBikeVo);
		}
		
		transferBikeMapper.updateTransferBikeDtl(transferBikeVo);
				
		return result;
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<TransferBikeVo> getCheckRepairBikeList(TransferBikeVo transferBikeVo) {
		// TODO Auto-generated method stub
		return transferBikeMapper.getCheckRepairBikeList(transferBikeVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getCheckRepairBikeListCount(TransferBikeVo transferBikeVo) {
		// TODO Auto-generated method stub
		return transferBikeMapper.getCheckRepairBikeListCount(transferBikeVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.MASTER)
	public int updateCollectYn(TransferBikeVo transferBikeVo) {
		// TODO Auto-generated method stub
		
		// 시퀀스 분개 후 업데이트
		String[] infoSeq = transferBikeVo.getRepairOursrcSeq().split(",");
		int result = 0;
		
		for(int i=0;i<infoSeq.length;i++){
			if(! infoSeq[i].equals("")){
				transferBikeVo.setRepairOursrcSeq(infoSeq[i]);
				result = transferBikeMapper.updateCollectYn(transferBikeVo);
			}
		}
		
		return result;
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int validationTransferBike(TransferBikeVo transferBikeVo) {
		// TODO Auto-generated method stub
		
		 JSONArray partsJson = null;
 		
		 partsJson = new JSONArray(transferBikeVo.getPartsData());
		
		 String tempBikeNo="";
		
		 int resultValue1 =0; 
		 
		for(int i = 0; i < partsJson.length(); i++){
				tempBikeNo= partsJson.getJSONObject(i).getString("bikeNo");
				resultValue1 = transferBikeMapper.validationTransferBike(tempBikeNo);
			   if(resultValue1 ==0){
				   return 0;
			   }
		}
		
		return 1;
	}
}
