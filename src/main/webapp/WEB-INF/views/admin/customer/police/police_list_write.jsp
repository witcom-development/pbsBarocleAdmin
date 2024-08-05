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
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>

<script src="/js/select/jquery.styled-select-box_main.js"></script>
<link href="/css/jquery-ui.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/js/common_barocle.js"></script>

<style type="text/css">
	#ui-datepicker-div .ui-date-wrap{
		height: 260px;
	}
	.ui-datepicker-title select{
		line-height: 40px;
		height: 30px;
	}
	.ui-state-default{
		width:15px;
		border: 0px;
		background: transparent;
	}
	#ui-datepicker-div .ui-date-wrap {
		width: 300px;
	}</style>

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
						<form id="tx_editor_form" name="tx_editor_form">
							
							<!-- 목록 조회 파라미터용 -->
							
							<input type="hidden" id="searchStartDate" 	name="searchStartDate" 	value="${searchVo.searchStartDate}" />
							<input type="hidden" id="searchEndDate"	  	name="searchEndDate"   	value="${searchVo.searchEndDate}" />
							<input type="hidden" id="searchValue" 	  	name="searchValue"     	value="${searchVo.searchValue}" />
							<input type="hidden" id="stationId" 		name="stationId" 		value="${vo.stationId}"/>
							<input type="hidden" id="polReqSeq" 		name="polReqSeq"		value="${vo.polReqSeq}" />
							<input type="hidden" id="checkType" 		name="checkType"		value="${vo.checkType}" />
							
							<fieldset>
								<table class="tb_type02 mt20">
									<colgroup>
										<col style="width:25%"/>
										<col style="width:75%"/>
									</colgroup>
									<tbody>
										<tr>
											<th class="top">요청기관</th>
											<td class="top">
												<span class="input-text05"><input id="polReqInstitutionName" name="polReqInstitutionName" type="text" value="${vo.polReqInstitutionName}"/></span>
											</td>
										</tr>
										<tr>
											<th>문서 번호</th>
											<td>
												<span class="input-text05"><input id="polReqName" name="polReqName" type="text" value="${vo.polReqName}"/></span>
											</td>
										</tr>		
										<tr>
											<th>요청내용</th>
											<td>
												<span class="input-text05"><input id="polReqContent" name="polReqContent" type="text" value="${vo.polReqContent}"/></span>											
											</td>
										</tr>																									 																									 
										<tr>
											<th>선택 구분</th>
											<td>
											<!-- 대여소 선택 관련 -->
											<c:choose>
												<c:when test="${vo.checkType == 2}">
													<div style="float: left; width: 150px;">
														<div class="input-rd01">
															<input type="radio" id="e1" name="radioChkType4" value="1">
															<label for="b1">대여소 이름</label>
														</div>
														<br/>
														
								        				<script>$("select").styledSelect();</script>
								        				
								        				<div class="input-rd01">
								        					<input type="radio" id="e1" name="radioChkType4" value="2" checked="checked">
								        					<label for="b2">자전거 번호</label>
								        				</div>
											        </div>													
												</c:when>
												<c:otherwise>
													<div style="float: left; width: 150px;">
														<div class="input-rd01">
															<input type="radio" id="e1" name="radioChkType4" value="1" checked="checked">
															<label for="b1">대여소 이름</label>
														</div>
														<br/>
														
								        				<script>$("select").styledSelect();</script>
								        				
								        				<div class="input-rd01">
								        					<input type="radio" id="e1" name="radioChkType4" value="2">
								        					<label for="b2">자전거 번호</label>
								        				</div>
											        </div>													
												</c:otherwise>
											</c:choose>
										        
										        <div style="float: left;">
											        <div class="input-text13">
											        <input type="text" id="searchStationName" name="searchStationName" value="${vo.stationName}" title=" 대여소 입력" placeholder="대여소를  2자이상 입력하세요"></span>
							        				<input type="text" id="bikeNo" name="bikeNo" value="${vo.bikeNo}" title="자전거 번호 입력" placeholder="자전거 번호 5자리를 입력하세요" maxlength="5">
							        				</div>
	        									</div>
	        								<!-- 대여소 선택 관련  end -->
											</td>
										</tr>
										<tr>
											<th>검색 일자 </th>
											<td>
												<span class="selectDate input-datepick04">
													<input id="fromDate" name="fromDate" type="text" class="datepicker input-datepick04" title="선택 날짜" readonly="true" value="${vo.fromDate}"/>
												</span>	
												<span class="input-text05">
													<input style="width:30px" id="fromHour" name="fromHour" type="text" value="${vo.fromHour}" placeholder="시간"/>
												</span>	
													<span class="dash">~</span>
												<span class="selectDate input-datepick04">
													<input id="toDate" name="toDate" type="text" class="datepicker input-datepick04" title="선택 날짜" readonly="true" value="${vo.toDate}"/>
												</span>
												<span class="input-text05" style="width:30px">
													<input style="width:30px" id="toHour" name="toHour" type="text" value="${vo.toHour}"  placeholder="시간"/>
												</span>																				
											</td>
										</tr>																																			 
									</tbody>
								</table>
								<!-- 하단부 버튼 부분 -->
								<c:choose>
									<c:when test="${policeView.polReqSeq > 0}">
										<div class="btnArea">
											<span class="left"><button class="btnType01 bc_gray" id="movePoliceList"/>목록</button></span>
											<span class="right">
													<button class="btnType01" id="btn_delete" onclick="deleteContent">삭제</button>
													<button type="button" class="btnType01 bc_green" id="btn_excel">엑셀저장</button>
												<button type="button" class="btnType01 bc_green" id="btn_update">수정</button>
											</span>
										</div>											
									</c:when>
									<c:otherwise>
										<div class="btnArea">
											<span class="left"><button class="btnType01 bc_gray" id="movePoliceList"/>목록</button></span>
											<span class="right">
												<button type="button" class="btnType01 bc_green" id="btn_save">저장</button>
											</span>
										</div>									
									</c:otherwise>
								</c:choose>

							</fieldset>
						</form>
					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		
		<form id="form_saveId" name="form_saveId">
			<!-- 목록 조회 파라미터용 -->
			<input type="hidden" id="polReqSeqNew" 		name="polReqSeq"		value="${vo.polReqSeq}" />
			<input type="hidden" id="viewFlg" 	        name="viewFlg" 		    value="${vo.viewFlg}"/>
		</form>
		
		<!-- ================================================== Start: Saving Contents ================================================== -->
		<script type="text/javascript" src="/js/common_barocle.js"></script>
		<script type="text/javascript">

		
			var policeInsert = {};
			var autocompleteStationName = new Array();
			
			$( function() {	
				policeInsert.initBtn();
			});
			
			policeInsert.initBtn = function(){
				// 대여소 조회버튼 클릭시
				$("#searchStationName"         ).on("click", this.searhText);
				//저장 버튼 클릭시
				$('#btn_save'		           ).on("click", this.saveContent);
				//목록 버튼을 누르면 동작하는 부분
				$("#movePoliceList"	           ).on("click", this.movePoliceList);
				//엑셀저장 버튼을 누르면 동작하는 부분
				$("#btn_excel"                 ).on("click", this.movePoliceExcelList);
				// 대여소 초기 데이터 세팅
				policeInsert.stationInitData();
				// 대여소 선택 구분자 이벤트	
				$('input[name="radioChkType4"]').on("change", this.parameterSelect);
				//삭제 버튼 누르면 동작하는 부분
				$("#btn_delete"                ).on("click"	, this.deleteContent);
				//수정버튼 눌렀을 때 동작하는 부분
				$("#btn_update"                ).on("click"	, this.updateContent);
			}
	
			policeInsert.stationInitData = function(){	
				// 대여소 초기 조회
		    	commonAjax.getAjax("/common/pop/findStationAllInfo.do", "json", $("#frm").serialize()
		               ,function(data){
		    		
		    		
		   		           if(data != null && data.stationList != null) {
		   					for( var i in data.stationList ) {
		   						
		   						var stationName = data.stationList[i].stationName;
		   						if(stationName.indexOf("3거리") > -1){
		   							stationName = stationName.replace("3거리","삼거리");
		   							
		   						}
		   						if(stationName.indexOf("4거리") > -1){
		   							stationName = stationName.replace("4거리","사거리");
		   						}
		            			autocompleteStationName.push(
		            						{
		            							label : stationName,
		            							stationId : data.stationList[i].stationId,
		            							teamNm : data.stationList[i].teamNm
		            						}
		            			);
		            		}
		                   }          
		                }
		         );
			}	
			
			// 대여소 선택 구분자 이벤트	
	    	policeInsert.parameterSelect = function(){	
				
				$('input[name="radioChkType4"]').each(
						function() {
			    			if( !  $(this).prop('checked')) return;
			   				if( $(this).val() == "1"){
			   					$("#bikeNo").val('');
			   				} else if( $(this).val() == "2"){
			   					$("#searchStationName").val('');
			   					$("#stationId").val('');
			   				}
	    				}
				);
				
	    	};
			
			
	    	policeInsert.movePoliceList = function(){	
				//PK초기화
				$("#polReqSeq").val("");
				//다시 목록 페이지로 돌아가기
				$("#tx_editor_form").attr( {method :"get", action :"/admin/customer/police/policeList.do"} ).submit();
			}

	    	
	    	policeInsert.saveContent = function(){	
				 if( !validForm() ) return false;
				// 저장 실행
				commonAjax.postAjax("/admin/customer/police/policeInsert.do", 'json', $("#tx_editor_form").serialize()
						, function(data){
					 		if( data.resultMessage == "Success" ) {
					 			alert("정상 저장되었습니다")
					 			$("#polReqSeq").val(data.newPolReqSeq);
					 			$("#polReqSeqNew").val(data.newPolReqSeq);
					 			//viewFlg를 R로 세팅해 주기
					 			$("#viewFlg").val('R');
					 			// 다시 상세보기 화면으로 리다이렉트
					 			$("#form_saveId").attr( {method :"get", action :"/admin/customer/police/policeListWrite.do"} ).submit();
					 			
					 		} else {
					 			alert("저장에 실패했습니다.")
					 		}
						}
				  );
			}
	    	
	    	policeInsert.deleteContent = function(){	
				// 삭제 실행
			    $("#tx_editor_form").attr( {method :"get", action :"/admin/customer/police/deletePolice.do"} ).submit();
			}
	    	 
	    	
	    	policeInsert.updateContent = function(){	
	    		// 수정 전에 밸리데이션을 먼저 체크 해 주기
				 if( !validForm() ) return false;
			    // 수정 
				commonAjax.postAjax("/admin/customer/police/updatePolice.do", 'json', $("#tx_editor_form").serialize()
						, function(data){
					 		if( data.resultMessage == "Success" ) {
					 			alert("수정 되었습니다")
					 			$("#polReqSeq").val(data.newPolReqSeq);
					 			$("#polReqSeqNew").val(data.newPolReqSeq);
					 			//viewFlg를 R로 세팅해 주기
					 			$("#viewFlg").val('R');
					 			// 다시 상세보기 화면으로 리다이렉트
					 			$("#form_saveId").attr( {method :"get", action :"/admin/customer/police/policeListWrite.do"} ).submit();
					 			
					 		} else {
					 			alert("수정에 실패했습니다.")
					 		}
						}
				  );
			}
			

			// 자동 조회
			policeInsert.searhText = function(e){
				
				e.preventDefault();
				
				$("#searchStationName").autocomplete({
		        	 source : autocompleteStationName 
		        	,matchContains: true
			        ,selectFirst: false
			        ,minLength: 2
			        ,autoFocus:true
			        , select : function(e, ui, data ){
			        	$("input:hidden[name='stationId']").val(ui.item.stationId);
			        }
					,  close : function(event) { // 자동완성 창 닫아질 때의 이벤트
			            console.log(event);
			        }
			    });
		    }		
			
			
			policeInsert.movePoliceExcelList = function(){	
				$("#tx_editor_form").attr( {method :"get", action :"/admin/customer/police/policeListWriteExcel.do"} ).submit();
			}
			
				
			function validForm() {
				var regexp = /^[z0-9]*$/;
				
				if( !_nullCheck( "#polReqInstitutionName" 	,"기관명" 	) ) return false;
				if( !_nullCheck( "#polReqName" 				,"요청자 성명"  ) ) return false;
				if( !_nullCheck( "#polReqContent" 			,"요청내용" 	) ) return false;
				if( $("input[name='radioChkType4']:checked").val() == 1 ){
					if( !_nullCheck( "#stationId" 				,"대여소 이름"  ) ) return false;
				}else{
					if( !_nullCheck( "#bikeNo" 					,"자전거 번호"  ) ) return false;
					
					if( regexp.test($("#bikeNo").val()) == false ) {
						alert("숫자만 입력 해 주세요.");
						return false;
					}
					if($("#bikeNo").val().toString().length < 5){
						alert("5자리 숫자를 입력 해 주세요");
						return false;
					}
				} 
				if( !_nullCheck( "#fromDate" 				,"검색 시작일"  ) ) return false;
				if( !_nullCheck( "#toDate" 					,"검색 종료일"  ) ) return false;
		        if( DateUtil.diffDays( $( "[name='fromDate']").val(),  $( "[name='toDate']").val() , "-" ) > 2 ) {
		        	alert("기간은 최대 2일만 가능합니다.")
			        return false;
		        }		
		        
				if( DateUtil.diffDays( $("#fromDate").val(),  $("#toDate").val() , "-" ) < 0 ) {
		        	alert("종료일이 시작일보다 빠를 수 없습니다")
			        return false;
		        }
				
				if( !_nullCheck( "#fromHour" 				,"시작 시간" 	) ) return false;
				
				if(regexp.test($("#fromHour").val()) == false){
					alert("숫자로 입력 해 주세요");
					return false;
				}
				
				if($("#fromHour").val() < 0 || $("#fromHour").val() > 24 ){
					alert("시간은 0 ~ 24 로 입력 해 주세요");
					return false;
				}
				
				if( !_nullCheck( "#toHour" 					,"종료 시간" 	) ) return false;
				
				if(regexp.test($("#toHour").val()) == false){
					alert("숫자로 입력 해 주세요");
					return false;
				}
				if($("#toHour").val() < 0 || $("#toHour").val() > 24 ){
					alert("시간은 0 ~ 24 로 입력 해 주세요");
					return false;
				}
				if( DateUtil.diffDays( $("#fromDate").val(),  $("#toDate").val() , "-" ) == 0){
					if( parseInt( $("#toHour").val() , 10 ) - parseInt( $("#fromHour").val() , 10 )  <= 0 ){ 
						alert("종료 시간이 시작 시간보다 빠를 수 없습니다")
				        return false;
					}
				}

				return true;
			}	 
			
			
			var isEmpty = function(value){ if( value == "" || value == null || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length ) ){ return true }else{ return false } };
				
			//id의 값이 없으면  "title 을 입력해 주세요."
			function _nullCheck( id , title ) {
				if( isEmpty( $( id ).val() ) ) {
					$( id ).focus();
					alert( title + "을 입력해 주세요.");
					return false;
				}
				return true;
			}
			
			
		</script>
		<!-- ================================================== End: Saving Contents ================================================== -->
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>
