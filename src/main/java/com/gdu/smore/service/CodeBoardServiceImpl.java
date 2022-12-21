package com.gdu.smore.service;

import java.io.File;
import java.io.PrintWriter;
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
import com.gdu.smore.util.MyFileUtil;
import com.gdu.smore.util.PageUtil;


@Service
public class CodeBoardServiceImpl implements CodeBoardService {
	
	private CodeBoardMapper codeboardMapper;
	private PageUtil pageUtil;
	private MyFileUtil myFileUtil;
	
	@Autowired
	public void set(CodeBoardMapper codeboardMapper, PageUtil pageUtil, MyFileUtil myFileUtil) {
		this.codeboardMapper = codeboardMapper;
		this.pageUtil = pageUtil;
		this.myFileUtil = myFileUtil;
	}
	
	public void getCodeBoardList(Model model) {
		
		// Model에 저장된 request 꺼내기
		Map<String, Object> modelMap = model.asMap();  // model을 map으로 변신
		HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
		
		// page 파라미터
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		// 전체 블로그 개수
		int totalRecord = codeboardMapper.selectCodeBoardListCount();
		
		// 페이징 처리에 필요한 변수 계산
		pageUtil.setPageUtil(page, totalRecord);
		
		// 조회 조건으로 사용할 Map 만들기
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
		// 뷰로 전달할 데이터를 model에 저장하기 
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("codeboardList", codeboardMapper.selectCodeBoardListByMap(map));
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
		model.addAttribute("paging", pageUtil.getPaging(request.getContextPath() + "/code/list"));
		
	}
	
	@Override
	public Map<String, Object> saveImage(MultipartHttpServletRequest mRequest) {
		// 파라미터 files
		MultipartFile mpFile = mRequest.getFile("file");
		// 저장경로
		String path = "c:" + File.separator + "summernoteImage";
		// 저장할 파일명
		String filesystem = myFileUtil.getFilename(mpFile.getOriginalFilename());
		
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
		map.put("src", mRequest.getContextPath() + "/load/image" + filesystem);
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
		String Ip = opt.orElse(request.getRemoteAddr());
		
		
		CodeBoardDTO post = CodeBoardDTO.builder()
				.nickname(nickname)
				.title(title)
				.content(content)
				.ip(Ip)
				.build();
		
		int result = codeboardMapper.insertCodeBoard(post);
		
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			if(result > 0) {
				
				String[] ImageNames = request.getParameterValues("ImageNames");
				
				if(ImageNames != null) {
					for(String filesystem : ImageNames) {
						CodeImageDTO image = CodeImageDTO.builder()
								.coNo(post.getCoNo())
								.filesystem(filesystem)
								.build();
						codeboardMapper.insertImage(image);
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

		List<CodeImageDTO> ImageList = codeboardMapper.selectCodeImageListInCode(coNo);
		
		if(ImageList != null && ImageList.isEmpty() == false) {
			for(CodeImageDTO Image : ImageList) {
				if(code.getContent().contains(Image.getFilesystem()) == false ) {
					File file = new File("C:" + File.separator + "Image", Image.getFilesystem());
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
				
				String[] ImageNames = request.getParameterValues("ImageNames");
				
				if(ImageNames != null) {
					for(String filesystem : ImageNames) {
						CodeImageDTO Image = CodeImageDTO.builder()
								.coNo(code.getCoNo())
								.filesystem(filesystem)
								.build();
						codeboardMapper.insertImage(Image);
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
		
		List<CodeImageDTO> ImageList = codeboardMapper.selectCodeImageListInCode(coNo);
		
		int result = codeboardMapper.deleteCodeBoard(coNo);   // 외래키 제약조건에 의해서 image도 모두 지워진다!
		
		try {

			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			if(result > 0) {
			
				if(ImageList != null && ImageList.isEmpty() == false) {
					
					for(CodeImageDTO Image : ImageList) {
						File file = new File("c:" + File.separator + "Image", Image.getFilesystem());
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