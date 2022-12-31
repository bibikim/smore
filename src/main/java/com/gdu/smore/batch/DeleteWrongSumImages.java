package com.gdu.smore.batch;

import java.io.File;
import java.io.FilenameFilter;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gdu.smore.domain.code.CodeImageDTO;
import com.gdu.smore.domain.free.FreeImageDTO;
import com.gdu.smore.mapper.CodeBoardMapper;
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
	@Autowired
	private CodeBoardMapper codeMapper;

	@Scheduled(cron="0 0 2 * * *")  // 새벽 2시마다 동작
	public void execute() {
		
		// 써머노트 이미지 경로
		String path = fileUtil.getSummernotePath();
		
		// db에 업로드 된 모든 써머노트 이미지 목록
		List<FreeImageDTO> freeImageList = freeMapper.selectAllFreeImageList();
	
		
		// db에 업로드 된 파일 목록을 list로 생성
		List<Path> pathList = new ArrayList<Path>();
		if(freeImageList != null && freeImageList.isEmpty() == false) {
			for(FreeImageDTO freeImage : freeImageList) {
					pathList.add(Paths.get(path, freeImage.getFilesystem()));
			}
		}
		
		// 테스트
		//System.out.println("--------" + pathList.toString());
		
		// HDD에 업로드 된 파일 목록 중 DB에 기록되어 있지 않은 써머노트 이미지 목록
		File dir = new File(path);
		File[] wrongSumnoteImages = dir.listFiles(new FilenameFilter() {
			
			@Override
			public boolean accept(File dir, String name) {

				return !pathList.contains(new File(dir, name).toPath());
			}
		});
		
		System.out.println("@@@@@@@@@@@@@@@@@@" + Arrays.toString(wrongSumnoteImages));
		// 삭제
		if(wrongSumnoteImages != null) {
			for(File wrongSumnoteImage : wrongSumnoteImages) {
					wrongSumnoteImage.delete();
			}
		}
		
	}
	
	
	@Scheduled(cron="0 0 4 * * *")  // 새벽 4시마다 동작
	public void execute2() {
		
		// 써머노트 이미지 경로
		String path = fileUtil.getSummernotePath();
		
		// db에 업로드 된 모든 써머노트 이미지 목록
		List<CodeImageDTO> codeImageList = codeMapper.selectAllCoardImageList();
	
		
		// db에 업로드 된 파일 목록을 list로 생성
		List<Path> pathList = new ArrayList<>();
		if(codeImageList != null && codeImageList.isEmpty() == false) {
			for(CodeImageDTO codeeImage : codeImageList) {
					pathList.add(Paths.get(path, codeeImage.getFilesystem()));
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
