package com.gdu.smore.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.smore.domain.code.CodeAttachDTO;
import com.gdu.smore.domain.code.CodeBoardDTO;
import com.gdu.smore.domain.code.CodeImageDTO;
import com.gdu.smore.mapper.CodeBoardMapper;
import com.gdu.smore.mapper.CodeCmtMapper;
import com.gdu.smore.util.MyFileUtil;
import com.gdu.smore.util.PageUtil;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class CodeBoardServiceImpl implements CodeBoardService {
	
	private CodeBoardMapper codeboardMapper;
	private CodeCmtMapper cmtMapper;
	private PageUtil pageUtil;
	private MyFileUtil fileUtil;
	
	@Autowired
	public void set(CodeBoardMapper codeboardMapper, CodeCmtMapper cmtMapper, PageUtil pageUtil, MyFileUtil fileUtil) {
		this.cmtMapper = cmtMapper;
		this.codeboardMapper = codeboardMapper;
		this.pageUtil = pageUtil;
		this.fileUtil = fileUtil;
	}
	
	public void getCodeBoardList(Model model) {
		
		// Model에 저장된 request 꺼내기
		Map<String, Object> mtoMap = model.asMap();  // model을 map으로 변신
		HttpServletRequest request = (HttpServletRequest) mtoMap.get("request");
		
		// 검색기능
		String type = request.getParameter("type");
		String keyword = request.getParameter("keyword");
				
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("type", type);
		map.put("keyword", keyword);
				
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
				
				
		// 첫 페이지
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
				
		int totalRecord = codeboardMapper.selectListCount();

		pageUtil.setPageUtil(page, totalRecord);
				
		//Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin() - 1);   // mySQL은 begin이 0부터 시작. 따라서 - 1 을 해줘야 한다.
		map.put("recordPerPage", pageUtil.getRecordPerPage());
				
		// 페이징 처리
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
		model.addAttribute("paging", pageUtil.getPaging("/code/list"));
				
		// 게시글 목록
		List<CodeBoardDTO> code = codeboardMapper.selectCodeBoardListByMap(map);
		model.addAttribute("codeboardList", code);
		
				
		// list에 댓글 갯수 띄우기
		List<Integer> coNo = new ArrayList<Integer>();
		List<Integer> cmtCount = new ArrayList<Integer>();
		for(int i = 0; i < code.size(); i++) {
			coNo.add(code.get(i).getCoNo());
			cmtCount.add(cmtMapper.selectCommentCnt(coNo.get(i)));
	 }
		model.addAttribute("codeCmtCnt", cmtCount);
	}
	
	@Override
	public Map<String, Object> savecImage(MultipartHttpServletRequest mRequest) {
		// 파라미터 files
				MultipartFile mpFile = mRequest.getFile("file");
				// 저장경로
				String path = fileUtil.getSummernotePath();
				// 저장할 파일명
				String filesystem = fileUtil.getFilename(mpFile.getOriginalFilename());
				
				File dir = new File(path);
				if(dir.exists() == false) {
					dir.mkdirs();
				}
				
				File file = new File(path, filesystem);
				
				try {
					mpFile.transferTo(file);
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("src",  "/load/image/" + filesystem);
				map.put("filesystem", filesystem);
				
				return map;
	}
	
	@Transactional
	@Override
	public void saveCodeBoard(MultipartHttpServletRequest request, HttpServletResponse response) {
		String nickname = request.getParameter("nickname");
		String content = request.getParameter("content");
		String title = request.getParameter("title");
		
		Optional<String> opt = Optional.ofNullable(request.getHeader("X-Forwarded-For"));
		String cIp = opt.orElse(request.getRemoteAddr());
		
		
		CodeBoardDTO cpost = CodeBoardDTO.builder()
				.nickname(nickname)
				.title(title)
				.content(content)
				.ip(cIp)
				.build();
		
		int result = codeboardMapper.insertCodeBoard(cpost);
		log.info("cono ==>" + cpost.getCoNo());
		log.info("result ==>" + result);
		
		List<MultipartFile> files = request.getFiles("files");
		log.info("파일 사이즈 : " +files.size());
		
		int attachResult;
		if(files.get(0).getSize() == 0) {
			attachResult = 1;	
		} else {
			attachResult = 0;
		}
		
		log.info("attachResult :" + attachResult);
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			if(result > 0) {
				
				String[] cImageNames = request.getParameterValues("cImageNames");
				
				if(cImageNames != null) {
					for(String filesystem : cImageNames) {
						CodeImageDTO cimage = CodeImageDTO.builder()
								.coNo(cpost.getCoNo())
								.filesystem(filesystem)
								.build();
						codeboardMapper.insertImage(cimage);
					}
				}
				
				// 첨부된 파일 목록 순회 (하나씩 저장)
				for(MultipartFile multipartFile : files) {
					
					try {
						
						if(multipartFile != null && multipartFile.isEmpty() == false) {
							
							// 원래 이름
							String origin = multipartFile.getOriginalFilename();
							origin = origin.substring(origin.lastIndexOf("\\") +1);
							log.info("origin :" + origin);

							
							// 저장할 이름
							String filesystem = fileUtil.getFilename(origin);
							
							// 저장할 경로
							String path = fileUtil.getTodayPath();
							
							// 저장할 경로 만들기
							File dir = new File(path);
							if(dir.exists() == false) {
								dir.mkdirs();
							}
							
							// 첨부할 File 객체
							File file = new File(dir, filesystem); // 경로, 저장할 이름
							

							// 첨부파일 서버에 저장(업로드 진행)
							multipartFile.transferTo(file);
							
							CodeAttachDTO attach = CodeAttachDTO.builder()
									.path(path)
									.origin(origin)
									.filesystem(filesystem)
									.coNo(cpost.getCoNo())
									.build();
							
							// DB에 AttachDTO 저장
							attachResult += codeboardMapper.insertAttach(attach);
							
						}
						
						
					}catch (Exception e) {
						// TODO: handle exception
					}
					
				} // for
				
				out.println("alert('게시글이 등록되었습니다.');");
				out.println("location.href='/code/list';");
			} else {
				out.println("alert('게시글 등록이 되지 않았습니다.);");
				out.println("history.back();");
			}
			
			out.println("</script>");
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}

	@Override
	public int increseCodeBoardHit(int coNo) {
		return codeboardMapper.updateHit(coNo);
	}

	@Override
	public CodeBoardDTO getCodeBoardByNo(int coNo) {
		CodeBoardDTO code = codeboardMapper.selectCodeBoardByNo(coNo);

		List<CodeImageDTO> cImageList = codeboardMapper.selectCodeImageListInCode(coNo);
		
		if(cImageList != null && cImageList.isEmpty() == false) {
			for(CodeImageDTO cImage : cImageList) {
				if(code.getContent().contains(cImage.getFilesystem()) == false ) {
					File file = new File(fileUtil.getSummernotePath(), cImage.getFilesystem());
					if(file.exists()) {
						file.delete();
					}
					codeboardMapper.deleteCodeImage(cImage.getFilesystem());
				}
			}
		}
		
		return code;
	}

	@Override
	public void modifyCodeBoard(HttpServletRequest request, HttpServletResponse response) {
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int coNo = Integer.parseInt(request.getParameter("coNo"));
		
		CodeBoardDTO code = CodeBoardDTO.builder()
				.title(title)
				.content(content)
				.coNo(coNo)
				.build();
		
		int result = codeboardMapper.updateCodeBoard(code);
		
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			
			if(result > 0) {
				
				String[] cImageNames = request.getParameterValues("ImageNames");
				
				if(cImageNames != null) {
					for(String filesystem : cImageNames) {
						CodeImageDTO cImage = CodeImageDTO.builder()
								.coNo(code.getCoNo())
								.filesystem(filesystem)
								.build();
						codeboardMapper.insertImage(cImage);
					}
				}
				
				out.println("alert('게시글이 수정되었습니다.');");
				out.println("location.href='/code/detail?coNo=" + coNo + "';");
			} else {
				out.println("alert('게시글이 수정되지 않았습니다. 확인해주세요');");
				out.println("history.back();");
			}
			
			out.println("</script>");
			out.close();
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		
	}

	@Override
	public void removeCodeBoard(HttpServletRequest request, HttpServletResponse response) {
		int coNo = Integer.parseInt(request.getParameter("coNo"));
		
		List<CodeImageDTO> cImageList = codeboardMapper.selectCodeImageListInCode(coNo);
		
		int result = codeboardMapper.deleteCodeBoard(coNo);   // 외래키 제약조건에 의해서 cimage도 모두 지워진다!
		
		try {

			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			if(result > 0) {
			
				if(cImageList != null && cImageList.isEmpty() == false) {
					
					for(CodeImageDTO cImage : cImageList) {
						File file = new File(fileUtil.getSummernotePath(), cImage.getFilesystem());
						if(file.exists()) {
							file.delete();
						}
					}
				}
				
				out.println("alert('게시글이 삭제되었습니다.');");
				out.println("location.href='/code/list'");
				
			} else {
				
				out.println("alert('게시글 삭제에 실패했습니다.);");
				out.println("history.back();");

			}
			
			out.println("</script>");
			out.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public ResponseEntity<Resource> download(String userAgent, int attachNo) {
		
		CodeAttachDTO attach = codeboardMapper.selectAttachByNo(attachNo);
		File file = new File(attach.getPath(), attach.getFilesystem());
		
		Resource resource = new FileSystemResource(file);
		
		if(resource.exists() == false) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}
		
		codeboardMapper.updateDownloadCnt(attachNo);
		
		String origin = attach.getOrigin();
		try {
			// IE (userAgent)에 "Trident"가 포함되어 있음
			if(userAgent.contains("Trident")) {
				origin = URLEncoder.encode(origin, "UTF-8").replaceAll("\\+", "");
			}
			
			else if(userAgent.contains("Edg")) {
				origin = URLEncoder.encode(origin,"UTF-8");
			}
			else {
				origin = new String(origin.getBytes("UTF-8"), "ISO-8859-1");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Disposition", "attachment; filename=" + origin);
		header.add("Content-Length", file.length() + "");
		
		return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
		
		
	
	}
	
	@Override
	public ResponseEntity<Resource> downloadAll(String userAgent, int coNo) {
		
		List<CodeAttachDTO> attachList = codeboardMapper.selectAttachList(coNo);
		
		FileOutputStream fileOutputStream = null;
		ZipOutputStream zipOutputStream = null;
		FileInputStream fileInputStream = null;
		
		String tmpPath = "storage" + File.separator + "temp";
		
		File tmpDir = new File(tmpPath);
		if(tmpDir.exists() == false) {
			tmpDir.mkdirs();
		}
		
		String tmpName = System.currentTimeMillis() + ".zip";
		
		try {
			
			fileOutputStream = new FileOutputStream(new File(tmpPath, tmpName));
			zipOutputStream = new ZipOutputStream(fileOutputStream);
			
			// 첨부가 있는지 확인
			if(attachList != null && attachList.isEmpty() == false) {
				
				// 첨부파일 순회
				for(CodeAttachDTO attach : attachList) {
					
					// zip 파일에 첨부 파일 추가
					ZipEntry zipEntry = new ZipEntry(attach.getOrigin());
					zipOutputStream.putNextEntry(zipEntry);
					
					fileInputStream = new FileInputStream(new File(attach.getPath(), attach.getFilesystem()));
					byte[] buffer = new byte[1024];
					int length;
					while((length = fileInputStream.read(buffer)) != -1) {
						zipOutputStream.write(buffer, 0, length);
					}
					zipOutputStream.closeEntry();
					fileInputStream.close();
					// 각 첨부 파일 모두 다운로드 횟수 증가
					codeboardMapper.updateDownloadCnt(attach.getAttachNo());
				}
				
				zipOutputStream.close();
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		
		// 반환할 Resource
		File file = new File(tmpPath, tmpName);
		Resource resource = new FileSystemResource(file);
		
		// Resource가 없으면 종료 (다운로드할 파일이 없음)
		if(resource.exists() == false) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}
		
		// 다운로드 헤더 만들기
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Disposition", "attachment; filename=" + tmpName);  // 다운로드할 zip파일명은 타임스탬프로 만든 이름을 그대로 사용
		header.add("Content-Length", file.length() + "");
		
		return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
	}
	
	@Override
	public void getUploadByNo(int coNo, Model model) {
		model.addAttribute("upload", codeboardMapper.selectCodeBoardByNo(coNo));
		model.addAttribute("attachList", codeboardMapper.selectAttachList(coNo));		
	}
	
}