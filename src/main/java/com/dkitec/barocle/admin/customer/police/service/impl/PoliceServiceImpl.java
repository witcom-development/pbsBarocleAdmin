package com.dkitec.barocle.admin.customer.police.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.faq.service.FaqMapper;
import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;
import com.dkitec.barocle.admin.customer.police.service.PoliceMapper;
import com.dkitec.barocle.admin.customer.police.service.PoliceService;
import com.dkitec.barocle.admin.customer.police.vo.PoliceVO;
import com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO;
import com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairPartsVO;
import com.dkitec.barocle.admin.customer.donor.service.DonorMapper;
import com.dkitec.barocle.admin.customer.donor.service.DonorService;
import com.dkitec.barocle.admin.customer.donor.vo.DonorVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.barocle.util.webutil.StringUtil;

@Service("policeService")
public class PoliceServiceImpl implements PoliceService {
	
	@Autowired PoliceMapper policeMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int listPoliceCount(PoliceVO policeVO) {
		return policeMapper.listPoliceCount(policeVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<PoliceVO> listPolice(PoliceVO policeVO) {
		return policeMapper.listPolice(policeVO);
	}

	
	

	@Override
	@Transactional(readOnly=true)
	public List<PoliceVO> listPoliceExcel(PoliceVO policeVO) {
		// TODO Auto-generated method stub
		return policeMapper.listPoliceExcel(policeVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	public List<PoliceVO> listPoliceExcel2(PoliceVO policeVO) {
		// TODO Auto-generated method stub
		return policeMapper.listPoliceExcel2(policeVO);
	}	
	
	
	@Override
	@Transactional(readOnly=true)
	public List<PoliceVO> listPoliceExcel3(PoliceVO policeVO) {
		// TODO Auto-generated method stub
		return policeMapper.listPoliceExcel3(policeVO);
	}	
		
	
	
	
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int deletePolice(PoliceVO policeVO) {
		return policeMapper.deletePolice(policeVO);
	}
	
	
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int updatePolice(PoliceVO policeVO) {
		return policeMapper.updatePolice(policeVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int updateIssueDttm(PoliceVO policeVO) {
		return policeMapper.updateIssueDttm(policeVO);
	}
	
	
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int insertPolice(PoliceVO policeVO) {
		
		return policeMapper.insertPolice(policeVO);
	}

}
