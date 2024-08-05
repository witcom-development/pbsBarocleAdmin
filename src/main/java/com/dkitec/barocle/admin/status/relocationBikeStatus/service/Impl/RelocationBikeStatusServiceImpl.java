/*
 * @Package Name : com.dkitec.barocle.admin.status.relocationBikeStatus.service.Impl
 * @파일명          : RelocationBikeStatusServiceImpl.java
 * @작성일          : 2015. 5. 21.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 21.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.status.relocationBikeStatus.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dkitec.barocle.admin.manage.relocationcar.vo.RelocationCarVO;
import com.dkitec.barocle.admin.status.relocationBikeStatus.service.RelocationBikeStatusMapper;
import com.dkitec.barocle.admin.status.relocationBikeStatus.service.RelocationBikeStatusService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @파일명          : RelocationBikeStatusServiceImpl.java
 * @작성일          : 2015. 5. 21.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 21.   |   ymshin   |  최초작성
 */
@Service(value="relocationBikeStatusService")
public class RelocationBikeStatusServiceImpl extends EgovAbstractServiceImpl implements RelocationBikeStatusService {

	@Autowired private RelocationBikeStatusMapper relocateBikeStatusMapper;

	/**
	 * @location   : com.dkitec.barocle.admin.status.relocationBikeStatus.service.Impl.RelocationBikeStatusService.getRelocationBikeStatusList
	 * @writeDay   : 2015. 5. 21. 오전 11:35:30
	 * @overridden : @see com.dkitec.barocle.admin.status.relocationBikeStatus.service.RelocationBikeStatusService#getRelocationBikeStatusList()
	 * @Todo       :
	 */ 
	@Override
	public List<RelocationCarVO> getRelocationBikeStatusList() {
		// TODO Auto-generated method stub
		return relocateBikeStatusMapper.getRelocationBikeStatusList();
	}
}
