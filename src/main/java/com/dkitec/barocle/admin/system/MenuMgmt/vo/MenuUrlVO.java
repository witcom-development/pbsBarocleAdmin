package com.dkitec.barocle.admin.system.MenuMgmt.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Null;
import javax.validation.constraints.Pattern;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.ibatis.type.Alias;
import org.hibernate.validator.constraints.URL;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.IsStringNumeric;

@Alias("menuUrlVO")
public class MenuUrlVO extends PagingVO implements Serializable {
	
	static final long serialVersionUID = -6180012040380176438L;

	private List<MenuUrlVO> urlList;

	/** 메뉴일련번호 */
	private String menuUrlSeq;
	
	/** 메뉴번호 */
	@CheckValue(message="메뉴코드는 빈값 일 수 없습니다.")
	@IsStringNumeric(message="Number형태의 값이어야 합니다.")
	private String menuCd;
	
	/** 권한 코드 */
	private String usrGrpCd;
	
	/** URL 주소 */
	@Null
	@URL
	private String menuUrl;

	/** URL 공개여부 */
	@Null
	@Pattern(regexp="^[Y|N]*$", message="잘못된 값입니다.")
	private String menuCrud;

	/** URL 삭제 시 사용할 값 ( not in ) */
	private String menuUrlNotIn;
	
	private String crudFlg ="";
			
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public List<MenuUrlVO> getUrlList() {
		return urlList;
	}

	public void setUrlList(List<MenuUrlVO> urlList) {
		this.urlList = urlList;
	}

	public String getMenuCd() {
		return menuCd;
	}

	public void setMenuCd(String menuCd) {
		this.menuCd = menuCd;
	}

	public String getMenuUrl() {
		return menuUrl;
	}

	public void setMenuUrl(String menuUrl) {
		this.menuUrl = menuUrl;
	}

	public String getMenuCrud() {
		return menuCrud;
	}

	public void setMenuCrud(String menuCrud) {
		this.menuCrud = menuCrud;
	}

	public String getMenuUrlNotIn() {
		return menuUrlNotIn;
	}

	public void setMenuUrlNotIn(String menuUrlNotIn) {
		this.menuUrlNotIn = menuUrlNotIn;
	}

	public String getUsrGrpCd() {
		return usrGrpCd;
	}

	public void setUsrGrpCd(String usrGrpCd) {
		this.usrGrpCd = usrGrpCd;
	}

	public String getMenuUrlSeq() {
		return menuUrlSeq;
	}

	public void setMenuUrlSeq(String menuUrlSeq) {
		this.menuUrlSeq = menuUrlSeq;
	}

	public String getCrudFlg() {
		return crudFlg;
	}

	public void setCrudFlg(String crudFlg) {
		this.crudFlg = crudFlg;
	}
	
	
}