<%@page import="com.spring.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<tiles:insertAttribute name="head" />
<title>YoonStudy - ${title}</title>

<!-- 외부 css  -->

	  
</head>
<body>
	


	<!-- jquery 4.3.1 js  -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	
	<script src="resources/js/jquery-ui.min.js"></script> 
	<script src="resources/js/timepicker.js"></script> 
	<script src="resources/js/fullcalendar.js" charset="euc-kr"></script> 

	

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>

	<!-- js dateFormat  -->
	<script src="<c:url value='resources/js/dateFormat.js'/>"></script>


	<div class="view">
		<c:if test="${title == 'HOME' }">
			<tiles:insertAttribute name="navbar" />
		</c:if>
		<div class="main-content ${title}">

			<tiles:insertAttribute name="body" />
		</div>
		<div class="right-menu-side">
			<tiles:insertAttribute name="right-menu" />
		</div>
	</div>
	<div id="mask"></div>

</body>


</html>

<script type="text/javascript">

$('.modal').on('hidden.bs.modal', function (e) {
		 //console.log('modal close');
		$(this).find('form')[0].reset();
		$(".pmemo-box").removeClass("memoBox-show");
		
		if(!$(".pmemo-box").hasClass("memoBox-show")){
			
			$(".note-pad-icon").removeClass("icon-color");
		}
		
		if($("#eventModal").hasClass("eventUpdate")){
			
			$("#eventModal").removeClass("eventUpdate");
			
			var updateOutput="<button type='submit' id='eventInsertForm-btn' class='btn btn-secondary' data-dismiss='modal'>계획 저장</button>"
							
				$(".event-pop-footer").html(updateOutput);
				
				$("#eventForm").attr("name","eventInsertForm");
				
		}
		
		
		
	});


</script>


