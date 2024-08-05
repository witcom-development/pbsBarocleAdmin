/*
 * @Package Name : com.dkitec.barocle.admin.common.service.serviceImpl
 * @파일명          : ExcelUploadProcServiceImpl.java
 * @작성일          : 2015. 8. 14.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 8. 14.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.common.service.serviceImpl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.common.service.ExcelUploadProcMapper;
import com.dkitec.barocle.admin.common.service.ExcelUploadProcService;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

/**
 * @파일명          : ExcelUploadProcServiceImpl.java
 * @작성일          : 2015. 8. 14.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 8. 14.   |   ymshin   |  최초작성
 */
@Service(value="excelUploadProcService")
public class ExcelUploadProcServiceImpl implements ExcelUploadProcService {
	
	
	@Autowired
    private ExcelUploadProcMapper excelUploadProcMapper;
	@Override
	@Transactional(readOnly=false, propagation=Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int addDeviceExcelData(List<HashMap<String, String>> addList) {
        int result = 0;
		int hist = 0;
		int chkEquipOrder =0;
        for(HashMap<String, String> map : addList) {
        	
        	result += excelUploadProcMapper.addDeviceExcelData(map);
        	if(!map.get("DEV_TYPE").equals(IConstants.COUNSEL_LIST))
        		hist += excelUploadProcMapper.addDeviceExcelDataLocateHist(map);
        	else
        		hist = result;
        	if(map.get("DEV_TYPE").equals(IConstants.DEVICE_TERMINAL)) {
        		chkEquipOrder = excelUploadProcMapper.setTerminalIdToBike(map);
        		
        	}
        }
		if(result != hist) {
			result = 0;
		}
		return result;
	}
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean chkSerialNo(HashMap<String, String> errorMap) {
        int result = excelUploadProcMapper.chkSerialNo(errorMap);
		return result > 0 ? true : false;
	}
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean chkExistStation(String cellStr) {
		int result = excelUploadProcMapper.chkExistStation(cellStr);
		return result > 0 ? true : false;
	}
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean chkExistCenter(String cellStr) {
		int result = excelUploadProcMapper.chkExistCenter(cellStr);
		return result > 0 ? true : false;
	}
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public String isExistBikeId(String cellStr) {
		return excelUploadProcMapper.isExistBikeId(cellStr);
	}
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean isAlreadyExistTeminal(String cellStr) {
		int result = excelUploadProcMapper.isAlreadyExistTeminal(cellStr);
		return result > 0 ? true :false;
	}
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean chkExistDeviceId(HashMap<String, String> errorMap) {
		int result = excelUploadProcMapper.chkExistDeviceId(errorMap);
		return result > 0 ? true :false;
	}
	/**
	 * @location   : com.dkitec.barocle.admin.common.service.serviceImpl.ExcelUploadProcService.isChkExistBikeNo
	 * @writeDay   : 2015. 8. 16. 오후 11:26:04
	 * @overridden : @see com.dkitec.barocle.admin.common.service.ExcelUploadProcService#isChkExistBikeNo(java.lang.String)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean isChkExistBikeNo(String cellStr) {
		int result = excelUploadProcMapper.isChkExistBikeNo(cellStr);
		return result > 0 ? true :false;
	}
	/**
	 * @location   : com.dkitec.barocle.admin.common.service.serviceImpl.ExcelUploadProcService.isExistChkEquipOrder
	 * @writeDay   : 2015. 8. 17. 오후 2:07:07
	 * @overridden : @see com.dkitec.barocle.admin.common.service.ExcelUploadProcService#isExistChkEquipOrder(java.util.HashMap)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int isExistChkEquipOrder(HashMap<String, String> arm) {
		return excelUploadProcMapper.isExistChkEquipOrder(arm);
	}
	/**
	 * @location   : com.dkitec.barocle.admin.common.service.serviceImpl.ExcelUploadProcService.addDevicePartStock
	 * @writeDay   : 2015. 8. 19. 오후 1:38:53
	 * @overridden : @see com.dkitec.barocle.admin.common.service.ExcelUploadProcService#addDevicePartStock(java.util.List)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=false, propagation=Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int addDevicePartStock(List<HashMap<String, String>> addList) {
		int result = 0;
		for(HashMap<String, String> item: addList) {
			boolean chkStock = excelUploadProcMapper.isStockExistChk(item) > 0 ? true : false;
			if(chkStock) {
				result = excelUploadProcMapper.setDevicePartStockitem(item);
			} else {
				result = excelUploadProcMapper.addDevicePartStockitem(item);
			}
		
		}
		return result;
	}
	/**
	 * @location   : com.dkitec.barocle.admin.common.service.serviceImpl.ExcelUploadProcService.chkExistParts
	 * @writeDay   : 2015. 8. 19. 오후 2:01:18
	 * @overridden : @see com.dkitec.barocle.admin.common.service.ExcelUploadProcService#chkExistParts(java.lang.String)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean chkExistParts(String cellStr) {
	    int result = excelUploadProcMapper.chkExistParts(cellStr);
		return result > 0 ? true : false;
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean chkExistEntrps(String cellStr) {
		int result = excelUploadProcMapper.chkExistEntrps(cellStr);
		return result > 0 ? true : false;
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean chkExistBikeSeCd(String cellStr) {
		int result = excelUploadProcMapper.chkExistBikeSeCd(cellStr);
		return result > 0 ? true : false;
	}
	
	@Override
	@Transactional(readOnly=false, propagation=Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int addCounselExcelData(List<HashMap<String, String>> addList) {
        int result = 0;
        for(HashMap<String, String> map : addList) {
        	result += excelUploadProcMapper.addDeviceExcelData(map);
        }
		return result;
	}
}
