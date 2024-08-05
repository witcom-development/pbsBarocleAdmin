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
</head>
<body>
	<div class="allwrap">
		<!--모바일 메뉴 S-->
			<tiles:insertAttribute name="header" />
		<!--모바일 메뉴 E-->
		<!--Head S-->
			<tiles:insertAttribute name="head" />
		<!--Head E-->
		<div id="body">
			<div class="cont">
				<!--left menu S-->
				<tiles:insertAttribute name="left" />
				<!--left menu E-->
				<!--conteent S-->
				<form name="frm" id="frm" method="post">				
					<div class="content">
						<div class="subject">
							<!--subject path S-->
								<tiles:insertAttribute name="subject" />
							<!--subject path E-->
						</div>
						<div class="page">
							<ul class="tablist mt20">
								<li><a href="#">회원정보</a></li>
								<li><a href="#">결제이력</a></li>
								<li><a href="#">이용이력</a></li>
								<li><a href="#">마일리지 이력</a></li>
								<li class="on"><a href="#">벌점이력</a></li>
								<li><a href="#">환불이력</a></li>
								<li><a href="#">미납이력</a></li>
								<li><a href="#">이용권</a></li>
								<li><a href="#">선물</a></li>
							</ul>
							<select  id="mobiletableList" class="tablist_m">
								<option value="0">회원정보</option>
								<option value="1">결제이력</option>
								<option value="2">이용이력</option>
								<option value="3">마일리지이력</option>
								<option value="4"  selected="selected">벌점이력</option>
								<option value="5">환불이력</option>
								<option value="6">미납이력</option>
								<option value="7">이용권</option>
							</select>
							<!-- 모바일 검색조건 S-->
							<div class="shBox_m mt20">
								<div class="downtitle">
									<div class="title">
										<p>검색조건</p><span><button type="button"><img src="/images/srh_open.png" alt="검색조건 열기" /></button></span>
									</div>
								</div>
							</div>
							<!-- 모바일 검색조건 E-->
							<!--검색조건 S-->
							<div class="shBox">
								<legend>검색조건</legend>
								<div class="shBoxSection">
									<div class="section">
										<label for="bb22" class="laType02">수정일</label>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchStartDate" name="searchStartDate" readonly/></span>
										<span class="dash">~</span>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchEndDate"	name="searchEndDate" readonly/></span>
									</div>
									<div class="section pright">
	                                    <label for="bb23" class="laType02">조회구분</label>
	                                    <span class="input-rd01"><input type="radio" id="readClsS" name="readClsCd" value="S" checked="checked"><label for="readClsS">현황</label></span>
	                                    <span class="input-rd01"><input type="radio" id="readClsH" name="readClsCd" value="H"><label for="readClsH">이력</label></span>
	                                    <button class="btn-srh03 btncase1" id="searchBtn" onclick="fn_penaltySearch();"><img src="/images/searchIcon.gif" alt="검색"></button>
	                                </div>
								</div>
							</div>
							<!--검색조건 E-->
							<p class="tb_numlist" style="float: left;">
								<b>
								총 벌점  : ${totalPenalty.penalty_point } 점 /
								블랙리스트 여부 : ${totalPenalty.black_list == 0?"NO":"YES" }
								</b>
							</p>
							<p class="tb_numlist">
								<c:if test="${paginationInfo != null }">
									총 ${paginationInfo.totalRecordCount } 건
								</c:if>
							</p>
							<table class="tb_type01">
								<colgroup>
									<col style="width:20%"/>
									<col style="width:15%"/>
									<col style="width:30%"/>
									<col style="width:20%"/>
									<col style="width:15%"/>
								</colgroup>
								<thead>
									<tr>
										<th>수정일</th>
										<th>벌점</th>
										<th>내용</th>
										<th>수정자</th>
										<th>변경</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${penaltyList }"	var="penaltyList">
										<tr>
											<td class="tc">
												<fmt:parseDate var="dateString" value="${penaltyList.reg_dttm }" pattern="yyyy-MM-ddHH:mm:ss" />
												<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd HH:mm" />	
											</td>
											<td class="tr pr10">${penaltyList.penalty_point }</td>
											<td class="title pl10">${penaltyList.penalty_desc }</td>
											<td class="pl10">${penaltyList.reg_id }</td>
											<td class="tc">
											    <c:if test="${ form.readClsCd eq 'S' }">
													<button class="fullBtn" onclick="fn_DeletePenalty('${penaltyList.penalty_seq}' ,'${penaltyList.usr_seq }'); return false;"><img src="/images/btn_delAnswer.png" alt=""></button>
											    </c:if>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							
							<c:if test="${paginationInfo.totalRecordCount == 0}">
								<table class="tb_type01">
									<tr>
										<td class="tc">
											<spring:message code="search.nodata.msg" />
										</td>
									</tr>
								</table>
							</c:if>
							
							
							<div class="paging">
								<input type="hidden" name="usr_seq"	id="usr_seq" value="${info.usr_seq }" >
								<c:if test="${paginationInfo != null }">
									<input type="hidden" name="currentPageNo"	id="currentPageNo" value="${paginationInfo.currentPageNo }">
									<input type="hidden" name="penalty_seq"	id="penalty_seq" value="">
									<ui:pagination paginationInfo = "${paginationInfo}" type="custom" jsFunction="linkPage"	/>
								</c:if>
							</div>
							<div class="btnArea">
	                            <span class="right">
	                            <!--15-12-15 추가  -->
	                            <a href="/common/pop/showPenaltyImpose.do"  class="winNewPop btnType01" title="벌점추가" data-width="450" data-height="450" data-pmt="&viewType=insert&usrSeq=${form.usr_seq}&rentHistSeq=" >벌점등록</a>
	                            </span>
	                            <!-- 추가  -->
	                        </div>
						</div>
					</div>
				</form>
				<!--content E-->
			</div>
		</div>
		<!--footer S-->
		<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
<script type="text/javascript">

$(function() {
    if("${result }" != ""){
        alert("${result}")
    }
    
    if("${form.readClsCd}" !== "") {
    	if("${form.readClsCd}" === "H") {
    		$("#readClsH").prop("checked", true);
    	} 
    }
    $("#searchStartDate").val("${form.searchStartDate}");
    $("#searchEndDate").val("${form.searchEndDate}");
            
    
        $(".page .tablist li").click(function(){
            //alert($(".page .tablist li").index(this));
            
            $(".page .tablist li").each(function(){
                $(this).attr("class", "");
            })
            $(this).attr("class","on");
            
            var action = getAction($(".page .tablist li").index(this));
            
            $("#searchStartDate").val("");
            $("#searchEndDate").val("");
            $("#currentPageNo").val(1);
            $("[name='readClsCd']").val("S");
            
            $("#frm").attr("action", action );
            $("#frm").submit();
            
        });
        
        
        $("#mobiletableList").change(function(){
            
            var action = getAction($("#mobiletableList").val());
            $("#searchStartDate").val("");
            $("#searchEndDate").val("");
            $("#currentPageNo").val(1);
            
            $("#frm").attr("action", action );
            $("#frm").submit();
        })
        
    
});

function getAction(idx){

    var actionValue = "" ;
    switch (Number(idx) ) {
        case 0: actionValue = "/admin/service/member/memberInfo.do";    		break;
        case 1: actionValue = "/admin/service/member/memberPaymentList.do";     break;
        case 2: actionValue = "/admin/service/member/memberUseList.do";     	break;
        case 3: actionValue = "/admin/service/member/memberMileage.do";     	break;
        case 4: actionValue = "/admin/service/member/memberPenalty.do";     	break;
        case 5: actionValue = "/admin/service/member/memberRefundList.do";  	break;
        case 6: actionValue = "/admin/service/member/memberUnpaidList.do";      break;
        case 7: actionValue = "/admin/service/member/memberVoucherList.do";     break;
        case 8:	actionValue = "/admin/service/member/memberGiftList.do"; 		break;
    }
    return actionValue;
}

function fn_DeletePenalty( penalty_seq , usr_seq){
    if(confirm("이력으로 변경 하시겠습니까?")){
        $.post("/admin/service/member/deletePenalty.do", "penalty_seq=" + penalty_seq +"&usr_seq=" + usr_seq , function(data) {
            if(data.resultMsg == "삭제성공"){
                alert('<spring:message code="success.common.update" />');
                fn_penaltySearch();
            }
            
        });
    }
    
    
}

function fn_penaltySearch(){
    linkPage(1);
}
function linkPage(no){
    
    if($("#searchStartDate").val()  &&  $("#searchEndDate").val())
    if($("#searchStartDate").val() > $("#searchEndDate").val()){
        alert('<spring:message code="fail.input.daterange" />');
        return;
    }
    $("#currentPageNo").val(no);
    $("#frm").attr("action", "/admin/service/member/memberPenalty.do").submit();
}
function penaltyEdit(vType, vSeq) {
	 linkPage(1);
}
</script>
</html>
