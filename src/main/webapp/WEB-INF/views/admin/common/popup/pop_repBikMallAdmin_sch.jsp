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
					<span class="section pwtableblock">
						<label for="usrGrpCd" class="laType02">구분</label>
						<select class="" id="usrGrpCd" >
							<option value="004">바로클포 관리자</option>
						</select>
					</span>
					<span class="section pwtableblock">
                        <label for="usrName" class="laType02">이름</label>
                        <span class="input-text02"><input type="text" id="usrName" /></span>
						<a href="#" class="btnType02" id="searchBtn">조회</a>
                    </span>
				</div>
            </div>
            <select class="longselect" style="width:100%" name="adminList" size="10">
            </select>
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
    	var usrGrpCd = '${userMgmtVo.usrGrpCd}' !== '' ? '${userMgmtVo.usrGrpCd}' : '';
    	var usrName = '${userMgmtVo.usrName}' !== '' ? '${userMgmtVo.usrName}' : '';
    	$('#usrGrpCd').val(usrGrpCd);
    	commonAjax.getRepBikeAdminList(usrGrpCd, usrName,
       		function(data) {
    			if(data !== null && data.userList !== null) {
    	        	var uSize = data.userList.length;
    	        	for(var i=0; i < uSize; i +=1) {
	    	        	var userInfo = data.userList[i];
	    	        	var userText = userInfo.usrId+"("+userInfo.usrName+")";
	    	        	var $op = $("<option value='"+userInfo.usrId+"'>"+userText+"</option>").appendTo('[name="adminList"]'); 
    	       		}
    		    }
        	}
    	);
    	
    	$('#searchBtn').on("click", getAdminList);
    	$("#confirmBtn").on("click", function(e) {
    	    e.preventDefault();
            var adminId = $('[name="adminList"]').val();
            opener.setAdminID(adminId);
            window.close();
    	});
    	
    	$("#cancelBtn").on("click", function(e) {
    		e.preventDefault();
    		window.close();
    	});
    });
    
    function getAdminList(e){
        e.preventDefault();
        
    	var usrGrpCd = $('#usrGrpCd').val();
    	var usrName = $('#usrName').val()
    	$('[name="adminList"]').empty();
    	commonAjax.getRepBikeAdminList(usrGrpCd, usrName,
          	function(data) {
       			if(data !== null && data.userList !== null) {
       	        	var uSize = data.userList.length;
       	        	for(var i=0; i < uSize; i +=1) {
	       	        	var userInfo = data.userList[i];
	       	        	var userText = userInfo.usrId+"("+userInfo.usrName+")";
	       	        	var $op = $("<option value='"+userInfo.usrId+"'>"+userText+"</option>").appendTo('[name="adminList"]');  
       	       		}
       			}
           	}
       	);
    }
    
    </script>
</body>
</html>