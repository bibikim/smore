package com.gdu.smore.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gdu.smore.domain.user.RetireUserDTO;
import com.gdu.smore.domain.user.SleepUserDTO;
import com.gdu.smore.domain.user.UserDTO;
import com.gdu.smore.mapper.UserMapper;
import com.gdu.smore.util.JavaMailUtil;
import com.gdu.smore.util.SecurityUtil;

@Service
public class UserServiceImpl implements UserService {

   @Autowired
   private UserMapper userMapper;   
   @Autowired
   private SecurityUtil securityUtil;
   @Autowired
   private JavaMailUtil javaMailUtil;
   
   @Override
   public Map<String, Object> isReduceId(String id) {
      
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("id", id);
      
      Map<String, Object> result = new HashMap<String, Object>();
      result.put("isUser", userMapper.selectUserByMap(map) != null);
      result.put("isRetireUser", userMapper.selectRetireUserById(id) != null);
      result.put("isSleepUser", userMapper.selectSleepUserById(id) != null);
      return result;
   }
   
   @Override
   public Map<String, Object> isReduceEmail(String email) {
      
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("email", email);
      
      Map<String, Object> result = new HashMap<String, Object>();
      result.put("isUser", userMapper.selectUserByMap(map) != null);
      return result;
   }
   
   @Override
	public Map<String, Object> sendAuthCode(String email) {
		
		// ???????????? ?????????
		String authCode = securityUtil.getAuthCode(6);
		
		// ?????? ??????
		javaMailUtil.sendJavaMail(email, "[Application] ????????????", "??????????????? <strong>" + authCode + "</strong>?????????.");
		// join.jsp??? ????????? ??????????????? ???????????? ???
		// ????????? ???????????? ????????? ??????????????? ????????? ??? ??? ??????
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("authCode", authCode);
		return result;
		
	}
   
	@Transactional
	@Override
	public void join(HttpServletRequest request, HttpServletResponse response) {
      
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String nickname = request.getParameter("nickname");
		String gender = request.getParameter("gender");
		String mobile = request.getParameter("mobile");
		int grade = Integer.parseInt(request.getParameter("grade"));
		String birthyear = request.getParameter("birthyear");
		String birthmonth = request.getParameter("birthmonth");
		String birthdate = request.getParameter("birthdate");
		String postcode = request.getParameter("postcode");
		String roadAddress = request.getParameter("roadAddress");
		String jibunAddress = request.getParameter("jibunAddress");
		String detailAddress = request.getParameter("detailAddress");
		String extraAddress = request.getParameter("extraAddress");
		String email = request.getParameter("email");
		String location = request.getParameter("location");
		String promotion = request.getParameter("promotion");
            
		pw = securityUtil.sha256(pw);
		 
		name = securityUtil.preventXSS(name);
		nickname = securityUtil.preventXSS(nickname);
		String birthday = birthmonth + birthdate;
		detailAddress = securityUtil.preventXSS(detailAddress);
		int agreeCode = 0;  // ?????? ??????
		if(!location.isEmpty() && promotion.isEmpty()) {
			agreeCode = 1;  // ?????? + ??????
		} else if(location.isEmpty() && !promotion.isEmpty()) {
			agreeCode = 2;  // ?????? + ????????????
		} else if(!location.isEmpty() && !promotion.isEmpty()) {
			agreeCode = 3;  // ?????? + ?????? + ????????????
		}
      
		UserDTO user = UserDTO.builder()
        	.id(id)
            .pw(pw)
            .name(name)
            .nickname(nickname)
            .gender(gender)
            .email(email)
            .mobile(mobile)
            .grade(grade)
            .birthyear(birthyear)
            .birthday(birthday)
            .postcode(postcode)
            .roadAddress(roadAddress)
            .jibunAddress(jibunAddress)
            .detailAddress(detailAddress)
            .extraAddress(extraAddress)
            .agreeCode(agreeCode)
            .build();
            
      int result = userMapper.insertUser(user);
      
      try {
         response.setContentType("text/html; charset=UTF-8");
         PrintWriter out = response.getWriter();
         
         if(result > 0) {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("id", id);
            
            request.getSession().setAttribute("loginUser", userMapper.selectUserByMap(map));
            
            int updateResult = userMapper.updateAccessLog(id);
            if(updateResult == 0) {
               userMapper.insertAccessLog(id);
            }
            out.println("<script>");
            out.println("alert('?????? ?????????????????????.');");
            out.println("location.href='/';");
            out.println("</script>");
            
         } else {
            out.println("<script>");
            out.println("alert('?????? ????????? ??????????????????.');");
            out.println("history.go(-2);");
            out.println("</script>");
         }
         out.close();
         
      } catch(Exception e) {
         e.printStackTrace();
      }
   }
   
    @Override
    public void login(HttpServletRequest request, HttpServletResponse response) {
          
       String url = request.getParameter("url");
       String id = request.getParameter("id");
       String pw = request.getParameter("pw");
       
       pw = securityUtil.sha256(pw);
       
       Map<String, Object> map = new HashMap<String, Object>();
       map.put("id", id);
       map.put("pw", pw);
       
       UserDTO loginUser = userMapper.selectUserByMap(map);       
       
       if(loginUser != null) {
    	  keepLogin(request, response);
    	  request.getSession().setAttribute("loginUser", loginUser);
    	  
          int updateResult = userMapper.updateAccessLog(id);
          if(updateResult == 0) {
             userMapper.insertAccessLog(id);
          }
          
          try {
             response.sendRedirect(url);
          } catch (IOException e) {
             e.printStackTrace();
           }            
       } else {
          try {         
               response.setContentType("text/html; charset=UTF-8");
               PrintWriter out = response.getWriter();
               out.println("<script>");
               out.println("alert('???????????? ??????????????? ????????????.')");
               out.println("location.href='/';");
               out.println("</script>");
               out.close();
          } catch (Exception e) {
             e.printStackTrace();
          }
       }
   }
    
    @Override
   public void keepLogin(HttpServletRequest request, HttpServletResponse response) {
      
      String id = request.getParameter("id");
      String keepLogin = request.getParameter("keepLogin");
      
      if(keepLogin != null) {
         String sessionId = request.getSession().getId();
         
         Cookie cookie = new Cookie("keepLogin", sessionId);
         cookie.setMaxAge(60 * 60 * 24 * 7);
         cookie.setPath("/");
         response.addCookie(cookie);
         
         UserDTO user = UserDTO.builder()
               .id(id)
               .sessionId(sessionId)
               .sessionLimitDate(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 24 * 7))
               .build();

         userMapper.updateSessionInfo(user);
      }
      else {
         Cookie cookie = new Cookie("keepLogin", "");
         cookie.setMaxAge(0);
         cookie.setPath("/");
         response.addCookie(cookie);
      }
   }
    
    @Override
   public UserDTO getUserBySessionId(Map<String, Object> map) {
      return userMapper.selectUserByMap(map);
   }
    
   @Override
   public void logout(HttpServletRequest request, HttpServletResponse response) {
      
      HttpSession session = request.getSession();
      if(session.getAttribute("loginUser") != null) {
         session.invalidate();
      }
      Cookie cookie = new Cookie("keepLogin", "");
      cookie.setMaxAge(0);
      cookie.setPath("/");
      response.addCookie(cookie);
   }

   @Override
   public Map<String, Object> confirmPassword(HttpServletRequest request) {
      
      String pw = securityUtil.sha256(request.getParameter("pw"));
      
      HttpSession session = request.getSession();
      String id = ((UserDTO)session.getAttribute("loginUser")).getId();
      
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("id", id);
      map.put("pw", pw);
      
      UserDTO user = userMapper.selectUserByMap(map);
      
      Map<String, Object> result = new HashMap<String, Object>();
      result.put("isUser", user != null);
      return result;
      
   }
   
   @Override
   public void modifyPassword(HttpServletRequest request, HttpServletResponse response) {
      
      HttpSession session = request.getSession();
      UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");

      String pw = securityUtil.sha256(request.getParameter("pw"));
      if(pw.equals(loginUser.getPw())) {
         try {
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('?????? ??????????????? ????????? ??????????????? ????????? ??? ????????????.');");
            out.println("history.back();");
            out.println("</script>");
            out.close();
            
         } catch(Exception e) {
            e.printStackTrace();
         }
      }

      int userNo = loginUser.getUserNo();
      UserDTO user = UserDTO.builder()
            .userNo(userNo)
            .pw(pw)
            .build();
      
      int result = userMapper.updateUserPassword(user);
      try {
         response.setContentType("text/html; charset=UTF-8");
         PrintWriter out = response.getWriter();
         
         if(result > 0) {
            loginUser.setPw(pw);
            
            out.println("<script>");
            out.println("alert('??????????????? ?????????????????????.');");
            out.println("location.href='/user/info';");
            out.println("</script>");
            
         } else {
            out.println("<script>");
            out.println("alert('??????????????? ???????????? ???????????????.');");
            out.println("history.back();");
            out.println("</script>");
         }
         out.close();
         
      } catch(Exception e) {
         e.printStackTrace();
      }
   }
   
   @Override
   public void modifyUser(HttpServletRequest request, HttpServletResponse response) {
      
      String id = request.getParameter("id");
      String name = request.getParameter("name");
      String gender = request.getParameter("gender");
      String mobile = request.getParameter("mobile");
      String birthyear = request.getParameter("birthyear");
      String birthmonth = request.getParameter("birthmonth");
      String birthdate = request.getParameter("birthdate");
      String postcode = request.getParameter("postcode");
      String roadAddress = request.getParameter("roadAddress");
      String jibunAddress = request.getParameter("jibunAddress");
      String detailAddress = request.getParameter("detailAddress");
      String extraAddress = request.getParameter("extraAddress");
      String email = request.getParameter("email");
      
      name = securityUtil.preventXSS(name);
      String birthday = birthmonth + birthdate;
      detailAddress = securityUtil.preventXSS(detailAddress);
      
      UserDTO user = UserDTO.builder()
            .id(id)
            .name(name)
            .gender(gender)
            .email(email)
            .mobile(mobile)
            .birthyear(birthyear)
            .birthday(birthday)
            .postcode(postcode)
            .roadAddress(roadAddress)
            .jibunAddress(jibunAddress)
            .detailAddress(detailAddress)
            .extraAddress(extraAddress)
            .build();
            
      int result = userMapper.updateUserInfo(user);
      
      try {
         response.setContentType("text/html; charset=UTF-8");
         PrintWriter out = response.getWriter();
         
         if(result > 0) {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("id", id);
            
            request.getSession().setAttribute("loginUser", userMapper.selectUserByMap(map));
            
            out.println("<script>");
            out.println("alert('?????? ????????? ?????????????????????.');");
            out.println("location.href='/user/info';");
            out.println("</script>");
            
         } else {
            out.println("<script>");
            out.println("alert('?????? ?????? ????????? ??????????????????.');");
            out.println("history.back();");
            out.println("</script>");
         }
         out.close();
         
      } catch(Exception e) {
         e.printStackTrace();
      }
   }
   
   @Transactional
   @Override
   public void retire(HttpServletRequest request, HttpServletResponse response) {

      HttpSession session = request.getSession();
      UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
      
      RetireUserDTO retireUser = RetireUserDTO.builder()
            .userNo(loginUser.getUserNo())
            .id(loginUser.getId())
            .joinDate(loginUser.getJoinDate())
            .build();
      
      int deleteResult = userMapper.deleteUser(loginUser.getUserNo());
      int insertResult = userMapper.insertRetireUser(retireUser);
      
      try {
         response.setContentType("text/html; charset=UTF-8");
         PrintWriter out = response.getWriter();
         
         if(deleteResult > 0 && insertResult > 0) {
            session.invalidate();
            
            out.println("<script>");
            out.println("alert('?????? ?????????????????????.');");
            out.println("location.href='/';");
            out.println("</script>");
            
         } else {
            out.println("<script>");
            out.println("alert('?????? ????????? ??????????????????.');");
            out.println("history.back();");
            out.println("</script>");
         }
         out.close();
         
      } catch (DuplicateKeyException e2) {
         e2.printStackTrace();
      } catch(Exception e) {
         e.printStackTrace();
      }
      
   }
   
   @Override
   public void sleepUserHandle() {
      int insertCount = userMapper.insertSleepUser();
      if(insertCount > 0) {
         userMapper.deleteUserForSleep();
      }
   }
   
   @Override
   public SleepUserDTO getSleepUserById(String id) {
      return userMapper.selectSleepUserById(id);
   }
   
   @Transactional
   @Override
   public void restoreUser(HttpServletRequest request, HttpServletResponse response) {
      HttpSession session = request.getSession();
      SleepUserDTO sleepUser = (SleepUserDTO)session.getAttribute("sleepUser");
      String id = sleepUser.getId();
      
      int insertCount = userMapper.insertRestoreUser(id);
      int deleteCount = 0;
      if(insertCount > 0) {
         deleteCount = userMapper.deleteSleepUser(id);
      }
      
      try {
         response.setContentType("text/html; charset=UTF-8");
         PrintWriter out = response.getWriter();
         
         if(insertCount > 0 && deleteCount > 0) {
            session.removeAttribute("sleepUser");
            
            out.println("<script>");
            out.println("alert('?????? ????????? ?????????????????????. ?????? ?????? ???????????? ?????? ?????? ???????????? ????????????.');");
            out.println("location.href='/';");
            out.println("</script>");
            
         } else {
            out.println("<script>");
            out.println("alert('?????? ????????? ???????????? ???????????????.');");
            out.println("history.back();");
            out.println("</script>");
         }
         out.close();
         
      } catch (Exception e) {
         e.printStackTrace();
      }
   }
   
   // ????????? ??????
   @Override
	public Map<String, Object> findId(Map<String, Object> map) {
	   Map<String, Object> result = new HashMap<String, Object>();
	   result.put("findId", userMapper.selectUserByMap(map));
	   return result;
	}
   
   // ?????? ??????
	@Override
	public Map<String, Object> sendTemporaryPw(UserDTO user) {
		// 9?????? ?????? ????????????
		String temporaryPassword = securityUtil.generateRandomString(9);
		
		// ?????? ??????
		String text = "";
		text += "??????????????? ????????????????????????.<br>";
		text += "?????????????????? : <strong>" + temporaryPassword + "</strong><br><br>";
		text += "????????????????????? ????????? ?????? ????????? ??????????????? ????????? ?????????.";
		
		// ?????? ??????
		javaMailUtil.sendJavaMail(user.getEmail(), "[Application] ??????????????????", text);
		
		// DB??? ?????? user
		user.setPw(securityUtil.sha256(temporaryPassword));  // user??? ????????? userNo??? pw??? ??????
		
		// ?????? ??????????????? DB ?????? ???????????? ?????? ??????
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isSuccess", userMapper.updateUserPassword(user));
		return result;
	}
	
	// ????????? ?????????
	@Override
	public String getNaverLoginApiURL(HttpServletRequest request) {
	    
		String apiURL = null;
		try {
			String requestURL = request.getRequestURL().toString();
			String requestURI = request.getRequestURI();
			String host = requestURL.substring(0, requestURL.indexOf(requestURI));
			
			String clientId = "_A7rC_ITgDiz6_aSPMCA";
			String redirectURI = URLEncoder.encode(host + "/user/naver/login", "UTF-8");  // ????????? ????????? Callback URL??? ????????? ?????? ?????? 
			SecureRandom random = new SecureRandom();
			String state = new BigInteger(130, random).toString();
			
			apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
			apiURL += "&client_id=" + clientId;
			apiURL += "&redirect_uri=" + redirectURI;
			apiURL += "&state=" + state;
			
			HttpSession session = request.getSession();
			session.setAttribute("state", state);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return apiURL;
		
	}
	
	@Override
	public String getNaverLoginToken(HttpServletRequest request) {
		
		// access_token ??????
		String clientId = "_A7rC_ITgDiz6_aSPMCA";
		String clientSecret = "2pH3suQqwn";
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		
		String redirectURI = null;
		try {
			String requestURL = request.getRequestURL().toString();
			String requestURI = request.getRequestURI();
			String host = requestURL.substring(0, requestURL.indexOf(requestURI));
			
			redirectURI = URLEncoder.encode(host, "UTF-8");
			
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		StringBuffer res = new StringBuffer();
		try {
			
			String apiURL;
			apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
			apiURL += "client_id=" + clientId;
			apiURL += "&client_secret=" + clientSecret;
			apiURL += "&redirect_uri=" + redirectURI;
			apiURL += "&code=" + code;
			apiURL += "&state=" + state;
			
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			con.disconnect();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		JSONObject obj = new JSONObject(res.toString());
		String access_token = obj.getString("access_token");
		return access_token;
	}
	
	@Override
	public UserDTO getNaverLoginProfile(String access_token) {
		
		// access_token??? ???????????? profile ??????
		String header = "Bearer " + access_token;
		
		StringBuffer sb = new StringBuffer();
		
		try {
			
			String apiURL = "https://openapi.naver.com/v1/nid/me";
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", header);
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			while ((inputLine = br.readLine()) != null) {
				sb.append(inputLine);
			}
			br.close();
			con.disconnect();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// ????????? profile??? UserDTO??? ???????????? ??????
		UserDTO user = null;
		try {
			JSONObject profile = new JSONObject(sb.toString()).getJSONObject("response");
			String id = profile.getString("id");
			String name = profile.getString("name");
			String nickname = profile.getString("nickname");
			String gender = profile.getString("gender");
			String email = profile.getString("email");
			String mobile = profile.getString("mobile").replaceAll("-", "");
			String birthyear = profile.getString("birthyear");
			String birthday = profile.getString("birthday").replace("-", "");
			
			user = UserDTO.builder()
					.id(id)
					.name(name)
					.nickname(nickname)
					.gender(gender)
					.email(email)
					.mobile(mobile)
					.birthyear(birthyear)
					.birthday(birthday)
					.build();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}
	
	@Override
	public UserDTO getNaverUserById(String id) {
		
		// ?????? ???????????? ????????? Map
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		
		return userMapper.selectUserByMap(map);
	}
	
	@Transactional
	@Override
	public void naverLogin(HttpServletRequest request, UserDTO naverUser) {
		
		// ????????? ????????? ????????? session??? ????????? ??? ????????? ????????? ?????????
		request.getSession().setAttribute("loginUser", naverUser);
		
		// ????????? ?????? ?????????
		String id = naverUser.getId();
		int updateResult = userMapper.updateAccessLog(id);
		if(updateResult == 0) {
			userMapper.insertAccessLog(id);
		}
	}
	
	@Override
	public void naverJoin(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String nickname = request.getParameter("nickname");
		String gender = request.getParameter("gender");
		String mobile = request.getParameter("mobile");
		String birthyear = request.getParameter("birthyear");
		String birthmonth = request.getParameter("birthmonth");
		String birthdate = request.getParameter("birthdate");
		String email = request.getParameter("email");
		String location = request.getParameter("location");
		String promotion = request.getParameter("promotion");
		
		// ?????? ??????????????? DB??? ?????? ??? ????????? ??????
		name = securityUtil.preventXSS(name);
		String birthday = birthmonth + birthdate;
		String pw = securityUtil.sha256(birthyear + birthday);  // ??????????????? ???????????? 8????????? ??????????????? ???
		
		int agreeCode = 0;  // ?????? ??????
		if(location != null && promotion == null) {
			agreeCode = 1;  // ?????? + ??????
		} else if(location == null && promotion != null) {
			agreeCode = 2;  // ?????? + ????????????
		} else if(location != null && promotion != null) {
			agreeCode = 3;  // ?????? + ?????? + ????????????
		}
		
		// DB??? ?????? UserDTO ?????????
		UserDTO user = UserDTO.builder()
				.id(id)
				.pw(pw)
				.name(name)
				.nickname(nickname)
				.gender(gender)
				.email(email)
				.mobile(mobile)
				.birthyear(birthyear)
				.birthday(birthday)
				.agreeCode(agreeCode)
				.snsType("naver")  // ???????????????????????? ???????????? naver??? ????????? ????????? ???
				.build();
				
		int result = userMapper.insertNaverUser(user);
		
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(result > 0) {
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", id);
				
				request.getSession().setAttribute("loginUser", userMapper.selectUserByMap(map));
				
				int updateResult = userMapper.updateAccessLog(id);
				if(updateResult == 0) {
					userMapper.insertAccessLog(id);
				}
	            out.println("<script>");
	            out.println("alert('?????? ?????????????????????.');");
	            out.println("location.href='/';");
	            out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('?????? ????????? ??????????????????.');");
				out.println("history.go(-2);");
				out.println("</script>");
			}
			out.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}