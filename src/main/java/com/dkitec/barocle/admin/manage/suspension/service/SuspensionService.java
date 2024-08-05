package com.dkitec.barocle.admin.manage.suspension.service;

import com.dkitec.barocle.admin.manage.suspension.vo.SuspensionVO;

public interface SuspensionService {
	
	public int listSuspensionCount(SuspensionVO suspensionVO);
	
	public java.util.List<SuspensionVO> listSuspension(SuspensionVO suspensionVO);
	
	public SuspensionVO viewSuspension(SuspensionVO suspensionVO);
	
	public SuspensionVO insertSuspension(SuspensionVO suspensionVO);
	
	public SuspensionVO updateSuspension(SuspensionVO suspensionVO);
	
	public int getDuplicateCount(SuspensionVO suspensionVO);
	
	public int deleteSuspension(SuspensionVO suspensionVO);
	
	public int countSuspensionValid(SuspensionVO suspensionVO);

}
