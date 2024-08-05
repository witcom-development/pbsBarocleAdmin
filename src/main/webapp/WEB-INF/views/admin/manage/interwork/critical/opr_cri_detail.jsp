<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
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
                <tiles:insertAttribute name="left"  />
                <!--left menu E-->
				<!--content S-->
				<div class="content">
					<div class="subject">
						<!--subject path S-->
							<tiles:insertAttribute name="subject" />
						<!--subject path E-->
					</div>
					<div class="page">
						<form id="criticalFrm" name="criticalFrm">
						<fieldset>
							<table class="tb_type01">
								<colgroup>
									<col style="width:20%" />
									<col span="2" style="width:auto" />
								</colgroup>
								<thead>
									<tr>
										<th>항목</th>
										<th>하한</th>
										<th>상한</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="result" items="${criticalList }" varStatus="status">
									<tr>
										<td>${result.criticalName }</td>
										<td>
											<span>
												<c:choose>
									            	<c:when test="${fn:contains(result.criticalMinUseYn, 'Y')}">
									                	<input type="checkbox" name="criticalMinUseYn" id="criticalMinUseYn" checked="checked" class="vm" />
									                </c:when>
									                <c:otherwise>
									                	<input type="checkbox" name="criticalMinUseYn" id="criticalMinUseYn" class="vm" />
									                </c:otherwise>
								                </c:choose>
											</span> <label for="criticalMinUseYn">사용여부</label> 
											<p class="pwtableblock">
												<span class="input-text03 ml20">
													<input type="text" name="criticalMin" value="${result.criticalMin }" />
												</span> 이상
											</p>
										</td>
										<td>
											<span>
												<c:choose>
									            	<c:when test="${fn:contains(result.criticalMaxUseYn, 'Y')}">
									                	<input type="checkbox" name="criticalMaxUseYn" id="criticalMaxUseYn" checked="checked" class="vm" />
									                </c:when>
									                <c:otherwise>
									                	<input type="checkbox" name="criticalMaxUseYn" id="criticalMaxUseYn" class="vm" />
									                </c:otherwise>
								                </c:choose>
											</span> <label for="criticalMaxUseYn">사용여부</label> 
											<p class="pwtableblock">
												<span class="input-text03 ml20">
													<input type="text" name="criticalMax" value="${result.criticalMax }" />
												</span> 이하
											</p>
										</td>
									</tr>
									</c:forEach>
									<c:if test='${fn:length(criticalList) == 0}'> 
								        <tr>
								            <td style="text-align:center" colspan="3"><spring:message code="search.nodata.msg" /></td>
							            </tr>
							        </c:if>
								</tbody>
							</table>
						<div class="btnArea">
							<span class="right"><button class="btnType01 bc_green" type="button" id="criticalModBtn">저장</button></span>
						</div>
						</fieldset>
						</form>
					</div>
				</div>
				<!--conteent E-->
         	</div>
        </div>
        <!--footer S-->
        <tiles:insertAttribute name="footer" />
        <!--footer E-->
    </div>

<script type="text/javascript" src="/js/common_barocle.js"></script>
<script type="text/javascript">
	$(function() {
		critical.initBtn();
	});
	var critical = {};
	critical.initBtn = function () {
		$("#criticalModBtn").on("click", function() {
			$("#criticalFrm").attr({method : "post", action : "/admin/manage/modCritical.do"}).submit();
		});
	};
</script>

</body>
</html>