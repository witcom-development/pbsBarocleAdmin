<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
<!---->
.cont {width: 80%; margin: 0 auto; margin-top: 30px; }
</style>

<div class="allwrap">
       <!--모바일 메뉴 S-->
       <tiles:insertAttribute name="header" />
       <!--모바일 메뉴 E-->
       <!--Head S-->
       <tiles:insertAttribute name="head" />
       		        <!--Head E-->
	<div id="body"  style="background: white;">
		<div class="cont">
			 <!--검색조건 S-->
	         <table class="tb_type01">
	             <colgroup>
	                 <col style="width:30%"/>
	                 <col style="width:30%"/>
	                 <col style="width:40%"/>
	             </colgroup>
	             <thead>
	                 <tr>
	                     <th>총괄</th>
	                     <th>실시간 ( =가-나-다 )</th>
	                     <th>비고</th>
	                 </tr>
	             </thead>
	             <tbody>
	                 <tr>
	                     <td class="title">
	                        <div class="statulist" style="line-height: 30px;">
	                            <p style="font-size: large; font-weight: bold;">자전거(가)<span id="a_1">37,500</span></p>
	                            <p>┌&nbsp;&nbsp;입고예정(나)<span id="a_2">4,830</span></p>
	                            <p>└&nbsp;&nbsp;폐기예정(다)<span id="a_3">1,595</span></p>
	                         </div>
	                     </td>   
	                     <td class="title"  style="line-height: 30px;vertical-align: middle;">
	                        <div class="statulist">
	                            <p style="font-size: large; font-weight: bold;">대여대기(a) <span id="b_1"><fmt:formatNumber value="20478" pattern="#,###"></fmt:formatNumber></span></p>
	                        </div>     
	                     </td>
	                       <td class="title"  style="vertical-align: middle;">
	                            <p><span>대여소에서 자전거 대기 중</span></p>
	                       </td>
	                   </tr>
	                   
	                   <tr>
	                     <td class="title">
	                        <div class="statulist" style="line-height: 30px;">
	                            <p style="font-size: large; font-weight: bold;">대여소   : <span id="a_1">2,411</span></p>
	                            <p style="font-size: large; font-weight: bold;">거치대 : <span id="a_2">30,196</span></p>
	                            <p> </p>
	                            <p><span id="a_3">2021.04.31 기준</span></p>
	                         </div>
	                     </td>   
	                     <td class="title">
	                        <div class="statulist" style="line-height: 30px;">
	                            <p>┌&nbsp;&nbsp;정상대여중 (b)<span id="a_2">2,609</span></p>
	                            <p>│&nbsp;&nbsp;고장신고 (c)<span id="a_2">165</span></p>
	                            <p>└&nbsp;&nbsp;센터보관 (d)<span id="a_2">7,283</span></p>
	                        </div>     
	                     </td>
	                       <td class="title" style="line-height: 30px;">   
	                            <p>&nbsp;<span>이용시민 자전거 이용 중</span></p>
	                            <p>&nbsp;<span>대여소 내 자전거 고장신고</span></p>
	                            <p>&nbsp;<span>배송 및 정비센터에 자전거 정비대기 등</span></p>
	                       </td>
	                   </tr>
	               		<tr style="background-color:Azure ;">
	               			<td>
	               			 <div class="statulist" style="line-height: 30px;">
	                         	<p style="font-size: large; font-weight: bold;">합계 ( a+b+c+d )</p>
	                          </div>
	               			</td>
	               			<td>
	               			 <div class="statulist" style="vertical-align: middle;">
	                             <p style="font-size: large; font-weight: bold;">&nbsp;<span>31,075</span></p>
	                          </div>   
	               			</td> 
	               			<td>
	               			</td>
	               		</tr>	    
	               </tbody>
	           </table>
	           <p style="color: red;text-align: right;margin-top: 10px;">&nbsp;<span>기타 평균 배송차량에 자전거 배송진행 : 400대</span></p>
		   </div>
	</div>
</div>		 