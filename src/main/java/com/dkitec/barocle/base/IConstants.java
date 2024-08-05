package com.dkitec.barocle.base;

public interface IConstants {
	
	public static final String ERROR_PAGE = "/common/error";
	public static final String ERROR_PAGE_ALL = "/barocle-admin/error.jsp";
	public static final String JSONVIEW = "JSONView";
	public static final String EXCELVIEW = "ExcelView";
	
	public static final String DEVICE_BIKE     = "DEV_001";
	public static final String DEVICE_TERMINAL = "DEV_002";
	public static final String DEVICE_AP       = "DEV_003";
	public static final String DEVICE_ARM      = "DEV_004";
	public static final String STOCK_PART      =  "STOCK";
	public static final String COUNSEL_LIST      =  "COUNSEL";
	public static final String DEVICE_MODEL_CD_AP = "DM1";
	public static final String DEVICE_MODEL_CD_TERMINAL = "DM2";
	
	
	public static final String Y = "Y";
	public static final String N = "N";
	
	public static final String LANG_KR = "LAG_001";
	public static final String LANG_EN = "LAG_002";
	public static final String LANG_JA = "LAG_003";
	public static final String LANG_ZH = "LAG_004";
	
	/**
	 * 게시판 로직 모드
	 * edit 수정 페이지로 이동
	 * modify 수정된 내용을  db에 등록
	 */
	public static final String MODE			=	"mode";		// mode
	public static final String MODE_LIST	=	"list";		// list page
	public static final String MODE_VIEW	=	"view";		// view page
	public static final String MODE_WRITE	=	"write";	// write page
	public static final String MODE_EDIT	=	"edit";		// edit page
	public static final String MODE_INSERT	=	"insert";	// insert
	public static final String MODE_UPDATE	=	"update";	// modify
	public static final String MODE_DELETE	=	"delete";	// delete
	public static final String MODE_COMMENT	=	"comment";	// replay
	public static final String MODE_REPLY	=	"reply";	// replay
	public static final String MODE_EXCEL	=	"excel";	// replay
	
	public static final String ERROR = "error";
	public static final String OK = "ok";
	public static final String OK_CODE = "20010000";
	
	public static final String RESULT = "result";
	public static final String RESULT_MESSAGE = "resultMessage";
	public static final String RESULTMSG = "resultMessage";
	public static final String RESULT_TYPE = "resultType";
	
	public static final String CHECK_RESULT = "checkResult";
	
	/**
	 * 날짜형식("yyyy-MM-dd")
	 */
	public static final String DATE_FORMAT = "yyyy-MM-dd";
	
	/**
	 * 작업 CRUD 구분 코드
	 */
	public static final String CRUD_C = "C";	
	public static final String CRUD_R = "R";
	public static final String CRUD_U = "U";
	public static final String CRUD_D = "D";
	
	/**
	 * 일괄등록 엑셀 구분 코드
	 * 
	 * */
	public static final String EXCEL_AP = "ap";
	public static final String EXCEL_BIKE = "bike";
	public static final String EXCEL_TERMINAL = "terminal";
	public static final String EXCEL_ARM = "arm";
	
	public static final String DEVICE_FW = "FWD_001";  	
	public static final String IMG_FW    = "FWD_002";  	
	public static final String VOICE_FW  = "FWD_003";  	
	
	/**
	 * 권한 구분 코드
	 */
	public static final String USER_GROUP 			= "UG"; //권한 구분 상위코드
//	
//	public static final String USER_GROUP_ALL 		= "UGA"; //관리자
//	public static final String USER_GROUP_MANAGE 	= "UGM"; //사업팀
//	public static final String USER_GROUP_SERVICE 	= "UGS"; //파트너사
//	
//	public static Map<String, String> USER_GROUP_MAP() {
//		Map<String, String> map = new LinkedHashMap<String, String>();
//		map.put(USER_GROUP_ALL, "관리자");
//		map.put(USER_GROUP_MANAGE, "사업팀");
//		map.put(USER_GROUP_SERVICE, "파트너사");
//		return map;
//	}
	
	
	/**
	 * 조회 구분 코드
	 */
	public static final String READ_AUTH 			= "RA"; //조회 구분 상위코드
	
	public static final String READ_AUTH_ALL 		= "RAA"; //관리자
	public static final String READ_AUTH_MANAGE 	= "RAM"; //사업팀
	public static final String READ_AUTH_SERVICE 	= "RAS"; //파트너사
	
	public static final String COMM_STA 			= "STATION"; //조회 구분 상위코드
	/**
	 * 서비스 정책 구분 코드
	 */
	public static final String POLICY_TYPE 				= "PT"; //서비스 정책 구분 상위코드
	
	public static final String POLICY_TYPE_BASIC 		= "PTB"; //기본
	public static final String POLICY_TYPE_EXCEPTION 	= "PTE"; //예외
	public static final String POLICY_TYPE_SPECIAL 		= "PTS"; //특판
	public static final String POLICY_TYPE_PURCHASE 	= "PTP"; //구매
	
	/**
	 * 에러코드 상위 코드
	 */
	public static final String EXCEPTION_CODE = "E";
	
	
	/**
	 * 구분코드 접두사
	 */
	public static final String PREFIX_SPECIAL 		= "P"; //특판
	public static final String PREFIX_PURCHASE 		= "L"; //구매
	
	/**
	 * 서비스 인증 비밀번호 접두사
	 */
	public static final String SERVICE_PWD_PREFIX	= "S";
//	public static final String  = "";
	
	
	/**
	 * 사용 여부
	 */
	public static final String USE_Y = "Y"; //사용
	public static final String USE_N = "N"; //미사용
	
	/**
	 * 높은숫자
	 */
	public static final int LIMIT_SIZE = 99999999;	//콤보에 노페이징 데이터 뿌릴때
	
	
	/**
	 * 특판 정책 유형 코드
	 */
	public static final String SPECIAL_POLICY_TYPE 		= "SPT"; //특판 정책 유형 상위코드
	public static final String SPECIAL_POLICY_TYPE_A 	= "SPTA"; //지정요금제
	public static final String SPECIAL_POLICY_TYPE_B 	= "SPTB"; //지정 他 부가서비스
	public static final String SPECIAL_POLICY_TYPE_C 	= "SPTC"; //부가서비스
	public static final String SPECIAL_POLICY_TYPE_D 	= "SPTD"; //무료체험

	/**
	 * 무료체험 코드
	 */
	public static final String FREE_EXPERIENCE 				= "FR"; //무료체험 상위코드
	
	/**
	 * 지정요금제 코드
	 */
	public static final String TARGET_CHARGE 				= "CH"; //지정요금제 상위코드
	
	/**
	 * 통신사 코드
	 */
	public static final String TELECOM_CODE 		= "TC"; //통신사 코드
	public static final String TELECOM_CODE_LG 		= "TCLG"; //LG
	public static final String TELECOM_CODE_SK 		= "TCSK"; //SK
	public static final String TELECOM_CODE_KT 		= "TCKT"; //KT
	public static final String TELECOM_CODE_ANY 	= "TCANY"; //ANY
	
	
	/**
	 * UPLUS 서비스
	 */
	
	public static final String UPLUS_SERVICE_ID 		= "LGUPLUS"; // UPLUS 서비스
	public static final String UPLUS_SERVICE_NAME 		= "LGU+"; // UPLUS 서비스명
	
	
	/**
	 * 기본 등록 정책
	 */
	public static final String applyEndDate = "9999-12-31";
	
	/**
	 * 그룹별 메인페이지
	 */
	public static final String MAIN_PAGE_RAA = "MAIN_PAGE_RAA";
	public static final String MAIN_PAGE_RAM = "MAIN_PAGE_RAM"; 
	public static final String MAIN_PAGE_RAS = "MAIN_PAGE_RAS";
			
	/**
	 * 검색 구분: 일별, 월별
	 */
	public static final String SEARCH_DAY   = "D";
	public static final String SEARCH_MONTH = "M";
	
	
	
	
	/**
	 * 통계 선택 구분
	 */
	public static final String STA_TYPE_TELECOM 	= "T";
	public static final String STA_TYPE_DEVICE 		= "D";
	public static final String STA_TYPE_OS 			= "O";
	public static final String STA_TYPE_CONNECT 	= "C";
	
	
	/**
	 * 그룹 코드 : 상위 코드
	 */
	public static final String USR_GROUP_CODE = "UG";
	
	
	/**
	 * 로그인 비밀번호 실패 시도 제한 횟수
	 */
	public static final int LOGIN_FAIL_CNT = 5;
	
	public static final String PREFIX_BIKE_NO = "BRC";
	
	
	/*
	 * 자전거 인증제 감면 shoh2999
	 */
	public static final String CERT_DIS_START_MSG_TITLE = "인증제감면자격 개시";
	public static final String CERT_DIS_START_MSG = "안녕하십니까? 귀하께서는 아파트 자전거 교통안전교육 인증제(중급)에 합격함에 따라 금일부터 2년간 바로클 이용요금을 일부 감면받을 수 있습니다. (일일권 30%, 정기권 15%)\n" + 
			"감면적용 기간은 바로클앱 > 내정보 메뉴에서도 확인 가능합니다. 감사합니다.";
	
	public static final String CERT_DIS_END_MSG_TITLE = "인증제감면자격 종료";
	public static final String CERT_DIS_END_MSG = "안녕하십니까? 아파트 자전거 교통안전교육 인증제 합격에 따른 바로클 이용요금 감면 적용이 내일 자정(24:00) 종료될 예정이오니 이용에 참고 바랍니다. 감사합니다.";
	
}
