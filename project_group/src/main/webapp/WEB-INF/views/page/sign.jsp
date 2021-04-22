<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="simple-login-container">
	
    <h2>STUDY PLANNER</h2>
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
            <a href="/login?with=this" class="btn btn-block btn-login">  
            	로그인
            </a>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 form-group" data-toggle="modal" data-target="#signUpModal"> 
             <input type="button" class="btn btn-block btn-signUp" value="회원 가입">
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12 form-group"> 
            <a href="/login?with=kakao" >
             	<img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="300"/>
            </a> 
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 form-group"> 
            <a href="/login?with=google">
             	<img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="300"/>
            </a> 
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
						<p class="label-txt">ID</p> 
						<input type="text" class="signUp-input">
						<div class="line-box">
							<div class="line"></div>
						</div>
					</label> 
					<label>
						<p class="label-txt">PASSWORD</p> 
						<input type="text" class="signUp-input">
						<div class="line-box">
							<div class="line"></div>
						</div>
					</label> 
					<label>
						<p class="label-txt">NAME</p> 
						<input type="text" class="signUp-input">
						<div class="line-box">
							<div class="line"></div>
						</div>
					</label>
					<label>
						<p class="label-txt">GENDER</p> 
						<div class="reg-radio" >
					
						<input type="radio" value="male"  id="male" name="gender">
							<label for="male">남성</label>
					
						<input type="radio" value="female" id="female" name="gender">
							<label for="female">여성</label>
						</div>
					</label>
					
					<label>
						<p class="label-txt">PHONE NUMBER</p> 
						
						<input type="text" class="signUp-input">
						
						<div class="line-box ">
							<div class="line"></div>
							
						</div>
					
					</label>
					
					<label>
						<p class="label-txt">E-mail</p> 
						<input type="text" class="signUp-input email-input">
						<div class="line-box email-line-box">
							<div class="line"></div>
							<input type="button" class="email-check" value="e-mail 인증">
						</div>
						<div class="reg-input-group">
							<input type="text" class="signUp-input email-check-input">
							<div class="email-check-timer">
								<span class="time"></span>
							</div>
						</div>
					</label>
					
				</form>
			</div>
			<div class="modal-footer signUp-footer">
				<button type="submit" >가입 완료</button>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">

var timer = null;
var isRunning = false;

$(document).ready(function(){

	  $('.signUp-input').focus(function(){
	    $(this).parent().find(".label-txt").addClass('label-active');
	  });

	  $(".signUp-input").focusout(function(){
	    if ($(this).val() == '') {
	      $(this).parent().find(".label-txt").removeClass('label-active');
	    };
	  });
		
	  
	  $(".email-check").on("click",function(){
		  
		  var email = $(".email-input").val();
		  if ( email == ""){
			  
			  alert("이메일을 입력해주세요.");
			  return false;
		  }
		  else{
			  $(".reg-input-group").css("display","flex");
			  
			  $.ajax({
			  
				  url : "/emailCheck",
			  	data : {
					  "inputEmail" : email
				  
				  },success: function(data){
					
				  	alert("이메일 전송 성공");
		
					var display = $('.time');
			    	var leftSec = 600;
			    	// 남은 시간
			    	// 이미 타이머가 작동중이면 중지
			    	if (isRunning){
			    		clearInterval(timer);
			    		display.html("");
			    		startTimer(leftSec, display);
			    	}else{
			    		startTimer(leftSec, display);
			    		
			    	}
				  },beforeSend :function(){
					  
					  var width = 0;
		              var height = 0;
		              var left = 0;
		              var top = 0;

		              width = 200;
		              height = 200;


		              top = ( $(window).height() - height ) / 3 + $(window).scrollTop();
		              left = ( $(window).width() - width ) / 2 + $(window).scrollLeft();
						
		              
		              if($("#loading-img").length != 0) {
		                     $("#div_ajax_load_image").css({
		                            "top": top+"px",
		                            "left": left+"px"
		                     });
		                     $("#mask").show();
		                     $("#loading-img").show();
		              }else{
		            	  $("#mask").show();
		              	$('body').append('<div id="loading-img" style="position:absolute; top:'+ top + 'px; left:' + left + 'px; width:' + width + 'px; height:' + height + 'px; z-index:10001; background:rgba(240, 240, 240, 0); filter:alpha(opacity=50); opacity:alpha*0.5; margin:auto; padding:0; "> <img src="resources/gif/email-loading.gif" style="width:200px; height:200px;"></div>');

		              }
						
		       }, complete: function () { 
		    	   $("#mask").hide();
		    	   $("#loading-img").hide();

		       }
 
			  })
		  
		  }
	  })
	  
	
	});
	
 

function startTimer(count, display) {
            
    		var minutes, seconds;
            timer = setInterval(function () {
            minutes = parseInt(count / 60, 10);
            seconds = parseInt(count % 60, 10);
     
            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;
     
            display.html(minutes + ":" + seconds);
     
            // 타이머 끝
            if (--count < 0) {
    	     clearInterval(timer);
    	     alert("시간초과");
    	     display.html("시간초과");
    	     $('.btn_chk').attr("disabled","disabled");
    	     isRunning = false;
            }
        }, 1000);
             isRunning = true;
}


</script>

