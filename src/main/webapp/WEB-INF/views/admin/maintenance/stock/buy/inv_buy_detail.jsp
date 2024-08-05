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
                    
                        <form id="frm">
                            <input type="hidden" name="viewFlg" value="${part.getViewFlg()}">
                            <input type="hidden" name="searchStartDate" value="${part.getSearchStartDate()}">
                            <input type="hidden" name="searchEndDate" value="${part.getSearchEndDate()}">
                            <input type="hidden" name="partBuySeq" value="${part.getPartBuySeq()}">
                            <input type="hidden" name="buyerMpnNo" value="">
                            <input type="hidden" name="cmpyBusinessNo" value="">
                            <input type="hidden" name="cmpyTelNo" value="">
                            <fieldset>
                                <legend>구매내역 등록 / 상세 / 수정</legend>
                                <table class="tb_type02 mt20">
                                    <colgroup>
                                        <col style="width:25%"/>
                                        <col style="width:75%"/>
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th class="top"><em>*</em> 주문자명</th>
                                            <td class="top">
                                                <span class="input-text08"><input type="text"  id="buyerName" name="buyerName" value="${partData.buyerName }"/></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><em>*</em> 주문자 연락처</th>
                                            <td>
                                                <span class="input-text03"><input name="buyer" type="text" maxlength="3" /></span>
                                                <span class="dash">-</span>
                                                <span class="pwtableblock">
                                                    <span class="input-text03 "><input name="buyer"  type="text" maxlength="4" /></span>
                                                    <span class="dash">-</span>
                                                    <span class="input-text03 "><input name="buyer"  type="text" maxlength="4" /></span>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><em>*</em> 주문일자</th>
                                            <td>
                                                <span class="selectDate input-datepick04"><input type="text"  id="buyDate"  class="datepicker input-datepick04" title="선택 날짜" id="bb22"  name="buyDate" value="${partData.buyDate }" readonly/></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>업체 사업자 번호</th>
                                            <td>
                                                <span class="input-text03"><input type="text" name="businessNo" /></span>
                                                <span class="dash">-</span>
                                                <span class="pwtableblock">
                                                    <span class="input-text03 "><input type="text"  name="businessNo"  /></span>
                                                    <span class="dash">-</span>
                                                    <span class="input-text03 "><input type="text"  name="businessNo" /></span>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><em>*</em> 업체명</th>
                                            <td>
                                                <span class="input-text07"><input type="text" id="buyCmpyName" name="buyCmpyName" value="${partData.buyCmpyName}"/></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><em>*</em> 업체연락처</th>
                                            <td>
                                                <span class="input-text03"><input type="text" maxlength="3"  name="telNo" /></span>
                                                <span class="dash">-</span>
                                                <span class="pwtableblock">
                                                    <span class="input-text03 "><input type="text" maxlength="4"  name="telNo" /></span>
                                                    <span class="dash">-</span>
                                                    <span class="input-text03 "><input type="text" maxlength="4"  name="telNo" /></span>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><em>*</em> 가격</th>
                                            <td>
                                                <span class="input-text08"><input class="tr" type="text" maxlength="8" id="totBuyPrce" name="totBuyPrce" readonly="readonly"  value="${partData.totBuyPrce}"/></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>비고</th>
                                            <td>
                                                <span class="input-text07"><input type="text" name="partBuyDesc" id="partBuyDesc" value="${partData.partBuyDesc}" /></span>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <table class="tb_type01  mt20">
                                    <colgroup>
                                        <col style="width:34%">
                                        <col style="width:24%">
                                        <col style="width:25%">
                                        <col style="width:17%">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th class="sd">부품</th>
                                            <th class="sd">수량</th>
                                            <th class="sd">부품단가</th>
                                            <th class="last"><button type="button" id="plusBtn" class="fullBtn"><img src="/images/btn_addAnswer.png" alt=""></button></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                                <div class="btnArea">
                                    <span class="left"><button type="button" id="pageBtn" class="btnType01 bc_gray">목록</button></span>
                                    <span class="right">
                                    	<button class="btnType01" id="excelViewBtn" title="엑셀다운로드">엑셀다운로드</button>
	                                    <button type="button" id="deltBtn" class="btnType01">삭제</button>
	                                    <button type="button" id="editBtn" class="btnType01 bc_green">저장</button>
                                    </span>  
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
    <section style="display: none;">
        <table id="cloneTr">
            <tr>
                <td style="display: none;"><input type="hidden"  name="partBuyList[0].viewFlg" value="C"/></td>
                <td class="tc">
                    <select class="select-category03" name="partBuyList[0].partCd">
                         <option value="">선택</option>
                    </select>
                </td>
                <td  class="tc">
                    <span class="input-text11"><input type="text"  class="tr"  name="partBuyList[0].buyQunt" max="4"/></span>
                </td>
                <td  class="tc">
                    <span class="input-text13"><input type="text"  class="tr"  name="partBuyList[0].partUnitPrce" max="8"/></span>
                </td>
                <td class="last tc"><button type="button" class="fullBtn"><img src="/images/btn_delAnswer.png" alt=""></button></td>
            </tr>
        </table>
    
    </section>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function() {
    	//상태코드
        commonAjax.getCommonCode("PAR", function(data) {
             if(data !== null && data.codeList !== null) {
            	 buyDetail.partCombo = data.codeList;
                 commCdBox.makeComboBox('CC','',data.codeList, $("#cloneTr").find('select'));
                 buyDetail.initData("${part.getViewFlg()}");
             }
        });
    	buyDetail.initView();
    	buyDetail.initBtn();
    });
    var buyDetail = {};
    buyDetail.partBuySeq = '${part.getPartBuySeq()}';
    buyDetail.buyerMpnNo = '${partData.buyerMpnNo}';
    buyDetail.cmpyBusinessNo = '${partData.cmpyBusinessNo}';
    buyDetail.cmpyTelNo = '${partData.cmpyTelNo}';
    buyDetail.partCombo = [];
    
    buyDetail.initData = function(vFlg){
    	
    	if(vFlg === 'U') {
            commonAjax.getAjax("/getStockBuyPartList.do", "json", {partBuySeq : $("[name='partBuySeq']").val()}
                 ,function(data){
            	      if(data){
            	          if(data.checkResult) {
            	              if(data.partList.length  > 0)  {
            	            	  var pSize = data.partList.length;
            	            	  for(var i= 0; i<pSize; i+=1) {
	            	            	  buyDetail.makePartDetailList(data.partList[i]);
            	            	  }
            	              } else {
            	            	  buyDetail.makePartDetailList(null);
            	              }
            	          } else {}    	    	  
            	     }
                 }
            );
    	} else {
    		 buyDetail.makePartDetailList(null);
    	}
    };
    buyDetail.deltPartRow = function(e) {
    	e.preventDefault();
    	e.stopPropagation();
    	
    };
    buyDetail.initView = function(){
    	//주문자 연락처
    	if(buyDetail.buyerMpnNo !== '') {
    		var mpnNo = buyDetail.buyerMpnNo.split('-');
    		$("[name='buyer']").eq(0).val(mpnNo[0]);
    		$("[name='buyer']").eq(1).val(mpnNo[1]);
    		$("[name='buyer']").eq(2).val(mpnNo[2]);
    		
    		
    		
    		
    		
    	}
        if(buyDetail.cmpyBusinessNo !== '') {
        	var businessNo = buyDetail.cmpyBusinessNo.split('-');
        	$("[name='businessNo']").eq(0).val(businessNo[0]);
            $("[name='businessNo']").eq(1).val(businessNo[1]);
            $("[name='businessNo']").eq(2).val(businessNo[2]);
        }
        if(buyDetail.cmpyTelNo !== '') {
        	var telNo = buyDetail.cmpyTelNo.split('-');
        	$("[name='telNo']").eq(0).val(telNo[0]);
            $("[name='telNo']").eq(1).val(telNo[1]);
            $("[name='telNo']").eq(2).val(telNo[2]);
        }
    	
    };
    buyDetail.initBtn = function(){
    	$("#plusBtn").on("click", { type : 'add' }, this.editListPartRow);
    	$("#deltBtn").on("click", { modType : 'del'} ,this.exePartEditForm);
    	$("#pageBtn").on("click", { modType : 'list'},this.exePartEditForm);
    	$("#editBtn").on("click", { modType : 'edit'},this.exePartEditForm);
    	$("#excelViewBtn").on("click",{modType : "excel"},this.exePartEditForm);
    };
    buyDetail.editListPartRow = function(e){
    	var type = e.data.type;
    	if(type === 'add') {
	    	buyDetail.makePartDetailList(null);
    	} else {
    		var sltIdx = $(this).parent().parent().get(0).rowIndex-1;
    		var rowType = $(".tb_type01 tbody tr").eq(sltIdx).find('input[type="hidden"]').val();
    		var qunt = $(".tb_type01 tbody tr").eq(sltIdx).find('input[type="text"]').eq(0).val();
    		var unitPrce = $(".tb_type01 tbody tr").eq(sltIdx).find('input[type="text"]').eq(1).val();
    		var tot =Number(removeComma(qunt)) * Number(removeComma(unitPrce));
    		if(rowType === 'C'){
    			$(".tb_type01 tbody tr").eq(sltIdx).remove();
    			if($(".tb_type01 tbody tr").length() === 0) {
    				 buyDetail.makePartDetailList(null);
    			}
    		} else {
    			$(".tb_type01 tbody tr").eq(sltIdx).find('input[type="hidden"]').first().val('D');
    			$(".tb_type01 tbody tr").eq(sltIdx).css('display', 'none');
    		}
    		buyDetail.calcPrice('minus', tot);
           
    	}
    };
    buyDetail.makePartDetailList  = function(pData){
    	var iidx = $(".tb_type01 tbody tr").length;
    	var $tr = $("#cloneTr tbody tr").clone();
    	var part='',qunt='',partPrce='',vType='C';
    	if(pData !== null) {
    		part = pData.partCd;
    		qunt = pData.buyQunt;
    		partPrce = FormatNumber(pData.partUnitPrce,3);
    		vType= 'U';
    	}
    	$tr.children().eq(0).find('input').attr('name', 'partBuyList['+iidx+'].viewFlg').val(vType);
    	var slt = $tr.children().eq(1).find('select').attr('name', 'partBuyList['+iidx+'].partCd').val(part).on('change',this.chkPart);
    	if(vType === 'U' && pData !== null){
    		slt.prop('disabled', true);
    		$tr.append('<td style="display:none;"><input type="hidden" name="partBuyList['+iidx+'].partCd" value="'+part+'"></td>');
    	}
    	$tr.children().eq(2).find('input').attr('name', 'partBuyList['+iidx+'].buyQunt').val(qunt);
    	$tr.children().eq(3).find('input').attr('name', 'partBuyList['+iidx+'].partUnitPrce').val(partPrce).on('focusout',this.calcTotPrice).on('focusin', this.resetPrice);
    	$tr.children().eq(4).find('button').on('click', {type : 'del'}, this.editListPartRow);
    	if(iidx == 0) {
            $(".tb_type01 tbody").append($tr);
    	} else {
	    	$(".tb_type01 tbody tr").last().after($tr);
    	}
    };
    buyDetail.resetPrice = function(e) {
    	e.preventDefault();
    	if($(this).val() === '') {
    		return false;
    	}
    	$(this).val('').focus();
    };
    buyDetail.calcTotPrice = function(e){
    	e.preventDefault();
    //	var tIdx = $(this).parent().parent().parent().get(0).rowIndex-1;
	    if($(this).parent().parent().prev().find('input').val() === ''){
	    	return false;
	    }
    	buyDetail.calcPrice('add', 0);
    };
    buyDetail.calcPrice = function(type, pNum) {
    	var tot = 0;
    	if(type === 'add') {
    		$(".tb_type01 tbody tr").each(function(){
    			if($(this).css('display') !== 'none') {
	    			tot += Number($(this).find('input[type="text"]').eq(0).val()) * Number($(this).find('input[type="text"]').eq(1).val());
    			}
    		});
    	} else{
    		var t = $("#totBuyPrce").val() === ""?  0 : $("#totBuyPrce").val();
    		tot =  Number(removeComma(t));
    	    tot -= pNum;
    	}
    	$("#totBuyPrce").val(FormatNumber(tot,3));
    };
    buyDetail.exeEdit = function() {
        commonAjax.postAjax("/exeStockBuyDataEdit.do", "json",$("#frm").serialize()
            ,function(data){
                 if(data) {
                	 if(data.checkResult > 0){
                         alert(data.resultMessage);
                         if($("[name='viewFlg']").val() !== 'U') {
                        	 $("#pageBtn").trigger('click');
                         }
                     } else {
                         alert(data.resultMessage);
                         return false;
                     }
                 }
             }
        );
    };
    buyDetail.exePartEditForm = function(e) {
    	e.preventDefault();
    	e.stopPropagation();
    	var _this = buyDetail;
    	var mType = e.data.modType;
    	switch(mType){
	    	case "list" :
	    		$("#frm").attr({method : 'post',  action  :'/getBuyPartsList.do'}).submit();
	    	break;
	    	case "excel" :
	    		$("[name='viewFlg']").val(mType);
	    		$("#frm").attr({method : 'post',  action  :'/moveStockBuyDetailInfo.do'}).submit();
	    	break;
	    	case "del" :
	    		var ans = confirm("등록한 부품을 포함한 모든 정보를 삭제 하시겠습니까?");
	    		if(ans) {
	    			$("[name='viewFlg']").val("D");
	    			_this.exeEdit();
	    		}
	    		
	    	break;
	    	case "edit" :
	    		if(buyDetail.inputValidChk()) {
	    			var tel1 = $("[name='buyer']").eq(0).val()+"-"+ $("[name='buyer']").eq(1).val()+"-"+ $("[name='buyer']").eq(2).val();
	    	        var tel2 = $("[name='businessNo']").eq(0).val()+"-"+ $("[name='businessNo']").eq(1).val()+"-"+ $("[name='businessNo']").eq(2).val();
	    	        var tel3 = $("[name='telNo']").eq(0).val()+"-"+ $("[name='telNo']").eq(1).val()+"-"+ $("[name='telNo']").eq(2).val();
	    	        $("[name='buyerMpnNo']").val(tel1);
	    	        if(tel2.trim().length < 4) {
	    	            tel2 = "";
	    	        }
	    	        $("[name='cmpyBusinessNo']").val(tel2);
	    	        $("[name='cmpyTelNo']").val(tel3);
	    	        $("[name='totBuyPrce']").val(removeComma($("#totBuyPrce").val()));
	    	        //if()
	    	        
	    	        _this.exeEdit();
	    		}
	    	break;	
    	}
    };
    buyDetail.chkPart = function(e){
    	e.preventDefault();
    	var tVal = $(this).val();
    	var iSize = $(".tb_type01 tbody tr").length;
    	var target = $(this).parent().parent().get(0).rowIndex -1;
    	if(iSize > 1) {
	    	$(".tb_type01 tbody tr").each(function(i){
	    		if(i !== target) {
	    		    if($(this).find('select').val() === tVal && $(this).css('display') !== 'none') {
	                     alert('같은 이미 선택한 부품입니다.');
	                     $(".tb_type01 tbody tr").eq(target).find('select').val('');
	                     return false;
	                 }
	    		}
	        });
    	}
    };
    buyDetail.inputValidChk = function() {
    	
    	if($("#buyerName").val() === ""){
    		alert("주문자명을 입력해주세요");
    		return false;
    	}
    	var chkCnt = 0;
    	$("[name='buyer']").each(function(){
             if($(this).val() === '') {
            	 alert("주문자 연락처를 입력해 주세요");
                 $(this).focus();
                 chkCnt ++;
                 return false;
             }
        });
    	if(chkCnt > 0) {
    		 return false;
    	}
    	if($("#buyDate").val() === ""){
            alert("주문일자를 입력해주세요.");
            return false;
        }   
    	
    	if($("#buyCmpyName").val() === ""){
            alert("업체명을 입력해주세요.");
            return false;
        }
    	chkCnt = 0;
        $("[name='telNo']").each(function(){
        	if($(this).val() === '') {
        		alert("업체 연락처를 입력해 주세요.");
        		$(this).focus();
        		chkCnt ++;
        		return false;
        	}
        });
        if(chkCnt > 0) {
            return false;
        }
    	if($("#buyerName").val() === ""){
           alert("주문자명을 입력해주세요");
           return false;
        }
    	if($("#totBuyPrce").val() === "" || $("#totBuyPrce").val() === "0" ){
            alert("부품을 입력해 주세요.");
            return false;
        }
    	var phoneNum = $("[name='buyer']").eq(0).val()+ $("[name='buyer']").eq(1).val()+ $("[name='buyer']").eq(2).val();
    	if(!isTel(phoneNum)){
    		alert("전화번호 형식이 아닙니다.");
    		return false;
    	}
    	phoneNum = $("[name='telNo']").eq(0).val()+ $("[name='telNo']").eq(1).val()+ $("[name='telNo']").eq(2).val();
    	if(!isTel(phoneNum) && !isMpn(phoneNum)){
            alert("전화번호 형식이 아닙니다.");
            return false;
        }
    	if(!isNumeric(removeComma($("#totBuyPrce").val()))){
            alert("숫자만 입력 가능합니다.");
            $("#totBuyPrce").val('').focus();
            return false;
        }
    	chkCnt = 0;
    	$(".tb_type01 tbody tr").each(function(){
    		if($(this).find('select').val() === '') {
    			alert('부품을 선택해 주세요.');
    			chkCnt ++;
    			return false;
    		}
    		if($(this).find('input[type="text"]').val() === '') {
                alert('수량을 입력해 주세요.');
                chkCnt ++;
                return false;
            }
    		if(!isNumeric($(this).find('input[type="text"]').val())) {
                alert('숫자형식이어야 합니다.');
                chkCnt ++;
                return false;
            }
    		/* if(!isNumeric($(this).find('input[type="text"]').eq(1).val())) {
                alert('숫자형식이어야 합니다.');
                return false;
            } */
    	});
    	if(chkCnt !== 0){
    		return false;
    	}
    	return true;
    };
    
    
    </script>
</body>
</html>