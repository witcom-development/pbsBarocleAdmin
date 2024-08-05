/*
 * @Package Name : com.dkitec.barocle.admin.system.commonCodeMgmt.service
 * @파일명          : CommonCodeService.java
 * @작성일          : 2015. 4. 8.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 8.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.system.commonCodeMgmt.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import com.dkitec.barocle.admin.common.vo.TroubleReportVO;
import com.dkitec.barocle.admin.status.rentHistory.vo.PenaltyVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCenterVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonStationVO;
import com.dkitec.barocle.admin.system.usermgmt.vo.UserMgmtVO;

/**
 * @파일명          : CommonCodeService.java
 * @작성일          : 2015. 4. 8.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 8.   |   ymshin   |  최초작성
 */
public interface CommonCodeService {

	
	/** 
	 * USE_YN : Y인 공통코드만 조회
	 * 
	 * @param cateCode 가져올려는 공통코드의 UP_CODE
	 * @return
	 * @throws Exception
	 */
	List<CommonCodeVO> getComCodeList(String cateCode) throws Exception;
	
	/** 
	 * useOnly : true (USE_YN : Y 인 공통코드만 조회)
	 * useOnly : true (해당 전체 공통코드 조회)
	 * 
	 * @param cateCode 가져올려는 공통코드의 UP_CODE
	 * @param useOnly true, false
	 * @return
	 * @throws Exception
	 */
	List<CommonCodeVO> getComCodeList(String cateCode, boolean useOnly) throws Exception;
	

	CommonCodeVO getComCodeVal(CommonCodeVO cVo);
	
	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService.getAdmComCodeList
	 * @writeDay : 2015. 4. 8. 오후 2:46:40
	 * @return   : Map<String,Object>
	 * @throws SQLException 
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 8.   |   ymshin   |  최초작성
	 */ 
	List<CommonCodeVO> getAdmComCodeList(CommonCodeVO codeVO) throws SQLException;

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService.getAdmComCodeInfo
	 * @writeDay : 2015. 4. 8. 오후 2:46:59
	 * @return   : Map<Object,Object>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 8.   |   ymshin   |  최초작성
	 */ 
	HashMap<Object, Object> getAdmComCodeInfo(CommonCodeVO codeVO) throws SQLException;

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService.setAdmComCode
	 * @writeDay : 2015. 4. 8. 오후 2:48:00
	 * @return   : void
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 8.   |   ymshin   |  최초작성
	 */ 
	int setAdmComCode(CommonCodeVO codeVO) throws SQLException;

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService.addAdmComCode
	 * @writeDay : 2015. 4. 8. 오후 3:00:30
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 8.   |   ymshin   |  최초작성
	 */ 
	int addAdmComCode(CommonCodeVO codeVO) throws SQLException;

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService.isExistCode
	 * @writeDay : 2015. 4. 8. 오후 3:14:56
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 8.   |   ymshin   |  최초작성
	 */ 
	int isExistCode(String codeVO) throws SQLException;

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService.getUpcodeDspOrdNum
	 * @writeDay : 2015. 4. 15. 오전 9:23:03
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 15.   |   ymshin   |  최초작성
	 */ 
	int getUpcodeDspOrdNum();

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService.getComCodeInfo
	 * @writeDay : 2015. 4. 20. 오후 3:58:13
	 * @return   : List<CommonCodeVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 20.   |   ymshin   |  최초작성
	 */ 
	List<CommonCodeVO> getComCodeInfo(CommonCodeVO cVo);

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService.getComStation
	 * @writeDay : 2015. 4. 20. 오후 5:08:44
	 * @return   : CommonStationVO
	 * @Todo     : 공통 아파트과 대여소 정보 취득.
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 20.   |   ymshin   |  최초작성
	 */ 
	List<CommonStationVO> getComStation(CommonStationVO codeVO);
	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService.getCenterInfo
	 * @writeDay : 2015. 4. 20. 오후 5:08:44
	 * @return   : CommonStationVO
	 * @Todo     : 센터 정보 취득.
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 20.   |   ymshin   |  최초작성
	 */ 
	List<CommonCenterVO> getCenterInfo();
	
	/*
	 * 2019.03.04 바로클포 센터조회
	 */
	List<CommonCenterVO> getCenterMallInfo();

	int getAdmComCodeListCnt(CommonCodeVO codeVO);

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService.getUserInfo
	 * @writeDay : 2015. 5. 8. 오후 5:49:16
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
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService.getPenaltyCode
	 * @writeDay : 2015. 5. 8. 오후 5:49:16
	 * @return   : List<UserMgmtVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 15.   |   ymshin   |  최초작성
	 */
	List<PenaltyVO> getPenaltyCode();
	
	List<TroubleReportVO> getFaultList(TroubleReportVO troubleReportVo);
	
	List<CommonStationVO> getComStationGrp(CommonStationVO codeVO);

}
