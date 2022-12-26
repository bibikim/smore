package com.gdu.smore.service;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.smore.domain.code.CodeBoardDTO;
import com.gdu.smore.domain.code.CodeImageDTO;
import com.gdu.smore.mapper.CodeBoardMapper;
import com.gdu.smore.mapper.CodeCmtMapper;
import com.gdu.smore.util.MyFileUtil;
import com.gdu.smore.util.PageUtil;


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
				
				int totalRecord = codeboardMapper.selectCodeBoardListCount();

				pageUtil.setPageUtil(page, totalRecord);
				
				//Map<String, Object> map = new HashMap<String, Object>();
				map.put("begin", pageUtil.getBegin() - 1);   // mySQL은 begin이 0부터 시작. 따라서 - 1 을 해줘야 한다.
				map.put("recordPerPage", pageUtil.getRecordPerPage());
				
				// 페이징 처리
				model.addAttribute("totalRecord", totalRecord);
				//model.addAttribute("freeList", freeMapper.selectFreeListByMap(map));
				model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
				model.addAttribute("paging", pageUtil.getPaging(request.getContextPath() + "/code/list"));
				
				// 게시글 목록
				List<CodeBoardDTO> code = codeboardMapper.selectCodeBoardListByMap(map);
				model.addAttribute("codeList", code);
				//model.addAttribute("freeList", free);
				
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
		// 1. 코드게시판에서 보낸 파일 담아준다.
		MultipartFile mpFile = mRequest.getFile("file");
		// 2. 저장할 경로 설정
		String path = "c:" + File.separator + "summernoteImage";
		// 3. 저장할 파일명
		String filesystem = fileUtil.getFilename(mpFile.getOriginalFilename());
		
		// 4. 파일 클래스 생성 
		File dir = new File(path);
		
		// 5. 2번에서 저장할 경로에 summernoteImage폴더 없으면 생성 
		if(dir.exists() == false) {
			dir.mkdirs();
		}
		
		// 6. 해당경로에 실제 파일 저장할 클래스 생성 
		File file = new File(path, filesystem);
		
		// 7. 해당경로에 파일 생성 
		try {
			mpFile.transferTo(file);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 8. 다 완료 됐으면 이미지 경로랑 파일명 다시 write 페이지로 전송 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("src", "/resources/upload/" + filesystem);
		map.put("filesystem", filesystem);
		
		return map;
	}
	
	@Transactional
	@Override
	public void saveCodeBoard(HttpServletRequest request, HttpServletResponse response) {
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
					File file = new File("C:" + File.separator + "cImage", cImage.getFilesystem());
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
						File file = new File("c:" + File.separator + "cImage", cImage.getFilesystem());
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
	
	
	
	
}