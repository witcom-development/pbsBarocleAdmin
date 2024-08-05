<%@page import="com.dkitec.barocle.base.IConstants"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- 
	개발일시 : 2021-09-03
	개발자   : 양재영
	내용     : 공동근무 실적 조회 화면
	TODO : 
 -->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
<style type="text/css" media="print">
    @page 
    {
        size: auto;  
        margin-top: 10mm;  
        margin-bottom: 0mm;  
    }
</style>
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
					<div class="page" style="margin-top:20px;">       
        
        
				<form id="coWorkForm">
					<input type="hidden" name="regId" value="${UserSessionVO.usrId}">
					<input type="hidden" name="coworkInfoSeq" value="">
					<input type="hidden" name="coworkDtlSeq" value="">
					<input type="hidden" name="coworkName" value="">
					<input type="hidden" name="workCenterId" value="${userSessionVO.centerId}">        
					<input type="hidden" name="centerId" 	 value="${userSessionVO.centerId}">        
        			<input type="hidden" name="adminId" value="${UserSessionVO.usrId}"/>
        			
            			<table class="tb_type02">
							<colgroup>
								<col style="width:20%">
								<col style="width:30%">
								<col style="width:20%">
								<col style="width:30%">
							</colgroup>
							<tbody>
								<tr>
									<th class="top" style="text-align:center">
										<span><label for="workFrHour">시작시간</label></span>
									</th>
									<td class="top">
										<input list="timelist" name="workFrHour" id="workFrHour" style="display : inline-block; height: 20px; border: 1px solid #d4d4d4; padding:2px" >
										<datalist id="timelist">
											<option value="7"></option>
											<option value="8"></option>
											<option value="9"></option>
											<option value="10"></option>
											<option value="11"></option>
											<option value="12"></option>
											<option value="13"></option>
											<option value="14"></option>
											<option value="15"></option>
											<option value="16"></option>
											<option value="17"></option>
											<option value="18"></option>
											<option value="19"></option>
											<option value="20"></option>
											<option value="21"></option>
											<option value="22"></option>
											<option value="23"></option>
											<option value="24"></option>
										</datalist>
									</td>
									
									<th class="top" style="text-align:center">
										<span><label for="workToHour">종료시간</label></span>
										
									</th>
									<td class="top">
										<input list="timelist" name="workToHour" id="workToHour" style="display : inline-block; height: 20px; border: 1px solid #d4d4d4; padding:2px" >
									</td>
								</tr>
								<tr>
									<th style="text-align:center">작업</th>
									<td>
										<div class="row">
											<div class="col-md-6 d-flex align-items-start">
												<select id="workType" name="workType" style="display : inline-block;">
													<option value="">선택</option>
													<option value="Cd1">상차</option>
													<option value="Cd2">하차</option>
													<option value="Cd9">기타</option>
												</select>
												
											</div>
										</div>
									</td>
									<th style="text-align:center">
										<span>자전거</span>
									</th>
									<td>
										<input name="bikeCnt" placeholder="수량입력" type="text" onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" style="display : inline-block; width : 85%;"/>대
									</td>
								</tr>	
								<tr>
									<th style="text-align:center">작업내용</th>
									<td colspan="3"><input name="workDtl" type="text" style="display : inline-block; width : 90%;"/></td>
								</tr>
<!-- 								<tr>
									<th>참여인원</th>
									<td colspan="3"><input name="workCnt" type="text" readonly="readonly"></input></td>
								</tr> -->
								<tr>
									<th style="text-align:center">대상자</th>
									<td colspan="3">
										<table id="subMember">
											
												<!--  toto for loop -->
												
												 <c:forEach items="${dsCoWorkList}" var="item" varStatus="stat">
											 	  <tr>
													<td>${item.coworkName}</td>
													<td><button onclick="exeMoveDetailFnc(${item.workDtlSeq})" id="${item.workDtlSeq}" type="button" class="delete" style="color: #fff; background-color: #28a745; border: solid; border-color: #28a745; padding: 1px;">삭제</button></td>
											    </tr>  
											     
												</c:forEach>  
												
												<tr>
												<td>
													<input readonly list="workList" name="coWorkId" id="coWorkId" style="display : inline-block; height: 20px; border: 1px solid #d4d4d4; padding:2px" >
													<datalist id="workList">
													</datalist>
												</td>
												<td>
													<button id="btnWrkerAdd" type="button" style="color: #fff; background-color: #28a745; border: solid; border-color: #28a745; padding: 1px;">인원 추가시</button>
													<button id="btnWrkerMemInsert" type="button" style="color: #fff; background-color: #28a745; border: solid; border-color: #28a745; padding: 1px;">대상자 등록</button>
													
												</td>
											
											</tr>
										</table>
									</td>
								</tr>
								 
									</tbody>
									
								</table>
									
				</form>
							</div>
							
							<div class="text-right my-2">
								<button id="btnCoworkSave" class="s-btn s-btn-success">저장</button>
								<button id="btnCoworkDelete" class="s-btn s-btn-success">삭제</button>
							</div>
											
						</div>
					</div>
					
				</div>	
				
						
        </div>
        <!--footer S-->
        <tiles:insertAttribute name="footer" />
        <!--footer E-->
    <script type="text/javascript" src="/js/common_barocle.js"></script>
 
<script type="text/javascript">

	var msmvBike = {};
	
	initMsmvBike();
	
	function search(){
		
		// $("#coWorkForm").attr({method : 'post', action : "<c:url value='/distributionDiary/modifyCoworkList.do'/>"}).submit();
		location.reload();
		
		
		// location.href = "/distributionDiary/modifyCoworkList.do";
	}
	
	function initMsmvBike(){
		
		var size = ${size}
		
		if ( size > 0 ) {
			
			$("input[name='coworkInfoSeq']").val( "${dsVO.coworkInfoSeq}");
			$("input[name='workFrHour']").val( "${dsVO.workFrHour}");
			$("input[name='workToHour']").val( "${dsVO.workToHour}"); 
			$("input[name='bikeCnt']").val( "${dsVO.bikeCnt}"); 
			$("#workType").val( "${dsVO.workType}").prop("selected", true); 
			$("input[name='workDtl']").val( "${dsVO.workDtl}"); 
			$("input[name='workCenterId']").val( "${dsVO.workCenterId}");
			
			$(".delete > tbody > tr").on("click", "button",{viewFlg : "U"}, exeMoveDetailFnc);
		}
	} 
	
	function exeMoveDetailFnc(key){
		
		
		if ( !confirm("정말 삭제하시겠습니까?")) return;
	    
		$("input[name='coworkDtlSeq']").val(key);
		
		commonAjax.postAjax("/distributionDiary/deleteDistCoWorkMemberAjax.do", 'json', $("#coWorkForm").serialize()
				, function(data){
				if( !data.result ) {
					alert("정상적으로 삭제가 되지 않았습니다.");
					return;
				}
				alert("정상적으로 삭제되었습니다.");
				search();
	    	}
	    )  
	}
	
	
	$("#btnWrkerAdd").on("click", function(e) {
	    e.preventDefault();
	    
	    if( isEmpty( $("input[name='coworkInfoSeq']").val() )) {
	    	alert("공동작업 등록 후, 추가를 부탁드립니다.");
	    	return false;
	    }
	    	    
	    if( isEmpty( $("input[name='workCenterId']").val() )) {
	    	$("input[name='workCenterId']").val($("input[name='centerId']").val());
	    }
	    
	    commonAjax.postAjax("/distributionDiary/getDistMemberInfo.do", 'json', $("#coWorkForm").serialize()
				, function(data){
				if( !data.result ) {
					alert("정상적으로 조회가 되지 않았습니다.");
					return;
				}
				
				console.table(data.list )
				
				$.each(data.list, function (idx, el) {
					
					$("#workList").append( "<option value='"+el.regId+"'>"+ el.coworkName + "</option>" );
			    }); 
				
				// 
				$('#coWorkId').prop('readonly', false );
				
 
	    	}
	    )  
	});	    
	
	
	$("#btnWrkerMemInsert").on("click", function(e) {
	    
		e.preventDefault();
	    
	    if( isEmpty( $("input[name='coworkInfoSeq']").val() )) {
	    	alert("공동작업 등록 후, 추가를 부탁드립니다.");
	    	return false;
	    }
	    
	    if( isEmpty($("input[name='coWorkId']").val() )) {
	    	alert("대상자 선택이 되지 않았습니다. 대상자 선택 후 저장하시기 바랍니다.");
	    	return false;
	    }
	    
	    commonAjax.postAjax("/distributionDiary/insertCoWorkDtlAjax.do", 'json', $("#coWorkForm").serialize()
	    		, function(data){
	            	
	    			if( !data.result ) {
	    				alert("정상적으로 저장이 되지 않았습니다.");
	    				return;
	    			}
	    			 
	    			alert("정상 저장되었습니다.");
	    			search();
	    });	
	});
	

	$("#btnCoworkSave").on("click", function(e) {
	    e.preventDefault();
	    
	    if( isEmpty( $("input[name='workFrHour']").val() )) {
	    	alert("시작시간이 미입력되었습니다.");
	    	return false;
	    }

	    if( isEmpty( $("input[name='workToHour']").val() )) {
	    	alert("시작시간이 미입력되었습니다.");
	    	return false;
	    }

	    if( isEmpty( $("#workType option:selected").val() )) {
	    	alert("작업구분이 미입력되었습니다.");
	    	return false;
	    }

	    if( isEmpty( $("input[name='workDtl']").val() )) {
	    	alert("작업내용이 미입력되었습니다.");
	    	return false;
	    }	    
	    
	    if( isEmpty( $("input[name='workCenterId']").val() )) {
	    	$("input[name='workCenterId']").val($("input[name='centerId']").val());
	    }	    
	    
	    if( isEmpty( $("input[name='workCenterId']").val() )) {
	    	alert("센터구분이 미입력되었습니다. 전산팀 확인 부탁드립니다.");
	    	return false;
	    }
	    
		commonAjax.postAjax("/distributionDiary/insertCoWorkAjax.do", 'json', $("#coWorkForm").serialize()
				, function(data){
		        	
				if( !data.result ) {
					alert("정상적으로 저장이 되지 않았습니다.");
					return;
				}
				
				// SEQ 추가
				$("input[name='coworkInfoSeq']").val( data.vo.coworkInfoSeq ); 
				alert("정상적으로 저장되었습니다.");
				// search();
	    	}
	    )   
	});
	
	
	
	$("#btnCoworkDelete").on("click", function(e) {
	   e.preventDefault();
		if ( !confirm("정말 삭제하시겠습니까?")) return;
		
		commonAjax.postAjax("/distributionDiary/deleteDistCoWorkAdminAjax.do", 'json', $("#coWorkForm").serialize()
				, function(data){
				if( !data.result ) {
					alert("정상적으로 삭제가 되지 않았습니다.");
					return;
				}
				
				alert("정상적으로 삭제되었습니다.");
				$("#coWorkForm").attr({method : 'post', action : "<c:url value='/distributionDiary/getCoworkList.do'/>"}).submit();
	    	}
	    )  
	   
	});
	
	
     
	/**
	 * 문자열이 빈 문자열인지 체크하여 결과값을 리턴한다.
	 * @param str       : 체크할 문자열
	 */
	function isEmpty(str){
	     
	    if(typeof str == "undefined" || str == null || str == "")
	        return true;
	    else
	        return false ;
	}
	 
	
    </script>
</body>
</html>