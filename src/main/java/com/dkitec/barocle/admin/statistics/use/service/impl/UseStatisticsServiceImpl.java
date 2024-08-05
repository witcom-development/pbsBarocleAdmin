package com.dkitec.barocle.admin.statistics.use.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.notice.vo.NoticeVO;
import com.dkitec.barocle.admin.statistics.use.service.UseStatisticsMapper;
import com.dkitec.barocle.admin.statistics.use.service.UseStatisticsService;
import com.dkitec.barocle.admin.statistics.use.vo.UseStatisticsBoardVO;
import com.dkitec.barocle.admin.statistics.use.vo.UseStatisticsVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.barocle.util.webutil.StringUtil;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service(value="useStatisticsService")
public class UseStatisticsServiceImpl extends EgovAbstractServiceImpl implements UseStatisticsService {

	/** EgovPropertyService */
	@Resource(name = "propertiesService") protected EgovPropertyService propertiesService;
	
	@Autowired private UseStatisticsMapper useStatisticsMapper;
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getDayPeriod(UseStatisticsVO useStatisticsVo) {
		// TODO Auto-generated method stub
		return useStatisticsMapper.getDayPeriod(useStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getUseMemberCnt(UseStatisticsVO useStatisticsVo) {
		// TODO Auto-generated method stub
		return useStatisticsMapper.getUseMemberCnt(useStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getMonthPeriod(UseStatisticsVO useStatisticsVo) {
		// TODO Auto-generated method stub
		return useStatisticsMapper.getMonthPeriod(useStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<UseStatisticsVO> getUseMemberList(UseStatisticsVO useStatisticsVo) {
		// TODO Auto-generated method stub
		return useStatisticsMapper.getUseMemberList(useStatisticsVo);
	}
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<UseStatisticsVO> getUseMemberRentTypeSumData(UseStatisticsVO useStatisticsVo) {
		// TODO Auto-generated method stub
		return useStatisticsMapper.getUseMemberRentTypeSumData(useStatisticsVo);
	}
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<UseStatisticsVO> getUseMemberGenderSumData(UseStatisticsVO useStatisticsVo) {
		// TODO Auto-generated method stub
		return useStatisticsMapper.getUseMemberGenderSumData(useStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getUseHourlyCnt(UseStatisticsVO useStatisticsVo) {
		// TODO Auto-generated method stub
		return useStatisticsMapper.getUseHourlyCnt(useStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<UseStatisticsVO> getUseHourlyList(UseStatisticsVO useStatisticsVo) {
		// TODO Auto-generated method stub
		return useStatisticsMapper.getUseHourlyList(useStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getUseAgeGroupCnt(UseStatisticsVO useStatisticsVo) {
		// TODO Auto-generated method stub
		return useStatisticsMapper.getUseAgeGroupCnt(useStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<UseStatisticsVO> getUseAgeGroupList(UseStatisticsVO useStatisticsVo) {
		// TODO Auto-generated method stub
		return useStatisticsMapper.getUseAgeGroupList(useStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getUseMemberMaxPeriod() {
		// TODO Auto-generated method stub
		return useStatisticsMapper.getUseMemberMaxPeriod();
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getUseRanDayCnt(UseStatisticsVO useStatisticsVo){
		// TODO Auto-generated method stub
		return useStatisticsMapper.getUseRanDayCnt(useStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<UseStatisticsVO> getUseRanDayList(UseStatisticsVO useStatisticsVo){
		// TODO Auto-generated method stub
		return useStatisticsMapper.getUseRanDayList(useStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getUseRanWeekCnt(UseStatisticsVO useStatisticsVo){
		// TODO Auto-generated method stub
		return useStatisticsMapper.getUseRanWeekCnt(useStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<UseStatisticsVO> getUseRanWeekList(UseStatisticsVO useStatisticsVo){
		// TODO Auto-generated method stub
		return useStatisticsMapper.getUseRanWeekList(useStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getUseRanMonthCnt(UseStatisticsVO useStatisticsVo){
		// TODO Auto-generated method stub
		return useStatisticsMapper.getUseRanMonthCnt(useStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<UseStatisticsVO> getUseRanMonthList(UseStatisticsVO useStatisticsVo){
		// TODO Auto-generated method stub
		return useStatisticsMapper.getUseRanMonthList(useStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getUseForeignDayCnt(UseStatisticsVO useStatisticsVo){
		// TODO Auto-generated method stub
		return useStatisticsMapper.getUseForeignDayCnt(useStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<UseStatisticsVO> getUseForeignDayList(UseStatisticsVO useStatisticsVo){
		// TODO Auto-generated method stub
		return useStatisticsMapper.getUseForeignDayList(useStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getUseForeignMonthCnt(UseStatisticsVO useStatisticsVo){
		// TODO Auto-generated method stub
		return useStatisticsMapper.getUseForeignMonthCnt(useStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<UseStatisticsVO> getUseForeignMonthList(UseStatisticsVO useStatisticsVo){
		// TODO Auto-generated method stub
		return useStatisticsMapper.getUseForeignMonthList(useStatisticsVo);
	}
	
	
	
	
	
	
	/**
	 * 통계 게시판 
	 */
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int listUseStatisticsBoardCount(UseStatisticsBoardVO useStatisticsBoardVO) throws Exception {
		return useStatisticsMapper.listUseStatisticsBoardCount(useStatisticsBoardVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<UseStatisticsBoardVO> listUseStatisticsBoard(UseStatisticsBoardVO useStatisticsBoardVO) throws Exception {
		return useStatisticsMapper.listUseStatisticsBoard(useStatisticsBoardVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public Map<String, UseStatisticsBoardVO> viewUseStatisticsBoard(UseStatisticsBoardVO useStatisticsBoardVO) throws Exception {
		Map<String, UseStatisticsBoardVO> returnMap = null;
		UseStatisticsBoardVO returnVO = null;
		try{
			returnMap = new HashMap<String, UseStatisticsBoardVO>();
			returnVO = useStatisticsMapper.viewUseStatisticsBoard(useStatisticsBoardVO);
			returnMap.put("returnVO", returnVO);
		} catch (Exception e){
			throw e;
		}
		return returnMap;
	}	
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<DaumEditorVO> listDaumEditorVO(UseStatisticsBoardVO useStatisticsBoardVO) throws Exception {
		return useStatisticsMapper.getDaumEditorImage(useStatisticsBoardVO);
	}


	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public UseStatisticsBoardVO insertUseStatisticsBoard(UseStatisticsBoardVO useStatisticsBoardVO) throws Exception {
			@SuppressWarnings("unused") int resultValue = useStatisticsMapper.insertUseStatisticsBoard(useStatisticsBoardVO);
			this.updateDaumEditorImage(useStatisticsBoardVO,false);
		return useStatisticsBoardVO;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public UseStatisticsBoardVO updateUseStatisticsBoard(UseStatisticsBoardVO useStatisticsBoardVO) throws Exception {
		@SuppressWarnings("unused") int resultModify = useStatisticsMapper.updateUseStatisticsBoard(useStatisticsBoardVO);
		this.updateDaumEditorImage(useStatisticsBoardVO,true);
		return useStatisticsBoardVO;
	}
	
	public boolean updateDaumEditorImage(UseStatisticsBoardVO useStatisticsBoardVO, boolean mode) throws Exception {
		// * 이미지 파일을 업로드 했다면 useStatisticsBoardVO.imageList에 파일명이 저장되어 있다.
		if(mode){ useStatisticsMapper.deleteDaumEditorImage(useStatisticsBoardVO); }
		if(!StringUtil.isEmpty(useStatisticsBoardVO.getAttach_file())){ 
			useStatisticsMapper.updateDaumEditorImage(useStatisticsBoardVO);
		}
		return true;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int deleteUseStatisticsBoard(UseStatisticsBoardVO useStatisticsBoardVO) throws Exception {
		useStatisticsBoardVO.setUseYn("N");
		return useStatisticsMapper.deleteUseStatisticsBoard(useStatisticsBoardVO);
	}	
	

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public String staticFileDownloadList(UseStatisticsBoardVO useStatisticsBoardVO) throws Exception {

		//업로드된 파일을 조회해서 zip파일로 압축한다.
		java.util.List<UseStatisticsBoardVO> staticFileList = useStatisticsMapper.staticFileDownloadList(useStatisticsBoardVO);
		
		//로컬 테스트용!!! 첨부되어 있는 파일 경로
		//start
		//String zipFileName = "/nas_link/barocle/attachFiles/file_admin/basePath/daum/notice/file.zip";
		//end
		
		//서버용
		//String zipFileName = "/upload/daum/notice/file.zip";
		
		int noticeCnt = staticFileList.size();
		String[] files = new String[noticeCnt];
		
		//로컬 테스트용!!! 첨부되어 있는 파일 경로
		//start
		String originalFilePath = propertiesService.getString("fileUploadDir") + propertiesService.getString("ctnDaumDir") +"/"+ useStatisticsBoardVO.getaFolder()+"/";
		//end

/*		for(int i=0; i<noticeCnt; i++){
			//로컬 테스트용 !!!
			files[i] = originalFilePath + staticFileList.get(i).getAttachNm();
			//서버용
			//files[i] = staticFileList.get(i).getImgUrl();
		}*/
		
		//로컬 테스트용 !!!
		String fileNm = originalFilePath + staticFileList.get(0).getAttachNm();
		//서버용
		//String fileNm =  = staticFileList.get(0).getImgUrl();
		
		//System.out.println("fileNm :::: " + fileNm);
		
		//System.out.println("files::::: " + files.toString());
		         
		/*byte[] buf = new byte[4096];
		 
		try {
		    ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipFileName));
		 
		    for (int i=0; i<files.length; i++) {
		        FileInputStream in = new FileInputStream(files[i]);
		        Path p = Paths.get(files[i]);
		        String fileName = p.getFileName().toString();
		                 
		        ZipEntry ze = new ZipEntry(fileName);
		        out.putNextEntry(ze);
		           
		        int len;
		        while ((len = in.read(buf)) > 0) {
		            out.write(buf, 0, len);
		        }
		           
		        out.closeEntry();
		        in.close();
		 
		    }
		           
		    out.close();
		    
		    
		} catch (IOException e) {
			e.printStackTrace();
		}*/
		
		return fileNm;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public String staticFileDownloadNm(UseStatisticsBoardVO useStatisticsBoardVO) throws Exception {

		java.util.List<UseStatisticsBoardVO> staticFileList = useStatisticsMapper.staticFileDownloadList(useStatisticsBoardVO);
		String fileNm = staticFileList.get(0).getImgName();
		
		return fileNm;
	}
	
	
		
	
}