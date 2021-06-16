<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script src="resources/js/js/eventForm.js"></script>
<script src="resources/js/ko.js"></script>
<script type="text/javascript">
	var usercode = "${gui.usercode}";
	var calendar;
	var eventData;
	//var viewPage ="dayGridMonth";
	
	$(document).ready(function() { 
				var calendarEl = document.getElementById('calendar');
				calendar = new FullCalendar.Calendar(calendarEl, {
					timeZone : 'local',
					height : "100%",
					initialView : "dayGridMonth",
					selectable : true,
					navLinks : true,
					selectMirror : true,
					editable : false,
					dayMaxEvents : false,
					displayEventTime : true,
					locale: 'ko',
					fixedWeekCount: true,
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
				

			});
	
	
	//이벤트 삽입
	$(document).on("click","#eventInsertForm-btn",function() {
	
		var startDay =$("#startDay").val();
		var endDay =$("#endDay").val();
		var startDate = new Date(startDay);
		var endDate = new Date(endDay);
		
		
		
		if(startDate > endDate){
			
			alert("날짜 설정이 잘못되었습니다.");
			return false;
		}else{
			
			if(startDay == endDay && ($("#startTime").val()=="00:00" || $("#startTime").val()=="")&& ($("#endTime").val() =="00:00" || $("#endTime").val()=="")){
				
				
				$("#allDayTrue").prop("checked",true);
			}
			
			$("input[name=startDay]").val(startDate.format("yyyy-MM-dd HH:mm:ss"));
			$("input[name=endDay]").val(endDate.format("yyyy-MM-dd HH:mm:ss"));
						
			var queryString = $("form[name='eventInsertForm']").serialize();
			
			//alert(queryString);			
			
			 $.ajax({ 

					url : "/event/insertEvent/" + usercode,
					type : "POST",
					data : queryString,
					dataType : "TEXT",
					async : false,
					success : function(data) {

						alert("등록되었습니다.");
						location.reload();
					},
					error : function() {

						alert("error");
					}

				})   
 
		}

})
	
	$(document).on("click", "#eventDeleteForm-btn",function(){
		var pnum = $("#pnum").val();
		
		var con = confirm("삭제하시겠습니까?");
		if(con == true){
		 $.ajax({ 

				url : "/event/deleteEvent/" + usercode,
				type : "POST",
				data : {
					
					"pnum" : pnum
				},
				dataType : "TEXT",
				async : false,
				success : function(data) {

					alert("삭제 되었습니다.");
					location.reload();
				},
				error : function() {

					alert("error");
				}

			})   
		}
	})
	
	$(document).on("click","#eventUpdateForm-btn",function(){
		
		

		var startDay =$("#startDay").val();
		var endDay =$("#endDay").val();
		var startDate = new Date(startDay);
		var endDate = new Date(endDay);
		//alert(startDay+","+endDay);
		//실제 데이터로 들어가는 인풋에 삽입
		
		if(startDate > endDate){
			
			alert("날짜 설정이 잘못되었습니다.");
			return false;
		}else{
		 	
			if(startDay == endDay && ($("#startTime").val()=="00:00" || $("#startTime").val()=="")&& ($("#endTime").val() =="00:00" || $("#endTime").val()=="")){
				
				
				$("#allDayTrue").prop("checked",true);
			}
			
			$("input[name='startDay']").val(startDate.format("yyyy-MM-dd HH:mm:ss"));
			$("input[name='endDay']").val(endDate.format("yyyy-MM-dd HH:mm:ss"));
			var queryString = $("form[name='eventUpdateForm']").serialize();
		
			//alert(queryString);
		
			 $.ajax({

					url : "/event/updateEvent/" + usercode,
					type : "POST",
					data : queryString,
					dataType : "TEXT",
					async : false,
					success : function(data) {

						alert("수정되었습니다..");
						location.reload();
					},
					error : function() {

						alert("error");
					}

				})
				
		}
		
	})
	
	function getAllEvents() {

		var usercode = "${gui.usercode}";
		

		$.ajax({

			url : "/event/getAllEvent/" + usercode,
			type : "POST",
			dataType : "JSON",
			async : false,
			success : function(data) {

				eventData = data;
				//alert(events);

			},
			error : function() {

				alert("error");
			}

		})
		console.log(eventData);
		return eventData;
	}
</script>

<div class="modal" id="eventModal" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content event-pop-content">
			<div class="modal-header event-pop-header" id="modalClose">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body event-pop-body">
				<form id="eventForm" name="eventInsertForm" method="POST">
					<div class="form-item ptitle-box">
						<p class="formLabel">제목</p>
						<input type="text" name="ptitle" id="ptitle" class="form-style"
							autocomplete="off" value="" />
						<div class="note-pad-icon">
							<i class="far fa-sticky-note  fa-2x"></i>
						</div>
					</div>
					<div class="form-item pmemo-box">
						<p class="formLabel">메모</p>
						<textarea name="pmemo" id="pmemo"
							onkeydown="textareaResize(this)" onkeyup="textareaResize(this)"
							class="form-style" autocomplete="off"></textarea>
					</div>
					<div class="form-item allDayRadio-Box">
						<div class="btn-group allDayRadio-group">
							<label class="radio-label btn allDay-btn-chk" for="allDayTrue"
								id="allDay-btn-left"> 
								<input type="radio" name="allDay"
								id="allDayTrue" value="true" checked="checked"> 하루 종일
							</label>
							<div class="standard-bar"></div>
							<label class="btn radio-label" for="allDayFalse"
								id="allDay-btn-right"> <input type="radio" name="allDay"
								id="allDayFalse" value="false"> 시간
							</label>
						</div>
					</div>
					<div class="form-box">
						<div class="form-item day-box">
							<input type="hidden" name="startDay" class="form-style"
								autocomplete="off" />
							<p class="formLabel">시작 날짜</p>
							<input type="text" id="startDay" class="form-style"
								autocomplete="off" />
							<div class="calendar-icon">
								<i class="far fa-calendar-alt fa-2x"></i>
							</div>
						</div>
						<div class="form-item time-box">
							<p class="formLabel">시작 시간</p>
							<input type="text" name="startTime" id="startTime"
								class="form-style" autocomplete="off" />
							<div class="calendar-icon">
								<i class="far fa-clock  fa-2x"></i>
							</div>
						</div>
					</div>
					<div class="form-box">
						<div class="form-item day-box">
							<input type="hidden" name="endDay" class="form-style"
								autocomplete="off" />
							<p class="formLabel">끝 날짜</p>
							<input type="text" id="endDay" class="form-style"
								autocomplete="off" />
							<div class="calendar-icon">
								<i class="far fa-calendar-alt fa-2x"></i>
							</div>
						</div>

						<div class="form-item time-box">
							<p class="formLabel">끝 시간</p>
							<input type="text" name="endTime" id="endTime" class="form-style"
								autocomplete="off" />
							<div class="calendar-icon">
								<i class="far fa-clock  fa-2x"></i>
							</div>
						</div>
					</div>
					<div class="form-box color-radio-box">
						<label class="color-radio-label" for="red-color"> <input
							type="radio" name="color" class="color-radio" id="red-color"
							checked="checked">
						</label> <label class="color-radio-label" for="orange-color"> <input
							type="radio" name="color" class="color-radio" id="orange-color">
						</label> <label class="color-radio-label" for="yellow-color"> <input
							type="radio" name="color" class="color-radio" id="yellow-color">
						</label> <label class="color-radio-label" for="green-color"> <input
							type="radio" name="color" class="color-radio" id="green-color">
						</label> <label class="color-radio-label" for="blue-color"> <input
							type="radio" name="color" class="color-radio" id="blue-color">
						</label> <label class="color-radio-label" for="navy-color"> <input
							type="radio" name="color" class="color-radio" id="navy-color">
						</label>

					</div>
				</form>
			</div>

			<div class="modal-footer event-pop-footer">
				<button type="submit" id="eventInsertForm-btn"
					class="btn btn-outline-primary">계획 저장</button>
				
			</div>
		</div>
	</div>
</div>
<div class="calendar-container container">
	<div id="planner_${gui.usercode }" class="planner"> 
		<div id="calendar"></div>
	</div>
</div>
<script>
	$(document).ready(
			function() {

				var colorArr = [ "#ff0068", "#ff8100", "#ffc800", "#00ff43","#00a1ff", "#1b00ff" ];

				$(".color-radio-label").each(function() {
					var i = $(".color-radio-label").index(this);
					$(this).css("background-color", colorArr[i]);
					$(this).children().val(colorArr[i]);
					//alert("i :"+i);
				})

				$(function() {
					var today = new Date();
					var y = today.getFullYear();
					var m = today.getMonth();
					var d = today.getDate();
					var prevY = y - 1;
					var nextFiveY = y + 5;

					$("#startDay, #endDay").datepicker(
							{

								showOn : "focus", // 버튼과 텍스트 필드 모두 캘린더를 보여준다. 
								changeMonth : true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
								changeYear : true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
								minDate : '-2y', // 현재날짜로부터 100년이전까지 년을 표시한다. 
								nextText : '다음 달', // next 아이콘의 툴팁. 
								prevText : '이전 달', // prev 아이콘의 툴팁. 
								numberOfMonths : [ 1, 1 ], // 한번에 얼마나 많은 월을 표시할것인가. [2,3] 일 경우, 2(행) x 3(열) = 6개의 월을 표시한다.
								stepMonths : 1, // next, prev 버튼을 클릭했을때 얼마나 많은 월을 이동하여 표시하는가.
								showButtonPanel : true, // 캘린더 하단에 버튼 패널을 표시한다. 
								currentText : '오늘 날짜', // 오늘 날짜로 이동하는 버튼 패널
								closeText : '닫기', // 닫기 버튼 패널 
								dateFormat : "yy-mm-dd", // 텍스트 필드에 입력되는 날짜 형식.  
								showMonthAfterYear : true, // 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다.
								dayNamesMin : [ '월', '화', '수', '목', '금', '토',
										'일' ], // 요일의 한글 형식. 
								monthNamesShort : [ '1월', '2월', '3월', '4월',
										'5월', '6월', '7월', '8월', '9월', '10월',
										'11월', '12월' ], // 월의 한글 형식.
								yearRange : prevY + ":" + nextFiveY //연도 범위

							});
				})
				$("#startTime, #endTime").timepicker();

			})

	
	function modalOption(sort){
	
		if(sort == "insert"){
		 //alert("insert");
 			if($("#ptitle").val() != ""){
 				
 				$("#ptitle").val(""); 
 			}
 			
			if($("#pmemo").val() != ""){
 				
 				$("#pmemo").val(""); 
 			}
			
			if($("#startTime").val() !=""){
				
				$("#startTime").val(""); 
			}
			if($("#endTime").val() !=""){
				
				$("#endTime").val(""); 
			}
			
			if($("#allDayFalse").is(':checked')){
				
				$("#allDayTrue").prop("checked",true);
			}
			
			$(".color-radio").each(function(){
				
				if($(this).is(':checked')){
					if($(this).attr("id") != "red-color"){
						
						$("#red-color").prop("checked",true);
					}
				}
			})
		}
		$(".form-style").each(function(){
			
			if($(this).val() ==""){
				
				$(this).prev().removeClass("formTop");
				$(this).next().removeClass("icon-color");

			}else{
				
				$(this).prev().addClass("formTop");
				$(this).next().addClass("icon-color");
			}
		})
		
		if($("#pmemo").val() !=""){
			
			$(".pmemo-box").addClass("memoBox-show");
			$(".ptitle-box").css("margin-bottom","2rem");
			$(".note-pad-icon").addClass("icon-color");
		}else{
			$(".ptitle-box").css("margin-bottom","1rem");
			$(".note-pad-icon").removeClass("icon-color");
			$(".pmemo-box").removeClass("memoBox-show");
		}
		
		$("input[name='allDay']").each(function(){
			
			if($(this).is(":checked")){
				
				var checked=$(this).parent().attr("id");
				
				//alert(checked);
				if(checked == "allDay-btn-left"){
					
					$("#"+checked).addClass("allDay-btn-chk");	
					$(".day-box").css("width","100%");
					$(".time-box").css("display","none");

					if($("#allDay-btn-right").hasClass("allDay-btn-chk")){
						$("#allDay-btn-right").removeClass("allDay-btn-chk");	
					}
						
				}
				if(checked == "allDay-btn-right"){
					if($("#allDay-btn-left").hasClass("allDay-btn-chk")){
						$("#allDay-btn-left").removeClass("allDay-btn-chk");	
					}
					
					$("#"+checked).addClass("allDay-btn-chk");	
					$(".day-box").css("width","unset");
					$(".time-box").css("display","flex");
								
						
				}
				
			}
		})
		
 
	}
	
	function rgbToHex (rgbType){
		
		  var rgb = rgbType.replace( /[^%,.\d]/g, "" ).split( "," ); 
		    
		    rgb.forEach(function (str, x, arr){ 
		    
		        /* 컬러값이 "%"일 경우, 변환하기. */ 
		        if ( str.indexOf( "%" ) > -1 ) str = Math.round( parseFloat(str) * 2.55 ); 
		        
		        /* 16진수 문자로 변환하기. */ 
		        str = parseInt( str, 10 ).toString( 16 ); 
		        if ( str.length === 1 ) str = "0" + str; 
		        
		        arr[ x ] = str; 
		    }); 
		    
		    return "#" + rgb.join( "" ); 
	}
	
	
	
</script>