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
	<%-- 현재 메뉴의 값을 절대적으로 표시하야 함. --%> var currentPageName = "opinionboard";
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
							<input type="hidden" id="mode" name="mode" value="${opinionBoardView.mode}" /><%-- <form:errors path="mode" cssClass="error" /> --%>
							<input type="hidden" id="qnaSeq" name="qnaSeq" value="${opinionBoardView.qnaSeq}" /><%-- <form:errors path="noticeSeq" cssClass="error"/> --%>
							<fieldset>
								<legend>시민의견수렴 게시판</legend>
								<table class="tb_type02 mt20">
									<colgroup>
										<col style="width:25%"/>
										<col style="width:75%"/>
									</colgroup>
									<tbody>
										<tr>
											<th class="top">제목
											</th>
												<td class="top"><c:out value="${opinionBoardView.qestnTitle}"/>
											</td>
										</tr>
										<tr>
											<th>구분
											</th>
												<td><c:out value="${opinionBoardView.cdNm }"/>
											</td>
										</tr>
										<tr>
											<th>등록자</th>
											<td><c:out value="${opinionBoardView.usr_regID}"/></td>
										</tr>
										<tr>
											<th>등록일시</th>
											<td><fmt:formatDate value="${opinionBoardView.usr_regDttm}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										</tr>
										<tr>
											<th><span>내용</span></th>
											<td>
												<c:out value="${opinionBoardView.qestnTextContent}"/>
											</td>
										</tr>
										<tr class="editorLine">
											<th>답변</th>
											<td class="editor">
												<!--daum editor S-->
												<tiles:insertAttribute name="daum_editor"/>
												<div style="display:none;"><textarea id="answer_HTML_content" name="content"></textarea></div>
												<!--daum editor E-->
											</td>
										</tr>
										<tr>
											<th>공개여부</th>
											<td><c:out value="${opinionBoardView.openNm}"/></td>
										</tr>
										<tr>
											<th>답변자</th>
											<td><c:out value="${opinionBoardView.regID}"/></td>
										</tr>
										<tr>
											<th>답변일시</th>
											<td><fmt:formatDate value="${opinionBoardView.modDttm}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										</tr>
									</tbody>
								</table>
								<div class="btnArea">
									<span class="left"><button class="btnType01 bc_gray" onclick="location.href='/admin/customer/opinionBoard/opinionBoardList.do?currentPageNo=<c:out value="${opinionBoardView.currentPageNo}"/><c:out value="${parameterInfo}" escapeXml="false"/>';">목록</button></span>
									<span class="right">
										<c:if test="${opinionBoardView.qnaSeq>0}">
											<button class="btnType01" onclick="deleteContent('<c:out value="${opinionBoardView.qnaSeq}"/>');">질문 삭제</button>
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
		                styleSheetUrl: ["http://google-code-prettify.googlecode.com/svn/trunk/src/prettify.css"],
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
			/* 예제용 함수 */
			function saveContent() { 
				if(confirm("저장 하시겠습니까?")){
					Editor.save(); 
				}
			}
			
			function deleteContent(qnaSeq){
				if(confirm("삭제 하시겠습니까?")){
					location.href = "/admin/customer/opinionBoard/opinionBoardDelete.do?mode=delete&qnaSeq="+qnaSeq;
				} else return false;
			}
			
			function validForm(editor) {
				var validator = new Trex.Validator();
				var content = editor.getContent();
				if(!validator.exists(content)) {
					alert("내용을 입력해 주세요.");
					return false;
				}
				var mode = $("#tx_editor_form").children("#mode").val();
				if(mode=='insert'){
					$("#tx_editor_form").attr('action','/admin/customer/opinionBoard/opinionBoardInsert.do').submit();
				} else if(mode=='update'){
					$("#tx_editor_form").attr('action','/admin/customer/opinionBoard/opinionBoardUpdate.do').submit();
				} else {
					alert("모드 값이 설정되지 않았습니다.");
					return false;
				}
				return true;
			}
			
			function setForm(editor) {
				document.getElementById("answer_HTML_content").disabled=true;
		        var i, input;
		        var form = editor.getForm();
		        var answerHTMLContent = editor.getContent();
		        var textarea = document.createElement('textarea');
		        textarea.name = 'answerHTMLContent';
		        textarea.value = answerHTMLContent;
		        
		        if(document.getElementsByName("answerHTMLContent").length == 0){
			        form.createField(textarea);
		        }
		        
		        $('[name="answerHTMLContent"]').attr('style', 'display:none');
		        var images = editor.getAttachments('image');
		        for (i = 0; i < images.length; i++) {
		            if (images[i].existStage) {
		                /* alert('attachment information - image[' + i + '] \r\n' + JSON.stringify(images[i].data)); */
		                input = document.createElement('input');
		                input.type = 'hidden';
		                input.name = 'attach_image_info';
		                input.value = JSON.stringify(images[i].data);
		                form.createField(input);
		            }
		        }
		        /* 
		        var files = editor.getAttachments('file');
		        for (i = 0; i < files.length; i++) {
		            input = document.createElement('input');
		            input.type = 'hidden';
		            input.name = 'attach_file';
		            input.value = files[i].data.attachurl;
		            form.createField(input);
		        }
		         */
		        return true;
			}
		</script>
		<!-- ================================================== End: Saving Contents ================================================== -->
		
		<!-- ================================================== Start: Loading Contents ================================================== -->
		<div style="display:none;">
			<textarea id="answer_TEXT_content"><c:out value="${opinionBoardView.answerHTMLContent}"/></textarea>
		</div>
		<script type="text/javascript">
			$(document).ready(function(){
				/* 에러 메시지  */
				var alertValue = "<c:out value='${resultError.errorMessage}'/>";
				if(alertValue!=""){ alert(alertValue); }
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
								/* ,'thumburl': '<c:out value="${daumEditorVO.thumbnailImgURL}"/>' */
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
					"content": document.getElementById("answer_TEXT_content").value
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
