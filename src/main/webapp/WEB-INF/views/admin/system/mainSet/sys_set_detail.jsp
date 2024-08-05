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
				<!--content S-->
				<div class="content">
					<div class="subject">
						<!--subject path S-->
							<tiles:insertAttribute name="subject" />
						<!--subject path E-->
					</div>
					<div class="page">
					<form:form id="frm" commandName="form" accept-charset="utf-8" modelAttribute="mainSetList" onsumit="return false;">
					<input type="hidden" id="mainCheck" name="mainCheck"  value="">
					<input type="hidden" id="mainCheck2" name="mainCheck2"  value="">
					<input type="hidden" id="windowWh" name="windowWh"  value="">
							<fieldset>
								<table class="tb_type02 mt20">
									<colgroup>
										<col style="width:40%">
										<col style="width:60%">
									</colgroup>
									<tbody>
									<c:forEach items="${mainSetView}" var="mainSetVO" varStatus="status">
										<c:choose>
											<c:when test="${mainSetVO.comCD eq 'MSI_001'}">
												<tr>
													<th class="top"><em>*</em> <c:out value="${mainSetVO.mLangComCDName}" />
													<td class="top">
														<form:input type="hidden" path="msiList[0].comCD" />
														<select id="msiListAddValSel_1_1" name="msiList[0].addVal1">
															<option value="">선택</option>
															<option value="00" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '00'}">selected="true"</c:if>>00</option>
															<option value="01" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '01'}">selected="true"</c:if>>01</option>
															<option value="02" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '02'}">selected="true"</c:if>>02</option>
															<option value="03" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '03'}">selected="true"</c:if>>03</option>
															<option value="04" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '04'}">selected="true"</c:if>>04</option>
															<option value="05" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '05'}">selected="true"</c:if>>05</option>
															<option value="06" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '06'}">selected="true"</c:if>>06</option>
															<option value="07" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '07'}">selected="true"</c:if>>07</option>
															<option value="08" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '08'}">selected="true"</c:if>>08</option>
															<option value="09" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '09'}">selected="true"</c:if>>09</option>
															<option value="10" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '10'}">selected="true"</c:if>>10</option>
															<option value="11" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '11'}">selected="true"</c:if>>11</option>
															<option value="12" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '12'}">selected="true"</c:if>>12</option>
															<option value="13" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '13'}">selected="true"</c:if>>13</option>
															<option value="14" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '14'}">selected="true"</c:if>>14</option>
															<option value="15" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '15'}">selected="true"</c:if>>15</option>
															<option value="16" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '16'}">selected="true"</c:if>>16</option>
															<option value="17" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '17'}">selected="true"</c:if>>17</option>
															<option value="18" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '18'}">selected="true"</c:if>>18</option>
															<option value="19" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '19'}">selected="true"</c:if>>19</option>
															<option value="20" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '20'}">selected="true"</c:if>>20</option>
															<option value="21" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '21'}">selected="true"</c:if>>21</option>
															<option value="22" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '22'}">selected="true"</c:if>>22</option>
															<option value="23" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '23'}">selected="true"</c:if>>23</option>
															<option value="24" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,0,2) eq '24'}">selected="true"</c:if>>24</option>
														</select>시
														<select id="msiListAddValSel_1_2" name="msiList[0].addVal1">
															<option value="">선택</option>
															<option value="00" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,3,5) eq '00'}">selected="true"</c:if>>00</option>
															<option value="05" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,3,5) eq '05'}">selected="true"</c:if>>05</option>
															<option value="10" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,3,5) eq '10'}">selected="true"</c:if>>10</option>
															<option value="15" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,3,5) eq '15'}">selected="true"</c:if>>15</option>
															<option value="20" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,3,5) eq '20'}">selected="true"</c:if>>20</option>
															<option value="25" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,3,5) eq '25'}">selected="true"</c:if>>25</option>
															<option value="30" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,3,5) eq '30'}">selected="true"</c:if>>30</option>
															<option value="35" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,3,5) eq '35'}">selected="true"</c:if>>35</option>
															<option value="40" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,3,5) eq '40'}">selected="true"</c:if>>40</option>
															<option value="45" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,3,5) eq '45'}">selected="true"</c:if>>45</option>
															<option value="50" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,3,5) eq '50'}">selected="true"</c:if>>50</option>
															<option value="55" <c:if test="${fn:substring(mainSetList.msiList[0].addVal1,3,5) eq '55'}">selected="true"</c:if>>55</option>
														</select>분
														~
														<p class="pwtableblock">
														<select id="msiListAddValSel_2_1" name="msiList[0].addVal2">
															<option value="">선택</option>
															<option value="00" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '00'}">selected="true"</c:if>>00</option>
															<option value="01" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '01'}">selected="true"</c:if>>01</option>
															<option value="02" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '02'}">selected="true"</c:if>>02</option>
															<option value="03" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '03'}">selected="true"</c:if>>03</option>
															<option value="04" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '04'}">selected="true"</c:if>>04</option>
															<option value="05" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '05'}">selected="true"</c:if>>05</option>
															<option value="06" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '06'}">selected="true"</c:if>>06</option>
															<option value="07" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '07'}">selected="true"</c:if>>07</option>
															<option value="08" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '08'}">selected="true"</c:if>>08</option>
															<option value="09" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '09'}">selected="true"</c:if>>09</option>
															<option value="10" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '10'}">selected="true"</c:if>>10</option>
															<option value="11" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '11'}">selected="true"</c:if>>11</option>
															<option value="12" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '12'}">selected="true"</c:if>>12</option>
															<option value="13" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '13'}">selected="true"</c:if>>13</option>
															<option value="14" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '14'}">selected="true"</c:if>>14</option>
															<option value="15" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '15'}">selected="true"</c:if>>15</option>
															<option value="16" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '16'}">selected="true"</c:if>>16</option>
															<option value="17" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '17'}">selected="true"</c:if>>17</option>
															<option value="18" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '18'}">selected="true"</c:if>>18</option>
															<option value="19" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '19'}">selected="true"</c:if>>19</option>
															<option value="20" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '20'}">selected="true"</c:if>>20</option>
															<option value="21" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '21'}">selected="true"</c:if>>21</option>
															<option value="22" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '22'}">selected="true"</c:if>>22</option>
															<option value="23" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '23'}">selected="true"</c:if>>23</option>
															<option value="24" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,0,2) eq '24'}">selected="true"</c:if>>24</option>
														</select>시
														<select id="msiListAddValSel_2_2" name="msiList[0].addVal2">
															<option value="">선택</option>
															<c:forEach begin="0" end="59" step="1" varStatus="loop">
															    <c:if test="${loop.index < 10 }">
																	<option value="0${loop.index }" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,3,6) eq loop.index }">selected="true"</c:if>>0${loop.index }</option>
															    </c:if>
															    <c:if test="${loop.index > 9 }">
																	<option value="${loop.index }" <c:if test="${fn:substring(mainSetList.msiList[0].addVal2,3,5)  eq loop.index }">selected="true"</c:if>>${loop.index }</option>
															    </c:if>
															</c:forEach>
														</select>분
														</p>
														<p style="margin-top :5PX;">익일설정 예 : 05:00 ~ 01:00로 설정시 당일 5시 부터 익일 1시까지 운영</p>
													</td>
												</tr>
											</c:when>
											<c:when test="${mainSetVO.comCD eq 'MSI_009'}">
		                                        <tr>
		                                            <th><em>*</em> <c:out value="${mainSetVO.mLangComCDName}" /></th>
		                                            <td>
		                                                <form:input type="hidden" path="msiList[${status.index}].comCD" />
		                                                <span class="pwtableblock">최소 <span class="input-text08"><form:input id="msiListAddVal1_${status.index}" path="msiList[${status.index}].addVal1" type="text" numberOnly="true" maxLength="8" /></span> </span>
		                                                <span class="pwtableblock">최대 <span class="input-text08"><form:input id="msiListAddVal2_${status.index}" path="msiList[${status.index}].addVal2" type="text" numberOnly="true" maxLength="8" /></span> </span>
		                                            </td>
		                                        </tr>
		                                    </c:when>
											<c:when test="${mainSetVO.comCD eq 'MSI_010'}">
												<tr>
													<th><em>*</em> <c:out value="${mainSetVO.mLangComCDName}" /></th>
													<td>
														<form:input type="hidden" path="msiList[${status.index}].comCD" />
														<span class="pwtableblock">최소 <span class="input-text08"><form:input id="msiListAddVal1_${status.index}" path="msiList[${status.index}].addVal1" type="text" numberOnly="true" maxLength="8" /></span> </span>
														<span class="pwtableblock">최대 <span class="input-text08"><form:input id="msiListAddVal2_${status.index}" path="msiList[${status.index}].addVal2" type="text" numberOnly="true" maxLength="8" /></span> </span>
													</td>
												</tr>
											</c:when>
											<c:when test="${mainSetVO.comCD eq 'MSI_022'}">
	                                    		<tr>
		                                            <th><em>*</em> <c:out value="${mainSetVO.mLangComCDName}" /></th>
		                                            <td>
		                                                <form:input type="hidden" path="msiList[${status.index}].comCD" />
		                                                <span class="input-text08"><form:input id="msiListAddVal1_${status.index}" path="msiList[${status.index}].addVal1" type="text" numberOnly="true" maxLength="8" /></span>
		                                            </td>
		                                        </tr>
	                                    	</c:when>
	                                    	<c:when test="${mainSetVO.comCD eq 'MSI_023'}">
	                                    		<tr>
		                                            <th><em>*</em> <c:out value="${mainSetVO.mLangComCDName}" /></th>
		                                            <td>
		                                                <form:input type="hidden" path="msiList[${status.index}].comCD" />
		                                                <span class="input-text08"><form:input id="msiListAddVal1_${status.index}" path="msiList[${status.index}].addVal1" type="text" numberOnly="true" maxLength="8" /></span>
		                                            </td>
		                                        </tr>
	                                    	</c:when>
											<c:when test="${mainSetVO.comCD eq 'MSI_020'}"><br>
		                                        <tr>
		                                            <th><em>*</em> <c:out value="${mainSetVO.mLangComCDName}" /></th>
		                                            <td>
		                                                <form:input type="hidden" path="msiList[${status.index}].comCD" />
		                                                <span class="pwtableblock"><span class="input-text08"><form:input id="sms1" path="msiList[${status.index}].addVal1" type="text"  maxLength="13" /></span> </span>
		                                                <span class="pwtableblock"><span class="input-text08"><form:input id="sms2" path="msiList[${status.index}].addVal2" type="text"  maxLength="13" /></span> </span>
		                                                <span class="pwtableblock"><span class="input-text08"><form:input id="sms3" path="msiList[${status.index}].addVal3" type="text"  maxLength="13" /></span> </span>
		                                            </td>
		                                        </tr>
		                                    </c:when>
		                                     <c:when test="${mainSetVO.comCD eq 'MSI_025'}">
			                                        <tr>
			                                            <th rowspan="5"><em>*</em> <c:out value="재배치 유도" /></th>
				                                          <%-- <td>	<!-- 점유율 사용 안함_2017.03.27_JHN -->
			                                                <form:input type="hidden" path="msiList[${status.index}].comCD" />
			                                                <div style='float:left; margin-top: 7px;'>
			                                            		점유율(%)
			                                            	</div>
			                                            	<div id="textChg1" style='text-align:left;'>   
			                                            	<input type="text"  value="${mainVal1 }" id="mainVal1" name="mainVal1"   style="width: 80px;"/>
			                                            	</div>			
			                                            </td>    --%>
			                                        </tr>
			                                        <tr>
				                                          <td>
			                                                <form:input type="hidden" path="msiList[${status.index}].comCD" />
			                                                <div style='float:left; margin-top: 7px;'>
			                                            		반경(m)
			                                            	</div>
			                                            	<div id="textChg2" style='text-align:left;'>   
			                                            	<input type="text"  value="${mainVal2 }" id="mainVal2" name="mainVal2"  style="width: 80px;"/>
			                                            	</div>	
			                                            </td>   
			                                        </tr>
			                                        <tr>
				                                          <td>
			                                                <form:input type="hidden" path="msiList[${status.index}].comCD" />
			                                                <div style='float:left; margin-top: 7px;'>
			                                            		1회 적립 POINT
			                                            	</div>
			                                            	<div id="textChg3" style='text-align:left;'>   
			                                            	<input type="text" value="${mainVal3 }" id="mainVal3" name="mainVal3" style="width: 80px;"/>
			                                            	</div>	
			                                            </td>   
			                                        </tr>
			                                        <tr>
				                                          <td>
			                                                <form:input type="hidden" path="msiList[${status.index}].comCD" />
			                                                <div style='float:left; margin-top: 7px;'>
			                                            		일 최대 적립 POINT
			                                            	</div>
			                                            	<div id="textChg4" style='text-align:left;'>  
			                                            	<input type="text" value="${mainVal4 }" id="mainVal4" name="mainVal4" style="width: 80px;"/>
			                                            	</div>	
			                                            </td>   
			                                        </tr>
			                                        <tr>
				                                          <td style="margin-top: 100px;">
			                                                <form:input type="hidden" path="msiList[${status.index}].comCD" />
			                                              
			                                                
			                                                <div style='float:left; margin-top: 10px;'>
			                                            		정책 OPEN 유무 
			                                            	</div>
			                                            	<div id="windowChg" style='text-align:left;'> 
			                                            		<c:if test="${mainVal5 eq 'Y'}">
																	<span class="pwtableblock input-ck02" style="margin-left: 38px; margin-top: 10px;"><input type="checkbox" onclick="isChkY();" id="mainVal5" name="mainVal5" checked="checked" value="Y"/><label for="premiumSeason">&nbsp;유&nbsp;&nbsp;</label>
																	<input type="checkbox" onclick="isChkN();" id="mainVal6" name="mainVal6" value="N"/><label for="premiumSeason">&nbsp;무</label></span>
				                                                </c:if>	
				                                                <c:if test="${mainVal5 eq 'N'}">
				                                                	<span class="pwtableblock input-ck02" style="margin-left: 38px; margin-top: 10px;"><input type="checkbox" onclick="isChkY();" id="mainVal5" name="mainVal5" value="Y"/><label for="premiumSeason">&nbsp;유&nbsp;&nbsp;</label>
																	<input type="checkbox" id="mainVal6" name="mainVal6"  onclick="isChkN();" checked="checked"  value="N"/><label for="premiumSeason">&nbsp;무</label></span>
				                                                </c:if>	
				                                                <c:if test="${mainVal5 == null || mainVal5 == ''}">
				                                                	<span class="pwtableblock input-ck02" style="margin-left: 38px; margin-top: 10px;"><input type="checkbox" onclick="isChkY();" id="mainVal5" name="mainVal5" value="Y"/><label for="premiumSeason">&nbsp;유&nbsp;&nbsp;</label>
																	<input type="checkbox" id="mainVal6" name="mainVal6"  onclick="isChkN();"  value="N"/><label for="premiumSeason">&nbsp;무</label></span>
				                                                </c:if>
			                                            	</div>	
			                                                
			                                            </td>   
			                                        </tr>
		                                    </c:when>
		                                    <c:when test="${mainSetVO.comCD eq 'MSI_030'}">
			                                        <tr>
			                                            <th rowspan="3"><em>*</em> <c:out value="탄소절감" /></th>
				                                          <td>
			                                                <form:input type="hidden" path="msiList[${status.index}].comCD" />
			                                                <div style='float:left; margin-top: 7px;'>
			                                            		1회 적립 POINT
			                                            	</div>
			                                            	<div id="textChg5" style='text-align:left;'> 
			                                            	<input type="text"  value="${mainVal7 }" id="mainVal7" name="mainVal7"  style="width: 80px;"/>
			                                            	</div>			
			                                            </td>   
			                                        </tr>
			                                        <tr>
				                                          <td>
			                                                <form:input type="hidden" path="msiList[${status.index}].comCD" />
			                                                <div style='float:left; margin-top: 7px;'>
			                                            		일 최대 적립 POINT
			                                            	</div>
			                                            	<div id="textChg6" style='text-align:left;'> 
			                                            	<input type="text"  value="${mainVal8 }" id="mainVal8" name="mainVal8"  style="width: 80px;"/>
			                                            	</div>	
			                                            </td>   
			                                        </tr>
			                                        <tr>
				                                          <td style="margin-top: 100px;">
			                                                <form:input type="hidden" path="msiList[${status.index}].comCD" />
			                                              
			                                                
			                                                <div style='float:left; margin-top: 10px;'>
			                                            		정책 OPEN 유무
			                                            		
			                                            	</div>
			                                            	<div id="windowChg2" style='text-align:left;'> 
			                                            		<c:if test="${mainVal9 eq 'Y'}">
																	<span class="pwtableblock input-ck02" style="margin-left: 38px; margin-top: 10px;"><input type="checkbox" onclick="isChkY2();" id="mainVal9" name="mainVal9" checked="checked" value="Y"/><label for="premiumSeason">&nbsp;유&nbsp;&nbsp;</label>
																	<input type="checkbox" onclick="isChkN2();" id="mainVal10" name="mainVal10" value="N"/><label for="premiumSeason">&nbsp;무</label></span>
				                                                </c:if>	
				                                                <c:if test="${mainVal9 eq 'N'}">
				                                                	<span class="pwtableblock input-ck02" style="margin-left: 38px; margin-top: 10px;"><input type="checkbox" onclick="isChkY2();" id="mainVal9" name="mainVal9" value="Y"/><label for="premiumSeason">&nbsp;유&nbsp;&nbsp;</label>
																	<input type="checkbox" id="mainVal10" name="mainVal10"  onclick="isChkN2();" checked="checked"  value="N"/><label for="premiumSeason">&nbsp;무</label></span>
				                                                </c:if>	
				                                                <c:if test="${mainVal9 == null || mainVal9 == ''}">
				                                                	<span class="pwtableblock input-ck02" style="margin-left: 38px; margin-top: 10px;"><input type="checkbox" onclick="isChkY2();" id="mainVal9" name="mainVal9" value="Y"/><label for="premiumSeason">&nbsp;유&nbsp;&nbsp;</label>
																	<input type="checkbox" id="mainVal10" name="mainVal10"  onclick="isChkN2();"  value="N"/><label for="premiumSeason">&nbsp;무</label></span>
				                                                </c:if>
			                                            	</div>	
			                                                
			                                            </td>   
			                                        </tr>
		                                    </c:when>
		                                    <c:when test="${mainSetVO.comCD eq 'MSI_035'}">
			                                        <tr>
			                                            <th rowspan="4"><em>*</em> <c:out value="QR자전거 상태주기보고(분)" /></th>
				                                          <td>
			                                                <form:input type="hidden" path="msiList[${status.index}].comCD" />
			                                                <div style='float:left; margin-top: 7px;'>
			                                            		사용자(대여)
			                                            	</div>
			                                            	<div id="textChg7" style='text-align:left;'> 
			                                            	<input type="text"  value="${mainVal11 }" id="mainVal11" name="mainVal11"  style="width: 80px;"/>
			                                            	</div>			
			                                            </td>   
			                                        </tr>
			                                        <tr>
				                                          <td>
			                                                <form:input type="hidden" path="msiList[${status.index}].comCD" />
			                                                <div style='float:left; margin-top: 7px;'>
			                                            		사용자(반납)
			                                            	</div>
			                                            	<div id="textChg8" style='text-align:left;'> 
			                                            	<input type="text"  value="${mainVal12 }" id="mainVal12" name="mainVal12"  style="width: 80px;"/>
			                                            	</div>	
			                                            </td>   
			                                        </tr>
			                                        <tr>
				                                          <td>
			                                                <form:input type="hidden" path="msiList[${status.index}].comCD" />
			                                                <div style='float:left; margin-top: 7px;'>
			                                            		관리자(이동)
			                                            	</div>
			                                            	<div id="textChg9" style='text-align:left;'> 
			                                            	<input type="text"  value="${mainVal13 }" id="mainVal13" name="mainVal13"  style="width: 80px;"/>
			                                            	</div>			
			                                            </td>   
			                                        </tr>
			                                        <tr>
				                                          <td>
			                                                <form:input type="hidden" path="msiList[${status.index}].comCD" />
			                                                <div style='float:left; margin-top: 7px;'>
			                                            		관리자(설치)
			                                            	</div>
			                                            	<div id="textChg10" style='text-align:left;'> 
			                                            	<input type="text"  value="${mainVal14 }" id="mainVal14" name="mainVal14"  style="width: 80px;"/>
			                                            	</div>	
			                                            </td>   
			                                        </tr>
		                                    </c:when>
		                                    <c:otherwise>
		                                        <tr>
		                                            <th><em>*</em> <c:out value="${mainSetVO.mLangComCDName}" /></th>
		                                            <td>
		                                                <form:input type="hidden" path="msiList[${status.index}].comCD" />
		                                                <span class="input-text08"><form:input id="msiListAddVal1_${status.index}" path="msiList[${status.index}].addVal1" type="text" numberOnly="true" maxLength="8" /></span>
		                                            </td>
		                                        </tr>
		                                    </c:otherwise>
										</c:choose>
									</c:forEach>
									</tbody>
								</table>
								<div class="btnArea">
									<!-- <span class="left"><button class="btnType01 bc_gray">목록</button></span> -->
									<span class="right"><button type="button" class="btnType01 bc_green"  id="saveBtn">저장</button></span>
								</div>
							</fieldset>
						</form:form>
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
        	$("#windowWh").val($(window).width());
        	
        	/* 정책 OPEN 유무, 웹, 모바일 체크박스 위치 조정  */
        	/* 모바일 */
        	if($("#windowWh").val() < 700){
        		$("#windowChg").css("margin-left","35%"); 
        		$("#windowChg2").css("margin-left","35%"); 
        		$("#windowChg3").css("margin-left","35%"); 
        		
        		$("#textChg1").css("margin-left","50%"); 
        		$("#textChg2").css("margin-left","50%"); 
        		$("#textChg3").css("margin-left","50%"); 
        		$("#textChg4").css("margin-left","50%"); 
        		$("#textChg5").css("margin-left","50%"); 
        		$("#textChg6").css("margin-left","50%"); 
        		$("#textChg7").css("margin-left","50%");
        		$("#textChg8").css("margin-left","50%");
        		$("#textChg9").css("margin-left","50%");
        		$("#textChg10").css("margin-left","50%");
        	}else{
        	/* 웹 */	
        		$("#windowChg").css("margin-left","26%"); 
        		$("#windowChg2").css("margin-left","26%"); 
        		$("#windowChg3").css("margin-left","26%"); 
        		
        		$("#textChg1").css("margin-left","35%"); 
        		$("#textChg2").css("margin-left","35%");
        		$("#textChg3").css("margin-left","35%"); 
        		$("#textChg4").css("margin-left","35%");
        		$("#textChg5").css("margin-left","35%"); 
        		$("#textChg6").css("margin-left","35%"); 
        		$("#textChg7").css("margin-left","35%"); 
        		$("#textChg8").css("margin-left","35%"); 
        		$("#textChg9").css("margin-left","35%"); 
        		$("#textChg10").css("margin-left","35%"); 
        	}
        	
        	var alertValue = "<c:out value='${resultError.errorMessage}'/>";
            if(alertValue!=""){ alert(alertValue); }

            $(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
            $(document).on("focusout", "input:text[numberOnly]", function() {
                if(isNaN($(this).val())){
                    //alert("숫자만 입력이 가능합니다.");
                    $(this).focus();
                }
            });
            $("#saveBtn").on("click", saveContent);
            
        });
        
        function saveContent(){
            var tempVar = '';
            var flag = false;
            $("input:text[numberOnly]").each(function(){
                tempVar = $(this).val();
                if(tempVar==''){ flag = true; }
                tempVar = '';
            });
            if(flag){ alert("모든 폼에 공백을 허용하지 않습니다."); return false; }
            
            if($("#sms1").val() !== ''){
                if(!isMpnSpb($("#sms1").val())) {
                    alert('형식이 맞지 않습니다.ex) 010-0000-0000');
                    flag = true;
                    return false;
                }
            }
            if($("#sms2").val() !== ''){
                if(!isMpnSpb($("#sms2").val())) {
                    alert('형식이 맞지 않습니다.ex) 010-0000-0000');
                    flag = true;
                    return false;
                }
            }
            if($("#sms3").val() !== ''){
                if(!isMpnSpb($("#sms3").val())) {
                    alert('형식이 맞지 않습니다.ex) 010-0000-0000');
                    flag = true;
                    return false;
                }
            }

            if($('[name="mainVal5"]:checked').val() != null){
            	$("#mainCheck").val("Y");
            }else if($('[name="mainVal6"]:checked').val() != null){
            	$("#mainCheck").val("N");
            }else{
            	$("#mainCheck").val("");
            }
            
            if($('[name="mainVal9"]:checked').val() != null){
            	$("#mainCheck2").val("Y");
            }else if($('[name="mainVal10"]:checked').val() != null){
            	$("#mainCheck2").val("N");
            }else{
            	$("#mainCheck2").val("");
            }
            
            
            if(!flag) {
                $("#frm").attr("action","/admin/system/mainSet/mainSetUpdate.do").submit();
            }
        }
        
        /* 재배치 유도 */
        function isChkN(val){
        	$("input[name=mainVal5]").prop("checked",false);
        }
        function isChkY(val){
        	$("input[name=mainVal6]").prop("checked",false);
        }
        
        /* 탄소절감 */
        function isChkN2(val){
        	$("input[name=mainVal9]").prop("checked",false);
        }
        function isChkY2(val){
        	$("input[name=mainVal10]").prop("checked",false);
        }
        
        </script>
</body>
</html>

