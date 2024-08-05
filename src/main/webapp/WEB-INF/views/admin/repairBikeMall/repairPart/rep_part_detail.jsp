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
                        <form id="frm" name="frm" >
                        	<input type="hidden" name="repairOursrcPriceSeq" value="${partVo.repairOursrcPriceSeq }" />
                        	<input type="hidden" name="viewFlg" value="${partVo.viewFlg }" /> 
                            <fieldset>
                                <table  class="tb_type02 mt20">
                                    <caption>수리단가</caption>
                                    <colgroup>
                                        <col style="width:25%"/>
                                        <col style="width:75%"/>
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th class="top"><em>*</em>부품명</th>
                                            <td class="top">
                                                <select class="select-category02" id="comCd" name="comCd" <c:if test="${partVo.viewFlg eq 'U' }">disabled="disabled"</c:if>>
                                                    <option value="">선택</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><em>*</em>수리단가</th>
                                            <td>
                                                <span class="input-text12">
                                                	<input type="text" id="price" name="price" class="input-text12" value="${partView.price }"/> 원
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><em>*</em>적용년도</th>
                                            <td>
                                            	<span class="input-text12">
                                            		<input type="text" id="priceYmd" name="priceYmd" class="input-text12" value="${partView.priceYmd }"/> 년
                                            	</span>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="btnArea">
                                    <span class="left"><button type="button" class="btnType01 bc_gray" id="moveListBtn">목록</button></span>
                                    <span class="right"><button type="button" class="btnType01 bc_green" id="dataEditBtn">저장</button></span>
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
    $(function(){
        priceForm.initBtn();
        priceForm.initCommonCode();
    });
    var priceForm = {};
    priceForm.viewType = '${partVo.getViewFlg()}';
    priceForm.initBtn = function() {
        $("#moveListBtn").on("click", this.exeList );
        $("#dataEditBtn").on("click", this.editDataExcFnc);        
    };
    priceForm.exeList = function(e) {
        e.preventDefault();
        priceForm.moveList();       
    };
    //목록페이지 이동.
    priceForm.moveList = function() {
    	$("#comCd").val('');
        $("#frm").attr({action : '<c:out value="/repairPartPriceList.do"/>', method : 'post'}).submit();
    };
    priceForm.initCommonCode = function() {
        var _this = priceForm;
        // 부품명
        commonAjax.getCommonCode("REC", function(data) {
            if(data !== null && data.codeList !== null) {
                commCdBox.makeComboBox('CC', '${partView.comCd}', data.codeList, "comCd");
            }
        });
    };
    
    priceForm.editDataExcFnc = function(e) {
        var _this = priceForm;
        e.preventDefault();
        e.stopPropagation();
        
        if($("#comCd").val() === '') {
            alert("부품명을 선택해 주세요.");
            return false;
        }
        if($("#price").val() === '') {
            alert("수리단가를 입력해주세요.");
            $("#price").focus();
            return false;
        }
        if($("#priceYmd").val() === '') {
            alert("적용년도를 입력해주세요.");
            $("#priceYmd").focus();
            return false;
        }
        
		commonAjax.postAjax("<c:out value='/exePartPriceAjax.do'/>", 'json', $("#frm").serialize()
			,function(data){
				if(data.resultMessage == "Success"){
					if(priceForm.viewType === 'C'){
						alert("수리단가 등록에 성공하였습니다.");
						_this.moveList();
					}else{
						alert("수리단가 수정에 성공하였습니다.");
					}
					return false;
				}
		});
       
    };
    //priceForm.data
    </script>
</body>
</html>