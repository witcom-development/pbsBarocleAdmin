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
							<input type="hidden" name="useYn"	id="useYn" value="" >
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
											<th class="top"> <em>*</em>순서</th>
											<td class="top">
												<span class="input-text08" ><input type="text" name="dspOrd" style="width: 367px" /></span>
											</td>
										</tr>
										<!-- <tr>
											<th> 공통코드명 <br>(<em>*</em>한글/영문/일어/중국어)</th>
											<td>
												<span class="input-text08"><input type="text" name="chgCodeNm" placeholder="한글"  /></span>
												<span class="input-text08"><input type="text" name="codeNm2" placeholder="영문"  /></span>
												<span class="input-text08"><input type="text" name="codeNm3" placeholder="일어"  /></span>
												<span class="input-text08"><input type="text" name="codeNm4" placeholder="중국어"  /></span>
											</td>
										</tr> -->
										<tr>
											<th><em>*</em>공통코드명 (한글)</th>
											<td>
												<span class="input-text08"><input type="text" name="chgCodeNm" placeholder="한글"  style="width: 367px"  /></span>
											</td>
										</tr>
										<!-- <tr>
											<th> 코드설명</th>
											<td>
												<span class="input-text08" ><input type="text" name="chgDesc" placeholder="코드명" style="width: 367px" /></span>
											</td>
										</tr>
										<tr>
											<th> 추가값1,2,3</th>
											<td>
												<span class="input-text08"><input type="text" name="addVal1" placeholder="추가값1" /></span>
												<span class="input-text08"><input type="text" name="addVal2" placeholder="추가값2" /></span>
												<span class="input-text08"><input type="text" name="addVal3" placeholder="추가값3" /></span>
											</td>
										</tr> -->
										<tr>
											<th> <em>*</em>표시여부</th>
											<td>
												<span class="input-rd01"><input type="radio" name="repairCmptYn" value="Y">사용</span>
												<span class="input-rd01"><input type="radio" name="repairCmptYn" value="N">미사용</span>
											
											</td>
										</tr>
									</tbody>
								</table>
								
								<div class="btnArea">
									<span class="left"><button class="btnType01 bc_gray" id="moveList">목록</button></span>
									<span class="right">
										<button type="button" class="btnType01 bc_green" id="addDivision">저장</button>
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
		
		$("#addDivision").click(function(){
			$("#btn_chk").val($("#btn_chk").val());
			
			if($("[name='dspOrd']").val() == '') {
	        	alert("순서를 입력해 주십시오.");
	        	return false;
	        }else if($("[name='chgCodeNm']").val() == ''){
				alert("코드명(한글)을 입력해 주십시오.");
				return false;
			}/* else if($("[name='chgDesc']").val() == ''){
				alert("코드설명을 입력해 주십시오.");
				return false;
			} */else if($('[name="repairCmptYn"]:checked').val() == null){
				alert("표시여부를 지정해 주십시오.");
				return false;
			}
			$("#useYn").val($('[name="repairCmptYn"]:checked').val());
			$("#frm").attr({method : 'post', action : '/repairAddDivision.do'}).submit();
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