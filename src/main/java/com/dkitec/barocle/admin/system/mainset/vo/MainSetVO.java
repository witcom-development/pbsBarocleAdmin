package com.dkitec.barocle.admin.system.mainset.vo;

import javax.validation.GroupSequence;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;

@Alias("mainSetVO")
public class MainSetVO implements java.io.Serializable {
	
	private static final long serialVersionUID = -8992501809945208835L;
	
	private String msi;
	private java.util.List<CategoryVO> msiList;
	
	private String mainCheck;		//재배치유도 - 정책 OPEN 유무
	private String mainVal1;		//재배치유도 - 점유율
	private String mainVal2;		//재배치유도 - 반경
	private String mainVal3;		//재배치유도 - 1회적립 point
	private String mainVal4;		//재배치유도 - 일 최대 적립point
	
	private String mainCheck2;		//탄소절감 - 정책 OPEN 유무
	private String mainVal7;		//탄소절감 - 1회적립 point
	private String mainVal8;		//탄소절감 - 일 최대 적립point
	
	private String mainVal11;		//사용자 - 대여
	private String mainVal12;		//사용자 - 반납
	private String mainVal13;		//관리자 - 대여
	private String mainVal14;		//관리자 - 반납


	public String getMainVal14() {
		return mainVal14;
	}

	public void setMainVal14(String mainVal14) {
		this.mainVal14 = mainVal14;
	}

	public String getMainVal11() {
		return mainVal11;
	}

	public void setMainVal11(String mainVal11) {
		this.mainVal11 = mainVal11;
	}

	public String getMainVal12() {
		return mainVal12;
	}

	public void setMainVal12(String mainVal12) {
		this.mainVal12 = mainVal12;
	}

	public String getMainVal13() {
		return mainVal13;
	}

	public void setMainVal13(String mainVal13) {
		this.mainVal13 = mainVal13;
	}

	public String getMainCheck2() {
		return mainCheck2;
	}

	public void setMainCheck2(String mainCheck2) {
		this.mainCheck2 = mainCheck2;
	}

	public String getMainVal7() {
		return mainVal7;
	}

	public void setMainVal7(String mainVal7) {
		this.mainVal7 = mainVal7;
	}

	public String getMainVal8() {
		return mainVal8;
	}

	public void setMainVal8(String mainVal8) {
		this.mainVal8 = mainVal8;
	}

	public String getMainVal4() {
		return mainVal4;
	}

	public void setMainVal4(String mainVal4) {
		this.mainVal4 = mainVal4;
	}

	public String getMainCheck() {
		return mainCheck;
	}

	public void setMainCheck(String mainCheck) {
		this.mainCheck = mainCheck;
	}

	public String getMainVal1() {
		return mainVal1;
	}

	public void setMainVal1(String mainVal1) {
		this.mainVal1 = mainVal1;
	}

	public String getMainVal2() {
		return mainVal2;
	}

	public void setMainVal2(String mainVal2) {
		this.mainVal2 = mainVal2;
	}

	public String getMainVal3() {
		return mainVal3;
	}

	public void setMainVal3(String mainVal3) {
		this.mainVal3 = mainVal3;
	}

	public String getMsi() {
		return msi;
	}

	public void setMsi(String msi) {
		this.msi = msi;
	}

	public java.util.List<CategoryVO> getMsiList() {
		return msiList;
	}

	public void setMsiList(java.util.List<CategoryVO> msiList) {
		this.msiList = msiList;
	}
	
	@Override
	public String toString() {
		return "MainSetVO [msi=" + msi + ", msiList=" + msiList
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}
	
	private interface MainSetList{}
	private interface MainSetEdit{}
	private interface MainSetInsert{}
	private interface MainSetUpdate{}
	private interface MainSetDelete{}
	
	@GroupSequence({MainSetList.class})
	public static interface MainSetListVal{}
	
	@GroupSequence({MainSetEdit.class})
	public static interface MainSetEditVal{}
	
	@GroupSequence({MainSetInsert.class})
	public static interface MainSetInsertVal{}
	
	@GroupSequence({MainSetUpdate.class})
	public static interface MainSetUpdateVal{}
	
	@GroupSequence({MainSetDelete.class})
	public static interface MainSetDeleteVal{}
	
}
