<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="simple-login-container">
	
    <h2>YOON PLANNER</h2>
    <form id="signIn-form" name="signIn-form" method="POST">
    <div class="row">
        <div class="col-md-12 form-group">
            <input type="text" class="form-control" id="signIn-userid" name="userid" placeholder="아이디 " autocomplete="off">
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 form-group"> 
            <input type="password" id="signIn-userpw" autocomplete="off" name="userpw" placeholder="패스워드" class="form-control" autocomplete="off">
        </div>
    </div>
    </form>
    <div class="row">
        <div class="col-md-12 form-group">
            <input type="submit" form="signIn-form" id="signIn-btn" class="btn btn-block btn-login" value="로그인">         	  
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 form-group" data-toggle="modal" data-target="#signUpModal"> 
             <input type="button" class="btn btn-block btn-signUp" value="회원 가입">
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 form-group"> 
            <a class="loginBtn" id="kakao" href="/signin/KAKAO" >
             	<span class="kakaoLogo">
             		<img src="resources/logo/kakaotalk_logo_icon_147272.png">
             	</span>
             	<span class="kakao-login logo-line">카카오 로그인</span>
            </a> 
        </div>
    </div>
   
    <div class="row">
  		<div class="col-md-12 form-group"> 
         	<a class="loginBtn" id="google" href="/signin/GOOGLE">
         		<span class="googleLogo">
         			<img src="resources/logo/Google_icon-icons.com_66793.png">
         		</span>
         		<span class="google-login logo-line">Google 로그인</span>
         	</a>
        </div> 
    </div> 
    
   <!--  <div>테스트입니다.</div>
    <a href="http://localhost:8081/auth/GOOGLE">구글 로그인</a> -->
</div>

<!-- 회원 가입 모달  -->
<div class="modal fade" id="signUpModal" tabindex="-1" role="dialog"
	aria-labelledby="signUpModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header signUp-header">
				<h5 class="modal-title signUp-title" id="signUpModalLabel">회원가입</h5>
				<button type="button" class="close modal-cancel"
					data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body signUp-body">
				<form id="reg-form" name="reg-form" action="/signUp" method="POST">
					<label>
						<p class="label-txt">ID</p> 
						<input type="text" class="signUp-input" id="userid" name="userid" maxlength="20" placeholder="&#8251; 아이디  6 ~ 20자를 입력하세요." value="userid1">
						<div class="line-box">
							<div class="line"></div>
						</div>
						<div class="idChk-text-box">
							<span class="idChk-text"></span>
						</div>
					</label>  
					<label>
						<p class="label-txt">PASSWORD</p> 
						<input type="password" class="signUp-input" autocomplete="off" id="userpw" name="userpw" maxlength="24" placeholder="&#8251; 비밀번호  8 ~ 24자를 입력하세요." value="12341234">
						<div class="line-box">
							<div class="line"></div>
						</div>
					</label> 
					<label>
						<p class="label-txt">PASSWORD CHECK</p> 
						<input type="password" class="signUp-input" autocomplete="off" id="userpwChk" maxlength="24" placeholder="&#8251; 비밀번호를  확인해주세요." value="12341234"> 
						<div class="line-box">
							<div class="line"></div>
						</div>
					</label> 
					<label>
						<p class="label-txt">NAME</p> 
						<input type="text" class="signUp-input" id="username" name="username" value="윤정현">
						<div class="line-box">
							<div class="line"></div>
						</div>
					</label>
					
					<label>
						<p class="label-txt">DATE OF BIRTH </p> 
						<input type="text" class="signUp-input" id="strBirth" name="strBirth" placeholder="&#8251; 생년월일  8자리를  '-' 없이 입력하세요." value="19940216">
						<div class="line-box">
							<div class="line"></div>
						</div>
					</label>
					<label>
						<p class="label-txt">GENDER</p> 
						<div class="reg-radio" >
					
							<input type="radio" value="male"  id="male" name="gender" checked="checked">
							<label for="male">남성</label>
					
							<input type="radio" value="female" id="female" name="gender">
							<label for="female">여성</label>
						</div>
					</label>
					
					
					
					<label>
						<p class="label-txt">E-mail</p> 
						<input type="text" class="signUp-input email-input" id="email" name="email" value="yjh_zzzz@naver.com">
						<div class="line-box email-line-box">
							<div class="line"></div>
							<input type="button" class="email-check" value="e-mail 인증">
						</div>
						<div class="reg-input-group">
							
							<div class="email-check-timer">
								<span class="time"></span>
							</div>
							<input type="hidden" name="loginsort" value="SP">
							<input type="text" class="signUp-input email-check-input" id="email-check-input">
							<input type="button" class="email-check-btn" id="email-check-btn" value="확인">
							
							
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
<script src="/resources/js/sign.js"></script>


