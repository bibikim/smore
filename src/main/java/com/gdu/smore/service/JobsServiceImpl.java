package com.gdu.smore.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gdu.smore.domain.jobs.JobsDTO;
import com.gdu.smore.mapper.JobsMapper;
import com.gdu.smore.util.PageUtil;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class JobsServiceImpl implements JobsService{

	private JobsMapper jobMapper;
	private PageUtil pageUtil;
	
	@Override
	public void getJobsList(HttpServletRequest request, Model model) {  // map만 ajax 가능.. model은 jsp 화면에 뿌리기 위함이라 ${}로 가져오는게 model을 매개변수로 받아왔을때
		
		// 전체 구인 공고 개수
		int totalRecord = jobMapper.selectListCount();
		
		// 첫 페이지
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		pageUtil.setPageUtil(page, totalRecord);
		
		// 한 페이지에 뿌려지는 글 목록 수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin() - 1);   // mysql은 0부터 시작하므로 begin이 pageUtil에서 1을 가지므로 -1 해주기
		map.put("recordPerPage", pageUtil.getRecordPerPage()); 
		
		// 페이징
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
		model.addAttribute("paging", pageUtil.getPaging(request.getContextPath() + "/job/list"));
		
		// 검색기능
		String type = request.getParameter("type");
		String keyword = request.getParameter("keyword");
		map.put("type", type);
		map.put("keyword", keyword);
		
		// 글 목록
		List<JobsDTO> jobs = jobMapper.selectJobsListByMap(map);
		model.addAttribute("jobList" ,jobs);
		
	}
	
	@Override
	public void saveJobs(HttpServletRequest request, HttpServletResponse response) {


		
		JobsDTO job = JobsDTO.builder()
				.title(request.getParameter("title"))
				.nickname(request.getParameter("nickname"))
				.companyName(request.getParameter("companyName"))
				.contact(request.getParameter("contact"))
				.homepage(request.getParameter("homepage"))
				.profile(request.getParameter("profile"))
				.hrName(request.getParameter("hrName"))
				.hrContact(request.getParameter("hrContact"))
				.hrEmail(request.getParameter("hrEmail"))
				.location(request.getParameter("location"))
				.position(request.getParameter("position"))
				.jobType(request.getParameter("jobType"))
				.content(request.getParameter("content"))
				.career(request.getParameter("career"))
				//.status(status)
				.skillStack(request.getParameter("skillStack"))
				.build();
		
		int result = jobMapper.insertJobs(job);
		
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			
			if(result > 0) {
				
				out.println("alert('구인 공고 게시글이 등록되었습니다.');");
				out.println("location.href='/job/list';");
				
			} else {
				
				out.println("alert('게시글이 등록되지 않았습니다.');");
				out.println("history.back();");
				
			}
			
			out.println("</script>");
			out.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public JobsDTO getJobsByNo(int jobNo) {

		JobsDTO job = jobMapper.selectJobsByNo(jobNo);  // mapper의 반환타입과 여기서 반환타입 같아야 함
		return job;
	}
	
	@Override
	public int increaseHit(int jobNo) {
		return jobMapper.updateHit(jobNo);
	}
	
	@Override
	public void editJobs(HttpServletRequest request, HttpServletResponse response) {
		
		int jobNo = Integer.parseInt(request.getParameter("jobNo"));
		//int status = Integer.parseInt(request.getParameter("status"));
		
		JobsDTO job = JobsDTO.builder()
				.jobNo(jobNo)
				.title(request.getParameter("title"))
				.nickname(request.getParameter("nickname"))
				.contact(request.getParameter("contact"))
				.homepage(request.getParameter("homepage"))
				.profile(request.getParameter("profile"))
				.hrName(request.getParameter("hrName"))
				.hrContact(request.getParameter("hrContact"))
				.hrEmail(request.getParameter("hrEmail"))
				.location(request.getParameter("location"))
				.position(request.getParameter("position"))
				.jobType(request.getParameter("jobType"))
				.content(request.getParameter("content"))
				.career(request.getParameter("career"))
				//.status(status)
				.skillStack(request.getParameter("skillStack"))
				.build();
		
		
		int result = jobMapper.modifyJobs(job);
		
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			
			if(result > 0) {
				
				out.println("alert('채용 공고 게시글이 수정되었습니다.');");
				out.println("location.href='/job/detail?jobNo=" + jobNo + "';");
				
			} else {
				
				out.println("alert('게시글 수정에 실패했습니다. 확인해주세요');");
				out.println("history.back();");
				
			}
			
			out.println("</script>");
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void removeJobs(HttpServletRequest request, HttpServletResponse response) {
		
		int jobNo = Integer.parseInt(request.getParameter("jobNo"));
		int result = jobMapper.deleteJobs(jobNo);
		
			
			try {
				
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				
				out.println("<script>");
				if(result > 0) {
					
					out.println("alert('게시글이 삭제되었습니다.');");
					out.println("location.href='/job/list'");
					
				} else {
					
					out.println("alert('게시글 삭제에 실패했습니다.');");
					out.println("history.back();");
					
				}
				
				out.println("</script>");
				out.close();
				
			} catch(Exception e) {
				e.printStackTrace();
			}
			
	}
	
	//
	
	@Override
	public void changeStatus(HttpServletRequest request ,HttpServletResponse response) { // request는 서버로 보내고, response가 화면에 뿌려주는것..
		System.out.println(request.getParameter("jobNo"));
		int jobNo = Integer.parseInt(request.getParameter("jobNo"));
		int result = jobMapper.updateStatus(jobNo);
		
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			
			if(result > 0) {
				
				out.println("alert('채용 마감 처리 되었습니다.');");
				out.println("location.href='/job/list'");
				//out.println("location.href='/job/detail?jobNo" + jobNo);
				
			} else {
				
				out.println("alert('요청이 제대로 들어가지 않았습니다. 다시 한번 확인해해주세요.');");
				out.println("history.back();");
				
			}
			
			out.println("</script>");
			out.close();
		
		} catch(Exception e) {
			
			e.printStackTrace();
			
		}
	}
	
	
	
	
}
