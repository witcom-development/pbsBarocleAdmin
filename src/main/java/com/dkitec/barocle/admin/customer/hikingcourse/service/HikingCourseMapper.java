package com.dkitec.barocle.admin.customer.hikingcourse.service;

import java.util.List;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.hikingcourse.vo.HikingCourseVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("hikingCourseMapper")
public interface HikingCourseMapper {
	
	public int listHikingCourseCount(HikingCourseVO hikingCourseVO);
	
	public java.util.List<HikingCourseVO> listHikingCourse(HikingCourseVO hikingCourseVO);
	
	public HikingCourseVO viewHikingCourse(HikingCourseVO hikingCourseVO);
	
	public List<DaumEditorVO> getDaumEditorImage(HikingCourseVO hikingCourseVO);
	
	public HikingCourseVO prevHikingCourse(HikingCourseVO hikingCourseVO);
	
	public HikingCourseVO nextHikingCourse(HikingCourseVO hikingCourseVO);
	
	public int insertHikingCourse(HikingCourseVO hikingCourseVO);
	
	public int updateHikingCourse(HikingCourseVO hikingCourseVO);
	
	public int deleteDaumEditorImage(HikingCourseVO hikingCourseVO);
	
	public int updateDaumEditorImage(HikingCourseVO hikingCourseVO);
	
	public int deleteHikingCourse(HikingCourseVO hikingCourseVO);

}
