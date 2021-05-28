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
		 calendarTitle.innerHTML = today.getFullYear() +" "+ (today.getMonth() + 1) + ".";
		
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
				prevDateValue = new Date(today.getFullYear(),today.getMonth()-1, prevDay);
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
<style type="text/css">

</style>
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
				<label>
					<p class="label-txt">제목</p> 
					<input type="text" class="eventPop-input" id="" name="" maxlength="20" value="">
					<div class="line-box">
						<div class="line"></div>
					</div>
						
				</label>  
				<label>
					<p class="label-txt">내용</p> 
					<textarea rows="3"  class="eventPop-input pop-text-area"></textarea>
					<div class="line-box">
						<div class="line"></div>
					</div>
						
				</label>  
				
				<label>
					<div class="label-txt eventPop-chk">
						<span class="eventPop-chk-title">
							시간 정하기
						</span>
						<div class="eventPop-chk-btn">
							<input class="eventPop-chkbox" type="checkbox"> 
						</div>
					</div> 
				</label>
				
				
				<div class="row select-day-group">
					<div class="select-day-box startDay">
							<div class="select-title">시작 날짜</div> 
							<input type="text" value=""/>
					</div>
					<div class="select-day-box endDay">
						<div class="select-title">끝 날짜</div> 
						<input type="text" value=""/>
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
			
			$("#"+dateInfo).modal();
		})
		
		 $('.eventPop-input').focus(function(){
			    $(this).parent().find(".label-txt").addClass('label-active');
			  });

		$(".eventPop-input").focusout(function(){
			    if ($(this).val() == '') {
			      $(this).parent().find(".label-txt").removeClass('label-active');
			    };
			  });
			  
		$('.eventPop-chkbox').change(function(){
			
			var chk = $(this).is(":checked");
			
			if(chk == true){
				
				$(this).parent().parent().css("color", "#526df3");
			}else{
				
				$(this).parent().parent().css("color", "#000");
			}
		})	  
		 
		
		
		/* $(".pop-text-area").keyup(function(){
			
			if (window.event.keyCode == 13){
				alert($(".pop-text-area").val());
				keyupCnt += 1;
			
				if( keyupCnt > 4){
				
					$(".pop-text-area").attr("rows",keyupCnt);
				}
			}
		}) */
	})
	
	
</script>

