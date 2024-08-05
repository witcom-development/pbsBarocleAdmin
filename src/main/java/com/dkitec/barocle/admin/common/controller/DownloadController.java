/*
 * @Package Name : com.dkitec.barocle.admin.common.controller
 * @파일명          : DownloadController.java
 * @작성일          : 2015. 6. 5.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 6. 5.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.common.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @파일명          : DownloadController.java
 * @작성일          : 2015. 6. 5.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 6. 5.   |   ymshin   |  최초작성
 */
@Controller
@RequestMapping("/common/down")
public class DownloadController extends BaseController implements ApplicationContextAware{
	protected static Logger log = LoggerFactory.getLogger(DownloadController.class);
	private WebApplicationContext context = null;
	 
	@Resource(name = "propertiesService") private EgovPropertyService propertiesService;
	
	@RequestMapping(value="/{type}/sampleExcelFileDown.do")
	public ModelAndView sampleExcelFileDown(@PathVariable("type") String excelType, HttpServletRequest request, HttpServletResponse response){
		
		String bizName = "고장신고 공통 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		//this.getFileSaveFilegetFileSaveFile();
		File downloadFile = new File(propertiesService.getString("excelDownDir")+"_sample.xlsx");
		
		return new ModelAndView("downloadView", "downloadFile", downloadFile);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.common.controller.ApplicationContextAware.setApplicationContext
	 * @writeDay   : 2015. 6. 5. 오후 3:25:19
	 * @overridden : @see org.springframework.context.ApplicationContextAware#setApplicationContext(org.springframework.context.ApplicationContext)
	 * @Todo       :
	 */ 
	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		 this.context = (WebApplicationContext) applicationContext;
		
	}
	
	private String getFileSaveFile(HashMap<String, String> pMap){
		//파일 업로드 경로 prefix
		String fileString = "";
		
		if(pMap.get("FILE_NAME") !=null && !pMap.get("FILE_NAME").equals("")){
			String prefix = System.getProperty("os.name").toLowerCase().indexOf("win") >= 0 ? "d:/" : "";
			
			String filePath = prefix+ propertiesService.getString("excelDownDir") + 
					File.separator + pMap.get("FILE_NAME");
			
			File getFile = new File(filePath);
			
			if(getFile.exists()){
				FileInputStream inputStream =  null;
			    ByteArrayOutputStream byteOutStream = null;
	
			    try {
			        inputStream = new FileInputStream(getFile);
			        byteOutStream = new ByteArrayOutputStream();
			    
					int len = 0;
					byte[] buf = new byte[1024];
			        while ((len = inputStream.read(buf)) != -1) {
			             byteOutStream.write(buf, 0, len);
			        }
	
			        byte[] fileArray = byteOutStream.toByteArray();
			        fileString = new String(Base64.encodeBase64(fileArray));
			        
			    } catch (IOException e) {
			        e.printStackTrace();
			    } finally {
			    	try {
						inputStream.close();
					} catch (IOException e) {
					}
			        try {
						byteOutStream.close();
					} catch (IOException e) {
					}
			    }
			}	
		}
		return fileString;
	}
}
