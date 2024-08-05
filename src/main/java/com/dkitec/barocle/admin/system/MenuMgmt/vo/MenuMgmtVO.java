/*
 * @Package Name : com.dkitec.barocle.admin.system.MenuMgmt.vo
 * @파일명          : MenuMgmtVO.java
 * @작성일          : 2015. 4. 7.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 7.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.system.MenuMgmt.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.IsStringNumeric;



/**
 * @파일명          : MenuMgmtVO.java
 * @작성일          : 2015. 4. 7.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 7.   |   ymshin   |  최초작성
 */
@Alias("menuMgmtVO")
public class MenuMgmtVO extends PagingVO implements Serializable {

	static final long serialVersionUID = -2963619215485154431L;

	/** 메뉴번호 */
	@Size(max=20, message="메뉴코드는 20자 이하만 가능 합니다.")
    @Pattern(regexp="^[0-9a-zA-Z]*$" , message="메뉴코드는 영문자, 숫자 조합만 가능 합니다.")
	private String menuCd;

	/** 메뉴명 */
	@Size(max=20, message="메뉴명은 20자 이하만 가능 합니다.")
	@CheckValue( message="빈 값일 수 없습니다.")
	private String menuName;
	
	/** TOP메뉴명 */
	private String topMenuName;

	/** 상위메뉴번호 */
	@Size(max=10, message="상위메뉴코드는 10자 이하만 가능 합니다.")
    @Pattern(regexp="^[0-9a-zA-Z]*$" , message="상위메뉴코드는 영문자, 숫자 조합만 가능 합니다.")
	private String upMenu;

	/** 메뉴 레벨 */
	@IsStringNumeric(message="메뉴레벨은 숫자만 가능 합니다.")
	private String menuLevel;
	
	/** 메뉴 상세 cd */
	private String menuDetailCd;

	/** 메뉴 이미지 */
	private String menuImg;

	/** 링크 이미지 */
	private String linkImg;

	/** 링크  */
	private String srcLink;

	/** 메뉴순서 */
	@Size(max=3, message="메뉴순서는 3자 이하만 가능 합니다.")
	@Pattern(regexp="^[0-9]*$" , message="메뉴순서는 숫자만 가능 합니다.")
	private String menuOrd;

	/** 메뉴설명 */
	@Size(max=500, message="메뉴순서는 500자 이하만 가능 합니다.")
	private String menuDesc;
	
	/** 전 메뉴순서 */
	private String oldMenuOrd;
			
	/** 새메뉴번호 */
	private String downMenuCd;

	/** 새메뉴명 */
	private String downMenuName;

	/** 하위 메뉴 여부 0 이상일시 존재 */
	private int downCnt;
	
	/** 생성자 */
	private String regUsrId;
	
	/** 생성일 */
	private String regDate;
	
	@Size(max=1, message="히든여부는 1자만 가능 합니다.")
	@Pattern(regexp="^[Y|N]*$" , message="히든여부는 Y,N만 가능 합니다.")
	private String hiddenYn;
	
	/** 순서변경 type 
	 * I : insert
	 * U : Update
	 * D : Delete 
	**/
	private String type;

	/** 권한 코드 */
	private String usrGrpCd;
	
	/** 읽기 권한 */
	private String readYn;

	/** 쓰기 권한 */
	private String creYn;

	/** 수정 권한 */
	private String updateYn;

	/** 삭제 권한 */
	private String delYn;

	/** 메뉴 리스트 */
	private List<MenuMgmtVO> menuGrpList;

	/** 1레벨 메뉴 cd 리스트 */
	private String depth1Cd;
	/** 2레벨 메뉴 cd */
	private String depth2Cd;
	/** 3레벨 메뉴 cd */
	private String depth3Cd;
	/** 4레벨 메뉴 cd */
	private String depth4Cd;
	
	
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
    
	public String getMenuCd() {
		return menuCd;
	}

	public void setMenuCd(String menuCd) {
		this.menuCd = menuCd;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getUpMenu() {
		return upMenu;
	}

	public void setUpMenu(String upMenu) {
		this.upMenu = upMenu;
	}

	public String getMenuLevel() {
		return menuLevel;
	}

	public void setMenuLevel(String menuLevel) {
		this.menuLevel = menuLevel;
	}

	public String getMenuImg() {
		return menuImg;
	}

	public void setMenuImg(String menuImg) {
		this.menuImg = menuImg;
	}

	public String getLinkImg() {
		return linkImg;
	}

	public void setLinkImg(String linkImg) {
		this.linkImg = linkImg;
	}

	public String getSrcLink() {
		return srcLink;
	}

	public void setSrcLink(String srcLink) {
		this.srcLink = srcLink;
	}

	public String getMenuOrd() {
		return menuOrd;
	}

	public void setMenuOrd(String menuOrd) {
		this.menuOrd = menuOrd;
	}

	public String getMenuDesc() {
		return menuDesc;
	}

	public void setMenuDesc(String menuDesc) {
		this.menuDesc = menuDesc;
	}

	public String getOldMenuOrd() {
		return oldMenuOrd;
	}

	public void setOldMenuOrd(String oldMenuOrd) {
		this.oldMenuOrd = oldMenuOrd;
	}

	public String getDownMenuCd() {
		return downMenuCd;
	}

	public void setDownMenuCd(String downMenuCd) {
		this.downMenuCd = downMenuCd;
	}

	public String getDownMenuName() {
		return downMenuName;
	}

	public void setDownMenuName(String downMenuName) {
		this.downMenuName = downMenuName;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getHiddenYn() {
		return hiddenYn;
	}

	public void setHiddenYn(String hiddenYn) {
		this.hiddenYn = hiddenYn;
	}

	public int getDownCnt() {
		return downCnt;
	}

	public void setDownCnt(int downCnt) {
		this.downCnt = downCnt;
	}
	

    public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getUsrGrpCd() {
		return usrGrpCd;
	}

	public void setUsrGrpCd(String usrGrpCd) {
		this.usrGrpCd = usrGrpCd;
	}

	public String getCreYn() {
		return creYn;
	}

	public void setCreYn(String creYn) {
		this.creYn = creYn;
	}

	public String getRegUsrId() {
		return regUsrId;
	}

	public void setRegUsrId(String regUsrId) {
		this.regUsrId = regUsrId;
	}

	public String getReadYn() {
		return readYn;
	}

	public void setReadYn(String readYn) {
		this.readYn = readYn;
	}

	public String getUpdateYn() {
		return updateYn;
	}

	public void setUpdateYn(String updateYn) {
		this.updateYn = updateYn;
	}

	public String getDelYn() {
		return delYn;
	}

	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}

	public List<MenuMgmtVO> getMenuGrpList() {
		return menuGrpList;
	}

	public void setMenuGrpList(List<MenuMgmtVO> menuGrpList) {
		this.menuGrpList = menuGrpList;
	}

	public String getDepth1Cd() {
		return depth1Cd;
	}

	public void setDepth1Cd(String depth1Cd) {
		this.depth1Cd = depth1Cd;
	}

	public String getDepth2Cd() {
		return depth2Cd;
	}

	public void setDepth2Cd(String depth2Cd) {
		this.depth2Cd = depth2Cd;
	}

	public String getDepth3Cd() {
		return depth3Cd;
	}

	public void setDepth3Cd(String depth3Cd) {
		this.depth3Cd = depth3Cd;
	}

	public String getDepth4Cd() {
		return depth4Cd;
	}

	public void setDepth4Cd(String depth4Cd) {
		this.depth4Cd = depth4Cd;
	}

	public String getMenuDetailCd() {
		return menuDetailCd;
	}

	public void setMenuDetailCd(String menuDetailCd) {
		this.menuDetailCd = menuDetailCd;
	}

	public String getTopMenuName() {
		return topMenuName;
	}

	public void setTopMenuName(String topMenuName) {
		this.topMenuName = topMenuName;
	}
}
