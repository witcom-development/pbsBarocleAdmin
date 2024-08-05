package com.dkitec.barocle.admin.system.teammgmt.service;

import java.util.List;

import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.admin.system.teammgmt.vo.TeamMgmtVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("TeamMgmtMapper")
public interface TeamMgmtMapper {

	/**
	 * 팀 등록
	 * @param teamVO
	 * @return
	 * @throws Exception
	 */
	public int insertTeam(TeamMgmtVO teamVO) ;

	/**
	 * 팀 정보 수정
	 * @param teamVO
	 * @return
	 * @throws Exception
	 */
	public int updateTeam(TeamMgmtVO teamVO) ;

	/**
	 * 팀 정보 삭제
	 * @param teamVO
	 * @return
	 * @throws Exception
	 */
	public int deleteTeam(TeamMgmtVO teamVO);

	/**
	 * 팀 정보 삭제
	 * @param teamVO
	 * @return
	 * @throws Exception
	 */
	public int deleteTeamAuth(TeamMgmtVO teamVO);
	
	public int getTeamCount(TeamMgmtVO teamVO);

	public List<TeamMgmtVO> getTeamList(TeamMgmtVO teamVO);
	
	public List<TeamMgmtVO> getTeamNameList(TeamMgmtVO teamVO);
	
	public TeamMgmtVO getTeamInfo(TeamMgmtVO teamVO);


}
