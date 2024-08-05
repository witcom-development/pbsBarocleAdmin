<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<%@ include file="../popup/pop_resource.jsp" %>
</head>
<body>
    <h1 class="popTt"></h1>
    <div class="cntbox">
        <div class="allwrap pop">
            <table class="tb_type02 mt20">
                <colgroup>
                    <col style="width:30%">
                    <col style="width:70%">
                </colgroup>
                <tbody>
                    <tr>
                        <th class="top"><em>*</em> 거치대 ID</th>
                        <td class="top"><span class="input-text01p"><input type="text"></span></td>
                    </tr>
                    <tr>
                        <th><em>*</em> 대여소명/ 번호</th>
                        <td>여의도11/1</td>
                    </tr>
                    <tr>
                        <th><em>*</em> 신고자 ID</th>
                        <td>hongildong</td>
                    </tr>
                    <tr>
                        <th><em>*</em> 고장상태</th>
                        <td>
                            <span class="pwtableblock input-ck01"><input type="checkbox" id="c1"><label for="c1">잠금블록 파손</label></span>
                            <span class="pwtableblock input-ck01"><input type="checkbox" id="c2"><label for="c2">자체파손</label></span>
                            <span class="pwtableblock input-ck01"><input type="checkbox" id="c3"><label for="c3">거치대</label></span>
                            <span class="pwtableblock input-ck01"><input type="checkbox" id="c4"><label for="c4">기타</label></span>
                        </td>
                    </tr>
                    <tr>
                        <th><em>*</em> 비고</th>
                        <td><textarea name="" class="detatextarea"></textarea></td>
                    </tr>
                </tbody>
            </table>
            <div class="btnArea">
                <span class="right"><button class="btnType01">저장</button><button class="btnType01">취소</button></span>
            </div>
        </div>
    </div>
    <a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
</body>
</html>
