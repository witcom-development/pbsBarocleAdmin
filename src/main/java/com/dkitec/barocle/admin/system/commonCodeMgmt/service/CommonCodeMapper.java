/*
 * @Package Name : com.dkitec.barocle.admin.system.commonCodeMgmt.service
 * @파일명          : CommonCodeMapper.java
 * @작성일          : 2015. 4. 8.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 8.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.system.commonCodeMgmt.service;

import java.util.List;
import java.util.Map;

import com.dkitec.barocle.admin.common.vo.TroubleReportVO;
import com.dkitec.barocle.admin.status.rentHistory.vo.PenaltyVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCenterVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonStationVO;
import com.dkitec.barocle.admin.system.usermgmt.vo.UserMgmtVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * @파일명          : CommonCodeMapper.java
 * @작성일          : 2015. 4. 8.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 8.   |   ymshin   |  최초작성
 */
@Mapper(value="commonCodeMapper")
public interface CommonCodeMapper {

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeMapper.getAdmComCodeListCnt
	 * @writeDay : 2015. 4. 8. 오후 3:29:56
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 8.   |   ymshin   |  최초작성
	 */ 
	int getAdmComCodeListCnt(CommonCodeVO codeVO);

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeMapper.getAdmComCodeListPading
	 * @writeDay : 2015. 4. 8. 오후 3:30:02
	 * @return   : List<CommonCodeVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 8.   |   ymshin   |  최초작성
	 */ 
	List<CommonCodeVO> getAdmComCodeListPading(CommonCodeVO codeVO);

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeMapper.getAdmComCodeList
	 * @writeDay : 2015. 4. 8. 오후 3:30:12
	 * @return   : List<CommonCodeVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 8.   |   ymshin   |  최초작성
	 */ 
	List<CommonCodeVO> getAdmComCodeList(CommonCodeVO codeVO);

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeMapper.getAdmComCodeInfo
	 * @writeDay : 2015. 4. 8. 오후 3:32:41
	 * @return   : CommonCodeVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 8.   |   ymshin   |  최초작성
	 */ 
	CommonCodeVO getAdmComCodeInfo(CommonCodeVO codeVO);

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeMapper.setAdmComCode
	 * @writeDay : 2015. 4. 8. 오후 3:34:54
	 * @return   : void
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 8.   |   ymshin   |  최초작성
	 */ 
	int setAdmComCode(CommonCodeVO codeVO);

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeMapper.addAdmComCode
	 * @writeDay : 2015. 4. 8. 오후 3:37:15
	 * @return   : void
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 8.   |   ymshin   |  최초작성
	 */ 
	int addAdmComCode(CommonCodeVO tempVO);

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeMapper.isExistCode
	 * @writeDay : 2015. 4. 8. 오후 3:42:10
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 8.   |   ymshin   |  최초작성
	 */ 
	int isExistCode(String code);

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeMapper.getComCodeList
	 * @writeDay : 2015. 4. 8. 오후 3:49:21
	 * @return   : List<Object>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 8.   |   ymshin   |  최초작성
	 */ 
	List<CommonCodeVO> getComCodeList(Map<Object, Object> hm);

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeMapper.getUpcodeDspOrdNum
	 * @writeDay : 2015. 4. 15. 오전 9:23:34
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 15.   |   ymshin   |  최초작성
	 */ 
	int getUpcodeDspOrdNum();

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeMapper.getComCodeInfo
	 * @writeDay : 2015. 4. 20. 오후 3:59:14
	 * @return   : List<CommonCodeVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 20.   |   ymshin   |  최초작성
	 */ 
	List<CommonCodeVO> getComCodeInfo(CommonCodeVO cVo);

	CommonCodeVO getComCodeVal(CommonCodeVO cVo);

	/**
	 * @param pVo 
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeMapper.getStationGrp
	 * @writeDay : 2015. 4. 20. 오후 5:27:48
	 * @return   : List<CommonStationVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 20.   |   ymshin   |  최초작성
	 */ 
	List<CommonStationVO> getStationGrp(CommonStationVO pVo);

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeMapper.getStation
	 * @writeDay : 2015. 4. 20. 오후 5:32:29
	 * @return   : List<CommonStationVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 20.   |   ymshin   |  최초작성
	 */ 
	List<CommonStationVO> getStation(CommonStationVO vo);

	List<CommonCenterVO> getCenterInfo();
	
	/*
	 * 2019.03.04 바로클포 조회
	 */
	List<CommonCenterVO> getCenterMallInfo();

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeMapper.getLangInfo
	 * @writeDay : 2015. 4. 21. 오후 5:32:41
	 * @return   : List<CommonCodeVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	List<CommonCodeVO> getLangInfo(String comCd);

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeMapper.addSysLangName
	 * @writeDay : 2015. 4. 21. 오후 6:09:12
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	int addSysLangName(CommonCodeVO l);

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeMapper.setSysLangName
	 * @writeDay : 2015. 4. 21. 오후 6:09:56
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	int setSysLangName(CommonCodeVO l);

	int getChkLangCode(CommonCodeVO l);

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeMapper.getSubCode
	 * @writeDay : 2015. 4. 28. 오전 10:37:12
	 * @return   : List<CommonCodeVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 28.   |   ymshin   |  최초작성
	 */ 
	List<CommonCodeVO> getSubCode(String comCd);

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeMapper.getUserInfo
	 * @writeDay : 2015. 5. 8. 오후 5:50:16
	 * @return   : List<UserMgmtVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 8.   |   ymshin   |  최초작성
	 */ 
	List<UserMgmtVO> getUserInfo(UserMgmtVO userVo);
	List<UserMgmtVO> getRepBikeAdminInfo(UserMgmtVO userVo);
	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeMapper.getPenaltyCode
	 * @writeDay : 2015. 5. 8. 오후 5:50:16
	 * @return   : List<UserMgmtVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 15.   |   ymshin   |  최초작성
	 */
	List<PenaltyVO> getPenaltyCode();

	List<TroubleReportVO> getFaultList(TroubleReportVO troubleReportVo);
	
}
