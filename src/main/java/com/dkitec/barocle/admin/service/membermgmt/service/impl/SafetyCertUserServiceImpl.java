package com.dkitec.barocle.admin.service.membermgmt.service.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.service.membermgmt.service.SafetyCertMapper;
import com.dkitec.barocle.admin.service.membermgmt.service.SafetyCertUserService;
import com.dkitec.barocle.admin.service.membermgmt.vo.SafetyCertUserVO;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.admin.service.membermgmt.vo.SafetyCertUserVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.barocle.util.webutil.StringUtil;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("safetyCertUserService")
public class SafetyCertUserServiceImpl extends EgovAbstractServiceImpl implements SafetyCertUserService {
	protected static Logger log = LoggerFactory.getLogger(SafetyCertUserServiceImpl.class);
	
	@Autowired SafetyCertMapper mapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int safetyCertUserListCnt(SafetyCertUserVO memberVo) {
		int result = 0;
		result =  mapper.safetyCertUserListCnt(memberVo);
		return result;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<SafetyCertUserVO> safetyCertUserList(SafetyCertUserVO memberVo) {
		List<SafetyCertUserVO> resultList = null;
		resultList =  mapper.safetyCertUserList(memberVo);
		return resultList;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean chkCertNum(HashMap<String, String> errorMap) {
        int result = mapper.chkCertNum(errorMap);
		return result > 0 ? true : false;
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean chkUsrMpnNo(HashMap<String, String> errorMap) {
        int result = mapper.chkUsrMpnNo(errorMap);
		return result > 0 ? true : false;
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean chkMbId(HashMap<String, String> errorMap) {
        int result = mapper.chkMbId(errorMap);
		return result > 0 ? true : false;
	}

	@Override
	public int addSafetyCertUserExcelData(List<HashMap<String, String>> addList) {
		int result = 0;
		int tempResult =0;
        for(HashMap<String, String> map : addList) {        	
        	tempResult = mapper.addCertUsrFromExcel(map);
        	if(tempResult != 0) {
    			result = result+ tempResult;
    		}
        }
		return result;
	}

	@Override
	public SafetyCertUserVO getCertInfoWithMpnNo(String mpnNo) {
		return mapper.getCertInfoWithMpnNo(mpnNo);
	}

	@Override
	public SafetyCertUserVO getSafetyCertUserInfo(SafetyCertUserVO safetyCertUserVo) {
		return mapper.getSafetyCertUserInfo(safetyCertUserVo);
	}

	@Override
	public int setSafetyCertUser(SafetyCertUserVO safetyCertUserVo) {
		int result = 0;
		if (!StringUtil.isEmpty(safetyCertUserVo.getUsrMpnNo())) {
			SafetyCertUserVO tempVo = mapper.getCertInfoWithMpnNo(safetyCertUserVo.getUsrMpnNo());
			if (tempVo != null) {
				safetyCertUserVo.setMbYn("Y");
				safetyCertUserVo.setUsrUsrSeq(tempVo.getUsrUsrSeq());
				safetyCertUserVo.setMbId(tempVo.getMbId());
			}
		}
		safetyCertUserVo.setModDttm("NowInQuery");
		result = mapper.setSafetyCertUser(safetyCertUserVo);
		return result;
	}

	@Override
	public int delSafetyCertUser(SafetyCertUserVO safetyCertUserVo) {
		int result = 0;
		mapper.delSafetyCertUser(safetyCertUserVo);
		result = 1;
		return result;
	}
	
	
//	@Override
//	@Transactional(readOnly=false, propagation=Propagation.REQUIRED, rollbackFor={SQLException.class, Exception.class})
//	@DataSource(DataSourceType.MASTER)
//	public int addSafetyCertUser(SafetyCertUserVO sftCertUserVO)throws CfoodException {
//		return safetyCertMapper.addSafetyCertUser(sftCertUserVO);
//	}
}
