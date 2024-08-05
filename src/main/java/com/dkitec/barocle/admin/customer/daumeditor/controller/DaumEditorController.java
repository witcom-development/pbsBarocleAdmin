package com.dkitec.barocle.admin.customer.daumeditor.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import net.coobird.thumbnailator.Thumbnails;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.customer.daumeditor.service.DaumEditorService;
import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.base.IConstants;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
@RequestCategory(value="DaumEditorController")
@RequestMapping
public class DaumEditorController implements IConstants {
	
	protected static Logger log = LoggerFactory.getLogger(DaumEditorController.class);
	
	@Resource(name = "daumEditorService") protected DaumEditorService daumEditorService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService") protected EgovPropertyService propertiesService;
	
	@RequestName(value="daumeditorFileUploadPopup")
	@RequestMapping(value="/daumeditorFileUploadPopup.do")
	public String daumeditorFileUploadPopup(@Validated DaumEditorVO daumEditorVO, BindingResult result, HttpServletRequest request, Model model) {
		model.addAttribute("pageURL","/daumeditorFileUploadPersist.do?currentPageName=");
		return "/admin/customer/popup/daumImage";
	}
	
	@RequestName(value="daumeditorFileUploadPopup2")
	@RequestMapping(value="/daumeditorFileUploadPopup2.do")
	public String daumeditorFileUploadPopup2(@Validated DaumEditorVO daumEditorVO, BindingResult result, HttpServletRequest request, Model model) {
		model.addAttribute("pageURL","/daumeditorFileUploadPer.do?currentPageName=");
		return "/admin/customer/popup/daumFile";
	}
	
	@RequestName(value="daumeditorFileUploadPersist")
	@RequestMapping(value="/daumeditorFileUploadPersist.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String daumeditorFileUploadPersist(@Validated DaumEditorVO daumEditorVO, BindingResult result, HttpServletRequest request, Model model) {
		
		String currentPageName = String.valueOf(request.getParameter("currentPageName"));
		
		// currentPageName값은 현재 작성중인 화면 메뉴와 이미지가 저장될 경로를 결정한다. 이에 currentPageName을 값은 daumeditor.properties에 정의된 daumFiledir값으로 유효성을 검사해야 한다.
		if(!"null".equalsIgnoreCase(currentPageName)&&!"".equals(currentPageName)&&propertiesService.getString("allowFileDir").indexOf(currentPageName)>=0){
			daumEditorVO.setBbsClsCD(currentPageName);
			daumEditorVO.setImgPath(currentPageName + "/");
			currentPageName = "/" + (String)request.getParameter("currentPageName") + "/";
			
		} else throw new CfoodException("daumeditor.upload.error.menu");
		
		log.info("entering : /daumeditorFileUploadPersist.do");
		log.info("currentPageName : " + currentPageName);
		
		boolean bResult = false;
		String tempFileURL = "";
		
		try{
			
			// 이미지 받아오기
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;
			multiRequest.setCharacterEncoding(propertiesService.getString("fileEncoding"));
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			
			// 저장 경로 설정 및 생성
			java.io.File saveFolder = new java.io.File(propertiesService.getString("fileUploadDir")+propertiesService.getString("ctnDaumDir")+currentPageName);
			
			if (!saveFolder.exists() || saveFolder.isFile()){ saveFolder.mkdirs(); }
			
			// 저장 파일 설정
			Iterator<Map.Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			tempFileURL = propertiesService.getString("ctnDaumURL") + propertiesService.getString("ctnDaumDir") + currentPageName;
			MultipartFile file;
			
				Map.Entry<String, MultipartFile> entry = itr.next();
				file = entry.getValue();
				if (!"".equals(file.getOriginalFilename())) {
					
					// set new name
					String orgFileName = file.getOriginalFilename();
					int dot = orgFileName.lastIndexOf(".");
					String fileExtension = null;
					if(dot!=-1){ fileExtension = orgFileName.substring(dot); } // includes "."
					
					// size check
					if(file.getSize()>propertiesService.getInt("fileMaxSize")){
						throw new CfoodException("daumeditor.upload.error.size");
					}
					
					// extension check
					if(propertiesService.getString("allowFileExt").length()>-1&&fileExtension.length()>-1){
						if((propertiesService.getString("allowFileExt").indexOf(fileExtension.substring(1)))<0){
							throw new CfoodException("daumeditor.upload.error.extension");
						}
					}
					
					// 파일 설정
					String fileNameExtension = new SimpleDateFormat("yyyyMMddHHmmsss").format(Calendar.getInstance().getTime()) + fileExtension;
					// 파일 명
					String fileName = orgFileName.substring(0, dot) + fileNameExtension;
					// 파일 경로
					String newFileNameExe = String.valueOf(request.getParameter("currentPageName")) + "_img" + "_" + fileNameExtension;
					daumEditorVO.setImgName(fileName);
					daumEditorVO.setImgURL(tempFileURL + newFileNameExe);
					
					String originalFilePath = propertiesService.getString("fileUploadDir") + propertiesService.getString("ctnDaumDir") + currentPageName;
					
					// 파일 저장
					file.transferTo(new java.io.File(originalFilePath + newFileNameExe));
					daumEditorVO.setImgSize((int)file.getSize());
					//daumEditorVO.setImgAlign(propertiesService.getString("daumImageAlign"));
					
					// 썸네일 이미지 만들
					//File originFileName = new File(originalFilePath + newFileNameExe);
					File thumbnailFileName = new File(originalFilePath + propertiesService.getString("thumbnailDir") + "thumbnail_" + newFileNameExe);
					daumEditorVO.setThumbnailImgURL(tempFileURL + propertiesService.getString("thumbnailDir") + "thumbnail_" + newFileNameExe);
					daumEditorVO.setThumbnailImgName("thumbnail_" + newFileNameExe);
					
					// 썸네일 디렉토리 확인
					java.io.File tempSaveFolder = new java.io.File(originalFilePath + propertiesService.getString("thumbnailDir"));
					daumEditorVO.setThumbnailImgPath(daumEditorVO.getImgPath() + propertiesService.getString("thumbnailDir"));
					if (!tempSaveFolder.exists() || tempSaveFolder.isFile()) { tempSaveFolder.mkdirs(); }
					
					// 현재 이미지 크기
					java.awt.image.BufferedImage bufferedImage = ImageIO.read(new java.io.File(originalFilePath + newFileNameExe));
					int currentImageWidth = bufferedImage.getWidth();
					int currentImageHeight = bufferedImage.getHeight();
					
					// 썸네일 이미지 저장 
					int newThumbnailWidth = (int)propertiesService.getInt("thumbnailWidth");
					int newThumbnailHeight = (int)propertiesService.getInt("thumbnailHeight");
					if("/photogallery/".equalsIgnoreCase(currentPageName)){
						newThumbnailWidth = (int)propertiesService.getInt("photoGalleryThumbnailWidth");
						newThumbnailHeight = (int)propertiesService.getInt("photoGalleryThumbnailHeight");
					}
					// 썸네일 이미지 크기 지정
					if(newThumbnailWidth>currentImageWidth){ newThumbnailWidth = currentImageWidth; }
					if(newThumbnailHeight>currentImageHeight){ newThumbnailHeight = currentImageHeight; }
					Thumbnails.of(new File(originalFilePath+newFileNameExe)).size(newThumbnailWidth, newThumbnailHeight).outputFormat(fileExtension.replace(".", "")).toFile(originalFilePath + propertiesService.getString("thumbnailDir") + "thumbnail_" + newFileNameExe);
					daumEditorVO.setThumbnailImgSize((int)thumbnailFileName.length());
					
					// 등록한 이미지 DB에 저장 : TB_COM_DAUM_IMG
					daumEditorService.insertDaumImage(daumEditorVO);
					
				}
				
				bResult = true;
				
		} catch (Exception e) {
			throw new CfoodException("daumeditor.upload.error.uploadDaumEditorImage",e);
		} 
		
		log.info("returning : /daumeditorFileUploadPersist.do");
		if(bResult){ log.info("return value : " + daumEditorVO.toString()); }
		
		return bResult ? "{\"imageurl\":\""+daumEditorVO.getImgURL()+"\",\"filename\":\""+daumEditorVO.getImgName()+"\",\"filesize\":\""+daumEditorVO.getImgSize()+"\",\"imagealign\":\"" + propertiesService.getString("daumImageAlign") + "\"}" : ERROR_PAGE;
	}
	
	/*파일 업로드_cms20161108*/	
	@RequestName(value="daumeditorFileUploadPer")
	@RequestMapping(value="/daumeditorFileUploadPer.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String daumeditorFileUploadPer(@Validated DaumEditorVO daumEditorVO, BindingResult result, HttpServletRequest request, Model model) {
		
		String currentPageName = String.valueOf(request.getParameter("currentPageName"));
		// currentPageName값은 현재 작성중인 화면 메뉴와 이미지가 저장될 경로를 결정한다. 이에 currentPageName을 값은 daumeditor.properties에 정의된 daumFiledir값으로 유효성을 검사해야 한다.
		if(!"null".equalsIgnoreCase(currentPageName)&&!"".equals(currentPageName)&&propertiesService.getString("allowFileDir").indexOf(currentPageName)>=0){
			daumEditorVO.setBbsClsCD(currentPageName);
			daumEditorVO.setFilePath(currentPageName + "/");
			currentPageName = "/" + (String)request.getParameter("currentPageName") + "/";
		} else {
			throw new CfoodException("daumeditor.upload.error.menu");
		}
		log.info("entering : /daumeditorFileUploadPer.do");
		log.info("currentPageName : " + currentPageName);
		
		boolean bResult = false;
		String tempFileURL = "";
		
		try{
			// 파일 받아오기
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;
			multiRequest.setCharacterEncoding(propertiesService.getString("fileEncoding"));
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			
			// 저장 경로 설정 및 생성
			java.io.File saveFolder = new java.io.File(propertiesService.getString("fileUploadDir")+propertiesService.getString("ctnDaumDir")+currentPageName);
			
			if (!saveFolder.exists() || saveFolder.isFile()){ saveFolder.mkdirs(); }
			
			// 저장 파일 설정
			Iterator<Map.Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			tempFileURL = propertiesService.getString("ctnDaumURL") + propertiesService.getString("ctnDaumDir") + currentPageName;
			MultipartFile file;
			
				Map.Entry<String, MultipartFile> entry = itr.next();
				file = entry.getValue();
				if (!"".equals(file.getOriginalFilename())) {
					// set new name
					String orgFileName = file.getOriginalFilename();
					int dot = orgFileName.lastIndexOf(".");
					String fileExtension = null;
					if(dot!=-1){ fileExtension = orgFileName.substring(dot); } // includes "."
					// 파일 설정
					String fileNameExtension = new SimpleDateFormat("yyyyMMddHHmmsss").format(Calendar.getInstance().getTime()) + fileExtension;
					// 파일 명
					String fileName = orgFileName.substring(0, dot) + fileNameExtension;
					// 파일 경로
					String newFileNameExe = String.valueOf(request.getParameter("currentPageName")) + "_file" + "_" + fileNameExtension;
					daumEditorVO.setFileName(fileName);
					daumEditorVO.setFileURL(tempFileURL + newFileNameExe);
					String originalFilePath = propertiesService.getString("fileUploadDir") + propertiesService.getString("ctnDaumDir") + currentPageName;
					System.out.println("oFP : " + originalFilePath);
					// 파일 저장
					file.transferTo(new java.io.File(originalFilePath + newFileNameExe));
					System.out.println("파일저장 주소 : " + originalFilePath + newFileNameExe);
					daumEditorVO.setFileSize((int)file.getSize());
					
					// 등록한 파일 DB에 저장 : TB_COM_DAUM_File
					daumEditorService.insertDaumFile(daumEditorVO);
					
				}
				System.out.println("daumeditorFileUploadPer 7 ");
				bResult = true;
				System.out.println("bResult 7 : " + bResult);
		} catch (Exception e) {
			System.out.println("daumeditorFileUploadPer 8 ");
			System.out.println("bResult 8 : " + bResult);
			e.printStackTrace();
			throw new CfoodException("daumeditor.upload.error.uploadDaumEditorFile",e);
		} 
		
		System.out.println("daumeditorFileUploadPer 9 ");
		log.info("returning : /daumeditorFileUploadPer.do");
		if(bResult){ log.info("return value : " + daumEditorVO.toString()); }
		System.out.println("bResult : " + bResult);
		return bResult ? "{\"fileurl\":\""+daumEditorVO.getFileURL()+"\",\"filename\":\""+daumEditorVO.getFileName()+"\",\"filesize\":\""+daumEditorVO.getFileSize()+"\",\"filealign\":\"" + propertiesService.getString("daumImageAlign") + "\"}" : ERROR_PAGE;
	}
	
}
