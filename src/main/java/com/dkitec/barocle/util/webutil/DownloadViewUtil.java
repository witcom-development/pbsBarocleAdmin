/*
 * @Package Name : com.dkitec.barocle.util.webutil
 * @파일명          : DownloadViewUtil.java
 * @작성일          : 2015. 6. 5.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 6. 5.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.util.webutil;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

/**
 * @파일명          : DownloadViewUtil.java
 * @작성일          : 2015. 6. 5.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 6. 5.   |   ymshin   |  최초작성
 */
public class DownloadViewUtil extends AbstractView {
	
	
	public DownloadViewUtil() {
		setContentType("application/download;charset=utf-8");
	}

	/**
	 * @location   : com.dkitec.barocle.util.webutil.AbstractView.renderMergedOutputModel
	 * @writeDay   : 2015. 6. 5. 오후 3:06:42
	 * @overridden : @see org.springframework.web.servlet.view.AbstractView#renderMergedOutputModel(java.util.Map, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 * @Todo       :
	 */ 
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model,HttpServletRequest request, HttpServletResponse response) throws Exception {
		
        File file = (File)model.get("downloadFile");
		
		response.setContentType(getContentType());
		response.setContentLength((int)file.length());
		
		String userAgent = request.getHeader("User-Agent");
		boolean ie = userAgent.indexOf("MSIE") > -1;
		String fileName = null;
		
		if(ie) {
			fileName = URLEncoder.encode(file.getName(), "utf-8");
		} else {
			fileName = new String(file.getName().getBytes("utf-8"), "iso-8859-1");
		}
		
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		
		OutputStream out = response.getOutputStream();
		FileInputStream fis = null;
		
		try {
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
		} finally {
			if(fis != null) {
				try {
					fis.close();
				} catch(IOException ioe) {}
			}
		}
		out.flush();

	}
	
	
}
