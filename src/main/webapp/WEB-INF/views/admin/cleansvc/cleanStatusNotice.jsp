<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
</head>
<body>
<!-- solbit test-테스트 페이지  S   -->
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
                        <!-- 모바일 검색조건 S-->
                        <!-- 모바일 검색조건 E-->
						<!-- 검색조건  S -->
                       	
                       	<!-- 검색조건  E -->

                       	
                       	
                       	
                       	<div id="">
							<div class="card my-3">
								<div class="card-header">
								<strong>출입 차량 및 사람 소독</strong>
								</div>
								<div class="card-body rem0-9">
								농장내 출입하는 모든 차량과 사람에 대해서는 반드시 소독을 하고 기록을 하여야 합니다.
								차량을 소독할 경우에는 바퀴, 차체, 운전석 등을 전체적으로 소독하고, 운전자에 대해서도 반드시 소독조치를 하여야 합니다.
								악성가축질병이 발생한 경우 만은 인원이 모이는 장소에는 가급적 가지 마시고, 축산농가 모임에 가지 않아야 합니다.
								</div>
							</div>
							
							<div class="card my-3">
								<div class="card-header">
								<strong>근로자 관리 방안</strong>
								</div>
								<div class="card-body rem0-9">
								근로자 채용시 없는 곳에서 채용절차를 밟고, 채용 후 5일 이내에는 축사에 출입하지 못하도록 하여야 합니다. 
						휴대품 중 축산물 등 음식물은 소각·폐기하고, 의복·신발·가방 등 개인 용구에 대해서는 소독 등 방역 조치를 하여야 합니다.
								</div>
							</div>
						</div>
                    </div>
                 </div>
             </div>
      	</div>
<script type="text/javascript" src="/js/common_barocle.js"></script>
<script type="text/javascript">
		
	


      
</script>
                       	
</body>

</html>