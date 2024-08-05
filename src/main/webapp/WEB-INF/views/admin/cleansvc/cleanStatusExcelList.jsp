<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>


<%
	Calendar cal = Calendar.getInstance();
	int nowYear = cal.get(Calendar.YEAR);
	int nowMonth = cal.get(Calendar.MONTH)+1;
	int day = cal.get(Calendar.DAY_OF_MONTH);
	int hour = cal.get(Calendar.HOUR_OF_DAY);
	int min = cal.get(Calendar.MINUTE);
	int sec = cal.get(Calendar.SECOND);
	
	String fileName =  nowYear + "년" + nowMonth + "월"+ day + "일" + hour + "시"+ min +"분" + sec +"초" + "근태실적.xls" ;
	
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode( fileName , "UTF-8"));
    /* response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("정비보고서.doc", "UTF-8")); */
	/* response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("정비보고서.hwp", "UTF-8")); */
    response.setHeader("Content-Description", "JSP Generated Data");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
</head>
<body>
<meta content="text/html; charset=KSC5601" http-equiv="content-type" />
 
</head>
<body>

<h1 style="text-align:center;">   ${statMonth}  월 근태실적</h1>
    <div style="height:200px; width:100%;text-align:center; margin-top:10px;">
    </div>

    <table class="tb_type01" style="width : 100%;">
        <thead>
            <tr>
                <th>id</th>
                <th>성명</th>
                <th>근무일수</th>
                <th>01</th>
                <th>02</th>
                <th>03</th>
                <th>04</th>
                <th>05</th>
                <th>06</th>
                <th>07</th>
                <th>08</th>
                <th>09</th>
                <th>10</th>
                <th>11</th>
                <th>12</th>
                <th>13</th>
                <th>14</th>
                <th>15</th>
                <th>16</th>
                <th>17</th>
                <th>18</th>
                <th>19</th>
                <th>20</th>
                <th>21</th>
                <th>22</th>
                <th>23</th>
                <th>24</th>
                <th>25</th>
                <th>26</th>
                <th>27</th>
                <th>28</th>
                <th>29</th>
                <th>30</th>
                <th>31</th>
            </tr>
        </thead>
          
        <tbody>

          <c:forEach var="result" items="${cleanListA}" varStatus="status">
			<tr>
				<th>${result.adminId}</th>
				<th>${result.adminName}</th>
				<th>${result.status_cnt}</th>
				<th>${result.status_01}</th>
                <th>${result.status_02}</th>
                <th>${result.status_03}</th>
                <th>${result.status_04}</th>
                <th>${result.status_05}</th>
                <th>${result.status_06}</th>
                <th>${result.status_07}</th>
                <th>${result.status_08}</th>
                <th>${result.status_09}</th>
                <th>${result.status_10}</th>
                <th>${result.status_11}</th>
                <th>${result.status_12}</th>
                <th>${result.status_13}</th>
                <th>${result.status_14}</th>
                <th>${result.status_15}</th>
                <th>${result.status_16}</th>
                <th>${result.status_17}</th>
                <th>${result.status_18}</th>
                <th>${result.status_19}</th>
                <th>${result.status_20}</th>
                <th>${result.status_21}</th>
                <th>${result.status_22}</th>
                <th>${result.status_23}</th>
                <th>${result.status_24}</th>
                <th>${result.status_25}</th>
                <th>${result.status_26}</th>
                <th>${result.status_27}</th>
                <th>${result.status_28}</th>
                <th>${result.status_29}</th>
                <th>${result.status_30}</th>
                <th>${result.status_31}</th>
             </tr>
          </c:forEach>      
          
		</tbody>
    </table>

</body>
</html>