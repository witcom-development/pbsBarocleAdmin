/*
 * Copyright 2008-2009 MOPAS(Ministry of Public Administration and Security).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.dkitec.barocle.util.egov.paging;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * DefaultPaginationRenderer.java
 * <p/><b>NOTE:</b><pre> 페이징 리스트의 기본적인 포맷을 제공한다.  
 * 이를 위해 AbstractPaginationRenderer의 클래스 변수들의 값을 세팅한다.  
 * 화면에서 아래와 같이 display 된다.  
 * 
 * [처음][이전] 1 2 3 4 5 6 7 8 [다음][마지막]
 * 
 * 클래스 변수들이 각 element와 다음과 같이 매핑이 된다.
 * firstPageLabel = [처음]
 * previousPageLabel = [이전]
 * currentPageLabel = 현재 페이지 번호
 * otherPageLabel = 현재 페이지를 제외한 페이지 번호
 * nextPageLabel = [다음]
 * lastPageLabel = [마지막]
 * </pre>
 * @author 실행환경 개발팀 함철
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.05.30  함철            최초 생성
 *
 * </pre>
 */
public class DefaultPaginationRenderer extends AbstractPaginationRenderer {

	public DefaultPaginationRenderer() {
		firstPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\"><img src=\"/images/first.gif\" alt=\"맨 처음 페이지\" /></a>\n";
		previousPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\"><img src=\"/images/p_prev.gif\" alt=\"이전 페이지\" /></a>\n";
		currentPageLabel = "<span class=\"on\"><a href=\"#\"><strong>{0}</strong></a></span>\n";
		otherPageLabel = "<span><a href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a></span>\n";
		nextPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\"><img src=\"/images/p_next.gif\" alt=\"다음 페이지\" /></a>\n";
		lastPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\"><img src=\"/images/last.gif\" alt=\"마지막 페이지\" /></a>\n";
//		firstPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\"><img src=\"/images/first.gif\" alt=\"맨 처음 페이지\" /></a>&#160;";
//		previousPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\"><img src=\"/images/p_prev.gif\" alt=\"이전 페이지\" /></a>&#160;";
//		currentPageLabel = "<span class=\"on\"><a href=\"#\"><strong>{0}</strong></a></span>&#160;";
//		otherPageLabel = "<span><a href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a></span>&#160;";
//		nextPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\"><img src=\"/images/p_next.gif\" alt=\"다음 페이지\" /></a>&#160;";
//		lastPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\"><img src=\"/images/last.gif\" alt=\"마지막 페이지\" /></a>&#160;";
	}

	@Override
	public String renderPagination(PaginationInfo paginationInfo, String jsFunction) {

		return super.renderPagination(paginationInfo, jsFunction);
	}

}