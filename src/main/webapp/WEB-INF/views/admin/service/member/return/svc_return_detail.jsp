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



<script type="text/javascript" src="/js/common_barocle.js"></script>
<script type="text/javascript">

	function fn_list(){

		$("#frm").attr("action","/admin/service/member/returnRentalList.do");
		$("#frm").submit();
	}
	function fn_MemberDetail(seq){
		$("#usr_seq").val(seq);
		
		$("#frm").attr("action", "/admin/service/member/memberInfo.do");

		$("#frm").submit();
	}
	
</script>

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
				<form  method="post" name="frm"	id="frm">
				<input type="hidden" name="searchStartDate" id="searchStartDate" value="${searchParam.searchStartDate}"/>
				<input type="hidden" name="searchEndDate" id="searchEndDate" value="${searchParam.searchEndDate}"/>
				<input type="hidden" name="page" id="page" value="${searchParam.pageNo}"/>
				<input type="hidden" name="searchParameter" id="searchParameter" value="${searchParam.searchParameter}"/>
				<input type="hidden" name="searchParameter2" id="searchParameter2" value="${searchParam.searchParameter2}"/>
				<input type="hidden" name="searchValue" id="searchValue" value="${searchParam.searchValue}"/>
				<input type="hidden" name="usr_seq"	id="usr_seq">
				
				<div class="content">
					<div class="subject">
						<!--subject path S-->
							<tiles:insertAttribute name="subject" />
						<!--subject path E-->
					</div>
					<div class="page">
						<table class="tb_type02 mt20">
<!-- 						<table class="tb_type01"> -->
								<colgroup>
									<col style="width:30%" />
									<col style="width:70%" />
								</colgroup>
							<tbody>
							
<%-- 								<c:forEach var="result" items="${returnList }" varStatus="status"> --%>
									<tr>
										<th>ID</th>
<%-- 										<td>${result.usrId }</td> --%>
										<td class="title"><a href="#" onclick="fn_MemberDetail('${returnList.usrSeq }'); return false;">${returnList.usrId }</a></td>
									</tr>
									<tr>
										<th>추천반납 대여소 조회시간</th>
										<td>${nowTime }</td>
									</tr>
									<tr>
										<th>추천 반납 대여소</th>
										<td>
										${fn:replace( returnList.recommend_station, ',', ' ,<br/><br/>')}
										</td>
									</tr>
									<tr>
										<th>추천반납 대여소 최대 거치수</th>
										<td>
											${fn:replace( returnList.station_max_val, ',', ' ,<br/><br/>')}
										</td>
									</tr>
									<tr>
										<th>추천반납 대여소 반납순위</th>
										<td>${returnList.return_rank }</td>
									</tr>
									<tr>
										<th>반납 대여소</th>
										<td>${returnList.stationNm }</td>
									</tr>
									<tr>
										<th>반납 일시</th>
										<td>${returnList.returnDttm }</td>
									</tr>
									<tr>
										<th>마일리지 부여 여부(포인트)</th>
										<td>${returnList.mileageYn }(${returnList.mileagePoint } 점)</td>
									</tr>
<!-- 									<tr> -->
<!-- 										<th>마일리지 점수</th> -->
<%-- 										<td>${result.mileagePoint } 점</td> --%>
<!-- 									</tr> -->
									<tr>
										<th>일 누적 / 일 최대 적립 Point</th>
										<td>${returnList.todayAccumulateMileagePoint } / ${returnList.dayMaxMileagePoint } 점</td>
									</tr>
<%-- 								</c:forEach> --%>
							</tbody>
						</table>
						<div class="btnArea">
							<span class="left" onclick="fn_list(); return false;"><button class="btnType01 bc_gray">목록</button></span>
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
</html>
