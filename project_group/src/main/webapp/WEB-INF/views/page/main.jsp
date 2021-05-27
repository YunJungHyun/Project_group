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
		 row = dateColumn.insertRow(); // tr을 하나 만듦
		 
		 var cnt = 0;
		
		/* 
		 if(firstDate.getDay()!=0){ 
			 var prevDate = new Date(today.getFullYear(),today.getMonth(), 0);
			 var prevDay = prevDate.getDate();
			 for (var k = 0 ; k < firstDate.getDay() ; k++){

			 		var text = prevDay - k;
			 		cell.innerHTML = i;

			 	}
			
			} */
		 
		 var prevDate = new Date(today.getFullYear(),today.getMonth(), 0);
		 var prevDay = prevDate.getDate();	
			
		 for (var i = 0 ; i < firstDate.getDay() ; i++){ // 기준 날짜의 요일을 반환 일요일 : 0
			 cell = row.insertCell(); // 빈칸을 채움
			 cnt = cnt + 1;
			
				prevDay = prevDay - firstDate.getDay()+i+1;
				cell.innerHTML = "<font color=#bbb>" + prevDay;
				prevDay = prevDate.getDate();
		 } 
		
		 for (i=1; i<= lastDate.getDate(); i++) {  // 기준 날짜의 정확한 날짜
				//1일부터 마지막 일까지 돌림
				cell = row.insertCell();//열 한칸한칸 계속 만들어주는 역할
				cell.innerHTML = i;//셀을 1부터 마지막 day까지 HTML 문법에 넣어줌
				cnt = cnt + 1;//열의 갯수를 계속 다음으로 위치하게 해주는 역할
		
				if (cnt % 7 == 1) {/*일요일 계산*/
					//1주일이 7일 이므로 일요일 구하기
					//월화수목금토일을 7로 나눴을때 나머지가 1이면 cnt가 1번째에 위치함을 의미한다
					cell.innerHTML = "<font color=#F79DC2>" + i
					//1번째의 cell에만 색칠
				}    
				
				if (cnt%7 == 0){/* 1주일이 7일 이므로 토요일 구하기*/
					//월화수목금토일을 7로 나눴을때 나머지가 0이면 cnt가 7번째에 위치함을 의미한다
					cell.innerHTML = "<font color=skyblue>" + i
					//7번째의 cell에만 색칠
					row = dateColumn.insertRow();
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
		 var emptyDay = dateColumn.lastElementChild.childElementCount;
		 //alert(emptyDay);
		 if( emptyDay != 0  && emptyDay <8){
			 var x = 8 - emptyDay;
			 for (var j = 1 ; j < x ; j++){
				 cell = row.insertCell();
				 cell.innerHTML = "<font color=#bbb>" + j;
			 }
		 }
	}
</script>
<style type="text/css">
.calendar-container {
	background-color: #526df3;
	border-radius: .5rem;
	box-shadow: 0 1px 2px #C3C3C3;
	-webkit-box-shadow: 0px 0px 21px 2px rgba(0, 0, 0, 0.18);
	-moz-box-shadow: 0px 0px 21px 2px rgba(0, 0, 0, 0.18);
	box-shadow: 0px 0px 21px 2px rgba(0, 0, 0, 0.18);
}

.calendar-nav {
	display: flex;
	padding: .3rem .3rem 1rem .3rem;
	
}

.calendar-nav {
    border-bottom: 2px solid #ffffff52;
}

.nav-group-left {
	font-family: 'Righteous', cursive;
	font-size: 32px;
	font-weight: bold;
	color : #fff;
	letter-spacing: 3px;
}

.nav-group-center {
	text-align: center;
	align-self: flex-end;
}

.nav-group-right {
	text-align: right;
	align-self: flex-end;
}
.nav-btn-group{

box-shadow: 0 1px 2px #C3C3C3;
	-webkit-box-shadow: 0px 0px 21px 2px rgba(0, 0, 0, 0.18);
	-moz-box-shadow: 0px 0px 21px 2px rgba(0, 0, 0, 0.18);
	box-shadow: 0px 0px 21px 2px rgba(0, 0, 0, 0.18);
}
.btn-light{

	font-size : 12px;
}

.table {
 	color : #fff;
 	text-align: center;
}

#dayHeader > td{
	padding: 0px;
    padding-top: .2rem;
    padding-bottom: .2rem;
    font-weight: bold;

}

#date-col > tr > td{

	height: 12vh;
    text-align: right;
}
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
					<td>일</td>
					<td>월</td>
					<td>화</td>
					<td>수</td>
					<td>목</td>
					<td>금</td>
					<td>토</td>
				</tr>
			</thead>
			<tbody id="date-col">
			
			</tbody>
		</table>
	</div>
</div>
</div>
<script type="text/javascript">


	calendar();
 
</script>

