<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<!-- <meta content="text/html; charset=KSC5601" http-equiv="content-type" /> -->
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title" /></title>
<tiles:insertAttribute name="resource" />
<script type="text/javascript" src="/js/common_barocle.js"></script>
<script type="text/javascript">

	function fn_list(){
		//$("#staImgFile").val("");
		$("#frm").attr("action", "/admin/manage/station/stationList.do");
		$("#frm").submit();
	}
	
	$(function() {
		
		//var msg = $("input[name=nameList]").val() + " 대여소가 임시폐쇄 되었습니다.";
		
	    var date = new Date;
		date.setDate(date.getDate()+30);
		var today = DateUtil.dateFmt(date);
		var fromday = DateUtil.dateFmt(new Date()); 
		var sDate = '${info.unuse_str_dttm}' !== '' ? '${info.unuse_str_dttm}' : fromday;
		var eDate = '${info.unuse_end_dttm}' !== '' ? '${info.unuse_end_dttm}' : today;
		
		$("[name='unuse_str_dttm']").val(sDate);
		$("[name='unuse_end_dttm']").val(eDate);
		
		
		$("#station_no").keyup(function(){
			$(this).val($(this).val().replace(/[^0-9]/g,""));
		});
		
		if("${cmd}" == "INFO"){
			
			$("select[name=station_grp_seq]").val("${info.station_grp_seq}")
			
			$("#station_no").val('${info.station_no }');
			
			"<c:forEach items='${stationName }' var='lang'>"
				
				$("#"+"${lang.lang_cls_cd}").val("${lang.station_name}");

			"</c:forEach>"
			
			$("select[name=station_cls_cd]").val("${info.station_cls_cd}");
			
			$("#station_post_no").val("${info.station_post_no }");
						
			$("#station_addr1").val("${info.station_addr1 }");
			$("#station_addr2").val("${info.station_addr2 }");
						
			$("#station_latitude").val("${info.station_latitude }");
			$("#station_longitude").val("${info.station_longitude }");
						
			$("#memo").val("${info.memo }");
			$("#dstnc_lt").val("${info.dstnc_lt }");
			
			$("#rockCnt").text("${info.rockCnt}");
		
			//$("#reason").text("${info.reason}");
			
			if('${info.station_use_yn }' == "Y"){
				$("#station_use_y").prop('checked', true);
			}else if('${info.station_use_yn }' == "T"){
				$("#station_use_t").prop('checked', true);
				$("#unuseDate").css("display","");
			}
		}
		
		$("[name='station_use_yn']").on("change",  function(){
			 var radioVal = $(':radio[name="station_use_yn"]:checked').val();
			 if (radioVal == "T") {
			 	$("#unuseDate").css("display","");
			 	$("#reason").css("display","");
			 } else {
				$("#unuseDate").css("display","none"); 
				$("#reason").css("display","none"); 
			 }	
		 });
		
		$("#selboxDirect").hide();
		$("#reason").change(function() {
			if($("#reason").val() == "") {
				$("#selboxDirect").show();
			}  else {
				$("#selboxDirect").hide();
			}
		});	
	});
	
	function vallidateModify( flag, id ){
		
		if(!$("input[name=station_use_yn]").is(":checked")){
			alert('<spring:message code="fail.input.emptyValue2" arguments="사용여부"/>');
			return false;
		}
		
		if(flag == "UPDATE"){
			fn_update( id );
		}
	}
	
	var doubleClick = true;
	var succMsg = '<spring:message code="success.common.save" />';
	var failMsg = '<spring:message code="fail.request.msg" />';
			
	function fn_update( id ){
		
		$("#cmd").val("UPDATE");
		$("#station_id").val(id);
		
		var radioVal = $(':radio[name="station_use_yn"]:checked').val();
		if('${info.station_use_yn }' == radioVal && 
		   '${info.unuse_str_dttm }' ==  $("input[name=unuse_str_dttm]").val() && 
		   '${info.unuse_end_dttm }' ==  $("input[name=unuse_end_dttm]").val() )
		{
			frm.histYn.value = 'N';
		} else {
			frm.histYn.value = 'Y';
		}
		
		if( radioVal == 'T' ){
			if( $("#selbox").val() == '선택'){	
				alert('<spring:message code="fail.input.emptyValue2" arguments="사유(은)"/>');
				return false;
			} 
			if ( confirm( $("input[name=nameList]").val() + " 대여소가 임시폐쇄됩니다. 저장하시겠습니까?")) {
				$("#frm").attr({method : "post", action : "/admin/manage/station/stationModify.do"}).submit();
			}
		}else if( radioVal == 'Y'){ 
			if ( confirm( $("input[name=nameList]").val() +" 대여소가 사용으로 전환됩니다. 저장하시겠습니까?")) {
				$("#frm").attr({method : "post", action : "/admin/manage/station/stationModify.do"}).submit();
			}
		}else { 
			if (confirm('<spring:message code="common.save.msg"/>')){
				$("#frm").attr({method : "post", action : "/admin/mane/station/stationModify.do"}).submit();
			} 
		}
	}
	
   function goMapAddr(){
		
		var pwidth = 600;
		var pheight = 680;
		var winL = (screen.width-pwidth)/2;
		var winT = (screen.height-pheight)/2;
		var lat = $("#station_latitude").val();
		var lon = $("#station_longitude").val();
		window.open("/common/pop/showLocationMapPop.do?outptt=%uC704%uCE58%uC9C0%uB3C4%uCC3E%uAE30&latitude="+ lat +"&longitude=" + lon , "winpop", "width=600, height=680, top="+winT+", left="+winL , "scrollbars=yes");

	}
   
     $(document).ready(function(){
    	 $("#staImgFile").hide();
     });
     
     
     

</script>
<script type="text/javascript">
	 String.prototype.trim = function(){
	      return this.replace(/\s/g, "");
	  }
</script>
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
				<!--conteent S-->
			<form action="" method="post"	name="frm" id="frm" enctype="multipart/form-data" >
			<!-- enctype="multipart/form-data" -->
				<div class="content">
					<div class="subject">
						<!--subject path S-->
							<tiles:insertAttribute name="subject" />
						<!--subject path E-->
					</div>
					<div class="page">
					<div class="tabWrap type3">
							 <ul class="tabBox">
								<li class="tab on"><button type="button">대여소 정보</button></li>
								<li class="tab"><button type="button">사용 이력</button></li>
							</ul>
							<div class="tabCon on">
							<fieldset>
								<table  class="tb_type02 mt20">
									<caption>대여소 상세</caption>
									<colgroup>
										<col style="width:25%"/>
										<col style="width:75%"/>
									</colgroup>
									<tbody>
										<input type="hidden" id="station_grp_seq" name="station_grp_seq"/>
										<input type="hidden" id="team_seq" name="team_seq"/>
										<input type="hidden" id="station_latitude" name="station_latitude"/>
										<input type="hidden" id="station_longitude" name="station_longitude"/>
										<input type="hidden" id="station_no" name="station_no">
										<input type="hidden" id="histYn" name="histYn" value="${info.station_use_yn }">
										<input type="hidden" id="station_id" name="station_id">
										<input type="hidden" id="cmd" name="cmd" value="${cmd }">
										<input type="hidden" name="station_post_no" id="station_post_no" value="${info.station_post_no }"/>
										<input type="hidden" name="dstnc_lt" id="dstnc_lt"/>
										<input type="hidden" name="memo" id="memo"/>
										<input type="hidden" name="rockCnt" id="rockCnt"/>
										<input type="file" id="staImgFile" name="staImgFile" style="width: 350px"/>
										<tr>
											<th>현재상태 </th>
											<td>
												<c:if test= "${info.station_use_yn == 'T'}"> 임시폐쇄 </c:if>
												<c:if test= "${info.station_use_yn == 'S'}"> 임시폐쇄(예정) </c:if>
												<c:if test= "${info.station_use_yn == 'Y'}"> 사용 </c:if>
												<c:if test= "${info.station_use_yn == 'N'}"> 미사용 </c:if>
												<c:if test= "${info.station_use_yn == 'C'}"> 폐쇄</c:if>
												<c:if test= "${info.station_use_yn == 'R'}"> 정비센터 테스트용 </c:if>
											</td>
										</tr>
									    <tr>
											<th><em>*</em>대여소 명</th>
											<td>	
												<c:forEach items="${codeList }" var="code" varStatus="idx">
													<p>
													<span class="input-text05">
														<c:if test="${idx.index == 0 }">
															<input type="text" name="nameList" id="${code.comCd }" readonly />
														</c:if>
													</span>
													</p>
												</span>
												</c:forEach>	
											</td>
										</tr>
										<tr>
											<th><em>*</em>주소</th>
											<td><input type="hidden"  name="station_post_no" id="station_post_no"/>
												<p class="mt10"><span class="input-text05"><input type="text" name="station_addr1" id="station_addr1" readonly /></span></p>
												<p class="mt10"><span class="input-text05"><input type="text" name="station_addr2" id="station_addr2" readonly/></span></p>
												<button class="btnType02" onclick="goMapAddr();" type="button">지도보기</button>
											</td>
										</tr>
										<tr>
											<th><em>*</em>사용 여부</th>
											<td>
												<span>
													<!-- <span class="input-rd01"><input type="radio" name="station_use_yn" id="station_use_t" value="T"><label for="station_use_t">임시 폐쇄 <font color="red">(예정)</font></label></span> -->
													<span class="input-rd01"><input type="radio" name="station_use_yn" id="station_use_t" value="T"><label for="station_use_t">임시 폐쇄</label></span>
													<span class="input-rd01"><input type="radio" name="station_use_yn" id="station_use_y" value="Y"><label for="station_use_y">사용</label></span>
												</span>
											</td>
										</tr>
										<tr>
											<th>임시 폐쇄 기간</th>
										 	<td>
										 		<div id="unuseDate" style="display: none;">
										 		<span class="selectDate input-datepick04">
										 		<input type="text" class="datepicker input-datepick04" name="unuse_str_dttm"  title="선택 날짜" id="unuse_str_dttm" readonly value="${info.unuse_str_dttm}"/></span>
										 	    <span class="dash">~</span>
										 	    <span class="selectDate input-datepick04">
										 	    <input type="text" class="datepicker input-datepick04" name="unuse_end_dttm"  title="선택 날짜" id="unuse_end_dttm" readonly value="${info.unuse_end_dttm}"/></span>
										 	    </div>
										 	</td>
										<tr>
											<th><em>*</em>사유</th>
											<td>
												<select class="select-category02" name="reason" id="selbox">
													<option value="선택">선택</option>
													<option value="통신장애">통신장애</option>
													<option value="공사">공사</option>
													<option value="행사/축제">행사/축제</option>
													<option value="">직접입력</option>
												</select>
												<input type="text" class="input-text03" id="selboxDirect" name="reason"/>
											</td>
										</tr>
										</tbody>
								</table>
                         
								<div class="btnArea">
									<c:if test="${cmd == 'INFO'}">
										<span class="left" onclick="fn_list(); return false;"><button class="btnType01 bc_gray">목록</button></span>
										<span class="right" onclick="vallidateModify('UPDATE','${info.station_id}'); return false;"><button class="btnType01 bc_green">저장</button></span>
									</c:if>
								</div>
							</fieldset>
						</div>
						<div class="tabCon">
							<table class="tb_type01">
								<colgroup>
									<col style="width:15%"/>
									<col style="width:15%"/>
									<col style="width:15%"/> 
									<col style="width:15%"/>
									<col style="width:15%"/>
								</colgroup>
								<thead>
									<tr>
										
										<th>등록자</th>
										<th>등록일</th>
										<th>사용구분</th>
										<th>임시정지시작일</th>
										<th>임시정지종료일</th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${fn:length(stationUseList) > 0 }">                  
										<c:forEach var="result" items="${stationUseList}" varStatus="status">
			                                <tr>
			                                     <td class="tc"><c:out value="${result.reg_id}"/></td>
			                                    <td class="tc"><c:out value="${result.reg_dttm}"/></td>
			                                    <td class="tc">
			                                    	<c:if test="${result.station_use_yn eq 'Y'}">사용</c:if>
			                                    	<c:if test="${result.station_use_yn eq 'N'}">미사용</c:if>
			                                    	<c:if test="${result.station_use_yn eq 'T'}">임시폐쇄</c:if>
			                                    	<c:if test="${result.station_use_yn eq 'S'}">임시폐쇄(예정)</c:if>
			                                    	<c:if test="${result.station_use_yn eq 'C'}">폐쇄</c:if>
			                                    	<c:if test="${result.station_use_yn eq 'R'}">정비센터 테스트용</c:if>
			                                    </td>
			                                    <td class="tc"><c:out value="${result.unuse_str_dttm}"/></td>
			                                    <td class="tc"><c:out value="${result.unuse_end_dttm}"/></td>
			                                </tr>
										</c:forEach>
									</c:if>
	                            	<c:if test="${fn:length(stationUseList) == 0 }">  
		                                <tr>
		                                	<td colspan="5" class="tc"><spring:message code="info.nodata.msg" /></td>
		                                </tr>
									</c:if>
								</tbody>
							</table>
								<c:choose>
								<c:when test="${fn:length(stationUseList) > 0}">
									<div class="drpaging">
								</c:when>
								<c:otherwise>
									<div class="drpaging" style="display:none;">
								</c:otherwise>
						    </c:choose>
							
						</div>
						</div>
						</div>
						</div>
						</div>
					</div>
				</form>
				<!--content E-->
			</div>
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>

