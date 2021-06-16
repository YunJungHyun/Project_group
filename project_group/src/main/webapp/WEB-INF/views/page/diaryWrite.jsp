<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<script>
	 var date = new Date();
	 var now = date.format("yyyy년 MM월 dd일");
	
	 $(document).ready(function(){ 
		 
		 $("#writeDay").val(now);
	 })
</script>

<div class="diary-container container">
	<div id="planner_${gui.usercode}" class="diary">
		<form id="diary-form" name="diary-form" class="diary-form">

			<div class="diary-group">
				<div class="diary-label-box">
					<label class="diary-label">날짜</label>
				</div>
				<div class="diary-input-box form-group">

					<input type="text" id="writeDay" name="writeDay"
						class="form-control diary-input">
				</div>
			</div>
			<div class="diary-group">
				<div class="diary-label-box">
					<label class="diary-label">제목</label>
				</div>
				<div class="diary-input-box form-group">
					<input type="text" id="dtitle" name="dtitle" class="form-control diary-input" autocomplete="off">
				</div>
			</div>
			<div class="diary-group">
				<div class="diary-label-box">
					<label class="diary-label">내용</label>
				</div>
				<div class="diary-input-box form-group">
					<textarea class="form-control diaryTextarea diary-input" rows="7"
						name="dcontents" id="dcontents" autocomplete="off"></textarea>
				</div>
			</div>
		</form>
		<div class="diary-btn-group">
			<button type="button" id="diary-insert-btn" form="diary-form">저장</button>
			<button type="button">취소</button>
		</div>
	</div>
</div>

<script> 

	$(".diary-input").focus(function(){
		
		$(this).parent().prev().children().addClass("diary-input-focus");
		
	})
	$(".diary-input").focusout(function(){
		
		$(this).parent().prev().children().removeClass("diary-input-focus");
		
	})
	
	$("#diary-insert-btn").on("click",function(){
		var nowDate = new Date();
		var writeDay = null;
		
		if(nowDate.format("yyyy년 MM월 dd일") == $("#writeDay").val()){
			
			writeDay = nowDate.format("yyyy-MM-dd HH:mm:ss");
		}else{
			var inputDate =$("#writeDay").val();
			var year =inputDate.split("년");
			var month =year[1].split("월");
			var day =month[1].split("일");
			
			var inputDate2 = year[0].trim()+"-"+month[0].trim()+"-"+day[0].trim();
			var d = new Date(inputDate2);
			writeDay = d.format("yyyy-MM-dd 00:00:00");
		}
		var testDay = new Date(writeDay);
		
		if(testDay > nowDate){
			alert("일기는 미리 작성 할 수 없습니다. 날짜를 다시 선택해주세요.");
			return false;
		}
		var wchk= false;
		
		$.ajax({
			
			url : "/todayWriteCheck",
			data :{
				"usercode" : "${gui.usercode}",
				"writeDay" :writeDay
			},
			async:false,
			success: function(data){
				
				if(data == "fail"){
					
					alert("선택한 날짜의 일기는 이미 작성하였습니다.");
					location.href="/diaryList";
					wchk=false;
				}else{
					
					wchk =true;
				}
				
			},error : function(){
				
				alert("error");
			}
			
		})
		
		if(wchk){
			
			
			
			$.ajax({
			
				url : "/diaryInsert",
				data :{
					"usercode" : "${gui.usercode}",
					"writeDay" :writeDay,
					"dtitle" : $("#dtitle").val(),
					"dcontents" : $("#dcontents").val()
				},success: function(data){
				
					if(data =="success"){
					
						alert("일기를 작성에 성공하였습니다.");
						location.href="/diaryList";
					}else{
					
						alert("error");
					}
				},error : function(){
				
					alert("error");
				}
			
			})
		}
		
	})
	
	
		$(function() {
					var today = new Date();
					var y = today.getFullYear();
					var m = today.getMonth();
					var d = today.getDate();
					var prevY = y - 1;
					var nextFiveY = y + 5;

					$("#writeDay").datepicker(
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
								dateFormat : "yy년 mm월 dd일", // 텍스트 필드에 입력되는 날짜 형식.  
								showMonthAfterYear : true, // 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다.
								dayNamesMin : [ '월', '화', '수', '목', '금', '토',
										'일' ], // 요일의 한글 형식. 
								monthNamesShort : [ '1월', '2월', '3월', '4월',
										'5월', '6월', '7월', '8월', '9월', '10월',
										'11월', '12월' ], // 월의 한글 형식.
								yearRange : prevY + ":" + nextFiveY //연도 범위

							});
				})
</script>