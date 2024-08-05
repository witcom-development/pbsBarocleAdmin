package com.dkitec.barocle.admin.system.usermgmt.vo;

import java.io.Serializable;

import javax.validation.constraints.Pattern;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@Alias("userHistoryVo")
public class UserHistoryVO extends PagingVO implements Serializable {
	
	 private static final long serialVersionUID = 1L;
	
	/** 수정일시   */
	private String modDate;
	/** 사용자 ID */
	private String usrId;
	/** 수정자 ID      */
	private String modId;
	/** 사용 여부 */
    @Pattern(regexp="Y|N" , message="잘못된 형식입니다.")
    private String usrYn;
	
    public String getModDate() {
		return modDate;
	}
	public void setModDate(String modDate) {
		this.modDate = modDate;
	}
	public String getUsrId() {
		return usrId;
	}
	public void setUsrId(String usrId) {
		this.usrId = usrId;
	}
	public String getModId() {
		return modId;
	}
	public void setModId(String modId) {
		this.modId = modId;
	}
	public String getUsrYn() {
		return usrYn;
	}
	public void setUsrYn(String usrYn) {
		this.usrYn = usrYn;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
}
