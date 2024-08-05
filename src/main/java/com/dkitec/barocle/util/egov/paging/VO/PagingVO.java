package com.dkitec.barocle.util.egov.paging.VO;

import javax.validation.GroupSequence;
import javax.validation.constraints.Size;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.dkitec.barocle.util.validator.annotation.IsDate;

public class PagingVO extends ModeVO implements java.io.Serializable {
	
	private static final long serialVersionUID = -5294563096779643443L;
	
	private int currentPageNo = 1;
	private int recordCountPerPage;
	private int pageSize;
	private int totalRecordCount;
	
	private int firstRecordIndex;
	
	@Size(max=20, message="20자 이하만 가능 합니다." , groups=SearchValue.class)
	private String searchValue;
	private String searchParameter;
	
	private String searchDate;
	@IsDate(groups=SearchStartDate.class)
	private String searchStartDate;
	@IsDate(groups=SearchEndDate.class)
	private String searchEndDate;
	
	public int getCurrentPageNo() {
		return currentPageNo;
	}
	public void setCurrentPageNo(int currentPageNo) {
		this.currentPageNo = currentPageNo;
	}
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getTotalRecordCount() {
		return totalRecordCount;
	}
	public void setTotalRecordCount(int totalRecordCount) {
		this.totalRecordCount = totalRecordCount;
	}
	public int getFirstRecordIndex() {
		return firstRecordIndex;
	}
	public void setFirstRecordIndex(int firstRecordIndex) {
		this.firstRecordIndex = firstRecordIndex;
	}
	public String getSearchValue() {
		return searchValue;
	}
	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
	public String getSearchParameter() {
		return searchParameter;
	}
	public void setSearchParameter(String searchParameter) {
		this.searchParameter = searchParameter;
	}
	public String getSearchDate() {
		return searchDate;
	}
	public void setSearchDate(String searchDate) {
		this.searchDate = searchDate;
	}
	public String getSearchStartDate() {
		return searchStartDate;
	}
	public void setSearchStartDate(String searchStartDate) {
		this.searchStartDate = searchStartDate;
	}
	public String getSearchEndDate() {
		return searchEndDate;
	}
	public void setSearchEndDate(String searchEndDate) {
		this.searchEndDate = searchEndDate;
	}
	
	public interface SearchStartDate{}
	public interface SearchEndDate{}
	public interface SearchValue{}
	
	@GroupSequence({SearchStartDate.class,SearchEndDate.class})
	public interface SearchDateValidator {}
	
	@Override
    public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
    }
}
