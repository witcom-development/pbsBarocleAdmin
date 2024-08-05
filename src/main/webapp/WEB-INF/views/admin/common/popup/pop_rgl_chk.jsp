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
<script type="text/javascript">
     if('${result}' === 'error') {
    	 alert('${resultMessage}');
    	 window.close();
     }
</script>
</head>
<body>
    <h1 class="popTt"></h1>
    <div class="cntbox">
        <div class="allwrap pop">
            <form id="frm">
                <input type="hidden" name="equipmentClsCd" value="${deviceType}">
                <input type="hidden" name="mode" value="${mode}">
                <input type="hidden" name="faultSeq" value="${faultSeq}">
	            <table class="tb_type02 mt20">
	                <colgroup>
	                    <col style="width:30%">
	                    <col style="width:70%">
	                </colgroup>
	                <tbody>
	                    <tr>
	                        <th class="top">유지보수 운영자</th>
	                        <td class="top">
	                            <select class="select-category02" id="adminSlt" name="adminId">
	                                <option value="">선택</option>
	                            </select>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>정기점검일</th>
	                        <td><span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name='chkDttm' value="${resultVo.chkDttm}" title="선택 날짜" id="bb22" readonly/></span></td>
	                    </tr>
	                    <tr>
	                        <th id="deviceClsName"></th>
	                        <td><span class="input-text01"><input type="text" readonly value="${equipmentId}"  name="equipmentId"/></span></td>
	                    </tr>
	                    <tr>
	                        <th>비고</th>
	                        <td><textarea name="comments" class="detatextarea" cols="100" rows="5">${resultVo.comments}</textarea></td>
	                    </tr>
	                </tbody>
	            </table>
	            <div class="btnArea">
	                <span class="right">
	                	<c:if test="${mode == 'U' || mode == 'M'}">
	                	<button class="btnType01" id="regularChkBtn">저장</button>
	                	</c:if>
	                	<button class="btnType01" id="cancelBtn">취소</button>
	                </span>
	            </div>
            </form>
        </div>
    </div>
    <a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function(){
    	//유지보수 운영자 콤보.
    	commonAjax.getAdminList("004","",
    			function(data) {
    		        if(data) {
    		        	if(data.userList.length > 0) {
    		        		var uSize = data.userList.length;
    		        		for(var i=0; i < uSize; i +=1) {
    		        			var userInfo = data.userList[i];
    		        			var userText = userInfo.usrId+"("+userInfo.usrName+")";
    		        			var $op = $("<option></option>", {"value" : userInfo.usrId}).text(userText);
    		        		    if('${resultVo.adminId}' !== "" && '${resultVo.adminId}' === userInfo.usrId ) {
    		        		    	$op.attr('selected', true);
    		        		    }
    		        			$("#adminSlt option").last().after($op);        			
    		        		}
    		        	}
    		        }
    		    }
    	);
    	var today = DateUtil.dateFmt(new Date());
    	if('${resultVo.chkDttm}' === '') {
    		$("[name='chkDttm']").val(today);
    	}
    	
    	setTitleName('${deviceType}');
    
    	$("#regularChkBtn").on("click", function(e) {
    	    e.preventDefault();
    	    if($("#adminSlt").val() === '') {
    	    	alert("운영자를 선택해 주세요.");
    	    	return false;
    	    }
    	    if(DateUtil.checkDateTerm(today, $("#bb22").val()) !== 'ok') {
    	    	alert("정기 점검일은 오늘 날짜보다 작을수 없습니다. .");
                return false;
    	    }
    		var ans = confirm("정기 점검일자를 등록 하시겠습니까?");
    		
    		
    		
    		if(ans) {
    		    commonAjax.postAjax("/common/pop/${deviceType}/regularChkupReg.do", "json", $("#frm").serialize()
    			    ,function(data){
    			        if(data) {
    			            if(data.checkResult > 0) {
	    			      	    if(opener) {
		    			      	    opener.setNewLastChkDttm($("[name='chkDttm']").val());
	    			      	    }
     			                window.close();
    			          } else {
    			              alert(data.resultMessage);
    			          }
    			          return false;
    			        }
    			    }
    			);
    		}
    	 });
    	 $("#cancelBtn").on("click", function(e) {
    		 e.preventDefault();
    		 window.close();
    	 });
    });
    
    function setTitleName(dType) {
    	var title ='';
    	if(dType === 'DEV_001') {
    		title = '자전거No';
    	} else if(dType === 'DEV_002') {
    		title = '단말기 ID';
    	} else if(dType === 'DEV_003') {
    		title = '무선AP ID';
    	} else {
    		title = '거치대 ID';
    	}
    	$("#deviceClsName").text(title);
    }
    </script>
    
</body>
</html>