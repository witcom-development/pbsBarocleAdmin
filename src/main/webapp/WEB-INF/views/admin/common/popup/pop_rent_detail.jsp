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
<body onunload="Ev_onbeforeunload()">
    <h1 class="popTt"></h1>
    <div class="cntbox">
        <div class="allwrap pop">
            <table class="tb_type02 mt20">
                <colgroup>
                    <col style="width:30%">
                    <col style="width:70%">
                </colgroup>
                <tbody>
                    <tr>
                        <th class="top">자전거 번호</th>
                        <td class="top">${detailInfo.rentBikeNo}</td>
                    </tr>
                    <tr>
                        <th>(자전거) 상태</th>
                        <td>
                        	<c:choose>
                        		<c:when test="${detailInfo.rentStatusCd eq 'BKS_010' || detailInfo.rentStatusCd eq 'BKS_012' }">
                        			${detailInfo.rentStatusName }
                        		</c:when>
                        		<c:when test="${detailInfo.rentStatusCd ne 'BKS_010' || detailInfo.rentStatusCd ne 'BKS_012' }">
                        			반납
                        		</c:when>
                          	</c:choose>
                        </td>
                    </tr>
                    
                    <c:choose>
						<c:when test="${detailInfo.adminId ne null && detailInfo.adminId ne ''}">
							<tr>
								<th>강제반납 처리자</th>
								<td>${detailInfo.adminId}</td>
							</tr>
						</c:when>
					</c:choose> 
					
                    <tr>
                        <th>이용자(ID)</th>
                        <td>${detailInfo.mbId}</td>
                    </tr>
                    <tr>
                        <th>대여구분</th>
                        <td>${detailInfo.rentClsCdName}</td>
                    </tr>
                    <tr>
                        <th>대여일시</th>
                        <td>${detailInfo.rentDttm}</td>
                    </tr>
                    <tr>
                        <th>반납일시</th>
                        <td>${detailInfo.returnDttm}</td>
                    </tr>
                    <tr>
                        <th>대여대여소/거치대 번호</th>
                        <td>${detailInfo.rentStationName}/${detailInfo.rentRackId}</td>
                    </tr>
                    <tr>
                        <th>반납대여소/거치대 번호</th>
                        <td>${detailInfo.returnStationName}/${detailInfo.returnRackId}</td>
                    </tr>
                    <tr>
                        <th>대여시간</th>
                        <td>${detailInfo.useMi}분</td>
                    </tr>
                    <tr>
                        <th>추가과금</th>
                        <td>${detailInfo.overFee}</td>
                    </tr>
                    <tr>
                        <th>벌점</th>
                        <td>${detailInfo.penaltyPoint}</td>
                    </tr>
                    <tr>
                        <th>실패사유</th>
                        <td>
                        	<c:forEach var="result" items="${failInfo}" varStatus="status">
                        		${result.errMsg }<br>
                        	</c:forEach>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="btnArea">
                <span class="right"><button class="btnType01">취소</button></span>
            </div>
        </div>
    </div>
    <a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
    <script type="text/javascript">
    $(function(){
    	var returnBike = "${detailInfo.rentClsCdName}";
    	if(returnBike == "-"){
    		alert("사용자가 반납했습니다. 다시 조회 바랍니다.");
    		opener.location.reload();
    		window.open('', '_self', '');
    		window.close();
    	}

		/* $.ajax({
			url : "/admin/customer/notice/noticePopupCount.do",
			type : "get",
			contentType: "charset=utf-8",
			data : params ,
			success : function(data){
					if(data!=null){
						for(var i=0; i<data.popupCount.length; i++){
							var s = getCookie(data.popupCount[i].noticeSeq);
							if(s!='hide'){
								window.open("/admin/customer/notice/noticePopup.do?popSeq="+data.popupCount[i].noticeSeq, "noticePop"+data.popupCount[i].noticeSeq, "toolbar=no, location=no, directory=no, scrollbars=yes, resizable=yes, top="+ top +", left="+ left +", width=400, height=600");
								left += 415;
							}
						}
					}
			}, error : function(){ alert("데이터를 가져오는데 실패 하였습니다."); }
		}); */

    	
    	$(".btnType01").on("click", function(){
    		window.close();
    	});
    });
    
//     function Ev_onbeforeunload(){
//     	opener.location.reload();
//     }
    </script>
</body>
</html>
