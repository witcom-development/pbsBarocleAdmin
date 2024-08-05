package com.dkitec.barocle.admin.customer.daumeditor.vo;

import org.apache.ibatis.type.Alias;

@Alias("daumEditorVO")
public class DaumEditorVO implements java.io.Serializable {
	
	private static final long serialVersionUID = -4811890240934080111L;
	
	private int imgSeq;
	private String bbsClsCD;
	private int bbsSeq;
	
	private String imgPath;
	private String imgURL;
	private String imgName;
	private int imgSize;
	
	// 파일 상세 정보 _ cms_20161108
	private int fileSeq;			
	private String filePath;
	private String fileURL;
	private String fileName;
	private int fileSize;
	
	private String imgNm;
	
	private String thumbnailImgPath;
	private String thumbnailImgURL;
	private String thumbnailImgName;
	private int thumbnailImgSize;
	
	
	
	public String getImgNm() {
		return imgNm;
	}
	public void setImgNm(String imgNm) {
		this.imgNm = imgNm;
	}
	public int getFileSeq() {
		return fileSeq;
	}
	public void setFileSeq(int fileSeq) {
		this.fileSeq = fileSeq;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFileURL() {
		return fileURL;
	}
	public void setFileURL(String fileURL) {
		this.fileURL = fileURL;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public int getFileSize() {
		return fileSize;
	}
	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public int getImgSeq() {
		return imgSeq;
	}
	public void setImgSeq(int imgSeq) {
		this.imgSeq = imgSeq;
	}
	public String getBbsClsCD() {
		return bbsClsCD;
	}
	public void setBbsClsCD(String bbsClsCD) {
		this.bbsClsCD = bbsClsCD;
	}
	public int getBbsSeq() {
		return bbsSeq;
	}
	public void setBbsSeq(int bbsSeq) {
		this.bbsSeq = bbsSeq;
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
	public int getImgSize() {
		return imgSize;
	}
	public void setImgSize(int imgSize) {
		this.imgSize = imgSize;
	}
	public String getThumbnailImgPath() {
		return thumbnailImgPath;
	}
	public void setThumbnailImgPath(String thumbnailImgPath) {
		this.thumbnailImgPath = thumbnailImgPath;
	}
	public String getThumbnailImgURL() {
		return thumbnailImgURL;
	}
	public void setThumbnailImgURL(String thumbnailImgURL) {
		this.thumbnailImgURL = thumbnailImgURL;
	}
	public String getThumbnailImgName() {
		return thumbnailImgName;
	}
	public void setThumbnailImgName(String thumbnailImgName) {
		this.thumbnailImgName = thumbnailImgName;
	}
	public int getThumbnailImgSize() {
		return thumbnailImgSize;
	}
	public void setThumbnailImgSize(int thumbnailImgSize) {
		this.thumbnailImgSize = thumbnailImgSize;
	}
	
	@Override
	public String toString() {
		return "DaumEditorVO [imgSeq=" + imgSeq + ", bbsClsCD=" + bbsClsCD
				+ ", bbsSeq=" + bbsSeq + ", imgPath=" + imgPath + ", imgURL="
				+ imgURL + ", imgName=" + imgName + ", imgSize=" + imgSize
				+ ", thumbnailImgPath=" + thumbnailImgPath
				+ ", thumbnailImgURL=" + thumbnailImgURL
				+ ", thumbnailImgName=" + thumbnailImgName
				+ ", thumbnailImgSize=" + thumbnailImgSize + "]";
	}
	
}
