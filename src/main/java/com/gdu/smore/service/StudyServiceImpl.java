package com.gdu.smore.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
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
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.gdu.smore.domain.study.StudyCommentDTO;
import com.gdu.smore.domain.study.StudyGroupDTO;
import com.gdu.smore.domain.user.UserDTO;
import com.gdu.smore.mapper.StudyMapper;
import com.gdu.smore.util.PageUtil;
import com.gdu.smore.util.StudPageUtil;

@PropertySource(value = {"classpath:application.yml"})
@Service
public class StudyServiceImpl implements StudyService {

	@Autowired
	private StudyMapper studyMapper;
	@Autowired
	private PageUtil pageUtil;
	@Autowired
	private StudPageUtil studPageUtil;
	
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
		model.addAttribute("paging", pageUtil.getPaging("/study/list"));
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
		String studDate = request.getParameter("studDate");

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
				.title(title)
				.content(content)
				.gender(gender)
				.region(region)
				.wido(wido)
				.gdo(gdo)
				.lang(lang)
				.people(people)
				.contact(contact)
				.ip(ip)
				.studDate(studDate)
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
				out.println("location.href='/';");
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
	public int increseStudyHit(int studNo) {
		return studyMapper.updateHit(studNo);
	}

	
	@Override
	public StudyGroupDTO getStudyByNo(int studNo) {

		StudyGroupDTO study = studyMapper.selectStudyByNo(studNo);
		
		return study;
	}
	
	@Transactional
	@Override
	public void modifyStudy(HttpServletRequest request, HttpServletResponse response) {
		
		// 파라미터 title, content, sNo
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int studNo = Integer.parseInt(request.getParameter("studNo"));
		
		// DB로 보낼 StudyGroupDTO
		StudyGroupDTO study = StudyGroupDTO.builder()
				.title(title)
				.content(content)
				.studNo(studNo)
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
				out.println("location.href='/';");
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
		
		// 파라미터 studNo
		int studNo = Integer.parseInt(request.getParameter("studNo"));
		
		// DB 삭제
		int result = studyMapper.deleteStudy(studNo);  // 외래키 제약조건에 의해서 SummernoteImage도 모두 지워짐
		
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
				out.println("location.href='/';");
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
	
	@Override
	public Map<String, Object> getStudyScroll(HttpServletRequest request, Model model) {

		// page 파라미터가 전달되지 않는 경우 page = 1로 처리한다.
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		// 전체 레코드(직원) 개수 구하기
		int totalRecord = studyMapper.selectAllBoardCnt();
		
		// PageUtil 계산하기
		int recordPerPage = 9;  // 스크롤 한 번에 9개씩 가져가기
		studPageUtil.setPageUtil(page, recordPerPage, totalRecord);
		
		// Map 만들기(field, order, begin, end)
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", studPageUtil.getBegin());
		map.put("end", studPageUtil.getEnd());
		
		// begin~end 목록 가져오기
		List<StudyGroupDTO> S_group = studyMapper.selectStudyScroll(map);
		
		// 응답할 데이터
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("totalPage", studPageUtil.getTotalPage());
		resultMap.put("S_group", S_group);
		
		return resultMap;
	}

	
	// 댓글
	@Override
	public Map<String, Object> getCmtCnt(int studNo) {   // 반환용 map
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("commentCnt",  studyMapper.selectCommentCnt(studNo));  // 키, 값 
		return result;
	}
	
	
	@Override
	public Map<String, Object> getCmtList(HttpServletRequest request) {
		
		int studNo = Integer.parseInt(request.getParameter("studNo"));
		int page = Integer.parseInt(request.getParameter("page"));
		String ip = request.getRemoteAddr();
		
		int cmtCnt = studyMapper.selectCommentCnt(studNo);
		pageUtil.setPageUtil(page, cmtCnt);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("studNo", studNo);
		map.put("ip", ip);
		map.put("begin", pageUtil.getBegin() - 1);
		map.put("recordPerPage", pageUtil.getRecordPerPage());
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("cmtList", studyMapper.selectCommentList(map));
		result.put("pageUtil", pageUtil);  // pageUtil은 왜 Map에 넣는걸까?
		
		return result;
	}

	@Transactional
	@Override
	public Map<String, Object> saveComment(StudyCommentDTO comment) {
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
		 
		 int groupNo = Integer.parseInt(request.getParameter("groupNo"));
		 comment.setGroupNo(groupNo);
		 comment.setNickname(loginUser.getNickname());
		 // 원댓 group_no
		 
		 
		 StudyCommentDTO cmt2 = StudyCommentDTO.builder() 
		//		 .cmtNo(cmtNo)
				 .groupNo(groupNo)
				 .build();
		 
		 studyMapper.updateGroupNo(cmt2);
		
		 
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isSave", studyMapper.insertStudycmt(comment) == 1);
					// insert 결과가 1이면 true, 아니면 false 반환
	
		
		return result;
	}
	
	@Override
	public Map<String, Object> removeComment(int cmtNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isRemove", studyMapper.deleteComment(cmtNo) == 1);
		return result;
	}
	
	
	@Override
	public Map<String, Object> saveRecomment(StudyCommentDTO recomment) {
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
		recomment.setNickname(loginUser.getNickname());
		
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isSaveRe", studyMapper.insertRecomment(recomment) == 1);
		return result;
	}
	
	
	// 좋아요
	@Override
	public Map<String, Object> getLikeCheck(HttpServletRequest request) {
		int studNo = Integer.parseInt(request.getParameter("studNo"));
		String nickname = request.getParameter("nickname");
		Map<String, Object> map = new HashMap<>();
		map.put("studNo", studNo);
		map.put("nickname", nickname);
		Map<String, Object> result = new HashMap<>();
		result.put("count", studyMapper.selectUserLikeCount(map));
		return result;
	}
	
	@Override
	public Map<String, Object> getLikeCount(int studNo) {
		Map<String, Object> result = new HashMap<>();
		result.put("count", studyMapper.selectStudyLikeCount(studNo));
		return result;
	}
	
	@Override
	public Map<String, Object> mark(HttpServletRequest request) {
		int studNo = Integer.parseInt(request.getParameter("studNo"));
		String nickname = request.getParameter("nickname");
		Map<String, Object> map = new HashMap<>();
		map.put("studNo", studNo);
		map.put("nickname", nickname);
		Map<String, Object> result = new HashMap<>();
		if (studyMapper.selectUserLikeCount(map) == 0) {  // 해당 게시물의 "좋아요"를 처음 누른 상태
			result.put("isSuccess",studyMapper.insertLike(map) == 1);  // 신규 삽입			
		} else {
			result.put("isSuccess", studyMapper.deleteLike(map) == 1);  // 기존 정보 삭제		
		}
		return result;
	}
}
