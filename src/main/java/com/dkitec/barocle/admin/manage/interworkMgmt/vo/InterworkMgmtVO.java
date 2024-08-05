package com.dkitec.barocle.admin.manage.interworkMgmt.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Pattern;

import org.springframework.web.multipart.MultipartFile;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.IsNumeric;
import com.dkitec.barocle.util.validator.annotation.IsYN;

@SuppressWarnings("serial")
public class InterworkMgmtVO extends PagingVO implements Serializable {

	@CheckValue(message="펌웨어 일련번호를 입력해주세요.",groups={FwUpdateValid.class, FwDeleteValid.class, FwFileDeleteValid.class})
	private String firmwareSeq;
	private String firmware_seq;
	
	@CheckValue(message="펌웨어 구분을 입력해주세요.",groups={FwInsertValid.class, FwVerCheckValid.class})
	private String firmwareClsCd;
	private String firmwareClsName;
	
	@Pattern(regexp="^[0-9.]+$", message="펌웨어 버전은 숫자와 .만 입력 가능합니다.",groups={FwInsertValid.class, FwUpdateValid.class, FwVerCheckValid.class})
	@CheckValue(message="펌웨어 버전을 입력해주세요.",groups={FwInsertValid.class, FwUpdateValid.class, FwVerCheckValid.class})
	private String firmwareVer;
	private float binSize;
	
	@IsYN(groups={FwInsertValid.class, FwUpdateValid.class})
	@CheckValue(message="사용여부를 입력해주세요.",groups={FwInsertValid.class, FwUpdateValid.class})
	private String useYn;
	private String updateCanStrTime;
	private String updateCanEndTime;
	private String regDttm;
	private String modStrDate;
	private String modEndDate;
	private String successCnt;
	private String failCnt;
	
	private String deviceId;
	private String successYn;
	private String reqDttm;
	private String processDttm;
	private String processStrDate;
	private String processEndDate;
	
	private String firmwareFileNo;
	
	private List<String> firmwareFileNoList;
	private String firmwareFileState;
	private List<String> firmwareFileStateList;
	private String firmwareFileOrd;
	private List<MultipartFile> firmwareFile;
	private List<String> oldFileNameList;
	private String fileName;
	private List<String> fileSavePathList;
	private String fileSavePath;
	private float fileSize;
	private byte[] fileByte;
	
	private String viewFlg;
	private String isSuccess;
	
	private String criticalName;
	private String criticalMin;
	private String criticalMinUseYn;
	private String criticalMax;
	private String criticalMaxUseYn;
	
	private String companyCd;			// 제조사 구분코드
	private String companyName;			// 제조사 명
	private String allUpdateYn;			// 단말기 전체 업데이트 여부
	private String updateBeginSerialNo;	// 업데이트 시작 단말기 번호
	private String updateEndSerialNo;		// 업데이트 종료 단말기 번호
	
	private String deviceModlCd;
	
	public String getDeviceModlCd() {
		return deviceModlCd;
	}
	public void setDeviceModlCd(String deviceModlCd) {
		this.deviceModlCd = deviceModlCd;
	}
	public String getCompanyCd() {
		return companyCd;
	}
	public void setCompanyCd(String companyCd) {
		this.companyCd = companyCd;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getAllUpdateYn() {
		return allUpdateYn;
	}
	public void setAllUpdateYn(String allUpdateYn) {
		this.allUpdateYn = allUpdateYn;
	}
	public String getUpdateBeginSerialNo() {
		return updateBeginSerialNo;
	}
	public void setUpdateBeginSerialNo(String updateBeginSerialNo) {
		this.updateBeginSerialNo = updateBeginSerialNo;
	}
	public String getUpdateEndSerialNo() {
		return updateEndSerialNo;
	}
	public void setUpdateEndSerialNo(String updateEndSerialNo) {
		this.updateEndSerialNo = updateEndSerialNo;
	}
	public String getFirmwareSeq() {
		return firmwareSeq;
	}
	public void setFirmwareSeq(String firmwareSeq) {
		this.firmwareSeq = firmwareSeq;
	}
	public String getFirmware_seq() {
		return firmware_seq;
	}
	public void setFirmware_seq(String firmware_seq) {
		this.firmware_seq = firmware_seq;
	}
	public String getFirmwareClsCd() {
		return firmwareClsCd;
	}
	public void setFirmwareClsCd(String firmwareClsCd) {
		this.firmwareClsCd = firmwareClsCd;
	}
	public String getFirmwareVer() {
		return firmwareVer;
	}
	public void setFirmwareVer(String firmwareVer) {
		this.firmwareVer = firmwareVer;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getUpdateCanStrTime() {
		return updateCanStrTime;
	}
	public void setUpdateCanStrTime(String updateCanStrTime) {
		this.updateCanStrTime = updateCanStrTime;
	}
	public String getUpdateCanEndTime() {
		return updateCanEndTime;
	}
	public void setUpdateCanEndTime(String updateCanEndTime) {
		this.updateCanEndTime = updateCanEndTime;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileSavePath() {
		return fileSavePath;
	}
	public void setFileSavePath(String fileSavePath) {
		this.fileSavePath = fileSavePath;
	}
	public String getCriticalName() {
		return criticalName;
	}
	public void setCriticalName(String criticalName) {
		this.criticalName = criticalName;
	}
	public String getCriticalMin() {
		return criticalMin;
	}
	public void setCriticalMin(String criticalMin) {
		this.criticalMin = criticalMin;
	}
	public String getCriticalMax() {
		return criticalMax;
	}
	public void setCriticalMax(String criticalMax) {
		this.criticalMax = criticalMax;
	}
	public String getCriticalMinUseYn() {
		return criticalMinUseYn;
	}
	public void setCriticalMinUseYn(String criticalMinUseYn) {
		this.criticalMinUseYn = criticalMinUseYn;
	}
	public String getCriticalMaxUseYn() {
		return criticalMaxUseYn;
	}
	public void setCriticalMaxUseYn(String criticalMaxUseYn) {
		this.criticalMaxUseYn = criticalMaxUseYn;
	}
	public String getFirmwareClsName() {
		return firmwareClsName;
	}
	public void setFirmwareClsName(String firmwareClsName) {
		this.firmwareClsName = firmwareClsName;
	}
	public String getModStrDate() {
		return modStrDate;
	}
	public void setModStrDate(String modStrDate) {
		this.modStrDate = modStrDate;
	}
	public String getModEndDate() {
		return modEndDate;
	}
	public void setModEndDate(String modEndDate) {
		this.modEndDate = modEndDate;
	}
	public String getDeviceId() {
		return deviceId;
	}
	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}
	public String getSuccessYn() {
		return successYn;
	}
	public void setSuccessYn(String successYn) {
		this.successYn = successYn;
	}
	public String getReqDttm() {
		return reqDttm;
	}
	public void setReqDttm(String reqDttm) {
		this.reqDttm = reqDttm;
	}
	public String getProcessDttm() {
		return processDttm;
	}
	public void setProcessDttm(String processDttm) {
		this.processDttm = processDttm;
	}
	public String getSuccessCnt() {
		return successCnt;
	}
	public void setSuccessCnt(String successCnt) {
		this.successCnt = successCnt;
	}
	public String getFailCnt() {
		return failCnt;
	}
	public void setFailCnt(String failCnt) {
		this.failCnt = failCnt;
	}
	public String getProcessStrDate() {
		return processStrDate;
	}
	public void setProcessStrDate(String processStrDate) {
		this.processStrDate = processStrDate;
	}
	public String getProcessEndDate() {
		return processEndDate;
	}
	public void setProcessEndDate(String processEndDate) {
		this.processEndDate = processEndDate;
	}
	public String getViewFlg() {
		return viewFlg;
	}
	public void setViewFlg(String viewFlg) {
		this.viewFlg = viewFlg;
	}
	public String getIsSuccess() {
		return isSuccess;
	}
	public void setIsSuccess(String isSuccess) {
		this.isSuccess = isSuccess;
	}
	public String getFirmwareFileNo() {
		return firmwareFileNo;
	}
	public void setFirmwareFileNo(String firmwareFileNo) {
		this.firmwareFileNo = firmwareFileNo;
	}
	public List<String> getFirmwareFileNoList() {
		return firmwareFileNoList;
	}
	public void setFirmwareFileNoList(List<String> firmwareFileNoList) {
		this.firmwareFileNoList = firmwareFileNoList;
	}
	public List<MultipartFile> getFirmwareFile() {
		return firmwareFile;
	}
	public void setFirmwareFile(List<MultipartFile> firmwareFile) {
		this.firmwareFile = firmwareFile;
	}
	public String getFirmwareFileOrd() {
		return firmwareFileOrd;
	}
	public void setFirmwareFileOrd(String firmwareFileOrd) {
		this.firmwareFileOrd = firmwareFileOrd;
	}
	public String getFirmwareFileState() {
		return firmwareFileState;
	}
	public void setFirmwareFileState(String firmwareFileState) {
		this.firmwareFileState = firmwareFileState;
	}
	public float getBinSize() {
		return binSize;
	}
	public void setBinSize(float binSize) {
		this.binSize = binSize;
	}
	public float getFileSize() {
		return fileSize;
	}
	public void setFileSize(float fileSize) {
		this.fileSize = fileSize;
	}
	public List<String> getFirmwareFileStateList() {
		return firmwareFileStateList;
	}
	public void setFirmwareFileStateList(List<String> firmwareFileStateList) {
		this.firmwareFileStateList = firmwareFileStateList;
	}
	public byte[] getFileByte() {
		return fileByte;
	}
	public void setFileByte(byte[] fileByte) {
		this.fileByte = fileByte;
	}
	public List<String> getOldFileNameList() {
		return oldFileNameList;
	}
	public void setOldFileNameList(List<String> oldFileNameList) {
		this.oldFileNameList = oldFileNameList;
	}
	public List<String> getFileSavePathList() {
		return fileSavePathList;
	}
	public void setFileSavePathList(List<String> fileSavePathList) {
		this.fileSavePathList = fileSavePathList;
	}
	
	public static interface FwInsertValid{}
	public static interface FwUpdateValid{}
	public static interface FwFileDeleteValid{}
	public static interface FwDeleteValid{}
	public static interface FwVerCheckValid{}
	
}
