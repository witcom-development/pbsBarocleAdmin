<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
</head>
<body>
    <div class="allwrap">
        <!--모바일 메뉴 S-->
        <tiles:insertAttribute name="header"/>
        <!--모바일 메뉴 E-->
        <!--Head S-->
        <tiles:insertAttribute name="head"/>
        <!--Head E-->
        <div id="body">
            <div class="cont">
                <!--left menu S-->
                <tiles:insertAttribute name="left"/>
                <!--left menu E-->
                <!--conteent S-->
                <form id="frm"></form>
                <div class="content">
                    <div class="subject">
                        <!--subject path S-->
                        <tiles:insertAttribute name="subject" />
                        <!--subject path E-->
                    </div>
                    <div class="page">
                        <table class="tb_type02 mt20">
                            <colgroup>
                                <col style="width:25%">
                                <col style="width:75%">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th class="top">자전거 번호</th>
                                    <td class="top" id="bikeSeCdNm">${rentInfo.rentBikeNo}</td>
                                </tr>
                                <tr>
                                    <th>대여상태</th>
                                    <td>
                                    <c:choose>
                                        <c:when test="${menuType ne 'history' }">
	                                    ${rentInfo.rentStatusName }
                                        </c:when>
                                        <c:otherwise>
                                            <c:if test="${ rentInfo.rentStatusCd eq 'BKS_012' }">
                                                 ${rentInfo.rentStatusName }
                                            </c:if>
                                            <c:if test="${ rentInfo.rentStatusCd ne 'BKS_012' }">
                                                반납
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                    </td>
                                </tr>
                                
                                <c:choose>
                                	<c:when test="${rentInfo.adminId ne null && rentInfo.adminId ne ''}">
		                                <tr>
		                                	<th>강제반납 처리자</th>
		                                	<td>${rentInfo.adminId}</td>
		                                </tr>
		                            </c:when>
                                </c:choose>      
                                                 
                                <tr>
                                    <th>이용자(ID)</th>
                                    <td></td>
                                </tr>
                                <tr>
                                    <th>휴대폰 번호</th>
                                    <td>${rentInfo.usrMpnNo }</td>
                                </tr>
                                <%-- <tr>
                                    <th>대여구분</th>
                                    <td>${rentInfo.rentClsCdName }</td>
                                </tr> --%>
                                <tr>
                                    <th>대여일시</th>
                                    <td>${rentInfo.rentDttm }</td>
                                </tr>
                                <tr>
                                    <th>반납일시</th>
                                    <td>${rentInfo.returnDttm }</td>
                                </tr>
                                <tr>
                                    <th>대여 대여소/거치대번호</th>
                                    <td>${rentInfo.rentStationName}  / ${rentInfo.rentRackId} </td>
                                </tr>
                                <tr>
                                    <th>반납 대여소/거치대번호</th>
                                    <td>${rentInfo.returnStationName} /${rentInfo.returnRackId} </td>
                                </tr>
                                <tr>
                                    <th>대여(경과)시간</th>
                                    <td></td>
                                </tr>
                                <tr>
                                    <th>후불결제금액</th>
                                    <td>${rentInfo.overFee}</td>
                                </tr>
                                <tr>
                                    <th rowspan="2">벌점</th>
                                    <td>
                                        <span id="penaltyTot">${rentInfo.penaltyTot}</span>
                                        <span id="penaltyAdd"><a href="/common/pop/showPenaltyImpose.do"  class="winNewPop btnType02" title="벌점추가" data-width="450" data-height="450" data-pmt="&viewType=insert&usrSeq=${rentInfo.userSeq}&rentHistSeq=${rentInfo.rentHistSeq}" >벌점추가</a></span>
                                    </td><!--벌점 총함-->
                                </tr>
                                <tr>
                                    <td>
                                        <c:if test="${fn:length(rentInfo.penaltyList) > 0 }">
                                        <c:forEach var="penalty" items="${rentInfo.penaltyList}">
                                            <span class="pp" id="penalty_${penalty.penaltySeq}">
                                                <em>
                                                    <a href="/common/pop/showPenaltyImpose.do"  class="winNewPop modal" title="벌점추가" data-width="450" data-height="450" data-pmt="&viewType=update&penaltySeq=${penalty.penaltySeq}" style="color:#3366FF;">${penalty.penaltyName}</a>/${penalty.penaltyPoint}
                                                </em>
                                            </span>
                                        </c:forEach>
                                        </c:if>
                                    </td><!--벌점항목-->
                                </tr>
                                <tr>
                                    <th>대여가능시간</th>
                                    <td>${rentInfo.voucherStrDttm}~ ${rentInfo.voucherEndDttm}</td>
                                </tr>
                                <%-- <tr>
                                    <th>임시대여번호</th>
                                    <td><span class="renNum">${rentInfo.rentEncPwd}</span> <button class="btnType02" id="smsBtn">sms발송</button></td>
                                </tr> --%>
                            </tbody>
                        </table>
                        <div class="btnArea tl">
                            <span class="left"><button class="btnType01 mb10" id="listBtn">목록</button></span>
                            <span class="right">
                                
                                <a href="/moveBikeEditForm.do" target="_blank" class="winNewPop btnType01" title="로그" data-width="450" data-height="795" data-pmt="&bikeId=${rentInfo.rentBikeId}&bikeNo=${rentInfo.rentBikeNo}&viewFlg=U&tabNum=4&currentPageNo=1" >로그정보</a>
                                
                                <a href="/common/pop/showCompulsionBikeReturn.do" class="winNewPop btnType01" title="강제반납" data-width="450" data-height="795" data-pmt="&rentSeq=${rentInfo.rentSeq}" >강제반납</a>
                              <!-- 
                                <a href="/common/pop/showBikeMissingPop.do"       class="winNewPop btnType01" title="분실등록" data-width="450" data-height="293" data-pmt="&bikeId=${rentInfo.rentBikeId}&bikeNo=${rentInfo.rentBikeNo}&terminalId=${rentInfo.terminalId}&chkType=I">분실등록</a>
 -->   
                            </span>
                        </div>
                    </div>
                </div>
                <!--conteent E-->
            </div>
        </div>
        <!--footer S-->
        <tiles:insertAttribute name="footer"/>
        <!--footer E-->
    </div>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function() {
        
    	if('${menuType}' === 'history') {
    		$(".btnArea").find("a").eq(0).css('display', 'none');
    		$(".btnArea").find("a").eq(1).css('display', 'none');
    	} else {
    		$(".tb_type02 > tbody > tr").eq(6).css("display", "none");
    		$(".tb_type02 > tbody > tr").eq(8).css("display", "none");
    		$(".tb_type02 > tbody > tr").eq(10).css("display", "none");
    		$("#penaltyAdd").css('display', 'none');
    	}
    	var timeTxt = '${rentInfo.useMi}' !== "" ? "${rentInfo.useMi}" : "${rentInfo.elapseTime}";
    	timeTxt = timeTxt.concat("분");
    	
    	if('${rentInfo.adminId}' != null && '${rentInfo.adminId}' != "")
    	{
    		$(".tb_type02 > tbody > tr").eq(9).find("td").text(timeTxt);
    	}else{
    		$(".tb_type02 > tbody > tr").eq(8).find("td").text(timeTxt);
    	}
    	
    	var mbId = '${rentInfo.mbId}' === "" ? '${rentInfo.usrMpnNo}' : '${rentInfo.mbId}';
    	if(mbId !== 'GUEST'){
    		if('${rentInfo.adminId}' != null && '${rentInfo.adminId}' != ""){
    			$(".tb_type02 > tbody > tr").eq(12).css("display", "none");
                $(".tb_type02 > tbody > tr").eq(13).css("display", "none");
    		}else{
    			$(".tb_type02 > tbody > tr").eq(11).css("display", "none");
                $(".tb_type02 > tbody > tr").eq(12).css("display", "none");
    		}
    	}
    	
    	if('${rentInfo.adminId}' != null && '${rentInfo.adminId}' != "")
    	{
    		$(".tb_type02 > tbody > tr").eq(3).find("td").text(mbId);
    	}else{
    		$(".tb_type02 > tbody > tr").eq(2).find("td").text(mbId);
    	}
    	
    	rentDetail.initBtn('${menuType}');
    	
    	var bikeSeCd = '${rentInfo.bikeSeCd}';
    	// 자전거 구분명
    	commonAjax.getCommonCode("BIK", function(data){
    		if(data !== null && data.codeList !== null) {
    			for(var i = 0; i < data.codeList.length; i++){
    				if(bikeSeCd == data.codeList[i].comCd)
    					$('<label>['+data.codeList[i].comCdName+']</label>').appendTo('#bikeSeCdNm');
    			}
    		}
    	});
    });
    
    var rentDetail = {};
    
    rentDetail.initBtn = function(mType){
    	$("#smsBtn").on("click", exeTempPwSend);
    	$("#listBtn").on("click", function(e){
    		var tUrl = "/getRentHistoryList.do";
    		if(mType === 'status') {
    		    tUrl = "/getRentStatusList.do";
    		}
    		$("#frm").attr({action: tUrl, method : 'post'}).submit();
    	});
            	
    };
    
    var rentSeq = '${rentInfo.rentSeq}';
    var rentHistSeq = '${rentInfo.rentHistSeq}';
    var menuType = '${menuType}';
    function bikeStatusChange(statusCode) {
        $(".tb_type02 > tbody > tr").eq(1).children().eq(1).text("분실");
    };
    function exeTempPwSend(){
    	commonAjax.postAjax("/rentTempPwSend.do", "json", {usrMpnNo : '${rentInfo.usrMpnNo}'}
    	,function(data) {
    		if(data) {
    			if(data.checkResult > 0) {
    				alert('대여비밀번호를 전송했습니다.');
    				return false;
    			} else {}
    		}
    	});
    	
    }
    function penaltyEdit(pViewType, penaltyData){
    	var pTot = 0;
    	if(pViewType === "insert") {
    		
	        commonAjax.getAjax("/getPenaltyInfo.do", "json", {rentHistSeq : '${rentInfo.rentHistSeq}', menuType : '${menuType}'}
	            ,function(data) {
	                 if(data) {
	                     
	                     if(data.penaltyList.length > 0) {
	                         $(".tb_type02 > tbody > tr").eq(10).find("td").empty();
	                         var pSize = data.penaltyList.length;
	                         var $displayList = [];
	                         for(var i=0; i < pSize; i+=1) {
	                             var $span = $("<span>", {id : "penalty_"+data.penaltyList[i].penaltySeq}).addClass("pp");
	                             var $a = $("<a>", {href : "/common/pop/showPenaltyImpose.do", 'title' : "벌점추가", 'data-width' : "450",'data-height' : "450",'data-pmt' :"&viewType=update&penaltySeq="+data.penaltyList[i].penaltySeq}).addClass("winNewPop").css("color", "#3366FF").text(data.penaltyList[i].penaltyName);
	                             var point = "/".concat(data.penaltyList[i].penaltyPoint);
	                             var $em =  $("<em>").append($a);
	                             var str = $em.html();
                                 str = str + point                            ;
                                 $em.empty().append(str);
	                             $span.append($em);
	                             $displayList.push($span);
	                             pTot += parseInt(data.penaltyList[i].penaltyPoint);
	                         }
	                         
	                         $(".tb_type02 > tbody > tr").eq(10).find("td").append($displayList);  
	                         $("#penaltyTot").text(pTot);  
	                     }
	                     
	                 }
	            }
	        );
    	}else if(pViewType === "update") {
    		pTot = parseInt($("#penaltyTot").text());
    		var sPoint = $("#penalty_"+penaltyData+" > em").text().split("/");
    		pTot -= parseInt(sPoint[1]);
    		$("#penaltyTot").text(pTot);
            $("#penalty_"+penaltyData).remove();
        } else{
        	
        }
    } 
    </script>
</body>
</html>