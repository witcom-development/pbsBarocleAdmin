package com.dkitec.barocle.admin.manage.interworkMgmt.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.manage.interworkMgmt.service.InterworkMgmtMapper;
import com.dkitec.barocle.admin.manage.interworkMgmt.service.InterworkMgmtService;
import com.dkitec.barocle.admin.manage.interworkMgmt.vo.InterworkMgmtVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("interworkMgmtService")
public class InterworkMgmtServiceImpl extends EgovAbstractServiceImpl implements InterworkMgmtService {

	@Autowired private InterworkMgmtMapper interworkMgmtMapper;
	
	@Resource(name = "propertiesService") private EgovPropertyService propertiesService;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<InterworkMgmtVO> listCritical() {
		return interworkMgmtMapper.listCritical();
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int modCritical(InterworkMgmtVO interworkMgmtVO) {
		return interworkMgmtMapper.modCritical(interworkMgmtVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<InterworkMgmtVO> listFirmware(InterworkMgmtVO interworkMgmtVO) {
		return interworkMgmtMapper.listFirmware(interworkMgmtVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int listFirmwareCount(InterworkMgmtVO interworkMgmtVO) {
		return interworkMgmtMapper.listFirmwareCount(interworkMgmtVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<InterworkMgmtVO> listFirmwareUpdateResult(InterworkMgmtVO interworkMgmtVO) {
		return interworkMgmtMapper.listFirmwareUpdateResult(interworkMgmtVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int listFirmwareUpdateResultCount(InterworkMgmtVO interworkMgmtVO) {
		return interworkMgmtMapper.listFirmwareUpdateResultCount(interworkMgmtVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public InterworkMgmtVO getFirmware(InterworkMgmtVO interworkMgmtVO) {
		return interworkMgmtMapper.getFirmware(interworkMgmtVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<InterworkMgmtVO> listFirmwareFile(InterworkMgmtVO interworkMgmtVO) {
		return interworkMgmtMapper.listFirmwareFile(interworkMgmtVO);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public boolean updateStartYn(InterworkMgmtVO interworkMgmtVO) {
		return interworkMgmtMapper.updateStartYn(interworkMgmtVO) > 0 ? true: false;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public boolean insertFirmwareFile(InterworkMgmtVO interworkMgmtVO) {
		
		//펌웨어 파일 사이즈 SUM
		float totFileSize = 0;
		for(MultipartFile file : interworkMgmtVO.getFirmwareFile())
			totFileSize += file.getSize();
		
		interworkMgmtVO.setBinSize(totFileSize / 1024 / 1024);
		
		//펌웨어 정보 INSERT
		interworkMgmtMapper.insertFirmware(interworkMgmtVO);
		
		//펌웨어 파일 정보 INSERT
		Map<String,List<InterworkMgmtVO>> map = new HashMap<String,List<InterworkMgmtVO>>();
		List<InterworkMgmtVO> list = new ArrayList<InterworkMgmtVO>();
		InterworkMgmtVO interworkFileMgmtVO = null;
		MultipartFile file = null;
		
		//파일 업로드 경로 prefix
		String prefix = System.getProperty("os.name").toLowerCase().indexOf("win") >= 0 ? "d:/" : "";
		
		try {
			for(int i=0;i<interworkMgmtVO.getFirmwareFile().size();i++) {
				file = interworkMgmtVO.getFirmwareFile().get(i);
	
				interworkFileMgmtVO = new InterworkMgmtVO();
				interworkFileMgmtVO.setFirmwareSeq("" + interworkMgmtVO.getFirmware_seq());
				interworkFileMgmtVO.setFirmwareFileNo(interworkMgmtVO.getFirmwareFileNoList().get(i));
				interworkFileMgmtVO.setFileName(file.getOriginalFilename());
				interworkFileMgmtVO.setFileSavePath(prefix + propertiesService.getString("fwUploadDir") + 
						File.separator + interworkMgmtVO.getFirmwareClsCd() + File.separator + interworkMgmtVO.getFirmware_seq());
				interworkFileMgmtVO.setFileSize((float)file.getSize() / 1024 / 1024);
				interworkFileMgmtVO.setFileByte(file.getBytes());
				interworkFileMgmtVO.setCompanyCd(interworkMgmtVO.getCompanyCd());
				
				list.add(interworkFileMgmtVO);
				
				//물리 파일 저장
				insertPhysicalFirmwareFile(interworkFileMgmtVO);
			}
		} catch(IOException e) {
			throw new CfoodException("");
		}
		
		map.put("list", list);
		
		return interworkMgmtMapper.insertFirmwareFileList(map) > 0 ? true : false;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public boolean delFirmwareFile(InterworkMgmtVO interworkMgmtVO) {
		
		boolean rst = interworkMgmtMapper.delFirmwareFile(interworkMgmtVO) > 0 ? true : false;
		
		//물리 파일 삭제 & 펌웨어 사이즈 업데이트
		if(rst) {
			try {
				delPhysicalFirmwareFile(interworkMgmtVO);
			} catch(IOException e) {
				throw new CfoodException("", e);
			}
			interworkMgmtMapper.modFirmwareBinSize(interworkMgmtVO.getFirmwareSeq());
		}
		
		return rst;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public boolean modFirmware(InterworkMgmtVO interworkMgmtVO) {

		//펌웨어 정보 업데이트
		boolean rst = interworkMgmtMapper.modFirmware(interworkMgmtVO) > 0 ? true : false;
		
		if(rst) {
			try {
				//펌웨어 파일 정보 업데이트
				InterworkMgmtVO interworkFileMgmtVO = null;
				MultipartFile file = null;
				
				//파일 업로드 경로 prefix
				String prefix = System.getProperty("os.name").toLowerCase().indexOf("win") >= 0 ? "d:/" : "";
				
				if(interworkMgmtVO.getFirmwareFile() != null) {
					for(int i=0;i<interworkMgmtVO.getFirmwareFile().size();i++) {
						
						file = interworkMgmtVO.getFirmwareFile().get(i);
						if(!file.isEmpty()) {
							
							interworkFileMgmtVO = new InterworkMgmtVO();
							
							interworkFileMgmtVO.setFirmwareSeq(interworkMgmtVO.getFirmwareSeq());
		
							interworkFileMgmtVO.setFirmwareFileNo(interworkMgmtVO.getFirmwareFileNoList().get(i));
							interworkFileMgmtVO.setFileSize((float)file.getSize() / 1024 / 1024);
							
							if("I".equals(interworkMgmtVO.getFirmwareFileStateList().get(i))) {
								
								interworkFileMgmtVO.setFileSavePath(prefix + propertiesService.getString("fwUploadDir") + 
										File.separator + interworkMgmtVO.getFirmwareClsCd() + File.separator + interworkMgmtVO.getFirmwareSeq());
								interworkFileMgmtVO.setFileName(file.getOriginalFilename());
								interworkFileMgmtVO.setFileByte(file.getBytes());
								
								insertPhysicalFirmwareFile(interworkFileMgmtVO);
								interworkMgmtMapper.insertFirmwareFile(interworkFileMgmtVO);
								
							} else if("U".equals(interworkMgmtVO.getFirmwareFileStateList().get(i))) {
								
								interworkFileMgmtVO.setFileSavePath(interworkMgmtVO.getFileSavePathList().get(i));
								interworkFileMgmtVO.setFileName(interworkMgmtVO.getOldFileNameList().get(i));
								
								delPhysicalFirmwareFile(interworkFileMgmtVO);
								
								interworkFileMgmtVO.setFileSavePath(prefix + propertiesService.getString("fwUploadDir") + 
										File.separator + interworkMgmtVO.getFirmwareClsCd() + File.separator + interworkMgmtVO.getFirmwareSeq());
								interworkFileMgmtVO.setFileName(file.getOriginalFilename());
								interworkFileMgmtVO.setFileByte(file.getBytes());
								
								insertPhysicalFirmwareFile(interworkFileMgmtVO);
								interworkMgmtMapper.modFirmwareFile(interworkFileMgmtVO);
							}
						}
					}
				}
			} catch(IOException e) {
				throw new CfoodException("", e);
			}
			
			//펌웨어 사이즈 업데이트
			interworkMgmtMapper.modFirmwareBinSize(interworkMgmtVO.getFirmwareSeq());
		}
		
		return rst;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public boolean delFirmware(InterworkMgmtVO interworkMgmtVO) {
		
		//펌웨어 파일 삭제
		if(interworkMgmtVO.getFirmwareFileNoList() != null) {
			for(int i=0;i<interworkMgmtVO.getFirmwareFileNoList().size();i++) {
				interworkMgmtVO.setFileSavePath(interworkMgmtVO.getFileSavePathList().get(i));
				interworkMgmtVO.setFileName(interworkMgmtVO.getOldFileNameList().get(i));
				
				try {
					delPhysicalFirmwareFile(interworkMgmtVO);
				} catch(IOException e) {
					throw new CfoodException("", e);
				}
			}
		}
		interworkMgmtMapper.delFirmwareFile(interworkMgmtVO);
		
		//펌웨어 정보 삭제
		return interworkMgmtMapper.delFirmware(interworkMgmtVO) > 0 ? true : false;
	}

	@Override
	public void insertPhysicalFirmwareFile(InterworkMgmtVO interworkMgmtVO) throws IOException {
		
		File fileSavePath = new File(interworkMgmtVO.getFileSavePath());
		
		if(!fileSavePath.exists())
			fileSavePath.mkdirs();
		
		File f = new File(fileSavePath.getAbsolutePath()  + File.separator + interworkMgmtVO.getFileName());
		
		FileOutputStream fos = new FileOutputStream(f);
		
		fos.write(interworkMgmtVO.getFileByte());
		fos.close();
	}

	@Override
	public boolean delPhysicalFirmwareFile(InterworkMgmtVO interworkMgmtVO) throws IOException {
		
		File f = new File(interworkMgmtVO.getFileSavePath() + File.separator + interworkMgmtVO.getFileName());
		return f.delete();
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean chkFirmwareVer(InterworkMgmtVO interworkMgmtVO) {
		return interworkMgmtMapper.chkFirmwareVer(interworkMgmtVO) > 0 ? true : false;
	}

}
