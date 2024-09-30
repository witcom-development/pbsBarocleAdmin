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

<script type="text/javascript" src="/js/common_barocle.js"></script>

<script type="text/javascript">
	<%-- 현재 메뉴의 값을 절대적으로 표시하야 함. --%> var currentPageName = "notice";
</script>

<style type="text/css">
	.close 			{display:inline-block;*display:inline;}
	.close:after 	{display: inline-block;content: "\00d7"; font-size:15pt; color:red;}
	
	/* 이미지 갤러리 시작 */
	.img 			{width: 50px;}
 	#fileList				{}
	#fileList::after			{content: ""; display: block; clear: both;}
	#fileList > li			{float: left; margin: 20px 10px; list-style:none;}
	#fileList > li > a		{display: block; text-decoration: none;}
	#fileList > li > a > img	{display: block;	width: 200px;	border: 5px solid black;	box-shadow: 4px 4px 4px rgba(0, 0, 0, 0.6);}
	#overlay				{position: fixed;top: 0; right: 0; left: 0; bottom: 0;background-color: rgba(0, 0, 0, 0.8);display: none;}
	#photo					{position: absolute;top: 50%; left: 50%;transform: translate(-50%, -50%);max-width: 80%;max-height: 80%;border: 10px solid white;}	
	/* 이미지 갤러리 종료 */
	
</style>

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
					
						<form id="tx_editor_form" name="tx_editor_form" method="post" accept-charset="utf-8">
							<input type="hidden" id="mode" name="mode" value="${bbsBoardVO.mode}" />
							<input type="hidden" id="noticeHtmlContent" name="boardHtmlContent" value="${bbsBoardVO.noticeHTMLContent}" />
							<input type="hidden" id="attachNo" name="attachNo" value="" />
							<input type="hidden" id="noticeSeq" name="noticeSeq" value="${bbsBoardVO.noticeSeq}" />
							<input type="hidden" id="imgSeq" name="imgSeq" value="" />
							<input type="hidden" id="atchFileID" name="atchFileID" value="" />
							
							<input type="hidden" id="cateCD" name="cateCD" value="J"/>
							 <input type="hidden" id="b1" name="popupYN" value="N"/>
							<fieldset>
								<legend>공지사항 작성</legend>
								<table class="tb_type02 mt20">
									<caption>공지사항 작성</caption>
										<colgroup>
											<col style="width:25%" />
											<col style="width:75%" />
										</colgroup>
									<tbody>
										
										<tr>
											<th><label for="bbsClsCd" class="laType02">제목</label></th>
											<td>
												<input type="text" id="noticeTitle" name="noticeTitle" class="input-text02p" value="${bbsBoardVO.noticeTitle}" style="width:200px" maxlength="200" /><span class="input-ck01">
												<input type="checkbox" id="a11" value="Y" <c:if test="${bbsBoardVO.mainNoticeYN=='Y'}">checked="true"</c:if>/><label for="a11">중요여부</label>
												<input type="hidden" id="b11" name="mainNoticeYN" value="${bbsBoardVO.mainNoticeYN}"/>
											</td>
										</tr>
										
										<tr>
											<th>공지기간</th>
											<td>
												<fmt:formatDate value="${bbsBoardVO.postStrDttm}" pattern="yyyy-MM-dd" var="postStrDttm"/>
												<span class="selectDate input-datepick02"><input id="sDate" name="postStrDttm" type="text" class="datepicker input-datepick02" title="선택 날짜" readonly="true" value="${postStrDttm}"/></span>
												<span class="dash">~</span>
												<fmt:formatDate value="${bbsBoardVO.postEndDttm}" pattern="yyyy-MM-dd" var="postEndDttm"/>
												<span class="selectDate input-datepick02"><input id="eDate" name="postEndDttm" type="text" class="datepicker input-datepick02" title="선택 날짜" readonly="true" value="${postEndDttm}"/></span>
											</td>
										</tr>
										
										
										<tr>
											<td colspan="2" id="editor">
												<textarea rows="20" cols="100" name="noticeTextContent">${bbsBoardVO.noticeTextContent}</textarea>
											</td>
										</tr> 
									</tbody>
								</table>
								
							</fieldset>
						
							<!-- 파일 첨부 area -->
							<div id="dropbox" style="width: 99%; height: 50px; margin-top:20px; border: 2px dotted green">
								<input	type="file"	id="fileElem"	multiple style="display:none"	onchange="handleFiles(this.files)" />
								<a href="#" id="fileSelect">파일 첨부 클릭 또는 파일 드래그</a>
								<img id="container111"/>
							</div>						
							<!-- 파일 첨부 area End -->
							
							<!-- 파일 조회영역 -->
							<div id="fileList">
							
								<c:choose>
									<c:when test="${fn:length(bbsImgList) > 0 }">
										<c:forEach items="${bbsImgList}" var="list" varStatus="status">
												<li id=<c:out value="${list.imgSeq}"/>>
													<a href="${list.imgURL}">
														<img class="img" src="${list.imgURL}" alt="Thumbnails">
													</a>
													<button class="close" type="button"  onclick="deleteImage('<c:out value="${list.imgSeq}"/>');"></button>
												</li>
										</c:forEach>
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>						
							</div>	
							
			 				<ul id="fileList">
								<c:choose>
									<c:when test="${fn:length(bbsFileList) > 0 }">
										<c:forEach items="${bbsFileList}" var="list" varStatus="status">
												<li id=<c:out value="${list.imgSeq}"/>>
													<div style="float:left; width: auto"><a href="${list.imgURL}">${list.imgName}</a></div>
													<div style="float:right; width: 20px">
														<button class="close" type="button" onclick="deleteImage('<c:out value="${list.imgSeq}"/>');"></button>
													</div>
												</li>
										</c:forEach>
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>
							</ul>
							<!-- 파일 조회영역 end -->	 
								
												
						</form>
						
						<div class="btnArea">
							<span class="left"><button class="btnType01 bc_gray" onclick="location.href='/admin/customer/notice/noticeList.do';">목록</button></span>
							<span class="right">
								<c:if test="${bbsBoardVO.noticeSeq>0}">
									<button  class="btnType01"  onclick="deleteContent('<c:out value="${noticeView.noticeSeq}"/>');">삭제</button>
								</c:if>
								<button class="btnType01 bc_green" onclick='saveContent();'>저장</button>
							</span>
						</div>
					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		
		
		<!-- 이미지 갤러리 시작 -->
		<div id="overlay">
			<img src="" alt="photo" id="photo">
		</div>									
		<!-- 이미지 갤러리 종료 -->
		<script>
	
		var bbsEdit = {};
		
	    $(function() {
	    	
	    });

		var fileArr = [];
		
		<c:forEach items="${bbsImgList}" var="list" varStatus="status">
			fileArr.push("${list.imgSeq}");
			
		</c:forEach>
		<c:forEach items="${bbsFileList}" var="list" varStatus="status">
			fileArr.push("${list.imgSeq}");
		</c:forEach>
		
		/* 이미지 갤러리 시작 */
	    var overlay = document.getElementById("overlay");
	    var photo = document.getElementById("photo");
	    var Thumbnails = document.querySelectorAll("#fileList > li > a");
	 
	    for(var i=0; i<Thumbnails.length; i++){
	    	Thumbnails[i].addEventListener("click", function(e){
	    	e.preventDefault();
	    	//alert(1);
	    	photo.src = this.href;
	    	overlay.style.display = "block";
		    });
		 
		    overlay.addEventListener("click", function(){
			
	    		this.removeAttribute("style");
			
	    	});
	    }		
	    /* 이미지 갤러리 종료 */		

	    /* 파일 첨부 */
		window.URL = window.URL || window.webkitURL;

		const fileSelect = document.getElementById("fileSelect"),
			fileElem = document.getElementById("fileElem"),
			fileList = document.getElementById("fileList");

		var dropbox;
	
		dropbox = document.getElementById("dropbox");
		dropbox.addEventListener("dragenter", dragenter, false);
		dropbox.addEventListener("dragover", dragover, false);
		dropbox.addEventListener("drop", drop, false);
		dropbox.addEventListener("paste", paste, false);
		
		fileSelect.addEventListener(
		  "click",
		  function (e) {
			  
			  if(	$("#noticeSeq").val() == 0 ) {
	        		alert("게시글을 먼저 작성 후, 파일 저장 부탁드립니다.");
	        		return;
	        	}
 
				if (fileElem) {
					fileElem.click();
				}
				e.preventDefault(); // "#" 해시로 이동을 방지
			},
		  	false
		);

		
		function handleFiles(files) {
			if (!files.length) {
				fileList.innerHTML = "<p>파일 미존재</p>";
			} else {
				
				let innerHtml = fileList.innerHTML;
				
				if( innerHtml == "<p>첨부된 파일 없음</p>")	fileList.innerHTML = "";
				
				const list = document.createElement("ul");
				fileList.appendChild(list);
				for (let i = 0; i < files.length; i++) {
					const li = document.createElement("li");
					list.appendChild(li);
					
					const img = document.createElement("img");
					
					img.classList.add("obj");
					img.file = files[i];

					if (files[i].type.startsWith("image/")) {
						img.src = window.URL.createObjectURL(files[i]);
						img.width = 30;
						img.height = 30;
				    }
					img.onload = function () {
					  window.URL.revokeObjectURL(this.src);
					};
					li.appendChild(img);
					
					// 파일 업로드
					new FileUpload(img, files[i] , li);
				}
			}
		}		
		
		function dragenter(e) {
			  e.stopPropagation();
			  e.preventDefault();
		}

		function dragover(e) {
		  e.stopPropagation();
		  e.preventDefault();
		}
		
		function drop(e) {
		  e.stopPropagation();
		  e.preventDefault();

		  
		  if(	$("#noticeSeq").val() == 0 ) {
      		alert("게시글을 먼저 작성 후, 파일 저장 부탁드립니다.");
      		return;
      	}
		  
		  const dt = e.dataTransfer;
		  const files = dt.files;

		  handleFiles(files);
		}
		
		function paste(pasteEvent) {
			
			if(	$("#noticeSeq").val() == 0 ) {
        		alert("게시글을 먼저 작성 후, 파일 저장 부탁드립니다.");
        		return;
        	}
			
			
			// 첫 번째 항목을 고려합니다(여러 항목에 대해 쉽게 확장할 수 있음)
		    var item = pasteEvent.clipboardData.items[0];
		    
		    if (item.type.indexOf("image") === 0)
		    {
		       
				let innerHtml = fileList.innerHTML;
				if( innerHtml == "<p>첨부된 파일 없음</p>")	fileList.innerHTML = "";
		    	
		    	var blob = item.getAsFile();
		 
		        var reader = new FileReader();
		        reader.onload = function(event) {
		        	
				const list = document.createElement("ul");
				const li = document.createElement("li");
				list.appendChild(li);
				fileList.appendChild(list);
				const img = document.createElement("img");
				img.classList.add("obj");
				img.file = event.target.result;
				// if (event.target.result.type.startsWith("image/")) {
				img.src = event.target.result;
				img.width = 30;
				img.height = 30;
				img.onload = function () {
				  window.URL.revokeObjectURL(event.target.result);
				};
				li.appendChild(img);
					
					// 파일 업로드
				new FileUpload(img, blob , li);
					// document.getElementById("container111").src = event.target.result;
			};
			
			reader.readAsDataURL(blob);
		    }
		}
		
		function FileUpload(img, blob, li ) {
			const formData = new FormData();
        	formData.append('image', blob);
        	
        	var bbsSeq = "";
        	
        	if(	$("#noticeSeq").val() > 0 ) {
        		bbsSeq = $("#noticeSeq").val();
        	}
        	
        	let url = '/images/';
   			$.ajax({
           		type: 'POST',
           		enctype: 'multipart/form-data',
           		url: '/admin/customer/notice/fileUpload.do?currentPageName=notice&noticeSeq='+bbsSeq,
           		data: formData,
           		dataType: 'json',
           		processData: false,
           		contentType: false,
           		cache: false,
           		timeout: 600000,
           		success: function(data) { 
           			fileArr.push(data.imgSeq);
           			const info = document.createElement("span");
					info.innerHTML = "<a target='_blank()' href='" + data.imageurl  + "'>" +  data.imageName +"</a>";
					li.appendChild(info);
           			
           		},
           		error: function(e) {
           			//console.log('ajax 이미지 업로드 실패');
           			console.log(e);
           			alert( '이미지 저장 실패');
           		}
           	});			
		}
		
		function deleteImage(imgSeq){
			if( !confirm("이미지를 삭제하시겠습니까?")) return;
			$("#imgSeq").val(imgSeq);
			$("#atchFileID").val(imgSeq);
			commonAjax.postAjax("/admin/customer/notice/deleteImage.do", "json", $("#tx_editor_form").serialize()
		    		,function(data){
		    		   
						if(data) {
		    			  var result = data.checkResult;
		    			  if( result ) {
		    			  	var delFileArr = [];
		    			  	
		    			  	for(var i = 0; i < fileArr.length; i++){ 
		    			  	  if (fileArr[i] === imgSeq) { 
		    			  	    continue;
		    			  	  } else {
		    			  		delFileArr.push(fileArr[i]);
		    			  	  }
		    			  	}
		    			  	
		    			  	fileArr = delFileArr;
		    				$("#"+imgSeq).remove();
		    				alert("정상적으로 삭제되었습니다.");
		    			  } else {
		    				  console.log(data.resultMessage);  
		    				  alert(data.resultMessage);  
		    			  }
		    		   }
		    	}
		    );
		}
		
		/* 파일 첨부 end */
		function deleteContent(boardSeq){
			$("#noticeSeq").val(boardSeq);
			commonAjax.postAjax("/admin/board/distribute/boardDelete.do", "json", $("#tx_editor_form").serialize()
		    		,function(data){
		    		   
						if(data) {
		    			  var result = data.checkResult;
		    			  if( result ) {
		    				 console.log( data.BOARD_SEQ); 
		    				 $("#boardSeq").val(data.BOARD_SEQ);		// key 등록
		    				alert("정상적으로 처리되었습니다.");	
		    				location.href='/admin/customer/notice/noticeList.do"/>';
		    			  } else {
		    				  console.log(data.resultMessage);  
		    				  alert(data.resultMessage);  
		    			  }
		    		   }
		    	}
		    ); 
		}
		
		function saveContent() {
			
			$("#imgSeq").val(fileArr);
			
			if($("#a11").is(":checked")){
				$("#b11").val('Y');
			} else {
				$("#b11").val('N');
			}
			
			commonAjax.postAjax("/admin/customer/notice/noticeInsert.do", "json", $("#tx_editor_form").serialize()
		    		,function(data){
		    		   
						if(data) {
		    			  var result = data.checkResult;
		    			  if( result ) {
		    				 console.log( data.BOARD_SEQ); 
		    				 $("#noticeSeq").val(data.BOARD_SEQ);		// key 등록
		    				alert("정상적으로 처리되었습니다.");	  
		    			  } else {
		    				  console.log(data.resultMessage);  
		    				  alert(data.resultMessage);  
		    			  }
		    		   }
		    	}
		    );
		}
		
		</script>	
		<!-- ================================================== End: Loading Contents ================================================== -->
		
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>