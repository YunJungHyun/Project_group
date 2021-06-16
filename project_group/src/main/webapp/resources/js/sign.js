


history.pushState(null, null, "http://localhost:8081/YooNPlanner")
var referrer = document.referrer;

if( referrer == "http://localhost:8081/plannerHome"){
	window.onpopstate=function(event){
		history.go(-2);
	};
}



var timer = null;
var isRunning = false;

$(document).ready(function(){
	 	// 정규식
	  var idRegExp = /^[a-zA-z0-9]{6,20}$/; //아이디 유효성 검사
	  var nameRegExp=  /^[가-힣]+$/; //이름 유효성 검사 > 한글만 입력
	  //var nickNameRegExp=  /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]{2,6}$/; //닉네임 유효성 검사
	  var regExp = /^[0-9]*$/; //숫자로만 구성되어있는지
	  //var phnRegExp = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;// 휴대전화 유효성검사
	  var pwChk =false;
	  var idChk =false;
	  var emailChk= false;
	  var emailRegExp = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	 
	  $('.signUp-input').focus(function(){
	    $(this).parent().find(".label-txt").addClass('label-active');
	  });

	  $(".signUp-input").focusout(function(){
	    if ($(this).val() == '') {
	      $(this).parent().find(".label-txt").removeClass('label-active');
	    };
	  });
	   
	  $("#userid").blur(function(){
		  
		  var inputId = $("#userid").val().trim();
		  
		  if(inputId == ""){
			 
			  $(".idChk-text-box").css("display","none");
			  idChk =false;
		  }
		  else{
			  
			 
			 if(!idRegExp.test(inputId)){
				alert("아이디는 공백없이 영문 대소문자와 숫자 6~20자리로 입력해야합니다!");
				$("#userid").val("");
				$("#userid").focus();
				
				return false;
			 }
			 
		 	 $.ajax({
			  
				 url: "/idCheck",
			 	 type: "POST",
			 	 data : {
				  
					  "userid" : inputId
			 
				  },success:function(data){
				  
					 if(data == "fail"){
						 $(".idChk-text-box").css("display","block");
						 $(".idChk-text-box").css("color","red");
						 $(".idChk-text").text("※ 중복된 아이디입니다.");
						 idChk =false;
					 }
					 else if(data =="success"){
					 
						 $(".idChk-text-box").css("display","block");
						 $(".idChk-text-box").css("color","blue");
						 $(".idChk-text").text("※ 사용 가능한 아이디입니다.");
						 idChk =true;
					 }
				  
				  }
			  })
		  }
	  })
	  
	  $("#userpw").blur(function(){
		  var userpw = $("#userpw").val().trim();
		  
		  
		  if(userpw != ""){
			  
			  
			  if(userpw.length < 8 || userpw.length > 24){
				  
				  alert("비밀번호는 공백없이  8~24자리로 입력해야합니다!");
					$("#userpw").val("");
					$("#userpw").focus();
					return false;
			  }else if(userpw.search(/\s/) != -1){
				 	 alert("비밀번호는 공백 없이 입력해주세요.");
				 	 $("#userpw").val(""); 
				 	 $("#userpw").focus();
					 return false;
				}
		  }else if($("#userpw").val().search(/\s/) != -1){
			  
			     alert("비밀번호는 공백 없이 입력해주세요.");
			 	 $("#userpw").val(""); 
			 	 $("#userpw").focus();
				 return false;
			  
		  }
		  
	  })
	  
	   $("#userpwChk").blur(function(){
		 
		  var userpw = $("#userpw").val().trim();
		  var userpwChk = $("#userpwChk").val().trim();
		  
		  if(userpw != "" && userpwChk !=""){
			  
			  if (userpw != userpwChk){
				  
				  alert("입력하신 비밀번호가 다릅니다.");
				  $("#userpwChk").val("");
				  $("#userpwChk").focus(); 
				  return false;
			  }else{
				  
				  pwChk = true;
				  
				  //alert(pwChk);
			  }
		  }
		  
	  })
	  
	  $("#username").blur(function(){
		  
		  var username = $("#username").val().trim();
		  
		  
		  if(username !=""){
			  
			  if(!nameRegExp.test(username)){
				  
				    alert("이름은 공백없이 한글로 입력해야합니다.");
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
	 
	   
	   $("#email").blur(function(){
		   
		   var email = $("#email").val().trim();
		   
		   
		   if(email != ""){
			   
			   if(!emailRegExp.test(email)){
				   
				   alert("이메일을 형식에맞게 정확히 입력해주세요.           ex) study_2020@gmail.com");
				   $("#email").val("");
				   $("#email").focus();
				   return false
			   }
		   }
	   })
	  
	  
	  $("#reg-form-submit").on("click", function(){
		  
		  
		 	if($("#userid").val().trim() ==""){
		 		alert("사용하실 회원 아이디를 입력해주세요.");
		 		$("#userid").focus();
		 		return false;
		 	}
		 	if($("#userpw").val().trim() ==""){
		 		alert("사용하실 비밀번호를 입력해주세요.");
		 		$("#userpw").focus();
		 		return false;
		 	}
		 	if($("#userpwChk").val().trim() ==""){
		 		alert("사용하실 비밀번호를 확인해주세요.");
		 		$("#userpwChk").focus();
		 		return false;
		 	}
		 	if($("#username").val().trim() ==""){
		 		alert("회원님의 이름을 입력해주세요.");
		 		$("#username").focus();
		 		return false;
		 	}
		 	if($("#strBirth").val().trim() ==""){
		 		alert("회원님의 생년월일을 입력해주세요.");
		 		$("#strBirth").focus();
		 		return false;
		 	}
		 	
		 	
		 	if($("#email").val().trim() ==""){
		 		alert("사용하시는 이메일을 입력해주세요.");
		 		$("#email").focus();
		 		return false;
		 	}
		 	if(!$("input:radio[name='gender']").is(':checked')){
		 		
		 		alert("성별을 선택해주세요.");
		 		return false;
		 	}
		 	
		 	
		 	if(idChk == true && pwChk == true && emailChk ==true){
		 		
		 		//alert("hi");
		 		var queryString = $("form[name=reg-form]").serialize() ;
				
				
		 	}else if(idChk == false){
		 		
		 		alert("아이디가 중복 되었습니다.");
		 		$("#userid").focus();
		 		return false;
		 		
		 	}else if(pwChk == false){
		 		
		 		alert("비밀번호를 확인해주세요.");
		 		$("#userpw").focus();
		 		return false;
		 				 		
		 	}else if(emailChk == false){
		 		
		 		alert("이메일 인증 확인 버튼을 눌러주세요.");
		 		$("#email").focus();
		 		return false;
		 		
		 	}
	  })
		
	
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
			    	
			    	sessionStorage.setItem("emailChkNum",data);
			    	
			    	//삭제 할것
			    	$("#email-check-input").val(data);
			    	
			    	
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
	  
		
	  
	  $("#email-check-btn").on("click",function(){
		  
		  var emailChkNum =$("#email-check-input").val();
		  
		  if(emailChkNum == ""){
			  
			  alert("인증 키 번호를 입력해주세요.");
			  $(this).focus();
			  return false;
		  }else{
			  
			 
			  if(emailChkNum == sessionStorage.getItem("emailChkNum")){
				  
				  alert("이메일 인증 되었습니다.");
				  emailChk =true;
			  }else{
				  
				  alert("인증 키 번호를 정확히 입력해주세요.");
				  emailChk = false;
			  }
		  }
	  })
	  
	  $("#signIn-btn").on("click",function(){
		  
		  
		  if($("#signIn-userid").val()==""){
			  
			  alert("아이디를 입력해주세요.");
				
			  $("#signIn-userid").focus();
			  return false;
		  }
		  
		  if($("#signIn-userpw").val()==""){
		  
			alert("비밀번호를 입력해주세요.");  
			$("#signIn-userpw").focus();
			return false;
		  }
		  
	  	
		  

	  		var queryString = $("form[name=signIn-form]").serialize();
	  		
	  		login(queryString);
	  		
	  		
	  		return false;
	
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



function login(queryString){
	
	$.ajax({ 
		
		url : "/signin/SP",
		type : "GET",
		data : queryString, 
		success : function(data){
			
			switch (data) { 
				case "idChkFail" :
					alert("존재하지 않는 아이디입니다.");
					$("#signIn-userid").focus();
					break;
					
				case "pwChkFail" :
					alert("비밀번호가 잘못되었습니다.");
					$("#signIn-userpw").focus();
					break;
					
				case "loginSuccess" :
					alert("로그인 되었습니다.");
					window.location.href="/plannerHome";
					break;
			}			
				
		
		},error : function(error){
			
			alert("에러");
		}
		
	})
}

