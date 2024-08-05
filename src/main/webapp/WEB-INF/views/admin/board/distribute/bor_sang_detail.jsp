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
<!-- daumeditor -->
<script type="text/javascript" src="<c:url value='/daumeditor/js/editor_loader.js?environment=production'/>" charset="utf-8"></script>
<link type="text/css" rel="stylesheet" href="<c:url value='/daumeditor/css/editor.css'/>"/>
<script type="text/javascript">
	<%-- 현재 메뉴의 값을 절대적으로 표시하야 함. --%> var currentPageName = "manageBoard";
</script>
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
						<form id="tx_editor_form" name="tx_editor_form" method="post" accept-charset="utf-8" onsubmit="return false;">
							<input type="hidden" id="mode" name="mode" value="${distributeBoardView.mode}" /><%-- <form:errors path="mode" cssClass="error" /> --%>
							<input type="hidden" id="distSeq" name="distSeq" value="${distributeBoardView.distSeq}" /><%-- <form:errors path="distSeq" cssClass="error"/> --%>
							<input type="hidden" id="distNO" name="distNO" value="${distributeBoardView.distNO}" />
							<input type="hidden" id="sortOrd" name="sortOrd" value="${distributeBoardView.sortOrd}" />
							<input type="hidden" id="seqNo" name="seqNo" value="${seqNo}" />
							<input type="hidden" id="attachNo" name="attachNo" value="" />
							<input type="hidden" id="cateCD" name="cateCD" value="S"/>
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
											<th class="top">제목</th>
											<td class="top">
												<input id="distTitle" name="distTitle" type="text" class="input-text02p" value="${distributeBoardView.distTitle}" maxlength="256" /><span class="input-ck01">
												<input type="checkbox" id="a1" value="Y" <c:if test="${distributeBoardView.popupYN=='Y'}">checked="true"</c:if>/><label for="a1">팝업여부</label>&nbsp;&nbsp;
												<input type="hidden" id="b1" name="popupYN" value="${distributeBoardView.popupYN}"/>
												<input type="checkbox" id="a11" name="mainDistYN" value="Y" /><label for="a11">최상단등록</label>
												<%-- <input type="checkbox" id="a11" name="pushYN" value="Y" /><label for="a11">푸시여부</label> --%>
												</span>
											</td>
										</tr>
										<tr>
											<th>공지기간</th>
											<td>
												<fmt:formatDate value="${distributeBoardView.postStrDttm}" pattern="yyyy-MM-dd" var="postStrDttm"/>
												<span class="selectDate input-datepick02"><input id="sDate" name="postStrDttm" type="text" class="datepicker input-datepick02" title="선택 날짜" value="${postStrDttm}" readonly/></span>
												<span class="dash">~</span>
												<fmt:formatDate value="${distributeBoardView.postEndDttm}" pattern="yyyy-MM-dd" var="postEndDttm"/>
												<span class="selectDate input-datepick02"><input id="eDate" name="postEndDttm" type="text" class="datepicker input-datepick02" title="선택 날짜" value="${postEndDttm}" readonly/></span>
											</td>
										</tr>
										<tr>
											<th>공지대상</th>
											<td>
												<span class="input-ck01"><input type="checkbox" id="a2" name="siteClsCD" value="sang" checked="checked"/><label for="a2">상담원</label></span>
												<span class="input-ck01"><input type="checkbox" id="a3" name="siteClsCD" value="bun" <c:if test="${fn:indexOf(distributeBoardView.siteClsCD,'bun')>-1}">checked="true"</c:if>/><label for="a3">분배원</label></span>
												<span class="input-ck01"><input type="checkbox" id="a4" name="siteClsCD" value="jeng" <c:if test="${fn:indexOf(distributeBoardView.siteClsCD,'jeng')>-1}">checked="true"</c:if>/><label for="a4">정비원</label></span>
											</td>
										</tr>
										<%-- <tr>
											<th>공지여부 ${distributeBoardView.mainDistYN}</th>
											<td>
												<span class="input-rd01"><input type="radio" id="a4" name="mainDistYN" value="Y" <c:if test="${empty distributeBoardView.mainDistYN || distributeBoardView.mainDistYN=='Y'}">checked="true"</c:if> /><label for="a5">공개</label></span>
												<span class="input-rd01"><input type="radio" id="a5" name="mainDistYN" value="N" <c:if test="${distributeBoardView.mainDistYN=='N'}">checked="true"</c:if> /><label for="a6">비공개</label></span>
											</td>
										</tr> --%>
										<tr>
											<th><span>내용</span></th>
											<td class="editor">
												<!--daum editor S-->
												<tiles:insertAttribute name="dist_daum_editor"/>
												<div style="display:none;"><textarea id="dist_HTML_content" name="content"></textarea></div>
												<!--daum editor E-->
											</td>
										</tr> 
										<c:if test="${fn:length(daumEditorImageList) > 0}">
											<tr>
												<th>다운로드</th>
												<td>
													<c:forEach var="result" items="${daumEditorImageList}" varStatus="status" >
															<h2><a href="#" class="fileDownload" value="${result.imgSeq}">${result.imgNm}</a></h2><br/>
													</c:forEach> 
													<!-- <span class="right"><button type="button" id="fileDownload" class="btnType01">파일 다운로드</button></span> -->
												</td>
											</tr>
										</c:if>
									</tbody>
								</table>
								<div class="btnArea">
									<span class="left"><button class="btnType01 bc_gray" onclick="location.href='/admin/board/distribute/getSangBoardList.do?currentPageNo=<c:out value="${distributeBoardView.currentPageNo}"/><c:out value="${parameterInfo}" escapeXml="false"/>';">목록</button></span>
									<span class="right">
										<c:if test="${distributeBoardView.distSeq>0}">
											<button class="btnType01" onclick="deleteContent('<c:out value="${distributeBoardView.distSeq}"/>');">삭제</button>
										</c:if>
										<button class="btnType01 bc_green" onclick='return saveContent();'>저장</button>
									</span>
								</div>
							</fieldset>
						</form>
					</div>
				</div>
				<!--content E-->
			</div>
		</div>

		<script type="text/javascript">
			var config = {
				txHost: '', /* 런타임 시 리소스들을 로딩할 때 필요한 부분으로, 경로가 변경되면 이 부분 수정이 필요. ex) http://xxx.xxx.com */
				txPath: '', /* 런타임 시 리소스들을 로딩할 때 필요한 부분으로, 경로가 변경되면 이 부분 수정이 필요. ex) /xxx/xxx/ */
				txService: 'ntc', /* 수정필요없음. */
				txProject: 'ntc', /* 수정필요없음. 프로젝트가 여러개일 경우만 수정한다. */
				initializedId: "", /* 대부분의 경우에 빈문자열 */
				wrapper: "tx_trex_container", /* 에디터를 둘러싸고 있는 레이어 이름(에디터 컨테이너) */
				form: 'tx_editor_form'+"", /* 등록하기 위한 Form 이름 */
				txIconPath: "/daumeditor/images/icon/editor/", /*에디터에 사용되는 이미지 디렉터리, 필요에 따라 수정한다. */
				txDecoPath: "/daumeditor/images/deco/contents/", /*본문에 사용되는 이미지 디렉터리, 서비스에서 사용할 때는 완성된 컨텐츠로 배포되기 위해 절대경로로 수정한다. */
				canvas: {
		            exitEditor:{
		            	/* 
		                desc:'빠져 나오시려면 shift+b를 누르세요.',
		                hotKey: {
		                    shiftKey:true,
		                    keyCode:66
		                },
		                nextElement: document.getElementsByTagName('button')[0]
		                 */
		            },
					styles: {
						color: "#123456", /* 기본 글자색 */
						fontFamily: "굴림", /* 기본 글자체 */
						fontSize: "10pt", /* 기본 글자크기 */
						backgroundColor: "#fff", /*기본 배경색 */
						lineHeight: "1.5", /*기본 줄간격 */
						padding: "8px" /* 위지윅 영역의 여백 */
					},
					showGuideArea: false,
		            autolink: false
				},
				events: {
					preventUnload: false
				},
				sidebar: {
					attachbox: {
						show: true,
						confirmForDeleteAll: true
					}
				},
				size: {
					contentWidth: 700 /* 지정된 본문영역의 넓이가 있을 경우에 설정 */
				},
		        toolbar: {
		            codehighlight: {
		                styleSheetUrl: [/* "http://google-code-prettify.googlecode.com/svn/trunk/src/prettify.css" */
		                	"https://cdn.bootcss.com/prettify/r298/prettify.css"],
		                highlight: function(code){
		                    return prettyPrintOne(code);
		                }
		            },
		            paste: {
		                defaultMode: Trex.Paste.MODE_HTML
		            }
		        }
			};
			EditorJSLoader.ready(function(Editor) {
				var editor = new Editor(config);
			});
		</script>
		
		<!-- ================================================== Start: Saving Contents ================================================== -->
		<script type="text/javascript">
		
			$(function() {
				$(".fileDownload").click(function(){
					if(confirm("다운로드 하시겠습니까?")){
						var imgURL= $(this).attr('value');
						location.href = "/admin/board/distribute/downloadFile.do?imgSeq="+imgURL+"&currentPageName="+currentPageName;
					}else return false;
				});
			});
			function saveContent() { 
				if(confirm("저장 하시겠습니까?")){
					if($("#a1").is(":checked")){
						$("#b1").val('Y');
					} else {
						$("#b1").val('N');
					}
					Editor.save(); 
				}
			}
			function deleteContent(distSeq){
				if(confirm("삭제 하시겠습니까?")){
					location.href = "/admin/board/distribute/distBoardDelete.do?mode=delete&distSeq="+distSeq;
				} else return false;
			}
			
			function validForm(editor) {
				/* 제목 */
				if($.trim($("#distTitle").val())==''){
					$("#distTitle").focus();
					alert("제목을 입력해 주세요.");
					return false;
				}
				/* 날짜 */
				if($("#sDate").val()==''){ alert("공지 시작 날짜를 선택해 주세요."); return false; }
				if($("#eDate").val()==''){ alert("공지 종료 날짜를 선택해 주세요."); return false; }
				if($("#sDate").val()>$("#eDate").val()){
					alert("공지 종료 날짜는 시작 날짜보다 빠를 수 없습니다.");
					return false;
				}
				/* 공지대상 */
				if(!$("#a2").prop('checked')&&!$("#a3").prop('checked')&&!$("#a4").prop('checked')){ alert("공지대상을 선택해 주세요."); return false; }
				/* 본문 내용이 입력되었는지 검사하는 부분 */
				var validator = new Trex.Validator();
				var content = editor.getContent();
				if(!validator.exists(content)) {
					alert("내용을 입력해 주세요.");
					return false
				}
				var mode = $("#tx_editor_form").children("#mode").val();
				if(mode=='insert'){
					$("#tx_editor_form").attr('action','/admin/board/distribute/distBoardInsert.do').submit();
				} else if(mode=='update'){
					$("#tx_editor_form").attr('action','/admin/board/distribute/distBoardUpdate.do').submit();
				} else {
					alert("모드 값이 설정되지 않았습니다.");
					return false;
				}
				return true;
			}
			
			function setForm(editor) {

				document.getElementById("dist_HTML_content").disabled=true;
		        var i,f, input;
		        var form = editor.getForm();
		        var distHTMLContent = editor.getContent();
		        var textarea = document.createElement('textarea');
		        textarea.name = 'distHTMLContent';
		        textarea.value = distHTMLContent;
		        
		        if(document.getElementsByName("distHTMLContent").length == 0){
			        form.createField(textarea);
		        }
		        
		        $('[name="distHTMLContent"]').attr('style', 'display:none');
		       /*  var images = editor.getAttachments('image');
		        for (i = 0; i < images.length; i++) {
		            if (images[i].existStage) {
		                input = document.createElement('input');
		                input.type = 'hidden';
		                input.name = 'attach_image_info';
		                input.value = JSON.stringify(images[i].data);
		                form.createField(input);
		            }
		        }
		        
		        var files =editor.getAttachments('file', true);
		        alert(files.length);
		        for (k = 0; k < files.length; k++) {
		            if (files[k].existStage) {
		                input = document.createElement('input');
		                input.type = 'hidden';
		                input.name = 'attach_file';
		                input.value = JSON.stringify(files[k].data);
		                alert(files[k].data.attachurl);
		                form.createField(input);
		            }
		        } */

		        
		      //이미지, 파일 업로드 _cms_20161108
		        var edtList = Editor.getAttachBox().datalist;
		        var imglist =Editor.getAttachments('image', true);
		        var filelist =Editor.getAttachments('file', true);
		        
		         for( f = 0; f < edtList.length; f++ ){
		        	for(k = 0; k < imglist.length; k++){
		        		if(edtList[f].data.dispElId == imglist[k].data.dispElId){
			        		 var entry = edtList[f];
				            	 input = document.createElement('input');
					             input.type = 'hidden';
					             input.name = 'attach_image_info';
					             input.value = JSON.stringify(edtList[f].data);
					             form.createField(input);
		        		}
		        	 }
		         } 
		         
		         for( f = 0; f < edtList.length; f++ ){
			        	for(k = 0; k < filelist.length; k++){
			        		if(edtList[f].data.dispElId == filelist[k].data.dispElId){
				        		 var entry = edtList[f];
					            	 input = document.createElement('input');
						             input.type = 'hidden';
						             input.name = 'attach_file';
						             input.value = JSON.stringify(edtList[f].data);
						             form.createField(input);
		        		}
		        	}
		        } 
		        return true;
			}
			
			var previousValue;
			$("input").on('focus',function(){
				previous = this.value;
			}).change(function(){
				var sDate = $("#sDate").val();
				var eDate = $("#eDate").val();
				if(sDate!=''&&eDate!=''&&sDate>eDate){
					alert("공지 종료 날짜는 시작 날짜보다 빠를 수 없습니다.");
					$(this).val(previous);
				}
			});
			function checkPopup(){
				if($("#a1").is(":checked")){
					$("#a2").attr("checked",true);
					$("#a3").attr("checked",false).prop("disabled",true);
				} else {
					$("#a3").prop("disabled",false);
				}
			}
		</script>
		<!-- ================================================== End: Saving Contents ================================================== -->
		
		<!-- ================================================== Start: Loading Contents ================================================== -->
		<textarea id="dist_TEXT_content" style="display:none;"><c:out value="${distributeBoardView.distHTMLContent}"/></textarea>
		<script type="text/javascript">
			$(document).ready(function(){
				
				/* 기간 초기설정 : 한달  */
				var myDate = new Date();
				var sYear = myDate.getFullYear();
			    var sMonth = myDate.getMonth()+1;
			    var sDay = myDate.getDate();
			    var eDay = myDate.getDate()-1;
			    var eMonth = myDate.getMonth()+2;
			    var eYear = myDate.getFullYear();
			    if(eMonth > 12){
			    	eYear = myDate.getFullYear()+1;
			    	eMonth = '01';
			    } 
			    var setSDate = sYear + '-' + sMonth + '-' + sDay;
			    var setEDate = eYear + '-' + eMonth + '-' + eDay;
			    if( $("#sDate").val() == '' && $("#eDate").val() == '' ){
			    	$("#sDate").val(setSDate); 
				    $("#eDate").val(setEDate);
			    } else {
				    $("#sDate").val();
				    $("#eDate").val();
			    } 
			    
				/* 에러 메시지  */
				var alertValue = "<c:out value='${resultError.errorMessage}'/>";
				if(alertValue!=""){ alert(alertValue); }
				<%--
				/* 팝업 */
				$("#a1").click(function(){
					checkPopup();
				});
				/* 초기 팝업 */
				checkPopup();
				--%>
				/* 이미지 */
				var attachments = {};
				
				attachments['image'] = [];
				<c:if test="${fn:length(daumEditorImageList) > 0 }">
					<c:forEach items="${daumEditorImageList}" var="daumEditorVO" varStatus="status">
						attachments['image'].push({
						    'attacher': 'image',
						    'data': {
								'imageurl': '<c:out value="${daumEditorVO.imgURL}"/>',
								'filename': '<c:out value="${daumEditorVO.imgName}"/>',
								'filesize': <c:out value="${daumEditorVO.imgSize}"/>,
								'originalurl': '<c:out value="${daumEditorVO.imgURL}"/>'
							}
						});
					</c:forEach>
				</c:if>
				
				/* 내용 */
				Editor.modify({
					"attachments": function () { /* 저장된 첨부가 있을 경우 배열로 넘김, 위의 부분을 수정하고 아래 부분은 수정없이 사용 */
						var allattachments = [];
						for (var i in attachments) { allattachments = allattachments.concat(attachments[i]); }
						return allattachments;
					}(),
					"content": document.getElementById("dist_TEXT_content").value
				});
			});

			<%-- $(window).load(function() { console.log( "window loaded" ); }); --%>
		</script>
		<!-- ================================================== End: Loading Contents ================================================== -->
		
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>