/*
 * @Package Name : com.dkitec.barocle.admin.status.rentStatus.service.Impl
 * @파일명          : RentStatusServiceImpl.java
 * @작성일          : 2015. 5. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 15.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.status.rentStatus.service.Impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.maintenance.repair.bike.service.RepairBikeMapper;
import com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeMapper;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO;
import com.dkitec.barocle.admin.status.rentStatus.service.RentStatusMapper;
import com.dkitec.barocle.admin.status.rentStatus.service.RentStatusService;
import com.dkitec.barocle.admin.status.rentStatus.vo.BikeRentalVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.property.EgovPropertyService;


/**
 * @파일명          : RentStatusServiceImpl.java
 * @작성일          : 2015. 5. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 15.   |   ymshin   |  최초작성
 */
@Service("rentStatusService")
public class RentStatusServiceImpl implements RentStatusService {

	@Autowired private RentStatusMapper rentStatusMapper;
	
	@Autowired private BikeMapper bikeMapper;
	
	@Resource(name = "propertiesService") private EgovPropertyService propertiesService;
	/**
	 * @location   : com.dkitec.barocle.admin.status.rentStatus.service.Impl.RentStatusService.getRentStatusAllCnt
	 * @writeDay   : 2015. 5. 15. 오후 5:09:17
	 * @overridden : @see com.dkitec.barocle.admin.status.rentStatus.service.RentStatusService#getRentStatusAllCnt(com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeRentalVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly = true)
	@DataSource(DataSourceType.SLAVE01)
	public int getRentStatusAllCnt(BikeRentalVO rentalVo) {
		// TODO Auto-generated method stub
		return rentStatusMapper.getRentStatusAllCnt(rentalVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.status.rentStatus.service.Impl.RentStatusService.getRentStatusList
	 * @writeDay   : 2015. 5. 15. 오후 5:09:17
	 * @overridden : @see com.dkitec.barocle.admin.status.rentStatus.service.RentStatusService#getRentStatusList(com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeRentalVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly = true)
	@DataSource(DataSourceType.SLAVE01)
	public List<CommonCodeVO> getRentStatusList(BikeRentalVO rentalVo) {
		// TODO Auto-generated method stub
		return rentStatusMapper.getRentStatusList(rentalVo);
	}

	@Override
	@Transactional(readOnly = true)
	@DataSource(DataSourceType.SLAVE01)
	public List<String> getSmsAllUsrMpnNo(BikeRentalVO rentalVo) {
		// TODO Auto-generated method stub
		return rentStatusMapper.getSmsAllUsrMpnNo(rentalVo);
	}

	@Override
	@Transactional(readOnly = true)
	@DataSource(DataSourceType.SLAVE01)
	public BikeRentalVO getRentStatusInfo(BikeRentalVO rentalVo) {
		// TODO Auto-generated method stub
		return rentStatusMapper.getRentStatusInfo(rentalVo);
	}

	@Override
	@Transactional(readOnly = true)
	@DataSource(DataSourceType.SLAVE01)
	public BikeRentalVO getCompulsionInfo(BikeRentalVO rentalVo) {
		// TODO Auto-generated method stub
		return  rentStatusMapper.getCompulsionInfo(rentalVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.status.rentStatus.service.Impl.RentStatusService.getCurrentRentData
	 * @writeDay   : 2015. 5. 27. 오후 1:33:58
	 * @overridden : @see com.dkitec.barocle.admin.status.rentStatus.service.RentStatusService#getCurrentRentData(com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly = true)
	@DataSource(DataSourceType.SLAVE01)
	public BikeRentalVO getCurrentRentData(BikeRentalVO bikeVo) {
		return rentStatusMapper.getCurrentRentData(bikeVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.status.rentStatus.service.Impl.RentStatusService.delCurrnetRentData
	 * @writeDay   : 2015. 7. 22. 오후 4:39:46
	 * @overridden : @see com.dkitec.barocle.admin.status.rentStatus.service.RentStatusService#delCurrnetRentData(com.dkitec.barocle.admin.status.rentStatus.vo.BikeRentalVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int delCurrnetRentData(BikeRentalVO rentalVo) {
		// TODO Auto-generated method stub
		return rentStatusMapper.delCurrnetRentData(rentalVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.status.rentStatus.service.Impl.RentStatusService.addRentHistory
	 * @writeDay   : 2015. 7. 22. 오후 4:41:30
	 * @overridden : @see com.dkitec.barocle.admin.status.rentStatus.service.RentStatusService#addRentHistory(com.dkitec.barocle.admin.status.rentStatus.vo.BikeRentalVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int exeImpulseBikeReturn(BikeRentalVO currentInfo) {
        int result = 0;
        result =  rentStatusMapper.addRentHistory(currentInfo);
        result =  rentStatusMapper.delCurrnetRentData(currentInfo);
        if(currentInfo.getOverFeeYn().equals("Y")){
        	result = rentStatusMapper.addOverFeeInfo(currentInfo);
        }
    	//4)자전거 상태 변경.->BKS_012
		BikeVO bikeVo = new BikeVO();
		bikeVo.setBikeId(currentInfo.getRentBikeId());
		bikeVo.setBikeStatusCd("BKS_012");
		bikeVo.setAdminId(currentInfo.getAdminId());
		result = bikeMapper.setBikeDevice(bikeVo);
		//강제 반납 테이블 입력
		result = rentStatusMapper.addExeImpulseReturnHistory(currentInfo);
		//파일입력
		float totFileSize = 0;
		if(currentInfo.getEnfrcFile() != null) {
		for(MultipartFile file : currentInfo.getEnfrcFile())
			totFileSize += file.getSize();
		}
		
		//펌웨어 파일 정보 INSERT
		Map<String,List<BikeRentalVO>> map = new HashMap<String,List<BikeRentalVO>>();
		List<BikeRentalVO> list = new ArrayList<BikeRentalVO>();
		BikeRentalVO bikeRentalFileVO = null;
		MultipartFile file = null;
		int index = 0;
		String fileExt = "";
		//파일 업로드 경로 prefix
		String prefix = System.getProperty("os.name").toLowerCase().indexOf("win") >= 0 ? "d:/" : "";
		//int cntt = currentInfo.getFirmwareFile().size();
		double fileSize=0.0;
		try {
			if(currentInfo.getEnfrcFile() != null) {
				for(int i=0;i<currentInfo.getEnfrcFile().size();i++) {
					file = currentInfo.getEnfrcFile().get(i);
		
					if(file.getSize() > 0.0) {
						bikeRentalFileVO = new BikeRentalVO();
						//bikeRentalFileVO.setFirmwareSeq("" + interworkMgmtVO.getFirmware_seq());
						bikeRentalFileVO.setEnfrcReturnHistSeq(currentInfo.getEnfrcReturnHistSeq());
						bikeRentalFileVO.setRentBikeId(currentInfo.getRentBikeId());
						bikeRentalFileVO.setEnfrcFileNo(currentInfo.getEnfrcFileNoList().get(i));
						index = file.getOriginalFilename().lastIndexOf(".");
				    	fileExt = file.getOriginalFilename().substring(index + 1);
				    	bikeRentalFileVO.setFileName("enfrcimg"+"_"+ currentInfo.getEnfrcReturnHistSeq() +"_"+bikeRentalFileVO.getEnfrcFileNo()+"."+fileExt);
						bikeRentalFileVO.setFileOriName(file.getOriginalFilename());
						bikeRentalFileVO.setFileSavePath(prefix + propertiesService.getString("fileUploadDir") + 
								File.separator + "exeImpulseBike");
						bikeRentalFileVO.setFileSize((float)file.getSize() / 1024 / 1024);
						bikeRentalFileVO.setFileByte(file.getBytes());
						
						//물리 파일 저장
						insertPhysicalEnfrcFile(bikeRentalFileVO);
						
						bikeRentalFileVO.setFileSavePath(prefix + propertiesService.getString("ctnDaumURL") + 
								File.separator + "exeImpulseBike");
						//물리 파일 저장 후 파일 불러올 경로로 변경
						
						list.add(bikeRentalFileVO);
					}
					
				}
				map.put("list", list);
				if(list.size() > 0) {
					result = rentStatusMapper.insertEnfrcFileList(map);
				}
			}
			
		} catch(IOException e) {
			throw new CfoodException("");
		}
		
		
		return result;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.status.rentStatus.service.Impl.RentStatusService.getOverFeePolicy
	 * @writeDay   : 2015. 7. 22. 오후 5:05:18
	 * @overridden : @see com.dkitec.barocle.admin.status.rentStatus.service.RentStatusService#getOverFeePolicy(java.util.Map)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly = true)
	@DataSource(DataSourceType.SLAVE01)
	public Map<String, Object> getOverFeePolicy(Map<String, Object> fee) {
		// TODO Auto-generated method stub
		return rentStatusMapper.getOverFeePolicy(fee);
	}

	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int setRentTempPwSend(BikeRentalVO rentalVo) {
		// TODO Auto-generated method stub
		return rentStatusMapper.setRentTempPwSend(rentalVo);
	}

	@Override
	@Transactional(readOnly = true)
	@DataSource(DataSourceType.SLAVE01)
	public List<BikeRentalVO> getExeImpulseReturnList(BikeRentalVO rentalVo) {
		// TODO Auto-generated method stub
		return rentStatusMapper.getExeImpulseReturnList(rentalVo);
	}
	
	@Override
	@Transactional(readOnly = true)
	@DataSource(DataSourceType.SLAVE01)
	public int getExeImpulseReturnListCnt(BikeRentalVO rentalVo) {
		// TODO Auto-generated method stub
		return rentStatusMapper.getExeImpulseReturnListCnt(rentalVo);
	}
	
	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int compExeImpulseProc(BikeRentalVO currentInfo) {
        int result = 0;
        result =  rentStatusMapper.compExeImpulseProc(currentInfo);
        
		return result;
	}
	
	@Override
	@Transactional(readOnly = true)
	@DataSource(DataSourceType.SLAVE01)
	public BikeRentalVO getExeImpulseCntInfo(BikeRentalVO rentalVo) {
		// TODO Auto-generated method stub
		return rentStatusMapper.getExeImpulseCntInfo(rentalVo);
	}
	
	@Override
	@Transactional(readOnly = true)
	@DataSource(DataSourceType.SLAVE01)
	public BikeRentalVO getExeImpulseReturnInfo(BikeRentalVO rentalVo) {
		// TODO Auto-generated method stub
		return rentStatusMapper.getExeImpulseReturnInfo(rentalVo);
	}
	
	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int updateExeImpulseProc(BikeRentalVO currentInfo) {
        int result = 0;
        result =  rentStatusMapper.updateExeImpulseProc(currentInfo);
        
    	//파일입력
		float totFileSize = 0;
		if(currentInfo.getEnfrcFile() != null) {
		for(MultipartFile file : currentInfo.getEnfrcFile())
			totFileSize += file.getSize();
		}
		
		
		//펌웨어 파일 정보 INSERT
				Map<String,List<BikeRentalVO>> map = new HashMap<String,List<BikeRentalVO>>();
				List<BikeRentalVO> list = new ArrayList<BikeRentalVO>();
				BikeRentalVO bikeRentalFileVO = null;
				MultipartFile file = null;
				int index = 0;
				String fileExt = "";
				//파일 업로드 경로 prefix
				String prefix = System.getProperty("os.name").toLowerCase().indexOf("win") >= 0 ? "d:/" : "";
				//int cntt = currentInfo.getFirmwareFile().size();
				
				System.out.println("####prefix = "+prefix);
				double fileSize=0.0;
				try {
					if(currentInfo.getEnfrcFile() != null) {
						for(int i=0;i<currentInfo.getEnfrcFile().size();i++) {
							file = currentInfo.getEnfrcFile().get(i);
							System.out.println("####file.getsize = "+file.getSize());
							if(file.getSize() > 0.0) {
								System.out.println("###file.getsize 진입");
								bikeRentalFileVO = new BikeRentalVO();
								//bikeRentalFileVO.setFirmwareSeq("" + interworkMgmtVO.getFirmware_seq());
								bikeRentalFileVO.setEnfrcReturnHistSeq(currentInfo.getEnfrcReturnHistSeq());
								bikeRentalFileVO.setRentBikeId(currentInfo.getRentBikeId());
								bikeRentalFileVO.setEnfrcFileNo(currentInfo.getEnfrcFileNoList().get(i));
								index = file.getOriginalFilename().lastIndexOf(".");
						    	fileExt = file.getOriginalFilename().substring(index + 1);
						    	bikeRentalFileVO.setFileName("enfrcimg"+"_"+ currentInfo.getEnfrcReturnHistSeq() +"_"+bikeRentalFileVO.getEnfrcFileNo()+"."+fileExt);
								bikeRentalFileVO.setFileOriName(file.getOriginalFilename());
								bikeRentalFileVO.setFileSavePath(prefix + propertiesService.getString("fileUploadDir") + 
										File.separator + "exeImpulseBike");
								bikeRentalFileVO.setFileSize((float)file.getSize() / 1024 / 1024);
								bikeRentalFileVO.setFileByte(file.getBytes());
								
								//물리 파일 저장
								insertPhysicalEnfrcFile(bikeRentalFileVO);
								
								bikeRentalFileVO.setFileSavePath(prefix + propertiesService.getString("ctnDaumURL") + 
										File.separator + "exeImpulseBike");
								//물리 파일 저장 후 파일 불러올 경로로 변경
								
							   int fileChk = rentStatusMapper.chkEnfrcFile(bikeRentalFileVO);
							   if(fileChk > 0) { //기존 등록 이미지 있을시 
							 	  rentStatusMapper.updateEnfrcFile(bikeRentalFileVO);
							   } else { //없을시
								  list.add(bikeRentalFileVO);
							   }
							}
							
						}
						map.put("list", list);
						if(list.size() > 0) {
							//System.out.println("list.size() "+list.size());
							result = rentStatusMapper.insertEnfrcFileList(map);
						}
					}
					
				} catch(IOException e) {
					throw new CfoodException("");
				}
        
        
        
        
		return result;
	}
	
	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int exeBikeParkingLoication(BikeRentalVO currentInfo) {
        int result = 0;
        
        //강제 반납 테이블 입력, 임의장소 반납 요청
      	result = rentStatusMapper.addExeImpulseReturnHistory(currentInfo);
        //파일
        /*Map<String,List<BikeRentalVO>> map = new HashMap<String,List<BikeRentalVO>>();
        List<BikeRentalVO> list = new ArrayList<BikeRentalVO>();
		BikeRentalVO bikeRentalFileVO = null;
		MultipartFile file = null;
		int index = 0;
		String fileExt = "";
		//파일 업로드 경로 prefix
		String prefix = System.getProperty("os.name").toLowerCase().indexOf("win") >= 0 ? "d:/" : "";
		//int cntt = currentInfo.getFirmwareFile().size();
		double fileSize=0.0;
		try {
			if(currentInfo.getEnfrcFile() != null)
			for(int i=0;i<currentInfo.getEnfrcFile().size();i++) {
				file = currentInfo.getEnfrcFile().get(i);
	
				if(file.getSize() > 0.0) {
					bikeRentalFileVO = new BikeRentalVO();
					//bikeRentalFileVO.setFirmwareSeq("" + interworkMgmtVO.getFirmware_seq());
					bikeRentalFileVO.setEnfrcReturnHistSeq(currentInfo.getEnfrcReturnHistSeq());
					bikeRentalFileVO.setRentBikeId(currentInfo.getRentBikeId());
					bikeRentalFileVO.setEnfrcFileNo(currentInfo.getEnfrcFileNoList().get(i));
					index = file.getOriginalFilename().lastIndexOf(".");
			    	fileExt = file.getOriginalFilename().substring(index + 1);
			    	bikeRentalFileVO.setFileName("enfrcimg"+"_"+ currentInfo.getEnfrcReturnHistSeq() +"_"+bikeRentalFileVO.getEnfrcFileNo()+"."+fileExt);
					bikeRentalFileVO.setFileOriName(file.getOriginalFilename());
					bikeRentalFileVO.setFileSavePath(prefix + propertiesService.getString("fileUploadDir") + 
							File.separator + "exeImpulseBike");
					bikeRentalFileVO.setFileSize((float)file.getSize() / 1024 / 1024);
					bikeRentalFileVO.setFileByte(file.getBytes());
					
					insertPhysicalEnfrcFile(bikeRentalFileVO);
					
					bikeRentalFileVO.setFileSavePath(prefix + propertiesService.getString("ctnDaumURL") + 
							File.separator + "exeImpulseBike");
					//물리 파일 저장 후 파일 불러올 경로로 변경
					
					list.add(bikeRentalFileVO);
					
					//물리 파일 저장
				}
				
			}
			
			map.put("list", list);
			result = rentStatusMapper.insertEnfrcFileList(map);
			
		} catch(IOException e) {
			throw new CfoodException("");
		}*/
      //파일입력
      float totFileSize = 0;
      if(currentInfo.getEnfrcFile() != null) {
    	  for(MultipartFile file : currentInfo.getEnfrcFile())
      		totFileSize += file.getSize();
      }
      		
      //펌웨어 파일 정보 INSERT
      Map<String,List<BikeRentalVO>> map = new HashMap<String,List<BikeRentalVO>>();
      List<BikeRentalVO> list = new ArrayList<BikeRentalVO>();
      BikeRentalVO bikeRentalFileVO = null;
      MultipartFile file = null;
      int index = 0;
      String fileExt = "";
      //파일 업로드 경로 prefix
      String prefix = System.getProperty("os.name").toLowerCase().indexOf("win") >= 0 ? "d:/" : "";
      //int cntt = currentInfo.getFirmwareFile().size();
      double fileSize=0.0;
      try {
    	  if(currentInfo.getEnfrcFile() != null) {
    		  	for(int i=0;i<currentInfo.getEnfrcFile().size();i++) {
      				file = currentInfo.getEnfrcFile().get(i);
      				
      				if(file.getSize() > 0.0) {
      					bikeRentalFileVO = new BikeRentalVO();
      					//bikeRentalFileVO.setFirmwareSeq("" + interworkMgmtVO.getFirmware_seq());
      					bikeRentalFileVO.setEnfrcReturnHistSeq(currentInfo.getEnfrcReturnHistSeq());
      					bikeRentalFileVO.setRentBikeId(currentInfo.getRentBikeId());
      					bikeRentalFileVO.setEnfrcFileNo(currentInfo.getEnfrcFileNoList().get(i));
      					index = file.getOriginalFilename().lastIndexOf(".");
      					fileExt = file.getOriginalFilename().substring(index + 1);
      					bikeRentalFileVO.setFileName("enfrcimg"+"_"+ currentInfo.getEnfrcReturnHistSeq() +"_"+bikeRentalFileVO.getEnfrcFileNo()+"."+fileExt);
      					bikeRentalFileVO.setFileOriName(file.getOriginalFilename());
      					bikeRentalFileVO.setFileSavePath(prefix + propertiesService.getString("fileUploadDir") + 
      						File.separator + "exeImpulseBike");
      					bikeRentalFileVO.setFileSize((float)file.getSize() / 1024 / 1024);
      					bikeRentalFileVO.setFileByte(file.getBytes());
      								
      					//물리 파일 저장
      					insertPhysicalEnfrcFile(bikeRentalFileVO);
      								
      					bikeRentalFileVO.setFileSavePath(prefix + propertiesService.getString("ctnDaumURL") + 
      						File.separator + "exeImpulseBike");
      					//물리 파일 저장 후 파일 불러올 경로로 변경
      							
      					list.add(bikeRentalFileVO);
      					}
      							
      			}
      			map.put("list", list);
      			if(list.size() > 0) {
      				result = rentStatusMapper.insertEnfrcFileList(map);
      			}
      		}
      					
      	} catch(IOException e) {
      		throw new CfoodException("");
      	}
		
		return result;
	}
	
	@Override
	public void insertPhysicalEnfrcFile(BikeRentalVO rentalVo) throws IOException {
		
		File fileSavePath = new File(rentalVo.getFileSavePath());
		
		if(!fileSavePath.exists())
			fileSavePath.mkdirs();
		
		File f = new File(fileSavePath.getAbsolutePath()  + File.separator + rentalVo.getFileName());
		
		FileOutputStream fos = new FileOutputStream(f);
		
		fos.write(rentalVo.getFileByte());
		fos.close();
	}
	
	@Override
	@Transactional(readOnly = true)
	@DataSource(DataSourceType.SLAVE01)
	public BikeRentalVO getEnfrcViewInfo(BikeRentalVO bikeVo) {
		// TODO Auto-generated method stub
		return rentStatusMapper.getEnfrcViewInfo(bikeVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<BikeRentalVO> listEnfrcFile(BikeRentalVO rentalVo) {
		return rentStatusMapper.listEnfrcFile(rentalVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public void checkEnfrc(BikeRentalVO rentalVo) {
		String bike_status = "";
		bike_status= rentStatusMapper.checkBikeStatus(rentalVo);
		String enfrcReturnHistSeq = "";
		int result = 0;
		if(bike_status.equals("BKS_012")){
			// 자전거 강제반납 상태이므로 강제반납 신고 확인 및 처리
			enfrcReturnHistSeq = rentStatusMapper.checkEnfrcInfo(rentalVo);
			if(enfrcReturnHistSeq != null && enfrcReturnHistSeq != ""){	
				// 강제반납 신고 내역이 있으므로 완료 처리
				rentalVo.setEnfrcReturnHistSeq(enfrcReturnHistSeq);
				rentalVo.setComptCd("4");
				result = rentStatusMapper.compExeImpulseProc(rentalVo);
			}
		}
	}

	@Override
	public String getTeamName(BikeRentalVO rentVo) {
		// TODO Auto-generated method stub
		return rentStatusMapper.getTeamName(rentVo);
	}

	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int addBikeRobbedHistory(BikeRentalVO rentalVo) {
		int result = 0;
		BikeVO bikeVo = new BikeVO();
		bikeVo.setBikeId(rentalVo.getRentBikeId());
		bikeVo.setBikeStatusCd("BKS_016"); //도난추정
		bikeVo.setAdminId(rentalVo.getAdminId());
		bikeVo.setLostYn("Y");
		// result = bikeMapper.setBikeDevice(bikeVo); //자전거상태 변경
		result = rentStatusMapper.addBikeRobbedHistory(rentalVo);
		return result;
	}

	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int addBikeRtrvlHistory(BikeRentalVO rentalVo) {
		int result = 0;
		BikeVO bikeVo = new BikeVO();
		bikeVo.setBikeId(rentalVo.getRentBikeId());
		bikeVo.setBikeStatusCd("BKS_017"); //회수
		bikeVo.setAdminId(rentalVo.getAdminId());
		result = bikeMapper.setBikeDevice(bikeVo); //자전거상태 변경
		result = rentStatusMapper.addBikeRtrvlHistory(rentalVo);
		return result;
		
	}

	@Override
	public BikeRentalVO getSearchBikeNo(BikeRentalVO rentalVo) {
		// TODO Auto-generated method stub
		return rentStatusMapper.getSearchBikeNo(rentalVo);
	}
	
	@Override
	@Transactional(readOnly = true)
	@DataSource(DataSourceType.SLAVE01)
	public BikeRentalVO getBikeMapInfo(BikeRentalVO rentalVo) {
		// TODO Auto-generated method stub
		return rentStatusMapper.getBikeMapInfo(rentalVo);
	}
	
	@Override
	@DataSource(DataSourceType.MASTER)
	public int insertParkingInfo(BikeRentalVO rentalVo)  {
		// TODO Auto-generated method stub
		return rentStatusMapper.insertParkingInfo(rentalVo);
	}
	
	@Override
	@DataSource(DataSourceType.MASTER)
	public int updateBikeStatus(BikeRentalVO rentalVo)  {
		// TODO Auto-generated method stub
		
		return rentStatusMapper.updateBikeStatus(rentalVo);
	}
}
