<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
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
            <form id="frm">
                <input type="hidden" name="bikeId" value="${bikeInfo.bikeId }">
                <input type="hidden" name="terminalId" value="${bikeInfo.terminalId }">
                <input type="hidden" name="bikeStatusCd" value="BKS_007">
                <input type="hidden" name="lostYn" value="Y">
                <input type="hidden" name="chkType" value="${bikeInfo.chkType}">
            
	            <table class="tb_type02 mt20">
	                <colgroup>
	                    <col style="width:30%">
	                    <col style="width:70%">
	                </colgroup>
	                <tbody>
	                    <tr>
	                        <th class="top">자전거 번호</th>
	                        <td class="top">${bikeInfo.bikeNo}</td>
	                    </tr>
	                    <tr>
	                    <c:if test="${bikeInfo.chkType eq 'I'}">
	                        <th>분실일</th>
	                        <td><span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="lostDate"  title="선택 날짜" id="bb22" readonly/></span></td>
                        </c:if>
	                    <c:if test="${bikeInfo.chkType eq 'U'}">
	                        <th>센터</th>
	                        <td><select class="select-category02" name="centerId" id="centerSlt">
                                    <option value="">선택</option>
                                </select>
                            </td>
                        </c:if>
	                    </tr>
	                    
	                </tbody>
	            </table>
            </form>
            <div id="resultTxt"></div>
            <div class="btnArea">
                <span class="right"><button class="btnType01" id="missingBtn">저장</button><button class="btnType01" id="cancelBtn">취소</button></span>
            </div>
        </div>
    </div>
    <a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function() {
    	var today = DateUtil.dateFmt(new Date());
    	$("[name='lostDate']").val(today);
    	
    	$("#missingBtn").on("click",{ chkType : '${bikeInfo.chkType}'} ,bikeMissingStatusExe);
    	$("#cancelBtn").on("click", function(e) {
    		e.preventDefault();
    		window.close();
    	});
    	
    	  //센터 
        commonAjax.getCenterCode( 
            function(data) {
                if(data !== null && data.centerList !== null) {
                    commCdBox.makeComboBox('C', '', data.centerList, "centerSlt");
                }
            }
        );
    });
    function bikeMissingStatusExe(e) {
    	e.preventDefault();
    	if(e.data.chkType === 'I') {
	    	var ans = confirm("자전거No [${bikeInfo.bikeNo}]를 분실로 등록 하시겠습니까?");
	        if(ans) {
		    	commonAjax.postAjax("/common/pop/missingBikeReg.do", "json", $("#frm").serialize()
		    		,function(data){
		    		   if(data.checkResult > 0) {
		    			   alert(data.resultMessage);
		    			   opener.bikeStatusChange('BKS_007');
		    			   window.close();
		    		   }
		    		}
		    	);
	        }
    	} else {
    		if($("#centerSlt").val() === "") {
    			alert("센터를 선택해 주세요.");
    			return false;
    		}
    		
    		var ans = confirm("자전거No [${bikeInfo.bikeNo}]를 분실 해제 하시겠습니까?");
            if(ans) {
            	$("[name='bikeStatusCd']").val('BKS_004');
            	$("[name='lostYn']").val('N');
                commonAjax.postAjax("/common/pop/missingBikeReg.do", "json", $("#frm").serialize()
                    ,function(data){
                       if(data.checkResult > 0) {
                           alert(data.resultMessage);
                           opener.bikeStatusChange('BKS_004');
                           window.close();
                       }
                    }
                );
            }
    	}
    }
    </script>
    
</body>
</html>