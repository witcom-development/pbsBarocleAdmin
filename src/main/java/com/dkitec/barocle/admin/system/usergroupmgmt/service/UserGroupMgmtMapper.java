package com.dkitec.barocle.admin.system.usergroupmgmt.service;

import java.util.List;

import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.admin.system.usergroupmgmt.vo.UserGroupMgmtVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("UserGroupMgmtMapper")
public interface UserGroupMgmtMapper {

	/**
	 * 그룹 등록
	 * @param groVO
	 * @return
	 * @throws Exception
	 */
	public int insertGro(UserGroupMgmtVO groVO) ;

	/**
	 * 그룹 정보 수정
	 * @param groVO
	 * @return
	 * @throws Exception
	 */
	public int updateGro(UserGroupMgmtVO groVO) ;

	/**
	 * 그룹 정보 삭제
	 * @param groVO
	 * @return
	 * @throws Exception
	 */
	public int deleteGro(UserGroupMgmtVO groVO);

	/**
	 * 그룹 사용 메뉴 정보 삭제
	 * @param groVO
	 * @return
	 * @throws Exception
	 */
	public int deleteGroAuth(UserGroupMgmtVO groVO);
	
	

	public int getGroCount(UserGroupMgmtVO groVO);

	public List<UserGroupMgmtVO> getGroList(UserGroupMgmtVO GroVO);
	
	public List<UserGroupMgmtVO> getGroupNameList(UserGroupMgmtVO GroVO);
	
	public UserGroupMgmtVO getGroInfo(UserGroupMgmtVO groVO);

	public List<UserGroupMgmtVO> getAdminGroCodeList();

	public List<UserGroupMgmtVO> getPatnrGroCodeList();

	public List<CommonCodeVO> getGroCdList();

}
