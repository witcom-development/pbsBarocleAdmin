package com.dkitec.barocle.admin.maintenance.distMgmt.massMove.controller;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.barocle.admin.maintenance.distMgmt.massMove.service.MassMoveService;
import com.dkitec.barocle.base.BaseController;


@Controller
@RequestCategory("MassMoveController")
public class MassMoveController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(MassMoveController.class);
	private static final String RETURN_URL = "/admin/maintenance/distMgmt/massMove/";
	
	@Resource(name="massMoveService") private MassMoveService massMoveService;
	
	
	
}
