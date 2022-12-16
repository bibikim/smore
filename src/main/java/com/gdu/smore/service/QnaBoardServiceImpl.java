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
      
      // 페이징 처리에 필요한 변수 계산
      pageUtil.setPageUtil(page, totalRecord);
      
      // 조회 조건으로 사용할 Map 만들기
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("begin", pageUtil.getBegin());
      map.put("end", pageUtil.getEnd());
      
      // 뷰로 전달할 데이터를 model에 저장하기 
      model.addAttribute("totalRecord", totalRecord);
      model.addAttribute("qnaboardList", qnaboardMapper.selectQnaBoardListByMap(map));
      model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
      model.addAttribute("paging", pageUtil.getPaging(request.getContextPath() + "/qnaboard/list"));
      
   }

   @Override
   public void saveQnaBoard(HttpServletRequest request, HttpServletResponse response) {
      String nickname = request.getParameter("nickname");
      String content = request.getParameter("qContent");
      String title = request.getParameter("qTitle");
      
      Optional<String> opt = Optional.ofNullable(request.getHeader("X-Forwarded-For"));
      String qIp = opt.orElse(request.getRemoteAddr());
      
      
      QnaBoardDTO qpost = QnaBoardDTO.builder()
            .nickname(nickname)
            .qTitle(title)
            .qContent(content)
            .qIp(qIp)
            .build();
      
      int result = qnaboardMapper.insertQnaBoard(qpost);
      
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
   public int increseQnaBoardHit(int qNo) {
      return qnaboardMapper.updateHit(qNo);
   }

   @Override
   public QnaBoardDTO getQnaBoardByNo(int qNo) {
      return qnaboardMapper.selectQnaBoardByNo(qNo);
   }

   @Override
   public void modifyQnaBoard(HttpServletRequest request, HttpServletResponse response) {
       QnaBoardDTO qna = new QnaBoardDTO();
       qna.setQTitle(request.getParameter("title"));
       qna.setQContent(request.getParameter("content"));
       qna.setQNo(Integer.parseInt(request.getParameter("qNo")));
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
      int qNo = Integer.parseInt(request.getParameter("qNo"));
         
         int result = qnaboardMapper.deleteQnaBoard(qNo);
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
   
   
   
   
   
   
   
}