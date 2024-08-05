package com.dkitec.barocle.admin.maintenance.check.bike.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.check.bike.vo.CheckBikeVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("checkBikeMapper")
public interface CheckBikeMapper {

	List<CheckBikeVO> getCheckBikeList(CheckBikeVO checkBikeVo);

	int getCheckBikeListCount(CheckBikeVO checkBikeVo);

	int exeBikeCheck(CheckBikeVO checkBikeVO);

}
