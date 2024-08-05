<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
            <div class="shBox_pop">
                <div class="shBoxSection">
                <form id="searchFrm">
					<span class="section pwtableblock">
						<label for="usrName" class="laType02">센터명 </label>
						 <select	class="select-category03" id="centerId" name="centerId">
								<option value="">선택</option>
								<c:forEach var="result" items="${centerList}" varStatus="status">
									<c:if test="${inputFrm.centerId == result.comCd}">
										<option value="${result.comCd}" selected="selected"><c:out value="${result.comCdName}" /></option>
									</c:if>
									<c:if test="${inputFrm.centerId != result.comCd}">
										<option value="${result.comCd}"><c:out	value="${result.comCdName}" /></option>
									</c:if>
								</c:forEach>
						</select>
						</span>
					<span class="section pwtableblock">
	                    <label for="usrName" class="laType02">팀명 </label>
						<select class="select-category03" id="teamId"	name="teamId">
							<option value="">선택</option>
							<c:forEach var="result" items="${teamList}" varStatus="status">
								<c:if test="${inputFrm.teamId == result.comCd}">
								<option value="${result.comCd}" selected="selected"><c:out value="${result.comCdName}"/></option>
								</c:if>
								<c:if test="${inputFrm.teamId != result.comCd}">
								<option value="${result.comCd}" ><c:out value="${result.comCdName}"/></option>
								</c:if>
							</c:forEach>
						</select>
						<a href="#" class="btnType02" id="searchBtn">조회</a>
					</span>
				</form>
				</div>
            </div>
            <table class="tb_type01 mt20">
                <colgroup>
                    <col style="width:40%"/>
                    <col style="width:40%"/>
                    <col style="width:20%"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>센터명</th>
                        <th>팀명</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <div class="btnArea">
				<span class="right">
					<button id="confirmBtn" class="btnType01">확인</button>
					<button id="cancelBtn" class="btnType01">취소</button>
				</span>
			</div>
        </div>
    </div>
    <a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    
		$(function() {    	
	    	$('#searchBtn').on("click", searchTeam);
	    	$("#confirmBtn").on("click", function(e) {
	    	    e.preventDefault();
	            var adminId = $('[name="adminList"]').val();
	            opener.setAdminID(adminId, '');
	            window.close();
	    	});
		});
    	
    	 function searchTeam(e) {
			e.preventDefault();
    	    	e.stopPropagation();
    	    	$(".tb_type01 tbody").empty();
    	    	commonAjax.postAjax("/common/pop/findOutTeamInfo.do", "json", $("#searchFrm").serialize()
    	    			,function(data){
    	    		         if(data){
    	    		        	if(data.teamList != null) {
    	    		        	    var dSize = data.teamList.length;
    	    		        		if(dSize> 0) {
    	                                for(var i=0; i< dSize; i+=1) { 	

    	                                    var $td1 = $("<td>").text(data.teamList[i].centerNm);
    	                                    var $td2 = $("<td>").text(data.teamList[i].teamNm);
    	                                    var $td3 = $("<td>").append( $("<a>",{href :'#'}).text("선택").on("click", {faultSeq: ${faultSeq}, teamSeq: data.teamList[i].teamSeq},clickTeam));
    	                                	//var $td3 = $("<td>").append( $("<a>",{href :'#'}).text(data.teamList[i].teamSeq).on("click", {apId: data.teamList[i].apId, deviceStatusName: data.deviceList[i].deviceStatusName, stationName: data.deviceList[i].stationName},clickApId	 ));
    	                                	//var $td3 = $("<td>").append( $("<a>",{href :'#'}).text(data.teamList[i].teamSeq).on("click", {faultSeq: faultSeq, teamSeq: data.teamList[i].teamSeq},clickTeam));
    	                                    
    	                                    $(".tb_type01 tbody").append($("<tr>")).append([$td1,$td2,$td3]);
    	                                }
    	                            }
    	    		        	} else {
    	    		        		if(data.resultMessage !== '') {
    	    		        			alert(data.resultMessage);
    	    		        			return false;
    	    		        		} else {
    		                            $(".tb_type01 tbody").append($("<tr>")).append($("<td>", {'colspan' : 3}).text("no data"));
    	    		        		}
    	    		        		
    	                        }
    	    		        	
    	    		        	 
    	    		         }
    	    		   }
    	    	);
    	    	
    	    }
    	 
    	 function clickTeam(e) {
    	    	e.preventDefault();

    	    	var faultSeq = e.data.faultSeq;
    	    	var teamSeq = e.data.teamSeq;
    	    	
    	    	opener.setTeam(faultSeq, teamSeq);
		    	window.close();
    	    }	
    </script>
</body>
</html>