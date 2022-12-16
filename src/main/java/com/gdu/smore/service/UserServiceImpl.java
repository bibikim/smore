package com.gdu.smore.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gdu.smore.domain.user.RetireUserDTO;
import com.gdu.smore.domain.user.SleepUserDTO;
import com.gdu.smore.domain.user.UserDTO;
import com.gdu.smore.mapper.UserMapper;
import com.gdu.smore.util.SecurityUtil;

@PropertySource(value = {"classpath:application.yml"})
@Service
public class UserServiceImpl implements UserService {

	@Value(value = "${mail.username}")
	private String username;
		
	@Value(value="${mail.password}")
	private String password;
	
	@Autowired
	private UserMapper userMapper;	
	@Autowired
	private SecurityUtil securityUtil;
	
	@Override
	public Map<String, Object> isReduceId(String id) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isUser", userMapper.selectUserByMap(map) != null);
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
		
		String authCode = securityUtil.getAuthCode(6);  
		System.out.println("발송된 인증코드 : " + authCode);
		
		Properties properties = new Properties();
		properties.put("mail.smtp.host", "smtp.gmail.com");  
		properties.put("mail.smtp.port", "587");          
		properties.put("mail.smtp.auth", "true");         
		properties.put("mail.smtp.starttls.enable", "true"); 
		
		Session session = Session.getInstance(properties, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});
		try {
			Message message = new MimeMessage(session);
			
			message.setFrom(new InternetAddress(username, "인증코드관리자"));         
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
			message.setSubject("[Application] 인증 요청 메일입니다.");               
			message.setContent("인증번호는 <strong>" + authCode + "</strong>입니다.", "text/html; charset=UTF-8");  // 내용
			
			Transport.send(message);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
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
		int agreeCode = 0;  // 필수 동의
		if(!location.isEmpty() && promotion.isEmpty()) {
			agreeCode = 1;  // 필수 + 위치
		} else if(location.isEmpty() && !promotion.isEmpty()) {
			agreeCode = 2;  // 필수 + 프로모션
		} else if(!location.isEmpty() && !promotion.isEmpty()) {
			agreeCode = 3;  // 필수 + 위치 + 프로모션
		}
		
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
				out.println("alert('회원 가입되었습니다.');");
				out.println("location.href='/';");
				out.println("</script>");
				
			} else {
				out.println("<script>");
				out.println("alert('회원 가입에 실패했습니다.');");
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
    	   int updateResult = userMapper.updateAccessLog(id);
    	   if(updateResult == 0) {
    		   userMapper.insertAccessLog(id);
    	   }
    	   keepLogin(request, response);
        
    	   request.getSession().setAttribute("loginUser", loginUser);
          
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
               out.println("alert('일치하는 회원정보가 없습니다.')");
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
				out.println("alert('현재 비밀번호와 동일한 비밀번호로 변경할 수 없습니다.');");
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
				out.println("alert('비밀번호가 수정되었습니다.');");
				out.println("location.href='/user/info';");
				out.println("</script>");
				
			} else {
				out.println("<script>");
				out.println("alert('비밀번호가 수정되지 않았습니다.');");
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
				out.println("alert('회원 정보가 수정되었습니다.');");
				out.println("location.href='/user/mypage';");
				out.println("</script>");
				
			} else {
				out.println("<script>");
				out.println("alert('회원 정보 수정이 실패했습니다.');");
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
		
		System.out.println(request.getContextPath());
		
		int deleteResult = userMapper.deleteUser(loginUser.getUserNo());
		int insertResult = userMapper.insertRetireUser(retireUser);
		
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(deleteResult > 0 && insertResult > 0) {
				session.invalidate();
				
				out.println("<script>");
				out.println("alert('회원 탈퇴되었습니다.');");
				out.println("location.href='/';");
				out.println("</script>");
				
			} else {
				out.println("<script>");
				out.println("alert('회원 탈퇴에 실패했습니다.');");
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
				out.println("alert('휴면 계정이 복구되었습니다. 휴면 계정 활성화를 위해 바로 로그인을 해주세요.');");
				out.println("location.href='/';");
				out.println("</script>");
				
			} else {
				out.println("<script>");
				out.println("alert('휴면 계정이 복구되지 않았습니다.');");
				out.println("history.back();");
				out.println("</script>");
			}
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	
	
}