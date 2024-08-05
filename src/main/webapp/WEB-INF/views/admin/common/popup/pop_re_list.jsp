<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<%@ include file="../popup/pop_resource.jsp" %>
</head>
<body>
	<h1 class="popTt"></h1>
	<div class="cntbox">
		<div class="allwrap pop">
			<form id="frm">
				<%-- <div class="shBox_pop">
					<div class="shBoxSection">
						<label for="comUpCD" class="laType">카테고리별 유형</label>
						<select class="select-category01" id="comUpCD" name="comUpCD" disabled="disabled">
						</select>
					</div>
				</div>
				<table class="tb_type02 mt20">
					<caption>카테고리명</caption>
						<colgroup>
							<col style="width:30%"/>
							<col style="width:70%"/>
						</colgroup>
					<tbody>
						<tr>
							<th class="top">카테고리 명</th>
							<td class="top"><span class="input-text01p"><input id="mLangComCDName" name="mLangComCDName" type="text" /></span></td>
						</tr>
					</tbody>
				</table>
				<div class="btnArea tc">
					<input type="hidden" id="mode" name="mode" value="insert" />
					<input type="hidden" id="comCD" name="comCD" value="" />
					<span><button class="btnType01" onclick="commonFaq.newCategory(); return false;">신규</button> <button class="btnType01 bc_green" onclick="commonFaq.submitCategory(); return false;">저장</button></span>
				</div> --%>
				<table class="tb_type01 mt20 mb20">
					<caption>카테고리 리스트</caption>
					<colgroup>
						<col style="width:20%"/>
						<col style="width:20%"/>
						<col style="width:20%"/>
					</colgroup>
					<thead>
						<tr>
							<th>미처리</th>
							<th>해당센터</th>
							<th>해당팀</th>
							
						</tr>
					</thead>
					<tbody id="innerResult23423">
					<tr onclick="goEmpImpluseList(); return false;">
					<td class="tc">${resultVo.empCnt } 건</td>
					<td class="tc">${resultVo.centerCnt } 건</td>
					<td class="tc">${resultVo.teamCnt } 건</td>
					</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
	<a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
	
    <script type="text/javascript" src="/js/common_barocle.js"></script>
	<script type="text/javascript">
     function goEmpImpluseList(){
    	 window.opener.goEmpImpluseList();
    	 //window.opener.location.goEmpImpluseList();
    	 //parents.window.opener.location.href ="/getExeImpulseList.do";
    	// setTimeout(closeFnc(),5000);
    	//setTimeout(window.close(),2000);
    	//self.close();
    	// window.close();
     }
     function closeFnc(){
    	 window.close();
     }
    </script>
</body>
</html>
