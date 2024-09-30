package com.dkitec.barocle.admin.customer.notice.vo;

import org.apache.ibatis.type.Alias;

@Alias("fileVO")
public class FileVO implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	// TB_COM_ATCH_FILE_INFO
	private String atchFileId;
	private String creDttm;
	private String useYn;
	
	// TB_COM_ATCH_FILE_DETAIL_INFO
	private int fileOrd;
	private String fileSavePath;
	private String saveFileName;
	private String orignlFileName;
	private String fileExtsn;
	private int fileSize;
	
	// TB_COM_EDITOR_IMG
	private String bbsClsCD;
	private int imgSeq;
	private String imgPath;
	private String imgURL;
	private String imgName;
	
	private int imgSize;
	private int noticeSeq;
	private String regId;
	
	
	public String getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	public String getCreDttm() {
		return creDttm;
	}
	public void setCreDttm(String creDttm) {
		this.creDttm = creDttm;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public int getFileOrd() {
		return fileOrd;
	}
	public void setFileOrd(int fileOrd) {
		this.fileOrd = fileOrd;
	}
	public String getFileSavePath() {
		return fileSavePath;
	}
	public void setFileSavePath(String fileSavePath) {
		this.fileSavePath = fileSavePath;
	}
	public String getSaveFileName() {
		return saveFileName;
	}
	public void setSaveFileName(String saveFileName) {
		this.saveFileName = saveFileName;
	}
	public String getOrignlFileName() {
		return orignlFileName;
	}
	public void setOrignlFileName(String orignlFileName) {
		this.orignlFileName = orignlFileName;
	}
	public String getFileExtsn() {
		return fileExtsn;
	}
	public void setFileExtsn(String fileExtsn) {
		this.fileExtsn = fileExtsn;
	}
	public int getFileSize() {
		return fileSize;
	}
	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}

	public int getImgSeq() {
		return imgSeq;
	}
	public void setImgSeq(int imgSeq) {
		this.imgSeq = imgSeq;
	}
	public String getImgPath() {
		return imgPath;
	}
	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}
	public String getImgURL() {
		return imgURL;
	}
	public void setImgURL(String imgURL) {
		this.imgURL = imgURL;
	}
	public String getImgName() {
		return imgName;
	}
	public void setImgName(String imgName) {
		this.imgName = imgName;
	}
	public String getBbsClsCD() {
		return bbsClsCD;
	}
	public void setBbsClsCD(String bbsClsCD) {
		this.bbsClsCD = bbsClsCD;
	}
	public int getImgSize() {
		return imgSize;
	}
	public void setImgSize(int imgSize) {
		this.imgSize = imgSize;
	} 
	
	public int getNoticeSeq() {
		return noticeSeq;
	}
	public void setNoticeSeq(int noticeSeq) {
		this.noticeSeq = noticeSeq;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	@Override
	public String toString() {
		return "FileVO [atchFileId=" + atchFileId + ", creDttm=" + creDttm
				+ ", useYn=" + useYn + ", fileOrd=" + fileOrd 
				+ ", fileSavePath="+ fileSavePath + ", saveFileName=" + saveFileName
				+ ", orignlFileName=" + orignlFileName + ",fileExtsn=" + fileExtsn
				+ ", saveFileName=" + saveFileName + ", orignlFileName=" + orignlFileName
				+ ", fileExtsn=" + fileExtsn + ", fileSize=" + fileSize
				+ ", imgSeq=" + imgSeq + ", imgPath=" + imgPath
				+ ", imgURL=" + imgURL + ", imgName=" + imgName
				+ "]";
	}
	
}
