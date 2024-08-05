package com.dkitec.barocle.admin.statistics.zeropay.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.CommonVo;

@SuppressWarnings("serial")
@Alias("zeropayStatisticsVo")

public class ZeropayStatisticsVO extends CommonVo implements Serializable {
	
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
	
	private String ticketPmt_1day;
	private String ticketPmt_7day;
	private String ticketPmt_30day;
	private String ticketPmt_180day;
	private String ticketPmt_365day;
	
	
	private String ticket_7day_1h;
	private String ticket_7day_2h;
	private String ticket_30day_1h;
	private String ticket_30day_2h;
	private String ticket_180day_1h;
	private String ticket_180day_2h;
	private String ticket_365day_1h;
	private String ticket_365day_2h;
	
	private String ticketPmt_7day_1h;
	private String ticketPmt_7day_2h;
	private String ticketPmt_30day_1h;
	private String ticketPmt_30day_2h;
	private String ticketPmt_180day_1h;
	private String ticketPmt_180day_2h;
	private String ticketPmt_365day_1h;
	private String ticketPmt_365day_2h;
	
	
	private String member_1h;
	private String memberPmt_1h;
	private String member_2h;
	private String memberPmt_2h;
	private String nonMember_1h;
	private String nonMemberPmt_1h;
	private String nonMember_2h;
	private String nonMemberPmt_2h;
	private String foreigner_24h;
	private String foreignerPmt_24h;
	
	private String chkTicket;
	
	private String chkDailyTicket;
	private String pmtDate; 
	private String pmtWeek; 
	private String totPmtCnt;
	private String totPmtPrice;
	private String zeropayPmt_price;
	private String zeropayPmt_priceRatio;
	private String zeropayPmt_cnt;
	private String zeropayPmt_ratio;
	private String creditPmt_price;
	private String creditPmt_priceRatio;
	private String creditPmt_cnt;
	private String creditPmt_ratio;
	private String phonePmt_price;
	private String phonePmt_priceRatio;
	private String phonePmt_cnt;
	private String phonePmt_ratio;
	private String kakaoPmt_price;
	private String kakaoPmt_priceRatio;
	private String kakaoPmt_cnt;
	private String kakaoPmt_ratio;
	private String paycoPmt_price;
	private String paycoPmt_priceRatio;
	private String paycoPmt_cnt;
	private String paycoPmt_ratio;
	private String otherPmt_price;
	private String otherPmt_priceRatio;
	private String otherPmt_cnt;
	private String otherPmt_ratio;
	
	
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
	public String getZeropayPmt_price() {
		return zeropayPmt_price;
	}
	public void setZeropayPmt_price(String zeropayPmt_price) {
		this.zeropayPmt_price = zeropayPmt_price;
	}
	public String getZeropayPmt_priceRatio() {
		return zeropayPmt_priceRatio;
	}
	public void setZeropayPmt_priceRatio(String zeropayPmt_priceRatio) {
		this.zeropayPmt_priceRatio = zeropayPmt_priceRatio;
	}
	public String getZeropayPmt_cnt() {
		return zeropayPmt_cnt;
	}
	public void setZeropayPmt_cnt(String zeropayPmt_cnt) {
		this.zeropayPmt_cnt = zeropayPmt_cnt;
	}
	public String getZeropayPmt_ratio() {
		return zeropayPmt_ratio;
	}
	public void setZeropayPmt_ratio(String zeropayPmt_ratio) {
		this.zeropayPmt_ratio = zeropayPmt_ratio;
	}
	public String getCreditPmt_cnt() {
		return creditPmt_cnt;
	}
	public void setCreditPmt_cnt(String creditPmt_cnt) {
		this.creditPmt_cnt = creditPmt_cnt;
	}
	public String getCreditPmt_ratio() {
		return creditPmt_ratio;
	}
	public void setCreditPmt_ratio(String creditPmt_ratio) {
		this.creditPmt_ratio = creditPmt_ratio;
	}
	public String getPhonePmt_cnt() {
		return phonePmt_cnt;
	}
	public void setPhonePmt_cnt(String phonePmt_cnt) {
		this.phonePmt_cnt = phonePmt_cnt;
	}
	public String getPhonePmt_ratio() {
		return phonePmt_ratio;
	}
	public void setPhonePmt_ratio(String phonePmt_ratio) {
		this.phonePmt_ratio = phonePmt_ratio;
	}
	public String getKakaoPmt_cnt() {
		return kakaoPmt_cnt;
	}
	public void setKakaoPmt_cnt(String kakaoPmt_cnt) {
		this.kakaoPmt_cnt = kakaoPmt_cnt;
	}
	public String getKakaoPmt_ratio() {
		return kakaoPmt_ratio;
	}
	public void setKakaoPmt_ratio(String kakaoPmt_ratio) {
		this.kakaoPmt_ratio = kakaoPmt_ratio;
	}
	public String getPaycoPmt_cnt() {
		return paycoPmt_cnt;
	}
	public void setPaycoPmt_cnt(String paycoPmt_cnt) {
		this.paycoPmt_cnt = paycoPmt_cnt;
	}
	public String getPaycoPmt_ratio() {
		return paycoPmt_ratio;
	}
	public void setPaycoPmt_ratio(String paycoPmt_ratio) {
		this.paycoPmt_ratio = paycoPmt_ratio;
	}
	public String getOtherPmt_cnt() {
		return otherPmt_cnt;
	}
	public void setOtherPmt_cnt(String otherPmt_cnt) {
		this.otherPmt_cnt = otherPmt_cnt;
	}
	public String getOtherPmt_ratio() {
		return otherPmt_ratio;
	}
	public void setOtherPmt_ratio(String otherPmt_ratio) {
		this.otherPmt_ratio = otherPmt_ratio;
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
	public String getCreditPmt_price() {
		return creditPmt_price;
	}
	public void setCreditPmt_price(String creditPmt_price) {
		this.creditPmt_price = creditPmt_price;
	}
	public String getCreditPmt_priceRatio() {
		return creditPmt_priceRatio;
	}
	public void setCreditPmt_priceRatio(String creditPmt_priceRatio) {
		this.creditPmt_priceRatio = creditPmt_priceRatio;
	}
	public String getPhonePmt_price() {
		return phonePmt_price;
	}
	public void setPhonePmt_price(String phonePmt_price) {
		this.phonePmt_price = phonePmt_price;
	}
	public String getPhonePmt_priceRatio() {
		return phonePmt_priceRatio;
	}
	public void setPhonePmt_priceRatio(String phonePmt_priceRatio) {
		this.phonePmt_priceRatio = phonePmt_priceRatio;
	}
	public String getKakaoPmt_price() {
		return kakaoPmt_price;
	}
	public void setKakaoPmt_price(String kakaoPmt_price) {
		this.kakaoPmt_price = kakaoPmt_price;
	}
	public String getKakaoPmt_priceRatio() {
		return kakaoPmt_priceRatio;
	}
	public void setKakaoPmt_priceRatio(String kakaoPmt_priceRatio) {
		this.kakaoPmt_priceRatio = kakaoPmt_priceRatio;
	}
	public String getPaycoPmt_price() {
		return paycoPmt_price;
	}
	public void setPaycoPmt_price(String paycoPmt_price) {
		this.paycoPmt_price = paycoPmt_price;
	}
	public String getPaycoPmt_priceRatio() {
		return paycoPmt_priceRatio;
	}
	public void setPaycoPmt_priceRatio(String paycoPmt_priceRatio) {
		this.paycoPmt_priceRatio = paycoPmt_priceRatio;
	}
	public String getOtherPmt_price() {
		return otherPmt_price;
	}
	public void setOtherPmt_price(String otherPmt_price) {
		this.otherPmt_price = otherPmt_price;
	}
	public String getOtherPmt_priceRatio() {
		return otherPmt_priceRatio;
	}
	public void setOtherPmt_priceRatio(String otherPmt_priceRatio) {
		this.otherPmt_priceRatio = otherPmt_priceRatio;
	}
	public String getTicketPmt_1day() {
		return ticketPmt_1day;
	}
	public void setTicketPmt_1day(String ticketPmt_1day) {
		this.ticketPmt_1day = ticketPmt_1day;
	}
	public String getTicketPmt_7day() {
		return ticketPmt_7day;
	}
	public void setTicketPmt_7day(String ticketPmt_7day) {
		this.ticketPmt_7day = ticketPmt_7day;
	}
	public String getTicketPmt_30day() {
		return ticketPmt_30day;
	}
	public void setTicketPmt_30day(String ticketPmt_30day) {
		this.ticketPmt_30day = ticketPmt_30day;
	}
	public String getTicketPmt_180day() {
		return ticketPmt_180day;
	}
	public void setTicketPmt_180day(String ticketPmt_180day) {
		this.ticketPmt_180day = ticketPmt_180day;
	}
	public String getTicketPmt_365day() {
		return ticketPmt_365day;
	}
	public void setTicketPmt_365day(String ticketPmt_365day) {
		this.ticketPmt_365day = ticketPmt_365day;
	}
	public String getMemberPmt_1h() {
		return memberPmt_1h;
	}
	public void setMemberPmt_1h(String memberPmt_1h) {
		this.memberPmt_1h = memberPmt_1h;
	}
	public String getMemberPmt_2h() {
		return memberPmt_2h;
	}
	public void setMemberPmt_2h(String memberPmt_2h) {
		this.memberPmt_2h = memberPmt_2h;
	}
	public String getNonMemberPmt_1h() {
		return nonMemberPmt_1h;
	}
	public void setNonMemberPmt_1h(String nonMemberPmt_1h) {
		this.nonMemberPmt_1h = nonMemberPmt_1h;
	}
	public String getNonMemberPmt_2h() {
		return nonMemberPmt_2h;
	}
	public void setNonMemberPmt_2h(String nonMemberPmt_2h) {
		this.nonMemberPmt_2h = nonMemberPmt_2h;
	}
	public String getForeigner_24h() {
		return foreigner_24h;
	}
	public void setForeigner_24h(String foreigner_24h) {
		this.foreigner_24h = foreigner_24h;
	}
	public String getForeignerPmt_24h() {
		return foreignerPmt_24h;
	}
	public void setForeignerPmt_24h(String foreignerPmt_24h) {
		this.foreignerPmt_24h = foreignerPmt_24h;
	}
	public String getChkTicket() {
		return chkTicket;
	}
	public void setChkTicket(String chkTicket) {
		this.chkTicket = chkTicket;
	}
	public String getTicket_7day_1h() {
		return ticket_7day_1h;
	}
	public void setTicket_7day_1h(String ticket_7day_1h) {
		this.ticket_7day_1h = ticket_7day_1h;
	}
	public String getTicket_7day_2h() {
		return ticket_7day_2h;
	}
	public void setTicket_7day_2h(String ticket_7day_2h) {
		this.ticket_7day_2h = ticket_7day_2h;
	}
	public String getTicket_30day_1h() {
		return ticket_30day_1h;
	}
	public void setTicket_30day_1h(String ticket_30day_1h) {
		this.ticket_30day_1h = ticket_30day_1h;
	}
	public String getTicket_30day_2h() {
		return ticket_30day_2h;
	}
	public void setTicket_30day_2h(String ticket_30day_2h) {
		this.ticket_30day_2h = ticket_30day_2h;
	}
	public String getTicket_180day_1h() {
		return ticket_180day_1h;
	}
	public void setTicket_180day_1h(String ticket_180day_1h) {
		this.ticket_180day_1h = ticket_180day_1h;
	}
	public String getTicket_180day_2h() {
		return ticket_180day_2h;
	}
	public void setTicket_180day_2h(String ticket_180day_2h) {
		this.ticket_180day_2h = ticket_180day_2h;
	}
	public String getTicket_365day_1h() {
		return ticket_365day_1h;
	}
	public void setTicket_365day_1h(String ticket_365day_1h) {
		this.ticket_365day_1h = ticket_365day_1h;
	}
	public String getTicket_365day_2h() {
		return ticket_365day_2h;
	}
	public void setTicket_365day_2h(String ticket_365day_2h) {
		this.ticket_365day_2h = ticket_365day_2h;
	}
	public String getTicketPmt_7day_1h() {
		return ticketPmt_7day_1h;
	}
	public void setTicketPmt_7day_1h(String ticketPmt_7day_1h) {
		this.ticketPmt_7day_1h = ticketPmt_7day_1h;
	}
	public String getTicketPmt_7day_2h() {
		return ticketPmt_7day_2h;
	}
	public void setTicketPmt_7day_2h(String ticketPmt_7day_2h) {
		this.ticketPmt_7day_2h = ticketPmt_7day_2h;
	}
	public String getTicketPmt_30day_1h() {
		return ticketPmt_30day_1h;
	}
	public void setTicketPmt_30day_1h(String ticketPmt_30day_1h) {
		this.ticketPmt_30day_1h = ticketPmt_30day_1h;
	}
	public String getTicketPmt_30day_2h() {
		return ticketPmt_30day_2h;
	}
	public void setTicketPmt_30day_2h(String ticketPmt_30day_2h) {
		this.ticketPmt_30day_2h = ticketPmt_30day_2h;
	}
	public String getTicketPmt_180day_1h() {
		return ticketPmt_180day_1h;
	}
	public void setTicketPmt_180day_1h(String ticketPmt_180day_1h) {
		this.ticketPmt_180day_1h = ticketPmt_180day_1h;
	}
	public String getTicketPmt_180day_2h() {
		return ticketPmt_180day_2h;
	}
	public void setTicketPmt_180day_2h(String ticketPmt_180day_2h) {
		this.ticketPmt_180day_2h = ticketPmt_180day_2h;
	}
	public String getTicketPmt_365day_1h() {
		return ticketPmt_365day_1h;
	}
	public void setTicketPmt_365day_1h(String ticketPmt_365day_1h) {
		this.ticketPmt_365day_1h = ticketPmt_365day_1h;
	}
	public String getTicketPmt_365day_2h() {
		return ticketPmt_365day_2h;
	}
	public void setTicketPmt_365day_2h(String ticketPmt_365day_2h) {
		this.ticketPmt_365day_2h = ticketPmt_365day_2h;
	}
	
	
}