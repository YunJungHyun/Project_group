<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<div class="simple-login-container">
    <h2>YOON STUDY</h2>
    <div class="row">
        <div class="col-md-12 form-group">
            <input type="text" class="form-control" placeholder="아이디 ">
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 form-group"> 
            <input type="password" placeholder="패스워드" class="form-control">
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 form-group">
            <input type="submit" class="btn btn-block btn-login" value="로그인">
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 form-group" data-toggle="modal" data-target="#signUpModal"> 
             <input type="button" class="btn btn-block btn-signUp" value="회원 가입">
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12 form-group"> 
             <input type="button" class="btn btn-block btn-signUp" value="카카오 로그인">
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 form-group"> 
             <input type="button" class="btn btn-block btn-signUp" value="구글 로그인">
        </div>
    </div>
    
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
				<form>
					<label>
						<p class="label-txt">ENTER YOUR EMAIL</p> 
						<input type="text" class="signUp-input">
						<div class="line-box">
							<div class="line"></div>
						</div>
					</label> <label>
						<p class="label-txt">ENTER YOUR NAME</p> <input type="text"
						class="signUp-input">
						<div class="line-box">
							<div class="line"></div>
						</div>
					</label> <label>
						<p class="label-txt">ENTER YOUR PASSWORD</p> 
						<input type="text" class="signUp-input">
						<div class="line-box">
							<div class="line"></div>
						</div>
					</label>
					
				</form>
			</div>
			<div class="modal-footer signUp-footer">
				<button type="submit">가입 완료</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	
	
$(document).ready(function(){

	  $('.signUp-input').focus(function(){
	    $(this).parent().find(".label-txt").addClass('label-active');
	  });

	  $(".signUp-input").focusout(function(){
	    if ($(this).val() == '') {
	      $(this).parent().find(".label-txt").removeClass('label-active');
	    };
	  });

	});

</script>

