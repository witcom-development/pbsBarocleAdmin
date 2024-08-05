package com.dkitec.barocle.admin.maintenance.distMgmt.massMove.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dkitec.barocle.admin.maintenance.distMgmt.massMove.service.MassMoveMapper;
import com.dkitec.barocle.admin.maintenance.distMgmt.massMove.service.MassMoveService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="massMoveService")
public class MassMoveServiceImpl extends EgovAbstractServiceImpl implements MassMoveService {

	@Autowired private MassMoveMapper massMoveMapper;

}
