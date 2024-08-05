package com.dkitec.barocle.admin.customer.survey.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.survey.service.SurveyMapper;
import com.dkitec.barocle.admin.customer.survey.service.SurveyService;
import com.dkitec.barocle.admin.customer.survey.vo.SurveyQestItemVO;
import com.dkitec.barocle.admin.customer.survey.vo.SurveyQestVO;
import com.dkitec.barocle.admin.customer.survey.vo.SurveyResultVO;
import com.dkitec.barocle.admin.customer.survey.vo.SurveyVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.barocle.util.webutil.StringUtil;
import com.dkitec.barocle.util.webutil.WebUtil;

@Service("surveyService")
public class SurveyServiceImpl implements SurveyService{

	@Autowired SurveyMapper surveyMapper;

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int listSurveyCount(SurveyVO surveyVO) {
		return surveyMapper.listSurveyCount(surveyVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<SurveyVO> listSurvey(SurveyVO surveyVO) {
		return surveyMapper.listSurvey(surveyVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public SurveyVO viewSurvey(SurveyVO surveyVO) {
		// 1. 모바일 설문을 가져온다.
		SurveyVO returnVO = surveyMapper.viewSurvey(surveyVO);
		// 2. 모바일 설문에 질문(들)을 가져온다.
		List<SurveyQestVO> surveyQestVO = surveyMapper.viewSurveyQest(surveyVO);
		for(int i=0; i<surveyQestVO.size(); i++){
			// 3. 각 질문의 항목 리스트를 가져온다.
			List<SurveyQestItemVO> surveyQestItemVO = surveyMapper.viewSurveyQestItem(surveyQestVO.get(i));
			// 4. 가져온 항목을 해당 질문에 넣는다.
			surveyQestVO.get(i).setSurveyQestItemVO(surveyQestItemVO);
		}
		// 5. 항목이 입력된 질문 목록을 모바일 설문 VO에 넣는다.
		returnVO.setSurveyQestVO(surveyQestVO);
		return returnVO;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public SurveyVO insertSurvey(SurveyVO surveyVO) {
		/*
		 * 설문조사는 일괄처리를 해야 하는 페이지로 SurveyVO는 계층형 자바빈 패턴을 따른다.
		 * SurveyVO는 List<SurveyQestVO> 변수를 가지고 있고, SurveyQestVO는 List<SurveyQestItemVO> 변수를 가지고 있다.
		 * 각 VO 설문.질문.항목을 나눈다면, 하나의 설문에 질문들이 있고, 또 그 질문들속에 항목들이 있다.
		 * 질문과 항목에는 flag 값과 각[qestnContent]|[itemContent]을 확인하여 해당 VO를 insert 할 여부를 결정한다.
		 * 로직 :
		 * 1. TB_COM_QESTNR_INFO(SurveyVO.qustnrSeq) 내용을 수정한다.
		 * 2. TB_COM_QESTNR_INFO(SurveyVO.qustnrSeq)와 연관된 레코드 TB_COM_QUSTNR_QESITM(SurveyQestVO.qustnrSeq) 와 TB_COM_QUSTNR_ITEM(SurveyQestItemVO.qustnrSeq)의 delYN을 'N'으로 설정한다.
		 * 3. TB_COM_QUSTNR_QESITM(SurveyQestVO.qustnrSeq&&qustnrQesitmID)을 insert한다.
		 * 	3-1. 해당 TB_COM_QUSTNR_QESITM(SurveyQestVO.qustnrSeq&&qustnrQesitmID)의 TB_COM_QUSTNR_ITEM(SurveyQestItemVO.qustnrItemID) insert한다.
		 * 4. TB_COM_QUSTNR_QESITM(SurveyQestVO.qustnrSeq&&qustnrQesitmID)을 insert한다.
		 *  4-1. 해당 TB_COM_QUSTNR_QESITM(SurveyQestVO.qustnrSeq&&qustnrQesitmID)의 TB_COM_QUSTNR_ITEM(SurveyQestItemVO.qustnrItemID) insert한다.
		 */
		int resultValue = surveyMapper.insertSurvey(surveyVO);
		
		/*daum_editor start*/
		//다음 이미지 저장
		this.updateDaumEditorImage(surveyVO,true);
		/*daum_editor end*/

		if(resultValue>0){
			List<SurveyQestVO> listSurveyQestVO = surveyVO.getSurveyQestVO();
			int surveyQestIncrement = surveyMapper.getNextQestNum(surveyVO);
			// 질문 다음 등록번호
			if(listSurveyQestVO!=null&&listSurveyQestVO.size()>0){
				for(SurveyQestVO tempSurveyQestVO : listSurveyQestVO){

					// 해당 VO 등록 여부 확인 : flag qestnContent 가 null 혹은 "" 이면 등록하지 않는다.
					if(!StringUtil.isEmpty(tempSurveyQestVO.getFlag())&&!StringUtil.isEmpty(tempSurveyQestVO.getQestnContent())){
						// 질문 PK 값을 설정 | QESTNR_SEQ QUSTNR_QESITM_ID
						tempSurveyQestVO.setQustnrSeq(surveyVO.getQustnrSeq());
						surveyQestIncrement++;
						tempSurveyQestVO.setQustnrQesitmID(WebUtil.getQuestnrID("QEST",surveyVO.getQustnrSeq(),surveyQestIncrement));
						tempSurveyQestVO.setRegID(surveyVO.getRegID());	// 등록자 설정
						tempSurveyQestVO.setModID(surveyVO.getModID());	// 수정자 설정

						SurveyVO surVo = surveyMapper.maxOrd(surveyVO);
						int ordChk = surveyMapper.maxOrdCnt(surveyVO);
					    if(0 == ordChk){
					    	String[] etcArr = surveyVO.getEtcYn().split(",");
							String etcString = "";
							for (int i = 0; i < etcArr.length; i++) {
								etcString = etcArr[i];
								if(etcString.equals("0")){
									tempSurveyQestVO.setEtcYn("Y");
								}		
							}
					    }else{
					    	if(surveyVO.getEtcYn().replace(",","") != null){
								String[] etcArr = surveyVO.getEtcYn().split(",");
								String etcString = "";
								for (int i = 0; i < etcArr.length; i++) {
									etcString = etcArr[i];
									if(etcString.equals(surVo.getQestnOrd())){
										tempSurveyQestVO.setEtcYn("Y");
									}		
								}
							}
					    }
						int resultValueDepth1 = surveyMapper.insertSurveyQest(tempSurveyQestVO);
						if(resultValueDepth1>0){
							List<SurveyQestItemVO> listSurveyQestItemVO = tempSurveyQestVO.getSurveyQestItemVO();
							int surveyQestItemIncrement = surveyMapper.getNextItemNum(tempSurveyQestVO);
							if(listSurveyQestItemVO!=null&&listSurveyQestItemVO.size()>0){	// 질문.항목이 존재 여부
								for(SurveyQestItemVO tempSurveyQestItemVO : listSurveyQestItemVO){
									// 해당 VO 등록 여부 확인 | flag itemContent 가 null 혹은 "" 이면 등록하지 않는다.
									if(!StringUtil.isEmpty(tempSurveyQestItemVO.getFlag())){
										// 질문.항목 PK 값을 설정 | QESTNR_SEQ QUSTNR_QESITM_ID QUSTNR_ITEM_ID
										tempSurveyQestItemVO.setQustnrSeq(surveyVO.getQustnrSeq());
										tempSurveyQestItemVO.setQustnrQesitmID(tempSurveyQestVO.getQustnrQesitmID());
										surveyQestItemIncrement++;
										tempSurveyQestItemVO.setQustnrItemID(WebUtil.getQuestnrID("ITEM",surveyQestIncrement,surveyQestItemIncrement));
										tempSurveyQestItemVO.setRegID(surveyVO.getRegID());	// 등록자 설정
										tempSurveyQestItemVO.setModID(surveyVO.getModID()); // 수정자 설정
										@SuppressWarnings("unused") int resultVelueDepth2 = surveyMapper.insertSurveyQestItem(tempSurveyQestItemVO);
									}
								}
							}
						}
					}
				}
			}
		}
		return surveyVO;
	}
	
	/*daum_editor start*/
	public boolean updateDaumEditorImage(SurveyVO surveyVO, boolean mode) {
		// * 이미지 파일을 업로드 했다면 noticeVO.imageList에 파일명이 저장되어 있다.
		if(mode){ surveyMapper.deleteDaumEditorImage(surveyVO); }
		if(!StringUtil.isEmpty(surveyVO.getAttach_image_info())){ surveyMapper.updateDaumEditorImage(surveyVO); }
		return true;
	}
	/*daum_editor end*/
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public SurveyVO updateSurvey(SurveyVO surveyVO){
		/*
		 * 설문조사는 일괄처리를 해야 하는 페이지로 SurveyVO는 계층형 자바빈 패턴을 따른다.
		 * SurveyVO는 List<SurveyQestVO> 변수를 가지고 있고, SurveyQestVO는 List<SurveyQestItemVO> 변수를 가지고 있다.
		 * 각 VO 설문.질문.항목을 나눈다면, 하나의 설문에 질문들이 있고, 또 그 질문들속에 항목들이 있다.
		 * 질문과 항목에는 flag,action 값과 각[qestnContent]|[itemContent]을 확인하여 해당 VO를 insert/update/delete 할 여부를 결정한다.
		 * insert/update/delete여부는 flag(true),action(insert|update)값을 확인하여 insert/update 여부를 결정하고,
		 * 질문(SurveyQestVO.qestnContent) 값과 항목(SurveyQestItemVO.itemContent) 값의 null,""을 확인하여 insert/update 결정 여부를 선택한다.
		 * 로직 :
		 * 1. TB_COM_QESTNR_INFO(SurveyVO.qustnrSeq) 내용을 수정한다.
		 * 2. TB_COM_QESTNR_INFO(SurveyVO.qustnrSeq)와 연관된 레코드 TB_COM_QUSTNR_QESITM(SurveyQestVO.qustnrSeq) 와 TB_COM_QUSTNR_ITEM(SurveyQestItemVO.qustnrSeq)의 delYN을 'N'으로 설정한다.
		 * 3. TB_COM_QUSTNR_QESITM(SurveyQestVO.qustnrSeq&&qustnrQesitmID)을 update한다.
		 * 	3-1. 해당 TB_COM_QUSTNR_QESITM(SurveyQestVO.qustnrSeq&&qustnrQesitmID)의 TB_COM_QUSTNR_ITEM(SurveyQestItemVO.qustnrItemID) update한다.
		 * 	3-2. 해당 TB_COM_QUSTNR_QESITM(SurveyQestVO.qustnrSeq&&qustnrQesitmID)의 TB_COM_QUSTNR_ITEM(SurveyQestItemVO.qustnrItemID) insert한다.
		 * 4. TB_COM_QUSTNR_QESITM(SurveyQestVO.qustnrSeq&&qustnrQesitmID)을 insert한다.
		 *  4-1. 해당 TB_COM_QUSTNR_QESITM(SurveyQestVO.qustnrSeq&&qustnrQesitmID)의 TB_COM_QUSTNR_ITEM(SurveyQestItemVO.qustnrItemID) insert한다.
		 */
		// 로직 : 1
		int resultValue = surveyMapper.updateSurvey(surveyVO);
		
		/*daum_editor start*/
		this.updateDaumEditorImage(surveyVO,true);
		/*daum_editor end*/
		
		if(resultValue>0){
			/* st 로직 : 2 */
			surveyVO.setDelYN("Y");
			@SuppressWarnings("unused") int resultDeleteQestValue = surveyMapper.deleteSurveyQest(surveyVO);
			@SuppressWarnings("unused")int resultDeleteQestItem = surveyMapper.deleteSurveyQestItem(surveyVO);
			surveyVO.setDelYN("N");
			

			/* ed 로직 : 2 */
			List<SurveyQestVO> listSurveyQestVO = surveyVO.getSurveyQestVO();
			
			int surveyQestIncrement1 = surveyMapper.getNextQestNum(surveyVO);
			int surveyQestIncrement = 0;
			if(listSurveyQestVO!=null&&listSurveyQestVO.size()>0){
				for(SurveyQestVO tempSurveyQestVO : listSurveyQestVO){
					
					// 수정 - 질문 max no가 아닌 해당 질문 no를 가져오게._20170124_cms 
					surveyQestIncrement = surveyMapper.getNextQestNum2(tempSurveyQestVO);
					
					// 해당 VO 등록 여부 확인 : flag qestnContent 가 null 혹은 "" 이면 등록하지 않는다.
					if(!StringUtil.isEmpty(tempSurveyQestVO.getFlag())&&!StringUtil.isEmpty(tempSurveyQestVO.getQestnContent())){
						// 질문 PK 값을 설정 | QESTNR_SEQ QUSTNR_QESITM_ID
						tempSurveyQestVO.setQustnrSeq(surveyVO.getQustnrSeq());
						tempSurveyQestVO.setRegID(surveyVO.getRegID());	// 등록자 설정
						tempSurveyQestVO.setModID(surveyVO.getModID());	// 수정자 설정
						// 질문 action 값이 update이면 update하고 그렇지 않으면 insert한다.
						int resultValueDepth1 = 0;

						if(!surveyVO.getEtcYn().replace(",","").equals("")){
							String[] etcArr = surveyVO.getEtcYn().split(",");
							String etcString = "";
							for (int i = 0; i < etcArr.length; i++) {
								etcString = etcArr[i];
								if(Integer.parseInt(etcString) ==  (tempSurveyQestVO.getQestnOrd()-1)){
									tempSurveyQestVO.setEtcYn("Y");
								}		
							}
						}	
						
						if("update".equalsIgnoreCase(tempSurveyQestVO.getAction())){
							resultValueDepth1 = surveyMapper.updateSurveyQest(tempSurveyQestVO);
						} else {
							SurveyVO surVo = surveyMapper.maxOrd(surveyVO);
							int ordChk = surveyMapper.maxOrdCnt(surveyVO);
							
							if(0 == ordChk){
								String[] etcArr = surveyVO.getEtcYn().split(",");
								String etcString = "";
								
								for (int i = 0; i < etcArr.length; i++) {
									etcString = etcArr[i];
									if(etcString.equals("0")){
										tempSurveyQestVO.setEtcYn("Y");
									}		
								}
						    }else{
						    	if(surveyVO.getEtcYn() != null){
									String[] etcArr = surveyVO.getEtcYn().split(",");
									String etcString = "";
									for (int i = 0; i < etcArr.length; i++) {
										etcString = etcArr[i];
										if(etcString.equals(surVo.getQestnOrd())){
											tempSurveyQestVO.setEtcYn("Y");
										}else{
											tempSurveyQestVO.setEtcYn("N");
										}		
									}
								}
						    }

							surveyQestIncrement1++;
							tempSurveyQestVO.setQustnrQesitmID(WebUtil.getQuestnrID("QEST",surveyVO.getQustnrSeq(),surveyQestIncrement1));
							resultValueDepth1 = surveyMapper.insertSurveyQest(tempSurveyQestVO);
						}
						// end
						if(resultValueDepth1>0){
							List<SurveyQestItemVO> listSurveyQestItemVO = tempSurveyQestVO.getSurveyQestItemVO();
							int surveyQestItemIncrement = surveyMapper.getNextItemNum(tempSurveyQestVO);
							if(listSurveyQestItemVO!=null&&listSurveyQestItemVO.size()>0){	// 질문.항목이 존재 여부
								for(SurveyQestItemVO tempSurveyQestItemVO : listSurveyQestItemVO){
									// 해당 VO 등록 여부 확인 | flag itemContent 가 null 혹은 "" 이면 등록하지 않는다.
									if(!StringUtil.isEmpty(tempSurveyQestItemVO.getFlag())){
										// 질문.항목 PK 값을 설정 | QESTNR_SEQ QUSTNR_QESITM_ID QUSTNR_ITEM_ID
										tempSurveyQestItemVO.setQustnrSeq(surveyVO.getQustnrSeq());
										tempSurveyQestItemVO.setQustnrQesitmID(tempSurveyQestVO.getQustnrQesitmID());
										tempSurveyQestItemVO.setRegID(surveyVO.getRegID());	// 등록자 설정
										tempSurveyQestItemVO.setModID(surveyVO.getModID()); // 수정자 설정
										// 항목 action 값이 update이면 update하고 그렇지 않으면 insert한다.
										@SuppressWarnings("unused") int resultValueDepth2 = 0;
										if("update".equalsIgnoreCase(tempSurveyQestItemVO.getAction())){
											resultValueDepth2 = surveyMapper.updateSurveyQestItem(tempSurveyQestItemVO);
										} else {
											surveyQestItemIncrement++;
											
											if(surveyQestIncrement == 0){
												tempSurveyQestItemVO.setQustnrItemID(WebUtil.getQuestnrID("ITEM",surveyQestIncrement1,surveyQestItemIncrement));
											}else{
												tempSurveyQestItemVO.setQustnrItemID(WebUtil.getQuestnrID("ITEM",surveyQestIncrement,surveyQestItemIncrement));
											}
											
											resultValueDepth2 = surveyMapper.insertSurveyQestItem(tempSurveyQestItemVO);
										}
										// end
									}
								}
							}
						}
					}
				}
			}
		}
		return surveyVO;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int deleteSurvey(SurveyVO surveyVO) {
		surveyVO.setDelYN("Y");
		return surveyMapper.deleteSurvey(surveyVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<SurveyResultVO> viewSurveyResult(SurveyVO surveyVO) {
		return surveyMapper.viewSurveyResult(surveyVO);
	}

	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<SurveyVO> getEtcList(SurveyVO surveyVO) {
		return surveyMapper.getEtcList(surveyVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<DaumEditorVO> listDaumEditorVO(SurveyVO surveyVO) {
		// TODO Auto-generated method stub
		return surveyMapper.getDaumEditorImage(surveyVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<SurveyResultVO> viewSurveyResultExcel(SurveyVO surveyVO) {
		return surveyMapper.viewSurveyResultExcel(surveyVO);
	}
}
