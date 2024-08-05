<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

</head>
<body>

<div> 
    <!-- top menu -->
    <div id="navbarTop" class="navbar navbar-dark fixed-top" style="place-content: center;" >
    
    	<button class="navbar-brand" type="button" onclick="window.location.reload();"></button>
    	
    </div>
</div>

<div style="position: fixed; z-index: 1030;">

	<div class="menuBtn">
		<svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-justify" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  			<path fill-rule="evenodd" d="M2 12.5a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0-3a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0-3a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0-3a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5z"/>
  		</svg>
  	</div> 
	<div class="page_cover"></div> 
	
	
	<div id="menuDiv">
		
		<div class="menuClose" style="color: #fff; padding-top: 10px;">
			<svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-x-square" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
			  	<path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
			  	<path fill-rule="evenodd" d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
			</svg>
		</div>
		
	     <div id="slideNav" style="background: #11503d;height: 100%;">
	     
	     	 <div class="logOut" style="display: inline-block; width: 40px; height: 30px; padding-top: 3px; padding-bottom: 3px;  cursor: pointer; position: absolute; left: 10px; top: 10px;">
	     	 	
	     	 </div>
	     	 
	         <table style="padding : 10%; position: relative; top: 50px;">
	         
	             <tr>
	                 <td><button class="navBtn" type="button" style="color: #fff;">공지사항</button></td>
	             </tr>
 				<tr>
	                 <td><button class="navBtn" type="button" style="color: #fff;">근태등록</button></td>
	             </tr> 
 				<tr>
	                 <td><button class="navBtn" type="button" style="color: #fff;">대여소</button></td>
	             </tr>
 
	             <tr>
	             	<td><button class="setBtn" type="button" style="color: #fff;">글자크기 조절</button></td>
	             </tr>
	             
	         </table>
	     </div>	
	</div>

</div>
</body>
</html>