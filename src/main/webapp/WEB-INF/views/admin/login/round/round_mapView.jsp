<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<style type="text/css">
.staBox { padding : 10px 5px}
.staBox span{	margin-right: 0px; }
#infoBox {border:2px solid #555; background:#fff; font-family:dotum; width:230px; text-align:left;line-height:150%;} 
#infoBox .map_ul { display:inline-block; vertical-align:middle; font-size:1.1em; }
#infoBox .map_ul li{ margin : 5px; padding:5px } 
</style>
 
		<div id="filterDiv" class="staBox" style="margin-top:-20px">
		<form id="searchFrm" >
			<input type="hidden" name="stationGrpSeq" 	id="stationGrpSeq" 		value="${condition.stationGrpSeq }">
			<input type="hidden" name="defaultLevel" 	id="defaultLevel" 		value="${condition.defaultLevel }">
			<input type="hidden" name="paramSearchWord" id="paramSearchWord" 	value="${condition.paramSearchWord}">
			<input type="hidden" name="stationNo" 		id="stationNo" 			value="${condition.stationNo}">
			 
			
			<fieldset>
			    <legend>검색 옵션</legend>
			    <div class="shBoxSection">
			        <!-- <div class="section"> -->
			            <input type="text" id="searchWord" size="15" placeholder="대여소번호" value= "${condition.stationNo}" />
				        <button type="button" name="searchBtn" id="searchBtn" class="btn-srh03" >
				        	<img src="/images/searchIcon.gif" alt="검색"/>
				        </button> 
				        
				        <button  class="btnType01" type="button" id="bikeMoveBtn" onclick="goQrScan('move')">잠금장치 오픈</button>
				        
					<!-- </div> -->
				</div>
			</fieldset>
 
		</form>
		</div>	 
	<!--검색조건 E-->
	
	<table class="tb_type01" id="list" style="margin-top:10px;">
        <colgroup>
            <col style="width:10%"/>
            <col style="width:10%"/>
            <col style="width:10%"/>
            <col style="width:10%"/>
            <col style="width:10%"/>
            <col style="width:10%"/>
            <col style="width:10%"/>
        </colgroup>
        <thead>
            <tr>
            	<th>대여소</th>
                <th>비콘</th>
                <th>거치대</th>
                <th>AP</th>
                <th>안내간판</th>
                <th>수리공구대</th>
                <th>기타</th>
            </tr>
        </thead>
        <tbody id="stationBody"> 
        </tbody>
	</table>
	<div id="mapDiv" class="mt20" ></div>
	
	<form id="linkForm">
		<input type="hidden" name="bikeNo" value="">
		<input type="hidden" name="bikeId" value="">
		<input type="hidden" name="lang" value="">
		<input type="hidden" name="viewFlg" value="">
		<input type="hidden" name="tabNum" value="">
		<input type="hidden" name="currentPageNo" value="0">
		<input type="hidden" name="repairClsCd"   value="">
		<input type="hidden" name="rackId"   value="">
		<input type="hidden" name="stationId"   value="">
		<input type="hidden" name="stationName" value="">
		<input type="hidden" name="stationNo" value="">
	</form>	
	
	
 