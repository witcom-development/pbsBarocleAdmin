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
	    <form id="frm">
	        <input type="hidden" name="penaltySeq"  value="${penaltyVo.penaltySeq}">
	        <input type="hidden" name="rentHistSeq" value="${penaltyVo.rentHistSeq}">
	        <input type="hidden" name="menuType"    value="${penaltyVo.menuType}">
	        <input type="hidden" name="viewType"    value="${penaltyVo.viewType}">
	        <input type="hidden" name="usrSeq"     value="${penaltyVo.usrSeq}">
	        <div class="allwrap pop">
	            <table class="tb_type02 mt20">
	                <colgroup>
	                    <col style="width:30%">
	                    <col style="width:70%">
	                </colgroup>
	                <tbody>
	                    <tr>
	                        <th class="top">벌점</th>
	                        <td class="top">
	                            <select  id="penaltyCdSlt" name="penaltyCd">
	                                <option value="">전체</option>
	                            </select>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>사유</th>
	                        <td><textarea name="penaltyDesc" class="detatextarea">${penaltyInfo.penaltyDesc}</textarea></td>
	                    </tr>
	                </tbody>
	            </table>
	            <div class="btnArea">
	                <span class="right"><button class="btnType01" id="editBtn"></button><button class="btnType01" id="cancelBtn">취소</button></span>
	            </div>
	        </div>
	    </form>
    </div>
    <a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function(){
    	//viewType에 따라 버튼 텍스트가 변경.
        var btnTxt =  '${penaltyVo.viewType}' === "insert" ? "저장" :"삭제";
        if('${penaltyVo.viewType}' === 'view') {
        	$("#editBtn").css("display","none");
        } else {
        	$("#editBtn").text(btnTxt);
        	$("#editBtn").on("click", exePenaltyEdit);
        	$("#cancelBtn").on("click", function(e) {
        		e.preventDefault();
        		window.close();
        	});
        }
    	var penalty = '${penaltyInfo.penaltyCd}';
        commonAjax.getPenaltyCode(function(data){
        	if(data) {
        		if(data.penaltyList.length > 0) {
        			var pSize = data.penaltyList.length;
        			for(var i= 0; i<pSize; i+=1) {
        				
        				var optTxt = data.penaltyList[i].penaltyName+"( "+data.penaltyList[i].penaltyPoint+" )";
        			    var $op = $("<option>", {value : data.penaltyList[i].penaltyCd }).text(optTxt);
        				if(penalty != null && penalty === data.penaltyList[i].penaltyCd) {
        					$op.prop('selected', true);
        				}
        				$("#penaltyCdSlt").children().last().after($op);
        			}
        		}
        	}
        });
        
        
    });
    
    function exePenaltyEdit(e) {
    	e.preventDefault();
    	
    	if($("#penaltyCdSlt").val() === "") {
    		alert("벌점 코드를 선택해 주세요.");
    		return false;
    	}
    	
    	commonAjax.postAjax("/common/pop/exeEditPenalty.do", "json", $("#frm").serialize()
    		,function(data){
    		     if(data) {
    		    	 alert(data.resultMessage);
    		    	 window.close();
    		    	 opener.penaltyEdit('${penaltyVo.viewType}','${penaltyVo.penaltySeq}');
    		     } else {
    		    	 alert(data.resultMessage);
    		    	 return false;
    		     }
    		}
    	);
    }
    </script>
    
</body>
</html>