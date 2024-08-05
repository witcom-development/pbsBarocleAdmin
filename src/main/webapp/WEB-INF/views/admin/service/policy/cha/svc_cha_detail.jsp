<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
						<div class="tabWrap type3">
							<ul class="tabBox">
								<li class="tab on"><button type="button">정기권<br/>&nbsp;</button></li>
								<li class="tab"><button type="button">일일권<br/>(회원)</button></li>
								<li class="tab"><button type="button">일일권<br/>(비회원)</button></li>
								<li class="tab"><button type="button">단체권<br/>&nbsp;</button></li>
							</ul>
							
							<!-- 정기권 S  -->
							<div class="tabCon on">
								<form action="action" id="seasonFrm">
									<fieldset>
									<legend>정기권</legend>
										<table  class="tb_type01">
											<colgroup>
												<%-- <col style="width:9%"/>
												<col style="width:11%"/>
												<col style="width:8%"/>
												<col style="width:11%"/>
												<col style="width:11%"/>
												<col style="width:11%"/>
												<col style="width:11%"/>
												<col style="width:11%"/>
												<col style="width:11%"/> 
												변경시 전체적으로 넓이 수정 요망
												--%>
												<col style="width:13%"/>
												<col style="width:12%"/>
												<col style="width:9%"/>
												<col style="width:12%"/>
												<col style="width:12%"/>
												<col style="width:12%"/>
												<col style="width:12%"/>
												<col style="width:12%"/>
												<col style="width:12%"/>  
											</colgroup>
											<tbody>
											<c:set var="topCount" value="0" />
											<tr>
												<th>구분</th>
												<th>기본</th>
												<th>마일리지<br>사용여부</th>
												<!-- <th>할인요금</th> -->
												<th>제로페이</th>
												<th>국가유공자</th>
												<th>기초생활</th>
												<th>한부모</th>
												<th>청소년</th>
												<th>안전교육인증제</th>
											</tr>
											<c:forEach var="result" items="${rentChargePolicyList }" varStatus="status">
												<c:if test="${(fn:contains(result.addVal3, 'RCC_001'))}">
													<tr>
													
														<td>${result.cdDesc }</td>
														<td>
															<span class="input-text03">
																<input type="text" class="tr pr10" name="rentFeeList" value="${result.rentFee }"/>&nbsp;원 
																<input type="hidden" name="rentFeeSeqList" value="${result.rentFeeSeq }"/>
																<input type="hidden" name="paymentClsCd" value="${result.paymentClsCd }"/>
																<!-- 기존 할인 요금 표출 정지 -->
																<input type="hidden" name="discountFeeList" value="${result.discountFee }"/>
															</span>
														</td>
														<td class="tc">	
																<input type="checkbox" name="mileageUseYnList" value="${result.rentFeeSeq}" <c:if test='${result.mileageUseYn == "Y" }' >checked="chekced"</c:if>/>&nbsp;<label for="mileageYN"></label>
														</td>
														<%-- <span class="input-text03">
																<input type="text" class="tr pr10" name="discountFeeList" value="${result.discountFee }"/>원&nbsp;할인
															</span> --%>
														<td>	
															<span class="input-text03">
																<input type="text" class="tr pr10" name="zeroPayDiscountFeeList" value="${result.zeroPayDiscountFee }"/>&nbsp;원
															</span>
														</td>
														<td>	
															<span class="input-text03">
																<input type="text" class="tr pr10" name="meriterFeeList" value="${result.meriterFee}"/>&nbsp;원
															</span>
														</td>
														<td>	
															<span class="input-text03">
																<input type="text" class="tr pr10" name="bscLivFeeList" value="${result.bscLivFee}"/>&nbsp;원
															</span>
														</td>
														<td>	
															<span class="input-text03">
																<input type="text" class="tr pr10" name="singleParentFeeList" value="${result.singleParentFee}"/>&nbsp;원
															</span>
														</td>
														<td>	
															<span class="input-text03">
																<input type="text" class="tr pr10" name="youthFeeList" value="${result.youthFee}"/>&nbsp;원
															</span>
														</td>
														<td>	
															<span class="input-text03">
															<c:if test="${result.disRate ne null && result.disRate ne ''}">
																<input type="text" class="tr pr10" name="disRateList" style="width:20px" value="${result.disRate}" rownum onchange="valuechanged(seasonFrm, $(this));"/>&nbsp;%할인
																(<input type="text" class="tr pr10" name="certDisPrice" value="0" readonly/>&nbsp;원)
															</c:if>
															</span>
														</td>
													</tr>
													<c:set var="topCount" value="1"/>
												</c:if>
											</c:forEach>	
											</tbody>
										</table>
										
										<table  class="tb_type02 mt20">
											<colgroup>
												<col style="width:20%"/>
												<col style="width:80%"/>
											</colgroup>
											<tbody>
												<tr>
													<th class="top"><em>*</em>대여시간 초과요금</th>
													<td class="top">
														<c:forEach var="result" items="${addChargePolicyList }" varStatus="status">
															<c:if test="${fn:contains(result.addFeeCls, 'S')}">
																<c:if test="${result.overEndMi != '0' }">
																	<span class="input-text03 ml10"><input type="text" class="tr pr10" name="firstOverStrMiList" value="${result.overStrMi }" onchange="chargeForm.addStrMin(this)"/>
																	<input type="hidden" name="overStrMiList" value="${result.overStrMi }" id="overStartMinute1"/></span>
																	분&nbsp;&nbsp;~
																	<span class="input-text03 ml10"><input type="text" class="tr pr10" name="overEndMiList" id="0" value="${result.overEndMi }" onchange="chargeForm.addMin(this)"/></span>
																	분&nbsp;&nbsp;<span class="input-text03 ml10"><input type="text" class="tr pr10" name="addFeeInterMiList" value="${result.addFeeInterMi }"/></span>분 당
																	<span class="input-text03 ml10"><input type="text" class="tr pr10" name="addFeeList" value="${result.addFee }"/></span>
																	<input type="hidden" name="addFeeSeqList" value="${result.addFeeSeq }"/>
																	원<br/>
																</c:if>
																<c:if test="${result.overEndMi == '0' }">
																	<span class="input-text03 ml10"><input type="text" class="tr pr10" name="lastOverStrMiList" value="${result.overStrMi }" readonly="readonly"/>
																	<input type="hidden" name="overStrMiList" value="${result.overStrMi }"/></span>
																	분&nbsp;&nbsp;이후&nbsp;&nbsp;<span class="input-text03 ml10"><input type="text" class="tr pr10" name="addFeeInterMiList" value="${result.addFeeInterMi }" /></span>분 당
																	<span class="input-text03 ml10"><input type="text" class="tr pr10" name="addFeeList" value="${result.addFee }"/></span>
																	<input type="hidden" name="addFeeSeqList" value="${result.addFeeSeq }"/>
																	원
																</c:if>
															</c:if>
														</c:forEach>
													</td>
												</tr>
											</tbody>
										</table>
										
										<div class="btnArea">
											<span class="right"><button class="btnType01 bc_green" type="button" id="seasonSaveBtn">저장</button></span>
										</div>
									</fieldset>
								</form>
							</div>
							<!-- 정기권 E  -->
							
							<!-- 일일권(회원) S  -->
							<div class="tabCon">
								<form action="action" id="memberFrm">
									<fieldset>
									<legend>일일권(회원)</legend>
										<table  class="tb_type01">
											<colgroup>
												<%-- <col style="width:9%"/>
												<col style="width:11%"/>
												<col style="width:8%"/>
												<col style="width:11%"/>
												<col style="width:11%"/>
												<col style="width:11%"/>
												<col style="width:11%"/>
												<col style="width:11%"/>
												<col style="width:11%"/> 
												변경시 전체적으로 넓이 수정 요망
												--%>
												<col style="width:13%"/>
												<col style="width:12%"/>
												<col style="width:9%"/>
												<col style="width:12%"/>
												<col style="width:12%"/>
												<col style="width:12%"/>
												<col style="width:12%"/>
												<col style="width:12%"/>
												<col style="width:12%"/> 
											</colgroup>
											<tbody>
												<tr>
													<th>구분</th>
													<th>기본</th>
													<th>마일리지<br>사용여부</th>
													<!-- <th>할인요금</th> -->
													<th>제로페이</th>
													<th>국가유공자</th>
													<th>기초생활</th>
													<th>한부모</th>
													<th>청소년</th>
													<th>안전교육<br>인증제</th>
												</tr>
												<c:forEach var="result" items="${rentChargePolicyList }" varStatus="status">
													<c:if test="${(fn:contains(result.addVal3, 'RCC_002'))}">
														<tr>
															<td>${result.cdDesc }</td>
															<td>
																<span class="input-text03">
																	<input type="text" class="tr pr10" name="rentFeeList" value="${result.rentFee }"/>&nbsp;원 
																	<input type="hidden" name="rentFeeSeqList" value="${result.rentFeeSeq }"/>
																	<input type="hidden" name="paymentClsCd" value="${result.paymentClsCd }"/>
																	<!-- 기존 할인 요금 표출 정지 -->
																	<input type="hidden" name="discountFeeList" value="${result.discountFee }"/>
																</span>
															</td>
															<td class="tc">	
																	<input type="checkbox" name="mileageUseYnList" value="${result.rentFeeSeq}" <c:if test='${result.mileageUseYn == "Y" }' >checked="chekced"</c:if>/>&nbsp;<label for="mileageYN"></label>
															</td>
															<%-- <span class="input-text03">
																	<input type="text" class="tr pr10" name="discountFeeList" value="${result.discountFee }"/>원&nbsp;할인
																</span> --%>
															<td>	
																<span class="input-text03">
																	<input type="text" class="tr pr10" name="zeroPayDiscountFeeList" value="${result.zeroPayDiscountFee }"/>&nbsp;원
																</span>
															</td>
															<td>	
																<span class="input-text03">
																	<input type="text" class="tr pr10" name="meriterFeeList" value="${result.meriterFee}"/>&nbsp;원
																</span>
															</td>
															<td>	
																<span class="input-text03">
																	<input type="text" class="tr pr10" name="bscLivFeeList" value="${result.bscLivFee}"/>&nbsp;원
																</span>
															</td>
															<td>	
																<span class="input-text03">
																	<input type="text" class="tr pr10" name="singleParentFeeList" value="${result.singleParentFee}"/>&nbsp;원
																</span>
															</td>
															<td>	
																<span class="input-text03">
																	<input type="text" class="tr pr10" name="youthFeeList" value="${result.youthFee}"/>&nbsp;원
																</span>
															</td>
															<td>	
																<span class="input-text03">
																<c:choose>
																	<c:when test="${result.disRate ne null && result.disRate ne ''}">
																		<input type="text" class="tr pr10" name="disRateList" style="width:20px" value="${result.disRate}" rownum onchange="valuechanged(memberFrm, $(this));"/>&nbsp;%할인
																		(<input type="text" class="tr pr10" name="certDisPrice" value="0" readonly/>&nbsp;원)
																	</c:when>
																	<c:otherwise>
																		<input type="hidden" class="tr pr10" name="disRateList" style="width:20px" value=""/>&nbsp;
																		<input type="hidden" class="tr pr10" name="certDisPrice" value="0" readonly/>&nbsp;
																	</c:otherwise>
																</c:choose>
																</span>
															</td>
														</tr>
													</c:if>
												</c:forEach>
											</tbody>
										</table>
										
										<table  class="tb_type02 mt20">
											<colgroup>
												<col style="width:20%"/>
												<col style="width:80%"/>
											</colgroup>
											<tbody>
												<tr>
													<th class="top"><em>*</em>대여시간 초과요금</th>
													<td class="top">
														<c:forEach var="result" items="${addChargePolicyList }" varStatus="status">
															<c:if test="${fn:contains(result.addFeeCls, 'M')}">
																<c:if test="${result.overEndMi != '0' }">
																	<span class="input-text03 ml10"><input type="text" class="tr pr10" name="firstOverStrMiList" value="${result.overStrMi }" onchange="chargeForm.addStrMin(this)"/>
																	<input type="hidden" name="overStrMiList" value="${result.overStrMi }" id="overStartMinute2"/></span>
																	분&nbsp;&nbsp;~
																	<span class="input-text03 ml10"><input type="text" class="tr pr10" name="overEndMiList" id="1" value="${result.overEndMi }" onchange="chargeForm.addMin(this)"/></span>
																	분&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="input-text03 ml10"><input type="text" class="tr pr10" name="addFeeInterMiList" value="${result.addFeeInterMi }" /></span>분 당
																	<span class="input-text03 ml10"><input type="text" class="tr pr10" name="addFeeList" value="${result.addFee }"/></span>
																	<input type="hidden" name="addFeeSeqList" value="${result.addFeeSeq }"/>
																	원<br/>
																</c:if>
																<c:if test="${result.overEndMi == '0' }">
																	<span class="input-text03 ml10"><input type="text" class="tr pr10" name="lastOverStrMiList" value="${result.overStrMi }" readonly="readonly"/>
																	<input type="hidden" name="overStrMiList" value="${result.overStrMi }"/></span>
																	분&nbsp;&nbsp;이후&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="input-text03 ml10"><input type="text" class="tr pr10" name="addFeeInterMiList" value="${result.addFeeInterMi }" /></span>분 당
																	<span class="input-text03 ml10"><input type="text" class="tr pr10" name="addFeeList" value="${result.addFee }"/></span>
																	<input type="hidden" name="addFeeSeqList" value="${result.addFeeSeq }"/>
																	원
																</c:if>
															</c:if>
														</c:forEach>
													</td>
												</tr>
											</tbody>
										</table>
										
										<div class="btnArea">
											<span class="right"><button class="btnType01 bc_green" type="button" id="memberSaveBtn">저장</button></span>
										</div>
									</fieldset>
								</form>
							</div>
							<!-- 일일권(회원) E  -->
							
							<!-- 일일권(비회원) S  -->
							<div class="tabCon">
								<form action="action" id="nonMemberFrm">
									<fieldset>
									<legend>일일권(비회원)</legend>
										<table  class="tb_type01">
											<colgroup>
												<%-- <col style="width:9%"/>
												<col style="width:11%"/>
												<col style="width:8%"/>
												<col style="width:11%"/>
												<col style="width:11%"/>
												<col style="width:11%"/>
												<col style="width:11%"/>
												<col style="width:11%"/>
												<col style="width:11%"/> 
												변경시 전체적으로 넓이 수정 요망
												--%>
												<col style="width:13%"/>
												<col style="width:12%"/>
												<col style="width:9%"/>
												<col style="width:12%"/>
												<col style="width:12%"/>
												<col style="width:12%"/>
												<col style="width:12%"/>
												<col style="width:12%"/> 
											</colgroup>
											<tbody>
												<tr>
													<th>구분</th>
													<th>기본</th>
													<th>마일리지<br>사용여부</th>
													<!-- <th>할인요금</th> -->
													<th>제로페이</th>
													<th>국가유공자</th>
													<th>기초생활</th>
													<th>한부모</th>
													<th>청소년</th>
												</tr>
												<c:forEach var="result" items="${rentChargePolicyList }" varStatus="status">
													<c:if test="${(fn:contains(result.addVal3, 'RCC_003'))}">
														<tr>
															<td>${result.cdDesc }</td>
														<td>
															<span class="input-text03">
																<input type="text" class="tr pr10" name="rentFeeList" value="${result.rentFee }"/>&nbsp;원 
																<input type="hidden" name="rentFeeSeqList" value="${result.rentFeeSeq }"/>
																<input type="hidden" name="paymentClsCd" value="${result.paymentClsCd }"/>
																<!-- 기존 할인 요금 표출 정지 -->
																<input type="hidden" name="discountFeeList" value="${result.discountFee }"/>
															</span>
														</td>
														<td class="tc">	
																<input type="checkbox" name="mileageUseYnList" value="${result.rentFeeSeq}" <c:if test='${result.mileageUseYn == "Y" }' >checked="chekced"</c:if>/>&nbsp;<label for="mileageYN"></label>
														</td>
														<%-- <span class="input-text03">
																<input type="text" class="tr pr10" name="discountFeeList" value="${result.discountFee }"/>원&nbsp;할인
															</span> --%>
														<td>	
															<span class="input-text03">
																<input type="text" class="tr pr10" name="zeroPayDiscountFeeList" value="${result.zeroPayDiscountFee }"/>&nbsp;원
															</span>
														</td>
														<td>	
															<span class="input-text03">
																<input type="text" class="tr pr10" name="meriterFeeList" value="${result.meriterFee}"/>&nbsp;원
															</span>
														</td>
														<td>	
															<span class="input-text03">
																<input type="text" class="tr pr10" name="bscLivFeeList" value="${result.bscLivFee}"/>&nbsp;원
															</span>
														</td>
														<td>	
															<span class="input-text03">
																<input type="text" class="tr pr10" name="singleParentFeeList" value="${result.singleParentFee}"/>&nbsp;원
															</span>
														</td>
														<td>	
															<span class="input-text03">
																<input type="text" class="tr pr10" name="youthFeeList" value="${result.youthFee}"/>&nbsp;원
															</span>
														</td>
													</tr>
													</c:if>
												</c:forEach>
											</tbody>
										</table>
										
										<table  class="tb_type02 mt20">
											<colgroup>
												<col style="width:20%"/>
												<col style="width:80%"/>
											</colgroup>
											<tbody>
												<tr>
													<th class="top"><em>*</em>대여시간 초과요금</th>
													<td class="top">
														<c:forEach var="result" items="${addChargePolicyList }" varStatus="status">
															<c:if test="${fn:contains(result.addFeeCls, 'N')}">
																<c:if test="${result.overEndMi != '0' }">
																	<span class="input-text03 ml10"><input type="text" class="tr pr10" name="firstOverStrMiList" value="${result.overStrMi }" onchange="chargeForm.addStrMin(this)"/>
																	<input type="hidden" name="overStrMiList" value="${result.overStrMi }" id="overStartMinute3"/></span>
																	분&nbsp;&nbsp;~
																	<span class="input-text03 ml10"><input type="text" class="tr pr10" name="overEndMiList" id="2" value="${result.overEndMi }" onchange="chargeForm.addMin(this)"/></span>
																	분&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="input-text03 ml10"><input type="text" class="tr pr10" name="addFeeInterMiList" value="${result.addFeeInterMi }" /></span>분 당
																	<span class="input-text03 ml10"><input type="text" class="tr pr10" name="addFeeList" value="${result.addFee }"/></span>
																	<input type="hidden" name="addFeeSeqList" value="${result.addFeeSeq }"/>
																	원<br/>
																</c:if>
																<c:if test="${result.overEndMi == '0' }">
																	<span class="input-text03 ml10"><input type="text" class="tr pr10" name="lastOverStrMiList" value="${result.overStrMi }" readonly="readonly"/>
																	<input type="hidden" name="overStrMiList" value="${result.overStrMi }"/></span>
																	분&nbsp;&nbsp;이후&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="input-text03 ml10"><input type="text" class="tr pr10" name="addFeeInterMiList" value="${result.addFeeInterMi }" /></span>분 당
																	<span class="input-text03 ml10"><input type="text" class="tr pr10" name="addFeeList" value="${result.addFee }"/></span>
																	<input type="hidden" name="addFeeSeqList" value="${result.addFeeSeq }"/>
																	원
																</c:if>
															</c:if>
														</c:forEach>
													</td>
												</tr>
											</tbody>
										</table>
										
										<div class="btnArea">
											<span class="right"><button class="btnType01 bc_green" type="button" id="nonMemberSaveBtn">저장</button></span>
										</div>
									</fieldset>
								</form>
							</div>
							<!-- 일일권(비회원) E  -->
							
							<!-- 단체권 S  -->
							<div class="tabCon">
								<form action="action" id="groupFrm">
									<fieldset>
									<legend>단체권</legend>
										<table  class="tb_type01">
											<colgroup>
												<%-- <col style="width:9%"/>
												<col style="width:11%"/>
												<col style="width:8%"/>
												<col style="width:11%"/>
												<col style="width:11%"/>
												<col style="width:11%"/>
												<col style="width:11%"/>
												<col style="width:11%"/>
												<col style="width:11%"/> 
												변경시 전체적으로 넓이 수정 요망
												--%>
												<col style="width:13%"/>
												<col style="width:12%"/>
												<col style="width:9%"/>
												<col style="width:12%"/>
												<col style="width:12%"/>
												<col style="width:12%"/>
												<col style="width:12%"/>
												<col style="width:12%"/> 
											</colgroup>
											<tbody>
												<tr>
													<th>구분</th>
													<th>기본</th>
													<th>마일리지<br>사용여부</th>
													<!-- <th>할인요금</th> -->
													<th>제로페이</th>
													<th>국가유공자</th>
													<th>기초생활</th>
													<th>한부모</th>
													<th>청소년</th>
												</tr>
												<c:forEach var="result" items="${rentChargePolicyList }" varStatus="status">
													<c:if test="${(fn:contains(result.addVal3, 'RCC_004'))}">
														<tr>
															<td>${result.cdDesc }</td>
														<td>
															<span class="input-text03">
																<input type="text" class="tr pr10" name="rentFeeList" value="${result.rentFee }"/>&nbsp;원 
																<input type="hidden" name="rentFeeSeqList" value="${result.rentFeeSeq }"/>
																<input type="hidden" name="paymentClsCd" value="${result.paymentClsCd }"/>
																<!-- 기존 할인 요금 표출 정지 -->
																<input type="hidden" name="discountFeeList" value="${result.discountFee }"/>
															</span>
														</td>
														<td class="tc">	
																<input type="checkbox" name="mileageUseYnList" value="${result.rentFeeSeq}" <c:if test='${result.mileageUseYn == "Y" }' >checked="chekced"</c:if>/>&nbsp;<label for="mileageYN"></label>
														</td>
														<%-- <span class="input-text03">
																<input type="text" class="tr pr10" name="discountFeeList" value="${result.discountFee }"/>원&nbsp;할인
															</span> --%>
														<td>	
															<span class="input-text03">
																<input type="text" class="tr pr10" name="zeroPayDiscountFeeList" value="${result.zeroPayDiscountFee }"/>&nbsp;원
															</span>
														</td>
														<td>	
															<span class="input-text03">
																<input type="text" class="tr pr10" name="meriterFeeList" value="${result.meriterFee}"/>&nbsp;원
															</span>
														</td>
														<td>	
															<span class="input-text03">
																<input type="text" class="tr pr10" name="bscLivFeeList" value="${result.bscLivFee}"/>&nbsp;원
															</span>
														</td>
														<td>	
															<span class="input-text03">
																<input type="text" class="tr pr10" name="singleParentFeeList" value="${result.singleParentFee}"/>&nbsp;원
															</span>
														</td>
														<td>	
															<span class="input-text03">
																<input type="text" class="tr pr10" name="youthFeeList" value="${result.youthFee}"/>&nbsp;원
															</span>
														</td>
													</tr>
													</c:if>
												</c:forEach>
											</tbody>
										</table>
										
										<table  class="tb_type02 mt20">
											<colgroup>
												<col style="width:20%"/>
												<col style="width:80%"/>
											</colgroup>
											<tbody>
												<tr>
													<th class="top"><em>*</em>대여시간 초과요금 </th>
													<td class="top">
														<c:forEach var="result" items="${addChargePolicyList }" varStatus="status">
															<c:if test="${fn:contains(result.addFeeCls, 'N')}">
																<c:if test="${result.overEndMi != '0' }">
																	<span class="input-text03 ml10"><input type="text" class="tr pr10" name="firstOverStrMiList" value="${result.overStrMi }" onchange="chargeForm.addStrMin(this)"/>
																	<input type="hidden" name="overStrMiList" value="${result.overStrMi }" id="overStartMinute3"/></span>
																	분&nbsp;&nbsp;~
																	<span class="input-text03 ml10"><input type="text" class="tr pr10" name="overEndMiList" id="2" value="${result.overEndMi }" onchange="chargeForm.addMin(this)"/></span>
																	분&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="input-text03 ml10"><input type="text" class="tr pr10" name="addFeeInterMiList" value="${result.addFeeInterMi }" /></span>분 당
																	<span class="input-text03 ml10"><input type="text" class="tr pr10" name="addFeeList" value="${result.addFee }"/></span>
																	<input type="hidden" name="addFeeSeqList" value="${result.addFeeSeq }"/>
																	원<br/>
																</c:if>
																<c:if test="${result.overEndMi == '0' }">
																	<span class="input-text03 ml10"><input type="text" class="tr pr10" name="lastOverStrMiList" value="${result.overStrMi }" readonly="readonly"/>
																	<input type="hidden" name="overStrMiList" value="${result.overStrMi }"/></span>
																	분&nbsp;&nbsp;이후&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="input-text03 ml10"><input type="text" class="tr pr10" name="addFeeInterMiList" value="${result.addFeeInterMi }" /></span>분 당
																	<span class="input-text03 ml10"><input type="text" class="tr pr10" name="addFeeList" value="${result.addFee }"/></span>
																	<input type="hidden" name="addFeeSeqList" value="${result.addFeeSeq }"/>
																	원
																</c:if>
															</c:if>
														</c:forEach>
													</td>
												</tr>
											</tbody>
										</table>
										
										<div class="btnArea">
											<span class="right"><button class="btnType01 bc_green" type="button" id="groupMemberSaveBtn">저장</button></span>
										</div>
									</fieldset>
								</form>
							</div>
							<!-- 단체권 E  -->
						</div>
					</div>
				</div>
				<!--content E-->
                
			</div>
        </div>
        <!--footer S-->
        <tiles:insertAttribute name="footer" />
        <!--footer E-->
    </div>
    
<script type="text/javascript" src="/js/common_barocle.js"></script>
<script type="text/javascript">	
	$(function() {
		chargeForm.initBtn();
		chargeForm.initVal();
		initDisPrice('seasonFrm');
		initDisPrice('memberFrm');
	});
	
	
	var chargeForm = {};
	
	var template = "<span>";
	template += "<span class='input-text08 ml10'>";
	template += "<input type='text' class='tr pr10' name='applyStrHHList'/></span> 시 ~ ";
	template += "<span class='input-text08 ml10'>";
	template += "<input type='text' class='tr pr10' name='applyEndHHList'/></span> 시 ";
	template += "<span class='input-text08 ml20'>";
	template += "<input type='text' class='tr pr10' name='specialFeeList'/></span> 원 ";
	template += "<button class='fullBtn' type='button' onclick='chargeForm.rowDel(this)'><img src='/images/btn_delAnswer.png' alt=''/></button>";
	template += "<input type='hidden' name='specialFeeSeqList'/>";
	template += "<input type='hidden' name='specialFeeClsCdList' value='SDV_001'/>";
	template += "<input type='hidden' name='applyHHStateList' value='I'/>";
	template += "<br/></span>";
	
	
	chargeForm.initBtn = function () {
		
		$("#rowAddBtn1").on("click", function() {
			$("#specialTime1").append(template);
		});
		
		//$('<span class="pwtableblock input-ck02"><input type="checkbox" id="premiumSeason" value=""/><label for="premiumSeason">'+'프리미엄 정기권'+'</label></span>').appendTo('#premiumTD');
		//$('<span class="pwtableblock input-ck02"><input type="checkbox" id="premiumMday" value=""/><label for="premiumMday">'+'프리미엄 일일권'+'</label></span>').appendTo('#premiumTD');
		
		$("#rowAddBtn2").on("click", function() {
			$("#specialTime2").append(template);
		});
		
		$("#seasonSaveBtn").on("click", function() {
			if(chargeForm.checkVal($("#seasonFrm"))) {
				$("#seasonSaveBtn").attr("disabled", true);
				commonAjax.postAjax("/admin/service/policyMgmt/modChargePolicy.do", "json", 
		   				$("#seasonFrm").serialize(), 
		   				function(data) {
			   				if(data) {
								if(data.isSuccess == "true") {
									alert("저장되었습니다.");
									location.reload();
								} else {
									alert("저장 실패하였습니다.");
	   								$("#seasonSaveBtn").attr("disabled", true);		
								}
							}
				});
			}
		});

		$("#memberSaveBtn").on("click", function() {
			if(chargeForm.checkVal($("#memberFrm"))) {
				$("#memberSaveBtn").attr("disabled", true);
				commonAjax.postAjax("/admin/service/policyMgmt/modChargePolicy.do", "json", 
		   				$("#memberFrm").serialize(), 
		   				function(data) {
			   				if(data) {
								if(data.isSuccess == "true") {
									alert("저장되었습니다.");
									location.reload();
								} else {
									alert("저장 실패하였습니다.");
			   						$("#memberSaveBtn").attr("disabled", false);
								}
							}
				});
			}
		});
		
		$("#nonMemberSaveBtn").on("click", function() {
			if(chargeForm.checkVal($("#nonMemberFrm"))) {
				$("#nonMemberSaveBtn").attr("disabled", true);
				commonAjax.postAjax("/admin/service/policyMgmt/modChargePolicy.do", "json", 
		   				$("#nonMemberFrm").serialize(), 
		   				function(data) {
			   				if(data) {
								if(data.isSuccess == "true") {
									alert("저장되었습니다.");
									location.reload();
								} else {
									alert("저장 실패하였습니다.");
					   				$("#nonMemberSaveBtn").attr("disabled", false);
								}
							}
				});
			}
		});
		
		$("#groupMemberSaveBtn").on("click", function() {
			if(chargeForm.checkVal($("#groupFrm"))) {
				$("#groupMemberSaveBtn").attr("disabled", true);
				commonAjax.postAjax("/admin/service/policyMgmt/modChargePolicy.do", "json", 
		   				$("#groupFrm").serialize(), 
		   				function(data) {
			   				if(data) {
								if(data.isSuccess == "true") {
									alert("저장되었습니다.");
									location.reload();
								} else {
									alert("저장 실패하였습니다.");
					   				$("#groupMemberSaveBtn").attr("disabled", false);
								}
							}
				});
			}
		});
		
		$("#premiumSaveBtn").on("click", function() {				
			if(chargeForm.checkVal($("#premiumFrm"))) {
				$("#premiumSaveBtn").attr("disabled", true);
		
				var premiumSeasonUseYn = $("input:checkbox[id='premiumSeason']").is(":checked");
				var premiumMdayUseYn = $("input:checkbox[id='premiumMday']").is(":checked");
				
				
				if(premiumSeasonUseYn)
				{
					$("input[name='premiumSeason']").val('Y');
				}else{
					$("input[name='premiumSeason']").val('N');
				}
				
				if(premiumMdayUseYn)
				{
					$("input[name='premiumMday']").val('Y');
				}else{
					$("input[name='premiumMday']").val('N');
				}
				
				$("input[name='rentFeeList']").eq(11).val($("input[name='rentFeeList']").eq(10).val());				
				$("input[name='overStrMiList']").eq(6).val($("input[name='firstOverStrMiList']").eq(3).val());
				
				commonAjax.postAjax("/admin/service/policyMgmt/modChargePolicy.do", "json", 
		   				$("#premiumFrm").serialize(), 
		   				function(data) {
			   				if(data) {
								if(data.isSuccess == "true") {
									alert("저장되었습니다.");
									location.reload();
								} else {
									alert("저장 실패하였습니다.");
	   								$("#premiumSaveBtn").attr("disabled", true);		
								}
							}
				});
			}
		});
		
	}
	
	chargeForm.initVal = function () {
		
		if($("#premiumSeason").val() == 'Y'){
			$("input:checkbox[id='premiumSeason']").prop("checked", true);
			$("input[name='premiumSeason']").val('Y');
		}else{
			$("input[name='premiumSeason']").val('N');
		}
		
		if($("#premiumMday").val() == 'Y'){
			$("input:checkbox[id='premiumMday']").prop("checked", true);
			$("input[name='premiumMday']").val('Y');
		}else{
			$("input[name='premiumMday']").val('N');
		}
	}
	
	chargeForm.addStrMin = function (min) {
		if(!isNumeric($(min).val())) {
			alert("숫자만 입력가능 합니다.");
        	$(min).val("").focus();
        	return false;
		}
		
		var rst = false;
		
		$("input[name='overStrMiList']").each(function(index) {
			var min_index = (parseInt(min.id) + 1);

			if(index == ((min_index * 2) - 1)){
				$(this).val(parseInt($(min).val()));
//				alert($(this).val());
			}

		});
		
	} 
	
	
	
	chargeForm.addMin = function (min) {
		if(!isNumeric($(min).val())) {
			alert("숫자만 입력가능 합니다.");
        	$(min).val("").focus();
        	return false;
		}
		
		var rst = false;
		$("input:hidden[name='overStrMiList']").each(function(index) {
			if(index == (parseInt(min.id)==0?0:parseInt(min.id)==1?2:4)) {
				if(parseInt($(this).val()) >= parseInt($(min).val())) {
					alert("시작 분보다 커야합니다.");
					$(min).val("").focus();
		        	rst = true;
		        	return false;
				}
			}
		});
		if(rst)
			return false;
		
		$("input:hidden[name='maxRentTime']").each(function(index) {
			if(index == (parseInt(min.id))) {
				if(parseInt($(min).val()) > parseInt($("input:hidden[name='maxRentTime']").eq(index).val())) {
					alert("최대 대여시간보다 작아야합니다.");
					$(min).val(parseInt($("input:hidden[name='maxRentTime']").eq(index).val()) - 1).focus();
					return false;
				}
			}
		});

		/*
		if(parseInt($(min).val()) > parseInt($("input:hidden[name='maxRentTime']").val())) {
			alert("최대 대여 시간보다 작아야합니다.");
			$(min).val("").focus();
			return false;
		}*/
		
		$("input[name='lastOverStrMiList']").each(function(index) {
			if(index == min.id)
				$(this).val(parseInt($(min).val())+1);
		});
		
		$("input:hidden[name='overStrMiList']").each(function(index) {
			var min_index = (parseInt(min.id) + 1);

			if(index == ((min_index * 2) - 1)){
				$(this).val(parseInt($(min).val())+1);
			}
				
		});
	}
	
	chargeForm.checkVal = function (frm) {
		var rst = false;
		$(frm).find("input[type='text']").each(function() {
			if(!isNumeric($(this).val())) {
	        	alert("숫자만 입력가능 합니다.");
	        	$(this).val("").focus();
	        	rst = true;
	        	return false;
	        }
		});
		if(rst)
			return false;
		
		$(frm).find("input[name='applyStrHHList']").each(function(idx) {
			if(parseInt($(this).val()) > 24) {
				alert("특례 시간은 0시 ~ 24시입니다.");
	        	$(this).val("").focus();
	        	rst = true;
	        	return false;
			} 
		});
		if(rst)
			return false;
		
		$(frm).find("input[name='applyEndHHList']").each(function(idx) {
			if(parseInt($(this).val()) > 24) {
				alert("특례 시간은 0시 ~ 24시입니다.");
	        	$(this).val("").focus();
	        	rst = true;
	        	return false;
			} 
		});
		if(rst)
			return false;
		
		$(frm).find("input[name='applyEndHHList']").each(function(idx) {
			if(parseInt($(this).val()) <= parseInt($(frm).find("input[name='applyStrHHList']").eq(idx).val())) {
				alert("특례 종료 시간이 시작 시간보다 커야합니다.");
	        	$(this).val("").focus();
	        	rst = true;
	        	return false;
			}
		});
		if(rst)
			return false;
		
		$(frm).find("input[name='applyStrHHList']").each(function(idx) {
			for(var i=0;i<$(frm).find("input[name='applyStrHHList']").length;i++) {
				if(i != idx) {
					if(parseInt($(this).val()) >= parseInt($(frm).find("input[name='applyStrHHList']").eq(i).val()) &&
							parseInt($(this).val()) < parseInt($(frm).find("input[name='applyEndHHList']").eq(i).val())) {
						alert("특례 시간 범위가 중복됩니다.");
			        	$(this).val("").focus();
			        	rst = true;
			        	return false;
					}
				}
			}
		});
		if(rst)
			return false;
		
		$(frm).find("input[name='applyEndHHList']").each(function(idx) {
			for(var i=0;i<$(frm).find("input[name='applyStrHHList']").length;i++) {
				if(i != idx) {
					if(parseInt($(this).val()) > parseInt($(frm).find("input[name='applyStrHHList']").eq(i).val()) &&
							parseInt($(this).val()) <= parseInt($(frm).find("input[name='applyEndHHList']").eq(i).val())) {
						alert("특례 시간 범위가 중복됩니다.");
			        	$(this).val("").focus();
			        	rst = true;
			        	return false;
					}
				}
			}
		});
		if(rst)
			return false;
		

		//$(frm).find("input[name='overStrMiList']").val($(frm).find("input[name='firstOverStrMiList']").val())
		/* if($(frm).find("input[name='firstOverStrMiList']").val() != parseInt($(frm).find("input[name='basicRentTimeID']").val())+1){
			alert("기본대여(분)시간 +1분 으로 설정해주세요.");
        	$(this).val("").focus();
        	rst = true;
        	return false;
		} */
		if(rst)
			return false;
		
		
		return true;
	}
	
	chargeForm.rowDel = function (e) {

		var parent = e.parentNode;
		
		if(e.id != "") {
			
			if(confirm("삭제 하시겠습니까?")) {
		    	commonAjax.postAjax("/admin/service/policyMgmt/delSpecialTimeChargePolicyAjax.do", "json", 
		   				{specialFeeSeq : e.id}, 
		   				function(data) {
			   				if(data) {
								if(data.isDel == "true") {
									alert("삭제되었습니다.");
									$(parent).remove();
								} else {
									alert("삭제 실패하였습니다.");
								}
							}	
				});
			}
		} else {
			$(parent).remove();
		}
	};
	
	function initDisPrice(formName){
		var orgPriceList = $("#"+formName+" input[name=rentFeeList]");
		var disRateList = $("#"+formName+" input[name=disRateList]");
		var disPriceList = $("#"+formName+" input[name=certDisPrice]");
		
		//배열에 값 주입
		for(var i=0; i<disRateList.length; i++){                          
			var disRate = disRateList.eq(i).val();
			var orgPrice = orgPriceList.eq(i).val();
			var disPriceVal = (Number(orgPrice) * Number(disRate) / 100);
			var value = Number(orgPrice)-Number(disPriceVal);
			disPriceList.eq(i).val(value);
			disRateList.eq(i).attr("rownum",i);
	        //console.log("initDisPrice:"+i+" value:"+value);
		}
	}
	
	function valuechanged(form, obj) {
		var rownum = obj.attr("rownum");
		//alert('2:'+rownum);
		var orgPrice = form.rentFeeList[rownum].value;
		var disRate = obj.val();
		//alert('3:'+disRate);
		var disPriceVal = (Number(orgPrice) * Number(disRate) / 100);
		//alert('4:'+disPriceVal);
		//alert('4:'+form.certDisPrice[rownum]);
		form.certDisPrice[rownum].value = Number(orgPrice)-Number(disPriceVal);
		//alert(5);
	}
	
</script>