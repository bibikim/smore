package com.gdu.smore.batch;

import java.io.File;
import java.io.FilenameFilter;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gdu.smore.domain.free.FreeImageDTO;
import com.gdu.smore.mapper.FreeMapper;
import com.gdu.smore.util.MyFileUtil;

import lombok.AllArgsConstructor;

@EnableScheduling
@Component
public class DeleteWrongSumImages {


	
	@Autowired
	private FreeMapper freeMapper;
	@Autowired
	private MyFileUtil fileUtil;

	@Scheduled(cron="0 0 3 * * *")  // 새벽 3시마다 동작
	public void execute() {
		
		// 써머노트 이미지 경로
		String path = fileUtil.getSummernotePath();
		
		// db에 업로드 된 모든 써머노트 이미지 목록
		List<FreeImageDTO> freeImageList = freeMapper.selectAllFreeImageList();
	
		
		// db에 업로드 된 파일 목록을 list로 생성
		List<Path> pathList = new ArrayList<>();
		if(freeImageList != null && freeImageList.isEmpty() == false) {
			for(FreeImageDTO freeImage : freeImageList) {
					pathList.add(Paths.get(path, freeImage.getFilesystem()));
			}
		}
		
		File dir = new File(path);
		File[] wrongSumnoteImages = dir.listFiles(new FilenameFilter() {
			
			@Override
			public boolean accept(File dir, String name) {

				return !pathList.contains(new File(dir, name).toPath());
			}
		});
		
		// 삭제
		if(wrongSumnoteImages != null) {
			for(File wrongSumnoteImage : wrongSumnoteImages) {
					wrongSumnoteImage.delete();
			}
		}
	}
	
}
