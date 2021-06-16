<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="right-menu">
	<div class="right-menu-list list-number-1">
		<span class="right-menu-list-title">달력</span>
		<ul class="right-menu-ul">
			<li class="right-menu-li view-month">
				<a href="#" id="dayGridMonth" class="view-move">월간 일정 보기</a></li>
			<li class="right-menu-li view-week">
				<a href="#" id="timeGridWeek" class="view-move">주간 일정 보기</a></li>
			<li class="right-menu-li view-day">
				<a href="#" id="timeGridDay" class="view-move">오늘 일정 보기</a></li>
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
		<span class="right-menu-list-title">메모</span>
		<ul class="right-menu-ul">
			<li class="right-menu-li write-memo">
				<a href="#" class="view-move-memo">메모 쓰기</a></li>
		</ul>		
	</div>
</div>

<script>
  	$(".view-move").on("click", function(){
  		
  			var viewName=$(this).attr("id");
			var calendarEl = document.getElementById('calendar');
			calendar = new FullCalendar.Calendar(calendarEl, {
				timeZone : 'local',
				height : "100%",
				initialView : viewName,
				selectable : true,
				navLinks : true,
				selectMirror : true,
				editable : false,
				dayMaxEvents : true,
				displayEventTime : true,
				locale: 'ko',
				fixedWeekCount: false,
				handleWindowResize : true,
				dateClick: function(arg){
					
					 
					var dateClick = new Date(arg.dateStr);
					$("#startDay").val(arg.dateStr);
					$("input[name='startDay']").val(dateClick.format("yyyy-MM-dd HH:mm:ss"));
					$("#endDay").val(arg.dateStr);
					$("input[name='endDay']").val(dateClick.format("yyyy-MM-dd HH:mm:ss"));
					 
					
					modalOption("insert");
					/* modal 기본 값  */
					
					$("#eventModal").modal("show");

				},
				customButtons:{
					myCustomButton :{
						
						text : '일기 쓰기',
						click :function(){
							
							alert("일기 쓰기 모달");
						}
					},
					eventRegButton: {
						
						text : '일정 등록', 
						click : function(){
							
							
							modalOption("insert");
							/* modal 기본 값  */
							
							$("#eventModal").modal("show");
						}
					}
				},
				views :{
					dayGrid : {
						 titleFormat: function(info){
							 
							var m = info.date.month + 1;
							return  info.date.year+"년 "+m+"월";
						 } 
					}
					
				},
				buttonText:{
					
					today : '오늘',
					month : '월간 일정', 
					week : '주간 일정',
					day : '일간 일정',
					list : '일정 목록' 
				},
				headerToolbar : {
					left : '',
					center : 'prev title next',
					right :'eventRegButton today'
				},
				dayHeaderContent : function(info) {
					var weekList = [ "일", "월", "화", "수", "목", "금", "토" ];
					return weekList[info.dow];
				},
				select : function(arg) {
					
					/* modal 기본값  */
					var endDay = new Date(arg.end.getFullYear(), arg.end.getMonth(), arg.end.getDate() - 1);
					var startDay = new Date(arg.start.getFullYear(), arg.start.getMonth(), arg.start.getDate());
					/* $("#startDay").val(arg.startStr);//보여주는 시작날짜
					
					$("#endDay").val(endDay.format("yyyy-MM-dd"));// 보여주는 끝 날짜
					 */
					$("#startDay").val(startDay.format("yyyy-MM-dd"));
					$("input[name='startDay']").val(startDay.format("yyyy-MM-dd HH:mm:ss"));
					$("#endDay").val(endDay.format("yyyy-MM-dd"));
					$("input[name='endDay']").val(endDay.format("yyyy-MM-dd HH:mm:ss"));
					 
					
					modalOption("insert");
					/* modal 기본 값  */
					
					$("#eventModal").modal("show");

				},
				eventSources : [ getAllEvents() ],
				eventClick : function(info) {

					var thisEventId = info.event.id;
					var eventSource = eventData.events;
					var ptitle = info.event.title;
					var startDay = info.event.start;
					
					var endDay = info.event.end;
					var allDay = info.event.allDay;
					var color = info.el.style.backgroundColor;
					var pmemo;
					//실제데이터의 id값과 eventSource의 id 값을 비교하여 pmemo를 가져옴
					for (var i = 0; i < eventSource.length; i++) {
						if (eventSource[i].id == thisEventId) {

							pmemo = eventSource[i].memo
						}

					}
					
					//alert(thisEventId);
					var startStr = null;
					var endStr = null;
					var	startTimeStr =null;
					var	endTimeStr =null;
					
					if (allDay == false) {
						
						startStr = startDay.format("yyyy-MM-dd");
						endStr =endDay.format("yyyy-MM-dd");
						
						startTimeStr= startDay.format("HH:mm");
						endTimeStr = endDay.format("HH:mm");
						
						$("#allDayFalse").prop('checked', true);
						$("#allDayTrue").prop('checked', false);
						//alert("false  :"+startStr+"~"+endStr);
						//alert("false  :"+startTimeStr+"~"+endTimeStr);
					}else{
						var endDayDate = new Date(endDay.getFullYear(), endDay.getMonth(), endDay.getDate() - 1);
						
						startStr = startDay.format("yyyy-MM-dd");
						endStr =endDayDate.format("yyyy-MM-dd");
						startTimeStr="";
						endTimeStr="";
						$("#allDayFalse").prop('checked', false);
						$("#allDayTrue").prop('checked', true);
						//alert("true  :"+startStr+"~"+endStr);
						//alert("false  :"+startTimeStr+"~"+endTimeStr);
						
					}

					/* modal 기본값  */
					//title
					$("#ptitle").val(ptitle);
					
					//memo
					$("#pmemo").val(pmemo);
					
					//날짜
					$("#startDay").val(startStr);
					$("input[name='startDay']").val(startStr);
					$("#endDay").val(endStr);
					$("input[name='endDay']").val(endStr);
					
					//시간
					$("#startTime").val(startTimeStr);
					$("#endTime").val(endTimeStr);
					
					//color
					color =rgbToHex(color);
					
					$("input[name='color']").each(function(){
						
						if($(this).val() == color){
							
							$(this).prop("checked", true);
						}
						
					})
					
					
					modalOption("update");
					/* modal 기본 값  */
					var createInput = "<input type='hidden' id='pnum' name='pnum' value='"+thisEventId+"'/>";
					$("#eventForm").append(createInput);
					
					var updateOutput="<button type='submit' id='eventUpdateForm-btn' class='btn btn-outline-success'>계획 수정</button>"
									+"<button type='button' id='eventDeleteForm-btn'class='btn btn-outline-danger'><i class='fas fa-trash-alt'></i></button>"
									
					$(".event-pop-footer").html(updateOutput);
									
					$("#eventForm").attr("name","eventUpdateForm");
					$("#eventModal").addClass("eventUpdate");
					$("#eventModal").modal("show");

				}

			});
			calendar.render();
			$(".fc-col-header").css("width","100%");
			$(".fc-today-button").removeClass("fc-button-primary");
			$(".fc-eventRegButton-button").removeClass("fc-button-primary");
			//이벤트 수정
			
			$(".right-menu-side").removeClass("open");

	
  	})
  	
  	
</script>