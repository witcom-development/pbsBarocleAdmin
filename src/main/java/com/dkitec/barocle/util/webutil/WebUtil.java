package com.dkitec.barocle.util.webutil;

import java.util.LinkedList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class WebUtil {
	/*
	public static void main(String args[]){
		String text = "a<h3 style=\"background-color:#ff0;\">Test</h3><div><p><img src=\"adfadsf\"/><strong style=\"color:red;\"><a href=\"test.aspx\"><b>aabbcc</b></a><br /></strong></p><span style=\"color:blue\">xxx</span><pre>test</pre></div>";
		System.out.println(replaceHTMLSpecialChars(text, "img"));
	}
	
	public static void main(String arg[]){
    	java.util.List<String> list = null;
		String str = "<html><body>...<img src=\"http://www.tmep.com/test.jpg\" alt=\"adsfasdfasfdaf\"/> asdf <img src='http://www.test.com/img.jpg'/>...</body></html> ";
		list = getImgSrcValue(str);
		for (String imgUrl : list) {
			System.out.println(imgUrl);
		}
    }
	*/
	
	public static String replaceHTMLSpecialChars(String str, String strAllowTag) {
		String pattern = "<(\\/?)(?!\\/####)([^<|>]+)?>";
		String substitute = "&lt;$1$2&gt;";
		String[] allowTags = strAllowTag.split(",");
		StringBuilder buffer = new StringBuilder();
		for (int i = 0; i < allowTags.length; i++) { buffer.append("|" + allowTags[i].trim() + "(?!\\w)"); }
		pattern = pattern.replace("####", buffer.toString());
		return str.replaceAll(pattern, substitute);
	}
	
	public static String removeHTMLSpecialChars(String str, String strAllowTag) {
		String pattern = "<(\\/?)(?!\\/####)([^<|>]+)?>";
		String substitute = "";
		String[] allowTags = strAllowTag.split(",");
		StringBuilder buffer = new StringBuilder();
		for (int i = 0; i < allowTags.length; i++) { buffer.append("|" + allowTags[i].trim() + "(?!\\w)"); }
		pattern = pattern.replace("####", buffer.toString());
		return str.replaceAll(pattern, substitute);
	}
	
	public static String replaceHTMLSpecialChars(String str) {
		return str.replaceAll("</p>", "\n").replaceAll("<br>", "\n");
	}
	
    public static java.util.List<String> getImgSrcValue(String str){
    	Pattern nonValidPattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");
		List<String> result = new LinkedList<String>();
		Matcher matcher = nonValidPattern.matcher(str);
		while (matcher.find()) { result.add(matcher.group(1)); }
		return result;
    }
    
    public static String getQuestnrID(String preFix, int qustnrSeq, int increment){
		StringBuffer sb = new StringBuffer();
		sb.append(preFix).append(String.format("%06d",qustnrSeq)).append(String.format("%06d",increment));
		return sb.toString();
	}

	public static String getSmsAutoSendId(String preFix, int increment) {
		StringBuffer sb = new StringBuffer();
    	sb.append(preFix).append(String.format("%03d",increment));
    	return sb.toString();
	}
	
	public static String getPrefixPKAutoId(String preFix, int increment) {
		StringBuffer sb = new StringBuffer();
    	sb.append(preFix).append(String.format("%03d",increment));
    	return sb.toString();
	}
	
	public static String getTimeMin(String value) {
		return String.format("%02d",Integer.parseInt(value));
	}
	
}