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
                        <form id="frm">
                            <input type="hidden"  name="dupCheck" value="N" />
                            <input type="hidden"  name="useYn"  value="Y" />
                            <input type="hidden"  name="searchStartDate" value="${safetyCertUser.getSearchStartDate()}" />
                            <input type="hidden"  name="searchEndDate"   value="${safetyCertUser.getSearchEndDate()}" />
                            <input type="hidden"  name="mbYn"      value="${safetyCertUser.getMbYn()}" />
                            <input type="hidden"  name="searchValue"     value="${safetyCertUser.getSearchValue()}" />
                            <input type="hidden"  name="searchParameter" value="${safetyCertUser.getSearchParameter()}" />
                            <input type="hidden"  name="certUsrSeq" id="certUsrSeq" value="${safetyCertUserInfo.certUsrSeq }">
                            <input type="hidden"  name="usrMpnNo" id="usrMpnNo" value="${safetyCertUserInfo.usrMpnNo }">
                            <fieldset>
                                <table  class="tb_type02 mt20">
                                    <colgroup>
                                        <col style="width:20%" />
										<col style="width:30%" />
										<col style="width:20%" />
										<col style="width:30%" />
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th>일련번호</th>
                                            <td>
                                                ${ safetyCertUserInfo.certUsrSeq}
                                            </td>
                                            <th>응시번호</th>
                                            <td>
                                                ${ safetyCertUserInfo.certNum}
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>이름</th>
                                            <td>
                                                ${ safetyCertUserInfo.usrName}
                                            </td>
                                            <th>연락처</th>
                                            <td>
                                                ${ safetyCertUserInfo.usrMpnNo}
                                            </td>
                                        </tr>
                                        <tr>
                                        	<th>자치구</th>
                                            <td>
                                               ${ safetyCertUserInfo.usrPrvCd}
                                            </td>
                                            <th>응시일</th>
                                            <td>
                                                <fmt:parseDate var="dateStringC" value="${safetyCertUserInfo.certDate }" pattern="yyyy-MM-ddHH:mm:ss" />
												<fmt:formatDate value="${dateStringC}" pattern="yyyy-MM-dd" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>인증제유형코드</th>
                                            <td>
                                                ${ safetyCertUserInfo.certCls}
                                            </td>
                                            <th>안전교육이수기관</th>
                                            <td>
                                                ${ safetyCertUserInfo.certOrg}
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>안전교육일자</th>
                                            <td>
                                                <fmt:parseDate var="dateStringE" value="${safetyCertUserInfo.certEdDate }" pattern="yyyy-MM-ddHH:mm:ss" />
												<fmt:formatDate value="${dateStringE}" pattern="yyyy-MM-dd" />
                                            </td>
                                            <th>회원아이디</th>
                                            <td>
                                                <span class="input-text03p"><input type="text" class="input-text03p" name="mbId" id="mbId" value="${ safetyCertUserInfo.mbId}" /></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>할인적용시작일</th>
                                            <td>
                                                <fmt:parseDate var="dateString2" value="${safetyCertUserInfo.disSDttm }" pattern="yyyy-MM-ddHH:mm:ss" />
												<fmt:formatDate value="${dateString2}" pattern="yyyy-MM-dd" />
                                            </td>
                                            <th>할인적용종료일</th>
                                            <td>
                                                <fmt:parseDate var="dateString3" value="${safetyCertUserInfo.disEDttm }" pattern="yyyy-MM-ddHH:mm:ss" />
												<fmt:formatDate value="${dateString3}" pattern="yyyy-MM-dd" />
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="btnArea">
                                    <span class="left"><button class="btnType01 bc_gray" id="moveListPage">목록</button></span>
                                    <span class="right"><button class="btnType01 bc_green" id="certUsrSaveExe" >저장</button></span>
                                    <span class="right"><button class="btnType01" style="background: #8B4513;" id="certUsrDeleteExe">삭제</button></span>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
                <!--conteent E-->
            </div>
        </div>
        <!--footer S-->
        <tiles:insertAttribute name="footer" />
        <!--footer E-->
    </div>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function() {
        certUsrDetail.initBtn();
        //certUsrDetail.initCombo();
    });
    
    var certUsrDetail = {};
    certUsrDetail.initBtn = function() {
        $("#certUsrSaveExe").on("click  ", this.exeCertUsrSave);
        $("#certUsrDeleteExe").on("click  ", this.exeCertUsrDelete);
        $("#moveListPage").on("click", this.clickMoveListPage);
    };
    
    certUsrDetail.exeCertUsrSave = function(e) {
    	e.preventDefault();
    	e.stopPropagation();
    	var _this = certUsrDetail;
    	if(_this.inputValidChk()) {
    		commonAjax.postAjax("/admin/service/safetycert/setSafetyCertUserAjax.do", "json", $("#frm").serialize()
    			,function(data){
    		         if(data){
    		             if(data.checkResult > 0 ){
    		                  alert(data.resultMessage);
    		             } else {
    		                 alert(data.resultMessage+" 저장에 실패했습니다.");
	            		     return false;
    		             }
    		         }
    		    }
    		);
    	}
    	
    };
    certUsrDetail.exeCertUsrDelete = function(e) {
    	e.preventDefault();
    	e.stopPropagation();
    	var _this = certUsrDetail;
    	if(confirm('정말로 삭제하시겠습니까?')) {
    		commonAjax.postAjax("/admin/service/safetycert/delSafetyCertUserAjax.do", "json", $("#frm").serialize()
    			,function(data){
    		         if(data){
    		             if(data.checkResult > 0 ){
    		             	alert(data.resultMessage);
    		                var _this = certUsrDetail;
    		                _this.moveListPage();
    		             } else {
    		                 alert(data.resultMessage);
	            		     return false;
    		             }
    		         }
    		    }
    		);
    	}
    	
    };
    certUsrDetail.inputValidChk = function(){
    	if($("#mbId").val() === '') {
    		alert("회원 ID를 입력해 주세요.");
    		return false;
    	}
    	return true;
    };
    /* certUsrDetail.certMbIdCheck = function(e) {
        //e.preventDefault();
        commonAjax.postAjax("/admin/service/safetycert/certMbIdCheckAjax.do", "json", {usrMpnNo : $("[name='usrMpnNo']").val(), mbId : $("[name='mbId']").val() }
        , function(data){
            if(data) {
                var isWrongID = (data.isWrongID === "true");
                if(isWrongID) {
                    alert("회원 연락처와 아이디가 맞지 않습니다.");
                    return false;
                }
                var isMember = (data.isMember === "true");
                if(!isMember) {
                    alert("회원이 아닙니다.");
                    return false;
                }
                return true;
            }
        });
    }; */
    certUsrDetail.clickMoveListPage = function(e) {
    	e.preventDefault();
    	e.stopPropagation();
    	var _this = certUsrDetail;
    	_this.moveListPage();
    };
    certUsrDetail.moveListPage = function() {
         $("#frm").attr({action : "/admin/service/safetycert/safetyCertUserList.do", method : "post"}).submit();
    };
    </script>
</body>
</html>