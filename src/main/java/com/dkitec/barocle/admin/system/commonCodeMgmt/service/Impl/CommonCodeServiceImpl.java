/*
 * @Package Name : com.dkitec.barocle.admin.system.commonCodeMgmt.service.Impl
 * @파일명          : CommonCodeServiceImpl.java
 * @작성일          : 2015. 4. 8.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 8.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.system.commonCodeMgmt.service.Impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.common.vo.TroubleReportVO;
import com.dkitec.barocle.admin.status.rentHistory.vo.PenaltyVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeMapper;
import com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCenterVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonStationVO;
import com.dkitec.barocle.admin.system.usermgmt.vo.UserMgmtVO;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @파일명          : CommonCodeServiceImpl.java
 * @작성일          : 2015. 4. 8.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 8.   |   ymshin   |  최초작성
 */
@Service(value="commonCodeService")
public class CommonCodeServiceImpl extends EgovAbstractServiceImpl implements CommonCodeService {

	@Autowired private CommonCodeMapper commonCodeMapper;
	/**
	 * @location   : com.dkitec.barocle.admin.system.commonCodeMgmt.service.Impl.CommonCodeService.getAdmComCodeList
	 * @writeDay   : 2015. 4. 8. 오후 3:02:46
	 * @overridden : @see com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService#getAdmComCodeList(com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<CommonCodeVO> getAdmComCodeList(CommonCodeVO codeVO) throws SQLException {
		
		return commonCodeMapper.getAdmComCodeList(codeVO); 
	}
	
	/**
	 * @location   : com.dkitec.barocle.admin.system.commonCodeMgmt.service.Impl.CommonCodeService.getAdmComCodeInfo
	 * @writeDay   : 2015. 4. 8. 오후 3:02:46
	 * @overridden : @see com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService#getAdmComCodeInfo(com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public HashMap<Object, Object> getAdmComCodeInfo(CommonCodeVO codeVO) throws SQLException {
		
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		
		CommonCodeVO vo = commonCodeMapper.getAdmComCodeInfo(codeVO);
		List<CommonCodeVO> ccList = commonCodeMapper.getLangInfo(vo.getComCd());
		for(CommonCodeVO cVo : ccList) {
			setLangComList(cVo, vo);
		}
		
		map.put("parentCode", vo);
		codeVO.setComUpCd(codeVO.getComCd());
		List<CommonCodeVO> list = commonCodeMapper.getSubCode(codeVO.getComCd());
		for(CommonCodeVO item : list) {
			ccList = commonCodeMapper.getLangInfo(item.getComCd());
			for(CommonCodeVO cVo : ccList) {
				setLangComList(cVo, item);
			}
		}
		
		map.put("childCodeList", list);
		return map;
	}
	
	private void setLangComList(CommonCodeVO pVo, CommonCodeVO setVo) {
		if(pVo.getLang().equals(IConstants.LANG_EN)) {
			setVo.setComCdNameEn(pVo.getComCdName());
		} else if(pVo.getLang().equals(IConstants.LANG_JA)) {
			setVo.setComCdNameJa(pVo.getComCdName());
		} else if(pVo.getLang().equals(IConstants.LANG_ZH)) {
			setVo.setComCdNameZh(pVo.getComCdName());
		} else {
			setVo.setComCdNameKo(pVo.getComCdName());
		}
	}
	/**
	 * @location   : com.dkitec.barocle.admin.system.commonCodeMgmt.service.Impl.CommonCodeService.setAdmComCode
	 * @writeDay   : 2015. 4. 8. 오후 3:02:46
	 * @overridden : @see com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService#setAdmComCode(com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly=false, rollbackFor = {Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int setAdmComCode(CommonCodeVO codeVO) throws SQLException {
		int result =0;
		//parent update
		result = commonCodeMapper.setAdmComCode(codeVO);
		List<CommonCodeVO> upComList = codeVO.getLangList();
		//상위코드
		if(upComList.size() > 0) {
			for(CommonCodeVO upVo : upComList) {
				upVo.setComCd(codeVO.getComCd());
				if(upVo.getComCdName().equals("")){
					continue;
				}
				int isExsit = commonCodeMapper.getChkLangCode(upVo);
				if(isExsit == 0) {
					result = commonCodeMapper.addSysLangName(upVo);
				} else {
					result = commonCodeMapper.setSysLangName(upVo);	
				}
			}
		}
		List<CommonCodeVO> tempVO = null;
		//하위 서브코드
		if( result >= 0   && codeVO.getCodeList() != null && codeVO.getCodeList().size() > 0) {
			tempVO = codeVO.getCodeList();
			
			for(CommonCodeVO vo : tempVO) {
				if(IConstants.CRUD_C.equals(vo.getCrudFlg())) {
					//insert
					vo.setComUpCd(codeVO.getComCd());
					result = commonCodeMapper.addAdmComCode(vo);
				} else {
					//update
					result = commonCodeMapper.setAdmComCode(vo);
				}
				List<CommonCodeVO> lang = vo.getLangList();
				for( CommonCodeVO l : lang ) {
					l.setComCd(vo.getComCd());
					if(l.getComCdName().equals("")){
						continue;
					}
					int isExsit = commonCodeMapper.getChkLangCode(l);
					if(isExsit == 0) {
						result = commonCodeMapper.addSysLangName(l);
					} else {
						result = commonCodeMapper.setSysLangName(l);	
					}
				}
			}
		}
		return result;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.commonCodeMgmt.service.Impl.CommonCodeService.addAdmComCode
	 * @writeDay   : 2015. 4. 8. 오후 3:02:46
	 * @overridden : @see com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService#addAdmComCode(com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=false, propagation= Propagation.REQUIRED, rollbackFor = {Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int addAdmComCode(CommonCodeVO codeVO) throws SQLException {
		int result = 0;
		
		result = commonCodeMapper.addAdmComCode(codeVO);
		codeVO.setLang(IConstants.LANG_KR);
		List<CommonCodeVO> lang = codeVO.getLangList();
		for( CommonCodeVO l : lang ) {
			l.setComCd(codeVO.getComCd());
			int isExsit = commonCodeMapper.getChkLangCode(l);
			if(isExsit == 0) {
				result = commonCodeMapper.addSysLangName(l);
			} else {
				result = commonCodeMapper.setSysLangName(l);	
			}
		}
		return result;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.commonCodeMgmt.service.Impl.CommonCodeService.isExistCode
	 * @writeDay   : 2015. 4. 8. 오후 3:18:33
	 * @overridden : @see com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService#isExistCode(com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int isExistCode(String code) throws SQLException {
		return  commonCodeMapper.isExistCode(code);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.commonCodeMgmt.service.Impl.CommonCodeService.getComCodeList
	 * @writeDay   : 2015. 4. 8. 오후 3:47:58
	 * @overridden : @see com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService#getComCodeList(java.lang.String)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<CommonCodeVO> getComCodeList(String cateCode) throws Exception {
		// TODO Auto-generated method stub
		return  getComCodeList(cateCode, true);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public CommonCodeVO getComCodeVal(CommonCodeVO codeVO) {
		
		return commonCodeMapper.getComCodeVal(codeVO); 
	}
	
	/**
	 * @location   : com.dkitec.barocle.admin.system.commonCodeMgmt.service.Impl.CommonCodeService.getComCodeList
	 * @writeDay   : 2015. 4. 8. 오후 3:47:58
	 * @overridden : @see com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService#getComCodeList(java.lang.String, boolean)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<CommonCodeVO> getComCodeList(String cateCode, boolean useOnly) throws SQLException {
		// TODO Auto-generated method stub
		Map<Object, Object> hm = new HashMap<Object, Object>();
		hm.put("COM_UP_CD", cateCode);
		hm.put("USE_YN", useOnly == true ? "Y" : "");
		
		List<CommonCodeVO> result = commonCodeMapper.getComCodeList(hm);
		return result;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.commonCodeMgmt.service.Impl.CommonCodeService.getUpcodeDspOrdNum
	 * @writeDay   : 2015. 4. 15. 오전 9:23:18
	 * @overridden : @see com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService#getUpcodeDspOrdNum()
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getUpcodeDspOrdNum() {
		// TODO Auto-generated method stub
		return commonCodeMapper.getUpcodeDspOrdNum();
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.commonCodeMgmt.service.Impl.CommonCodeService.getComCodeInfo
	 * @writeDay   : 2015. 4. 20. 오후 3:58:45
	 * @overridden : @see com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService#getComCodeInfo(java.lang.String)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<CommonCodeVO> getComCodeInfo(CommonCodeVO cVo) {
		// TODO Auto-generated method stub
		return commonCodeMapper.getComCodeInfo(cVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.commonCodeMgmt.service.Impl.CommonCodeService.getComStation
	 * @writeDay   : 2015. 4. 20. 오후 5:14:44
	 * @overridden : @see com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService#getComStation()
	 * @Todo       : 스테이션 그룹 그에 해당하는 스테이션을 취득.
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<CommonStationVO> getComStation(CommonStationVO pVo) {
		// TODO Auto-generated method stub
		
		CommonStationVO stationVo = null;
		
		List<CommonStationVO> pStation =  commonCodeMapper.getStationGrp(pVo);
		
		List<CommonStationVO> resultList = new ArrayList<CommonStationVO>();
		
		for(CommonStationVO vo : pStation ) {
			stationVo = new CommonStationVO();
			vo.setLang(pVo.getLang());
			stationVo.setStationId(vo.getStationId());
			stationVo.setStationName(vo.getStationName());
			
			stationVo.setStationList(commonCodeMapper.getStation(vo));
			resultList.add(stationVo);
		}
		
		return resultList;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<CommonCenterVO> getCenterInfo() {
		// TODO Auto-generated method stub
		return commonCodeMapper.getCenterInfo();
	}

	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<CommonCenterVO> getCenterMallInfo() {
		// TODO Auto-generated method stub
		return commonCodeMapper.getCenterMallInfo();
	}
	
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getAdmComCodeListCnt(CommonCodeVO codeVO) {
		// TODO Auto-generated method stub
		return commonCodeMapper.getAdmComCodeListCnt(codeVO);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.system.commonCodeMgmt.service.Impl.CommonCodeService.getUserInfo
	 * @writeDay   : 2015. 5. 8. 오후 5:49:35
	 * @overridden : @see com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService#getUserInfo(com.dkitec.barocle.admin.system.usermgmt.vo.UserMgmtVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<UserMgmtVO> getUserInfo(UserMgmtVO userVo) {
		// TODO Auto-generated method stub
		return commonCodeMapper.getUserInfo(userVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<UserMgmtVO> getRepBikeAdminInfo(UserMgmtVO userVo) {
		// TODO Auto-generated method stub
		return commonCodeMapper.getRepBikeAdminInfo(userVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<PenaltyVO> getPenaltyCode() {
		// TODO Auto-generated method stub
		return commonCodeMapper.getPenaltyCode();
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<TroubleReportVO> getFaultList(TroubleReportVO troubleReportVo) {
		return commonCodeMapper.getFaultList(troubleReportVo);
		
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<CommonStationVO> getComStationGrp(CommonStationVO pVo) {
		// TODO Auto-generated method stub
		
		CommonStationVO stationVo = null;
		
		List<CommonStationVO> pStation =  commonCodeMapper.getStationGrp(pVo);
		
		List<CommonStationVO> resultList = new ArrayList<CommonStationVO>();
		
		for(CommonStationVO vo : pStation ) {
			stationVo = new CommonStationVO();
			vo.setLang(pVo.getLang());
			stationVo.setStationId(vo.getStationId());
			stationVo.setStationName(vo.getStationName());
			
			stationVo.setStationList(commonCodeMapper.getStation(vo));
			resultList.add(stationVo);
		}
		
		return resultList;
	}
}
