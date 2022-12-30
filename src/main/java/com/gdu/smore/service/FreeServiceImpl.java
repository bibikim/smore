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

import com.gdu.smore.domain.free.FreeBoardDTO;
import com.gdu.smore.domain.free.FreeImageDTO;
import com.gdu.smore.mapper.FreeCmtMapper;
import com.gdu.smore.mapper.FreeMapper;
import com.gdu.smore.util.MyFileUtil;
import com.gdu.smore.util.PageUtil;

@Service
public class FreeServiceImpl implements FreeService {

	// id= dlwlrma, pw= dkdldb1!
	
	private FreeMapper freeMapper;
	private FreeCmtMapper cmtMapper;
	private PageUtil pageUtil;
	private MyFileUtil fileUtil;
	
	@Autowired
	public void set(FreeMapper freeMapper, FreeCmtMapper cmtMapper, PageUtil pageUtil, MyFileUtil fileUtil) {
		this.cmtMapper = cmtMapper;
		this.freeMapper = freeMapper;
		this.pageUtil = pageUtil;
		this.fileUtil = fileUtil;
	}
	

	@Override
	public void getFreeList(Model model) {
		
		Map<String, Object> mtomap = model.asMap();
		HttpServletRequest request = (HttpServletRequest) mtomap.get("request"); // 컨트롤러에서 model에 저장한 request 꺼내기
		
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
		
		int totalRecord = freeMapper.selectListCount();

		pageUtil.setPageUtil(page, totalRecord);
		
		//Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin() - 1);   // mySQL은 begin이 0부터 시작. 따라서 - 1 을 해줘야 한다.
		map.put("recordPerPage", pageUtil.getRecordPerPage());
		
		// 페이징 처리
		model.addAttribute("totalRecord", totalRecord);
		//model.addAttribute("freeList", freeMapper.selectFreeListByMap(map));
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
		model.addAttribute("paging", pageUtil.getPaging("/free/list"));
		
		// 게시글 목록
		List<FreeBoardDTO> free = freeMapper.selectFreeListByMap(map);
		model.addAttribute("freeList", free);
		//model.addAttribute("freeList", free);
		
		// list에 댓글 갯수 띄우기
		List<Integer> freeNo = new ArrayList<Integer>();
		List<Integer> cmtCount = new ArrayList<Integer>();
		for(int i = 0; i < free.size(); i++) {
			freeNo.add(free.get(i).getFreeNo());
			cmtCount.add(cmtMapper.selectCommentCnt(freeNo.get(i)));
		}
		model.addAttribute("freeCmtCnt", cmtCount);
		
	}
	
	
	@Override
	public Map<String, Object> savefImage(MultipartHttpServletRequest mRequest) {
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
		map.put("src", "/load/image/" + filesystem);
		map.put("filesystem", filesystem);
		
		return map;
	}
	
	
	@Transactional
	@Override
	public void saveFree(HttpServletRequest request, HttpServletResponse response) {
		
		String nickname = request.getParameter("nickname");
		String content = request.getParameter("content");
		String title = request.getParameter("title");
		
		Optional<String> opt = Optional.ofNullable(request.getHeader("X-Forwarded-For"));
		String fIp = opt.orElse(request.getRemoteAddr());
		
		
		FreeBoardDTO fpost = FreeBoardDTO.builder()
				.nickname(nickname)
				.title(title)
				.content(content)
				.ip(fIp)
				.build();
		
		int result = freeMapper.insertFree(fpost);
		
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			if(result > 0) {
				
				String[] fImageNames = request.getParameterValues("fImageNames");
				
				if(fImageNames != null) {
					for(String filesystem : fImageNames) {
						FreeImageDTO fimage = FreeImageDTO.builder()
								.freeNo(fpost.getFreeNo())
								.filesystem(filesystem)
								.build();
						freeMapper.insertImage(fimage);
					}
				}
				
				out.println("alert('게시글이 등록되었습니다.');");
				out.println("location.href='/free/list';");
			} else {
				out.println("alert('게시글이 등록되지 않았습니다.);");
				out.println("history.back();");
			}
			
			out.println("</script>");
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
	
	
	@Override
	public int increaseHit(int freeNo) {
		return freeMapper.updateHit(freeNo);
	}
	
	@Override
	public FreeBoardDTO getFreeByNo(int freeNo) {
		
		FreeBoardDTO free = freeMapper.selectFreeByNo(freeNo);

		List<FreeImageDTO> fImageList = freeMapper.selectFreeImageListInFree(freeNo);
		
		if(fImageList != null && fImageList.isEmpty() == false) {
			for(FreeImageDTO fImage : fImageList) {
				if(free.getContent().contains(fImage.getFilesystem()) == false ) {
					File file = new File(fileUtil.getSummernotePath(), fImage.getFilesystem());
					if(file.exists()) {
						file.delete();
					}
					freeMapper.deleteFreeImage(fImage.getFilesystem());
				}
			}
		}
		
		return free;
	}
	
	@Transactional
	@Override
	public void modifyFree(HttpServletRequest request, HttpServletResponse response) {
		
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int freeNo = Integer.parseInt(request.getParameter("freeNo"));
		
		FreeBoardDTO free = FreeBoardDTO.builder()
				.title(title)
				.content(content)
				.freeNo(freeNo)
				.build();
		
		int result = freeMapper.updateFree(free);
		
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			
			if(result > 0) {
				
				String[] fImageNames = request.getParameterValues("fImageNames");
				
				if(fImageNames != null) {
					for(String filesystem : fImageNames) {
						FreeImageDTO fImage = FreeImageDTO.builder()
								.freeNo(free.getFreeNo())
								.filesystem(filesystem)
								.build();
						freeMapper.insertImage(fImage);
					}
				}
				
				out.println("alert('게시글이 수정되었습니다.');");
				out.println("location.href='/free/detail?freeNo=" + freeNo + "';");
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
	public void removeFree(HttpServletRequest request, HttpServletResponse response) {
		
		int freeNo = Integer.parseInt(request.getParameter("freeNo"));
		
		List<FreeImageDTO> fImageList = freeMapper.selectFreeImageListInFree(freeNo);
		
		int result = freeMapper.deleteFree(freeNo);   // 외래키 제약조건에 의해서 fimage도 모두 지워진다!
		
		try {

			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			if(result > 0) {
			
				if(fImageList != null && fImageList.isEmpty() == false) {
					
					for(FreeImageDTO fImage : fImageList) {
						File file = new File(fileUtil.getSummernotePath(), fImage.getFilesystem());
						if(file.exists()) {
							file.delete();
						}
					}
				}
				
				out.println("alert('게시글이 삭제되었습니다.');");
				out.println("location.href='/free/list'");
				
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
	
	
	/*
	 * @Override public void getCmtCount(int freeNo) {
	 * freeMapper.updateCmtCount(freeNo); }
	 */
}