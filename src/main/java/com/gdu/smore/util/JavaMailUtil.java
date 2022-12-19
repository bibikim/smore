package com.gdu.smore.util;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

/*
	이메일 보내기 API 사용을 위한 사전 작업
	
	1. 구글 로그인
	2. [Google 계정] - [보안]
	    1) [2단계 인증]  - [사용]
	    2) [앱 비밀번호]
	        (1) 앱 선택   : 기타
	        (2) 기기 선택 : Windows 컴퓨터
	        (3) 생성 버튼 : 16자리 앱 비밀번호를 생성해 줌(이 비밀번호를 이메일 보낼 때 사용)
*/

@PropertySource(value = {"classpath:application.yml"})
@Component
public class JavaMailUtil {

	@Value(value = "${spring.mail.host}")
	private String host;
	 
	@Value(value = "${spring.mail.port}")
	private int port;
	
	@Value(value = "${spring.mail.username}")
	private String username;
	
	@Value(value = "${spring.mail.password}")
	private String password;
	
	@Value(value = "${spring.mail.properties.mail.smtp.auth}")
	private String mailSmtpAuth;
	
	@Value(value = "${spring.mail.properties.mail.smtp.starttls.enable}")
	private String mailStarttlsEnable;
	
	public void sendJavaMail(String email, String title, String content) {
		
		// 이메일 작성 및 전송
		try {
			
			// 이메일 전송을 위한 필수 속성을 Properties 객체로 생성
			Properties properties = new Properties();
			properties.put("mail.smtp.host", host);  // 구글 메일로 보냄(보내는 메일은 구글 메일만 가능)
			properties.put("mail.smtp.port", port);  // 구글 메일로 보내는 포트 번호
			properties.put("mail.smtp.auth", mailSmtpAuth);  // 인증된 메일
			properties.put("mail.smtp.starttls.enable", mailStarttlsEnable);  // TLS 허용(port가 587인 경우 허용)
			
			// 사용자 정보를 javax.mail.Session에 저장
			MimeMessage message = new MimeMessage(Session.getInstance(properties, new Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					// TODO Auto-generated method stub
					return new PasswordAuthentication(username, password);
				}
			}));
			
			message.setFrom(new InternetAddress(username, "사이트관리자"));  // 보내는사람
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));  // 받는사람
			message.setSubject(title);  // 제목
			message.setContent(content, "text/html; charset=UTF-8");  // 내용
			
			Transport.send(message);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
}
