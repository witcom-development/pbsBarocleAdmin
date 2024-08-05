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
    <form name="frm" method="post" enctype="multipart/form-data">
	    <div class="cntbox">
	        <div class="allwrap pop">
	            <div class="shBox_pop">
	                <div class="shBoxSection">
	                    <input type="file" name="bulkFile" style="width: 300px;margin-right: 30px;" />
	                </div>
		            <div class="btnArea"></div>
	            </div>
	            <c:if test="${fn:length(erroList) > 0}">
	            <div class="shBox_pop mt20">
	                <c:forEach var="error" items="${erroList }">
	                <h2>${error.LINE_NO}</h2>
	                <p>${error.ERROR_MSG} </p>
	                </c:forEach>
	            </div>
	            </c:if>
	            <div class="mt20" ></div>
	            <div class="mt20" >두번째 ROW는 삭제하고 입력 바랍니다.</div>
	        </div>
	        <div class="tc">
	            <button type="button" id="uploadBtn" class="btnType01 bc_green">등록</button>
	        </div>
	    </div>
    </form>
    <a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
    <script type="text/javascript" src="<c:url value='/js/common_barocle.js'/>"></script>
    <script type="text/javascript">
    $(function() {
        //
        var errorCnt = '${fn:length(erroList)}';
        var chkResult = '${checkResult}';
        if(parseInt(errorCnt)== 0 && chkResult !== '') {
	        if( parseInt(chkResult) > 0){
	        	$(".mt20").eq(0).append("<h2>업로드에 성공했습니다.</h2>");
	        } else {
	        	$(".mt20").eq(0).append("<h2>업로드에 실패했습니다.</h2>").css("color" ,'red');
	        }
        }
        $(".popTt").text("엑셀업로드");
        $(".popclose").on("click", closePop);
        setExcelLink('<c:out value="${excelFlg}"/>');
         
        $("#uploadBtn").on("click", {devType :'${excelFlg}'}, function(e){
            e.preventDefault();
            e.stopPropagation();
            if($("[name='bulkFile']").val() === "") {
                alert("업로드할 file을 선택해주세요.");
                return false;
            }
            var fileType = $("[name='bulkFile']").val();
            var f = fileType.split(".");
            if(f[1] != 'xls' && f[1] != 'xlsx') {
                alert("엑셀 파일만 업로드 가능합니다.");
                $("[name='bulkFile']").val('');
                return false;
            }
            $("[name='frm']").attr('action', "/excel/"+e.data.devType+"/uploadExcel.do").submit();
        });
    });    
    function closePop() {
        opener.location.href = "javascript:maskhide()";
        self.close();
    }
    
    function sampleDownload(e){
    	e.preventDefault();
    	
    }
    function setExcelLink(type) {
    	if (type !== '') {
	    	 var $exeLink = $("<a>");
	    	 var devName = "";
	         if(type ==="DEV_001") {
	        	 devName = "자전거";;
	         } else if(type === "DEV_002") {
	        	 devName = "단말기";
	         } else if(type === "DEV_003") {
	        	 devName = "AP";
	         } else if(type === "DEV_004"){
	        	 devName = "거치대";
	         } else if(type === "COUNSEL"){
	        	 devName = "상담이력";
	         } else {
	        	 type = "STOCK";
	        	 devName = "부품";
	         }
	         
	         $exeLink.attr({href : '/excelSample/'+type+"_sample.xlsx"}).text(devName+" Excel 샘플 down.").css("color", "#0033CC"); 
    		$(".btnArea").append($exeLink);
    	}
    	
    }
    </script>
</body>
</html>
	
