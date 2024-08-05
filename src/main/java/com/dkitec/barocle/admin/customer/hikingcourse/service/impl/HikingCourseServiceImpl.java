package com.dkitec.barocle.admin.customer.hikingcourse.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.faq.service.FaqMapper;
import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;
import com.dkitec.barocle.admin.customer.hikingcourse.service.HikingCourseMapper;
import com.dkitec.barocle.admin.customer.hikingcourse.service.HikingCourseService;
import com.dkitec.barocle.admin.customer.hikingcourse.vo.HikingCourseVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.barocle.util.webutil.StringUtil;

@Service("hikingCourseService")
public class HikingCourseServiceImpl implements HikingCourseService {
	
	@Autowired HikingCourseMapper hikingCourseMapper;
	@Autowired FaqMapper faqMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int listHikingCourseCount(HikingCourseVO hikingCourseVO) {
		return hikingCourseMapper.listHikingCourseCount(hikingCourseVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<HikingCourseVO> listHikingCourse(HikingCourseVO hikingCourseVO) {
		return hikingCourseMapper.listHikingCourse(hikingCourseVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<CategoryVO> listHikingCourseCategory(CategoryVO categoryVO, String comCD) {
		categoryVO.setComCD(comCD);
		return faqMapper.listCategory(categoryVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public Map<String,HikingCourseVO> viewHikingCourse(HikingCourseVO hikingCourseVO) throws Exception {
		Map<String,HikingCourseVO> returnMap = null;
		HikingCourseVO returnVO = null;
		try{
			returnMap = new HashMap<String,HikingCourseVO>();
			returnVO = hikingCourseMapper.viewHikingCourse(hikingCourseVO);
			returnMap.put("returnVO", returnVO);
			//returnMap.put("prevHikingCourseVO", (HikingCourseVO)hikingCourseMapper.prevHikingCourse(hikingCourseVO));
			//returnMap.put("nextHikingCourseVO", (HikingCourseVO)hikingCourseMapper.nextHikingCourse(hikingCourseVO));
		} catch (Exception e){
			throw e;
		}
		return returnMap;
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<DaumEditorVO> listDaumEditorVO(HikingCourseVO hikingCourseVO) {
		return hikingCourseMapper.getDaumEditorImage(hikingCourseVO);
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public HikingCourseVO insertHikingCourse(HikingCourseVO hikingCourseVO) {
		hikingCourseVO.setUseYN("Y");
		@SuppressWarnings("unused") int hikingCourseSequenceNumber = hikingCourseMapper.insertHikingCourse(hikingCourseVO);
		this.updateDaumEditorImage(hikingCourseVO,false);
		return hikingCourseVO;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public HikingCourseVO updateHikingCourse(HikingCourseVO hikingCourseVO) {
		@SuppressWarnings("unused") int resultModify = hikingCourseMapper.updateHikingCourse(hikingCourseVO);
		this.updateDaumEditorImage(hikingCourseVO,true);
		return hikingCourseVO;
	}
	
	public boolean updateDaumEditorImage(HikingCourseVO hikingCourseVO, boolean mode) {
		// * 이미지 파일을 업로드 했다면 noticeVO.imageList에 파일명이 저장되어 있다.
		if(mode){ hikingCourseMapper.deleteDaumEditorImage(hikingCourseVO); }
		if(!StringUtil.isEmpty(hikingCourseVO.getAttach_image_info())){ hikingCourseMapper.updateDaumEditorImage(hikingCourseVO); }
		return true;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int deleteHikingCourse(HikingCourseVO hikingCourseVO) {
		hikingCourseVO.setUseYN("N");
		return hikingCourseMapper.deleteHikingCourse(hikingCourseVO);
	}

}
