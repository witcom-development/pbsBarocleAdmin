package com.dkitec.barocle.admin.statistics.use.vo;

import java.io.Serializable;
import java.util.Date;

import javax.validation.GroupSequence;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import com.dkitec.barocle.admin.manage.deviceMgmt.CommonVo;


@SuppressWarnings("serial")
@Alias("useStatisticsBoardVO")
public class UseStatisticsBoardVO extends CommonVo implements Serializable { 

	private static final String currentMenu = "STATIC";
	private static final String currentMenuName = "static";
	
	private int staticSeq;
	private String staticTitle;
	
	private String staticTEXTContent;
	private String staticHTMLContent;
	private String readCnt;
	private String useYn;
	private String atchFileId;

	private String regID;
	private String modID;
	
	private String manageDttm;
	
	private int adminGrpSeq;
	
	private java.util.List<String> fileList;		// 파일 URL 목록
	private String attach_file;						// 첨부파일 업로드
	private String attachNo;						// 첨부파일 번호
	private String attachNm;						// 파일명
	private String imgUrl;							// 서버파일경로+파일명
	private String aFolder;							// 현패이지경로
	private String imgSeq;							// 이미지 시퀀스	
	private String imgName;
	
	
	
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private Date regDttm;
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private Date modDttm;
	
	public int getStaticSeq() {
		return staticSeq;
	}
	public void setStaticSeq(int staticSeq) {
		this.staticSeq = staticSeq;
	}
	public String getStaticTitle() {
		return staticTitle;
	}
	public void setStaticTitle(String staticTitle) {
		this.staticTitle = staticTitle;
	}
	public String getStaticTEXTContent() {
		return staticTEXTContent;
	}
	public void setStaticTEXTContent(String staticTEXTContent) {
		this.staticTEXTContent = staticTEXTContent;
	}
	public String getStaticHTMLContent() {
		return staticHTMLContent;
	}
	public void setStaticHTMLContent(String staticHTMLContent) {
		this.staticHTMLContent = staticHTMLContent;
	}
	public String getReadCnt() {
		return readCnt;
	}
	public void setReadCnt(String readCnt) {
		this.readCnt = readCnt;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	public String getRegID() {
		return regID;
	}
	public void setRegID(String regID) {
		this.regID = regID;
	}
	public String getModID() {
		return modID;
	}
	public void setModID(String modID) {
		this.modID = modID;
	}
	public String getManageDttm() {
		return manageDttm;
	}
	public void setManageDttm(String manageDttm) {
		this.manageDttm = manageDttm;
	}
	public Date getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(Date regDttm) {
		this.regDttm = regDttm;
	}
	public Date getModDttm() {
		return modDttm;
	}
	public void setModDttm(Date modDttm) {
		this.modDttm = modDttm;
	}
	
	public int getAdminGrpSeq() {
		return adminGrpSeq;
	}
	public void setAdminGrpSeq(int adminGrpSeq) {
		this.adminGrpSeq = adminGrpSeq;
	}
	
	
	public java.util.List<String> getFileList() {
		return fileList;
	}
	public void setFileList(java.util.List<String> fileList) {
		this.fileList = fileList;
	}	
	public String getAttach_file() {
		return attach_file;
	}
	public void setAttach_file(String attach_file) {
		this.attach_file = attach_file;
	}
	public String getAttachNo() {
		return attachNo;
	}
	public void setAttachNo(String attachNo) {
		this.attachNo = attachNo;
	}
	public String getAttachNm() {
		return attachNm;
	}
	public void setAttachNm(String attachNm) {
		this.attachNm = attachNm;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	public String getaFolder() {
		return aFolder;
	}
	public void setaFolder(String aFolder) {
		this.aFolder = aFolder;
	}
	public String getImgSeq() {
		return imgSeq;
	}
	public void setImgSeq(String imgSeq) {
		this.imgSeq = imgSeq;
	}
	public static String getCurrentmenu() {
		return currentMenu;
	}
	public static String getCurrentmenuname() {
		return currentMenuName;
	}
	public String getImgName() {
		return imgName;
	}
	public void setImgName(String imgName) {
		this.imgName = imgName;
	}

	
	private interface UseStatisticsBoard{}
	private interface UseStatisticsBoardView{}
	private interface UseStatisticsBoardWrite{}
	private interface UseStatisticsBoardEdit{}
	private interface UseStatisticsBoardInsert{}
	private interface UseStatisticsBoardUpdate{}
	private interface UseStatisticsBoardDelete{}
	
	@GroupSequence({UseStatisticsBoard.class, SearchDateValidator.class})
	public static interface UseStatisticsBoardListVal{}
	
	@GroupSequence({UseStatisticsBoardView.class})
	public static interface UseStatisticsBoardViewVal{}
	
	@GroupSequence({UseStatisticsBoardWrite.class})
	public static interface UseStatisticsBoardWriteVal{}
	
	@GroupSequence({UseStatisticsBoardEdit.class})
	public static interface UseStatisticsBoardEditVal{}
	
	@GroupSequence({GetMode.class, UseStatisticsBoardInsert.class, UseStatisticsBoardUpdate.class})
	public static interface UseStatisticsBoardPersistVal{}
	
	@GroupSequence({GetMode.class,UseStatisticsBoardDelete.class})
	public static interface UseStatisticsBoardDeleteVal{}
	
	@GroupSequence({GetMode.class, UseStatisticsBoard.class, UseStatisticsBoardView.class, UseStatisticsBoardWrite.class, UseStatisticsBoardEdit.class, UseStatisticsBoardInsert.class, UseStatisticsBoardUpdate.class, UseStatisticsBoardDelete.class})
	public static interface UseStatisticsBoardAllVal{}




}
