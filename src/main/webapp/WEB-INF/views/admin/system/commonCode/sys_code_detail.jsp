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
                <form id="frm">
	                <input type="hidden" name="searchBgnDe" value="${ pVo.getSearchBgnDe()}">
	                <input type="hidden" name="searchEndDe" value="${ pVo.getSearchEndDe()}">
                </form>
                <div class="content">
                    <div class="subject">
                        <!--subject path S-->
                        <tiles:insertAttribute name="subject" />
                        <!--subject path E-->
                    </div>
                    <div class="page">
                        <form id="codefrm">
                            <input type="hidden" name="viewFlg" value="${ pVo.getViewFlg()}">
                            <input type="hidden" id="dupCheck" value="N">
                            <input type="hidden" name="useYn" value="Y">
                            <input type="hidden" name="dspOrd" value="1">
                            <fieldset>
                                <p class="head mt20">상위코드</p>
                                <table  class="tb_type02 mt20">
                                    <colgroup>
                                        <col style="width:25%"/>
                                        <col style="width:75%"/>
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th class="top"><em>*</em>상위 공통 코드</th>
                                            <td class="top">
                                                <span class="input-text07">
                                                    <input type="text" id="comCd" name="comCd" max="3" value="${codeVO.comCd}"/>
                                                    <button class="btnType02" id="dupCodeCheck" >중복확인</button>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><em>*</em> 상위 공통 코드명(한국어)</th>
                                            <td>
                                                <span class="input-text07">
                                                    <input type="hidden" name="langList[0].lang" value="LAG_001"/>
                                                    <input type="text"  id="comCdNameKo"  name="langList[0].comCdName" placeholder="한국어" value="${codeVO.comCdNameKo}"/>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>상위 공통 코드명(영어)</th>
                                            <td>
                                                <span class="input-text07">
                                                    <input type="hidden" name="langList[1].lang" value="LAG_002"/>
                                                    <input type="text" id="comCdNameEn" name="langList[1].comCdName" placeholder="영어" value="${codeVO.comCdNameEn}"/>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>상위 공통 코드명(일본어)</th>
                                            <td>
                                                <span class="input-text07">
                                                    <input type="hidden" name="langList[2].lang" value="LAG_003"/>
                                                    <input type="text"  id="comCdNameJa"  name="langList[2].comCdName" placeholder="일본어" value="${codeVO.comCdNameJa}"/>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>상위 공통 코드명(중국어)</th>
                                            <td>
                                                <span class="input-text07">
                                                    <input type="hidden" name="langList[3].lang" value="LAG_004"/>
                                                    <input type="text" id="comCdNameZh"   name="langList[3].comCdName" placeholder="중국어" value="${codeVO.comCdNameZh}"/>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>코드설명1</th>
                                            <td>
                                                <span class="input-text07"><input type="text" name="cdDesc1" placeholder="코드설명1"  maxlength="45"   value="${codeVO.cdDesc1}"/></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>코드설명2</th>
                                            <td>
                                                <span class="input-text07"><input type="text"  name="cdDesc2" placeholder="코드설명2"  maxlength="45" value="${codeVO.cdDesc2}"/></span>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div id="childDiv">
                                    <p class="head ttbtncase1">하위 코드<span><button type="button" class="btnType05" id="addCode">추가</button></span></p>
	                                <div class="questionBoxWrap">
	                                    <c:forEach var="result"  items="${childCodeList}" varStatus="loop">
	                                        <div class="questionBox">
		                                        <div class="addStwrap">
		                                            <table class="tb_type02">
		                                                <colgroup>
		                                                    <col style="width:25%"/>
		                                                    <col style="width:75%"/>
		                                                </colgroup>
		                                                <tbody>
		                                                    <tr>
                                                                <th class="top">코드</th>
                                                                <td class="top">
                                                                    <span class="input-text07"><input type="text" name="codeList[${loop.index}].comCd" readonly="readonly" value="<c:out value='${result.comCd }'/>" /></span>
                                                                </td>
                                                            </tr>
			                                                <tr>
			                                                    <th>순서</th>
			                                                    <td style="display: none" >
								                                    <input type="hidden" name="codeList[${loop.index}].crudFlg" value="${viewFlg}"/>
								                                </td>
			                                                    <td>
			                                                        <span class="input-text07"><input type="text" name="codeList[${loop.index}].dspOrd"  value="<c:out value='${result.dspOrd }'/>" /></span>
			                                                    </td>
			                                                </tr>
			                                                <tr>
			                                                    <th>공통코드명<br/>(<em>*</em>한글/영문/일어/중국어)</th>
			                                                    <td>
			                                                        <span>
			                                                             <span class="pholder input-text08">
				                                                             <input type="hidden" name="codeList[${loop.index}].langList[0].lang" value="LAG_001"/>
				                                                             <input type="text"  id="holder1" name="codeList[${loop.index}].langList[0].comCdName" placeholder="한글" value="<c:out value='${result.comCdNameKo }'/>"  maxlength="50"/>
			                                                             </span>
			                                                             <span class="pholder input-text08">
				                                                             <input type="hidden" name="codeList[${loop.index}].langList[1].lang" value="LAG_002"/>
				                                                             <input type="text"  id="holder2" name="codeList[${loop.index}].langList[1].comCdName" placeholder="영문" value="<c:out value='${result.comCdNameEn }'/>"  maxlength="50"/>
			                                                             </span>
			                                                        </span>
			                                                        <span class="pwtableblock">
			                                                            <span class="pholder input-text08">
				                                                            <input type="hidden" name="codeList[${loop.index}].langList[2].lang" value="LAG_003"/>
				                                                            <input type="text" id="holder3" name="codeList[${loop.index}].langList[2].comCdName"  placeholder="일어"  value="<c:out value='${result.comCdNameJa }'/>" maxlength="50" />
			                                                            </span>
			                                                            <span class="pholder input-text08">
				                                                            <input type="hidden" name="codeList[${loop.index}].langList[3].lang" value="LAG_004"/>
				                                                            <input type="text" id="holder4" name="codeList[${loop.index}].langList[3].comCdName" placeholder="중국어"  value="<c:out value='${result.comCdNameZh }'/>" maxlength="50"/>
			                                                            </span>
			                                                        </span>
			                                                    </td>
			                                                </tr>
			                                                <tr>
			                                                    <th>코드설명</th>
			                                                    <td>
			                                                        <span class="input-text07">
			                                                            <input type="text"  name="codeList[${loop.index}].cdDesc1" placeholder="코드설명1" value="<c:out value='${result.cdDesc1 }'/>"/>
			                                                        </span>
			                                                    </td>
			                                                </tr>
			                                                <tr>
			                                                    <th>추가값 1,2,3</th>
			                                                    <td>
			                                                        <span class="pwtableblock">
				                                                        <span class="input-text08"><input type="text" name="codeList[${loop.index}].addVal1" placeholder="추가값1" value="<c:out value='${result.addVal1 }'/>" /></span>
				                                                        <span class="input-text08"><input type="text" name="codeList[${loop.index}].addVal2" placeholder="추가값2" value="<c:out value='${result.addVal2 }'/>" /></span>
			                                                        </span>
			                                                        <span class="pwtableblock">
			                                                            <span class="input-text08"><input type="text" name="codeList[${loop.index}].addVal3" placeholder="추가값3" value="<c:out value='${result.addVal3 }'/>"  /></span>
			                                                        </span>
			                                                    </td>
			                                                </tr>
			                                                <tr>
			                                                    <th>표시여부</th>
			                                                    <td>
			                                                        <span class="input-rd01"><input type="radio" id="a3"  name="codeList[${loop.index}].useYn"  value="Y"  <c:if test="${result.useYn eq 'Y'}">checked="checked"</c:if>><label for="a3">사용</label></span>
			                                                        <span class="input-rd01"><input type="radio" id="a33" name="codeList[${loop.index}].useYn" value="N"   <c:if test="${result.useYn eq 'N'}">checked="checked"</c:if>><label for="a33">미사용</label></span>
			                                                    </td>
		                                                   </tr>
		                                               </tbody>
		                                           </table>
		                                       </div>
	                                       </div>
	                                   </c:forEach>
	                                </div>
                                </div>
                                <div class="btnArea">
                                    <span class="left"><button class="btnType01 bc_gray" id="moveListBtn">목록</button></span>
                                    <span class="right"><button class="btnType01 bc_green" id="dataEditBtn">저장</button></span>
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
    <!--하위코드 추가용 clone  -->
    <section id="cloneDiv" style="display: none;" >
        <div class="questionBox" >
	        <div class="btn_delQ"><button class="btnType04" ><img src="/images/btn_delQ.png" alt="" /></button></div>
	        <div class="addStwrap">
		        <table>
	                <colgroup>
	                    <col style="width:25%"/>
	                    <col style="width:75%"/>
	                </colgroup>
	                <tr style="display: none;"></tr>
		            <tr>
		                 <th class="top">순서</th>
		                 <td style="display: none"><input type="hidden" name="codeList[0].crudFlg" value="C"/></td>       
		                 <td style="display: none"><input type="hidden" name="codeList[0].comCd" value=""/></td>
		                 <td class="top"><span class="input-text07"><input type="text" name="codeList[0].dspOrd"  value="" /></span></td>
		             </tr>
		             <tr>
		                 <th>공통코드명<br/>(<em>*</em>한글/영문/일어/중국어)</th>
		                 <td>
		                     <span>
		                         <span class="pholder input-text08">
		                             <input type="hidden" name="codeList[0].langList[0].lang" value="LAG_001"/>
		                             <input type="text"  id="holder1" name="codeList[0].langList[0].comCdName"   placeholder="한글" value=""   maxlength="50"/>
		                         </span>
		                         <span class="pholder input-text08">
		                             <input type="hidden" name="codeList[0].langList[1].lang" value="LAG_002"/>
		                             <input type="text"  id="holder2" name="codeList[0].langList[1].comCdName"   placeholder="영문" value=""  maxlength="50"/>
		                         </span>
		                     </span>
		                     <span class="pwtableblock">
		                         <span class="pholder input-text08">
		                             <input type="hidden" name="codeList[0].langList[2].lang" value="LAG_003"/>
		                             <input type="text" id="holder3" name="codeList[0].langList[2].comCdName"   placeholder="일어" value="" maxlength="50" />
		                         </span>
		                         <span class="pholder input-text08">
		                             <input type="hidden" name="codeList[0].langList[3].lang" value="LAG_004"/>
		                             <input type="text" id="holder4" name="codeList[0].langList[3].comCdName"   placeholder="중국어" value=""  maxlength="50"/>
		                         </span>
		                     </span>
		                 </td>
		             </tr>
		             <tr>
		                 <th>코드설명</th>
		                 <td>
		                     <span class="input-text07">
		                         <input type="text" name="codeList[0].cdDesc1" placeholder="코드설명1" />
		                     </span>
		                 </td>
		             </tr>
		             <tr>
		                 <th>추가값 1,2,3</th>
		                 <td>
		                     <span class="pwtableblock">
		                         <span class="input-text08"><input type="text" name="codeList[0].addVal1" placeholder="추가값1" value=""/></span>
		                         <span class="input-text08"><input type="text" name="codeList[0].addVal2" placeholder="추가값2" value=""/></span>
		                     </span>
		                     <span class="pwtableblock">
		                         <span class="input-text08"><input type="text" name="codeList[0].addVal3" placeholder="추가값3" value="" /></span>
		                     </span>
		                 </td>
		             </tr>
		             <tr>
		                 <th>표시여부</th>
		                 <td>
		                     <span class="input-rd01"><input type="radio" id="a3"  name="codeList[0].useYn"  value="Y" checked="checked"><label for="a3">사용</label></span>
		                     <span class="input-rd01"><input type="radio" id="a33" name="codeList[0].useYn"  value="N"  ><label for="a33">미사용</label></span>
		                 </td>
		            </tr>
		        </table>
	        </div>
        </div>
    </section>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function(){
        
        var isCreat = ("${pVo.getViewFlg()}" === "C");
        var upCode = "";
        if(isCreat) {
            $("#childDiv").css("display", "none");
        } else {
            $("#dupCheck").val('Y');
            $("#dupCodeCheck").hide();
            $("#comCd").prop('readonly', true);
            upCode = '${codeVO.comCd}' === '' ? $("#comCd").val() : '${codeVO.comCd}';
            
            if(parseInt(commcodeEdit.subBoxSize) === 0) {
                commcodeEdit.addCodeFormFnc(upCode);
            }
        }
       
        commcodeEdit.initBtn(upCode);
    });
    var commcodeEdit = {};
    commcodeEdit.subBoxSize = parseInt('${fn:length(childCodeList)}');
    commcodeEdit.comUpCd = '${codeVO.comCd}';
    commcodeEdit.initBtn = function(pUpCd) {
        $("#comCd").focusin(function() {
            $("#comCd").val('');
            $("#dupCheck").val('N');
        });
       
        $("#dupCodeCheck").on("click",this.dupCodeCheckFnc);
        $("#moveListBtn").on("click",function(e) {
        	e.preventDefault();
        	e.stopPropagation();
            $("#frm").attr({method : 'post', action: "<c:url value='/getCommonCodeList.do'/>"}).submit();
        });
        $("#dataEditBtn").on("click",this.dataEditExecFnc);
        $("#addCode").on("click",this.clickAddCodeFormFnc);
        
    };
    
    commcodeEdit.dupCodeCheckFnc = function(e){
        e.preventDefault();
        if($("#comCd").val() === '') {
            alert('중복 체크 할 코드를 입력해주세요.');
            return;
        }
        commonAjax.postAjax("<c:url value='/isDupCodeChk.do'/>", 'json', {'comUpCd' : $("#comCd").val()}
           , function(data){
                 if(data != null && data.checkResult != null) {
                     if(data.checkResult > 0 ) {
                         $("#dupCheck").val('N');
                         alert("이미 등록된 코드입니다.");
                         $("#comCd").val('').focus(); 
                         return;
                     } else {
                         $("#dupCheck").val('Y');
                         alert("등록할 수 있는 코드입니다.");
                         var code = $("#comCd").val();
                         $("#comCd").val(code.toUpperCase());
                         return;
                     }
                 }
        });
    };
    commcodeEdit.dataEditExecFnc = function(e){
        e.preventDefault();
        e.stopPropagation();
        var _this = commcodeEdit;
        var ans = false;
        if($("#dupCheck").val() === "N") {
            alert("코드 중복을 체크해 주세요.");
            return false;
        }
        
        if($("[name='viewFlg']").val() === "C" ) {
            if(!isCode($("#comCd").val())) {
                alert("코드는 영문으로 시작해야 합니다.");
                return false;
            }
            if($("#comCdNameKo").val() === '' && ( $("#comCdNameEn").val() === '' || $("#comCdNameJa").val() === '' || $("#comCdNameZh").val() === '')) {
            	alert("코드명을 하나 이상 입력해 주세요.");
            	return false;
            }
            //$("#codefrm").append($('<input>',{type : 'hidden', name : 'dspOrd'}).val(1));
            $.trimAllText("codefrm");
            ans = confirm("저장 하시겠습니까?");
            if(ans) {
	            commonAjax.postAjax("<c:url value='/addCommonCodExe.do'/>","json", $("#codefrm").serialize() 
	                ,function(data){
	                    if(data !== null && data.checkResult > 0){
	                    	alert(data.resultMessage);
	                        $("[name='viewFlg']").val('U');
	                        $("#childDiv").css("display", "block");
	                        $("#comCd").prop("readonly", true);
	                        $("#dupCodeCheck").css("display", "none");
	                        _this.comUpCd = $("#comCd").val();
	                        _this.addCodeFormFnc();
	                    }    
	                }
	            );
            }
        } else {
        	var $allTr = $(".addStwrap > .tb_type02 > tbody > tr");
        	var trSize = $allTr.length;
        	for(var i=0; i< trSize ; i +=1) {
        		if((i % 6) !== 1) {
                    continue;
                }
        		var check1 = $allTr.eq(i).find("input:text").val();
                if(check1 === '') {
                     alert('순서는 필수 값입니다.');
                     return false;
                 }
                      	}
        	for(var j=0; j< trSize ; j +=1) {
                if((j %6) !== 2) {
                    continue;
                }
                var check2 = $allTr.eq(j).find("input:text").eq(0).val();
                if( check2 === '') {
                     alert('한글 코드명은 필수입니다.');
                     return false;
                 }
            }
        	ans = confirm("저장 하시겠습니까?");
        	if(ans) {
		        commonAjax.postAjax("<c:url value='/setCommonCodeExe.do'/>","json", $("#codefrm").serialize() 
		            , function(data){
		                  if(data.checkResult > 0){
		                      alert(data.resultMessage);
		                  }  
		              }
		        );
        	}
        }
        
    };
    commcodeEdit.clickAddCodeFormFnc = function(e) {
    	console.log(e.type);
    	e.preventDefault();
        e.stopPropagation();
        this.blur();
    	var _this = commcodeEdit;
        _this.addCodeFormFnc();
    };
    commcodeEdit.chkNumber = function(e) {
    	var r = numbersonly(e,false);
    	if(!r){
    		alert('숫자만 입력 가능합니다.');
    		$(this).val('');
    		return false;
    	}
    };
    commcodeEdit.removeBox = function(e) {
    	var _this = commcodeEdit;
    	e.preventDefault();
        e.stopPropagation();
        $(this).parent().parent().remove();
        _this.subBoxSize -= 1;
    };
    commcodeEdit.addCodeFormFnc = function(){
    	var _this = commcodeEdit;
    	
        var rIdx    = parseInt(_this.subBoxSize);
        var $cloneDiv = $("#cloneDiv .questionBox").clone();
        var upCode = _this.comUpCd;
       
        var surffix = "_00"+(rIdx +1);
        if(rIdx > 8) {
            surffix = "_0"+(rIdx +1);
        }
        upCode  = upCode+surffix;
        $cloneDiv.find("table").addClass('tb_type02'); 
        $cloneDiv.find("button").on("click", _this.removeBox);
        if(rIdx === 0) {
            
        	$cloneDiv.find("table tr").eq(1).find("input:hidden").eq(1).val(upCode);
        	$cloneDiv.find("table tr").eq(1).find("input:text").on('keyup',_this.chkNumber);
          
        	$(".questionBoxWrap").append($cloneDiv);
            
        } else {
        	
        	$cloneDiv.find("table tr").eq(1).find("input[type='hidden']").eq(0).attr('name', 'codeList['+rIdx+'].crudFlg');
        	$cloneDiv.find("table tr").eq(1).find("input[type='hidden']").eq(1).attr('name', 'codeList['+rIdx+'].comCd').val(upCode);
        	$cloneDiv.find("table tr").eq(1).find("input[type='text']").attr('name', 'codeList['+rIdx+'].dspOrd').on('keyup',_this.chkNumber);
        	
        	$cloneDiv.find("table tr").eq(2).find("input[type='hidden']").eq(0).attr('name', 'codeList['+rIdx+'].langList[0].lang');
        	$cloneDiv.find("table tr").eq(2).find("input[type='hidden']").eq(1).attr('name', 'codeList['+rIdx+'].langList[1].lang');
        	$cloneDiv.find("table tr").eq(2).find("input[type='hidden']").eq(2).attr('name', 'codeList['+rIdx+'].langList[2].lang');
        	$cloneDiv.find("table tr").eq(2).find("input[type='hidden']").eq(3).attr('name', 'codeList['+rIdx+'].langList[3].lang');

        	$cloneDiv.find("table tr").eq(2).find("input[type='text']").eq(0).attr('name', 'codeList['+rIdx+'].langList[0].comCdName');
            $cloneDiv.find("table tr").eq(2).find("input[type='text']").eq(1).attr('name', 'codeList['+rIdx+'].langList[1].comCdName');
            $cloneDiv.find("table tr").eq(2).find("input[type='text']").eq(2).attr('name', 'codeList['+rIdx+'].langList[2].comCdName');
            $cloneDiv.find("table tr").eq(2).find("input[type='text']").eq(3).attr('name', 'codeList['+rIdx+'].langList[3].comCdName');
            
            $cloneDiv.find("table tr").eq(3).find("input[type='text']").eq(0).attr('name', 'codeList['+rIdx+'].cdDesc1');

            $cloneDiv.find("table tr").eq(4).find("input[type='text']").eq(0).attr('name', 'codeList['+rIdx+'].addVal1');
            $cloneDiv.find("table tr").eq(4).find("input[type='text']").eq(1).attr('name', 'codeList['+rIdx+'].addVal2');
            $cloneDiv.find("table tr").eq(4).find("input[type='text']").eq(2).attr('name', 'codeList['+rIdx+'].addVal3');
           
            $cloneDiv.find("table tr").eq(5).find("input[type='radio']").eq(0).attr('name', 'codeList['+rIdx+'].useYn');
            $cloneDiv.find("table tr").eq(5).find("input[type='radio']").eq(1).attr('name', 'codeList['+rIdx+'].useYn');
            
            $(".questionBoxWrap").last().append($cloneDiv);
            $cloneDiv.find("table tr").eq(5).find("input[type='radio'][name='codeList["+rIdx+"].useYn']").eq(0).prop('checked', true);
          
        }
        _this.subBoxSize +=1;
    };
    </script>
</body>
</html>
