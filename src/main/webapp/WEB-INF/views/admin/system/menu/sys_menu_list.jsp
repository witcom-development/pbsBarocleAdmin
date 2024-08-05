<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<script type="text/javascript" src="/js/as/EgovMenuList.js"></script>
<style type="text/css">
.leftBox img {width : 18px; height: 18px;}
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
                <tiles:insertAttribute name="left"  />
                <!--left menu E-->
                <!--conteent S-->
                <div class="content">
                    <div class="subject">
                        <!--subject path S-->
                        <tiles:insertAttribute name="subject" />
                        <!--subject path E-->
                    </div>
                    <div class="page">
                        <div class="didBox">
                            <div class="leftBox" id="menuTree" ><!--style="height:500px" 는 영역 표시를 위한 임시값입니다. 트리구조 삽입후 삭제하셔야 합니다.-->
                            <c:if test="${fn:length(menuListData)>0}">
                                <c:forEach var="result" items="${menuListData}" varStatus="status" >
                                    <input type="hidden" name="menuListData" value="${result.menuCd}|${result.upMenu}|${result.menuName}|${result.menuCd}|${result.menuOrd}|${result.menuName}|${result.upMenu}|${result.menuDesc}|${result.menuLevel}|${result.linkImg}|${result.menuImg}|${result.srcLink}|${result.hiddenYn}|${result.menuDetailCd}" />
                                </c:forEach>
                            </c:if>
                            <c:if test="${fn:length(menuListData)>1}">
                                <script type="text/javaScript">
                                   setImagePath("/images/menuIconImg/");
                                    var Tree = new Array;
                                    var tSize = $("[name='menuListData']").length;
                                    for (var j = 0; j <tSize; j++) {
                                        Tree[j] =  $("[name='menuListData']").eq(j).val();
                                    }
                                    createTree(Tree,false);
                                    
                                </script>
                            </c:if>
                            <c:if test="${fn:length(menuListData)==0}">
                                <script type="text/javaScript">
                                    var Tree = new Array;
                                    Tree[0] = "1|1|1|1|1|1|1|1|1|1|1|1";;
                                    createTree(Tree,false);
                                </script>
                            </c:if>
                            </div>
                            <div class="rightBox">
                                <form id="menuFrm" name="menuFrm" method="post">
		                            <input type="hidden" name="rootCheck" value="N" />
		                            <input type="hidden" name="menuOpenUrlYn" value="N" />
		                            <input type="hidden" name="hiddenYn" value=""/>
		                            
		                            <fieldset>
		                                <legend>관리자 메뉴</legend>
                                        <table class="tb_type02">
                                            <colgroup>
                                                <col style="width:30%">
                                                <col style="width:70%">
                                            </colgroup>
                                            <tbody>
                                                <tr>
                                                    <th class="top"><em>*</em>상위메뉴Code</th>
                                                    <td class="top">
                                                        <input type="hidden" name="menuLevel" value="" />
                                                        <span class="input-text08"><input type="text" class="input-text08" id="upMenu" name="upMenu"  maxlength="10" required="required" placeholder="상위메뉴code"  readonly="readonly"></span>
                                                        <a href="<c:url value='/upperMenuPop.do' />" type="button" class="winNewPop btnType02" title="상위 메뉴 선택" data-width="380" data-height="635" data-pmt="">검색</a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th><em>*</em>메뉴Code</th>
                                                    <td><span class="input-text03p"><input id="menuDetailCd" name="menuDetailCd" type="hidden"/><input type="text" class="input-text08" id="menuCd" name="menuCd" placeholder="메뉴code" required="required"  maxlength="10" value=""></span></td>
                                                </tr>
                                                <tr>
                                                    <th><em>*</em>메뉴명</th>
                                                    <td>
                                                        <span class="input-text07"><input type="text" id="menuName" name="menuName"  placeholder="메뉴명" required="required" maxlength="20" value=""></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th><em>*</em>메뉴순서</th>
                                                    <td><span class="input-text08"><input type="text" class="input-text08" id="menuOrd" name="menuOrd" placeholder="메뉴순서" required="required" maxlength="3" value=""></span></td>
                                                </tr>
                                                <tr>
                                                    <th>새 메뉴 Code</th>
                                                    <td><span class="input-text08"><input type="text" class="input-text08" id="downMenuCd" name="downMenuCd" placeholder="새 메뉴 code"  value=""></span></td>
                                                </tr>
                                                <tr>
                                                    <th>새 메뉴명</th>
                                                    <td>
                                                        <span class="input-text07"><input type="text" id="downMenuName" name="downMenuName" placeholder="새 메뉴명" value=""></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>링크이미지</th>
                                                    <td><span class="input-text07"><input type="text" id="linkImg" name="linkImg" placeholder="링크이미지"></span></td>
                                                </tr>
                                                <tr>
                                                    <th>메뉴이미지</th>
                                                    <td><span class="input-text07"><input type="text" id="menuImg" name="menuImg" placeholder="메뉴이미지"></span></td>
                                                </tr>
                                                <tr>
                                                    <th>링크</th>
                                                    <td><span class="input-text07"><input type="text" id="srcLink"  name="srcLink"  placeholder="링크" max="300"></span></td>
                                                </tr>
                                                <tr>
                                                    <th>메뉴설명</th>
                                                    <td>
                                                        <textarea class="detatextarea" id="menuDesc" name="menuDesc"></textarea>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>메뉴공개여부</th>
                                                    <td>
                                                        <span>
                                                            <span class="input-rd01"><input type="radio" id="a3" name="hiddenRadio" value="N" checked="checked"><label for="a3">공개</label></span>
                                                            <span class="input-rd01"><input type="radio" id="a4" name="hiddenRadio" value="Y"><label for="a4">비공개</label></span>
                                                        </span></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <div class="btnArea">
                                            <span class="left mb10">
                                                <button id="initBtn" class="btnType05 bc_gray" >초기화</button>
                                                <button id="addMenuBtn" class="btnType05 bc_green">메뉴등록</button>
                                            </span>
                                            <span class="left">
                                                <button id="setMenuBtn" class="btnType05">수정</button>
                                                <button id="delMenuBtn" class="btnType05">삭제</button>
                                                <button id="openMenuUrlBtn" class="btnType05">하위URL보기</button>
                                            </span>
                                        </div>
                                   </fieldset>
                               </form>
                               <form name="urlForm" id="urlForm"></form>
                               <div id="urlDiv" style="display: none;">
	                               <table id="urlTable" class="tb_type01 addSt mt50">
	                                   <colgroup>
	                                       <col style="width:50%">
	                                       <col style="width:15%">
	                                       <col style="width:10%">
	                                   </colgroup>
	                                   <thead>
	                                       <tr>
	                                           <th>url</th>
	                                           <th class="br">CRUD</th>
	                                           <th><button type="button" class="fullBtn" id="plusUrlBtn" ><img src="/images/btn_addAnswer.png" alt=""></button></th>
	                                       </tr>
	                                   </thead>
	                                   <tbody class="np">
	                                       <tr>
	                                           <td style="display: none" ><input name="crudFlg" type="hidden" value="C"></td>
	                                           <td style="display: none" ><input name="menuUrlSeq" type="hidden" value=""></td>
	                                           <td><span class="input-text10"><input type="text" name="menuUrl"/></span></td>
	                                           <td class="br">
	                                               <select class="select-category06" name="menuCrud">
	                                                   <option value="R" selected="selected">조회</option>
	                                                   <option value="C">등록</option>
	                                                   <option value="U">수정</option>
	                                                   <option value="D">삭제</option>
	                                               </select>
	                                           </td>
	                                           <td class="tc"><button type="button" class="fullBtn"><img src="/images/btn_delAnswer.png" alt=""></button></td>
	                                       </tr>
	                                   </tbody>
	                               </table>
	                               <div class="btnArea">
	                                   <span class="left"><button type="button" class="btnType05" id="modifyBtn">수정</button></span>
	                               </div>
                               </div>  
                            </div>
                         </div>
                     </div>
                </div>
                <!--conteent E-->
            </div>
        </div>
        <!--footer S-->
        <tiles:insertAttribute name="footer" />
        <!--footer E-->
    </div>
    <!-- <script type="text/javaScript" src="/js/EgovMenuList.js"></script> -->
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
	    $(function(){
	        //버튼 이벤트 초기화.
	        adminMenu.initBtn();
	    });
	    
	    var adminMenu = {};
        adminMenu.delUrl = [];
	    adminMenu.initBtn = function () {
	        $("#initBtn").on("click",this.topBtnGroupFnc);//초기화
	        $("#addMenuBtn").on("click",this.topBtnGroupFnc);//등록
	        $("#setMenuBtn").on("click",this.topBtnGroupFnc);//수정
	        $("#delMenuBtn").on("click",this.topBtnGroupFnc);//삭제
	        $("#openMenuUrlBtn").on("click",this.topBtnGroupFnc);//하위url보기
	        $("#plusUrlBtn").on("click",this.menuURLEditFnc );//하위url 플러스,마이너스 버튼 
	      //  $("#urlTable > tbody > tr").on("click",'img', this.menuURLEditFnc );//하위url 플러스,마이너스 버튼 
	        $("#modifyBtn").on("click",this.menuURLModify);//수정버튼
	    };
	    
	    adminMenu.topBtnGroupFnc = function(e) {
	    	e.preventDefault();
	        var targetName = e.target.id;
	        var _this = adminMenu;
	        switch(targetName) {
		        case "initBtn" :
		            $("form").each(function() {  
		                if(this.id == "menuFrm") {
		                    this.reset();  
		                }
		            });  
		            break;
		        case "addMenuBtn" :
		            if( _this.insertMenuValidator() ) {
		                /*등록버튼 */
		                commonAjax.postAjax("<c:url value='/menuInsertAjax.do'/>", 'json', $("#menuFrm").serialize()
		                     ,function(data) {
		                          if(data) {
		                              if(data.checkResult > 0){
		                                  alert(data.resultMessage);
		                                  $("[name='menuCd']").val('');
		                                  $("[name=menuFrm]").attr({method: "post",  action : "<c:url value='/getMenuList.do'/>"}).submit(); 
		                              }else{
		                                  alert(data.resultMessage);
		                              }
		                         }
		                     }
		                );
		            }
		            break;
		        case "setMenuBtn" :
		            /*수정버튼 */
		            if($("#downMenuCd").val() !== '') {
		            	return false;
		            }
		             if(_this.updateMenuValidator()) {
		            	 $("[name='hiddenYn']").val($("input[type='radio']:checked").val());
		                     commonAjax.postAjax("<c:url value='/menuUpdateAjax.do'/>",'json', $("#menuFrm").serialize()
		                         ,function(data) {
		                              if(data.checkResult > 0){
		                                  alert(data.resultMessage);
		                                  $("[name='menuCd']").val('');
		                                  $("[name=menuFrm]").attr({method: "post",  action : "<c:url value='/getMenuList.do'/>"}).submit(); 
		                              } else {
		                                  alert(data.resultMessage);
		                                  return false;
		                              }
		                         }
		                 );
		             }
		            break;
		        case "delMenuBtn" :
		            //삭제버튼
		            if($("[name='rootCheck']").val() !== "N"){
		            	alert("root는 삭제가 불가능합니다."); 
		            	return false;
		            }
		            if(_this.deleteMenuValidator()) {
		                commonAjax.postAjax("<c:url value='/menuUnderCountAjax.do'/>",'json', $("#menuFrm").serialize()
		                    ,function(data) {
		                	     var actionBool = false;
		                         if(data.menuUnderCount > 0){
		                             actionBool = confirm($("#menuName").val()+"메뉴의 하위 메뉴가 " + data.menuUnderCount+"건이 존재합니다.\n삭세시 하위메뉴도 같이 삭제됩니다. 삭제 하시겠습니까?"); 
		                         }else{
		                             actionBool = confirm($("#menuName").val()+"메뉴를 삭제 하시겠습니까?");
		                         } 
		                          
		                         if(actionBool) {
		                             commonAjax.postAjax("<c:out value='/menuDeleteAjax.do'/>", "json", $("#menuFrm").serialize()
		                                  ,function(data){
		                                       if(data.checkResult > 0){
		                                           alert(data.resultMsg);
		                                           $("[name='menuCd']").val('');
		                                           $("[name=menuFrm]").attr({method: "post", action : "<c:url value='/getMenuList.do'/>"}).submit(); 
		                                       } else {
		                                           alert(data.resultMsg);
		                                           return false;
		                                       }
		                                  }
		                             );
		                         }
		                    }
		                );
		            }
		            break;
		        case "openMenuUrlBtn" :
		        	//하위메뉴 URL 버튼
		            if($("#menuCd").val() === "") {
		                alert("검색할 메뉴 코드를 선택해 주세요.");
		                return false;
		            }
		            _this.resetUrl();
		            commonAjax.getAjax("<c:url value='/menuUrlAjax.do'/>",'json', {menuCd : $("#menuCd").val()}
		                , function(data) {
		                      if(data.resultData && data.resultData.length > 0) {
		                          var $result = null;
		                          var dSize = data.resultData.length;
		                          for(var i =0; i < dSize; i +=1) {
		                              $result =  data.resultData[i];
		                              _this.addRow($result);
		                          }
		                          $("#urlTable > tbody > tr").eq(0).remove();
		                      } 
		                    $("#urlDiv").css("display","block");
		                }
		            );
		            break;
		        default :
		            break;
	        }
	    };
	    adminMenu.addRow = function(data) {
	    	
	    	var vFlg = 'C',ulrSeq = '',mUrl = '',slt  =  'R';
	    	if( data !== null )	{
	    		vFlg = "U";ulrSeq =  data.menuUrlSeq;mUrl = data.menuUrl;slt = data.menuCrud;
	    	}   	
	    	var $cloneNode = $("#urlTable > tbody > tr").eq(0).clone();
            $cloneNode.children().eq(0).find("input:hidden").attr("name", "crudFlg").val(vFlg);
            $cloneNode.children().eq(1).find("input:hidden").attr("name", "menuUrlSeq").val(ulrSeq);
            $cloneNode.children().eq(2).find("input:text").attr("name", "menuUrl").val(mUrl);
            $cloneNode.children().eq(3).find("select").attr("name", "menuCrud").val(slt);
            $cloneNode.children().eq(4).find("button").on("click", adminMenu.menuURLEditFnc);
             
            $("#urlTable > tbody > tr").last().after($cloneNode);
            
	    };
	    adminMenu.menuURLEditFnc = function(e) {
	    	e.preventDefault();
	    	//e.stopPropagation();
            var idx = $(this).find('img').attr('src').indexOf("add");
	    	var _this = adminMenu;
	        if(idx > 0) {
	        	_this.addRow(null);
	        } else {
	        	var idx = $(this).parent().parent().get(0).rowIndex -1;
	            var trSize = $("#urlTable > tbody > tr").length;
	            var viewType =  $("#urlTable > tbody > tr").eq(idx).children().eq(0).find('input:hidden').val();
	            if(viewType === 'U') {
	            	_this.delUrl.push( $("#urlTable > tbody > tr").eq(idx).children().eq(1).find("input:hidden").val());
	            	$("#urlTable > tbody > tr").eq(idx).remove();
	            	
                } else {
                	if(trSize > 0) {
                	    $("#urlTable > tbody > tr").eq(idx).remove();
                    } else{
                    	_this.resetUrl();
                    }
                }
	        } 
	    };
	    
	    adminMenu.menuURLModify = function(e) {
	        e.preventDefault();
	        e.stopPropagation();
	    	var _this = adminMenu;
	    	$("#urlForm").empty();
	        //하위url form 데이터 만들기.   
	    	var $para1 = $("<input>", { type : "hidden", name:"menuCd" }).val($("#menuCd").val());
            var $para2 = $("<input>", { type : "hidden", name:"menuUrlNotIn" }).val(_this.delUrl.toString());
            $("#urlForm").append([ $para1,  $para2]);
            var inputList = [];
            var chk = 0;
	        $("#urlTable > tbody > tr").each(function(idx){
                 if( $("[name=menuUrl]").eq(idx).val() === "") {
                	 chk +=1;
                     alert("메뉴 URL의 주소를 입력해 주세요.");
                     $("[name=menuUrl]").eq(idx).focus();
                     return false;
                 }
	        	 inputList.push($("<input>", { type : "hidden", name:"urlList["+idx+"].crudFlg" }).val($("[name=crudFlg]").eq(idx).val()));
                 inputList.push($("<input>", { type : "hidden", name:"urlList["+idx+"].menuUrl" }).val($("[name=menuUrl]").eq(idx).val()));
                 inputList.push($("<input>", { type : "hidden", name:"urlList["+idx+"].menuCrud" }).val($("[name=menuCrud]").eq(idx).val()));
                 inputList.push($("<input>", { type : "hidden", name:"urlList["+idx+"].menuUrlSeq" }).val($("[name=menuUrlSeq]").eq(idx).val()));
	        });
	        $("#urlForm").append(inputList);
	        if(chk === 0) {
		        commonAjax.postAjax("<c:url value='/menuUrlUpdateAjax.do'/>", 'json',$("#urlForm").serialize()
		            ,function(data) {
			             if(data.checkResult > 0){
			                 alert(data.resultMessage);
			                 _this.delUrl = [];
			                 $("#openMenuUrlBtn").trigger("click");
			                 //$("[name=menuFrm]").attr({ action : "<c:url value='/getMenuList.do'/>"}).submit(); 
			                // _this.resetUrl();
			             }else{
			                alert(data.resultMessage);
			                return false;
			             } 
		            }
		        );
	        } 
	    }; 
	    adminMenu.updateMenuValidator = function() {
	        if($("#upMenu").val() === ""){
	        	alert("상위메뉴코드는 필수 입력 항목입니다."); 
	        	return false;
	        }
	        if(!isAlNumber($("#upMenu").val())){
	        	alert("상위메뉴코드는 영문과 숫자만 입력 가능합니다."); 
	        	$("#upMenu").val('').focus();
	        	return false;
	        }
	        if($("#menuCd").val() === ""){
	        	alert("메뉴코드는 필수 입력 항목입니다."); 
	        	return false;
	        }
	        if(!isNumeric($("#menuCd").val() )){
	        	alert("메뉴코드는 숫자만 입력 가능합니다."); 
	        	$("#menuCd").val('').focus();
	        	return false;
	        }
	        if($("#menuName").val() == ""){
	        	alert("메뉴명은 필수 입력 항목입니다."); 
	        	return false;
	        }
	        if(!isAlHanNumber($("#menuName").val())){
	        	alert("메뉴명은 영문과 한글, 숫자만 가능합니다."); 
	        	$("#menuName").val('').focus();
	        	return false;
	        }
	        if($("#menuOrd").val()  == "" ){
	        	alert("메뉴순서는 필수 입력 항목입니다."); 
	        	return false;
	        }
	        if(!isNumeric($("#menuOrd").val())){
	        	alert("메뉴순서는 숫자만 입력 가능합니다."); 
	        	$("#menuOrd").val('').focus();
	        	return false;
	        }
	        return true;
	    };
	    adminMenu.insertMenuValidator = function() {
	        
	        if($("#menuCd").val() == ""){
	        	alert("메뉴코드는 필수 입력 항목입니다."); 
	        	return false;
	        }
	        if(!isNumeric($("#menuCd").val())){
	        	alert("메뉴코드는 숫자만 입력 가능합니다."); 
	        	$("#menuCd").val('').focus();
	        	return false;
	        }
	        if($("#menuName").val() == ""){
	        	alert("메뉴명은 필수 입력 항목입니다."); 
	        	return false;
	        }
	        if(!isAlHanNumber($("#menuName").val())){
	        	alert("메뉴명은 영문과 한글, 숫자만 가능합니다."); 
	        	$("#menuName").val('').focus();
	        	return false;
	        }
	        if($("#menuOrd").val() == ""){
	        	alert("메뉴순서는 필수 입력 항목입니다."); 
	        	return false;
	        }
	        if(!isNumeric($("#menuOrd").val())){
	        	alert("메뉴순서는 숫자만 입력 가능합니다.");
	        	$("#menuOrd").val('').focus();
	        	return false;
	        }
	        if( $("#downMenuCd").val() == ""){
	        	 alert("새 메뉴코드는 필수 입력 항목입니다."); 
	        	 return false;
	        }
	        if(!isNumeric($("#downMenuCd").val() )){
	        	alert("새 메뉴코드는 숫자만 입력 가능합니다."); 
	        	$("#downMenuCd").val('').focus();
	        	return false;
	        }
	        if($("#downMenuName").val()  == ""){
	        	alert("새 메뉴 명은 필수 입력 항목입니다."); 
	        	return false;
	        }
	        return true;
	    };
	    
	    adminMenu.deleteMenuValidator = function() {
	        if($("#menuCd").val() == ""){
	        	alert("메뉴코드는 필수 입력 항목입니다."); 
	        	return false;
	        }
	        if(!isNumeric($("#menuCd").val())){
	        	alert("메뉴코드는 숫자만 입력 가능합니다."); 
	        	$("#menuCd").val('').focus();
	        	return false;
	        }
	        return true;
	    };
	    adminMenu.upperchoice = function (pUpMenu,pMenuLevel,pMenuDetailCd) {
	        $("#upMenu").val(pUpMenu);
	        $("[name='menuLevel']").val(pMenuLevel);
	        $("#menuDetailCd").val(pMenuDetailCd+"/"+$("#menuCd").val());
	    };
	    adminMenu.resetUrl = function() {
	    	$("#urlTable > tbody > tr").not(":eq(0)").remove();
	    	$("#urlTable > tbody > tr").children().eq(0).find("input:hidden").val('C');
	    	$("#urlTable > tbody > tr").children().eq(1).find("input:hidden").val('');
	    	$("#urlTable > tbody > tr").children().eq(2).find("input:text").val('');
	    	$("#urlTable > tbody > tr").children().eq(3).find("select").val('R');
	    };
	    /**
	        트리 js용 함수  
	    */
        function choiceNodes(nodeNum) {
	        //하위 URL 비활성화
	        $("#urlDiv").css('display', 'none');
	        adminMenu.resetUrl();
	        //리셋 : url 테이블 선택후, url 테이블 삭제
	        $("[name='menuOpenUrlYn']").val('N');
	        //adminMenu.menuUrlVORemove();
	        var nodeValues = treeNodes[nodeNum].split("|");
	        $("#menuCd").val(nodeValues[3]).attr('readonly', true);
	        $("#menuOrd").val(nodeValues[4]);
	        $("#menuName").val(nodeValues[5]);
	        $("#upMenu").val(nodeValues[6]);
	        $("#menuDesc").text(nodeValues[7]);
	        $("[name='menuLevel']").val(nodeValues[8]);
	        $("#linkImg").val(nodeValues[9]);
	        $("#menuImg").val(nodeValues[10]);
	        $("#srcLink").val(nodeValues[11]);
	        if(nodeValues[12] === "N"){
	            $("#a3").get(0).checked = true;
	        }else{
	            $("#a4").get(0).checked = true;
	        }  
	        $("#menuDetailCd").val(nodeValues[13]);
	        $("#downMenuCd").val('');
	        $("#downMenuName").val('');
	        $("[name='rootCheck']").val("N");
	    }
	    function rootClick() {
	        //하위 URL 비활성화
	        $("#urlDiv").css('display', 'none');
	        //리셋 : url 테이블 선택후, url 테이블 삭제
	        adminMenu.resetUrl();
	        $("[name='menuOpenUrlYn']").val('N');
	        $("[name='rootCheck']").val("Y");
	        //form 리셋????
	        $("form").each(function() {  
	            if(this.id == "menuFrm") {
	                this.reset();  
	            }
	        });  
	        $("#menuDesc").text('');        
        }
    </script>
</body>
</html>