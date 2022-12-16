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

import com.gdu.smore.domain.study.StudyGroupDTO;
import com.gdu.smore.domain.user.UserDTO;
import com.gdu.smore.mapper.StudyMapper;
import com.gdu.smore.util.PageUtil;
import com.gdu.smore.util.SecurityUtil;

@PropertySource(value = {"classpath:application.yml"})
@Service
public class StudyServiceImpl implements StudyService {

	@Autowired
	private StudyMapper studyMapper;
	@Autowired
	private PageUtil pageUtil;
	@Autowired
	private SecurityUtil securityUtil;
	
	@Override  // 목록보기
	public void getStudyList(HttpServletRequest request, Model model) {
		
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
				
		// 전체 게시글 수는 DB에서 select count로 구하고 매퍼통해서 결과값 가져오기
		int totalRecord = studyMapper.selectAllBoardCnt();
		
		// 페이징에 필요한 계산 완.
		pageUtil.setPageUtil(page,totalRecord);
		
		// DB로 보낼 map(begin, end)
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
				
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("studyList", studyMapper.selectAllList(map));
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
		model.addAttribute("paging", pageUtil.getPaging(request.getContextPath() + "/study/list"));
	}

	@Transactional
	@Override
	public void saveStudy(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
		String nickname = loginUser.getNickname();

		// 파라미터
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String gender = request.getParameter("gender");
		String region = request.getParameter("region");
		String wido = request.getParameter("wido");
		String gdo = request.getParameter("gdo");
		String lang = request.getParameter("lang");
		String people = request.getParameter("people");
		String contact = request.getParameter("contact");

		// 작성자의 ip
		// 작성된 내용이 어딘가를 경유해서 도착하면 원래 ip가 X-Forwarded-For라는 요청헤더에 저장된다.
		
		// 출발                  도착
		// 1.1.1.1               1.1.1.1 : request.getRemoteAddr()
		//                       null    : request.getHeader("X-Forwarded-For")
		
		// 출발       경유       도착
		// 1.1.1.1    2.2.2.2    2.2.2.2 : request.getRemoteAddr()
		//                       1.1.1.1 : request.getHeader("X-Forwarded-For")
		
		Optional<String> opt = Optional.ofNullable(request.getHeader("X-Forwarded-For"));
		String ip = opt.orElse(request.getRemoteAddr());
		
		// DB로 보낼 StudyGroupDTO
		StudyGroupDTO study = StudyGroupDTO.builder()
				.nickname(nickname)
				.STitle(title)
				.SContent(content)
				.SGender(gender)
				.SRegion(region)
				.SWido(wido)
				.SGdo(gdo)
				.SLang(lang)
				.SPeople(people)
				.SContact(contact)
				.SIp(ip)
				.build();
		
		// DB에 Study 저장
		int result = studyMapper.insertStudy(study);
		
		// 응답
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			if(result > 0) {
				
				
				out.println("alert('삽입 성공');");
				out.println("location.href='" + request.getContextPath() + "/study/list';");
			} else {
				out.println("alert('삽입 실패');");
				out.println("history.back();");
			}
			out.println("</script>");
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public int increseStudyHit(int sNo) {
		return studyMapper.updateHit(sNo);
	}

	
	@Override
	public StudyGroupDTO getStudyByNo(int SNo) {

		StudyGroupDTO study = studyMapper.selectStudyByNo(SNo);
		
		return study;
	}
	
	@Transactional
	@Override
	public void modifyStudy(HttpServletRequest request, HttpServletResponse response) {
		
		// 파라미터 title, content, sNo
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int SNo = Integer.parseInt(request.getParameter("SNo"));
		
		// DB로 보낼 BlogDTO
		StudyGroupDTO study = StudyGroupDTO.builder()
				.STitle(title)
				.SContent(content)
				.SNo(SNo)
				.build();
		
		// DB 수정
		int result = studyMapper.updateStudy(study);
		
		response.setContentType("text/html; charset=UTF-8");
		// 응답
		try {
			
			PrintWriter out = response.getWriter();
			
			if(result > 0) {
				/*
				// 파라미터 summernoteImageNames
				String[] summernoteImageNames = request.getParameterValues("summernoteImageNames");
				
				// DB에 SummernoteImage 저장
				if(summernoteImageNames != null) {
					for(String filesystem : summernoteImageNames) {
						SummernoteImageDTO summernoteImage = SummernoteImageDTO.builder()
								.blogNo(blog.getBlogNo())
								.filesystem(filesystem)
								.build();
						blogMapper.insertSummernoteImage(summernoteImage);
					}
				}
				*/
				out.println("<script>");
				out.println("alert('수정 성공');");
				out.println("location.href='" + request.getContextPath() + "/study/list';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('수정 실패');");
				out.println("history.back();");
				out.println("</script>");

			}
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void removeStudy(HttpServletRequest request, HttpServletResponse response) {
		
		// 파라미터 blogNo
		int SNo = Integer.parseInt(request.getParameter("SNo"));
		
		// DB 삭제
		int result = studyMapper.deleteStudy(SNo);  // 외래키 제약조건에 의해서 SummernoteImage도 모두 지워짐
		
		// 응답
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			if(result > 0) {
				
				/*
				// HDD에서 SummernoteImage 리스트 삭제
				if(summernoteImageList != null && summernoteImageList.isEmpty() == false) {
					for(SummernoteImageDTO summernoteImage : summernoteImageList) {
						File file = new File(myFileUtil.getSummernotePath(), summernoteImage.getFilesystem());
						if(file.exists()) {
							file.delete();
						}
					}
				}
				*/
				
				out.println("alert('삭제 성공');");
				out.println("location.href='" + request.getContextPath() + "/study/list';");
			} else {
				out.println("alert('삭제 실패');");
				out.println("history.back();");
			}
			out.println("</script>");
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
}
