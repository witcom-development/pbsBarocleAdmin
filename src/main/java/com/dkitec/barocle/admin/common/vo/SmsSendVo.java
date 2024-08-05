/*
 * @Package Name : com.dkitec.barocle.admin.common.vo
 * @파일명          : SmsSendVo.java
 * @작성일          : 2015. 5. 18.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 18.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.common.vo;

import java.util.List;

import org.apache.ibatis.type.Alias;

/**
 * @파일명          : SmsSendVo.java
 * @작성일          : 2015. 5. 18.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 18.   |   ymshin   |  최초작성
 */
@Alias("smsSendVo")
public class SmsSendVo {

	private List<String> mprNoList;
	private String smsSeq;
	private String sendClsName;
	private String autoSendYn;
	private String autoSendId;
	private String smsMsg;
	private String recvMpnNo;
	private String sendRsltCd;
	private String adminId;
	private String bookDate;
	
	public String getBookDate() {
		return bookDate;
	}
	public void setBookDate(String bookDate) {
		this.bookDate = bookDate;
	}
	public List<String> getMprNoList() {
		return mprNoList;
	}
	public void setMprNoList(List<String> mprNoList) {
		this.mprNoList = mprNoList;
	}
	public String getSmsSeq() {
		return smsSeq;
	}
	public void setSmsSeq(String smsSeq) {
		this.smsSeq = smsSeq;
	}
	public String getSendClsName() {
		return sendClsName;
	}
	public void setSendClsName(String sendClsName) {
		this.sendClsName = sendClsName;
	}
	public String getAutoSendYn() {
		return autoSendYn;
	}
	public void setAutoSendYn(String autoSendYn) {
		this.autoSendYn = autoSendYn;
	}
	public String getAutoSendId() {
		return autoSendId;
	}
	public void setAutoSendId(String autoSendId) {
		this.autoSendId = autoSendId;
	}
	public String getSmsMsg() {
		return smsMsg;
	}
	public void setSmsMsg(String smsMsg) {
		this.smsMsg = smsMsg;
	}
	public String getRecvMpnNo() {
		return recvMpnNo;
	}
	public void setRecvMpnNo(String recvMpnNo) {
		this.recvMpnNo = recvMpnNo;
	}
	public String getSendRsltCd() {
		return sendRsltCd;
	}
	public void setSendRsltCd(String sendRsltCd) {
		this.sendRsltCd = sendRsltCd;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	
}
