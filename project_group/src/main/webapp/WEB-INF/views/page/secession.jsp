<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div class="container secession-container">
	<div class="secession">
		<div class="session-form">
			<div class="secession-title">
				<h5>회원 탈퇴</h5>
			</div>

			<div class="secession-body">
				<form id="secession-form">
					<div class="form-group secession-row">
						<label for="secession-input" class="secession-label col-sm-2 col-form-label">회원
							아이디</label>
						<div class="secession-input col-sm-10 readonly-input">
							<input type="text" id="secession-input" readonly class="form-control-plaintext" value="${gui.userid}">
						</div>
					</div>
					<c:if test="${gui.loginsort == 'SP' }">
					<div class="form-group secession-row">
						<label for="secession-input-password" class="secession-label col-sm-2 col-form-label">비밀번호</label>
						<div class="secession-input col-sm-10 password-input">
							<input type="password" class="form-control" id="secession-input-password" name="input-password"
								placeholder="비밀번호">
						</div>
					</div>
					</c:if>
				</form>
				<div class="session-btn-group">
					<button class="session-btn" id="session-btn">회원 탈퇴</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$("#session-btn").on("click" ,function(){
		
		var loginsort = '${gui.loginsort}';
		
		if(loginsort =="SP" && $("input[name='input-password']").val() == ""){
			
			alert("비밀번호를 입력해주세요");
			$("#secession-input-password").focus();
			return false;
		}else{
		
			if(loginsort =="SP"){
			$.ajax({
			
				url : "/secessionPwChk",
				data : {
				
					"inputpw" : $("input[name='input-password']").val()
 				},
 				async :false,
 				success : function(data){
 				
 					if(data == "pwChkSuccess"){
 						
 						var con = confirm("회원탈퇴 시 기존 데이터가 전부 사라집니다. 정말 회원탈퇴를 하시겠습니까?");
 						
 						if(con ==true){
 							
 							userDelete();
 						}
 					}else if( data == "pwChkFail"){
 						
 						alert("비밀번호를 확인해주세요");
 						$("#secession-input-password").focus();
 						return false;
 					}else {
 						
 						alert("error");
 					}
 				},error : function(){
 				
 					alert("error");
 				}
			
			})
			
			}else{
				
					var con = confirm("회원탈퇴 시 기존 데이터가 전부 사라집니다. 정말 회원탈퇴를 하시겠습니까?");
					
					if(con ==true){
						
						userDelete();
					}
			}
		}
	})
	
	function userDelete(){
		
		$.ajax({
			
			url : "/userDelete",
			success : function(data){
				
				alert("회원 탈퇴하였습니다.");
				
				location.href="/YooNPlanner"
			}
			
		})
		
	}
</script>