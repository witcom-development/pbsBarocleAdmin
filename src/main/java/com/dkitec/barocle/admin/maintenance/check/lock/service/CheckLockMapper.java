package com.dkitec.barocle.admin.maintenance.check.lock.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.check.lock.vo.CheckLockVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("checkLockMapper")
public interface CheckLockMapper {

	List<CheckLockVO> getCheckLockList(CheckLockVO checkLockVo);

	int getCheckLockListCount(CheckLockVO checkLockVo);

	int exeLockCheck(CheckLockVO checkLockVo);
}
