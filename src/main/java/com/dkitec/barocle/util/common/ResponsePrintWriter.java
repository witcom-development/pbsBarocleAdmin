package com.dkitec.barocle.util.common;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

public class ResponsePrintWriter
{

	/**
	 * iDay 
	 * @param String alertMsg
	 * alertMsg : alert 메세지, formUrl : 이동 URL
	 * @return void
	 */
	public static void PrintWriterScript(HttpServletResponse response, String script){
		response.setContentType("text/html; charset=euc-kr");
		PrintWriter out = null;
		try{
			out = response.getWriter();
			out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
			out.println("<html>");
			out.println("<head>");
			out.println("<title></title>");
			out.println("<script language='javascript'>");          
			out.println(script);    
			out.println("</script>"); 
			out.println("</head>");
			out.println("<body>");
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("</body>");
			out.println("</html>");
			out.flush();
			
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		finally{
			if(out != null){
				out.flush();
				out.close();
			}
		}
	}

	/**
	 * iDay 
	 * @param String alertMsg, String formUrl
	 * alertMsg : alert 메세지, formUrl : 이동 URL 
	 * @return void
	 */
	public static void PrintWriterFormScript(HttpServletResponse response, String alertMsg, String formUrl){
		response.setContentType("text/html; charset=euc-kr");
		PrintWriter out = null;
		try{
			out = response.getWriter();
			out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
			out.println("<html>");
			out.println("<head>");
			out.println("<title></title>");
			out.println("<script language='javascript'>");     
			out.println("function nextPage(){");          
			out.println("alert('"+alertMsg+"');");    
			out.println("var frm = document.printform;");          
			out.println("frm.action = '"+formUrl+"';");           
			out.println("frm.submit();");    
			out.println("}");          
			out.println("</script>"); 
			out.println("</head>");
			out.println("<body onload='nextPage();'>");
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("<form name='printform' method='post'>");
			out.println("</form>");
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("</body>");
			out.println("</html>");
			out.flush();
			
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		finally{
			if(out != null){
				out.flush();
				out.close();
			}
		}
	}
	/**
	 * iDay 
	 * @param String alertMsg, String formUrl, List<String[]> inputTextList
	 * alertMsg : alert 메세지, formUrl : 이동 URL , inputTextList String[2] 이동시 가지고 갈 정보 ( String[0] : input name , String[1] : input value )
	 * @return void
	 */
	public static void PrintWriterFormScript(HttpServletResponse response, String alertMsg, String formUrl, List<String[]> inputTextList){
		response.setContentType("text/html; charset=euc-kr");
		PrintWriter out = null;
		String[] inputText = null;
		try{
			out = response.getWriter();
			out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
			out.println("<html>");
			out.println("<head>");
			out.println("<title></title>");
			out.println("<script language='javascript'>");     
			out.println("function nextPage(){");          
			out.println("alert('"+alertMsg+"');");    
			out.println("var frm = document.printform;");          
			out.println("frm.action = '"+formUrl+"';");           
			out.println("frm.submit();");    
			out.println("}");          
			out.println("</script>"); 
			out.println("</head>");
			out.println("<body onload='nextPage();'>");
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("<form name='printform' method='post'>");
			if(null!=inputTextList){
				for(int i = 0; i < inputTextList.size(); i++){
					inputText = inputTextList.get(i);
					out.println("<input type='hidden' name='"+inputText[0]+"' value='"+inputText[1]+"' />");
				}
			}
			out.println("</form>");
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("</body>");
			out.println("</html>");
			out.flush();
			
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		finally{
			if(out != null){
				out.flush();
				out.close();
			}
		}
	}
}