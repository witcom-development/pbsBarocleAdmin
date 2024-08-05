package com.dkitec.barocle.admin.statistics.reduction.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.CommonVo;

@SuppressWarnings("serial")
@Alias("reductionStatisticsVo")

public class ReductionStatisticsVO extends CommonVo implements Serializable {
	
	private String searchBgnMt;
	private String searchEndMt;
	private String totCnt;
	private String dateType;
	
	
	private String ticketDate;
	private String ticketCnt;
	private String ticket_1day;
	private String ticket_7day;
	private String ticket_30day;
	private String ticket_180day;
	private String ticket_365day;
	
	private String member_1h;
	private String member_2h;
	private String nonMember_1h;
	private String nonMember_2h;
	
	private String chkDailyTicket;
	private String pmtDate; 
	private String pmtWeek; 
	private String totPmtCnt;
	private String totPmtPrice;
	private String rdtPmtPrice;
	private String rdt1Ratio;
	private String rdt1Cnt;
	private String rdt2Ratio;
	private String rdt2Cnt;
	private String rdt3Ratio;
	private String rdt3Cnt;
	private String rdt4Ratio; 
	private String rdt4Cnt;
	
	public String getSearchBgnMt() {
		return searchBgnMt;
	}
	public void setSearchBgnMt(String searchBgnMt) {
		this.searchBgnMt = searchBgnMt;
	}
	public String getSearchEndMt() {
		return searchEndMt;
	}
	public void setSearchEndMt(String searchEndMt) {
		this.searchEndMt = searchEndMt;
	}
	public String getTotCnt() {
		return totCnt;
	}
	public void setTotCnt(String totCnt) {
		this.totCnt = totCnt;
	}
	public String getDateType() {
		return dateType;
	}
	public void setDateType(String dateType) {
		this.dateType = dateType;
	}
	public String getTicketDate() {
		return ticketDate;
	}
	public void setTicketDate(String ticketDate) {
		this.ticketDate = ticketDate;
	}
	public String getTicketCnt() {
		return ticketCnt;
	}
	public void setTicketCnt(String ticketCnt) {
		this.ticketCnt = ticketCnt;
	}
	public String getTicket_1day() {
		return ticket_1day;
	}
	public void setTicket_1day(String ticket_1day) {
		this.ticket_1day = ticket_1day;
	}
	public String getTicket_7day() {
		return ticket_7day;
	}
	public void setTicket_7day(String ticket_7day) {
		this.ticket_7day = ticket_7day;
	}
	public String getTicket_30day() {
		return ticket_30day;
	}
	public void setTicket_30day(String ticket_30day) {
		this.ticket_30day = ticket_30day;
	}
	public String getTicket_180day() {
		return ticket_180day;
	}
	public void setTicket_180day(String ticket_180day) {
		this.ticket_180day = ticket_180day;
	}
	public String getTicket_365day() {
		return ticket_365day;
	}
	public void setTicket_365day(String ticket_365day) {
		this.ticket_365day = ticket_365day;
	}
	public String getMember_1h() {
		return member_1h;
	}
	public void setMember_1h(String member_1h) {
		this.member_1h = member_1h;
	}
	public String getMember_2h() {
		return member_2h;
	}
	public void setMember_2h(String member_2h) {
		this.member_2h = member_2h;
	}
	public String getNonMember_1h() {
		return nonMember_1h;
	}
	public void setNonMember_1h(String nonMember_1h) {
		this.nonMember_1h = nonMember_1h;
	}
	public String getNonMember_2h() {
		return nonMember_2h;
	}
	public void setNonMember_2h(String nonMember_2h) {
		this.nonMember_2h = nonMember_2h;
	}
	public String getPmtDate() {
		return pmtDate;
	}
	public void setPmtDate(String pmtDate) {
		this.pmtDate = pmtDate;
	}
	public String getTotPmtCnt() {
		return totPmtCnt;
	}
	public void setTotPmtCnt(String totPmtCnt) {
		this.totPmtCnt = totPmtCnt;
	}
	public String getTotPmtPrice() {
		return totPmtPrice;
	}
	public void setTotPmtPrice(String totPmtPrice) {
		this.totPmtPrice = totPmtPrice;
	}
	
	public String getRdt1Ratio() {
		return rdt1Ratio;
	}
	public void setRdt1Ratio(String rdt1Ratio) {
		this.rdt1Ratio = rdt1Ratio;
	}
	public String getRdt1Cnt() {
		return rdt1Cnt;
	}
	public void setRdt1Cnt(String rdt1Cnt) {
		this.rdt1Cnt = rdt1Cnt;
	}
	public String getRdt2Ratio() {
		return rdt2Ratio;
	}
	public void setRdt2Ratio(String rdt2Ratio) {
		this.rdt2Ratio = rdt2Ratio;
	}
	public String getRdt2Cnt() {
		return rdt2Cnt;
	}
	public void setRdt2Cnt(String rdt2Cnt) {
		this.rdt2Cnt = rdt2Cnt;
	}
	public String getRdt3Ratio() {
		return rdt3Ratio;
	}
	public void setRdt3Ratio(String rdt3Ratio) {
		this.rdt3Ratio = rdt3Ratio;
	}
	public String getRdt3Cnt() {
		return rdt3Cnt;
	}
	public void setRdt3Cnt(String rdt3Cnt) {
		this.rdt3Cnt = rdt3Cnt;
	}
	public String getRdt4Ratio() {
		return rdt4Ratio;
	}
	public void setRdt4Ratio(String rdt4Ratio) {
		this.rdt4Ratio = rdt4Ratio;
	}
	public String getRdt4Cnt() {
		return rdt4Cnt;
	}
	public void setRdt4Cnt(String rdt4Cnt) {
		this.rdt4Cnt = rdt4Cnt;
	}
	public String getRdtPmtPrice() {
		return rdtPmtPrice;
	}
	public void setRdtPmtPrice(String rdtPmtPrice) {
		this.rdtPmtPrice = rdtPmtPrice;
	}
	public String getPmtWeek() {
		return pmtWeek;
	}
	public void setPmtWeek(String pmtWeek) {
		this.pmtWeek = pmtWeek;
	}
	public String getChkDailyTicket() {
		return chkDailyTicket;
	}
	public void setChkDailyTicket(String chkDailyTicket) {
		this.chkDailyTicket = chkDailyTicket;
	}
	
	
	
}