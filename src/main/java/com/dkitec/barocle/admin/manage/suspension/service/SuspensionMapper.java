package com.dkitec.barocle.admin.manage.suspension.service;

import com.dkitec.barocle.admin.manage.suspension.vo.SuspensionVO;
import com.dkitec.barocle.admin.manage.suspension.vo.VoucherHistVO;
import com.dkitec.barocle.admin.manage.suspension.vo.VoucherVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("suspensionMapper")
public interface SuspensionMapper {
	
	public int listSuspensionCount(SuspensionVO suspensionVO);
	
	public java.util.List<SuspensionVO> listSuspension(SuspensionVO suspensionVO);
	
	public SuspensionVO viewSuspension(SuspensionVO suspensionVO);
	
	public int insertSuspension(SuspensionVO suspensionVO);
	
	public int updateSuspension(SuspensionVO suspensionVO);
	
	public int getDuplicateCount(SuspensionVO suspensionVO);
	
	public java.util.List<VoucherVO> getVoucherList(SuspensionVO suspensionVO);
	
	public java.util.List<VoucherVO> getUpdateVoucherList(SuspensionVO suspensionVO);
	
	public int updateVoucher(VoucherVO voucherVO);
	
	public int insertVoucherHist(VoucherHistVO voucherHistVO);
	
	public int updateVoucherHist(VoucherHistVO voucherHistVO);
	
	public int deleteSuspension(SuspensionVO suspensionVO);

}
