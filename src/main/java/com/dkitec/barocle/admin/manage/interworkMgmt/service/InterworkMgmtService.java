package com.dkitec.barocle.admin.manage.interworkMgmt.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.dkitec.barocle.admin.manage.interworkMgmt.vo.InterworkMgmtVO;

public interface InterworkMgmtService {

	
	/**
	 * @Todo 		: 임계치 관리 리스트
	 * @Date 		: 2015. 5. 20.
	 * @Return		: List<InterworkMgmtVO>
	 */
	public List<InterworkMgmtVO> listCritical();
	
	/**
	 * @Todo 		: 임계치 업데이트
	 * @Date 		: 2015. 5. 20.
	 * @Return		: int
	 */
	public int modCritical(InterworkMgmtVO interworkMgmtVO);
	
	/**
	 * @Todo 		: 펌웨어 리스트
	 * @Date 		: 2015. 5. 20.
	 * @Return		: List<InterworkMgmtVO>
	 */
	public List<InterworkMgmtVO> listFirmware(InterworkMgmtVO interworkMgmtVO);
	
	/**
	 * @Todo 		: 펌웨어 리스트 카운트
	 * @Date 		: 2015. 5. 20.
	 * @Return		: int
	 */
	public int listFirmwareCount(InterworkMgmtVO interworkMgmtVO);
	
	/**
	 * @Todo 		: 펌웨어 업데이트 결과 리스트
	 * @Date 		: 2015. 5. 20.
	 * @Return		: List<InterworkMgmtVO>
	 */
	public List<InterworkMgmtVO> listFirmwareUpdateResult(InterworkMgmtVO interworkMgmtVO);
	
	/**
	 * @Todo 		: 펌웨어 업데이트 결과 리스트 카운트
	 * @Date 		: 2015. 5. 20.
	 * @Return		: int
	 */
	public int listFirmwareUpdateResultCount(InterworkMgmtVO interworkMgmtVO);
	
	/**
	 * @Todo 		: 펌웨어 정보
	 * @Date 		: 2015. 5. 20.
	 * @Return		: InterworkMgmtVO
	 */
	public InterworkMgmtVO getFirmware(InterworkMgmtVO interworkMgmtVO);
	
	/**
	 * @Todo 		: 펌웨어 파일 리스트
	 * @Date 		: 2015. 5. 20.
	 * @Return		: List<InterworkMgmtVO>
	 */
	public List<InterworkMgmtVO> listFirmwareFile(InterworkMgmtVO interworkMgmtVO);
	
	/**
	 * @Todo 		: 펌웨어 업데이트 시작 여부
	 * @Date 		: 2015. 6. 2.
	 * @Return		: boolean 
	 */
	public boolean updateStartYn(InterworkMgmtVO interworkMgmtVO);
	
	/**
	 * @Todo 		: 펌웨어 파일 등록
	 * @Date 		: 2015. 5. 20.
	 * @Return		: void
	 */
	public boolean insertFirmwareFile(InterworkMgmtVO interworkMgmtVO);
	public void insertPhysicalFirmwareFile(InterworkMgmtVO interworkMgmtVO) throws IOException;
	
	/**
	 * @Todo 		: 펌웨어 정보 수정
	 * @Date 		: 2015. 5. 20.
	 * @Return		: void
	 */
	public boolean modFirmware(InterworkMgmtVO interworkMgmtVO);
	/**
	 * @Todo 		: 펌웨어 파일 삭제
	 * @Date 		: 2015. 5. 20.
	 * @Return		: boolean 
	 */
	public boolean delFirmwareFile(InterworkMgmtVO interworkMgmtVO);
	public boolean delPhysicalFirmwareFile(InterworkMgmtVO interworkMgmtVO) throws IOException;
	
	/**
	 * @Todo 		: 펌웨어 정보 삭제
	 * @Date 		: 2015. 5. 20.
	 * @Return		: int 
	 */
	public boolean delFirmware(InterworkMgmtVO interworkMgmtVO);
	
	/**
	 * @Todo 		: 펌웨어 버전 체크
	 * @Date 		: 2015. 5. 28.
	 * @Return		: boolean 
	 */
	public boolean chkFirmwareVer(InterworkMgmtVO interworkMgmtVO);
}
