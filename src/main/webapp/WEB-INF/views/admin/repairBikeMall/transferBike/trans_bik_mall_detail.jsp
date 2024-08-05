<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<tiles:insertAttribute name="resource"/>
<link href="/css/jquery-editable-select.css" rel="stylesheet">
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
						<form id="transMallFrm">
						<input type="hidden" name="viewFlg" value="${transferInfo.viewFlg }">
						<jsp:useBean id="today" class="java.util.Date"></jsp:useBean>
						<fmt:formatDate value="${today}" type="DATE" var="todaySim" pattern="yyyy-MM-dd HH:mm:ss"/>
						<input type="hidden" name="regDttm" value="${todaySim }">
						<%-- <input type="hidden" name="adminId" value="<%= com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrId") %>"> --%>
						<input type="hidden" name="adminId" value="${transferUserInfo.usrId }">
						<input type="hidden" name="takeId" value="${mallInfoView.takeId}">
						<input type="hidden" name="partsData" value="">
						<input type="hidden" name="stationGrpSeq" id="stationGrpSeq" value="${condition.stationGrpSeq }">
						
						<input type="hidden" name="centerId" id="centerId" value="${mallInfoView.centerId}">
						
						<input type="hidden" name="repairOutsrcMainSeq" id="repairOutsrcMainSeq" value="${transferInfo.repairOutsrcMainSeq }">
						
						<p class="head mt20">정비할 점포 확인
							<!-- <span><button type="button" class="btnType05" id="saveMall">점포 저장</button></span> -->
						</p>
						<table class="tb_type01 mt10">
							<colgroup>
								<col style="width:20%"/>
								<%-- <col style="width:15%"/> --%>
								<col style="width:39%"/>
								<col style="width:13%"/>
								<col style="width:13%"/>
							</colgroup>
							<thead>
								<tr>
									<th>작성일자</th>
									<!-- <th>지역구</th> -->
									<th>점포명</th>
									<th>등록자</th>
									<th>인수자(점포대표)</th>
								</tr>
							</thead>
							<c:if test="${transferInfo.viewFlg eq 'list' || transferInfo.viewFlg eq 'C' }">
							<tbody>
								<tr>
									<td class="tc">${todaySim}</td>
									<!-- <td class="tc">
									<select class="select-category09" id="stationGrpSlt" name="stationGrpSlt" required="true" >
											<option value="">선택</option>
									</select>&nbsp;
									</td> -->
									<td class="tc">
									<select class="select-category09" style="width:80%" name="centerName" id="centerSlt">
													<option value="" >선택</option>
												</select>
								    
									</td>
									<td class="tc">
										${transferUserInfo.usrName }
										<%-- <%= com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrName") %> --%>
									</td>
									<td class="tc" id="takeNm"></td>
								</tr>
							</tbody>
							</c:if>
							<c:if test="${transferInfo.viewFlg eq 'U' }">
							<tbody>
								<tr>
									<td class="tc">${mallInfoView.regDttm}</td>
									<!-- <td class="tc">
									<select class="select-category09" id="stationGrpSlt" name="stationGrpSlt" required="true" disabled="true">
											<option value="">선택</option>
									</select>&nbsp;
									</td> -->
									<td class="tc">
										${mallInfoView.centerName}
									</td>
									<td class="tc">
										${mallInfoView.adminId }
									</td>
									<td class="tc" id="takeNm">${mallInfoView.adminName}</td>
								</tr>
							</tbody>
							</c:if>
						</table>
						</form>
						<form id="transBikeFrm">
						<p class="head ttbtncase1">수리대상 자전거 등록
							<!-- <span><button type="button" class="btnType05" id="addItemBtn">자전거 추가</button></span> -->
						</p>
						<table class="tb_type01 mt10" id="example">
							<colgroup>
								<col style="width:35%"/>
								<col style="width:50%"/>
								<col style="width:15%"/>
							</colgroup>
							<thead>
								<tr>
									<th>자전거 번호</th>
									<th>부품 선택</th>
									<th>비고</th>
								</tr>
							</thead>
							<c:if test="${transferInfo.viewFlg eq 'list' || transferInfo.viewFlg eq 'C' }">
							<tbody>
								<tr class="item1">
									<td rowspan="1"><span class="input-text12"><input type="text" id="bikeNo" name="bikeNo" /></span>
										<button type="button" class="btnType05" id="addItemBtn">자전거 추가</button>
									</td>
									<td>
										<select class="select-category03" name="suribike" disabled="disabled">
											<option value="">선택</option>
											<option value="REC_001" selected>기본교정</option>
											<option value="REC_002">프레임</option>
											<option value="REC_003">포크</option>
											<option value="REC_004">안장</option>
											<option value="REC_005">싯포스트</option>
											<option value="REC_006">싯클램프</option>
											<option value="REC_007">QR레버</option>
											<option value="REC_008">변속레버</option>
											<option value="REC_009">변속기</option>
											<option value="REC_010">케이블</option>
											<option value="REC_011">보호대</option>
											<option value="REC_012">전륜 휠셋</option>
											<option value="REC_013">전륜 타이어</option>
											<option value="REC_014">전륜 튜브</option>
											<option value="REC_015">전륜 물받이</option>
											<option value="REC_016">후륜 휠셋</option>
											<option value="REC_017">후륜 타이어</option>
											<option value="REC_018">후륜 튜브</option>
											<option value="REC_019">후륜 물받이(구형)</option>
											<option value="REC_020">후륜 물받이(신형)</option>
											<option value="REC_021">핸들스템</option>
											<option value="REC_022">핸들바</option>
											<option value="REC_023">핸들그립</option>
											<option value="REC_024">크랭크암</option>
											<option value="REC_025">바텀브래킷</option>
											<option value="REC_026">체인</option>
											<option value="REC_027">페달</option>
											<option value="REC_028">브레이크레버</option>
											<option value="REC_029">V브레이크(앞)</option>
											<option value="REC_030">케이블(앞)</option>
											<option value="REC_031">패드(앞)</option>
											<option value="REC_032">롤브레이크(뒤)</option>
											<option value="REC_033">케이블(뒤)</option>
											<option value="REC_034">전조등(구형)</option>
											<option value="REC_035">전조등(신형)</option>
											<option value="REC_036">다이나모 케이블</option>
											<option value="REC_037">후미등</option>
											<option value="REC_038">벨</option>
											<option value="REC_039">바구니</option>
											<option value="REC_040">스탠드</option>
											<option value="REC_041">체인커버</option>
										</select>
										<button type="button" class="addBtn btnType05">항목추가</button>
									</td>
							        <td class="tc"><button class="delBtn btnType05" style="display:none;">삭제</button></td>
								</tr>
								
							</tbody>
							</c:if>
							<c:if test="${transferInfo.viewFlg eq 'U' }">
							<tbody>
								<c:set var="cnt" value="0" />
								<c:set var="bikNo" value="" />
								
								<c:forEach var="result" items="${repairBikeList}" varStatus="status">
								<c:set var="cnt" value="${cnt +1 }" />
								<c:forTokens var="broken" items="${result.partsData }" delims=",">
								<tr class="item${cnt }">
									<c:if test="${result.bikeNo ne bikNo}">
									<c:set var="bikNo" value="${result.bikeNo }" />
									<td rowspan="${result.brokenType }"><span class="input-text12"><input type="text" id="bikeNo" name="bikeNo" value="${fn:substringAfter(result.bikeNo, '-') }"/></span>
									<c:if test="${cnt ==1 }">
										<button type="button" class="btnType05" id="addItemBtn">자전거 추가</button>
									</c:if>
									
									</td>
									</c:if>
									<td>
										<select class="select-category03" name="suribike" <c:if test="${broken eq 'REC_001'}">disabled="disabled"</c:if>>
											<option value="">선택</option>
											<option value="REC_001" <c:if test="${broken eq 'REC_001'}">selected</c:if>>기본교정</option>
											<option value="REC_002" <c:if test="${broken eq 'REC_002'}">selected</c:if>>프레임</option>
											<option value="REC_003" <c:if test="${broken eq 'REC_003'}">selected</c:if>>포크</option>
											<option value="REC_004" <c:if test="${broken eq 'REC_004'}">selected</c:if>>안장</option>
											<option value="REC_005" <c:if test="${broken eq 'REC_005'}">selected</c:if>>싯포스트</option>
											<option value="REC_006" <c:if test="${broken eq 'REC_006'}">selected</c:if>>싯클램프</option>
											<option value="REC_007" <c:if test="${broken eq 'REC_007'}">selected</c:if>>QR레버</option>
											<option value="REC_008" <c:if test="${broken eq 'REC_008'}">selected</c:if>>변속레버</option>
											<option value="REC_009" <c:if test="${broken eq 'REC_009'}">selected</c:if>>변속기</option>
											<option value="REC_010" <c:if test="${broken eq 'REC_010'}">selected</c:if>>케이블</option>
											<option value="REC_011" <c:if test="${broken eq 'REC_011'}">selected</c:if>>보호대</option>
											<option value="REC_012" <c:if test="${broken eq 'REC_012'}">selected</c:if>>전륜 휠셋</option>
											<option value="REC_013" <c:if test="${broken eq 'REC_013'}">selected</c:if>>전륜 타이어</option>
											<option value="REC_014" <c:if test="${broken eq 'REC_014'}">selected</c:if>>전륜 튜브</option>
											<option value="REC_015" <c:if test="${broken eq 'REC_015'}">selected</c:if>>전륜 물받이</option>
											<option value="REC_016" <c:if test="${broken eq 'REC_016'}">selected</c:if>>후륜 휠셋</option>
											<option value="REC_017" <c:if test="${broken eq 'REC_017'}">selected</c:if>>후륜 타이어</option>
											<option value="REC_018" <c:if test="${broken eq 'REC_018'}">selected</c:if>>후륜 튜브</option>
											<option value="REC_019" <c:if test="${broken eq 'REC_019'}">selected</c:if>>후륜 물받이(구형)</option>
											<option value="REC_020" <c:if test="${broken eq 'REC_020'}">selected</c:if>>후륜 물받이(신형)</option>
											<option value="REC_021" <c:if test="${broken eq 'REC_021'}">selected</c:if>>핸들스템</option>
											<option value="REC_022" <c:if test="${broken eq 'REC_022'}">selected</c:if>>핸들바</option>
											<option value="REC_023" <c:if test="${broken eq 'REC_023'}">selected</c:if>>핸들그립</option>
											<option value="REC_024" <c:if test="${broken eq 'REC_024'}">selected</c:if>>크랭크암</option>
											<option value="REC_025" <c:if test="${broken eq 'REC_025'}">selected</c:if>>바텀브래킷</option>
											<option value="REC_026" <c:if test="${broken eq 'REC_026'}">selected</c:if>>체인</option>
											<option value="REC_027" <c:if test="${broken eq 'REC_027'}">selected</c:if>>페달</option>
											<option value="REC_028" <c:if test="${broken eq 'REC_028'}">selected</c:if>>브레이크레버</option>
											<option value="REC_029" <c:if test="${broken eq 'REC_029'}">selected</c:if>>V브레이크(앞)</option>
											<option value="REC_030" <c:if test="${broken eq 'REC_030'}">selected</c:if>>케이블(앞)</option>
											<option value="REC_031" <c:if test="${broken eq 'REC_031'}">selected</c:if>>패드(앞)</option>
											<option value="REC_032" <c:if test="${broken eq 'REC_032'}">selected</c:if>>롤브레이크(뒤)</option>
											<option value="REC_033" <c:if test="${broken eq 'REC_033'}">selected</c:if>>케이블(뒤)</option>
											<option value="REC_034" <c:if test="${broken eq 'REC_034'}">selected</c:if>>전조등(구형)</option>
											<option value="REC_035" <c:if test="${broken eq 'REC_035'}">selected</c:if>>전조등(신형)</option>
											<option value="REC_036" <c:if test="${broken eq 'REC_036'}">selected</c:if>>다이나모 케이블</option>
											<option value="REC_037" <c:if test="${broken eq 'REC_037'}">selected</c:if>>후미등</option>
											<option value="REC_038" <c:if test="${broken eq 'REC_038'}">selected</c:if>>벨</option>
											<option value="REC_039" <c:if test="${broken eq 'REC_039'}">selected</c:if>>바구니</option>
											<option value="REC_040" <c:if test="${broken eq 'REC_040'}">selected</c:if>>스탠드</option>
											<option value="REC_041" <c:if test="${broken eq 'REC_041'}">selected</c:if>>체인커버</option>

										</select>
										<c:if test="${broken eq 'REC_001'}">
									    	<button type="button" class="addBtn btnType05">항목추가</button>
									    </c:if>
									</td>
							        <td class="tc"><button class="delBtn btnType05">삭제</button></td>
								</tr>
								</c:forTokens>
								</c:forEach>		
							</tbody>
							</c:if>
						</table>
						
						
						<div class="btnArea">
							<span class="right">
								<c:if test="${ mallInfoView.collectYn ne 'Y'}">
								<button class="btnType01 bc_green mb10" id="btnSave">저장</button>
								</c:if>
								<button class="btnType01 bc_green mb10" id="btnPrintExel">인수인계증출력</button>
							</span>
						</div>

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
	<script type="text/javascript" src="/js/jquery-editable-select.js"></script>
	<!--  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script> -->

    <script type="text/javascript">
    $(function() {
    	if("${condition.stationGrpSeq}" != ""){
			$("#stationGrpSlt").val("${condition.stationGrpSeq}");
		}
    	repairBikeDetail.initBtn();
	});
    
	var repairBikeDetail = {};
    
	repairBikeDetail.initBtn = function(){
    	$("#searchBtn").on("click",{listType: "list"},this.exeListFnc);
    	$(".tb_type01 > tbody > tr").on("click", "a",{ viewFlg : 'U'},  this.moveEditForm);
    	$("#btnSave").on("click",{ viewFlg : 'C'}, this.moveEditForm);
    	$("#btnPrintExel").on("click", this.exeExcelFnc);
    	
    	// 점포명 변경 시 인수자 아이디, 이름 정보 변경
    	$("#centerName").change(function(){
    		var selectVal = this.value;
    		selectVal = selectVal.split(",");	// 인수자 아이디, 이름으로 분리
    		$("[name='takeId']").val(selectVal[0]);
    		$("#takeNm").text(selectVal[1]);    		
    	});
    	
    	
    	// 옵션추가 버튼 클릭시
        $("#addItemBtn").click(function(){
            // item 의 최대번호 구하기
            var lastItemNo = $("#example tr:last").attr("class").replace("item", "");
            var newitem = $("#example tr:eq(1)").clone();
            newitem.removeClass();
            newitem.find("td:eq(0)").attr("rowspan", "1");
            
            // 이전 자전거 번호가 값이 없으면 없다고 alert띄우고 return false
            if($(".item"+lastItemNo).find("td:eq(0) input").val() == ""){
            	alert("자전거 번호 입력 후 자전거를 추가해주세요.");
            	return false;
            }
            //alert("item"+lastItemNo+" : "+$(".item"+lastItemNo).find("td:eq(0) input").val());
            
            // 추가한 자전거 에 값 삭제 
            newitem.find("td:eq(0) input").val("");
            newitem.find("td:eq(0) button").remove();
            
         	// 삭제버튼 추가
            newitem.find("td:eq(2) button").attr("style","display:inline-block");
            
            newitem.addClass("item"+(parseInt(lastItemNo)+1));
            $("#example").append(newitem);
            newitem.find("td:eq(0) input").focus();
        });
        // 항목추가 버튼 클릭시
        $(document).on("click", ".addBtn",  function(){
       
        	var clickedRow = $(this).parent().parent();
            var cls = clickedRow.attr("class");
            // tr 복사해서 마지막에 추가
            var newrow = clickedRow.clone();
            
         // 새로운 항목추가 버튼은 삭제
            //newrow.find("td:eq(1) button").remove();
         
            newrow.find("td:eq(0)").remove();
            
            newrow.find("td:eq(0) button").remove();
            
            newrow.find("td:eq(0) select").removeAttr("disabled");
            
            newrow.find("td:eq(0) option[value='REC_001']").remove();
            
            // 삭제버튼 추가
            newrow.find("td:eq(1) button").attr("style","display:inline-block");
            
           // newrow.find("td:eq(0) select").remove();
           
          // newrow.find("td:eq(0) > select").attr("id","tempSelectBox");
            
            newrow.insertAfter($("#example ."+cls+":last"));
            // rowspan 조정
            resizeRowspan(cls);
            
            //$("#tempSelectBox").click();
            //alert(2);
        });
        // 삭제버튼 클릭시
         $(document).on("click", ".delBtn",  function(){
        
        	var clickedRow = $(this).parent().parent();
            var cls = clickedRow.attr("class");
            // 각 항목의 첫번째 row를 삭제한 경우 다음 row에 td 하나를 추가해 준다.
            if( clickedRow.find("td:eq(0)").attr("rowspan") ){
                if( clickedRow.next().hasClass(cls) ){
                    clickedRow.next().prepend(clickedRow.find("td:eq(0)"));
                }
            }
            clickedRow.remove();
            // rowspan 조정
            resizeRowspan(cls);
        });
      
       
        // cls : rowspan 을 조정할 class ex) item1, item2, ...
        function resizeRowspan(cls){
            var rowspan = $("."+cls).length;
            $("."+cls+":first td:eq(0)").attr("rowspan", rowspan);
        }
        var currentStatus = {};
        var _this = currentStatus;
        currentStatus.stationGrpSeq = '${condition.stationGrpSeq}';
        
     // 2019.03.26. 보관센터
    	 /* commonAjax.getCenterMallCode( 
            function(data) {
                if(data !== null && data.centerList !== null) {
                    commCdBox.makeComboBox('C', _this.centerId, data.centerList, "centerSlt");
                    $('#centerSlt > option').each(function() {
					      if($(this).text() == '${repairBikeInfo.centerName}') {
					         $(this).attr('selected', 'selected');
					      }
					  });
                   
                 
				    $('#centerSlt').editableSelect()
			    					// 센터 id 가져오는 로직
			    					.on('select.editable-select', function (e, li) {
			    						$('#centerId').val("CEN" + lpad( li.val(), 3, '0'));
			            					
			   						});
				    
                }
            }
        );  */
        
        $.ajax({
    		  url  : "/addTransferBikeMallAjax.do",
    		  type : "POST",
    		  data : {districtCd : ""},
    		  dataType	: 'json',
  			  success : function(data){
	    				//성공했다는 걸 띄우기 RESULT_MESSAGE
	    				//console.log(data);
	    						
	    				//$("#centerSlt").empty().data('options');
	    			
	  					 if(data.resultMessage == 'Success'){
	  						/* $('#centerSlt').editableSelect('clear');
	  						for(var i = 0; i < data.bikeMallList.length; i++){ 
	  							$('#centerSlt').editableSelect('add',function (){
	  								$(this).val(data.bikeMallList[i].centerId);
	  								$(this).text(data.bikeMallList[i].centerName);
	  							});
	  						} */
	  						 /* $('#centerSlt > option').each(function() {
	  						      if($(this).text() == '${repairBikeInfo.centerName}') {
	  						         $(this).attr('selected', 'selected');
	  						      }
	  						  }); */
	  						
	  						for(var i = 0; i < data.bikeMallList.length; i++){ 
	  							$('#centerSlt').editableSelect('add',function (){
	  								$(this).val(data.bikeMallList[i].centerId);
	  								$(this).attr('id', data.bikeMallList[i].centerId);
	  								$(this).attr('label', data.bikeMallList[i].takeId);
	  								$(this).attr('label2', data.bikeMallList[i].adminName);
	  								$(this).text(data.bikeMallList[i].centerName);
	  							});
	  						}
	  	                 
	  					    
	  			    	
	  					}else{
	  						alert("데이터를 가져오는데 실패 하였습니다.");
	  					} 
	  				},
  			 
  			  error : function(){
					alert("데이터를 가져오는데 실패 하였습니다.");
			  		}
  			});
        
    	$("#stationGrpSlt").on("change", function(e){
      	  // alert($("#stationGrpSlt").val());
      	  
      	   $.ajax({
      		  url  : "/addTransferBikeMallAjax.do",
      		  type : "POST",
      		  data : {districtCd : $("#stationGrpSlt").val()},
      		  dataType	: 'json',
    			  success : function(data){
	    				//성공했다는 걸 띄우기 RESULT_MESSAGE
	    				//console.log(data);
	    						
	    				//alert(data.bikeMallList.length);
	    				//$("#centerSlt").empty().data('options');
	    			
	  					 if(data.resultMessage == 'Success'){
	  						$('#centerSlt').editableSelect('clear');
	  						for(var i = 0; i < data.bikeMallList.length; i++){ 
	  							$('#centerSlt').editableSelect('add',function (){
	  								//alert(data.bikeMallList[i].centerId);
	  								$(this).val(data.bikeMallList[i].centerId);
	  								$(this).attr('id', data.bikeMallList[i].centerId);
	  								$(this).attr('label', data.bikeMallList[i].takeId);
	  								$(this).attr('label2', data.bikeMallList[i].adminName);
	  								$(this).text(data.bikeMallList[i].centerName);
	  							});
	  						}
	  			    	
	  					}else{
	  						alert("데이터를 가져오는데 실패 하였습니다.");
	  					} 
	  				},
    			 
    			  error : function(){
  					alert("데이터를 가져오는데 실패 하였습니다.");
  			  		}
    			});
      	   
      		var tId = e.target.id;
              var idx = $("#"+tId+" option:selected").index();
              var subList =$("#"+tId).data().sub_data;
              
      	});
    	

    	
    	
    	
    	
		$("[name='stationGrpSeq']").val($("#stationGrpSlt").val());
    	
    	commonAjax.getCommonCode("GUG", 
    	    function(data){
    			if(data !== null && data.codeList !== null) {
    				for(var i = 0; i < data.codeList.length; i++){
	        			var $op = $("<option value='"+data.codeList[i].comCd+"'>"+data.codeList[i].comCdName+"</option>").appendTo('[name="stationGrpSlt"]');
    				}
    			}
    	});	
 
    	
    	$('#centerSlt').editableSelect()
			// 센터 id 가져오는 로직
			.on('select.editable-select', function (e,li) {
				//alert($('#centerSlt').siblings('.es-list').find('li.selected').attr('id'));
				//alert($('#centerSlt').siblings('.es-list').find('li.selected').attr('label'));
				
				$('#centerId').val($('#centerSlt').siblings('.es-list').find('li.selected').attr('id'));
				$("[name='takeId']").val($('#centerSlt').siblings('.es-list').find('li.selected').attr('label'));
	    		$("#takeNm").text($('#centerSlt').siblings('.es-list').find('li.selected').attr('label2'));   
					
				});
    	
    	function lpad(str, padLen, padStr) {
	       	 if (padStr.length > padLen) {
	            console.log("오류 : 채우고자 하는 문자열이 요청 길이보다 큽니다");
	            return str;
	        }
	        str += ""; // 문자로
	        padStr += ""; // 문자로
	        while (str.length < padLen)
	            str = padStr + str;
	        str = str.length >= padLen ? str.substring(0, padLen) : str;
	        return str;
	    }
    }
    
     repairBikeDetail.moveEditForm = function (e) {
    	e.preventDefault();
    	var pViewFlg = e.data.viewFlg;
    	//행갯수
    	var itemCnt = $("#example > tbody > tr").length;
    	var rowcount = 0;
    	var partsData = new Array(); //json
    	var bikeData = "";
    	
    	// 점포명 입력 확인
    	if($("#takeId").val() == '' || $("#centerId").val() == ''){
    		alert("점포명을 입력해 주세요.");
    		$("#centerSlt").focus();
    		return false;
    	}
    	
    	for(var i=0; i<itemCnt;i++){
    		
    		var tempRowspan = $("#example > tbody > tr:eq("+i+")").find("td:eq(0)").attr("rowspan");
    		var tempBike = "";
    		if(tempRowspan ==null ||tempRowspan =="") {
    			obj = new Object();
		    	obj['bikeNo'] = bikeData;
		    	obj['partsCode'] = $("#example > tbody > tr:eq("+i+")").find("td:eq(0)").find('option:selected').val();
		    	partsData[i] = obj;
		    	//alert("33"+bikeData);
    		} else {
    			obj = new Object();
    			bikeData = "BRC-"+lpad2( $("#example > tbody > tr:eq("+i+")").find("td:eq(0)").find('input[type="text"]').val(), 5, '0');
    			//alert($("#example > tbody > tr:eq("+i+")").find("td:eq(0)").find('input[type="text"]').val());
    			//alert(bikeData);
		    	obj['bikeNo'] = "BRC-"+lpad2($("#example > tbody > tr:eq("+i+")").find("td:eq(0)").find('input[type="text"]').val(), 5, '0');
		    	obj['partsCode'] = $("#example > tbody > tr:eq("+i+")").find("td:eq(1)").find('option:selected').val();
		    	partsData[i] = obj;
    		}
    		
    	} 
    	$('[name="partsData"]').val(JSON.stringify(partsData));
    	//alert("JSON.stringify(partsData)\n"+JSON.stringify(partsData));
    	
    	var uniqueParts = [];
    	var chkDup = 0;
    	$.each(partsData, function(i, item){
    		if($.inArray(JSON.stringify(item), uniqueParts) === -1){
    			uniqueParts.push(JSON.stringify(item));
    			//alert(JSON.stringify(item));
    		}else{
    			alert("중복된 값이 존재합니다.");
    			chkDup = 1;
    			return false;
    		}
    	});
    	
    	if(chkDup == 1){
    		return false;
    	}
    	
    	if ( confirm("등록 하시겠습니까?")) {
    		commonAjax.postAjax("/validationTransferBikeAjax.do", 'json', $("#transMallFrm").serialize()
          			, function(data){
          	        	if(data.resultMessage == 'Success'){
          	        		if(data.result =="1") {
	          	        		commonAjax.postAjax("/addTransferBikeAjax.do", 'json', $("#transMallFrm").serialize()
	          	            			, function(data){
	          	            	        	if(data.resultMessage == 'Success'){
	          	            	        		alert('완료되었습니다.');
	          	            	        		$("#repairOutsrcMainSeq").val(data.resultSeq);
	          	            	        		$('[name="partsData"]').val('');
	          	            	        		//$('#exeRepairBikeEdit').attr('disabled', false);
	          	            	        		//$("#frm").attr({method :"post", action :"/repairBikeMallList.do"}).submit();
	          	            	        	}else{
	          	            	        		alert('오류가 발생하였습니다.');
	          	            	        		//$('#exeRepairBikeEdit').attr('disabled', false);
	          	            	        	}
	          	  	              	}
	          	  	    	    );
          	        		} else {
          	        			alert('올바르지 않은 자전거번호가 있습니다.');
          	        		}
          	        	}else{
          	        		alert('에러가 발생 하였습니다.');
          	        		//$('#exeRepairBikeEdit').attr('disabled', false);
          	        	}
	              	}
	    	    );
    		
    	}
    	function lpad2(str, padLen, padStr) {
	       	 if (str.length > padLen) {
	            console.log("오류 : 채우고자 하는 문자열이 요청 길이보다 큽니다");
	            return str;
	        }
	        str += ""; // 문자로
	        padStr += ""; // 문자로
	        while (str.length < padLen)
	            str = padStr + str;
	        str = str.length >= padLen ? str.substring(0, padLen) : str;
	        return str;
	    }
 /*   	$("#searchFrm").attr({method : 'post', action : '/moveTransferBikeEditForm.do'}).submit(); */
    }; 
    
    repairBikeDetail.exeExcelFnc = function (e) {
    	var mainSeq = $("#repairOutsrcMainSeq").val();
    	if(mainSeq == null || mainSeq == ""){
    		alert("수리대상저장 후 인수인계증 출력이 가능합니다.");
    		return false;
    	}else{
    		$("#transMallFrm").attr({method : 'post', action : '/exeTransferBikeExcel.do'}).submit();
    		return false;
    	}
    }
    </script>
</body>
</html>