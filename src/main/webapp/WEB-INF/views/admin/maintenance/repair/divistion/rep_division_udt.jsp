<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
</head>
<body>
	<div class="allwrap">
        <!--모바일 메뉴 S-->
			<tiles:insertAttribute name="header" />
		<!--모바일 메뉴 E-->
		<!--Head S-->
			<tiles:insertAttribute name="head" />
		<!--Head E-->
		<div id="body">
			<div class="cont">
				<!--left menu S-->
					<tiles:insertAttribute name="left" />
				<!--left menu E-->
				<!--content S-->
				<div class="content">
					<div class="subject">
                        <!--subject path S-->
                        <tiles:insertAttribute name="subject" />
                        <!--subject path E-->
					</div>
					<div class="page">
						<form id="frm">
                            <input type="hidden" name="btn_chk"	id="btn_chk" value="${btnChk}" >
							<input type="hidden" name="currentPageNo"	id="currentPageNo" value="${currentPageNo}" >
							<input type="hidden" name="comCd"	id="comCd" value="${comCd}" >
							<input type="hidden" name="comUpCd"	id="comUpCd" value="${comUpCd}" >
							<input type="hidden" name="useYn"	id="useYn" value="" >
							<input type="hidden" name="cdDesc1"	id="cdDesc1" value="${ udtCdDesc1}" >
							<input type="hidden" name="codeNm1"	id="codeNm1" value="${ udtCodeNm1}" >
							<input type="hidden" name="returnCnt"	id="returnCnt" value="${ returnCnt}" >
							
							
							<fieldset>
								<legend>자전거 등록 / 상세 / 수정</legend>
								<table class="tb_type02 mt20">
									<colgroup>
										<col style="width:25%"/>
										<col style="width:75%"/>
									</colgroup>
									<tbody>
										<tr>
											<th class="top"> 순서</th>
											<td class="top">
												<span class="input-text08" ><input type="text" name="dspOrd" style="width: 367px" value="${udtDspOrd }"/></span>
											</td>
										</tr>
										<tr>
											<th> 공통코드명 <br>(<em>*</em>한글/영문/일어/중국어)</th>
											<td>
												<span class="input-text08"><input type="text" name="chgCodeNm" placeholder="한글"  value="${udtCodeNm1 }"/></span>
												<span class="input-text08"><input type="text" name="codeNm2" placeholder="영문"  value="${udtCodeNm2}"/></span>
												<span class="input-text08"><input type="text" name="codeNm3" placeholder="일어"  value="${udtCodeNm3}"/></span>
												<span class="input-text08"><input type="text" name="codeNm4" placeholder="중국어"  value="${udtCodeNm4 }"/></span>
											</td>
										</tr>
										<tr>
											<th> 코드설명</th>
											<td>
												<span class="input-text08" ><input type="text" name="chgDesc" placeholder="코드명" style="width: 367px" value="${ udtCdDesc1}"/></span>
											</td>
										</tr>
										<tr>
											<th> 추가값1,2,3</th>
											<td>
												<span class="input-text08"><input type="text" name="addVal1" placeholder="추가값1"  value="${udtAddVal1 }"/></span>
												<span class="input-text08"><input type="text" name="addVal2" placeholder="추가값2"  value="${udtAddVal2 }"/></span>
												<span class="input-text08"><input type="text" name="addVal3" placeholder="추가값3"  value="${udtAddVal3 }"/></span>
											</td>
										</tr>
										<tr>
											<th> 표시여부</th>
											<td>
												<c:if test="${udtUseYn eq 'Y' }">
													<span class="input-rd01"><input type="radio" checked="checked" name="repairCmptYn" id="a3" value="Y"><label for="a3">사용</label></span>
													<span class="input-rd01"><input type="radio" name="repairCmptYn" id="ab3" value="N"><label for="ab3">미사용</label></span>
												</c:if>
												<c:if test="${udtUseYn eq 'N' }">
													<span class="input-rd01"><input type="radio" name="repairCmptYn" id="a3" value="Y"><label for="a3">사용</label></span>
													<span class="input-rd01"><input type="radio" checked="checked" name="repairCmptYn" id="ab3" value="N"><label for="ab3">미사용</label></span>
												</c:if>
											</td>
										</tr>
									</tbody>
								</table>
								
								<div class="btnArea">
									<span class="left"><button class="btnType01 bc_gray" id="moveList">목록</button></span>
									<span class="right">
										<button type="button" class="btnType01 bc_green" id="udtDivision">저장</button>
									</span>	
								</div>
							</fieldset>
						</form>
					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
	
	<script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
	$(function() {
		$("#btn_chk").val($("#btn_chk").val());
		
		$("#moveList").click(function(){
			$("#frm").attr({method : 'post', action : '/repairDivision.do'}).submit();
		});

		$("#udtDivision").click(function(){
			$("#useYn").val($('[name="repairCmptYn"]:checked').val());
			$("#frm").attr({method : 'post', action : '/repairUdtDivision.do'}).submit();
		});

	});
	
	$(document).ready(function(){
		if($("#returnCnt").val() ==  '1'){
			alert("이미 존재하는 코드명입니다.");
			return false;
		}
	});
	</script>
</body>
</html>