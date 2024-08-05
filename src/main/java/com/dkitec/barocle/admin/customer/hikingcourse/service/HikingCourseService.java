package com.dkitec.barocle.admin.customer.hikingcourse.service;

import java.util.List;
import java.util.Map;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;
import com.dkitec.barocle.admin.customer.hikingcourse.vo.HikingCourseVO;

public interface HikingCourseService {
	
	public int listHikingCourseCount(HikingCourseVO hikingCourseVO);
	
	public List<HikingCourseVO> listHikingCourse(HikingCourseVO hikingCourseVO);
	
	public List<CategoryVO> listHikingCourseCategory(CategoryVO categoryVO, String comCD);
	
	public Map<String,HikingCourseVO> viewHikingCourse(HikingCourseVO hikingCourseVO) throws Exception;
	
	public List<DaumEditorVO> listDaumEditorVO(HikingCourseVO hikingCourseVO);
	
	public HikingCourseVO insertHikingCourse(HikingCourseVO hikingCourseVO);
	
	public HikingCourseVO updateHikingCourse(HikingCourseVO hikingCourseVO);
	
	public int deleteHikingCourse(HikingCourseVO hikingCourseVO);

}
