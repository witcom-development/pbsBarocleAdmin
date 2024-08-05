package com.dkitec.barocle.admin.maintenance.check.lock.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.CommonVo;

@SuppressWarnings("serial")
@Alias("checkLockVo")
public class CheckLockVO extends CommonVo implements Serializable {

	@Size(max=20, message="거치대ID는 20자 이하만 가능 합니다.")
    @Pattern(regexp="^[0-9a-zA-Z]*$" , message="AP아이디는 영문자, 숫자 조합만 가능 합니다.")
	private String rackId;
	@Size(max=10, message="상태코드 형식이 아닙니다.")
	@Pattern(regexp="^[A-Z]*_[0-9]{3}$" , message="공통코드 형식이 아닙니다.")
	private String rackStatusCd;
	private String rackStatusName;
	private String chkType;
	@Size(max=20, message="날짜형식이 맞지않습니다.yyyy-mm-dd")
	@Pattern(regexp="^\\d{4}-\\d{2}-\\d{2}", message="적합하지 않은 날짜 형식입니다.")
	private String laskChkDttm;
	private String regDttm;
	private String usrSeq;
	private String userId;
	private String modDttm;
	private String modId;
	@Size(max=3, message="숫자 형식 3자리까지 입니다.")
	@Pattern(regexp="^[0-9]*" , message="숫자 형식 3자리까지 입니다.")
	private String stationEquipOrder;//거치대 설치 순서.
	private String locateStrDttm;
	private String loacteEndDttm;
    private List<String> StationIdList;
    private List<CheckLockVO> armList;
    private String faultSeq;
    private String reportYn;
    
	public String getRackId() {
		return rackId;
	}
	public void setRackId(String rackId) {
		this.rackId = rackId;
	}
	public String getRackStatusCd() {
		return rackStatusCd;
	}
	public void setRackStatusCd(String rackStatusCd) {
		this.rackStatusCd = rackStatusCd;
	}
	public String getRackStatusName() {
		return rackStatusName;
	}
	public void setRackStatusName(String rackStatusName) {
		this.rackStatusName = rackStatusName;
	}
	public String getChkType() {
		return chkType;
	}
	public void setChkType(String chkType) {
		this.chkType = chkType;
	}
	public String getLaskChkDttm() {
		return laskChkDttm;
	}
	public void setLaskChkDttm(String laskChkDttm) {
		this.laskChkDttm = laskChkDttm;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getUsrSeq() {
		return usrSeq;
	}
	public void setUsrSeq(String usrSeq) {
		this.usrSeq = usrSeq;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getModDttm() {
		return modDttm;
	}
	public void setModDttm(String modDttm) {
		this.modDttm = modDttm;
	}
	public String getModId() {
		return modId;
	}
	public void setModId(String modId) {
		this.modId = modId;
	}
	public String getStationEquipOrder() {
		return stationEquipOrder;
	}
	public void setStationEquipOrder(String stationEquipOrder) {
		this.stationEquipOrder = stationEquipOrder;
	}
	public String getLocateStrDttm() {
		return locateStrDttm;
	}
	public void setLocateStrDttm(String locateStrDttm) {
		this.locateStrDttm = locateStrDttm;
	}
	public String getLoacteEndDttm() {
		return loacteEndDttm;
	}
	public void setLoacteEndDttm(String loacteEndDttm) {
		this.loacteEndDttm = loacteEndDttm;
	}
	public List<String> getStationIdList() {
		return StationIdList;
	}
	public void setStationIdList(List<String> stationIdList) {
		StationIdList = stationIdList;
	}
	public List<CheckLockVO> getArmList() {
		return armList;
	}
	public void setArmList(List<CheckLockVO> armList) {
		this.armList = armList;
	}
	public String getFaultSeq() {
		return faultSeq;
	}
	public void setFaultSeq(String faultSeq) {
		this.faultSeq = faultSeq;
	}
	public String getReportYn() {
		return reportYn;
	}
	public void setReportYn(String reportYn) {
		this.reportYn = reportYn;
	}
}
