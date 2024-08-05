package com.dkitec.barocle.admin.customer.notice.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.notice.service.NoticeMapper;
import com.dkitec.barocle.admin.customer.notice.service.NoticeService;
import com.dkitec.barocle.admin.customer.notice.vo.NoticeVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.barocle.util.push.PushVO;
import com.dkitec.barocle.util.webutil.DateUtil;
import com.dkitec.barocle.util.webutil.StringUtil;

import egovframework.rte.fdl.property.EgovPropertyService;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired NoticeMapper noticeMapper;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService") protected EgovPropertyService propertiesService;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int listNoticeCount(NoticeVO noticeVO) throws Exception {
		return noticeMapper.listNoticeCount(noticeVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<NoticeVO> listNotice(NoticeVO noticeVO) throws Exception {
		return noticeMapper.listNotice(noticeVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public Map<String,NoticeVO> viewNotice(NoticeVO noticeVO) throws Exception {
		Map<String,NoticeVO> returnMap = null;
		NoticeVO returnVO = null;
		try{
			returnMap = new HashMap<String,NoticeVO>();
			returnVO = noticeMapper.viewNotice(noticeVO);
			returnMap.put("returnVO", returnVO);
			//returnMap.put("prevNoticeVO", (NoticeVO)noticeMapper.prevNotice(noticeVO));
			//returnMap.put("nextNoticeVO", (NoticeVO)noticeMapper.nextNotice(noticeVO));
		} catch (Exception e){
			throw e;
		}
		return returnMap;
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<DaumEditorVO> listDaumEditorVO(NoticeVO noticeVO) throws Exception {
		return noticeMapper.getDaumEditorImage(noticeVO);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public NoticeVO insertNotice(NoticeVO noticeVO) throws Exception {
			@SuppressWarnings("unused") int resultValue = noticeMapper.insertNotice(noticeVO);
			this.updateDaumEditorImage(noticeVO,false);
		return noticeVO;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public NoticeVO updateNotice(NoticeVO noticeVO) throws Exception {
		@SuppressWarnings("unused") int resultModify = noticeMapper.updateNotice(noticeVO);
		this.updateDaumEditorImage(noticeVO,true);
		return noticeVO;
	}
	
	public boolean updateDaumEditorImage(NoticeVO noticeVO, boolean mode) throws Exception {
		// * 이미지 파일을 업로드 했다면 noticeVO.imageList에 파일명이 저장되어 있다.
		if(mode){ noticeMapper.deleteDaumEditorImage(noticeVO); }
		if(!StringUtil.isEmpty(noticeVO.getAttach_image_info()) || !StringUtil.isEmpty(noticeVO.getAttach_file())){ 
			noticeMapper.updateDaumEditorImage(noticeVO);
		}
		return true;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int deleteNotice(NoticeVO noticeVO) throws Exception {
		noticeVO.setUseYN("N");
		return noticeMapper.deleteNotice(noticeVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<NoticeVO> listNoticePopupCount(NoticeVO noticeVO) throws Exception {
		noticeVO.setPopupYN("Y");
		noticeVO.setSiteClsCD("admin");
		String todayDate = DateUtil.getSystemDate("yyyyMMdd");
		noticeVO.setSearchStartDate(todayDate);
		noticeVO.setSearchEndDate(todayDate);
		return noticeMapper.listNoticePopupCount(noticeVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public NoticeVO listNoticePopup(NoticeVO noticeVO) throws Exception {
		noticeVO.setPopupYN("Y");
		noticeVO.setSiteClsCD("admin");
		String todayDate = DateUtil.getSystemDate("yyyyMMdd");
		noticeVO.setSearchStartDate(todayDate);
		noticeVO.setSearchEndDate(todayDate);
		return noticeMapper.listNoticePopup(noticeVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public String fileDownloadList(NoticeVO noticeVO) throws Exception {

		//업로드된 파일을 조회해서 zip파일로 압축한다.
		java.util.List<NoticeVO> noticeList = noticeMapper.fileDownloadList(noticeVO);
		
		//로컬 테스트용!!! 첨부되어 있는 파일 경로
		//start
		//String zipFileName = "/nas_link/barocle/attachFiles/file_admin/basePath/daum/notice/file.zip";
		//end
		
		//서버용
		//String zipFileName = "/upload/daum/notice/file.zip";
		
		int noticeCnt = noticeList.size();
		String[] files = new String[noticeCnt];
		
		//로컬 테스트용!!! 첨부되어 있는 파일 경로
		//start
		String originalFilePath = propertiesService.getString("fileUploadDir") + propertiesService.getString("ctnDaumDir") +"/"+ noticeVO.getaFolder()+"/";
		//end

/*		for(int i=0; i<noticeCnt; i++){
			//로컬 테스트용 !!!
			files[i] = originalFilePath + noticeList.get(i).getAttachNm();
			//서버용
			//files[i] = noticeList.get(i).getImgUrl();
		}*/
		
		//로컬 테스트용 !!!
		String fileNm = originalFilePath + noticeList.get(0).getAttachNm();
		//서버용
		//String fileNm =  = noticeList.get(0).getImgUrl();
		
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
	public String fileDownloadNm(NoticeVO noticeVO) throws Exception {

		java.util.List<NoticeVO> noticeList = noticeMapper.fileDownloadList(noticeVO);
		String fileNm = noticeList.get(0).getImgName();
		
		return fileNm;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int insertPush(PushVO pushVo) throws Exception {
			@SuppressWarnings("unused") int resultValue = noticeMapper.insertPush(pushVo);
			//this.updateDaumEditorImage(noticeVO,false);
		return resultValue;
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<PushVO> getPushTargetList() throws Exception {
		
		return noticeMapper.getPushTargetList();
	}
}
