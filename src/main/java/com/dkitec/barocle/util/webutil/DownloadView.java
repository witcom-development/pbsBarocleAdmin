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
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;
 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.springframework.web.servlet.view.AbstractView;
 
public class DownloadView extends AbstractView {
    @Override
    protected void renderMergedOutputModel(Map<String, Object> map, HttpServletRequest req, HttpServletResponse res) throws Exception {
 
        String fileName = null;
        String oriFileName = null;
        
        File file = (File) map.get("fileName");
        File file2 = (File) map.get("fileNm");
 
        res.setContentType("application/download;");
        int length = (int) file.length();
        res.setContentLength(length);
        
        oriFileName = URLEncoder.encode(file2.getName(),"UTF-8").replaceAll("\\+", "%20");
 
        // 익스플로러 인지 확인
        String userAgent = req.getHeader("User-Agent");
        boolean ie = userAgent.indexOf("MSIE") > -1;
 
        if (ie) {
            fileName = URLEncoder.encode(file.getName(), "utf-8").replace("+",  "%20");
        } else {
            fileName = new String(file.getName().getBytes("utf-8"), "iso-8859-1").replace("+", "%20");
        }
 
        res.setHeader("Content-Disposition", "attachment;" + " filename=\"" + oriFileName + "\";"); 
        OutputStream out = res.getOutputStream();
        FileInputStream fis = null;
 
        try {
            int temp;
            fis = new FileInputStream(file);
            while ((temp = fis.read()) != -1) {
                out.write(temp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (fis != null) {
                try {
                    fis.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
