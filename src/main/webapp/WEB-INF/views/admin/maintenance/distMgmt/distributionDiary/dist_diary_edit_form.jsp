<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
						<!-- 모바일 검색조건 S-->
						<div class="shBox_m">
							<div class="downtitle">
								<div class="title">
									<p>검색조건</p><span><button><img src="/images/srh_open.png" alt="검색조건 열기" /></button></span>
								</div>
							</div>
						</div>
						<form name="frm" id="frm" method="post">	
						<input type="hidden" id="relocateCarId" name="relocateCarId" value="${distributionAdminVo.relocateCarId}"  />
						<input type="hidden" id="assignCenterId" name="assignCenterId" value="${distributionAdminVo.assignCenterId}"  />
						<input type="hidden" id="teamSeq" name="teamSeq" value="${distributionAdminVo.teamSeq}"  />
						<input type="hidden" id="adminId" name="adminId" value="${distributionAdminVo.adminId}"  />
						
						<table class="tb_type01">
							<colgroup>
								<col style="width:5%"/>
								<col style="width:5%"/>
								<col style="width:5%"/>
								<col style="width:5%"/>
								<col style="width:5%"/>
								<col style="width:5%"/>
								<col style="width:5%"/>
								<col style="width:5%"/>
								<col style="width:5%"/>
								<col style="width:5%"/>
							</colgroup>
							<thead>
								<tr>
									<th colspan="5">&nbsp;</th>
									<!-- <th>&nbsp;</th>
									<th>&nbsp;</th>
									<th>&nbsp;</th>
									<th>&nbsp;</th> -->
									<th colspan="2">일자</th>
									<th colspan="2">${getTodayDate}</th>
								</tr>
							</thead>
							<tbody>
							<tr> 
								<td>강남/북</td>
								<td class="tc">${distributionAdminVo.assignCenterNm}</td>
								<td rowspan="2">
									<select class="select-category09" name="selectDay" id="selectDay">
                                       	<option value="1">오전</option>
                                       	<option value="2">오후</option>
                                    </select>
                                </td>
                                <td rowspan="2" valign="middle">${distributionAdminVo.adminNm}</td>
                                <td rowspan="2" valign="middle">
                                <input type="text" id="carNo" name="carNo" style="width: 30px;"  value="0" maxlength="4" />
                                <button id="searchCarBtn" class=""><img src="/images/searchIcon.gif" style="width: 24px;height: 20px;" alt="검색"></button>
                                <br><div id="carDiv">${distributionAdminVo.relocateCarNo}</div></td>
                                <td colspan="2" class="tc">주유량</td>
                                <td colspan="2"><input type="text" name="oil" style="width: 20px;"  value="0" />&nbsp;&nbsp;L</td>
                             </tr>
                             <tr> 
								<td>구 정보</td>
								<td class="tc">${distributionAdminVo.teamNm}</td>
                                <td>주행거리</td>
                                <td><input type="text" id="meter" name="meter" style="width: 40px;"  value="0" /></td>
                                <td>전&nbsp;&nbsp;<input type="text" name="firstMeter" style="width: 20px;"  value="0" /></td>
                                <td>후&nbsp;&nbsp;<input type="text" name="lastMeter" style="width: 20px;"  value="0" /></td>
                             </tr>
							</tbody>
							</table>	
							<br></br>
						
						<table class="tb_type01" id="table_01">
							<colgroup>
								<col style="width:20%"/>
								<col style="width:8%"/>
								<col style="width:7%"/>
								<col style="width:5%"/>
								<col style="width:5%"/>
								<col style="width:5%"/>
								<%-- <col style="width:15%"/> --%>
								<col style="width:5%"/>
								<%-- <col style="width:15%"/> --%>
								<col style="width:15%"/>
							</colgroup>
							<thead>
								<tr>
									<th>대여소 번호</th>
									<th>도착시간</th>
									<th>자전거 수량</th>
									<th>회수</th>
									<th>분배</th>
									<th>입고</th>
									<!-- <th>입고 자전거</th> -->
									<th>출고</th>
									<!-- <th>출고 자전거</th> -->
									<th>점검내용</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="stationName" value=""/>
								<c:set var="stationId" value=""/>
								<c:set var="odrDttm" value=""/>
								<c:set var="returnBikeCnt" value="0"/>
	                            <c:set var="rentBikeCnt" value="0"/>
	                            <c:set var="returnBikeSum" value="0"/>
	                            <c:set var="rentBikeSum" value="0"/>
	                            <c:set var="lineCnt" value="0"/>
	                            
								<c:forEach var="list" items="${distributionList}"  varStatus="loop">
	                                <c:if test="${stationName eq list.stationName}">
	                                	<c:if test="${list.return_bike eq '1'}">
	                                		<c:set var="returnBikeCnt" value="${returnBikeCnt + 1 }"/>
	                                	</c:if>
	                                	<c:if test="${list.rent_bike eq '1'}">
	                                		<c:set var="rentBikeCnt" value="${rentBikeCnt + 1 }"/>
	                                	</c:if>
	                                </c:if>
	                                <c:if test="${stationName eq ''}">
	                                	<c:set var="stationName" value="${list.stationName}"/>
	                                	<c:set var="stationId" value="${list.stationId}"/>
	                                	<c:set var="odrDttm" value="${list.odrDttm}"/>
	                                	<c:if test="${list.return_bike eq '1'}">
	                                		<c:set var="returnBikeCnt" value="1"/>
	                                	</c:if>
	                                	<c:if test="${list.return_bike ne '1'}">
	                                		<c:set var="returnBikeCnt" value="0"/>
	                                	</c:if>
	                                	<c:if test="${list.rent_bike eq '1'}">
	                                		<c:set var="rentBikeCnt" value="1"/>
	                                	</c:if>
	                                	<c:if test="${list.rent_bike ne '1'}">
	                                		<c:set var="rentBikeCnt" value="0"/>
	                                	</c:if>
	                                </c:if>
	                                <c:if test="${stationName ne list.stationName}">
	                                <c:set var="lineCnt" value="${lineCnt+1}"/>
	                                
	                                <tr>
	                                    <td>${stationName }</td>
	                                    <fmt:parseDate var="dateString" value="${odrDttm }" pattern="yyyy-MM-ddHH:mm:ss" />
	                                    <td><fmt:formatDate value="${dateString}" pattern="HH:mm:ss" />	</td>
	                                    <td><%-- <label id="bCnt_${lineCnt}"></label> --%><input type="text" id="bikeCount" name="bikeCount" style="width: 20px;" value="0" />
	                                    <div id="bLa_${lineCnt}" style="display: none">${stationId}_${odrDttm}</div>
	                                   <%-- <input id="bLa_${lineCnt}"name="bLa_${lineCnt}" type="hidden" value="${stationId}_${odrDttm}"> --%>
	                                    </td>
	                                    <%-- <c:set  var="bLa_<%=lCnt%>"  value="${stationId}_${odrDttm}"/> --%>
										<td>${returnBikeCnt}<input type="hidden" name="returnBikeCnt" value="${returnBikeCnt}" /></td>
										<c:set var="returnBikeSum" value="${returnBikeSum + returnBikeCnt}"/>
	                                    <td>${rentBikeCnt}<input type="hidden" name="rentBikeCnt" value="${rentBikeCnt}" /></td>
	                                     <c:set var="rentBikeSum" value="${rentBikeSum + rentBikeCnt}"/>	
	                                   	<td><input type="text" name="warehousing" style="width: 20px;" value="0" /></td>
	                                   	<!-- <td>...</td> -->
	                                   	<td><input type="text" name="dlivy" style="width: 20px;"  value="0" /></td>
	                                   	<!-- <td>...</td> -->
	                                   	<td>
	                                   		<select class="select-category09" name="checkCode" id="checkCode">
                                                <option value="default">선택</option>
                                               <c:forEach var="cList" items="${codeList}"  varStatus="status">
	                                               <option value="${cList.comCd}">${cList.comCdName}</option>
                                               </c:forEach>
                                            </select>
                                        </td>
									</tr>
									<c:set var="stationName" value="${list.stationName}"/>
									<c:set var="stationId" value="${list.stationId}"/>
	                                <c:set var="odrDttm" value="${list.odrDttm}"/>
										<c:if test="${list.return_bike eq '1'}">
	                                		<c:set var="returnBikeCnt" value="1"/>
	                                	</c:if>
	                                	<c:if test="${list.return_bike ne '1'}">
	                                		<c:set var="returnBikeCnt" value="0"/>
	                                	</c:if>
	                                	<c:if test="${list.rent_bike eq '1'}">
	                                		<c:set var="rentBikeCnt" value="1"/>
	                                	</c:if>
	                                	<c:if test="${list.rent_bike ne '1'}">
	                                		<c:set var="rentBikeCnt" value="0"/>
	                                	</c:if>
	                                	<input type="hidden" name="stationId" value="${stationId}" />
	                                	<input type="hidden" name="arvlDttm" value="${odrDttm}" />
									</c:if>
                                </c:forEach>
                                 <c:if test="${fn:length(distributionList) ne 0 }">
                                 		 <c:set var="lineCnt" value="${lineCnt+1}"/>
                                 		 
                                 		<tr>
	                                    <td>${stationName }</td>
	                                    <fmt:parseDate var="dateString" value="${odrDttm }" pattern="yyyy-MM-ddHH:mm:ss" />
										
	                                    <td><fmt:formatDate value="${dateString}" pattern="HH:mm:ss" />	</td>
	                                    <td><%-- <label id="bCnt_${lineCnt}"></label> --%><input type="text" id="bikeCount" name="bikeCount" style="width: 20px;" value="0" />
	                                    <div id="bLa_${lineCnt}" style="display: none">${stationId}_${odrDttm}</div>
										<td>${returnBikeCnt}<input type="hidden" name="returnBikeCnt" value="${returnBikeCnt}" /></td>
										<c:set var="returnBikeSum" value="${returnBikeSum + returnBikeCnt}"/>
	                                    <td>${rentBikeCnt}<input type="hidden" name="rentBikeCnt" value="${rentBikeCnt}" /></td>	
	                                     <c:set var="rentBikeSum" value="${rentBikeSum + rentBikeCnt}"/>
	                                   	<td><input type="text" name="warehousing" style="width: 20px;" value="0" /></td>
	                                   	<!-- <td>...</td> -->
	                                   	<td><input type="text" name="dlivy" style="width: 20px;" value="0" /></td>
	                                   	<!-- <td>...</td> -->
	                                   	<!-- <td>...</td> -->
	                                   	<td>
	                                   		<select class="select-category09" name="checkCode" id="checkCode">
                                               <option value="default">선택</option>
                                               <c:forEach var="cList" items="${codeList}"  varStatus="status">
	                                               <option value="${cList.comCd}">${cList.comCdName}</option>
                                               </c:forEach>
                                            </select>
                                        </td>
									</tr>
									<input type="hidden" name="stationId" value="${stationId}" />
                                	 <input type="hidden" name="arvlDttm" value="${odrDttm}" />
                                 </c:if>
									</tbody>
								</table>
								<div class="btnArea">
									<span class="right"><button class="btnType01" id="addBtn" title="추가">추가</button></span>
									<!-- <span class="right"><button class="btnType01" id="delBtn" title="삭제">삭제</button></span> -->
								</div>
								<br></br>	
									
								<table class="tb_type01">
									<colgroup>
										<col style="width:20%"/>
										<col style="width:8%"/>
										<col style="width:7%"/>
										<col style="width:5%"/>
										<col style="width:5%"/>
										<col style="width:5%"/>
										<%-- <col style="width:15%"/> --%>
										<col style="width:5%"/>
										<%-- <col style="width:15%"/> --%>
										<col style="width:15%"/>
									</colgroup>
									<thead>
									
									
									
									<tr>
									<th colspan="3">합계</th>
									<td>${returnBikeSum}</td>
									<td>${rentBikeSum}</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									
                                 
                                <c:if test="${fn:length(distributionList) eq 0 }">
	                                <table class="tb_type01 nbt0">
			                            <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
			                        </table>
								</c:if>
							</tbody>
						</table>
						
						 <table class="tb_type02 mt20">
	                		<colgroup>
	                    		<col style="width:30%">
	                    		<col style="width:70%">
	                		</colgroup>
	                		<tbody>
	                    		<tr>
	                        		<th class="top"><!-- <em>*</em> --> 기타사항</th>
	                        		<td><textarea class="detatextarea" id="etcDesc" name="etcDesc"></textarea>
	                        	</td>
	                        	</tr>
	                        	</tbody>
                        	</table>	
					
						</form>
						<div class="btnArea">
							<span class="right"><button class="btnType01" id="saveBtn" title="저장">저장</button></span>
						</div>
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
	<!-- <script type="text/javascript" src="/js/jquery.serialize-object.min.js"></script> -->
	
    <script type="text/javascript">
    var lineCount = ${lineCnt};
    $(function() {
		distributionList.initBtn();
		//alert(lineCount);
		
	});
    
    var distributionList = {};
    
    distributionList.initBtn = function(){
    	//bikeCntFnc();
    	//alert("배열?"+distributionFrm.warehousing[1].value);
    	var _this = distributionList;
    	$("#searchCarBtn").on("click",{listType: "list"},this.carSearchFnc);
    	$("#saveBtn").on("click",{listType: "list"},this.saveFnc);
    	$("#addBtn").on("click",{listType: "list"},this.addFnc);
    	$("#delBtn").on("click",{listType: "list"},this.delFnc);
    	
    	
    	
    	
    }
    
    
    function bikeCntFnc(){
		var lineCnt = '${lineCnt}';
		
		//var staionId = 'ST-161';
		//var time = '2017-08-23 18:27:43';
		var staionId = '';
		var time = '';
		if(lineCnt > 0){
			for (var i=1 ; i<=lineCnt ; i++ ){
				
				 stationParam = $("#bLa_"+i).text();
				 var f = stationParam.split("_");
				 staionId = f[0];
				 time = f[1];
	             if(f[0] != '' && f[1] != '') {
	            	 $.ajax({
	     				url : "/distributionDiary/getBikeCntAjax.do",
	     				type : "get",
	     				data : { "stationId" : staionId, "odrDttm" : time},
	     				contentType: "charset=utf-8",
	     				async : false,
	     				success : function(dataView){
	     					var bikeCount = dataView.bikeCount;
	     					//alert(bikeCount);
	     					
	     					//$("#bCnt_"+i).text(bikeCount);
	     					//frm.bikeCount[i-1].value = bikeCount; 
	     				},
	     				error : function(){ alert("데이터를 가져오는데 실패 하였습니다."); }
	     			});
	            	 
	             }
			  }
		}
		
		//var staionId = 'ST-161';
		//var time = '2017-08-23 18:27:43';
			
		}
		
    distributionList.carSearchFnc = function(e) {
        e.preventDefault();
        //var listType = e.data.listType;
        var carNo = $("[name='carNo']").val();
        //alert(carNo);
         $.ajax({
				url : "/distributionDiary/getCarNoAjax.do",
				type : "get",
				data : { "carNo" : carNo},
				contentType: "charset=utf-8",
				async : false,
				success : function(dataView){
					var carInfo = dataView.carInfo;
					//alert(bikeCount);
					//var carId ="";
					
					if(carInfo == null || carInfo ==''){
						$("#carDiv").text('');
					} else {
						var f = carInfo.split(",");
						$("#relocateCarId").val(f[0]);
						$("#carDiv").text(f[1]);
					}	
					
				},
				error : function(){ alert("데이터를 가져오는데 실패 하였습니다."); }
			}); 
        
    };
    
    distributionList.saveFnc = function(e) {
    	e.preventDefault();
    	//alert(1);
    	//alert("배열?"+frm.warehousing[1].value);
    	//alert($("#frm").serialize());
    	
    	
    	$.ajax({
				url : "/distributionDiary/addDistributionDiaryProc.do",
				type : "post",
				dataType : 'json',
				data : $('#frm').serialize(),
				async : false,
				success : function(dataView){
				alert("저장에 성공 하였습니다.");	
				},
				error : function(){ alert("저장에 실패 하였습니다."); }
			}); 
    };
    
    distributionList.addFnc = function(e) {
    	e.preventDefault();
    	// var today = new Date();
    	var today = DateUtil.dateFmt(new Date());
    	var nowTime = DateUtil.getCurrentTime(new Date());
    	
    	lineCount++;
    	
    	$("#table_01").last().append("<tr>"
    			+"<td><label for='stationGrpSlt"+lineCount+"' class='laType02'></label><select class='select-category02' name='stationGrpSeq"+lineCount+"' id='stationGrpSlt"+lineCount+"'><option value=''>선택</option></select>"
    			+"<label for='stationIdSlt"+lineCount+"' class='laType02'></label><select class='select-category03' name='stationId' id='stationIdSlt"+lineCount+"'><option value=''>선택</option></select></td>"
    			+"<td>"+ nowTime + "<input type='hidden' name='arvlDttm' style='width: 40px;' value='"+ today + " " + nowTime + "' /></td>"
    			+"<td><input type='text' name='bikeCount' style='width: 20px;' value='0' /></td>"
    			+"<td><input type='text' name='returnBikeCnt' style='width: 20px;' value='0' /></td>"
    			+"<td><input type='text' name='rentBikeCnt' style='width: 20px;' value='0' /></td>"
    			+"<td><input type='text' name='warehousing' style='width: 20px;' value='0' /></td>"
    			+"<td><input type='text' name='dlivy' style='width: 20px;' value='0' /></td>"
    			+"<td>"
    			+"<select class='select-category09' name='checkCode' id='checkCode'>"
    			+"<option value='default'>선택</option>"
    			+"<c:forEach var='cList' items='${codeList}'  varStatus='status'>"
    			+"<option value='${cList.comCd}'>${cList.comCdName}</option>"
    			+"</c:forEach>"
    			+"</select>"
    			+"</td>"
    			+"</tr>");
    	
    	$("#stationGrpSlt"+lineCount).on('change', function(e){
        	var tId = e.target.id;
        	var idx = $("#"+tId+" option:selected").index();
        	var subList =$("#"+tId).data().sub_data;
        	$("#stationIdSlt"+lineCount+" option").not(':eq(0)').remove();
        	var sltsubData = subList[(idx-1)];
        	if(sltsubData !== undefined) {
	        	if(sltsubData.length > 0) {
		        	commCdBox.makeComboBox("S",'9',sltsubData, "stationIdSlt"+lineCount);
	        	}
        	}
        });
    	
    	//스테이션 
        commonAjax.getStationCode( 
	        function(data) {
	           
	        	if(data != null && data.stationList != null) {
	                commCdBox.makeComboBox('S','9',data.stationList, "stationGrpSlt"+lineCount);
	                $("#stationGrpSlt"+lineCount).trigger('change');
	            }
	        }
        );
    };
    
    	distributionList.delFnc = function(e) {
        	e.preventDefault();
        	// var today = new Date();
        	
        	//$("#table_01").last().remove();
        	//$('#table2 tbody tr:nth-child(2)').remove();
        	
        	
        	
    	
    };
    
    
    </script>
</body>
</html>