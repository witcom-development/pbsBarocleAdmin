package com.dkitec.barocle.admin.board.distribute.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.board.distribute.service.DistributeBoardMapper;
import com.dkitec.barocle.admin.board.distribute.service.DistributeBoardService;
import com.dkitec.barocle.admin.board.distribute.vo.DistributeBoardVO;
import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.barocle.util.push.PushVO;
import com.dkitec.barocle.util.webutil.DateUtil;
import com.dkitec.barocle.util.webutil.StringUtil;

import egovframework.rte.fdl.property.EgovPropertyService;

@Service("distributeBoardService")
public class DistributeBoardServiceImpl implements DistributeBoardService{

	@Autowired DistributeBoardMapper distributeBoardMapper;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService") protected EgovPropertyService propertiesService;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int listDistributeCount(DistributeBoardVO distributeBoardVO) throws Exception {
		return distributeBoardMapper.listDistributeCount(distributeBoardVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<DistributeBoardVO> listDistributeBunBae() throws Exception {
		return distributeBoardMapper.listDistributeBunBae();
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<DistributeBoardVO> listDistribute(DistributeBoardVO distributeBoardVO) throws Exception {
		return distributeBoardMapper.listDistribute(distributeBoardVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public Map<String, DistributeBoardVO> viewDistribute(DistributeBoardVO distributeBoardVO) throws Exception {
		Map<String,DistributeBoardVO> returnMap = null;
		DistributeBoardVO returnVO = null;
		try {
			returnMap = new HashMap<String, DistributeBoardVO>();
			returnVO = distributeBoardMapper.viewDistribute(distributeBoardVO);
			returnMap.put("returnVO", returnVO);
			
			// 조회 카운트 추가
			distributeBoardMapper.updateReadcntViewDistribute(distributeBoardVO);
		} catch (Exception e) {
			throw e;
		}
		return returnMap;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<DaumEditorVO> listDaumEditorVO(DistributeBoardVO distributeBoardVO) throws Exception {
		return distributeBoardMapper.getDaumEditorImage(distributeBoardVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public DistributeBoardVO insertDistribute(DistributeBoardVO distributeBoardVO) throws Exception {
		@SuppressWarnings("unused") int resultValue = distributeBoardMapper.insertDistribute(distributeBoardVO);
		this.updateDaumEditorImage(distributeBoardVO, false);
		return distributeBoardVO;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public DistributeBoardVO updateDistribute(DistributeBoardVO distributeBoardVO) throws Exception {
		@SuppressWarnings("unused") int resultModify = distributeBoardMapper.updateDistribute(distributeBoardVO);
		this.updateDaumEditorImage(distributeBoardVO, true);
		return distributeBoardVO;
	}
	
	public boolean updateDaumEditorImage(DistributeBoardVO distributeBoardVO, boolean mode) throws Exception {
		// * 이미지 파일을 업로드 했다면 noticeVO.imageList에 파일명이 저장되어 있다.
		if(mode) { distributeBoardMapper.deleteDaumEditorImage(distributeBoardVO); }
		if(!StringUtil.isEmpty(distributeBoardVO.getAttach_image_info()) || !StringUtil.isEmpty(distributeBoardVO.getAttach_file())) {
			distributeBoardMapper.updateDaumEditorImage(distributeBoardVO);
		}
		return true;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int deleteDistribute(DistributeBoardVO distributeBoardVO) throws Exception {
		distributeBoardVO.setUseYN("N");
		return distributeBoardMapper.deleteDistribute(distributeBoardVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<DistributeBoardVO> listDistributePopupCount(DistributeBoardVO distributeBoardVO) throws Exception {
		distributeBoardVO.setPopupYN("Y");
		distributeBoardVO.setSiteClsCD("admin");
		String todayDate = DateUtil.getSystemDate("yyyyMMdd");
		distributeBoardVO.setSearchStartDate(todayDate);
		distributeBoardVO.setSearchEndDate(todayDate);
		return distributeBoardMapper.listDistributePopupCount(distributeBoardVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public DistributeBoardVO listDistributePopup(DistributeBoardVO distributeBoardVO) throws Exception {
		distributeBoardVO.setPopupYN("Y");
		distributeBoardVO.setSiteClsCD("admin");
		String todayDate = DateUtil.getSystemDate("yyyyMMdd");
		distributeBoardVO.setSearchStartDate(todayDate);
		distributeBoardVO.setSearchEndDate(todayDate);
		return distributeBoardMapper.listDistributePopup(distributeBoardVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public String fileDownloadList(DistributeBoardVO distributeBoardVO) throws Exception {

		//업로드된 파일을 조회해서 zip파일로 압축한다.
		java.util.List<DistributeBoardVO> distributeBoardList = distributeBoardMapper.fileDownloadList(distributeBoardVO);
		
		//로컬 테스트용!!! 첨부되어 있는 파일 경로 - 경로 수정 필요
		//start
		//String zipFileName = "/nas_link/barocle/attachFiles/file_admin/basePath/daum/notice/file.zip";
		//end
		
		//서버용 - 경로 수정 필요
		//String zipFileName = "/upload/daum/notice/file.zip";
		
		int distributeCnt = distributeBoardList.size();
		String[] files = new String[distributeCnt];
		
		//로컬 테스트용!!! 첨부되어 있는 파일 경로
		//start
		String originalFilePath = propertiesService.getString("fileUploadDir") + propertiesService.getString("ctnDaumDir") +"/"+ distributeBoardVO.getaFolder()+"/";
		//end
		
/*		for(int i=0; i<noticeCnt; i++){
		//로컬 테스트용 !!!
		files[i] = originalFilePath + distributeBoardList.get(i).getAttachNm();
		//서버용
		//files[i] = distributeBoardList.get(i).getImgUrl();
		}*/
	
		//로컬 테스트용 !!!
		String fileNm = originalFilePath + distributeBoardList.get(0).getAttachNm();
		//서버용
		//String fileNm =  = distributeBoardList.get(0).getImgUrl();
		
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
	public String fileDownloadNm(DistributeBoardVO distributeBoardVO) throws Exception {

		java.util.List<DistributeBoardVO> distributeBoardList = distributeBoardMapper.fileDownloadList(distributeBoardVO);
		String fileNm = distributeBoardList.get(0).getImgName();
		
		return fileNm;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int insertPush(PushVO pushVo) throws Exception {
		@SuppressWarnings("unused") int resultValue = distributeBoardMapper.insertPush(pushVo);
		//this.updateDaumEditorImage(distributeBoardVO,false);		
		return resultValue;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<PushVO> getPushTargetList() throws Exception {
		
		return distributeBoardMapper.getPushTargetList();
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<DistributeBoardVO> listBoardPopupCount(DistributeBoardVO distributeBoardVO) {
		distributeBoardVO.setPopupYN("Y");
		String todayDate = DateUtil.getSystemDate("yyyyMMdd");
		distributeBoardVO.setSearchStartDate(todayDate);
		distributeBoardVO.setSearchEndDate(todayDate);
		return distributeBoardMapper.listBoardPopupCount(distributeBoardVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public Object listBoardPopup(DistributeBoardVO distributeBoardVO) {
		distributeBoardVO.setPopupYN("Y");
		String todayDate = DateUtil.getSystemDate("yyyyMMdd");
		distributeBoardVO.setSearchStartDate(todayDate);
		distributeBoardVO.setSearchEndDate(todayDate);
		return distributeBoardMapper.listBoardPopup(distributeBoardVO);
	}
}
