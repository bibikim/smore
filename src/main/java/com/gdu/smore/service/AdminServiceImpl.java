package com.gdu.smore.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gdu.smore.domain.user.AllUserDTO;
import com.gdu.smore.domain.user.RetireUserDTO;
import com.gdu.smore.domain.user.UserDTO;
import com.gdu.smore.mapper.AdminMapper;
import com.gdu.smore.util.PageUtil;

@PropertySource(value = {"classpath:application.yml"})
@Service
public class AdminServiceImpl implements AdminService {

   @Autowired
   private AdminMapper adminMapper;
   
   @Autowired
   private PageUtil pageUtil;
   
   @Override
   public Map<String, Object> getUserList(int page) {
      
      int totalRecord = adminMapper.selectUserCount() + adminMapper.selectSleepUserCount();
      pageUtil.setPageUtil(page, totalRecord);
      
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("begin", pageUtil.getBegin());
      map.put("end", pageUtil.getEnd());
      
      Map<String, Object> result = new HashMap<String, Object>();
      result.put("userList", adminMapper.selectUserListByMap(map));
      result.put("sleepList", adminMapper.selectSleepUserListByMap(map));
      result.put("pageUtil", pageUtil);
      return result;
   }
   
   
   @Override
   public Map<String, Object> removeUserList(String userNoList) {
      List<String> list = Arrays.asList(userNoList.split(","));
      for(int i = 0; i < list.size(); i++) {
         UserDTO userDTO =adminMapper.selectUserByNo(Integer.parseInt(list.get(i)));
         
         RetireUserDTO retireUserDTO = new RetireUserDTO();
         retireUserDTO.setUserNo(userDTO.getUserNo());
         retireUserDTO.setId(userDTO.getId());
         retireUserDTO.setJoinDate(userDTO.getJoinDate());
         adminMapper.insertRetireUser(retireUserDTO);
      }
      Map<String, Object> result = new HashMap<String, Object>();
      result.put("deleteResult", adminMapper.deleteUserList(list));
      return result;
   }

   @Override
   public Map<String, Object> getreportUserList(int page) {
      int totalRecord = adminMapper.selectReportUserCount();
      pageUtil.setPageUtil(page, totalRecord);
      
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("begin", pageUtil.getBegin());
      map.put("end", pageUtil.getEnd());
      
      Map<String, Object> result = new HashMap<String, Object>();
      result.put("reportUserList", adminMapper.selectReportUserList(map));
      System.out.println(result);
      result.put("pageUtil", pageUtil);
      return result;
   }
   
   @Override
   public Map<String, Object> getSleepUserList(int page) {
      
      int totalRecord = adminMapper.selectSleepUserCount();
      pageUtil.setPageUtil(page, totalRecord);
      
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("begin", pageUtil.getBegin());
      map.put("end", pageUtil.getEnd());
      
      Map<String, Object> result = new HashMap<String, Object>();
      result.put("sleepuserList", adminMapper.selectSleepUserListByMap(map));
      result.put("pageUtil", pageUtil);
      return result;
   }
   
   @Override
   public Map<String, Object> getFreeBoardList(int page) {
      
      int totalRecord = adminMapper.selectFreeBoardCount();
      pageUtil.setPageUtil(page, totalRecord);
      
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("begin", pageUtil.getBegin());
      map.put("end", pageUtil.getEnd());
      
      Map<String, Object> result = new HashMap<String, Object>();
      result.put("freeBoardList", adminMapper.selectFreeListByMap(map));
      System.out.println(result);
      result.put("pageUtil", pageUtil);
      return result;
      
   }
   
   @Override
   public Map<String, Object> getStudyList(int page) {
      
      int totalRecord = adminMapper.selectSGroupBoardCount();
      pageUtil.setPageUtil(page, totalRecord);
      
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("begin", pageUtil.getBegin());
      map.put("end", pageUtil.getEnd());
      
      Map<String, Object> result = new HashMap<String, Object>();
      result.put("studyList", adminMapper.selectStudyListByMap(map));
      System.out.println(result);
      result.put("pageUtil", pageUtil);
      return result;
   }
   
   @Override
	public Map<String, Object> findUsers(HttpServletRequest request) {
	   
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
	   
	    String state = request.getParameter("state");
		String column = request.getParameter("column");
		String query = request.getParameter("query");
		String start = request.getParameter("start");
		String stop = request.getParameter("stop");
	   
		Map<String, Object> map = new HashMap<>();
		map.put("column", column);
		map.put("query", query);
		map.put("start", start);
		map.put("stop", stop);
		
		int totalRecord = 0;
		List<AllUserDTO> users = null;
		
		if(state.equals("active")) {
			totalRecord = adminMapper.selectUserCountByQuery(map);
			pageUtil.setPageUtil(page, totalRecord);			
			map.put("begin", pageUtil.getBegin());
			map.put("end", pageUtil.getEnd());
			users = adminMapper.selectUsersByQuery(map);
			System.out.println(users);
		}
			
		String path = null;
		
		switch(column) {
		case "ID":
			path =  "/users/search?column=" + column + "&query=" + query;
			break;
		case "JOIN_DATE":
			path = "/users/search?column=" + column + "&start=" + start + "&stop=" + stop;
			break;	
		}
		
		Map<String, Object> result = new HashMap<>();
		if(users.size() == 0) {
			result.put("message", "조회된 결과가 없습니다.");
			result.put("totalRecord", totalRecord);
			result.put("status", 500);
		} else {
			result.put("users", users);
			result.put("totalRecord", totalRecord);
			result.put("paging", pageUtil.getPaging(path));
			result.put("status", 200);
		}
		
		return result;
		
	}
   
   
}