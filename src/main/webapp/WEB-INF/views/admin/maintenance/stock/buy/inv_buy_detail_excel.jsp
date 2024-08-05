<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("부품구매상세내역.xls", "UTF8"));
    response.setHeader("Content-Description", "JSP Generated Data");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<title></title>
<meta content="text/html; charset=KSC5601" http-equiv="content-type" />
<style>
.tb_type01 th {text-align:center;padding:5% 0;}
.tb_type01 td {text-align:center;padding:5% 0}
.tb_type01 {width:100%;border:1px solid #e6e6e6;font-size:15px;table-layout:fixed}
.tb_type01 th {text-align:center;padding:15px 0;background:#eff5f8;border-top:2px solid #5e5e5e;border-right:1px solid #e6e6e6}
.tb_type01 td {text-align:left;padding:10px 2px;border:1px solid #e6e6e6}
.tb_type01 td.txRight {text-align:right;}
.tb_type01 td.txCenter {text-align:center;}
.tb_condition {width : 1200px}
.tb_condition td {text-align:center;padding:15px 0;border: 1px solid #e6e6e6;}
.tb_condition td.condition {width:150px;text-align:center;padding:15px 0;background:#FFFF99;}
/*label*/
.laType02 {margin-right:5px;display:inline-block;font-size:11px;}
</style>
</head>
<body>
    <div style="height:200px; width:1200px;text-align:center; margin-top:10px;">
    </div>
    <div>
        <table class="tb_condition">
            <tbody>
                <tr>
                	<td style="width:200px;" class="condition" ><label class="laType02">주문자명</label>
	                <td style="width:400px;" colspan="2">${partData.buyerName }</td>
	            </tr>
	            <tr>
	                <td style="width:200px;" class="condition" ><label class="laType02">주문자 연락처</label>
	                <td style="width:400px;" colspan="2">${partData.buyerMpnNo }</td>
	            </tr>
	            <tr>
	                <td style="width:200px;" class="condition" ><label class="laType02">주문자 일자</label>
	                <td style="width:400px;" colspan="2">${partData.buyDate }</td>
	            </tr>
	                <td style="width:200px;" class="condition" ><label class="laType02">업체 사업자 번호</label>
	                <td style="width:400px;" colspan="2">${partData.cmpyBusinessNo }</td>
	            </tr>
	            <tr>
	                <td style="width:200px;" class="condition" ><label class="laType02">업체명</label>
	                <td style="width:400px;" colspan="2">${partData.buyCmpyName }</td>
	            </tr>
	            <tr>
	                <td style="width:200px;" class="condition" ><label class="laType02">업체 연락처</label>
	                <td style="width:400px;" colspan="2">${partData.cmpyTelNo }</td>
	            </tr>
	            <tr>
	                <td style="width:200px;" class="condition" ><label class="laType02">가격</label>
	                <td style="width:400px;" colspan="2">${partData.totBuyPrce }</td>
	            </tr>
	            <tr>
	                <td style="width:200px;" class="condition" ><label class="laType02">비고</label>
	                <td style="width:400px;" colspan="2">${partData.partBuyDesc }</td>
                </tr>
            </tbody>
        </table>
    </div>
    <!--검색조건 E-->
    <table class="tb_type01" style="width : 1200px;">
        <thead>
            <tr>
                <th>부품</th>
				<th>수량</th>
				<th>부품단가</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="result" items="${partList}" varStatus="loop">
                <tr>
                    <td>${result.partCdName}</td>
                    <td>${result.buyQunt}</td>
                    <td>${result.partUnitPrce}</td>
                </tr>
            </c:forEach>
            <c:if test="${fn:length(partList) == 0 }">
                <tr><td colspan="3">no data</td></tr>
            </c:if>
        </tbody>
    </table>
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
    });
	buyDetail.initData = function(vFlg){
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
    </script>
</body>
</html>