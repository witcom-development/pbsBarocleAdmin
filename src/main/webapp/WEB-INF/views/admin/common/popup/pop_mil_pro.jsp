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
	        <input type="hidden" name="viewType"    value="${mileageVo.viewType}">
	        <input type="hidden" name="usrSeq"     value="${mileageVo.usrSeq}">
	         <input type="hidden" name="mbCardSeq"	value="${mileageVo.mbCardSeq }">
	        <div class="allwrap pop">
	            <table class="tb_type02 mt20">
	                <colgroup>
	                    <col style="width:30%">
	                    <col style="width:70%">
	                </colgroup>
	                <tbody>
	                    <tr>
	                        <th class="top">이용구분</th>
	                        <td class="top">
	                            <select  id="mileageCdSlt" name="mileageClsCd">
	                                <option value="">선택</option>
	                            </select>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>마일리지</th>
	                        <td><span class="input-text01"><input class="tr onlyNumber" type="text" name="mileagePoint" id="mileagePoint"  maxlength=6 /></span></td>
	                    </tr>
	                </tbody>
	            </table>
	            <div class="btnArea">
	                <span class="right"><button class="btnType01" id="editBtn"></button></span>
	            </div>
	        </div>
	    </form>
    </div>
    <a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function(){
    	//viewType에 따라 버튼 텍스트가 변경.
        /* var btnTxt =  '${penaltyVo.viewType}' === "insert" ? "저장" :"삭제";
        if('${penaltyVo.viewType}' === 'view') {
        	$("#editBtn").css("display","none");
        } else {
        	$("#editBtn").text(btnTxt);
        	$("#editBtn").on("click", exePenaltyEdit);
        	$("#cancelBtn").on("click", function(e) {
        		e.preventDefault();
        		window.close();
        	});
        } */
    	//var penalty = '${penaltyInfo.penaltyCd}';
    	/* commonAjax.getCommonCode(function(data){
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
        }); */
        var btnTxt = "저장";
        $("#editBtn").text(btnTxt);
    	$("#editBtn").on("click", exeMileageEdit);
    	
    	commonAjax.getCommonCode("MIG"
                , function(data){
                    if(data !== null && data.codeList !== null) {
                        commCdBox.makeComboBox("CC", '', data.codeList, "mileageCdSlt");
                       
                    }
                }
            );
        
        
    });
    
    function exeMileageEdit(e) {
    	e.preventDefault();
    	
    	if($("#mileageCdSlt").val() === "") {
    		alert("이용구분을 선택해 주세요.");
    		return false;
    	}
    	
    	if($("#mileagePoint").val() === "") {
    		alert("마일리지를 입력해 주세요.");
    		return false;
    	}
    	
    	commonAjax.postAjax("/common/pop/exeEditMileage.do", "json", $("#frm").serialize()
    		,function(data){
    		     if(data) {
    		    	 alert(data.resultMessage);
    		    	 window.close();
    		    	 window.opener.linkPage(1);
    		    	 //opener.penaltyEdit('${penaltyVo.viewType}','${penaltyVo.penaltySeq}');
    		     } else {
    		    	 alert(data.resultMessage);
    		    	 return false;
    		     }
    		}
    	);
    }
    
    $(".onlyNumber").keypress(function (event) {
        if (event.which && (event.which < 48 || event.which > 57)) {   //숫자만 받기
            event.preventDefault();
        }
    }).keyup(function () {
        if ($(this).val() != null && $(this).val() != '') {
            var text = $(this).val().replace(/[^0-9]/g, '');
            $(this).val(comma(text));
        }
    }); 
    </script>
    
</body>
</html>