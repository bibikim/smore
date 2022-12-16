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

import com.gdu.smore.domain.free.FreeBoardDTO;
import com.gdu.smore.domain.free.FreeImageDTO;
import com.gdu.smore.mapper.FreeMapper;
import com.gdu.smore.util.MyFileUtil;
import com.gdu.smore.util.PageUtil;

@Service
public class FreeServiceImpl implements FreeService {

	// id= dlwlrma, pw= dkdldb1!
	
	private FreeMapper freeMapper;
	private PageUtil pageUtil;
	private MyFileUtil fileUtil;
	
	@Autowired
	public void set(FreeMapper freeMapper, PageUtil pageUtil, MyFileUtil fileUtil) {
		this.freeMapper = freeMapper;
		this.pageUtil = pageUtil;
		this.fileUtil = fileUtil;
	}
	

	@Override
	public void getFreeList(Model model) {
		
		Map<String, Object> mtomap = model.asMap();
		HttpServletRequest request = (HttpServletRequest) mtomap.get("request"); // 컨트롤러에서 model에 저장한 request 꺼내기
		
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		int totalRecord = freeMapper.selectListCount();

		pageUtil.setPageUtil(page, totalRecord);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("freeList", freeMapper.selectFreeListByMap(map));
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
		model.addAttribute("paging", pageUtil.getPaging(request.getContextPath() + "/free/list"));
		
	}
	
	
	@Override
	public Map<String, Object> savefImage(MultipartHttpServletRequest mRequest) {
		// 파라미터 files
		MultipartFile mpFile = mRequest.getFile("file");
		// 저장경로
		String path = "c:" + File.separator + "summernoteImage";
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
		map.put("src", mRequest.getContextPath() + "/load/image/" + filesystem);
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
					File file = new File("C:" + File.separator + "fImage", fImage.getFilesystem());
				}
			}
		}
		
		return free;
	}
	
}
