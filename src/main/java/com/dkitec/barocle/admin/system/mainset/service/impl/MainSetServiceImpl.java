package com.dkitec.barocle.admin.system.mainset.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;
import com.dkitec.barocle.admin.system.mainset.service.MainSetMapper;
import com.dkitec.barocle.admin.system.mainset.service.MainSetService;
import com.dkitec.barocle.admin.system.mainset.vo.MainSetVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service("mainSetService")
public class MainSetServiceImpl implements MainSetService {

	@Autowired MainSetMapper mainSetMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<CategoryVO> listMainSet(CategoryVO categoryVO) {
		return mainSetMapper.listMainSet(categoryVO);
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public MainSetVO updateMainSet(MainSetVO mainSetVO) {
		@SuppressWarnings("unused") int resultValue = 0;

		//재배치유도-점유율
		if(!(mainSetVO.getMainVal1() == null || mainSetVO.getMainVal1().equals(""))){
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_025");
			categorVo.setAddVal1(mainSetVO.getMainVal1());
			resultValue = mainSetMapper.updateMainSet(categorVo);
		}else{
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_025");
			categorVo.setAddVal1("");
			resultValue = mainSetMapper.updateMainSet(categorVo);
		}
		
		//재배치유도-반경
		if(!(mainSetVO.getMainVal2() == null || mainSetVO.getMainVal2().equals(""))){
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_026");
			categorVo.setAddVal1(mainSetVO.getMainVal2());
			resultValue = mainSetMapper.updateMainSet(categorVo);
		}else{
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_026");
			categorVo.setAddVal1("");
			resultValue = mainSetMapper.updateMainSet(categorVo);
		}
		
		//재배치유도-마일리지 (1회 적립 point)
		if(!(mainSetVO.getMainVal3() == null || mainSetVO.getMainVal3().equals(""))){
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_027");
			categorVo.setAddVal1(mainSetVO.getMainVal3());
			resultValue = mainSetMapper.updateMainSet(categorVo);
		}else{
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_027");
			categorVo.setAddVal1("");
			resultValue = mainSetMapper.updateMainSet(categorVo);
		}
		
		//재배치유도-마일리지 (일 최대 적립 point)
		if(!(mainSetVO.getMainVal4() == null || mainSetVO.getMainVal4().equals(""))){
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_028");
			categorVo.setAddVal1(mainSetVO.getMainVal4());
			resultValue = mainSetMapper.updateMainSet(categorVo);
		}else{
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_028");
			categorVo.setAddVal1("");
			resultValue = mainSetMapper.updateMainSet(categorVo);
		}

		//재배치유도-정책 OPEN
		if(!(mainSetVO.getMainCheck() == null || mainSetVO.getMainCheck().equals(""))){
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_029");
			categorVo.setAddVal1(mainSetVO.getMainCheck());
			resultValue = mainSetMapper.updateMainSet(categorVo);
			
			categorVo.setAddVal3("107004%");
			if(mainSetVO.getMainCheck().equals("Y")){
				categorVo.setAddVal1("N");//사용자 메뉴는 Hidden_Yn이 N일 때 활성화
			} else {
				categorVo.setAddVal1("Y");//사용자 메뉴는 Hidden_Yn이 N일 때 비활성화
			}
			resultValue = mainSetMapper.updateMainSetMbMenu(categorVo);
		}else{
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_029");
			categorVo.setAddVal1("");
			resultValue = mainSetMapper.updateMainSet(categorVo);
			categorVo.setAddVal3("107004%");
			categorVo.setAddVal1("Y");//사용자 메뉴는 Hidden_Yn이 N일 때 비활성화
			resultValue = mainSetMapper.updateMainSetMbMenu(categorVo);
		}
		
		//탄소절감-(1회 적립 point)
		if(!(mainSetVO.getMainVal7() == null || mainSetVO.getMainVal7().equals(""))){
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_030");
			categorVo.setAddVal1(mainSetVO.getMainVal7());
			resultValue = mainSetMapper.updateMainSet(categorVo);
		}else{
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_030");
			categorVo.setAddVal1("");
			resultValue = mainSetMapper.updateMainSet(categorVo);
		}
		
		//탄소절감- (일 최대 적립 point)
		if(!(mainSetVO.getMainVal8() == null || mainSetVO.getMainVal8().equals(""))){
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_031");
			categorVo.setAddVal1(mainSetVO.getMainVal8());
			resultValue = mainSetMapper.updateMainSet(categorVo);
		}else{
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_031");
			categorVo.setAddVal1("");
			resultValue = mainSetMapper.updateMainSet(categorVo);
		}

		//탄소절감-정책 OPEN
		if(!(mainSetVO.getMainCheck2() == null || mainSetVO.getMainCheck2().equals(""))){
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_032");
			categorVo.setAddVal1(mainSetVO.getMainCheck2());
			resultValue = mainSetMapper.updateMainSet(categorVo);
			
			categorVo.setAddVal3("105011%");
			if(mainSetVO.getMainCheck().equals("Y")){
				categorVo.setAddVal1("N");//사용자 메뉴는 Hidden_Yn이 N일 때 활성화
			} else {
				categorVo.setAddVal1("Y");//사용자 메뉴는 Hidden_Yn이 N일 때 비활성화
			}
			resultValue = mainSetMapper.updateMainSetMbMenu(categorVo);
		}else{
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_032");
			categorVo.setAddVal1("");
			resultValue = mainSetMapper.updateMainSet(categorVo);
			
			categorVo.setAddVal3("105011%");
			categorVo.setAddVal1("Y");//사용자 메뉴는 Hidden_Yn이 N일 때 비활성화
			resultValue = mainSetMapper.updateMainSetMbMenu(categorVo);
		}
		
		//QR자전거 상태 주기보고(분) - (사용자(대여))
		if(!(mainSetVO.getMainVal11() == null || mainSetVO.getMainVal11().equals(""))){
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_035");
			categorVo.setAddVal1(mainSetVO.getMainVal11());
			resultValue = mainSetMapper.updateMainSet(categorVo);
		}else{
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_035");
			categorVo.setAddVal1("");
			resultValue = mainSetMapper.updateMainSet(categorVo);
		}
		
		//QR자전거 상태 주기보고(분) - (사용자(반납))
		if(!(mainSetVO.getMainVal12() == null || mainSetVO.getMainVal12().equals(""))){
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_036");
			categorVo.setAddVal1(mainSetVO.getMainVal12());
			resultValue = mainSetMapper.updateMainSet(categorVo);
		}else{
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_036");
			categorVo.setAddVal1("");
			resultValue = mainSetMapper.updateMainSet(categorVo);
		}
		
		//QR자전거 상태 주기보고(분) - (관리자(이동))
		if(!(mainSetVO.getMainVal13() == null || mainSetVO.getMainVal13().equals(""))){
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_037");
			categorVo.setAddVal1(mainSetVO.getMainVal13());
			resultValue = mainSetMapper.updateMainSet(categorVo);
		}else{
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_037");
			categorVo.setAddVal1("");
			resultValue = mainSetMapper.updateMainSet(categorVo);
		}
		
		//QR자전거 상태 주기보고(분) - (관리자(설치))
		if(!(mainSetVO.getMainVal14() == null || mainSetVO.getMainVal14().equals(""))){
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_038");
			categorVo.setAddVal1(mainSetVO.getMainVal14());
			resultValue = mainSetMapper.updateMainSet(categorVo);
		}else{
			CategoryVO categorVo =  new CategoryVO();
			categorVo.setComCD("MSI_038");
			categorVo.setAddVal1("");
			resultValue = mainSetMapper.updateMainSet(categorVo);
		}
		
		if(mainSetVO.getMsiList().size()>0){
			for(CategoryVO updateCategoryVO : mainSetVO.getMsiList()){
				resultValue = mainSetMapper.updateMainSet(updateCategoryVO);
			}
		}
		return mainSetVO;
	}

}
