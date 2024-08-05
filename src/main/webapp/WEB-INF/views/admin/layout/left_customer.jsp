<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
				<div class="leftmenu">
					<dl>
						<dt>고객센터</dt>
						<dd><a href="/admin/customer/notice/noticeList.do">공지사항_<c:out value="${sessionNa}"/></a></dd>
						<dd><a href="/admin/customer/faq/faqList.do">FAQ</a></dd>
						<dd><a href="/admin/customer/opinionBoard/opinionBoardList.do">시민 의견수렴</a></dd>
						<dd><a href="/admin/customer/photoGallery/photoGalleryList.do">포토갤러리</a></dd>
						<dd><a href="#">모바일 설문</a></dd>
						<dd><a href="/admin/customer/hikingCourse/hikingCourseList.do">추천하이킹 코스</a></dd>
					</dl>
				</div>