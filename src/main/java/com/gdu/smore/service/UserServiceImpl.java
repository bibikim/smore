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
		
		// 조회 조건으로 사용할 Map
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isUser", userMapper.selectUserByMap(map) != null);
		//result.put("isRetireUser", userMapper.selectRetireUserById(id) != null);
		return result;
		
	}
	
	@Override
	public Map<String, Object> isReduceEmail(String email) {
		
		// 조회 조건으로 사용할 Map
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isUser", userMapper.selectUserByMap(map) != null);
		return result;
		
	}
	
	@Override
	public Map<String, Object> sendAuthCode(String email) {
		
		// 인증코드 만들기
		String authCode = securityUtil.getAuthCode(6);  
		System.out.println("발송된 인증코드 : " + authCode);
		
		// 이메일 전송을 위한 필수 속성을 Properties 객체로 생성
		Properties properties = new Properties();
		properties.put("mail.smtp.host", "smtp.gmail.com");  // 구글 메일로 보냄(보내는 메일은 구글 메일만 가능)
		properties.put("mail.smtp.port", "587");             // 구글 메일로 보내는 포트 번호
		properties.put("mail.smtp.auth", "true");            // 인증된 메일
		properties.put("mail.smtp.starttls.enable", "true"); // TLS 허용
		
		// 사용자 정보를 javax.mail.Session에 저장
		Session session = Session.getInstance(properties, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});
		
		// 이메일 작성 및 전송
		try {
			
			Message message = new MimeMessage(session);
			
			message.setFrom(new InternetAddress(username, "인증코드관리자"));            // 보내는사람
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));  // 받는사람
			message.setSubject("[Application] 인증 요청 메일입니다.");                   // 제목
			message.setContent("인증번호는 <strong>" + authCode + "</strong>입니다.", "text/html; charset=UTF-8");  // 내용
			
			Transport.send(message);  // 이메일 전송
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		// join.jsp로 생성한 인증코드를 보내줘야 함
		// 그래야 사용자가 입력한 인증코드와 비교를 할 수 있음
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("authCode", authCode);
		return result;
		
	}
	
	@Transactional  // INSERT,UPDATE,DELETE 중 2개 이상이 호출되는 서비스에서 필요함
	@Override
	public void join(HttpServletRequest request, HttpServletResponse response) {
		
		// 파라미터
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
				
		// 일부 파라미터는 DB에 넣을 수 있도록 가공
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
		
		// DB로 보낼 UserDTO 만들기
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
				
		// 회원가입처리
		int result = userMapper.insertUser(user);
		
		// 응답
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(result > 0) {
				
				// 조회 조건으로 사용할 Map
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", id);
				
				// 로그인 처리를 위해서 session에 로그인 된 사용자 정보를 올려둠
				request.getSession().setAttribute("loginUser", userMapper.selectUserByMap(map));
				
				// 로그인 기록 남기기
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
                // TODO: handle exception
             }
        }
       
    }
    
    @Override
    public void keepLogin(HttpServletRequest request, HttpServletResponse response) {
    	/*
			로그인 유지를 체크한 경우
			
			1. session_id를 쿠키에 저장해 둔다.
			   (쿠키명 : keepLogin)
			2. session_id를 DB에 저장해 둔다.
			   (SESSION_ID 칼럼에 session_id를 저장하고, SESSION_LIMIT_DATE 칼럼에 15일 후 날짜를 저장한다.)

			로그인 유지를 체크하지 않은 경우
			
			1. 쿠키 또는 DB에 저장된 정보를 삭제한다.
			   편의상 쿠키명 keepLogin을 제거하는 것으로 처리한다.
		*/
		
		// 파라미터
		String id = request.getParameter("id");
		String keepLogin = request.getParameter("keepLogin");
		
		// 로그인 유지를 체크한 경우
		if(keepLogin != null) {
			
			// session_id
			String sessionId = request.getSession().getId();
			
			// session_id를 쿠키에 저장하기
			Cookie cookie = new Cookie("keepLogin", sessionId);
			cookie.setMaxAge(60 * 60 * 24 * 15);  // 15일
			cookie.setPath(request.getContextPath());
			response.addCookie(cookie);
			
			// session_id를 DB에 저장하기
			UserDTO user = UserDTO.builder()
					.id(id)
					.sessionId(sessionId)
					.sessionLimitDate(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 24 * 15))  // 현재타임스탬프 + 15일에 해당하는 타임스탬프
					.build();
	
			userMapper.updateSessionInfo(user);
			
		}
		// 로그인 유지를 체크하지 않은 경우
		else {
			// keepLogin 쿠키 제거하기
			Cookie cookie = new Cookie("keepLogin", "");
			cookie.setMaxAge(0);  // 쿠키 유지 시간이 0이면 삭제를 의미함
			cookie.setPath(request.getContextPath());
			response.addCookie(cookie);
		}
    }
    
    @Override
    public UserDTO getUserBySessionId(Map<String, Object> map) {
    	return userMapper.selectUserByMap(map);
    }
    
	@Override
	public void logout(HttpServletRequest request, HttpServletResponse response) {
		
		// 로그아웃 처리
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") != null) {
			session.invalidate();
		}
		
		// 로그인 유지 풀기
		Cookie cookie = new Cookie("keepLogin", "");
		cookie.setMaxAge(0);  // 쿠키 유지 시간이 0이면 삭제를 의미함
		cookie.setPath(request.getContextPath());
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
		
		// 현재 로그인 된 사용자
		HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");

		String pw = securityUtil.sha256(request.getParameter("pw"));

		// 동일한 비밀번호로 변경 금지
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

		// 사용자 번호
		int userNo = loginUser.getUserNo();
		
		// DB로 보낼 UserDTO
		UserDTO user = UserDTO.builder()
				.userNo(userNo)
				.pw(pw)
				.build();
		
		// 비밀번호 수정
		int result = userMapper.updateUserPassword(user);
		
		// 응답
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(result > 0) {
				// session에 저장된 loginUser 업데이트
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
		
		// 일부 파라미터는 DB에 넣을 수 있도록 가공
		name = securityUtil.preventXSS(name);
		String birthday = birthmonth + birthdate;
		detailAddress = securityUtil.preventXSS(detailAddress);
		
		// DB로 보낼 UserDTO 만들기
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
				
		// 회원정보수정
		int result = userMapper.updateUserInfo(user);
		
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(result > 0) {
				// 조회 조건으로 사용할 Map
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", id);
				
				// session에 올라간 정보를 수정된 내용으로 업데이트
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

		// 탈퇴할 회원의 userNo, id, joinDate는 session의 loginUser에 저장
		HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
		
		// 탈퇴할 회원 RetireUserDTO 생성
		RetireUserDTO retireUser = RetireUserDTO.builder()
				.userNo(loginUser.getUserNo())
				.id(loginUser.getId())
				.joinDate(loginUser.getJoinDate())
				.build();
		
		System.out.println(request.getContextPath());
		
		// 탈퇴처리
		int deleteResult = userMapper.deleteUser(loginUser.getUserNo());
		int insertResult = userMapper.insertRetireUser(retireUser);
		
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(deleteResult > 0 && insertResult > 0) {
				// session 초기화(로그인 사용자 loginUser 삭제를 위해서)
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
	
	
}