package com.gdu.smore.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.gdu.smore.domain.redbell.GrpRedbellDTO;
import com.gdu.smore.domain.user.UserDTO;
import com.gdu.smore.mapper.RedMapper;
import com.gdu.smore.util.PageUtil;
import com.gdu.smore.util.StudPageUtil;

@PropertySource(value = {"classpath:application.yml"})
@Service
public class RedServiceImpl implements RedService {

	@Autowired
	private RedMapper redMapper;
	@Autowired
	private PageUtil pageUtil;
	
	/*
	@Override  // 목록보기
	public void getRedList(HttpServletRequest request, Model model) {
		
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
				
		// 전체 게시글 수는 DB에서 select count로 구하고 매퍼통해서 결과값 가져오기
		int totalRecord = redMapper.selectAllRedCnt();
		
		// 페이징에 필요한 계산 완.
		pageUtil.setPageUtil(page,totalRecord);
		
		// DB로 보낼 map(begin, end)
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
				
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("redList", redMapper.selectAllRedList(map));
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
		model.addAttribute("paging", pageUtil.getPaging(request.getContextPath() + "/study/list"));
	}
	*/
	@Transactional
	@Override
	public void saveRed(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();		
		UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");

		// 파라미터
		String id = request.getParameter("id");
		String redContent = request.getParameter("redContent");
		int studNo = Integer.parseInt(request.getParameter("studNo"));
		
		GrpRedbellDTO grpred = GrpRedbellDTO.builder()
				.id(id)
				.redContent(redContent)
				.studNo(studNo)
				.build();
		
		// DB에 grpred 저장
		int result = redMapper.insertRed(grpred);
		
		// 응답
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			if(result > 0) {
				
				
				out.println("alert('신고 성공');");
				out.println("location.href='" + request.getContextPath() + "/study/list';");
			} else {
				out.println("alert('신고 실패');");
				out.println("history.back();");
			}
			out.println("</script>");
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
