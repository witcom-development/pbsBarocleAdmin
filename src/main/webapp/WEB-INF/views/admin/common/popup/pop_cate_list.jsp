<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
				<div class="shBox_pop">
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
				</div>
				<table class="tb_type01 mt20 mb20">
					<caption>카테고리 리스트</caption>
					<colgroup>
						<col style="width:32%"/>
						<col style="width:20%"/>
						<col style="width:20%"/>
					</colgroup>
					<thead>
						<tr>
							<th>카테고리</th>
							<th>수정일</th>
							<th>수정자</th>
						</tr>
					</thead>
					<tbody id="innerResult">
					</tbody>
				</table>
			</form>
		</div>
	</div>
	<a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
	
    <script type="text/javascript" src="/js/common_barocle.js"></script>
	<script type="text/javascript">
		var commonFaq = {};
		commonFaq.init = function(){
			
			commonAjax.postAjax('/admin/customer/faq/getCategorySelectionList.do', 'json', {}, function(data){
				$("#comUpCD").empty();
				$.each(data.dataList,function(key,val){
					$("#comUpCD").append('<option value="' + this.comCD + '">' + this.comCD + '</option>');
				})
				$("#comUpCD").val("FAQ");
			});
			
			commonFaq.setCategoryList();
			commonFaq.newCategory();
		}
		commonFaq.newCategory = function(){
			$("#mLangComCDName").val('');
			$("#mode").val("insert");
		}
		commonFaq.setCategory = function(val1,val2){
			$("#comCD").val(val1);
			$("#mLangComCDName").val(val2);
			$("#mode").val("update");
		}
		commonFaq.setCategoryList = function(){
			var comCD = '$("#comCD option:selected").val()';
			commonAjax.postAjax('/admin/customer/faq/getCategorySelectedList.do', 'json', {comCD:comCD}, function(data){
				$("#innerResult").empty();
				$.each(data.dataList,function(key,val){
					$("#innerResult").append('<tr><td onclick="commonFaq.setCategory(\''+this.comCD+'\',\''+this.mLangComCDName+'\'); return false;"">&nbsp;'+this.mLangComCDName+'</td><td>'+this.newRegDttm+'</td><td>'+this.regID+'</td></tr>');
				})
			});
		}
		commonFaq.submitCategory = function(){
			var mode = $("#mode").val();
			var comCD = $("#comCD").val();
			var comUpCD = $("#comUpCD").val();
			var mLangComCDName = $("#mLangComCDName").val();
			
			if(mLangComCDName == ''){
	    		alert('<spring:message code="fail.input.emptyValue1" arguments="카테고리 명"/>');
				return false;
			}

			commonAjax.postAjax('/admin/customer/faq/persistCategory.do', 'json', {mode:mode , comCD:comCD, comUpCD:comUpCD, mLangComCDName:mLangComCDName}, function(){
				alert(data.resultMessage);
				commonFaq.init();
			});
		}
		$("#comUpCD").change(function(){
			commonFaq.setCategoryList();
		})
		$(document).ready(function(){
			commonFaq.init();
		});
    </script>
    
    <script type="text/javascript">
		$(document).ready(function(){
			/* 에러 메시지  */
			var alertValue = "<c:out value='${resultMessage}'/>";
			if(alertValue!=""){ alert(alertValue); }
		});
	</script>
    
</body>
</html>
