<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page trimDirectiveWhitespaces="true"%>

<script>
$(document).ready(function(){
	var today = new Date();
	
	if(sessionStorage.getItem("sort") == null || sessionStorage.getItem("sort") == "DESC"){
		
		sessionStorage.setItem("sort","DESC");
		$(".d-sort-icon").html("<i class='fas fa-sort-numeric-up-alt'></i>");
	}
	
	if(sessionStorage.getItem("sort") == "ASC"){
		
		//sessionStorage.setItem("sort","ASC");
		$(".d-sort-icon").html("<i class='fas fa-sort-numeric-down'></i>");
	}
	
	diaryList(today.getFullYear(), today.getMonth(),sessionStorage.getItem("sort"));
	
	$(document).on("click",".d-list-next",function(){
		
		today = new Date(today.getFullYear(), today.getMonth() + 1,today.getDate());
		
		diaryList(today.getFullYear(), today.getMonth(),sessionStorage.getItem("sort"));
	})
	
	$(document).on("click",".d-list-prev",function(){
		
		today = new Date(today.getFullYear(), today.getMonth() -1,today.getDate());
		
		diaryList(today.getFullYear(), today.getMonth(),sessionStorage.getItem("sort"));
	})
	
	$(document).on("click", ".diary-collapse-btn", function(){
		
		$('div[name=diaryContents-collapse]').each(function() {

			if ($(this).hasClass('show')) {

				$(this).collapse('toggle');
			};
		})
		 
	})  

	$(document).on("click", ".d-sort-icon",function(){
		
		var sort = sessionStorage.getItem("sort");
		
		var yearMonthStr =$(".d-list-month").text();
		var yearMonthArr = yearMonthStr.split(" ");
		var yearArr =yearMonthArr[0].split("년");
		var monthArr =yearMonthArr[1].split("월");
		var year = yearArr[0];
		var month = monthArr[0] - 1;
		
		if(sort == "DESC"){
			
			sessionStorage.setItem("sort","ASC");
			
			$(".d-sort-icon").html("<i class='fas fa-sort-numeric-down'></i>");
			
			diaryList(year,month,sessionStorage.getItem("sort"));
		}
		
		if(sort=="ASC"){
			
			sessionStorage.setItem("sort","DESC");
			
			$(".d-sort-icon").html("<i class='fas fa-sort-numeric-up-alt'></i>");
			diaryList(year,month,sessionStorage.getItem("sort"));
			//alert(sessionStorage.getItem("sort"));
		}
	})
	
})
	
</script>



<div class="container diary-container">
	<div id="planner_${gui.usercode}" class="diary">
		<div class="diary-list">
			<div class="diary-list-nav">
				
				<div class="col-9 d-list-head-title">	
					<div class="d-list-prev"><i class='fas fa-chevron-left'></i></div>
					<div class="d-list-month"></div>
					<div class="d-list-next"><i class='fas fa-chevron-right'></i></div>
				</div>
				
				<div class="col-1 d-insert-icon"><a href="/diaryWrite"><i class="fas fa-pen"></i></a></div>
				<div class="col-1 d-update-icon"><i class="fas fa-wrench"></i></div>
				<div class="col-1 d-sort-icon"></div>
			</div> 
			<div class="diary-list-body">
			
			</div>
		</div>
	</div>
</div>
 
<script> 

function diaryList(year,month,sort){ 
	var realMonth = month + 1;
	
	$(".d-list-month").text(year+"년 "+realMonth+"월");
	

	var yearMonth = new Date(year+"-"+realMonth); 
	var yearMonthStr = yearMonth.format("yyyy-MM");
	
	
	
	$.ajax({
		
		url : "/getDiaryList",
		type:"POST",
		data : {
			
			"yearMonth" :yearMonthStr,
			"sort" :sort
		},success : function(list){
			var output='';
			if(list.length != 0){
			
			for(var i = 0 ; i <list.length ; i++){
				//alert(list[i].dtitle);
				
				var writeDay = new Date(list[i].writeDay);
				var regDay = new Date(list[i].regDay);
				output+='<div class="diary-row" >';
				output += '<a  class="diary-collapse-btn col-8" data-toggle="collapse" id="diary-num-'+list[i].dnum+'" href="#diaryCollapse-'+list[i].dnum+'" role="button" aria-expanded="false" aria-controls="diaryCollapse-'+list[i].dnum+'">';
				output += '<div class="d-list-title ">';
				output += list[i].dtitle ;
				output += '</div></a>';	 

				output += '<div class="d-list-writeDay col-4"  >';	 
				output += writeDay.format("yyyy년 MM월 dd일") ;
				output += '</div>';	 
				
				output += '</div>';
				
				output += '<div class="collapse" id="diaryCollapse-'+list[i].dnum+'" name="diaryContents-collapse">';
				
				output += '<div class="card card-body diary-contents-box">';
				output += '<div class="regDay-box">';
				output += regDay.format("yyyy년 MM월 dd일 :: HH시 mm분")+"에 작성"; 
				output += '</div>'; 
				output += '<div class="regDay-line"></div>';
				output += '<div class="diary-title-box">';
				output += '<span class="anno-span col-3">제목 : </span>';
				output += '<span class="diary-title" id="dtitle-'+list[i].dnum+'">'+list[i].dtitle+'</span>';
				output += '</div>';
				output += '<pre id="dcontents-'+list[i].dnum+'" class="diary-contents">'+list[i].dcontents+'</pre>';
				 
				output += '</div></div>';
				
			}  
			}else{
				
			 	output += '<div>작성된 일기가 없습니다</div>';
			}
			
			$(".diary-list-body").html(output);
			
		},error: function(){
			
			alert("error");
		}
	})
}


$(".d-update-icon").on("click",function(){
		
		if(!$(".diary-collapse-btn").hasClass("diary-edit-add")){
			$(".diary-collapse-btn").removeClass("col-8");
			$(".diary-collapse-btn").addClass("col-6");
			$(".diary-collapse-btn").addClass("diary-edit-add");
			$(".diary-row").append("<div class='diary-update-btn col-1'><i class='far fa-edit'></i></div><div class='diary-delete-btn col-1'><i class='far fa-trash-alt'></i></div>")
			
		}else{
			
			$(".diary-collapse-btn").removeClass("col-6");
			$(".diary-collapse-btn").removeClass("diary-edit-add");
			$(".diary-collapse-btn").addClass("col-8");
			$(".diary-update-btn").remove();
			$(".diary-delete-btn").remove();
		}
		
	})
	
	$(document).on("click", ".diary-update-btn", function(){
		
		var diaryId=$(this).prev().prev().attr("id");
		var diaryId = diaryId.split("-");
		var diaryNum = diaryId[2];
		var diaryTitleText = $("#dtitle-"+diaryNum).text();
		
		if($("#diaryCollapse-"+diaryNum).hasClass('diaryUpdate')){
			
			
			$("#diaryCollapse-"+diaryNum).removeClass('diaryUpdate');
			$('#dtitle-'+diaryNum).contents().unwrap().wrap('<span id="dtitle-'+diaryNum+'" class="diary-title"></span>'  );
			$('#dcontents-'+diaryNum).contents().unwrap().wrap('<pre id="dcontents-'+diaryNum+'" class="diary-contents" ></pre>' );	
			$(".diary-update-btn-group").remove();
		
		}else {
		 
	
			
			if(!$("#diaryCollapse-"+diaryNum).hasClass('show')){
				$("#diaryCollapse-"+diaryNum).collapse('show');
			}
			
			$("#diaryCollapse-"+diaryNum).addClass('diaryUpdate');
			$('#dtitle-'+diaryNum).contents().unwrap().wrap('<input id="dtitle-'+diaryNum+'" class="col-9 form-control diaryUpdateInput" value="'+diaryTitleText+'" autocomplete="off">'  );
			$('#dcontents-'+diaryNum).contents().unwrap().wrap('<textarea id="dcontents-'+diaryNum+'" class="form-control diaryUpdateTextarea" rows="5" autocomplete="off"></textarea>' );
			
			var output ="<div class='diary-update-btn-group'>";
				output +="<button type='button' class='diary-update-button' id='diary-update-"+diaryNum+"'>저장</button>";
				output +="<button type='button' id='diary-update-cancel'>취소</button>";
				output +="</div>";
				
			$("#diaryCollapse-"+diaryNum).children().append(output);
			
			
		}
	})
	
	$(document).on("click", ".diary-update-button" ,function(){
		
		var btnId = $(this).attr("id");
		var btnId =btnId.split("-");
		var diaryNum= btnId[2];
		
		var dtitle = $("#dtitle-"+diaryNum).val();
		var dcontents = $("#dcontents-"+diaryNum).val();
		
		var regDate =new Date();
		var regDay =regDate.format("yyyy-MM-dd HH:mm:ss");
		$.ajax({
			
			
			url : "/diaryUpdate",
			data : {
				"usercode" : "${gui.usercode}",
				"dtitle" : dtitle,
				"dcontents" : dcontents,
				"dnum" :diaryNum,
				"regDay" :regDay
				
			},
			success :function(data){
				
				if(data=="success"){
					
					alert("수정되었습니다.");
					location.reload();
				}else{
					
					alert("error");
					location.reload();
				}
				
			},error : function(){
				
				alert("error");
			}
		})
		
	})
	
	$(document).on("click", ".diary-delete-btn", function(){
		
		var diaryId=$(this).prev().prev().prev().attr("id");
		var diaryDay = $(this).prev().prev().text().trim();
		
		var diaryId = diaryId.split("-");
		
		var diaryNum = diaryId[2];
		
		var con = confirm(diaryDay+"날 일기를 삭제하시겠습니까?");
		
		if(con){
			
			$.ajax({
				
				url : "/diaryDelete",
				data : {
					
					"usercode":"${gui.usercode}",
					"dnum": diaryNum
				},success: function(data){
					
					if(data == "success"){
						
						alert("해당 일기가 삭제 되었습니다.");
						location.reload();
					}else{
						
						alert("error");
						location.reload();
					}
					
				},error : function(){
					
					alert("error");
				}
			})
		}
		
	})
</script>