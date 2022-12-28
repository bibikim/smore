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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.gdu.smore.domain.AllBoardDTO;
import com.gdu.smore.domain.user.AllUserDTO;
import com.gdu.smore.domain.user.RetireUserDTO;
import com.gdu.smore.domain.user.SleepUserDTO;
import com.gdu.smore.domain.user.UserDTO;
import com.gdu.smore.mapper.AdminMapper;
import com.gdu.smore.mapper.UserMapper;
import com.gdu.smore.util.NaverPageUtil;
import com.gdu.smore.util.PageUtil;

@PropertySource(value = {"classpath:application.yml"})
@Service
public class AdminServiceImpl implements AdminService {

   @Autowired
   private AdminMapper adminMapper;
   
   @Autowired
   private UserMapper userMapper;
   
   @Autowired
   private PageUtil pageUtil;
   
   @Autowired 
   private NaverPageUtil naverPageUtil;  
   
   @Override
   public Map<String, Object> getAllUserList(int page) {
	   int userCnt = adminMapper.selectUserCount();
	   int sleepCnt = adminMapper.selectSleepUserCount(); 
	   
	   int totalRecord = userCnt + sleepCnt;
	   
	   naverPageUtil.setNaverPageUtil(page, totalRecord);
	   
	   Map<String, Object> map = new HashMap<String, Object>();
	   map.put("begin", naverPageUtil.getBegin() - 1);
	   map.put("end", naverPageUtil.getEnd());
	   
	   Map<String, Object> result = new HashMap<String, Object>();
	   result.put("allUserList", adminMapper.selectAllUserList(map));
	   result.put("naverPageUtil", naverPageUtil);
	   return result;    
   }
      
   
   @Override
	public Map<String, Object> getCommonUserList(int page) {  
	   
	   int totalRecord = adminMapper.selectUserCount();
	   naverPageUtil.setNaverPageUtil(page, totalRecord);
		      
	   Map<String, Object> map = new HashMap<String, Object>();
	   map.put("begin", naverPageUtil.getBegin() -1);
	   map.put("end", naverPageUtil.getEnd());
	  
	   Map<String, Object> result = new HashMap<String, Object>();
	   result.put("userList", adminMapper.selectUserListByMap(map));
	   result.put("naverPageUtil", naverPageUtil);
	  
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
      result.put("sleepUserList", adminMapper.selectSleepUserListByMap(map));
      result.put("naverPageUtil", pageUtil);
      return result;
   }
   
   @Transactional
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
	public Map<String, Object> removeStudList(String studNoList) {
		List<String> list = Arrays.asList(studNoList.split(","));
		Map<String, Object> result = new HashMap<String, Object>();
       result.put("deleteResult", adminMapper.deleteStudyBoardList(list));	 
		return result;
	}
   
   
   @Override
	public Map<String, Object> removeFreeList(String freeNoList) {
		List<String> list = Arrays.asList(freeNoList.split(","));
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("deleteResult", adminMapper.deleteFreeBoardList(list));	 
		return result;
	}
   
   @Override
	public Map<String, Object> removeCodeList(String codeNoList) {
	   List<String> list = Arrays.asList(codeNoList.split(","));
	   Map<String, Object> result = new HashMap<String, Object>();
       result.put("deleteResult", adminMapper.deleteCodeBoardList(list));	 
	   return result;
	}
   
   @Override
	public Map<String, Object> removeQnaList(String qnaNoList) {
	   List<String> list = Arrays.asList(qnaNoList.split(","));
	   Map<String, Object> result = new HashMap<String, Object>();
       result.put("deleteResult", adminMapper.deleteQnaBoardList(list));	 
	   return result;
	}
   
   
   @Transactional
   @Override
	public Map<String, Object> toCommonUserList(String userNoList) {
		List<String> list = Arrays.asList(userNoList.split(","));
		for(int i = 0; i < list.size(); i++) {			
			SleepUserDTO sleepUserDTO = adminMapper.selectSleepUserByNo(Integer.parseInt(list.get(i)));				
			UserDTO userDTO = new UserDTO();
			userDTO.setUserNo(sleepUserDTO.getUserNo());
			userDTO.setId(sleepUserDTO.getId());
			userDTO.setNickname(sleepUserDTO.getNickname());
			userDTO.setPw(sleepUserDTO.getPw());
			userDTO.setName(sleepUserDTO.getName());
			userDTO.setGrade(sleepUserDTO.getGrade());
			userDTO.setGender(sleepUserDTO.getGender());
			userDTO.setEmail(sleepUserDTO.getEmail());
			userDTO.setMobile(sleepUserDTO.getMobile());
			userDTO.setBirthyear(sleepUserDTO.getBirthyear());
			userDTO.setBirthday(sleepUserDTO.getBirthday());
			userDTO.setPostcode(sleepUserDTO.getPostcode());
			userDTO.setRoadAddress(sleepUserDTO.getRoadAddress());
			userDTO.setJibunAddress(sleepUserDTO.getJibunAddress());
			userDTO.setDetailAddress(sleepUserDTO.getDetailAddress());
			userDTO.setExtraAddress(sleepUserDTO.getExtraAddress());
			userDTO.setAgreeCode(sleepUserDTO.getAgreeCode());
			userDTO.setSnsType(sleepUserDTO.getSnsType());
			userDTO.setUserState(sleepUserDTO.getUserState());
			userDTO.setJoinDate(sleepUserDTO.getJoinDate());
			userDTO.setLastLoginDate(sleepUserDTO.getLastLoginDate());
			userMapper.insertUser(userDTO);
			adminMapper.updateAccessInfo(userDTO.getId());
		}
		 Map<String, Object> result = new HashMap<String, Object>();
	     result.put("deleteSleep", adminMapper.deleteSleepUserList(list));
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
      result.put("naverPageUtil", pageUtil);
      return result;
   }
   

   
   @Override
   public Map<String, Object> getFreeBoardList(int page) {
      
      int totalRecord = adminMapper.selectFreeBoardCount();
      pageUtil.setPageUtil(page, totalRecord);
      
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("begin", pageUtil.getBegin() -1);
      map.put("end", pageUtil.getEnd());
      
      Map<String, Object> result = new HashMap<String, Object>();
      result.put("freeBoardList", adminMapper.selectFreeListByMap(map));
      result.put("naverPageUtil", pageUtil);
      return result;
      
   }
   
   @Override
   public Map<String, Object> getStudyList(int page) {
      
      int totalRecord = adminMapper.selectSGroupBoardCount();
      pageUtil.setPageUtil(page, totalRecord);
      
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("begin", pageUtil.getBegin() - 1);
      map.put("end", pageUtil.getEnd());
      
      Map<String, Object> result = new HashMap<String, Object>();
      result.put("studyList", adminMapper.selectStudyListByMap(map));
      result.put("naverPageUtil", pageUtil);
      return result;
   }
   
   @Override
	public Map<String, Object> getCodeList(int page) {
		
	   int totalRecord = adminMapper.selectCodeBoardCount();
	   pageUtil.setPageUtil(page, totalRecord);
	   
	   Map<String, Object> map = new HashMap<String, Object>();
	   map.put("begin", pageUtil.getBegin() -1);
       map.put("end", pageUtil.getEnd());
      
       Map<String, Object> result = new HashMap<String, Object>();
       result.put("codeList", adminMapper.selectCodeListByMap(map));
       result.put("naverPageUtil", pageUtil);
       return result;
	}
   
   @Override
	public Map<String, Object> getQnaList(int page) {
		int totalRecord = adminMapper.selectQnaBoardCount();
		pageUtil.setPageUtil(page, totalRecord);
		
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("begin", pageUtil.getBegin() -1);
        map.put("end", pageUtil.getEnd());
        
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("qnaList", adminMapper.selectQnaListByMap(map));
        result.put("naverPageUtil", pageUtil);
        return result;
	}
   
   
   @Override
	public Map<String, Object> findUsers(HttpServletRequest request, int page) {
	   		
		String column = request.getParameter("column");
		System.out.println(column);
		String query = request.getParameter("query");
		String start = request.getParameter("start");
		String stop = request.getParameter("stop");
	 	
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("column", column);
		map.put("query", query);
		map.put("start", start);
		map.put("stop", stop);
		
		int totalRecord = adminMapper.selectAllUserCountByQuery(map);
		naverPageUtil.setNaverPageUtil(page, totalRecord);		
		map.put("begin", naverPageUtil.getBegin());
		map.put("end", naverPageUtil.getEnd());
		
		List<AllUserDTO> users = adminMapper.selectUsersByQuery(map);
		String path = null;
		
		switch(column) {
		case "ID":
		case "NICKNAME" : 	
			path = "/users/search?column=" + column + "&query=" + query;
			break;
		case "JOIN_DATE":
			path = "/users/search?column=" + column + "&start=" + start + "&stop=" + stop;
			break;	
		}
				
		Map<String, Object> result = new HashMap<>();
		if(users.size() == 0) {
			result.put("message", "조회된 결과가 없습니다.");
			result.put("status", 500);
		} else {
			result.put("users", users);
			result.put("naverPageUtil", naverPageUtil.getNaverPaging(path));
			result.put("status", 200);
		}
		
		return result;
		
	}
   
   @Override
	public Map<String, Object> findBoards(HttpServletRequest request, int page) {
		
		String board = request.getParameter("board");
		String column2 = request.getParameter("column2");
		String query2 = request.getParameter("query2");
		String start2 = request.getParameter("start2");
		String stop2 = request.getParameter("stop2");
	   
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("column2", column2);
		map.put("query2", query2);
		map.put("start2", start2);
		map.put("stop2", stop2);
		
		int totalRecord = 0;
		
		List<AllBoardDTO> list = null;
						
		if(board.equals("FREE")) {
			totalRecord  = adminMapper.selectFreeBoardByCountQuery(map);
			System.out.println(totalRecord);
			naverPageUtil.setNaverPageUtil(page, totalRecord);		
			map.put("begin", naverPageUtil.getBegin());
			map.put("end", naverPageUtil.getEnd());
			list = adminMapper.selectFreeBoardByQuery(map);
		} else if(board.equals("CODE")) {
			totalRecord = adminMapper.selectCodeBoardByCountQuery(map);
			naverPageUtil.setNaverPageUtil(page, totalRecord);		
			map.put("begin", naverPageUtil.getBegin());
			map.put("end", naverPageUtil.getEnd());
			list = adminMapper.selectCodeBoardByQuery(map);
		} else if(board.equals("STUDY")) {
			totalRecord = adminMapper.selectStudyBoardByCountQuery(map);
			naverPageUtil.setNaverPageUtil(page, totalRecord);		
			map.put("begin", naverPageUtil.getBegin());
			map.put("end", naverPageUtil.getEnd());
			list= adminMapper.selectStudyBoardByQuery(map);
		} else if(board.equals("QNA")) {
			totalRecord = adminMapper.selectQnaBoardByCountQuery(map);
			naverPageUtil.setNaverPageUtil(page, totalRecord);		
			map.put("begin", naverPageUtil.getBegin());
			map.put("end", naverPageUtil.getEnd());
			list = adminMapper.selectQnaBoardByQuery(map);
		}
		
		System.out.println(list);
		String path = null;
		
		switch(column2) {
		case "NICKNAME":
		case "TITLE" : 	
			path = "/boards/search/page?column2=" + column2 + "&query2=" + query2;
			break;
		case "CREATE_DATE":
			path = "/boards/search/page?column2=" + column2 + "&start2=" + start2 + "&stop2=" + stop2;
			break;	
		}
				
		Map<String, Object> result = new HashMap<>();
		if((list.size() == 0)) {
			result.put("message", "조회된 결과가 없습니다.");
			result.put("status", 500);
		} else {
			result.put("boards", list);
			result.put("naverPageUtil", naverPageUtil.getNaverPaging(path));
			result.put("status", 200);
		}
				
		return result;
	}
   
   
   
   
   
   
}