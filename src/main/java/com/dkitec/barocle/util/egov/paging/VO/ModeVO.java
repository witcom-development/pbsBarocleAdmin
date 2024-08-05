package com.dkitec.barocle.util.egov.paging.VO;

import javax.validation.GroupSequence;

import com.dkitec.barocle.util.validator.annotation.ValMode;

public class ModeVO implements java.io.Serializable {
	
	private static final long serialVersionUID = -5958866650908998552L;
	
	@ValMode(groups=SetMode.class)
	private String mode;

	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	
	private interface SetMode{}
	
	@GroupSequence(SetMode.class)
	public static interface GetMode{}

}
