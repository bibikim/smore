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
	public void getJobsList(HttpServletRequest request, Model model) {
		
		// 전체 구인 공고 개수
		int totalRecord = jobMapper.selectListCount();
		
		// 첫 페이지
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		pageUtil.setPageUtil(page, totalRecord);
		
		// 한 페이지에 뿌려지는 글 목록 수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin() - 1);
		map.put("recordPerPage", pageUtil.getRecordPerPage());
		
		// 페이징
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
		model.addAttribute("paging", pageUtil.getPaging(request.getContextPath() + "/free/list/job/list"));
		
		// 글 목록
		List<JobsDTO> jobs = jobMapper.selectJobsListByMap(map);
		model.addAttribute("jobList" ,jobs);
	}
	
	@Override
	public void saveJobs(HttpServletRequest request, HttpServletResponse response) {
	
		JobsDTO job = JobsDTO.builder()
				.title(request.getParameter("title"))
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
				.build();
		
		int result = jobMapper.insertJobs(job);
		
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			
			if(result > 0) {
				
				out.println("alert('구인 공고 게시글이 등록되었습니다.');");
				out.println("location.href='/free/list/job/list';");
				
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
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public void removeJobs(HttpServletRequest reuqest, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}
	
	
}
