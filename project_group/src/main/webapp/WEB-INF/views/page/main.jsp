<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script src="resources/js/js/eventForm.js"></script>
<script src="resources/js/ko.js"></script>
<script type="text/javascript">
	var calendar;
	var eventData;
	$(document).ready(function() {
				var calendarEl = document.getElementById('calendar');
				var usercode = "${gui.usercode}";
				var date = new Date();
				var year = date.getFullYear();
				var month = date.getMonth();
				
				calendar = new FullCalendar.Calendar(calendarEl, {
					timeZone : 'local',
					height : "100%",
					initialView : 'dayGridMonth',
					selectable : true,
					navLinks : true,
					selectMirror : true,
					editable : false,
					dayMaxEvents : true,
					displayEventTime : true,
					titleFormat : {
						year : 'numeric',
						month : 'numeric'
					},
					headerToolbar : {
						left : 'title',
						center : 'dayGridMonth,listWeek',
						right : 'today prevYear,prev,next,nextYear'
					},
					dayHeaderContent : function(info) {
						var weekList = [ "일", "월", "화", "수", "목", "금", "토" ];
						return weekList[info.dow];
					},
					select : function(arg) {
						
						/* modal 기본값  */
						var date = new Date(arg.end.getFullYear(), arg.end.getMonth(), arg.end.getDate() - 1);

						$("#startDay").val(arg.startStr);
						$("input[name='startDay']").val(arg.start.format("yyyy-MM-dd HH:mm:ss"));
						$("#endDay").val(date.format("yyyy-MM-dd"));
						$("input[name='endDay']").val(date.format("yyyy-MM-dd HH:mm:ss"));

						$("#startDay").prev().addClass("formTop");
						$("#startDay").next().addClass("icon-color");
						$("#endDay").prev().addClass("formTop");
						$("#endDay").next().addClass("icon-color");
						/* modal 기본 값  */

						$("#eventInsertModal").modal("show");
						
						

					},
				eventSources : [ getAllEvents() ] ,
				eventClick :function(info){
					
					var thisEventId = info.event.id;
					var eventSource = eventData.events;
					var ptitle = info.event.title;
					var startDay = info.event.start;
					var endDay = info.event.end;
					var allDay = info.event.allDay;
					var color = info.el.style.backgroundColor;
					var pmemo ;
					
					for (var i =0 ; i <eventSource.length ; i++){
						if(eventSource[i].id ==thisEventId){
							
							pmemo = eventSource[i].memo
						}
						
					}
					var endDayDate = new Date(endDay.getFullYear(), endDay.getMonth(), endDay.getDate() - 1);
					
					
					var startStr = null;
					var endStr = null;
				
					
					startStr = startDay.format("yyyy-MM-dd");
					endStr = endDayDate.format("yyyy-MM-dd");
					
					/* modal 기본값  */
					alert(thisEventId+","+ptitle+","+startStr+","+endStr+","+allDay+","+color+","+pmemo);
					
					$("#ptitle").val(ptitle);
					$("#pmemo").val(pmemo);
					$("input[name='startDay']").val(startDay.format("yyyy-MM-dd HH:mm:ss"));
					$("input[name='endDay']").val(endDayDate.format("yyyy-MM-dd HH:mm:ss"));
					$("#startDay").val(startStr);
					$("#endDay").val(endStr);
					
					
					$("#ptitle").prev().addClass("formTop");
					$("#ptitle").next().addClass("icon-color");
					$("#pmemo").prev().addClass("formTop");
					$(".pmemo-box").css("display","block");
					$(".ptitle-box").css("margin-bottom","2rem");
					$(".pmemo-box").addClass("memoBox-show");
					$("#startDay").prev().addClass("formTop");
					$("#startDay").next().addClass("icon-color");
					$("#endDay").prev().addClass("formTop");
					$("#endDay").next().addClass("icon-color");
					/* modal 기본 값  */
					
					$("#eventInsertModal").modal("show");
				
				}
					 

				});

				calendar.render();

				$("#eventInsertForm-btn").on("click",function() {
							var usercode = "${gui.usercode}";
							var startDate = new Date($("#startDay").val());
							var endDate = new Date($("#endDay").val());
							$("input[name='startDay']").val(startDate.format("yyyy-MM-dd HH:mm:ss"));
							$("input[name='endDay']").val(endDate.format("yyyy-MM-dd HH:mm:ss"));
							
							var queryString = $("form[name=eventInsertForm]").serialize();
								
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

			});
</script>

<div class="modal" id="eventInsertModal" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content event-pop-content">
			<div class="modal-header event-pop-header">

				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body event-pop-body">
				<form id="eventInsertForm" name="eventInsertForm" method="POST">
					<div class="form-item ptitle-box">
						<p class="formLabel">제목</p>
						<input type="text" name="ptitle" id="ptitle" class="form-style"
							autocomplete="off" />
						<div class="note-pad-icon">
							<i class="far fa-sticky-note  fa-2x"></i>
						</div>
					</div>
					<div class="form-item pmemo-box">
						<p class="formLabel">메모</p>
						<textarea name="pmemo" name="pmemo" id="pmemo"
							onkeydown="textareaResize(this)" onkeyup="textareaResize(this)"
							class="form-style" autocomplete="off"></textarea>
					</div>
					<div class="form-item allDayRadio-Box">
						<div class="btn-group allDayRadio-group">
							<label class="radio-label btn allDay-btn-chk" for="allDayTrue"
								id="allDay-btn-left"> <input type="radio" name="allDay"
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
					class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<div id="planner_${gui.usercode }" class="planner">
	<div id="calendar"></div>
</div>

<script>
	$(document).ready(
			function() {

				var colorArr = [ "#ff0068", "#ff8100", "#ffc800", "#00ff43",
						"#00a1ff", "#1b00ff" ];

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

	function textareaResize(obj) {

		obj.style.height = "1px";
		obj.style.height = (12 + obj.scrollHeight) + "px";

	}
</script>