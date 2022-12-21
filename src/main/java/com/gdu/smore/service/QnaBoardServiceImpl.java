package com.gdu.smore.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gdu.smore.domain.qna.QnaBoardDTO;
import com.gdu.smore.mapper.QnaBoardMapper;
import com.gdu.smore.util.MyFileUtil;
import com.gdu.smore.util.PageUtil;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class QnaBoardServiceImpl implements QnaBoardService {
	
	private QnaBoardMapper qnaboardMapper;
	private PageUtil pageUtil;
	private MyFileUtil myFileUtil;
	
	@Autowired
	public void set(QnaBoardMapper qnaboardMapper, PageUtil pageUtil, MyFileUtil myFileUtil) {
		this.qnaboardMapper = qnaboardMapper;
		this.pageUtil = pageUtil;
		this.myFileUtil = myFileUtil;
	}
	
	public void getQnaBoardList(Model model) {
		
		// Model에 저장된 request 꺼내기
		Map<String, Object> modelMap = model.asMap();  // model을 map으로 변신
		HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
		
		// page 파라미터
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		// 전체 블로그 개수
		int totalRecord = qnaboardMapper.selectQnaBoardListCount();
		log.info(totalRecord);
		// 페이징 처리에 필요한 변수 계산
		pageUtil.setPageUtil(page, totalRecord);
		
		log.info(pageUtil.getBegin() + "====" + pageUtil.getEnd());
		// 조회 조건으로 사용할 Map 만들기
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", 0);
		map.put("end", 10);
		
		// 뷰로 전달할 데이터를 model에 저장하기 
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("qnaboardList", qnaboardMapper.selectQnaBoardListByMap(map));
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
		model.addAttribute("paging", pageUtil.getPaging(request.getContextPath() + "/qnaboard/list"));
		
	}

	@Override
	public void saveQnaBoard(HttpServletRequest request, HttpServletResponse response) {
		String nickname = request.getParameter("nickname");
		String content = request.getParameter("content");
		String title = request.getParameter("title");
		String Ip = request.getRemoteAddr();
		int pw = 0;
		
		if(request.getParameter("password") == null || "".equals(request.getParameter("password"))) {
			pw = 0;
		}else {
			pw = Integer.parseInt(request.getParameter("password"));
		}
		
		QnaBoardDTO post = QnaBoardDTO.builder()
				.nickname(nickname)
				.title(title)
				.content(content)
				.ip(Ip)
				.pw(pw)
				.build();
		
		int result = qnaboardMapper.insertQnaBoard(post);
		
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			if(result > 0) {
				


				out.println("alert('게시글이 등록되었습니다.');");
				out.println("location.href='/qna/list';");
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
	public int increseQnaBoardHit(int qaNo) {
		return qnaboardMapper.updateHit(qaNo);
	}

	@Override
	public QnaBoardDTO getQnaBoardByNo(int qaNo) {
		return qnaboardMapper.selectQnaBoardByNo(qaNo);
	}

	@Override
	public void modifyQnaBoard(HttpServletRequest request, HttpServletResponse response) {
		 QnaBoardDTO qna = new QnaBoardDTO();
		 qna.setTitle(request.getParameter("title"));
		 qna.setContent(request.getParameter("content"));
		 qna.setQaNo(Integer.parseInt(request.getParameter("qaNo")));
	      int result = qnaboardMapper.updateQnaBoard(qna);
	      response.setContentType("text/html; charset=UTF-8");
	      try {
	         PrintWriter out = response.getWriter();
	         if(result > 0) {  // if(result == 1) {
	            out.println("<script>");
	            out.println("alert('게시글이 수정되었습니다.');");
	            out.println("location.href='" + request.getContextPath() + "/qna/list';");
	            out.println("</script>");
	         } else {
	            out.println("<script>");
	            out.println("alert('게시글이 수정되지 않았습니다.');");
	            out.println("history.back();");
	            out.println("</script>");
	         }
	         out.close();
	      } catch(Exception e) {
	         e.printStackTrace();
	      }
		
	}

	@Override
	public void removeQnaBoard(HttpServletRequest request, HttpServletResponse response) {
		int qaNo = Integer.parseInt(request.getParameter("qaNo"));
         
         int result = qnaboardMapper.deleteQnaBoard(qaNo);
         response.setContentType("text/html; charset=UTF-8");
         try {
            PrintWriter out = response.getWriter();
            if(result > 0) {  // if(result == 1) {
               out.println("<script>");
               out.println("alert('게시글이 삭제되었습니다.');");
               out.println("location.href='" + request.getContextPath() + "/qna/list';");  
               out.println("</script>");
            } else {
               out.println("<script>");
               out.println("alert('게시글이 삭제되지 않았습니다.');");
               out.println("history.back();");
               out.println("</script>");
            }
            out.close();
         } catch(Exception e) {
            e.printStackTrace();
         }
   }

	@Override
	public int getQnaBoardPw(HttpServletRequest request, HttpServletResponse response) {
		QnaBoardDTO qna = new QnaBoardDTO();
		 qna.setQaNo(Integer.parseInt(request.getParameter("qaNo")));
		 qna.setPw(Integer.parseInt(request.getParameter("password")));
		return qnaboardMapper.selectQnaBoardPwCount(qna);
	}
	
	
	
	
	
	
	
}