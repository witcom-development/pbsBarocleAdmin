<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<style type="text/css">
.staBox { padding : 10px 5px}
.staBox span{	margin-right: 0px; }

#filterDiv ul  {
    list-style: none;
    margin: 0px;
    padding: 0px;
    max-width: 900px;
    width: 100%;	
}
#filterDiv ul li {
    display: inline-block;
    padding: 10px 10px 0px 10px;
    cursor: pointer;
    width: 12%;
    font-size:10px;
    font-weight: bolder;
}
</style>
 
		<div id="filterDiv" class="staBox mapguide" style="margin-top:-20px">
		<form id="searchFrm" >
			<input type="hidden" name="stationGrpSeq" id="stationGrpSeq" value="${condition.stationGrpSeq }">
			<input type="hidden" name="defaultLevel" id="defaultLevel" value="${condition.defaultLevel }">
			<input type="hidden" name="paramSearchWord" id="paramSearchWord" value="${condition.paramSearchWord}">
			<!-- 강반내역 찾기 용 -->
			<input type="hidden" name="searchWord" id="searchWord" 			 value="">
			<!-- 자전거 위치 찾기용 용 -->
			<input type="hidden" name="latitude" id="searchWord" 			 value="">
			<input type="hidden" name="longitude" id="searchWord" 			 value="">
			<input type="hidden" name="enfrcReturnHistSeq" id="searchWord" 			 value="">
			<fieldset>
			    <legend>검색 옵션</legend>
			    <div class="shBoxSection">
			        <button type="button" name="searchBtn" id="searchBtn" class="btn-srh03 btncase1" ><img src="/images/searchIcon.gif" alt="검색"/></button>
			        <div class="section">
			            <label for="bb22" class="laType03">구/대여소명</label>
			            <select id="bb22"><option value="">선택</option></select>
				    	<input type="text" id="searchWord" size="15" placeholder="대여소명" value= "${condition.paramSearchWord}" />
					    <span class="input-text12">
					    </span>
					</div>
					<div class="section pright etccase3">
					    <label for="paramCenterId" class="laType03">센터/팀</label>
					    <select id="paramCenterId" name="paramCenterId" style="width:80px">
					    	<option value="">선택</option>
						</select>&nbsp;
						<select id="paramTeamSeq" name="paramTeamSeq" style="width:auto">
							<option value="">선택</option>
						</select>
					</div>
				</div>
			</fieldset>

			<div id="filterImage">
				<ul>
					<li class="filterLstBike"><img src="/images/icon_bike_b4.png" alt="분실"/>          	</li>
					<li class="filterRtnBike"><img src="/images/icon_bike_b3.png" alt="강반"/>			</li>
					<li class="filterExcess"><img src="/images/staStop_ss150p.png" style="width:20px" alt="거치초과"/>		</li>
					<li class="filterErr"><img src="/images/mapIcon/E/icon_b3_4.png" alt="고장"/>		</li>
					<li class="filterTeamp"><img src="/images/mapIcon/T/icon_b5_0.png" alt="임시폐쇄"/>	</li>
					<li class="filterBat"><img src="/images/batLow.png" alt="배터리부족"/>	</li>
					<li class="filterExit"><img src="/images/position_re.png" alt="필터초기화"/>	</li>
				</ul>
			</div>
			<div id="filterLabel" style="width:100%; margin-left: -0.3%;">
				<ul>
					<li class="filterLstBike">분실</li>
					<li class="filterRtnBike">강반</li>
					<li class="filterExcess">초과</li>
					<li class="filterErr">고장</li>
					<li class="filterTeamp">임폐</li>
					<li class="filterBat">부족</li>
					<li class="filterExit"></li>
				</ul>	
			</div> 
		</form>
		</div>	 
	<!--검색조건 E-->
	<div id="mapDiv" class="mt20" ></div>
	<table class="tb_type01" id="list" style="margin-top:10px;">
        <colgroup>
            <col style="width:35%;" class="station_col1"/>
            <col style="width:20%" class="station_col2"/>
            <col style="width:10%" class="station_col3"/>
            <col style="width:10%" class="station_col5"/>
            <col style="width:10%" class="station_col6"/>
        </colgroup>
        <thead>
            <tr>
                <th>대여소</th>
                 <th title="[ LCD/QR]">자전거<br/> (점검)</th>
                <!-- <th title="연결반납 자전거 수/전체 자전거 수(점검수)">자전거 (점검)</th> -->
                <th>거치율<br/>(%)</th>
                <th>요청<br/>(7일)</th>
                <th>요청<br/>(1일)</th>
            </tr>
        </thead>
        <tbody id="stationBody"> 
        </tbody>
	</table>
 