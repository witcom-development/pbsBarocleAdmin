package com.dkitec.barocle.admin.system.usergroupmgmt.vo;

import java.io.Serializable;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;



/**
 * 카테고리 정보를 담고있는 VO 클래스를 정의한다.
 * @author 실행환경 개발팀 신혜연
 * @since 2011.07.11
 * @version 1.0
 * @see 
 * <pre>
 *  == 개정이력(Modification Information) ==
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2011.07.11  신혜연          최초 생성
 * 
 * </pre>
 */
@Alias(value="userGroupMgmtVO")
public class UserGroupMgmtVO extends PagingVO implements Serializable{

	private static final long serialVersionUID = -2132379045115001026L;

	
	private String searchUsrGrpCd;
	
	private String searchGrpName;
	
	private String reg_id;
	private String mod_id;
	private String com_cd;
	private String mlang_com_cd_name;
	private String admin;
	
	/** 사용 권한등급 코드	 */
	@Size(max=8, message="권한등급 코드는 8자 이하만 가능 합니다.")
	private String usrGrpCd;
	
	/** 사용 권한등급 명	 */
	private String usrGrpCdName;
	
	private String readAuthCd;
	
	private String readAuthCdName;

	/** 권한그룹 명	 */
	@Size(max=20, message="권한그룹 명은 20자 이하만 가능 합니다.")
    @Pattern(regexp="^[0-9a-zA-Z가-힣_ ]*$" , message="권한그룹 명은 특수문자가 들어갈 수 없습니다.")
	private String grpName;
	
	/** 그룹 설명	 */
	@Size(max=500, message="그룹 설명은 500자 이하만 가능 합니다.")
	private String grpDesc;

	/** 생성일	 */
	private String creDate;
	
	/** 수정일	 */
	private String modDate;
	
	/**  운영자 여부*/
	private String adminYN;
	
	private String pageIndex;
	
	private String admin_cls_cd;

	
	public String getAdmin_cls_cd() {
		return admin_cls_cd;
	}

	public void setAdmin_cls_cd(String admin_cls_cd) {
		this.admin_cls_cd = admin_cls_cd;
	}

	public String getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(String pageIndex) {
		this.pageIndex = pageIndex;
	}

	public String getUsrGrpCd() {
		return usrGrpCd;
	}

	public void setUsrGrpCd(String usrGrpCd) {
		this.usrGrpCd = usrGrpCd;
	}

	public String getGrpName() {
		return grpName;
	}

	public void setGrpName(String grpName) {
		this.grpName = grpName;
	}

	public String getGrpDesc() {
		return grpDesc;
	}

	public void setGrpDesc(String grpDesc) {
		this.grpDesc = grpDesc;
	}

	public String getCreDate() {
		return creDate;
	}

	public void setCreDate(String creDate) {
		this.creDate = creDate;
	}

	public String getModDate() {
		return modDate;
	}

	public void setModDate(String modDate) {
		this.modDate = modDate;
	}

	public String getUsrGrpCdName() {
		return usrGrpCdName;
	}

	public void setUsrGrpCdName(String usrGrpCdName) {
		this.usrGrpCdName = usrGrpCdName;
	}

	public String getReadAuthCd() {
		return readAuthCd;
	}

	public void setReadAuthCd(String readAuthCd) {
		this.readAuthCd = readAuthCd;
	}

	public String getReadAuthCdName() {
		return readAuthCdName;
	}

	public void setReadAuthCdName(String readAuthCdName) {
		this.readAuthCdName = readAuthCdName;
	}

	public String getAdminYN() {
		return adminYN;
	}

	public void setAdminYN(String adminYN) {
		this.adminYN = adminYN;
	}

	public String getSearchUsrGrpCd() {
		return searchUsrGrpCd;
	}

	public void setSearchUsrGrpCd(String searchUsrGrpCd) {
		this.searchUsrGrpCd = searchUsrGrpCd;
	}

	public String getSearchGrpName() {
		return searchGrpName;
	}

	public void setSearchGrpName(String searchGrpName) {
		this.searchGrpName = searchGrpName;
	}
	

	public String getReg_id() {
		return reg_id;
	}

	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}

	public String getMod_id() {
		return mod_id;
	}

	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}

	public String getCom_cd() {
		return com_cd;
	}

	public void setCom_cd(String com_cd) {
		this.com_cd = com_cd;
	}

	public String getMlang_com_cd_name() {
		return mlang_com_cd_name;
	}

	public void setMlang_com_cd_name(String mlang_com_cd_name) {
		this.mlang_com_cd_name = mlang_com_cd_name;
	}

	public String getAdmin() {
		return admin;
	}

	public void setAdmin(String admin) {
		this.admin = admin;
	}

	@Override
	public String toString() {
		return "UserGroupMgmtVO [searchUsrGrpCd=" + searchUsrGrpCd
				+ " , searchGrpName=" + searchGrpName + " , reg_id=" + reg_id
				+ " , mod_id=" + mod_id + " , usrGrpCd=" + usrGrpCd
				+ " , usrGrpCdName=" + usrGrpCdName + " , readAuthCd="
				+ readAuthCd + " , readAuthCdName=" + readAuthCdName
				+ " , grpName=" + grpName + " , grpDesc=" + grpDesc
				+ " , creDate=" + creDate + " , modDate=" + modDate
				+ " , adminYN=" + adminYN + " , pageIndex=" + pageIndex
				+ " , admin_cls_cd=" + admin_cls_cd + "]";
	}
	
	
}
