package com.dkitec.barocle.admin.service.membermgmt.service;

import java.util.HashMap;
import java.util.List;

import com.dkitec.barocle.admin.service.membermgmt.vo.SafetyCertUserVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.SafetyCertUserVO;


public interface SafetyCertUserService {
	
//	public int addSafetyCertUser(SafetyCertUserVO sftCertUserVO) throws Exception;
	
	public List<SafetyCertUserVO> safetyCertUserList(SafetyCertUserVO safetyCertUserVo);

	public int safetyCertUserListCnt(SafetyCertUserVO safetyCertUserVo);
	
	boolean chkCertNum(HashMap<String, String> errorMap);
	
	boolean chkUsrMpnNo(HashMap<String, String> errorMap);
	
	boolean chkMbId(HashMap<String, String> errorMap);

	public int addSafetyCertUserExcelData(List<HashMap<String, String>> addList);

	public SafetyCertUserVO getCertInfoWithMpnNo(String mpnNo);

	public SafetyCertUserVO getSafetyCertUserInfo(SafetyCertUserVO safetyCertUserVo);
	
	public int setSafetyCertUser(SafetyCertUserVO safetyCertUserVo);

	public int delSafetyCertUser(SafetyCertUserVO safetyCertUserVo);
}
