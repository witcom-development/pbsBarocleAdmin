<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<%@ include file="../popup/pop_resource.jsp" %>

<script>
console.log( "${brokenInfo}");
</script>

</head>
<body>
	<h1 class="popTtl">고장내용 상세</h1>
	<div class="cntbox">
		<form id="frm">
			<input type="hidden" name="repairOursrcSeq" value="${brokenInfo.repairOursrcSeq}">
			<input type="hidden" name="collectYn" value="${brokenInfo.collectYn}">
			<input type="hidden" name="viewFlg" value="${brokenInfo.viewFlg}">
			<input type="hidden" name="repairYn" value="${brokenInfo.repairYn}">
			<input type="hidden" name="repairDttm" value="${brokenInfo.repairDttm}">
			<input type="hidden" name="brokenStatusCd" value="">
			<input type="hidden" name="mode" value="">

	        <div class="allwrap pop">
				<table class="tb_type02 mt20" id="tb_repair">
					<colgroup>
								<col style="width:0%"/>
								<col style="width:23%"/>
								<col style="width:18%"/>
								<col style="width:27%"/>
								<col style="width:10%"/>
								<col style="width:15%"/>
					</colgroup>
					<thead>
						<tr>
								<th></th> 
								<th>수리항목</th> 
								<th>등록자</th>
								<th>등록일시</th>
								<th></th>
								<th>구분</th>
							</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${brokenList}" varStatus="status">
							<tr>
								<td><span style="display:none;">${result.brokenStatusCd}</span></td>
								<td>${result.brokenType}</td> 
								<td>${result.adminId}</td>
								<td>${result.regDttm}</td>
								<td>${result.discountRate}</td>
								<td>
									<c:if test="${ brokenInfo.collectYn ne 'Y'}">
										<button class="btnType02" id="deleteRow">삭제</button>
									</c:if>	
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="btnArea">
					<span class="right">
					<c:if test="${ brokenInfo.collectYn ne 'Y'}">
						<button class="btnType01 bc_blue" id="insertRow">행추가</button>
						<button class="btnType01 bc_green" id="saveBtn">저장</button>
					</c:if>
						<button class="btnType01 bc_gray" id="cancelBtn">닫기</button>
					</span>
				</div>
			</div>
		</form>
	</div>
	<a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
	<script type="text/javascript" src="/js/common_barocle.js"></script>
	<script type="text/javascript">
    $(function() {
    	
    	var select = '<select class="select-category03" name="suribike" id="selectOption">';
    		select += '<option value="">선택</option>'		
    		<c:forEach var="result" items="${codeList}" varStatus="status">
    			select += '<option value=${result.brokenStatusCd}>${result.brokenType}</option>'
			</c:forEach>
    		select += '</select>'
    		;
		
    	var isInsert = false;	
    	
    	$("#insertRow").on("click", function(e){
    		e.preventDefault();
    		
    		if ( isInsert ) {
    			alert("저장 후 추가하세요.");
    			return false;
    		}
    		
    		const table = document.getElementById('tb_repair');
    		  
    		// 새 행(Row) 추가
    		 const newRow = table.insertRow();
    		  // 새 행(Row)에 Cell 추가
    		  const newCell1 = newRow.insertCell(0);
    		  const newCell2 = newRow.insertCell(1);
    		  const newCell3 = newRow.insertCell(2);
    		  const newCell4 = newRow.insertCell(3);
    		  const newCell5 = newRow.insertCell(4);
    		  const newCell6 = newRow.insertCell(5);
    		  
    		  // Cell에 텍스트 추가
    		  newCell2.innerHTML =  select;
    		  newCell4.innerText = '항목 선택후 저장필수';
    		  newCell6.innerText = '저장';
    		  
    		  isInsert = true;
    	});
    	
		$(".btnType02").click(function(){ 
			
			
			if ( $('#tb_repair >tbody tr').length == 1  ) {
				alert("최소 1개 이상은 등록되어야 합니다.");
				return false;
			}
			
			var checkBtn = $(this);
			
			// checkBtn.parent() : checkBtn의 부모는 <td>이다.
			// checkBtn.parent().parent() : <td>의 부모이므로 <tr>이다.
			var tr = checkBtn.parent().parent();
			var td = tr.children();
			
			// console.log("클릭한 Row의 모든 데이터 : "+tr.text());
			var no = td.eq(0).text();
			
			$("input[name=brokenStatusCd]").val(no) ;
    		$("input[name=mode]").val("D") ;
    		
    		saveBrokenPart("D");
			 
		});
    	 
    	$("#cancelBtn").on("click", function(e){
    		e.preventDefault();
    		window.opener.location.reload();
    		window.close();
    	});
    	$(".popclose").on("click", function(e){
    		e.preventDefault();
    		window.opener.location.reload();
    		window.close();
    	});
    	
    	$("#saveBtn").on("click", function(e){
    		e.preventDefault();
    		
    		if ( !isInsert ) {
    			alert("행 추가 후 저장하세요.");
    			return false;
    		}
    		
    		var dd =  $("#selectOption").val() ;
    		
    		if ( typeof dd == "undefined" || dd == "" || dd == null  ) {
    			alert("수리 항목이 선택되지 않았습니다.");
    			return false;
    		}
    		$("input[name=brokenStatusCd]").val(dd) ;
    		$("input[name=mode]").val("U") ;
    		saveBrokenPart("U");
    	});  
 
    });
     
    
    function saveBrokenPart(div){
     
    	$.ajax({
			url : "/updateBrokenPartsAjax.do",
			type : "post",
			dataType : "json",
			data : $("#frm").serialize(),
			async : false,
	   		beforeSubmit: function (data,form,option) {
				return true;
			},
			success : function(data){
				if(data.resultMessage == "Success"){
					if ("U" == div ) {
						alert("고장부위 저장이 완료되었습니다.");
					} else {
						alert("고장부위가 삭제되었습니다.");
					}	
				}
				location.reload();
				
			},
			error : function(jqXHR, textStatus,errorThrown){
				if(jqXHR.status === 500 || jqXHR.status === 200){
					alert("에러가 발생했습니다. : " + textStatus);
				}
			}
		});  
    }
    </script>
</body>
</html>
