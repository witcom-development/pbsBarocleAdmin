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

<!-- 
	개발일시 : 2020-09-14
	개발자   : 김시성
	내용     : 관리자 문자 발송
	TODO : 
	ASIS : 문자 전송방식에 따라 발송구분 동적 생성 구현 - 2020-09-18
	
	       필요없는 그룹 제거 (쿼리에서 작업) - 2020-09-23
	       
	       그룹선택 시 전체선택 박스 초기화 처리 - 2020-09-23
	        
	       그룹선택 마우스 포인터, 선택 시 border 효과 처리 - 2020-10-05
	       
	       발송구분 선택 시 제목 발송구분명으로 자동등록 - 2020-10-22
	       
	       선택한 관리자명 나열 제거 - 2020-10-22
	       
	       전송확인 시 선택한 관리자명 나열 제거 - 2020-10-22
	       
	       그룹선택 더블클릭을 클릭으로변경 - 2020-10-22
	       
	       그룹이동 시 선택한 관리자 초기화 - 2020-10-22
	       
	       그룹 순서 강제로 변경 - 2020-10-22
	       
	       발송자 번호 추가 - 2020-10-23
	       
	       
	       
 -->
<style>

#groupListBody {cursor:pointer}

</style>
</head>
<body>
	<div class="allwrap">
		<!--모바일 메뉴 S-->
			
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
						<form id="frm" accept-charset="utf-8"  onsubmit="return false;">
        					<input type="hidden"  name="reqResDate" id="reqResDate" value=""/>
        					<input type="hidden"  name="adminId" id="adminId" value="<%= com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrId") %>" />
        					<input type="hidden"  name="adminIdArr"   id="adminIdArr" type="text" maxlength="11" style="IME-MODE: disabled" >
        					
        					<input type="hidden"  name="yyyy" id="yyyy" value=""/>
        					<input type="hidden"  name="mm" id="mm" value=""/>
        					<input type="hidden"  name="dd" id="dd" value=""/>
        					<input type="hidden"  name="hh" id="hh" value=""/>
        					<input type="hidden"  name="ss" id="ss" value=""/>
        					
							<fieldset>
								<br>
								<h2>대상 선택하기</h2>
								<br>
								<em>그룹 선택</em>
								<table class="tb_type02" style="width:99%;">
									<tbody id="groupListBody" onselectstart="return false" ondragstart="return false">
									
										<c:set var="cntList" value="0" />									
										<c:forEach var="result" items="${groCodeList}" varStatus="status">
											
											<c:if test="${cntList eq 0 }">
												<tr>
											</c:if>
											
											<td grpCd='${result.usrGrpCd}' style="padding:2px; text-align:center;" >${result.grpName}</td>
												
											<c:if test="${cntList eq 4}">	
												</tr>
											</c:if>
											
											<c:set var="cntList" value="${cntList + 1}" />
											<c:if test="${cntList eq 5 }">
												<c:set var="cntList" value="0" />
											</c:if>
										</c:forEach>
										
									</tbody>
								</table>
								
								<br>
								
								<div style="width:99%;">
									<em>관리자 선택</em>
									&nbsp;
									<span id="grpSpan"></span>
									<span style="float: right; margin-left:5px;">
										<span>관리자 검색 :</span>
										<input id="adminSearch" type="text" style="height:20px;" />
									</span>								
									<span style="float: right;">
										<span>전체선택 : </span>
										<input id="allChkBoxAdmin" type="checkbox" />
									</span>
								</div>
								
								<div style="width:98%; height:250px; overflow:auto; padding:3px; border:solid 2px;">
									<div id="adminListBody">
									
										<c:forEach var="result" items="${usrList}" varStatus="status">
										
											<div class="col-md-3 py-1 mx-0 px-0 input-ck02 text-left" style="display: none;">
												<input class="chkBoxAdmin" type="checkbox" grpCd="${result.usrGrpCd}" id="ra${status.index}" value="${result.usrId}"/><label class="labelAdmin" for="ra${status.index}">${result.usrName}</label>
											</div>
													
										</c:forEach>
										
									</div>
								</div>
								
								<br>
								
								<em>선택한 관리자</em>&nbsp;<span id="checkedAdminNamesCnt" style="margin-left:5px;">0</span>명
								
								<br>
								<br>
								
								<h2>내용 작성하기</h2>
								
								<br>
								
		                        <em>예약발송</em>
		                        
		                        <br>
		                        
		                        <div class="section pright" style="margin-top: 5px;">
	                            <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04"  title="선택 날짜" id="datepicker" readonly/></span>
	                            <span>
	                                <select name="reqHour" id="reqHour">
	                                    <option value="">선택</option>
	                                    <c:forEach begin="1" end="24" step="1" varStatus="loop">
	                                        <c:if test="${loop.index < 10 }">
	                                        <option value="0${loop.index }" >0${loop.index }</option>
	                                        </c:if>
	                                        <c:if test="${loop.index > 9 }">
	                                        <option value="${loop.index }">${loop.index }</option>
	                                        </c:if>
	                                    </c:forEach>                  
	                                </select>시
	                                <select name="reqMinute" id="reqMinute">
	                                    <option value="">선택</option>
	                                    <c:forEach begin="0" end="59" step="1" varStatus="loop">
	                                        <c:if test="${loop.index < 10 }">
	                                        <option value="0${loop.index }" >0${loop.index }</option>
	                                        </c:if>
	                                        <c:if test="${loop.index > 9 }">
	                                        <option value="${loop.index }">${loop.index }</option>
	                                        </c:if>
	                                    </c:forEach>
	                                </select>분
	                            </span>
	                            </div>
								
								<br>
								
								<em>발송자 번호 </em>
								<br>
								<input id="reqSendAdmTelNo" name="reqSendAdmTelNo" type="text" value="${sendTelNo}" />
								<br>
								
								<br>
								
								<em>제목작성 </em>
								<br>
								<input id="reqTitle" name="reqTitle" type="text" style="width:97%;">
								<br>
								
								<br>
								
								<em>발송구분</em>								
								<div>
		                           	<select id="sendClsSlt" name="sendClsName" >
		                            	<option value="">선택</option>
		                            </select>
								</div>
								
								<br>
								
								<span>문자 전송방식 :</span>
								<span class="input-rd01"><input type="radio" name="reqSendType" id="a3" value="001" checked="checked"><label for="a3">문자</label></span>
								<!-- <span class="input-rd01"><input type="radio" name="reqSendType" id="ab3" value="002"><label for="ab3">카카오톡</label></span> -->
								
								<textarea id="reqContent" name="reqContent" class="detatextarea" style="margin-top:5px; width:98%; resize: none;"></textarea>
								
								<br>
								
								<div class="btnArea">
									<button class="btnType01 bc_green" onclick="return saveContent();">전송</button>
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
		$(function(){
			
	    	 var date = new Date();
	    	 var yyyy = date.getFullYear();		//년
	    	 var mm = date.getMonth()+1;		//월
	    	 var dd = date.getDate();			//일
	    	 var hh = date.getHours();			//시간
	    	 var ss = date.getMinutes();		//분
	    	 
	    	 
	    	$("#yyyy").val(yyyy);
	    	$("#mm").val(mm);
	    	$("#dd").val(dd);
	    	$("#hh").val(hh);
	    	$("#ss").val(ss);
	    	
	    	$("#adminSearch").attr("readonly",true);
	    	$("#allChkBoxAdmin").attr("disabled","disabled");
			
	    	// 예약 날짜가 null 이면 시간 설정 못하게 막음.
	    	if($("#datepicker").val() == '') {
	    		$("#reqHour").attr("disabled", "disabled");
	    		$("#reqMinute").attr("disabled", "disabled");
	    	}

	    	//발송구분 콤보박스 데이터
	        commonAjax.getAjax("/common/pop/getSmsMessageList.do", "json",{},makeSmsSelect);
	    	
	    	//발송구분(selectbox) 변경시 
	        $("#sendClsSlt").on("change", sendCdSltChange);
	    	
	      	//날짜 입력시
	        $("#datepicker").on("change", sendDateAdd);
	    	
			//전체선택 박스 클릭 시
			$("#allChkBoxAdmin").change(function(){
				
				allChkBoxAdmin($(this).is(":checked"));
				
			})
			
			//문자 전송방식 변경 시
			$("[name='reqSendType']").change(function(){
				
				var Yn = ""
				
				if($(this).val() === "001") Yn = "N";
				else if($(this).val() === "002") Yn = "Y";
				
				sendTypeChange(Yn);
				
			}); 
			
			// 발송구분 선택후 발송내역 전체 삭제시 selectBox 초기화 한다.
		    $('#sendMsg').keyup(function () {
		
		    	var inputLength = $(this).val().length;
		    	
		    	if(inputLength == 0 ){
		    		$('#sendClsSlt').find('option:first').attr('selected', 'selected'); 
		    	}
		
		    });
			
			$("#groupListBody td").each(function(index,item){//그룹선택 더블클릭 이벤트리스너 등록
				
				var groupCode = $(this).attr('grpCd');
				
				$(this).click(function() {
					
					changeClickAdminList(groupCode);
					
				});
				
			})
			
			$("input:text").focusout(function(){//포커스를 잃으면 border를 지움
				
				$(this).css("border","");
				
			});
			
			$("input:text").on("click",function(){//클릭하면 border를 씌움
				
				var readonly = $(this).attr("readonly");
				if(typeof readonly == "undefined") $(this).css("border","1px solid");
				
			});
			
			$("input:checkbox").on("change",function(){//관리자를 선택할 때 마다 선택 된 관리자들을 보여준다.
				
				addChkAdmNamesHtml($(this),"checkedAdminNames");
				
			});
			
			
			$("#adminSearch").on('keypress.one',function(e){
				
				var content = $(this).val();
				
				
				if(!e.keyCode) {// 백스페이스로 지웠을때 공백 즉 뭔가 검색했다가 지웠을 때
					
					if(content == ""){
						
						if(smsAdmin.lastGrpCd != null) changeAdminList(smsAdmin.lastGrpCd);
						else{
							
							$(".labelAdmin").each(function(){
								
								$(this).parent().show();
								
							});
							
						}
						
					}
					
				}
				
			}).on('keyup',function(e){
				
				if(e.keyCode==8) {
					$('#adminSearch').trigger('keypress.one');
				}
				
			});
			
			$("#adminSearch").keyup(function(e){//한글은 keypress가 먹히지않기때문에 keyup으로 처리
				var content = $(this).val();
				
					if(content != ""){
						
						if(smsAdmin.lastGrpCd != null) {
							
							changeAdminList(smsAdmin.lastGrpCd);
							changeAdminSearch(content);
							
						}else{
							
							$(".labelAdmin").each(function(){
								
								$(this).parent().show();
								
							});
							
						}
						
					}
				
			})
			
		})
		
		
		var smsAdmin = {};
		smsAdmin.lastGrpCd = null;	  //그룹선택 그룹번호 저장하는 변수 - search에서 사용
		smsAdmin.adminIdArr = null; //관리자 아이디 담을 변수
		smsAdmin.adminNamesArr = []; //관리자 이름 담을 변수
		
		function changeClickAdminList(groupCode){
     
				if(smsAdmin.lastGrpCd == null){				
			
				$(".chkBoxAdmin").each(function(index,item){
					
					$(this).parent().hide();
					
					var usrGrpCd = $(this).attr('grpCd');
					
					if(groupCode == usrGrpCd) {
						
						$(this).parent().show();
						
					}
					
				})
				
				$("#groupListBody td").each(function(){
					
					$(this).css('background-color','');
					$(this).css('color','');
								
					if($(this).attr('grpcd') == groupCode) {
						
						$("#grpSpan").html($(this).html());
						checkGrpName($(this).html());
						
						$(this).css('background-color','#3e9a62');
						$(this).css('color','white');
						
					}
								
				})
				smsAdmin.lastGrpCd = groupCode;
				
			}else{
				
				if(smsAdmin.lastGrpCd == groupCode){

<%--
					$(".chkBoxAdmin").each(function(index,item){
						
						$(this).parent().show();
						
					})
					
					smsAdmin.lastGrpCd = null;
					$("#grpSpan").html("전체");
					checkGrpName("전체");
					
					$("#groupListBody td").each(function(){
						
						if($(this).attr('grpcd') == groupCode){
							
							$(this).css('background-color','');
							$(this).css('color','');
							
						}
								
					}) 
--%>
					
				}else{
					
					$("#allChkBoxAdmin").prop("checked","");
					
					$(".chkBoxAdmin").each(function(index,item){
						
						$(this).prop("checked","");
						addChkAdmNamesHtml($(this),"checkedAdminNames");
						
						$(this).parent().hide();
						
						var usrGrpCd = $(this).attr('grpCd');
						
						if(groupCode == usrGrpCd) {
							
							$(this).parent().show();
							
						}
						
					})
					
					$("#groupListBody td").each(function(){
						
						$(this).css('background-color','');
						$(this).css('color','');
								
						if($(this).attr('grpcd') == groupCode){
							
							$("#grpSpan").html($(this).html());
							checkGrpName($(this).html());
							
							$(this).css('background-color','#3e9a62');
							$(this).css('color','white');
							
						}
								
					})
					
					smsAdmin.lastGrpCd = groupCode;
					
				}
				
			}
			
			
		}
		
		function changeAdminList(groupCode){									
				
			$(".chkBoxAdmin").each(function(index,item){
				
				$(this).parent().hide();
				
				var usrGrpCd = $(this).attr('grpCd');
				
				if(groupCode == usrGrpCd) {
					
					$(this).parent().show();
					
				}
				
			})
			
		}
		
		function changeAdminSearch(item){
			
			if(item != "" && smsAdmin.lastGrpCd != null){
		
				$(".labelAdmin:visible").each(function(){
					
					var adminName = $(this).text();
						
					if(adminName.indexOf(item) == -1){
						
						$(this).parent().hide();
						
					}else {
						
						$(this).parent().show();
						
					}
						
				});
			
			}
			
		}
		
		function allChkBoxAdmin(check){
			
			$(".chkBoxAdmin:visible").each(function(index,item){
				
				$(this).prop("checked",check);
				
				addChkAdmNamesHtml($(this),"checkedAdminNames");
				
			})				
			
		}
		
		function saveContent(){

			var adminIdArr = selectCheckAdminId();
			
			var str = $('#reqContent').val();
			
			if(adminIdArr.length === 0) {
				
				alert("대상을 선택하세요.");
				return true;
				
			}
			
			if(str === ""){
				
				alert("내용을 입력하세요.");
				return true;
				
			}

			if(adminIdArr.length > 0 && ( str !== "" && str !== 'undefined' ) ){
				
				smsAdmin.adminIdArr = [];
				for(var i =0 ; i < adminIdArr.length; i++){
					
					if( (i+1) == adminIdArr.length ){
						
						smsAdmin.adminIdArr.push(adminIdArr[i].adminId);
						
					}else{
						
						smsAdmin.adminIdArr.push(adminIdArr[i].adminId);
							
					}
					
				}
				
				var confirmVal = confirm(adminIdArr.length+"명 에게 전송 하시겠습니까?");
				
				if(confirmVal){
					
			    	var chk = 0;
			    	var reqResDate ='';
			    	
			    	//예약 날짜만 있을 경우
			    	if($("#datepicker").val() !== '') {

				    	if(($("[name='reqHour']").val() === '' &&  $("[name='reqMinute']").val() !== '') 
				    			|| ($("[name='reqHour']").val() !== '' &&  $("[name='reqMinute']").val() === '') 
				    			|| ($("[name='reqHour']").val() === '' &&  $("[name='reqMinute']").val() === '') ) {
				    	    alert("발송 예약 시간을 설정해주십시오."); 
				    	    chk = 1;
				    		return false;
				    	}
				    	reqResDate = $("#datepicker").val()+' '+$("[name='reqHour'").val()+':'+$("[name='reqMinute'").val();
				    	
				    	// 금일 이전 예약 설정 체크.
				    	var reqdt = $("#datepicker").val().replace(/-/gi,'')+$("[name='reqHour'").val()+$("[name='reqMinute'").val();
				    	var ymdhs = $("#yyyy").val()+$("#mm").val()+$("#dd").val()+$("#hh").val()+$("#ss").val();

				    	if(parseInt(reqdt) <= parseInt(ymdhs)){
				    		alert("예약 시간을 현재시간 이후로 설정해주십시오."); 
				    		chk = 1;
				    		return false;
				    	}
				    	
			            $("[name='reqResDate']").val(reqResDate);
				    	
			    	} else {

			    		  if($("[name='reqHour']").val() !== '' &&  $("[name='reqMinute']").val() !== '') {
			                  alert("발송 예약 시간을 설정해주십시오."); 
			                  chk = 1;
			                  return false;
			              }
			    	}
			    	
					//발송자 번호 필수처리
					if($("[name='reqSendAdmTelNo']").val() === ""){
						
						alert("발송자 번호를 입력하세요."); 
		                chk = 1;
		                return false;
						
					}
					
			    	//전송방식이 카카오톡이라면
			    	if($("[name='reqSendType']:checked").val() === "002"){
			    		
			    		if($("[name='sendClsName']").val() !== ""){
			    			
			    			$("[name='reqSendType']").val($("[name='sendClsName']").val());
			    			console.log($("[name='reqSendType']").val());
			    		}else{
			    			
			    			alert("전송방식이 카카오톡일 경우 발송구분을 선택하세요.");
			    			chk = 1;
			    			return false;
			    			
			    		}
			    		
			    	}else if($("[name='reqSendType']:checked").val() === "001"){
			    		
			    		$("[name='reqSendType']").val("");
			    		
			    	}
			    	
			    	$("#adminIdArr").val(smsAdmin.adminIdArr);
			    	
			    	if(chk === 0) {
			    		
				    	 commonAjax.postAjax("/admin/system/sms/reqSendAdminSms.do", "json",$("#frm").serialize(),function(data){
			    		     
				    		 if(data) {
				    			 
			    		    	 if(data.checkResult) {
			    		    		 
			    		    		 alert("전송 되었습니다.[" +  data.checkResult +"]" );
			    		    		 document.location.reload();
			    		    		 
			    		    	 }
			    		    	 
			    		     }
				    		 
				    	});
				    	 
			    	}
					
				}
				
			}				
		}
		
		//선택된 관리자 아이디들을 리턴
		function selectCheckAdminId(){
			
			var resultArr = [];
			
			$(".chkBoxAdmin:checked").each(function(index,item){
				
				var obj = new Object();
				obj.adminId = $(this).val();
				obj.adminName = $(this).parent().children( '.labelAdmin' ).text();
				resultArr.push(obj);
				
			})				
			
			return resultArr;
		}
		
		/*
		 * param1 : checkbox - $(this)
		 * param2 : element  - 이름 나열할 element ID
		 * 
		 * param1 으로 받은 체크박스를 이용하여 param2 으로 받은 element id에다가 선택 된 관리자 이름들을 나열 - 2020.10.22 : 이름나열 제거
		 */
		function addChkAdmNamesHtml(item,eid){
			
			var id = $(item).attr("id");
				
			if(id == "allChkBoxAdmin");
			else{
			
				var check = $(item).is(":checked");
				
				if(check){
					
					var idx = smsAdmin.adminNamesArr.indexOf( $(item).parent().children(".labelAdmin").html() ); 
					
					if (idx == -1) smsAdmin.adminNamesArr.push($(item).parent().children(".labelAdmin").html());
					
				}else{
					
					var idx = smsAdmin.adminNamesArr.indexOf( $(item).parent().children(".labelAdmin").html() ); 
					
					if (idx > -1) smsAdmin.adminNamesArr.splice(idx, 1)

				}
				
				var lng = smsAdmin.adminNamesArr.length;
				
				if(lng > 0){}else{
					
					$("#allChkBoxAdmin").prop("checked","");
					
				}

				$("#"+eid+"Cnt").html(lng);
				
			}				 
			 
		 }
		
    	//그룹이 전체일때는 검색못하게
    	function checkGrpName(grpName){
    		
    		if(grpName == "전체") {
    			
    			$("#adminSearch").attr("readonly",true);
    			$("#allChkBoxAdmin").attr("disabled","disabled");
    			
    			
    		}else{ 
    			
    			$("#adminSearch").removeAttr("readonly");
    			$("#allChkBoxAdmin").removeAttr("disabled");
    			
    		}
    		$("#adminSearch").val("");
    	};
		
	    //발송구분 변경시
	    function sendCdSltChange(e) {
	    	e.preventDefault();
	    	var msg = $(e.target).find("option:selected").attr("msg");
	    	var title = $(e.target).find("option:selected").text();
	    	if(msg == null){
	    		$("#reqContent").text('');
	    		$("#reqTitle").val('');
	    	}else{
	    		$("#reqContent").text(msg);
	    		$("#reqTitle").val(title);
	    	}
	    	
	    }
	    
	    //문자 전송방식 변경시
	    function sendTypeChange(Yn){
	    	
	    	$("#sendClsSlt option").remove();
	    	$("#sendClsSlt").append("<option value>선택</option>");
	    	
	    	//발송구분 콤보박스 데이터
	        commonAjax.getAjax("/admin/system/sms/getAdminSmsTpl.do", "json",{autoSendYn : Yn},makeSmsSelect);
	    	
	    }
	    
	    //예약날짜 입력시
	    function sendDateAdd(e) {
	    	e.preventDefault();
	    	
	    	$('#reqHour').removeAttr("disabled"); 
			$('#reqMinute').removeAttr("disabled"); 
	    }
	    
	    //화면 초기시 발송구분 selectList
	    function makeSmsSelect(data) {
	    	if(data) {
	    		if(data.smsMsgList !== null) {
	    			
	    			var mSize = data.smsMsgList.length;
	    			
	    			for(var i=0; i<mSize; i+=1) {
	    				
	    				var $op = $("<option>", { value : data.smsMsgList[i].smsSeq, msg :data.smsMsgList[i].smsMsg }).text(data.smsMsgList[i].sendClsName);
	    				$("#sendClsSlt > option").last().after($op);
	    				
	    			}
	    			
	    		}
	    	}
	    }
		
	</script>
	
</body>
</html>
