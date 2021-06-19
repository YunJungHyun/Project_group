<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>



<!-- 회원 가입 모달  -->
<div class="modal fade" id="guiUpdateModal" tabindex="-1" role="dialog"
	aria-labelledby="guiUpdateModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header signUp-header">
				<h5 class="modal-title signUp-title" id="guiUpdateModalLabel">기본 정보 입력</h5>
				<button type="button" class="close modal-cancel cancel"
					data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body signUp-body">
				<form id="api-reg-form" name="api-reg-form" action="/oauthSignUp" method="POST">
					
					
					<label class="reg-label">
						<p class="label-txt label-active">이름</p> 
						<input type="text" class="signUp-input" id="username" name="username" value="${gui.username}">
						
					</label>
					
					<label class="reg-label">
						<p class="label-txt">생일 </p> 
						<input type="text" class="signUp-input" id="strBirth" name="strBirth" placeholder="&#8251; 생년월일  8자리를  '-' 없이 입력하세요." value="${gui.birth}">
						
					</label>
					<label class="reg-label">
						<p class="label-txt">성별</p> 
						<div class="reg-radio" >
					
						<input type="radio" value="male"  id="male" name="gender" <c:if test="${gui.gender == 'male' }">
							checked="checked" 
						</c:if>
						<c:if test="${gui.gender != '' }">
							disabled="disabled"
						</c:if>
						>
							<label for="male">남성</label>
					
						<input type="radio" value="female" id="female" name="gender" <c:if test="${gui.gender == 'female' }">
							checked="checked" 
						</c:if>
						<c:if test="${gui.gender != '' }">
							disabled="disabled"
						</c:if>
						>
							<label for="female">여성</label>
						</div>
					</label>
					 <c:if test="${gui.gender != '' }">
							<input type="hidden" name="gender" value="${gui.gender }">
					</c:if>
					<input type="hidden" name="loginsort" value="${gui.loginsort }">
					<input type="hidden" name="usercode" value="${gui.usercode }">
					<input type="hidden" name="userid" value="${gui.userid }">
					<input type="hidden" name="profile_img" value="${gui.profile_img }">
					<input type="hidden" name="thumnail_img" value="${gui.thumnail_img }">
				</form>
			</div>
			<div class="modal-footer signUp-footer">
				<button type="submit" class="reg-btn" form="api-reg-form" id="api-reg-form-submit">추가 정보 입력 완료</button>
				<button type="button" class="reg-btn" class="cancel"> 취소 </button>
			</div>
		</div>
	</div>
</div>
 <script src="/resources/js/sign.js"></script>
 
 
 
 <script type="text/javascript">
 	
 	
 
 	$(document).ready(function(){
 		
 		
 			var REG ="${REG}";
 	 	
 			if(REG=="NO"){
 			
 				window.location.href="/plannerHome";
 			
 			}else{
 			
 				$("#guiUpdateModal").modal("show");
 			}
 		
 			$(".cancel").on("click",function(){
 				
 				window.location.href="/YooNPlanner";
 			})
 			
 			// Modal hidden event fired
  			$('#guiUpdateModal').on('hidden.bs.modal', function () {
  				window.location.href="/YooNPlanner";
 			 });
 			
 			var nameRegExp=  /^[가-힣]+$/; //이름 유효성 검사 > 한글만 입력
	 		var regExp = /^[0-9]*$/; //숫자로만 구성되어있는지
	 		var regExp = /^[0-9]*$/; //숫자로만 구성되어있는지
	 		
	 		$("#username").blur(function(){
	 			  
	 			  var username = $("#username").val().trim();
	 			  
	 			  
	 			  if(username !=""){
	 				  
	 				  if(username.length >=8){
	 					  
	 					    alert("이름은 8글자 이하로만 가능합니다.");
	 						$("#username").val("");
	 						$("#username").focus();
	 						
	 						return false;	  
	 				  }
	 				  
	 			  }
	 			  
	 		  })
	 		 
				 
 		$("#strBirth").blur(function(){
		  
		  var birth = $("#strBirth").val().trim();
		  
		  
		  if(birth !=""){
			    
			  var year = Number(birth.substr(0,4)); // 입력한 값의 0~4자리까지 (연) 
			  var month = Number(birth.substr(4,2)); // 입력한 값의 4번째 자리부터 2자리 숫자 (월) 
			  var day = Number(birth.substr(6,2)); // 입력한 값 6번째 자리부터 2자리 숫자 (일) 
			  var today = new Date(); // 날짜 변수 선언
			  var yearNow = today.getFullYear(); // 올해 연도 가져옴 
			  if( !regExp.test(birth)){
				  
				  alert("생년월일은 숫자로만 작성해주세요. ex) 20200101");
	  				$("#strBirth").val("");
	  				$("#strBirth").focus();
	  				return false;
			  
			  }else if (birth.length <=8) { // 연도의 경우 1900 보다 작거나 yearNow 보다 크다면 false를 반환합니다. 
				  
				 if (1900 > year || year > yearNow){ 
					 alert("생년월일의 연도가 잘못 되었습니다.");
					 $("#strBirth").val("");
					 $("#strBirth").focus();
					return false; 
				
				} else if (month < 1 || month > 12) { 
					
					alert("생년월일의 '월'이 잘못 되었습니다.");
					$("#strBirth").val("");
					$("#strBirth").focus();
					
					return false; 
				
				} else if (day < 1 || day > 31) { 
					
					alert("생년월일의 '날짜'가 잘못 되었습니다.");
					$("#strBirth").val("");
					$("#strBirth").focus();
					
					return false;
				
				} else if ((month==4 || month==6 || month==9 || month==11) && day==31) {
					
					alert("생년월일이 잘못되었습니다.");
					$("#strBirth").val("");
					$("#strBirth").focus();
					
					return false;
				
				} else if (month == 2) { 
					 
					var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
						
					if (day>29 || (day==29 && !isleap)) {
						
						alert("[윤달] 생년월일이 잘못되었습니다.");
						$("#strBirth").val("");
						$("#strBirth").focus();
						
						return false; 
						
					} else { 
							
						return true; 
						
					} //end of if (day>29 || (day==29 && !isleap)) 
				 } else {
					 
					 return true; 
					
				 }//end of if 
				} 
			  else { //1.입력된 생년월일이 8자 초과할때 : auth:false
				  
				alert("생년월일을 정확히 입력해주세요.");
				$("#strBirth").val("");
				$("#strBirth").focus();
					
				  
				  return false; 
			
			  }
			  
		  }
		  
	  })
	  
	  
	   	$("#api-reg-form-submit").on("click",function(){
 				
 					
 				var username = $("#username").val().trim();
 				
 				var birth =$("#strBirth").val().trim();
 				
 				if(username ==""){
 					
 					alert("회원 이름을 입력해주세요.");
 					$("#username").focus();
 					return false;
 				}
 				
 				if(birth ==""){
 					
 					alert("생년월일을 입력해주세요.");
 					$("#birth").focus();
 					return false;
 				}
 				if(!$("input:radio[name='gender']").is(':checked')){
 			 		
 			 		alert("성별을 선택해주세요.");
 			 		return false;
 			 	}
 				
 			
		 		
 			})
 	})
 
 
 	
 </script>