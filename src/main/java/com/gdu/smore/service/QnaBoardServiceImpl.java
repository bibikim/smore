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
import com.gdu.smore.domain.qna.QnaCommentDTO;
import com.gdu.smore.mapper.QnaBoardMapper;
import com.gdu.smore.util.QnaPageUtil;

@Service
public class QnaBoardServiceImpl implements QnaBoardService {
	
	private QnaBoardMapper qnaboardMapper;
	private QnaPageUtil pageUtil;
	
	@Autowired
	public void set(QnaBoardMapper qnaboardMapper, QnaPageUtil pageUtil) {
		this.qnaboardMapper = qnaboardMapper;
		this.pageUtil = pageUtil;
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
		
		// 페이지 출력 개수
		int pageCount = 10;
		// offset
		int offset = (page - 1) * pageCount;
		
		// 조회 조건으로 사용할 Map 만들기
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageCount);
		map.put("end", offset);
		
		pageUtil.setPageUtil(page, totalRecord);
		
		// 뷰로 전달할 데이터를 model에 저장하기 
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("qnaboardList", qnaboardMapper.selectQnaBoardListByMap(map));
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
		model.addAttribute("paging", pageUtil.getPaging("/qna/list"));
		
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
	            out.println("location.href='" + "/qna/list';");
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
               out.println("location.href='"  + "/qna/list';");  
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
	
	@Override
	public QnaCommentDTO getQnaCmtByNo(int cmtNo) {
		return qnaboardMapper.selectQnaCmtByNo(cmtNo);
	}

	@Override
	public void removeQnaComment(HttpServletRequest request, HttpServletResponse response) {
		int cmtNo = Integer.parseInt(request.getParameter("cmtNo"));
        
        int result = qnaboardMapper.deleteQnaComment(cmtNo);
        QnaBoardDTO qna = new QnaBoardDTO();
		 	qna.setQaNo(Integer.parseInt(request.getParameter("qaNo")));
		 	qna.setAnswer(0);
		 	qnaboardMapper.updateAnswer(qna);
        response.setContentType("text/html; charset=UTF-8");
        try {
           PrintWriter out = response.getWriter();
           if(result > 0) {  // if(result == 1) {
	    	   	
              out.println("<script>");
              out.println("alert('답변이 삭제되었습니다.');");
              out.println("location.href='" + "/qna/list';");  
              out.println("</script>");
           } else {
              out.println("<script>");
              out.println("alert('답변이 삭제되지 않았습니다.');");
              out.println("history.back();");
              out.println("</script>");
           }
           out.close();
        } catch(Exception e) {
           e.printStackTrace();
        }
	}

	@Override
	public void saveQnaComment(HttpServletRequest request, HttpServletResponse response) {
		int qaNo = Integer.parseInt(request.getParameter("qaNo"));
		String nickname = request.getParameter("nickname");
		String cmtContent = request.getParameter("cmtContent");
		String Ip = request.getRemoteAddr();
		
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			QnaBoardDTO qb = qnaboardMapper.selectQnaBoardByNo(qaNo);
			if(qb == null) {
				out.println("<script>");
				out.println("alert('등록된 QNA가 없습니다.');");
				out.println("location.href='/qna/list';");
				out.println("</script>");
				out.close();
			}
			
			QnaCommentDTO post = QnaCommentDTO.builder()
					.nickname(nickname)
					.qaNo(qaNo)
					.cmtContent(cmtContent)
					.ip(Ip)
					.build();
			
			int result = qnaboardMapper.insertQnaComment(post);
			QnaBoardDTO qna = new QnaBoardDTO();
  		 	qna.setQaNo(qaNo);
  		 	qna.setAnswer(1);
  		 	qnaboardMapper.updateAnswer(qna);
			out.println("<script>");
			if(result > 0) {
				
				out.println("alert('답변이 등록되었습니다.');");
				out.println("location.href='/qna/list';");
			} else {
				out.println("alert('답변 등록이 되지 않았습니다.);");
				out.println("history.back();");
			}
			out.println("</script>");
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	
}