<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<script type="text/javascript">

	var today = new Date();
	var date = new Date();
	
	function now(){
		today = new Date();
		calendar(); 
	}
 
	function prev(){

		today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
		calendar();
	}

	function next(){

		today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
		calendar();

	}
	
	function calendar(){
		 // 이번 달의 첫 날
		 var firstDate = new Date(today.getFullYear(), today.getMonth(), 1);
		// 이번 달의 마지막 날
		 var lastDate = new Date(today.getFullYear(),today.getMonth()+1,0);
		 
         //날짜를 찍을 테이블 변수 만듬, 일 까지 다 찍힘
		 var calendarTitle = document.getElementById("calendarTitle");
		 calendarTitle.innerHTML = today.getFullYear() +" "+ (today.getMonth() + 1);
		
		 var dateColumn = document.getElementById("date-col");
		 	
		 while (dateColumn.rows.length > 0) {
				dateColumn.deleteRow(dateColumn.rows.length-1);
          }
		 var row = null;
		
		 var rowNum = 1;
		 row = dateColumn.insertRow(); // tr을 하나 만듦
		 row.className="row-"+rowNum;
		
		 var cnt = 0;
		 //이전 달 빈칸 채우기
		 var prevDate = new Date(today.getFullYear(),today.getMonth(), 0);
		 var prevDay = prevDate.getDate();	
		 var prevMonthValue = new Date();
		
		 for (var i = 0 ; i < firstDate.getDay() ; i++){ // 기준 날짜의 요일을 반환 일요일 : 0
			 cell = row.insertCell(); // 빈칸을 채움
			 cnt = cnt + 1;
			
				prevDay = prevDay - firstDate.getDay()+i+1;
				prevMonthValue = new Date(today.getFullYear(),today.getMonth()-1, prevDay);
				
				
				cell.innerHTML = "<font color=#bbb>" + prevDay+"<input class='dateInfo' type='hidden' value='"+prevMonthValue.format('yyyy-MM-dd')+"'></font>";
				 
				prevDay = prevDate.getDate();
		 } 
		
		 var thisMonthValue = new Date();
		
		 for (i=1; i<= lastDate.getDate(); i++) {  // 기준 날짜의 정확한 날짜
				//1일부터 마지막 일까지 돌림
				cell = row.insertCell();//열 한칸한칸 계속 만들어주는 역할
				thisMonthValue = new Date(today.getFullYear(), today.getMonth() , i);
				cell.innerHTML ="<font color=#000>" + i +"<input class='dateInfo' type='hidden' value='"+thisMonthValue.format('yyyy-MM-dd')+"'></font>";
				
				cnt = cnt + 1;//열의 갯수를 계속 다음으로 위치하게 해주는 역할
		
				if (cnt % 7 == 1) {/*일요일 계산*/
					//1주일이 7일 이므로 일요일 구하기
					//월화수목금토일을 7로 나눴을때 나머지가 1이면 cnt가 1번째에 위치함을 의미한다
					cell.innerHTML = "<font color=#F79DC2>" + i +"<input class='dateInfo' type='hidden' value='"+thisMonthValue.format('yyyy-MM-dd')+"'></font>";
					//1번째의 cell에만 색칠
				}    
				
				if (cnt%7 == 0){/* 1주일이 7일 이므로 토요일 구하기*/
					//월화수목금토일을 7로 나눴을때 나머지가 0이면 cnt가 7번째에 위치함을 의미한다
					cell.innerHTML = "<font color=skyblue>" + i +"<input class='dateInfo' type='hidden' value='"+thisMonthValue.format('yyyy-MM-dd')+"'></font>";
					//7번째의 cell에만 색칠
					row = dateColumn.insertRow();
					rowNum = rowNum + 1;
					row.className="row-"+ rowNum;
					//토요일 다음에 올 셀을 추가
        		 }
				/*오늘의 날짜에 노란색 칠하기*/
				if (today.getFullYear() == date.getFullYear()
					&& today.getMonth() == date.getMonth()
					&& i == date.getDate()) {
					//달력에 있는 년,달과 내 컴퓨터의 로컬 년,달이 같고, 일이 오늘의 일과 같으면
					cell.bgColor = "#FAF58C";//셀의 배경색을 노랑으로 
				}
				
			}
		 
		 
		//다음 달 빈 칸 채우기 #1
		var nextDay = dateColumn.lastElementChild.childElementCount;
		var x = 8 - nextDay;
		var j = 1;
		var nextMonthValue = new Date();
		
		if( nextDay != 0  && nextDay <7){
			
			for (j = 1 ; j < x ; j++){
					nextMonthValue = new  Date(today.getFullYear(), today.getMonth()+1 , j);
					 cell = row.insertCell();
					 cell.innerHTML = "<font color=#bbb>" + j +"<input class='dateInfo' type='hidden' value='"+nextMonthValue.format('yyyy-MM-dd')+"'></font>";
			 }
			
			
			if(dateColumn.childElementCount < 6){
				
				row = dateColumn.insertRow();
				rowNum = rowNum + 1;
				row.className="row-"+ rowNum;
				var k = j;
				
				for(k = j ; k < j+7 ;k++){
					nextMonthValue = new  Date(today.getFullYear(), today.getMonth()+1 , k);
					cell = row.insertCell();
					cell.innerHTML = "<font color=#bbb>" + k+"<input class='dateInfo' type='hidden' value='"+nextMonthValue.format('yyyy-MM-dd')+"'></font>";
				}
				
			}
		}
		
		//다음 달 빈 칸 채우기 #2
		if(nextDay == 0 && dateColumn.childElementCount == 6){
			
			var k = j;
			
			for(k = j ; k < j+7 ;k++){
				nextMonthValue = new  Date(today.getFullYear(), today.getMonth()+1 , k);
				cell = row.insertCell();
				cell.innerHTML = "<font color=#bbb>" + k+"<input class='dateInfo' type='hidden' value='"+nextMonthValue.format('yyyy-MM-dd')+"'></font>";
			}
		}
		 
		 
		 
		  
		 //column 클래스 이름 넣기
		 for(var p = 0 ; p <7 ; p++){
			 var findRowNum = 6 - p;
			 var parentColumn =$(".row-"+findRowNum);
			 var childrenLength = parentColumn.children().length;
			 
			 for (var q = 0 ; q < childrenLength ; q++){
				 
				 var colNum = q + 1;
				 parentColumn.children("td:eq("+q+")").addClass("column-"+colNum);
				 
			 }
			 
		 }
	}
	

</script>

<div class="planner">
<div id='planner_${gui.usercode}' class="calendar-container">
	<div class="calendar-nav">
		<div class="col-3 nav-group-left">
			<span class="p-title" id="calendarTitle"></span>
		</div> 
		<div class="col-6 nav-group-center">
			<div class="btn-group btn-group-toggle nav-btn-group" data-toggle="buttons">
				<label class="btn btn-light">
					<input type="radio" name="options" id="MONTH" autocomplete="off" > MONTH
				</label>
				<label class="btn btn-light">
					<input type="radio" name="options" id="MONTH" autocomplete="off" > WEEK
				</label>
				<label class="btn btn-light">
					<input type="radio" name="options" id="MONTH" autocomplete="off" > DAY
				</label>
			</div>	
		</div>
		<div class="col-3 nav-group-right">
			<div class="btn-group btn-group-toggle nav-btn-group" data-toggle="buttons">
				<label class="btn btn-light" onclick="now()">
					<input type="radio" name="options" id="MONTH" autocomplete="off" > TODAY
				</label>
				<label class="btn btn-light" onclick="prev()">
					<input type="radio" name="options" id="MONTH" autocomplete="off" > &#60;
				</label>
				<label class="btn btn-light" onclick="next()">
					<input type="radio" name="options" id="MONTH" autocomplete="off" > &#62;
				</label>
			</div>	
		</div>
		
	</div>
	<div class="calendar-body">
		<table id="calendar" class="table">
			<thead id="weekday">
				<tr id="dayHeader">
					<td class="sunday">일</td>
					<td class="weekday">월</td>
					<td class="weekday">화</td>
					<td class="weekday">수</td>
					<td class="weekday">목</td>
					<td class="weekday">금</td>
					<td class="saturday">토</td>
				</tr>
			</thead>
			<tbody id="date-col">
			
			</tbody>
		</table>
	</div>
</div>
</div>
<!-- 스케쥴 추가 모달  -->
<div class="modal fade eventPop" id="" tabindex="-1" role="dialog"
	aria-labelledby="eventPop-modalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header eventPop-header">
				<h5 class="modal-title signUp-title">스케쥴 작성</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
      	</div>
		<div class="modal-body eventPop-body">
			<form id="eventPop-form" name="eventPop-form" action="#" method="POST">
				<div class="eventPop-input-form">
					<div class="input-group event-input-box">
						<div class="event-input-group title-content-group">
							<label class="form-check-label time-select-label" for="start-time"> 제목 </label>
							<input type="text" id="event-title" name="plantitle" class="form-control event-input" placeholder="제목">
						</div>
					</div>
					<div class="input-group event-input-box">
						<div class="event-input-group title-content-group">
							<label class="form-check-label time-select-label" for="start-time"> 내용 </label>
							<textarea onkeydown="textareaResize(this)" name="plan"  onkeyup="textareaResize(this)" id="event-content" class="form-control event-input" placeholder="내용"></textarea>
						</div>
					</div>
					<div class="input-group form-check event-input-box">
						<div class="allDay-chk-group">
							<input class="form-check-input" type="checkbox" value="" id="allDay-select-chk">
							<label class="form-check-label allDay-select-chk-label" for="allDay-select-chk"> 하루만 하기 </label>
						</div>
						<div class="time-chk-group">
							<input class="form-check-input" type="checkbox" value="" id="time-select-chk">
							<label class="form-check-label time-select-chk-label" for="time-select-chk"> 시간 정하기 </label>
						</div>
					</div>
					<div class="input-group event-input-box select-day-time-box">
						<div class="event-input-group day-time-group" id="group-start-day">
							<label class="form-check-label day-select-label" for="start-day">시작 날짜</label>
							<div id="sdb" class="input-group" onclick="$('#start-day').datepicker('show')" >
								<input type="text" name="date" class="form-control event-input day-time-input" disabled="disabled" id="start-day" value="">
 								<label class="input-group-append" for="start-day">
    								<span class="input-group-text event-input" ><i class="far fa-calendar-alt"></i></span>
  								</label>
  							</div>
  						</div>
  						
						
  						<div class="between-empty">
  						</div>
  						<div class="event-input-group day-time-group" id="group-end-day">
  							<label class="form-check-label day-select-label" for="end-day"> 끝 날짜</label>
  							<div id="edb" class="input-group" onclick="$('#end-day').datepicker('show')">
								<input type="text" class="form-control event-input day-time-input" disabled="disabled" id="end-day" value="">
 								<label class="input-group-append" for="end-day">
    								<span class="input-group-text event-input"><i class="far fa-calendar-alt"></i></span>
  								</label>
  							</div> 
  						</div>
  					</div>
  					
					
					<div class="input-group event-input-box select-day-time-box" id="select-time-box">
						<div class="event-input-group day-time-group" id="group-start-time">
							<label class="form-check-label time-select-label" for="start-time"> 시작 시간</label>
							<div class="input-group " data-autoclose="true">
								<input type="text" class="form-control event-input day-time-input" id="start-time" value="00 : 00">
 								<label class="input-group-append" for="start-time" onclick="$('#start-time').timepicker()">
    								<span class="input-group-text event-input"><i class="far fa-clock"></i></span>
  								</label>
  							</div>
  						</div>
  						<div class="between-empty">
  						</div>
  						<div class="event-input-group day-time-group" id="group-end-time">
  							<label class="form-check-label time-select-label" for="end-time"> 끝 시간</label>
  							<div class="input-group ">
								<input type="text" class="form-control event-input day-time-input"  id="end-time" value="00 : 00">
 								<label class="input-group-append"  for="end-time" onclick="$('#end-time').timepicker()">
    								<span class="input-group-text event-input"><i class="far fa-clock"></i></span>
  								</label>
  							</div> 
  						</div>
  					</div>
					
					<div class="input-group event-input-box color-radio-box">
						<div class="color-radio-group">
							<input type="radio" class="color-radio" id="red-color"><label class="color-label" for="red-color"></label>
						</div>
						<div class="color-radio-group">
							<input type="radio" class="color-radio" id="orange-color"><label class="color-label" for="orange-color"></label>
						</div>
						<div class="color-radio-group">
							<input type="radio" class="color-radio" id="yellow-color"><label class="color-label" for="yellow-color"></label>
						</div>
						<div class="color-radio-group">
							<input type="radio" class="color-radio" id="green-color"><label class="color-label" for="green-color"></label>
						</div>
						<div class="color-radio-group">
							<input type="radio" class="color-radio" id="blue-color"><label class="color-label" for="blue-color"></label>
						</div>
						<div class="color-radio-group">
							<input type="radio" class="color-radio" id="navy-color"><label class="color-label" for="navy-color"></label>
						</div>
								
					</div>
					
				</div>
			</form>
		</div>
      <div class="modal-footer eventPop-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary">저장</button>
      </div>
    </div>
  </div>
</div>




<script type="text/javascript">

	calendar();
 	
	$(document).ready(function(){
		
		var keyupCnt = 0;
		
		$(document).on("click", "td", function(){
			
			var tdNum= $(this).attr("class");
			var trNum= $(this).parent().attr("class");
			var dateInfo = $(this).find(".dateInfo").val();
			
		
			$(".eventPop").attr("id",dateInfo);
			$("#start-day").val(dateInfo);
			$("#end-day").val(dateInfo);
			
			$("#"+dateInfo).modal();
		})
		
		
		$("#time-select-chk").change(function(){
       		 	
			if($("#time-select-chk").is(":checked")){
				$("#select-time-box").css("display","flex");
				$(".time-chk-group").css("color","#5286F3");
			}else{
				$("#select-time-box").css("display","none");
				$(".time-chk-group").css("color","#000");
			}
			
		})
		$("#allDay-select-chk").change(function(){
       		 	
			if($("#allDay-select-chk").is(":checked")){
				
				$("#sdb").attr("onclick","#");
				$("#edb").attr("onclick","#");
				$("#end-day").val($("#start-day").val());
			}else{
				
				$("#edb").attr("onclick","$('#end-day').datepicker('show')");
				$("#sdb").attr("onclick","$('#start-day').datepicker('show')");
			
			
			}
			
		})
		
		$(".time-chk-group").hover(function(){
			
			$(".time-chk-group").css("color", "#5286F3");
			
		},function(){
		
			$(".time-chk-group").css("color", "#000");
				
			
		})
		$(".allDay-chk-group").hover(function(){
			
			$(".allDay-chk-group").css("color", "#5286F3");
			
		},function(){
		
			$(".allDay-chk-group").css("color", "#000");
				
			
		})
		 
		var colorArr = ["#ff0068", "#ff8100", "#ffc800", "#00ff43", "#00a1ff", "#1b00ff"];
		
		$(".color-radio").each(function(){
			var i = $(".color-radio").index(this); 
			$(this).next().css("background-color",colorArr[i]);
			//alert("i :"+i);
		})
		
		$(".day-time-input").focus(function(){
			$(this).parent().css("border-radius", ".25rem");
			$(this).parent().css("box-shadow","0 0 0 0.2rem rgb(0 123 255 / 25%)");
		})
		
		$(".day-time-input").focusout(function(){
			$(this).parent().css("border-radius", "0");
			$(this).parent().css("box-shadow","none");
		})
		
		
		
		/*날짜 선택  */
		/* $(".day-time-group").on("click",function(){
			
			var dtpickStr =$(this).attr("id");
			var dtpick = dtpickStr.includes("day");
			
			switch(dtpick){
			
				case true  :
					
				
					break;
				
				case false  :
					alert("시간");
					break;
				 default:
					alert("error");
					break;
			}
		})
		 */
		
		
		$(function(){
			var today = new Date();
			var y = today.getFullYear();
			var m = today.getMonth();
			var d = today.getDate();
			var prevY = y-1;
			var nextFiveY = y+5;
		   
			$("#start-day, #end-day").datepicker({
		
			showOn: "focus", // 버튼과 텍스트 필드 모두 캘린더를 보여준다. 
	    	changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
	    	changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
	    	minDate: '-2y', // 현재날짜로부터 100년이전까지 년을 표시한다. 
	    	nextText: '다음 달', // next 아이콘의 툴팁. 
	    	prevText: '이전 달', // prev 아이콘의 툴팁. 
	    	numberOfMonths: [1,1], // 한번에 얼마나 많은 월을 표시할것인가. [2,3] 일 경우, 2(행) x 3(열) = 6개의 월을 표시한다.
	    	stepMonths: 1, // next, prev 버튼을 클릭했을때 얼마나 많은 월을 이동하여 표시하는가.
	    	showButtonPanel: true, // 캘린더 하단에 버튼 패널을 표시한다. 
			currentText: '오늘 날짜' , // 오늘 날짜로 이동하는 버튼 패널
	    	closeText: '닫기', // 닫기 버튼 패널 
		    dateFormat: "yy-mm-dd", // 텍스트 필드에 입력되는 날짜 형식.  
		    showMonthAfterYear: true , // 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다.
			dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], // 요일의 한글 형식. 
		    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'], // 월의 한글 형식.
			yearRange:  prevY+":"+nextFiveY //연도 범위
			    	
		
			});
			
			 

		}) 	

		$("#start-time, #end-time").timepicker();
			
	
		
	})
	

	function textareaResize(obj){
		
		obj.style.height= "1px";
		obj.style.height = (12+obj.scrollHeight)+"px";
		
	}
</script>

