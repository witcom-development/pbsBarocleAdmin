<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.dkitec.barocle.admin.login.vo.UserSessionVO" %>
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
<script type="text/javascript">
if('${stationId}' === null && '${stationId}'=== '') {
	alert("잘못된 접근입니다.");
	location.href = "/login.do";
}



</script>

<script type="text/javascript" src="/js/common_barocle.js?ver=0403"></script>

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
                <div class="content">
                    <div class="subject">
                        <p class="pageTitle">대여소 상세</p>
                        <span>실시간 현황 &gt; <em>대여소 상세</em></span>
                    </div>
                    <div class="page">
                        <table class="tb_type02 mt20" id="stationTbl">
                            <colgroup>
                                <col style="width:25%">
                                <col style="width:75%">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th class="top">대여소명</th>
                                    <td class="top">상암1 대여소</td>
                                </tr>
                                <tr>
                                    <th>상태</th>
                                    <td>운영중 / 운휴</td>
                                </tr>
                                <tr>
                                    <th>위치</th>
                                    <td>우 : 132 - 123 서울시 마포구 성산동 515</td>
                                </tr>
                                <tr>
                                    <th>QR거치대 수</th>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <th>반경(m)</th>
                                    <td>&nbsp;</td>
                                </tr>
                            </tbody>
                        </table>
                        
                        <p class="head ttbtncase1">자전거</p>
                        <p class="tb_numlist nmt" id="bikeTot"></p>
                        <table class="tb_type01" id="bikeTbl">
                            <colgroup>
                                <col style="width:12%"/>
                                <col style="width:20%"/>
                                <col style="width:8%" class="mhid"/>
                                <col style="width:10%"/>
                                <col style="width:10%"/>
                                <col style="width:35%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>자전거<br/>번호</th>
                                    <th>상태</th>
                                    <th class="mhid">장애발생<br/>일시</th>
                                    <th>배터리<br/>정보</th>
                                    <th>자전거<br/>오픈</th>
                                    <th>고장신고</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                        <p class="head ttbtncase1">거치대</p>
                        <p class="tb_numlist nmt" id="armTot"></p>
                        <table class="tb_type01"  id="armTbl">
                            <colgroup>
                                <col style="width:20%"/>
                                <col style="width:10%"/>
                                <col style="width:20%" class="mhid"/>
                                <col style="width:8%"/>
                                <col style="width:25%"/>
                                <col style="width:17%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>거치대ID</th>
                                    <th>상태</th>
                                    <th class="mhid">장애발생일시</th>
                                    <th>거치대<br/> 번호</th>
                                    <th>QR코드</th>
                                    <th>고장신고</th>
                                </tr>
                            </thead>
                            <tbody>
                               
                            </tbody>
                        </table>
                        
                        <p class="head">비콘</p>
                        <table class="tb_type01 mt20" id="beaconTbl">
                            <colgroup>
                                <col style="width:25%"/>
                                <col style="width:25%"/>
                                <col style="width:10%"/>
                                <col style="width:10%"/>
                                <col style="width:20%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>BEACON ID</th>
                                    <th>SERIAL NO</th>
                                    <th>배터리(%)</th>
                                    <th>신호세기</th>
                                    <th>수정일</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="pl10"></td>
                                    <td class="pl10"></td>
                                    <td class="pl10"></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                </tr>
                            </tbody>
                        </table>
                        
                        
                    </div>
                </div>
                <!--conteent E-->
            </div>
        </div>
        <!--footer S-->
        <tiles:insertAttribute name="footer"/>
        <!--footer E-->
    </div>
    <section style="display: none;">
        <table id="clone">
            <tr><td class="pl10"></td><td class="pl10"></td><td class='tc mhid'></td><td class='tr pr10'></td><td class='tr pr10'></td><td class='tc'></td></tr>
        </table>
        <table id="clone_1">
            <tr><td class="pl10"></td><td class="pl10"></td><td class='tc mhid'></td><td class='tc pr10'></td><td class='tr pr10'></td><td class='tc'></td></tr>
        </table>
        <table id="clone_2">
            <tr><td class="pl10"></td><td class="pl10"></td><td class='tc pr10'></td><td class='tr pr10'></td></td><td class='tr pr10'></td></tr>
        </table>
    </section>
    
 	<form id="QRfrm">
	    <input type="hidden" id="deviceId" name="deviceId" value=""/>
	    <input type="hidden" id="bikeId" name="bikeId" value=""/>
	    <input type="hidden" id="stationId" name="stationId" value=""/>
	    <input type="hidden" id="rackId" name="rackId" value=""/>
	    <input type="hidden" id="deviceName" name="deviceName" value=""/>
	    <input type="hidden" id="useTime" name="useTime" value=""/>
	    <input type="hidden" id="beaconId" name="beaconId" value=""/>
	    <!-- <input type="hidden" id="lat" name="lat" value=""/>
	    <input type="hidden" id="log" name="log" value=""/> -->
	</form>
    
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function() {
    	staDetail.makeDetailData('${stationId}');
    	 $("#stationId").val('${stationId}');
    	 
    	setTableGrid("ASC");
    });
    var staDetail = {};
    var _this = staDetail;
    staDetail.makeDetailData = function(pStationId) {
    	commonAjax.getAjax("/getCurrentStationDetail.do", "json", {stationId : pStationId}
    	    ,function(data){
    	    	if(data.result) {
    	    		_this.makeStationInfo(data.stationInfo);
    	    		_this.makeBikeInfo(data.stationInfo.bikeList);
    	    		_this.makeArmInfo(data.stationInfo.armList, data.stationInfo.armInfo);
    	    		_this.makeBeaconInfo(data.stationInfo.beaconList);
    	    	} else {
    	    		
    	    	}
    	    }
    	);
    };
    
    staDetail.makeStationInfo = function(pDataList) {
    	if(pDataList.stationSeCd === 'RAK_001')
    		$("#stationTbl > tbody > tr").eq(0).find('td').text("(기존)"+pDataList.stationName);
    	else if(pDataList.stationSeCd === 'RAK_002')
    		$("#stationTbl > tbody > tr").eq(0).find('td').text("(신규)"+pDataList.stationName);
    	else
    		$("#stationTbl > tbody > tr").eq(0).find('td').text(pDataList.stationName);
    	
    	$("#stationTbl > tbody > tr").eq(1).find('td').text(pDataList.currnetStatus);
    	$("#stationTbl > tbody > tr").eq(2).find('td').text("우 : "+pDataList.stationPostNo+" "+pDataList.stationAddr);
    	if(pDataList.memo !=null){
    		$("#stationTbl > tbody > tr").eq(3).find('td').text(pDataList.memo);
    	}
    	if(pDataList.dstncLt !=null){
    		$("#stationTbl > tbody > tr").eq(4).find('td').text(pDataList.dstncLt);
    	}
    };

    staDetail.makeBikeInfo = function(pData) {
    	var bSize = pData.length;
    	$("#bikeTbl > tbody").empty();
    	if(bSize > 0) {
	    	for(var i=0; i< bSize; i+=1) {
	    		var $tr = $("#clone_1 > tbody > tr").clone();
	    		var statusCd = pData[i].bikeStatusCd;
	    		
	    		// 자전거번호
	    		$tr.children().eq(0).text( pData[i].bikeNo.substring(4) );
	    		
	    		// 자전거 상태
	    		var status = statusCd.substring(6) + "." + pData[i].bikeStatusName;
	    		
	    		if(statusCd === 'BKS_001') {
	    			var spanmHtml = '<span style="color:red">'+ status +'</span>'; 
	    			$tr.children().eq(1).addClass('alert').append(spanmHtml);
	    		} else {
	    			$tr.children().eq(1).text( status );
	    		}
	    		
	    		// 장애발생일시
	    		$tr.children().eq(2).text(pData[i].regDttm.substring(5)); 
	    		var rackNo = pData[i].stationEquipOrder;
	    		if(pData[i].cascadeYn === 'Y'){
	    			rackNo +="(C)"; 
	    		}
	    		
	    		// 배터리 정보
	    		$tr.children().eq(3).text(pData[i].batteryStusCd);
	    		
	    		// 자전거 이동
	    		var linkHtml = "<a onclick=goQrScan(\'" + pData[i].bikeNo + "\',\'" +  pData[i].bikeId + "\')>오픈</a>";
	    		$tr.children().eq(4).append(linkHtml);
	    		
    			//2020-08-05 김시성 : 아래 /moveRepairBikeEditForm.do 링크의 faultSeq null들어가는 문제
    			var faultSeq = pData[i].faultSeq;
    			
    			if(faultSeq === 'null' || !faultSeq) faultSeq = 0;
    			
	    		if(statusCd === 'BKS_003') {
	    			$tr.children().eq(5)
	    			.append($('<a>', {href : "/common/pop/DEV_001/showTroubleReportPop.do", title : "고장신고", 'data-width' :"450" ,'data-height' :"550", 'data-pmt' : '&mode=insert&equipmentId='+pData[i].bikeId+'&stationId=${stationId}' })
	    					.addClass('winNewPop btnType02').text("고장신고"))
	    			/* .append($('<a>', {href : "/common/pop/exeBikeRobbed.do", title : "도난추정", 'data-pmt' : '&rentBikeId='+pData[i].bikeId})
	    					.addClass('winNewPop btnType05').text("도난\n추정")) */
   					.append($('<a>', {href : "javascript:void(0)", title : "도난추정", id : pData[i].bikeId , style:"margin-left: 3px;margin-right: 3px;"})
   	    					.addClass('btnType05 a1').text("도난추정"))
	    			.append($('<a>', {href : "/moveRepairBikeEditForm.do", title : "수리관리", 'data-width' :"450" ,'data-height' :"750", 'data-pmt' : '&viewFlg=C&bikeId='+pData[i].bikeId+'&bikeNo='+pData[i].bikeNo+"&faultSeq="+faultSeq, style:"background:#088A29;"})
	    					.addClass('winNewPop btnType05').text("수리관리"));
	    			/* 
	    			$tr.children().eq(5).children().eq(0).html($tr.children().eq(5).children().eq(0).text().replace(/\n/g, '<br/>')); 
	    			$tr.children().eq(5).children().eq(1).html($tr.children().eq(5).children().eq(1).text().replace(/\n/g, '<br/>')); 
	    			$tr.children().eq(5).children().eq(2).html($tr.children().eq(5).children().eq(2).text().replace(/\n/g, '<br/>')); 
	    			 */
	    			$(document).off().on("click",".a1",function(){
	    				var bikeId = $(this).attr("id");
	    				bikeRobbedExe(bikeId);
	    			});
	            } else {
	            	// 20190821
	            	//$tr.children().eq(5).html(pData[i].entrpsCdNm);
	            	
	            	// 2021 07 15
	            	$tr.children().eq(1).append('<br/><span>'+
	            			'<a href="/common/pop/DEV_001/showTroubleReportPop.do"  class="winNewPop modal" title="고장신고" data-width="450" data-height="620" data-pmt="&mode=view&faultSeq=' + faultSeq + '">'
	            			+   pData[i].entrpsCdNm+'</a></span></br></br>');
	            	  
	            	$tr.children().eq(5)
	            	.append($('<a>', {href : "/common/pop/DEV_001/showTroubleReportPop.do", title : "고장신고", 'data-width' :"450" ,'data-height' :"550", 'data-pmt' : '&mode=insert&equipmentId='+pData[i].bikeId+'&stationId=${stationId}' })
	    					.addClass('winNewPop btnType02').text("고장신고"))
   					.append($('<a>', {href : "javascript:void(0)", title : "도난추정", id : pData[i].bikeId, style:"margin-left: 3px;margin-right: 3px;" })
   	    					.addClass('btnType05 a1').text("도난추정"))
	    			.append($('<a>', {href : "/moveRepairBikeEditForm.do", title : "수리관리", 'data-width' :"450" ,'data-height' :"750", 'data-pmt' : '&viewFlg=C&bikeId='+pData[i].bikeId+'&bikeNo='+pData[i].bikeNo+'&bikeStatusCd='+pData[i].bikeStatusCd+"&repairCmptYn=Y&bikeStatusName="+pData[i].entrpsCdNm+"&faultSeq="+faultSeq, style:"background:#8B5927;"})
	    					.addClass('winNewPop btnType05').text("장애관리"));
	            	/* 
	    			$tr.children().eq(5).children().eq(3).html($tr.children().eq(5).children().eq(3).text().replace(/\n/g, '<br/>')); 
	    			$tr.children().eq(5).children().eq(4).html($tr.children().eq(5).children().eq(4).text().replace(/\n/g, '<br/>')); 
	    			$tr.children().eq(5).children().eq(5).html($tr.children().eq(5).children().eq(5).text().replace(/\n/g, '<br/>')); 
	    			 */
	    			$(document).off().on("click",".a1",function(){
	    				var bikeId = $(this).attr("id");
	    				bikeRobbedExe(bikeId);
	    			});
	            }
	    		
	    		$("#bikeTbl > tbody").append($tr);
	    	}
	   		  $("#bikeTbl > tbody > tr").find(".alert").on("click" , 'a',{tType : "DEV_001"}, _this.moveFaultDetail);
    	} else {
    		$("#bikeTbl").after('<table class="tb_type01 nbt0"><tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr></table>');
    	}
    	
    	var totText = "(총 자전거: "+bSize +")";
    	$("#bikeTot").text(totText);
    	
    };
    
    staDetail.makeArmInfo = function(pData, pInfo) {
    	var aSize = pData.length;
    	$("#armTbl > tbody").empty();
    	if(aSize > 0 ) {
    		for(var i=0; i< aSize; i+=1) {
                var $tr = $("#clone > tbody > tr").clone();
                $tr.children().eq(0).text(pData[i].rackId);
                var statusCd = pData[i].rackStatusCd;
                if( statusCd === 'RAS_001') {
                	var spanmHtml = '<span><em><img src="/images/sta_sys.png" alt="장애"/></em>'+pData[i].rackStatusName+'</span>'; 
                    $tr.children().eq(1).addClass('alert').append(spanmHtml);
                } else {
                    $tr.children().eq(1).text(pData[i].rackStatusName);
                }
                $tr.children().eq(2).text(pData[i].regDttm);
                $tr.children().eq(3).text(pData[i].stationEquipOrder);
                
                if(pData[i].qrText === null) {
                	$tr.children().eq(4).text("-");
                }else{
                	$tr.children().eq(4).text(pData[i].qrText);
                }
                
                if(statusCd === 'RAS_003') {
                    $tr.children().eq(5)
                    .append($('<a>', {href : "/common/pop/DEV_004/showTroubleReportPop.do", title : "고장신고", 'data-width' :"450" ,'data-height' :"550", 'data-pmt' : '&mode=insert&equipmentId='+pData[i].rackId+'&stationId=${stationId}'})
                    		.addClass('winNewPop btnType02').text("고장신고"));
                } else {
                    $tr.children().eq(5).text("-"); 
                }
                $("#armTbl > tbody").append($tr);
            }       
            $("#armTbl > tbody > tr").find(".alert").on("click" , 'a',{tType : "DEV_004"}, _this.moveFaultDetail);
    		
    	} else {
    		$("#armTbl").after('<table class="tb_type01 nbt0"><tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr></table>');
    	}
        var returnableCnt = Number(pInfo.rackTotCnt) - Number(pInfo.keepBikeRackCnt);
    	var totText = "(총 거치대: "+pInfo.rackTotCnt+", 거치중: "+pInfo.keepBikeRackCnt+", 연결반납 거치대수: "+pInfo.cascadeRackCnt+")";
    	$("#armTot").text(totText);
    	
    };

	function bikeRobbedExe(bikeId){
		var ans = confirm("도난추정으로 등록 하시겠습니까?");
		if(ans){
		commonAjax.postAjax("/common/pop/exeBikeRobbed.do", "json", {rentBikeId : bikeId}
    		,function(data){
    		   if(data.checkResult > 0) {
    			   alert(data.resultMessage);
    			   location.reload();
	    	   }
	    	}
        )  
	  }
	}; 
	
    staDetail.makeBeaconInfo = function(pData) {
    	var bSize = pData.length;
    	$("#beaconTbl > tbody").empty();
    	if(bSize > 0) {
	    	for(var i=0; i< bSize; i+=1) {
	    		var $tr = $("#clone_2 > tbody > tr").clone();
	    		$tr.children().eq(0).text( pData[i].beaconId);
	    		$tr.children().eq(1).text(pData[i].serialNo); 
	    		$tr.children().eq(2).text(pData[i].beaconBatteryStusCd); 
	    		$tr.children().eq(3).text(pData[i].beaconRange); 
	    		$tr.children().eq(4).text(pData[i].modDttm); 
	    		
	    		$("#beaconTbl > tbody").append($tr);
	    	}
    	} else {
    		$("#beaconTbl").after('<table class="tb_type01 nbt0"><tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr></table>');
    	}    	
    };
    
    
    function reloadPage() {
    	staDetail.makeDetailData('${stationId}');
    	
    }
    
    
    
    function setTableGrid(sortType){
		
    	// 모든 table 헤더에 클릭 이벤트를 설정한다.  list
		var tables = document.getElementsByTagName("table");
    	
		for( var i = 0; i < tables.length; ++i )
		{
			if ( tables[i].id == "bikeTbl" ) { 	
				var headers = tables[i].getElementsByTagName("th");
				for( var j = 0; j < headers.length; ++j )
				{
					// 지역 유효범위에 생성할 중첩 함수
					(function(table,n)	{
							headers[j].onclick = function() { SortTable( table, n )	};
						}( tables[i], j ) 
					);
				}
			}
		}    	
    }
    
    function SortTable( table, n )
	{
		// table 에 tbody tag 가 반드시 존재한다고 가정한다.
		var tbody = table.tBodies[0];
		var rows = tbody.getElementsByTagName( "tr" );
		// 배열로 생성한 후, 배열로 정렬한다.
		rows = Array.prototype.slice.call( rows, 0 );
		
		var upValue = 1;
		var downValue = -1;
		
		if(  sortType == "DESC" ) {
			upValue = 1;
			downValue = -1;
		} else {
			upValue = -1;
			downValue = 1;
		} 
		rows.sort( function( row1, row2 ) {
			
		    var cell1 = row1.getElementsByTagName("td")[n];
		    var cell2 = row2.getElementsByTagName("td")[n];
		    var value1 = cell1.textContent || cell1.innerText;
		    var value2 = cell2.textContent || cell2.innerText;
			// 대여소 , 팀명
			if (n == 0 || n == 3 ) {
			
				if( value1 < value2 ) return upValue;
			    if( value1 > value2 ) return downValue;
			
			// 자전거, 거치율    
			} else {
				
				if( parseInt(value1) < parseInt(value2) ) return upValue;
			    if( parseInt(value1) > parseInt(value2) ) return downValue;
				
			}
				return 0;
			}
		);
	  
	
		// 정렬된 배열로 row 를 다시 저장한다. 문서에 이미 존재하는 node 는 삽입하면 해당 node 는 자동으로 제거되고 새 위치에 저장된다.
		for( var i = 0; i < rows.length; ++i )
		{
			tbody.appendChild( rows[i] );
		}
		

		if(  sortType == "DESC" ) {
			sortType = "ASC";
		} else {
			sortType = "DESC";
		} 
	}
    
    var sortType ="ASC";
    
    
////////////////////////////////QR 촬영 //////////////////////////////////// 

	function getAdminLogin(){
	 	var usrSeq = '${adminSeq}';
		if (usrSeq != null && usrSeq != '' && usrSeq > 0) {
			var tempSeq = '';
			for (var i = usrSeq.length; i < 10; i++) {
			tempSeq += '0';
			}
			usrSeq = tempSeq + usrSeq;	
			} else {
			alert("관리자 번호가 조회되지 않았습니다. 다시 로그인 부탁드립니다.");
			return false;
		} 
		
		var jsonTestData = {"userseq" : usrSeq, "isuser" : false, "call" : "setUser"};
		var loginTestInfo = JSON.stringify(jsonTestData);
		
		if ( typeof( window.android_admin ) == undefined || typeof( window.android_admin) == 'undefined' ) {
			alert("관리자 앱에서 사용가능합니다.");
			return;
		}
		
		window.android_admin.setUser(loginTestInfo);
		return true;  
	} 
	
	function goQrScan(bikeNo, bikeId) {
/* 		
		if ( typeof( window.android_admin ) == undefined || typeof( window.android_admin) == 'undefined' ) {
			alert("관리자 앱에서 사용가능합니다.");
			return;
		}  
 */		
 		alert("goQrScan : " + bikeNo +  " : " + bikeId );
		// 관리자 로그인
		if(!getAdminLogin()) return;
 
 		$("#bikeId").val( bikeId );
 
 		window.android_admin.unLock( getDeviceName(bikeNo) , 60 );
	
	}
	
	function getDeviceName(s){
		if ( s.length ==  9 ) {
		s =	"BRC-000" + s.substring(4);
		}
		return s;
	}
    
    </script>
</body>
</html>