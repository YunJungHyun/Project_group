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
				<button type="button" class="close modal-cancel"
					data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body signUp-body">
				<form id="reg-form" name="reg-form" >

					<label>
						<p class="label-txt">NAME</p> 
						<input type="text" class="signUp-input" id="username" name="username" value="${gui.username}">
						<div class="line-box">
							<div class="line"></div>
						</div>
					</label>
					<label>
						<p class="label-txt">NICKNAME</p> 
						<input type="text" class="signUp-input" id="nickname" name="nickname" maxlength="6" placeholder="&#8251; 별칭을 입력하세요." value="${gui.nickname }">
						<div class="line-box">
							<div class="line"></div>
						</div>
						
					</label>
					<label>
						<p class="label-txt">DATE OF BIRTH </p> 
						<input type="text" class="signUp-input" id="strBirth" name="strBirth" placeholder="&#8251; 생년월일  8자리를  '-' 없이 입력하세요." value="${gui.birth}">
						<div class="line-box">
							<div class="line"></div>
						</div>
					</label>
					<label>
						<p class="label-txt">GENDER</p> 
						<div class="reg-radio" >
					
						<input type="radio" value="male"  id="male" name="gender" <c:if test="${gui.gender == 'male' }">
							checked="checked"
						</c:if>>
							<label for="male">남성</label>
					
						<input type="radio" value="female" id="female" name="gender" <c:if test="${gui.gender == 'female' }">
							checked="checked"
						</c:if>>
							<label for="female">여성</label>
						</div>
					</label>
					
					<label>
						<p class="label-txt">PHONE NUMBER</p> 
						
						<input type="text" id="phn" name="phn" class="signUp-input" placeholder="&#8251; 휴대전화번호 10~11자리를  '-' 없이 입력하세요.">
						
						<div class="line-box ">
							<div class="line"></div>
		
						</div>
					
					</label>
					
					
				</form>
			</div>
			<div class="modal-footer signUp-footer">
				<button type="submit" form="reg-form" id="reg-form-submit">추가 정보 입력 완료</button>
				<button type="button"> 취소 </button>
			</div>
		</div>
	</div>
</div>
 
 
 
 
 <script type="text/javascript">
 	
 	$(document).ready(function(){
 		
 		
 			var REG ="${REG}";
 	 	
 			if(REG=="NO"){
 			
 				window.location.href="/plannerHome";
 			
 			}else{
 			
 				$("#guiUpdateModal").modal("show");
 			}
 		
 			
 	})
 	
 	
 	
 </script>