<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${param.title}</title>
<script src="/resources/js/jquery-3.6.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/b9a2709031.js" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/userinfo.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400&display=swap" rel="stylesheet">
<style> 
    @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 100;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Thin.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Thin.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Thin.otf) format('opentype');}
    @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 300;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.otf) format('opentype');} @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 400;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Regular.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Regular.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Regular.otf) format('opentype');} @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 500;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Medium.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Medium.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Medium.otf) format('opentype');} @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 700;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Bold.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Bold.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Bold.otf) format('opentype');} @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 900;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Black.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Black.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Black.otf) format('opentype');} 
	head,body, table ,span{font-family:'Noto Sans KR' !important;}
	
	.bg-light {
		background-color: #ffffff;
	}	
	
	a {
		text-decoration-line: none ;
		cursor: pointer;
		color: black;
	}

	.nav-link {
		color: rgba(0,0,0,.9);
	}
	
	.nav-link:hover{
		color: rgba(0,144,249,.5);
	}
	
	.navbar {
		display: block !important;
	}
	.navbar-brand {
		float: left;
	}
	.nav {
		float: right !important;
		margin-right: 4px;
	}
	
	.dropdown-menu {
		text-align: center !important;
		min-width: 1px !important;
	}
	
	.dropdown-item {
		padding: 3px 10px !important;
	}
	
</style>
<style>

</style>
<link rel="stylesheet" href="/resources/css/reset.css">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">

	<c:if test="${loginUser == null}">
		<nav class="navbar navbar-light bg-light" >
			<a class="navbar-brand" href="/"><img alt="" src="/resources/images/logo3.png" style="width: 150px;"></a>
			<ul class="nav justify-content-end">
				<li class="nav-item">
					<a class="nav-link active" href="/">Study&amp;모임</a>
				</li>
				<li class="nav-item">
					<a class="nav-link active" href="/free/list">커뮤니티</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="/code/list">지식</a>
				</li>
				<li class="nav-item">
				    <a class="nav-link" href="/job/list">Jobs</a>
				</li>
				<li class="nav-item">
				    <a class="nav-link" href="/qna/list">Q&amp;A</a>
				</li>
				<li class="nav-item">
				    <a class="nav-link" href="/user/login/form" tabindex="-1" aria-disabled="true">login</a>
				</li>
			</ul>
			<div style="clear: both;"></div>
		</nav>
	</c:if>
	
	<c:if test="${loginUser ne null}">
	<div>
    	<div style="text-align: right"> 
			<nav class="navbar navbar-expand-lg navbar-light bg-light">
				<a class="navbar-brand" href="/"><img alt="" src="/resources/images/logo3.png" width="150px"></a>
				<ul class="nav justify-content-end">
					<li class="nav-item">
						<a class="nav-link active" href="/">Study&amp;모임</a>
					</li>
					<li class="nav-item">
						<a class="nav-link active" href="/free/list">커뮤니티</a>
					</li>
					<li class="nav-item">
					    <a class="nav-link" href="/code/list">지식</a>
					</li>
					<li class="nav-item">
				    	<a class="nav-link" href="/job/list">Jobs</a>
					</li>
					<li class="nav-item">
					    <a class="nav-link" href="/qna/list">Q&amp;A</a>
					</li>

					<li class="nav-item dropdown">
			      
				    	<c:if test="${loginUser.id == 'admin'}">
				      		<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				          		${loginUser.nickname}
				        	</a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
				          		<a class="dropdown-item" href="/admin/page">관리자페이지</a>
				          		<a class="dropdown-item" href="/user/logout">로그아웃</a>
				        	</div>
						</c:if>
			      
				      	<c:if test="${loginUser.id != 'admin'}">
				        	<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				          		<img src="../../resources/images/cookie.png" >&nbsp;${loginUser.nickname}
				        	</a>
				        	<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
				          		<a class="dropdown-item" href="/user/checkpw">My회원정보</a>
				          		<a class="dropdown-item" href="/user/mypage">My스터디</a>
				          		<a class="dropdown-item" href="/user/logout">로그아웃</a>
				        	</div>
						</c:if>
						
					</li>
				</ul>
				<div style="clear: both;"></div>
			  	<div class="collapse navbar-collapse" id="navbarNavDropdown">
				<ul class="navbar-nav">
			    	
				</ul>
				</div>
			</nav>
		</div>
	</div>
	</c:if>
	
		