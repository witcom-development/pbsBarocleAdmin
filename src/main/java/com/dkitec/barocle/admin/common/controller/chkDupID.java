package com.dkitec.barocle.admin.common.controller;

import java.util.Comparator;

import com.dkitec.barocle.admin.common.vo.TreeVO;

public class chkDupID implements Comparator {

	@Override
	public int compare(Object o1, Object o2) {
		TreeVO tree1 = (TreeVO)o1;
		TreeVO tree2 = (TreeVO)o2;
		int result = (tree1.getCHECKID()).compareToIgnoreCase(tree2.getCHECKID());
		return result;
	}

}
