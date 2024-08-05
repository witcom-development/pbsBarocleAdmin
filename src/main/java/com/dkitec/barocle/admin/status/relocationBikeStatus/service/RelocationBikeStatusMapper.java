/*
 * @Package Name : com.dkitec.barocle.admin.status.relocationBikeStatus.service
 * @파일명          : RelocationBikeStatusMapper.java
 * @작성일          : 2015. 5. 21.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 21.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.status.relocationBikeStatus.service;

import java.util.List;

import com.dkitec.barocle.admin.manage.relocationcar.vo.RelocationCarVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * @파일명          : RelocationBikeStatusMapper.java
 * @작성일          : 2015. 5. 21.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 21.   |   ymshin   |  최초작성
 */
@Mapper("relocationBikeStatusMapper")
public interface RelocationBikeStatusMapper {

	/**
	 * @location : com.dkitec.barocle.admin.status.relocationBikeStatus.service.RelocationBikeStatusMapper.getRelocationBikeStatusList
	 * @writeDay : 2015. 5. 21. 오전 11:35:42
	 * @return   : List<RelocationBikeVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 21.   |   ymshin   |  최초작성
	 */ 
	List<RelocationCarVO> getRelocationBikeStatusList();

}
