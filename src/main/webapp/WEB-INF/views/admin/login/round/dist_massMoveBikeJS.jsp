<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<script type="text/javascript">

var msmvBike = {};

function initMsmvBike(){
	
	setDisplay( "#coWorkFormDiv #btnWrkerMemDelete" , "hide");
	setDisplay( "#coWorkFormDiv #btnWrkerAdd"     	, "hide");
	setDisplay( "#coWorkFormDiv #btnCoworkDelete"   , "hide");
	
	 commonAjax.getCommonCode("DEC", 
		        function(data) {
			         if(data !== null && data.codeList !== null) {
			        	 var code = new Array();
			             for(var i =0; i <data.codeList.length ;i++) {
			                     code.push(data.codeList[i]);
			             }
			             commCdBox.makeComboBox('CC', '', code, "workCenterId");
			         }
	});
	 
	 
	 
	if ( $("#coWorkFormDiv #workFrHour option").size()  < 2 ) {
		for( var i=7; i<23; i++ ){
	    	$("#coWorkFormDiv #workFrHour").append("<option value='"+i+"'>"+i+"시</option>");
	    	$("#coWorkFormDiv #workToHour").append("<option value='"+i+"'>"+i+"시</option>");
		}
	} 
	
	coWorkSearch();
} 
 
function coWorkSearch(){

	commonAjax.postAjax("/distributionDiary/getDistCoWorkAjax.do", 'json', $("#coWorkFormDiv #coWorkForm").serialize()
			, function(data){
	        	
				if( !data.result ) {
					alert("정상적으로 조회가 되지 않았습니다.");
					return;
				}

				setDisplay( "#coWorkFormDiv #btnCoworkSave"     , "hide");		
				setDisplay( "#coWorkFormDiv #btnCoworkDelete"   , "hide");	// 공동작업 관련
				setDisplay( "#coWorkFormDiv #btnWrkerAdd"     	, "hide");	
				setDisplay( "#coWorkFormDiv #btnWrkerMemDelete" , "hide");	// 개별 참가 관련
				
				if ( data.list != null && data.list.coworkInfoSeq > 0 ){
					
					$("#coWorkFormDiv input[name='coworkInfoSeq']").val(data.list.coworkInfoSeq);
					$("#coWorkFormDiv input[name='coworkName']").val(data.list.coworkName);
					
					$("#coWorkFormDiv select[name='workCenterId']").val(data.list.workCenterId);// 작업장소
					$("#coWorkFormDiv select[name='workFrHour']").val(data.list.workFrHour);	// 시작시간
					$("#coWorkFormDiv select[name='workToHour']").val(data.list.workToHour);	// 종료시간
					
					$("#coWorkFormDiv input[name='workCnt']").val(data.list.workCnt);			// 참여인원
					$("#coWorkFormDiv input[name='workDtl']").val(data.list.workDtl);			// 작업내용
					$("#coWorkFormDiv input[name='bikeCnt']").val(data.list.bikeCnt);			// 자전거 건수
					$("#coWorkFormDiv select[name='workType']").val(data.list.workType);		// 작업유형
					
					$("#coWorkFormDiv #btnCoworkSave").html("수정");			// 등록
					
					switch ( data.usrGrpCd ){
						case "11" :	// 분배반장
						case "12" :	// 관리운영그룹
						case "13" :	// 운영팀
						case "14" :	// 관리팀
							setDisplay( "#coWorkFormDiv #btnCoworkSave"     	, "show");	// 메인 등록, 수정
							
							if ( data.list.coworkInfoSeq > 0 ){
								setDisplay( "#coWorkFormDiv #btnCoworkDelete"     	, "show");	// 메인 등록, 수정	
							}
							
						break;
						case "5" :	// 분배
						break;						
					}

					// 공동근무 신청 세팅
					if( data.list.isCoworkDeleteYn > 0 ) {
						setDisplay( "#coWorkFormDiv #btnWrkerAdd"     	  , "hide");
						setDisplay( "#coWorkFormDiv #btnWrkerMemDelete"   , "show");
					} else {
						setDisplay( "#coWorkFormDiv #btnWrkerAdd"     	  , "show");
						setDisplay( "#coWorkFormDiv #btnWrkerMemDelete"   , "hide");
					}
					
				} else {
					
					$("#coWorkFormDiv input[name='coworkInfoSeq']").val("");
					$("#coWorkFormDiv input[name='coworkName']").val("");
					
					$("#coWorkFormDiv input[name='workDtl']").val("");
					$("#coWorkFormDiv input[name='bikeCnt']").val("");
					$("#coWorkFormDiv select[name='workCenterId']").val("");
					$("#coWorkFormDiv select[name='workType']").val("");
					$("#coWorkFormDiv select[name='workFrHour']").val("");
					$("#coWorkFormDiv select[name='workToHour']").val("");
										
					switch ( data.usrGrpCd ){
						case "11" :	// 분배반장
						case "12" :	// 관리운영그룹
						case "13" :	// 운영팀
						case "14" :	// 관리팀
							$("#coWorkFormDiv #btnCoworkSave").html("등록");					// 등록
							setDisplay( "#coWorkFormDiv #btnCoworkSave"     	, "show");	// 메인 등록, 수정
						break;
					}
					setDisplay( "#coWorkFormDiv #btnWrkerAdd"     		, "hide");
					setDisplay( "#coWorkFormDiv #btnCoworkDelete"   	, "hide");
					setDisplay( "#coWorkFormDiv #btnWrkerMemDelete"   	, "hide");
				}
					 
	    	}
    ); 	
}

$("#coWorkFormDiv #btnCoworkSave").on("click", function(e) {
    e.preventDefault();
 
	commonAjax.postAjax("/distributionDiary/insertCoWorkAjax.do", 'json', $("#coWorkFormDiv #coWorkForm").serialize()
			, function(data){
	        	
			if( !data.result ) {
				alert("정상적으로 저장이 되지 않았습니다.");
				return;
			}
						
			coWorkSearch();
			alert("정상적으로 저장되었습니다.");
    	}
    )   
});

$("#coWorkFormDiv #btnCoworkDelete").on("click", function(e) {
    e.preventDefault();
 	
    if ( !confirm("정말 삭제하시겠습니까? 근무자들도 모두 삭제됩니다.")) return;
    
	commonAjax.postAjax("/distributionDiary/deleteDistCoWorkAdminAjax.do", 'json', $("#coWorkFormDiv #coWorkForm").serialize()
			, function(data){
	        	
			if( !data.result ) {
				alert("정상적으로 삭제가 되지 않았습니다.");
				return;
			}
			
			coWorkSearch();
			
			alert("정상적으로 삭제되었습니다.");
    	}
    )   
});

$("#coWorkFormDiv #btnWrkerMemDelete").on("click", function(e) {
    e.preventDefault();
 	
    if ( !confirm("정말 취소하시겠습니까?")) return;
    
	commonAjax.postAjax("/distributionDiary/deleteDistCoWorkMemberAjax.do", 'json', $("#coWorkFormDiv #coWorkForm").serialize()
			, function(data){
	        	
			if( !data.result ) {
				alert("정상적으로 취소가 되지 않았습니다.");
				return;
			}
			
			coWorkSearch();
			
			alert("정상적으로 취소되었습니다.");
    	}
    )   
});
 
   
$("#coWorkFormDiv #btnWrkerAdd").on("click", function(e) {
    e.preventDefault();

	commonAjax.postAjax("/distributionDiary/insertCoWorkDtlAjax.do", 'json', $("#coWorkFormDiv #coWorkForm").serialize()
		, function(data){
        	
			if( !data.result ) {
				alert("정상적으로 저장이 되지 않았습니다.");
				return;
			}
			
			$("#coWorkFormDiv input[name='coworkDtlSeq']").val(data.vo.coworkDtlSeq);
			
			coWorkSearch();
			alert("정상 저장되었습니다.");
	});	
});	
  
 
$("#coWorkFormDiv input[name='workCnt']").on("click", function(e) {
   	e.preventDefault();
		alert("참여자는 " + $("#coWorkFormDiv input[name='coworkName']").val());
	} 
);  


</script>
</body>
</html>