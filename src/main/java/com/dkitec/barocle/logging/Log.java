package com.dkitec.barocle.logging;

import java.text.DecimalFormat;

public class Log {

	private static DecimalFormat logIdFormat = new DecimalFormat("0000000000");

	private String logId;
	private String loginId;
	private String loginIp;
	private long requestTime;
	private long responseTime;
	private String requestCategory;
	private String requestName;
	private String requestUri;
	private String requestHname;
	private String errorCode;
	private String errorMessage;

	public Log() {

		logId = logIdFormat.format(Math.random() * 10000000000L);
	}

	public String getLogId() {

		return logId;
	}
	
	public String getLoginId() {
		
		return loginId;
		
	}
	
	public void setLoginId(String loginId) {
		
		this.loginId = loginId;
		
	}
	
	public String getLoginIp() {
		
		return loginIp;
		
	}
	
	public void setLoginIp(String loginIp) {
		
		this.loginIp = loginIp;
		
	}

	public long getRequestTime() {

		return requestTime;
	}

	public void setRequestTime(long requestTime) {

		this.requestTime = requestTime;
	}

	public long getResponseTime() {

		return responseTime;
	}

	public void setResponseTime(long responseTime) {

		this.responseTime = responseTime;
	}

	public String getRequestCategory() {

		return requestCategory;
	}

	public void setRequestCategory(String requestCategory) {

		this.requestCategory = requestCategory;
	}

	public String getRequestName() {

		return requestName;
	}

	public void setRequestName(String requestName) {

		this.requestName = requestName;
	}

	public String getRequestUri() {

		return requestUri;
	}

	public void setRequestUri(String requestUri) {

		this.requestUri = requestUri;
	}
	
	public String getRequestHname() {
		
		return requestHname;
		
	}
	
	public void setRequestHname(String requestHname) {
		
		this.requestHname = requestHname;
		
	}

	public String getErrorCode() {

		return errorCode;
	}

	public void setErrorCode(String errorCode) {

		this.errorCode = errorCode;
	}

	public String getErrorMessage() {

		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {

		this.errorMessage = errorMessage;
	}

	public double getElapsedTime() {

		return ((double)responseTime - requestTime) / 1000;
	}
	
}
