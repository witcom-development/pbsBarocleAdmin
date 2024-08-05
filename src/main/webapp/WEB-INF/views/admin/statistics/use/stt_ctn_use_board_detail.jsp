<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%
	Calendar cal = Calendar.getInstance();
	cal.add(Calendar.MONTH, -1);
	int minYear = 2010;
	int nowYear = cal.get(Calendar.YEAR);
	SimpleDateFormat sdf = new SimpleDateFormat("MM");
	String nowMonth = sdf.format(cal.getTime());
%>
<!DOCTYPE html>
<html>
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
	<%-- 현재 메뉴의 값을 절대적으로 표시하야 함. --%> 
	var currentPageName = "static";
</script>
<!-- daumeditor -->

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
						<p class="pageTitle">월간운영현황</p>
						<span>통계 &gt; <em>월간운영현황 상세</em></span>
					</div>

					<div class="page">
						<form id="tx_editor_form" name="tx_editor_form" method="post" accept-charset="utf-8" onsubmit="return false;">
							<input type="hidden" id="mode" name="mode" value="${useStatisticsBoardView.mode}" />
							<input type="hidden" id="staticSeq" name="staticSeq" value="${useStatisticsBoardView.staticSeq}" />
							<input type="hidden" id="seqNo" name="seqNo" value="${seqNo}" />
							<input type="hidden" id="attachNo" name="attachNo" value="" />


							<fieldset>
								<legend>월간운영현황 작성</legend>   
								<table class="tb_type02 mt20">
									<caption>월간운영현황 작성</caption>
										<colgroup>
											<col style="width:25%" />
											<col style="width:75%" />
										</colgroup>
									<tbody>
										<tr>
											<th class="top">제목 </th>
											<td class="top">
												<input id="staticTitle" name="staticTitle" type="text" class="input-text02p" value="${useStatisticsBoardView.staticTitle}" style="width:500px" maxlength="500" /><span class="input-ck01">
											</td>
										</tr>

										<tr>
											<th><span>내용</span></th>
											<td class="editor">
												<!--daum editor S-->
												<tiles:insertAttribute name="static_daum_editor"/>
												<div style="display:none;"><textarea id="static_HTML_content" name="content"></textarea></div>
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
									<span class="left"><button class="btnType01 bc_gray" onclick="location.href='/use/useStatisticsBoard.do?currentPageNo=<c:out value="${useStatisticsBoardView.currentPageNo}"/><c:out value="${parameterInfo}" escapeXml="false"/>';">목록</button></span>
									<span class="right">
										

										<c:choose>
											<c:when test="${useStatisticsBoardView.adminGrpSeq eq usrGrpSeq}">
												<c:if test="${useStatisticsBoardView.staticSeq > 0}">
													<button class="btnType01" onclick="deleteContent('<c:out value="${useStatisticsBoardView.staticSeq}"/>');">삭제</button>
												</c:if>
												<button class="btnType01 bc_green" onclick='return saveContent();'>저장</button>
											</c:when>
											<c:when test="${useStatisticsBoardView.adminGrpSeq ne usrGrpSeq}">
												<!-- 최고관리자가 등록한 건이 아닐 경우 -->
												<c:if test="${useStatisticsBoardView.adminGrpSeq ne usrGrpSeq}">
													<c:if test="${useStatisticsBoardView.adminGrpSeq ne 12}">
														<c:if test="${useStatisticsBoardView.staticSeq > 0}">
															<button class="btnType01" onclick="deleteContent('<c:out value="${useStatisticsBoardView.staticSeq}"/>');">삭제</button>
														</c:if>
														<button class="btnType01 bc_green" onclick='return saveContent();'>저장</button>
													</c:if>
									 			</c:if>
											</c:when>
										 
										</c:choose>

									 	
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
		
			$(function() {
				$(".fileDownload").click(function(){
					if(confirm("다운로드 하시겠습니까?")){
						var imgURL= $(this).attr('value');
						location.href = "/use/downloadFileStatic.do?imgSeq="+imgURL+"&currentPageName="+currentPageName;
					}else return false;
				});
			});
			function saveContent() { 

				if(confirm("저장 하시겠습니까?")){
					Editor.save(); 
				}
			}

			function deleteContent(staticSeq){
				if(confirm("삭제 하시겠습니까?")){
					location.href = "/use/useStatisticsBoardDelete.do?mode=delete&staticSeq="+staticSeq;
				} else return false;
			}
			
			function validForm(editor) {
				/* 제목 */
				if($.trim($("#staticTitle").val())==''){
					$("#staticTitle").focus();
					alert("제목을 입력해 주세요.");
					return false;
				}
				/* 본문 내용이 입력되었는지 검사하는 부분 */
				var validator = new Trex.Validator();
				var content = editor.getContent();
				if(!validator.exists(content)) {
					alert("내용을 입력해 주세요.");
					return false
				}
				var mode = $("#tx_editor_form").children("#mode").val();
				if(mode=='insert'){
					$("#tx_editor_form").attr('action','/use/useStatisticsBoardInsert.do').submit();
				} else if(mode=='update'){
					$("#tx_editor_form").attr('action','/use/useStatisticsBoardUpdate.do').submit();
				} else {
					alert("모드 값이 설정되지 않았습니다.");
					return false;
				}
				return true;
			}
			
			function setForm(editor) {

				document.getElementById("static_HTML_content").disabled=true;
		        var i,f, input;
		        var form = editor.getForm();
		        var staticHTMLContent = editor.getContent();
		        var textarea = document.createElement('textarea');
		        textarea.name = 'staticHTMLContent';
		        textarea.value = staticHTMLContent;
		        
		        if(document.getElementsByName("staticHTMLContent").length == 0){
			        form.createField(textarea);
		        }
		        
		        $('[name="staticHTMLContent"]').attr('style', 'display:none');
		        
				//이미지, 파일 업로드 _cms_20161108
		        var edtList = Editor.getAttachBox().datalist;
		        var filelist = Editor.getAttachments('file', true);
		        
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

			});
			function checkPopup(){

			}
		</script>
		<!-- ================================================== End: Saving Contents ================================================== -->


		<!-- ================================================== Start: Loading Contents ================================================== -->
		<textarea id="static_TEXT_content" style="display:none;"><c:out value="${useStatisticsBoardView.staticHTMLContent}"/></textarea>
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
					"content": document.getElementById("static_TEXT_content").value
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