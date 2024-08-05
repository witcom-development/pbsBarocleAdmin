
/* 주소 팝업 */
function goPopup(){
	varpop = window.open("/admin/manage/station/juso.do","pop","width=570,height=420, scrollbars=yes");
}

/* 주소 콜백 */
function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo,admCd, rnMgtSn, bdMgtSn){
	$("#station_post_no1").val(zipNo.split("-")[0]);
	$("#station_post_no2").val(zipNo.split("-")[1]);
	$("#station_full_post_no").val(zipNo);
	$("#station_post_no").val(zipNo.replace("-",""));
	$("#station_addr1").val(roadAddrPart1);
	$("#station_addr2").val(addrDetail);
	naverTraceAddr(jibunAddr);
}

/* 위도 경도 */
function naverTraceAddr(roadFullAddr){
		roadFullAddr = roadFullAddr.trim();
		$.post("/admin/manage/station/stationAddrSearch.do", "station_name=" + roadFullAddr  , function(data) {
		if(data.result == "OK"){
			$("#station_latitude").val(data.lat);
	        $("#station_longitude").val(data.lon);
		} else {
			alert(data.result);
		}
	});
}
