<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../layout/header.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>


<body>
 


  
   <script>
	   function getLocation() {
		  if (navigator.geolocation) { // GPS를 지원하면
		     navigator.geolocation.getCurrentPosition(function(position) {
	           var lat= position.coords.latitude;
	           var lng= position.coords.longitude;
		       alert('현재 위치는 ' + lat + ' , ' + lng + '입니다.');
		     }, function(error) {
		       console.error(error);
		     }, {
		       enableHighAccuracy: false,
		       maximumAge: 0,
		       timeout: Infinity
		     });
		   } else {
		     alert('GPS를 지원하지 않습니다');
		   }
		 }
	   // getLocation();
	   
   </script>
   <input type="button" value="현재위치 받기" id="btn_location" onclick="getLocation()">
    

</body>



<div>

	아무개
	
</div> 


</html>