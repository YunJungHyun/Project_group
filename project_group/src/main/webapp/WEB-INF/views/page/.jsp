<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


main

<!-- 회원 가입 모달  -->
<div class="modal fade" id="guiInfoUpdate" tabindex="-1" role="dialog"
	aria-labelledby="guiInfoUpdateLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header signUp-header">
				<h5 class="modal-title signUp-title" id="guiInfoUpdateLabel">기본 정보 입력</h5>
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
						<input type="text" class="signUp-input" id="nickname" name="nickname" maxlength="6"  value="${gui.nickname}">
						<div class="line-box">
							<div class="line"></div>
						</div>
						
					</label>
					<label>
						<p class="label-txt">DATE OF BIRTH </p> 
						<input type="text" class="signUp-input" id="strBirth" name="strBirth" placeholder="&#8251; 생년월일  8자리를  '-' 없이 입력하세요." value="${gui.birth }">
						<div class="line-box">
							<div class="line"></div>
						</div>
					</label>
					<label>
						<p class="label-txt">GENDER</p> 
						<div class="reg-radio" >
						
						<input type="radio" value="male"  id="male" name="gender" 
							<c:if test="${gui.gender == 'male' }">
							checked="checked"
							</c:if>>
							<label for="male">남성</label>
					
						<input type="radio" value="female" id="female" name="gender"
							<c:if test="${gui.gender == 'female' }">
							checked="checked"
							</c:if>>
							<label for="female">여성</label>
						</div>
					</label>
					
					<label>
						<p class="label-txt">PHONE NUMBER</p> 
						
						<input type="text" id="phn" name="phn" class="signUp-input" placeholder="&#8251; 휴대전화번호 10~11자리를  '-' 없이 입력하세요." value="${gui.phn }">
						
						<div class="line-box ">
							<div class="line"></div>
		
						</div>
					
					</label>
					
					
				</form>
			</div>
			<div class="modal-footer signUp-footer">
				<button type="submit" form="reg-form" id="reg-form-submit">가입 완료</button>
			</div>
		</div>
	</div>
</div>



<input type="button" value="연결 끊기" onclick="location.href='/unlink'">
<a href="/logout" class="btn btn-secondary">로그아웃</a>

<script type="text/javascript"> 

	$(document).ready(function(){
		
		var kakaoReg = "${kakaoReg}";
		
		alert(kakaoReg);
		if(kakaoReg=="yes"){
			$("#guiInfoUpdate").modal("show");
		}
		
		
		 var nameRegExp=  /^[가-힣]+$/; //이름 유효성 검사 > 한글만 입력
		 var nickNameRegExp=  /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]{2,6}$/; //닉네임 유효성 검사
		 var regExp = /^[0-9]*$/; //숫자로만 구성되어있는지
		 var phnRegExp = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;// 휴대전화 유효성검사
	
		
		 $('.signUp-input').focus(function(){
			    $(this).parent().find(".label-txt").addClass('label-active');
			});

		 $(".signUp-input").focusout(function(){
			    if ($(this).val() == '') {
			      $(this).parent().find(".label-txt").removeClass('label-active');
			    };
		 });
		 
		 
	})
</script>
