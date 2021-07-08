<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="right-menu">
	<div class="right-menu-list list-number-1">
		<span class="right-menu-list-title">달력</span>
		<ul class="right-menu-ul">
			<li class="right-menu-li view-month">
				<a href="/plannerHome?viewName=dayGridMonth" id="dayGridMonth" class="view-move">월간 일정 보기</a></li>
			<li class="right-menu-li view-week">
				<a href="/plannerHome?viewName=timeGridWeek" id="timeGridWeek" class="view-move">주간 일정 보기</a></li>
			<li class="right-menu-li view-day">
				<a href="/plannerHome?viewName=timeGridDay" id="timeGridDay" class="view-move">오늘 일정 보기</a></li>
		</ul>		
	</div>
	<div class="right-menu-list list-number-2">
		<span class="right-menu-list-title">일기</span>
		<ul class="right-menu-ul">
			<li class="right-menu-li write-diary">
				<a href="/diaryWrite" id="diaryWrite" class="view-move-diary">일기 쓰기</a></li>
			<li class="right-menu-li view-list-diary">
				<a href="/diaryList" id="diaryList" class="view-move-diary">일기 목록 보기</a></li>
		</ul>		
	</div>
	<div class="right-menu-list list-number-3">
		<span class="right-menu-list-title">회원</span>
		<ul class="right-menu-ul">
			<li class="right-menu-li write-diary">
				<a href="/userSecession"  class="userSecession-btn" >회원 탈퇴</a></li>
		</ul>		
	</div>
	 
</div>

<script>
  
$(document).on("click","#mask",function(){
	
	$(".right-menu-side").removeClass("open");
	$("#mask").hide();
})



  
</script>