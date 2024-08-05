<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<%@ include file="../../common/popup/pop_resource.jsp" %>
<script type="text/javaScript" src="/js/as/EgovMenuList.js"></script>
<style type="text/css">
.downemnubox img {width : 18px; height: 18px;}
</style>
</head>
<body>
    <h1 class="popTt"></h1>
    <div class="cntbox">
        <div class="allwrap pop">
            <c:forEach var="result" items="${menuListData}" varStatus="status" >
                <input type="hidden" name="menuListData" value="${result.menuCd}|${result.upMenu}|${result.menuName}|${result.menuCd}|${result.menuOrd}|${result.menuName}|${result.upMenu}|${result.menuDesc}|${result.menuLevel}|${result.linkImg}|${result.menuImg}|${result.srcLink}|${result.menuDetailCd }" />
            </c:forEach>
            <div class="downemnubox">
                <c:if test="${fn:length(menuListData)>1}">
                    <script type="text/javaScript">
                       setImagePath("/images/menuIconImg/");
                        var Tree = new Array;
                        var tSize = $("[name='menuListData']").length;
                        for (var j = 0; j <tSize; j++) {
                            Tree[j] =  $("[name='menuListData']").eq(j).val();
                        }
                        createTree(Tree,true);
                        
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
        </div>
    </div>
    <a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
	<script type="text/javaScript">
	    /* var treeDataSize = ("${fn:length(menuListData)>0}" === "true");
	    treeNode.setImgPath("/images/menuIconImg/");
	    var Tree = [];
	    if(treeDataSize) {
	        var tSize = $("[name=menuListData]").length;
	        for (var j = 0; j < tSize; j +=1) {
	            Tree[j] =  $("[name=menuListData]").eq(j).val();
	        }
	        treeNode.createTree($("#tree"),Tree,true);
	         
	    } else {
	        Tree[0] = "1|1|1|1|1|1|1|1|1|1|1|1";
	        treeNode.createTree($("#tree"),Tree);
	    } */
	    function choiceNodes(upperNo) {
	
	        var nodeValues = treeNodes[upperNo].split("|");
	        var upMenu = nodeValues[3];
	        var menuLevel = parseInt(nodeValues[8]) + 1;
	        var menuDetailCd = nodeValues[12];
	        opener.adminMenu.upperchoice(upMenu,menuLevel,menuDetailCd);
	        window.close();
	        
	    }
	    function rootClick() {
	        var upMenu = "0";
	        var menuLevel = "1";
	        var menuDetailCd = "";
	        opener.adminMenu.upperchoice(upMenu,menuLevel,menuDetailCd);
	        window.close();
	    }
	</script>
    
</body>
</html>

