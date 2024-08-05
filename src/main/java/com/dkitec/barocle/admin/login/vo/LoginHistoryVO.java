package com.dkitec.barocle.admin.login.vo;

import java.io.Serializable;

import javax.validation.constraints.Pattern;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@Alias("loginHistoryVo")
public class LoginHistoryVO extends PagingVO implements Serializable {
	static final long serialVersionUID = -7585417176991471695L;
	
	/** 로그인일시   */
	private String loginDate;
	/** 사용자 ID */
	private String usrId;
	/** 사용자 명      */
	private String usrName;
	/** 사용그룹명    */
	private String usrGrpName;
	/** 사용자 IP */
	private String usrIp;
	/** 페이징 여부 */
    @Pattern(regexp="Y|N" , message="잘못된 형식입니다.")
    private String pagingYn;
	
	public String getLoginDate() {
		return loginDate;
	}
	public void setLoginDate(String loginDate) {
		this.loginDate = loginDate;
	}
	public String getUsrId() {
		return usrId;
	}
	public void setUsrId(String usrId) {
		this.usrId = usrId;
	}
	public String getUsrName() {
		return usrName;
	}
	public void setUsrName(String usrName) {
		this.usrName = usrName;
	}
	public String getUsrGrpName() {
		return usrGrpName;
	}
	public void setUsrGrpName(String usrGrpName) {
		this.usrGrpName = usrGrpName;
	}
	public String getUsrIp() {
		return usrIp;
	}
	public void setUsrIp(String usrIp) {
		this.usrIp = usrIp;
	}

	public String getPagingYn() {
		return pagingYn;
	}
	public void setPagingYn(String pagingYn) {
		this.pagingYn = pagingYn;
	}
}
