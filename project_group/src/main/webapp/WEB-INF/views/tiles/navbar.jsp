<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<nav class="navbar navbar-expand-lg navbar-dark">
	<div class="container">
		 
			<div class="">
			
				<div class="user-profile" data-toggle="modal" data-target="#user-profile-modal">
					<img src="<c:if test="${gui.thumnail_img != null }">${gui.thumnail_img}</c:if>
							<c:if test="${gui.thumnail_img == null }">/resources/img/basic_profile.png</c:if>
					"/>
				</div> 
			</div>
			<div class="">
				<div class="brand-name">
					<h6>YOONPLANNER</h6>
				</div>
			</div>
			<div class="">
				<div class="right-menu-btn" >
					<img src="resources/icon/group.png"/>
				</div>
			</div>
		
	</div>
</nav>


<!-- 회원정보 모달  -->
<div class="modal fade" id="user-profile-modal" tabindex="-1" role="dialog"
	aria-labelledby="user-profile-modalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			
			<div class="modal-header user-profile-header">
				
				<button type="button" class="close modal-cancel"
					data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			 
			<div class="modal-body user-profile-body">
				<div class="profile-img-edit" >
					<div class="profile-img img-edit-btn" data-toggle="collapse" onclick="collapse()" data-target="#profileImg-collapse" role="button"  aria-controls="profileImg-collapse">
					<!--onclick="onclick=document.all.profileImgFile.click()"  -->
						<img id="profile_img_${gui.usercode}" class="user_img" src="<c:if test="${gui.profile_img != null }">${gui.profile_img}</c:if>
							<c:if test="${gui.profile_img == null }">/resources/img/basic_profile_big.png</c:if>
					">
					</div>
					
					<div class="collapse mt-3 profileImg-update-btn" name="profile-collapse-container" id="profileImg-collapse">
						<button onclick="document.getElementById('profileImgFile').click()">프로필 변경</button>
						<button onclick="profileBasicImg()" >기본이미지로 변경</button>

					</div>
					
					
					<form id="fileForm"  method="POST" enctype="multipart/form-data">
						<input type="file" id="profileImgFile" name="profileImgFile"  style="display:none"/> 
					</form>
					
					
					
					<div class="profile-usertitle">
                		<div class="profile-usertitle-name"> 
                		${gui.username } 
                			<span class="badge badge-light"><i class="fas fa-pencil-alt"></i></span>
                		</div>
					</div>
            		<div class="profile-userbuttons">
						<button type="button" class="btn btn-info btn-sm" data-toggle="collapse" onclick="collapse()" data-target="#profile-collapse" role="button"  aria-controls="profile-collapse">
							내 정보</button>
						<button type="button" class="btn btn-info  btn-sm" data-toggle="collapse" onclick="collapse()" data-target="#pw-collapse" role="button"  aria-controls="pw-collapse">
							비밀번호 변경</button>
						<button type="button" class="btn btn-info  btn-sm" onclick="logout()">로그아웃</button>
            		</div> 
				
			</div>
			
			<div class="collapse mt-2" name="profile-collapse-container" id="pw-collapse">
				<form class="pw-update-form" name="pw-update-form" id="pw-update-form" method="POST">
					
  					<div class="row profile-row">
  						<p class="col-sm-3 col-3 col-form-label label-pw">기존 비밀번호</p> 
  						<div class="col-sm-9 col-9">
  							
							<input type="password" class="profile-input" autocomplete="off" id="beforePw" name="beforePw">
							
							<div class="line-box profile-line">
								<div class="line"></div>
							</div>
							<div class=pwChk-text-box>
								<span class="pwChk-text"></span>
							</div>
						</div>
					</div> 
					<div class="row profile-row">
						<p class="col-sm-3 col-3 col-form-label label-pw">바꿀 비밀번호</p> 
						<div class="col-sm-9 col-9">
							<input type="password" class="profile-input" autocomplete="off" id="afterPw" name="afterPw">
							<div class="line-box profile-line">
								<div class="line"></div>
							</div>
						</div>
					</div>   
					
				</form>
				<div class="profile-update-btn-box">
					<button class="pw-update-btn" type="button" >비밀번호 저장</button> 
				</div>
			</div>
		
			<div class="collapse mt-2" name="profile-collapse-container" id="profile-collapse">
  				<form class="profile-update-form" name="profile-update-form" id="profile-update-form" method="POST">
  					
  					<div class="row profile-row">
  						<p class="col-sm-3 col-3 col-form-label">e-mail</p> 
  						<div class="col-sm-9 col-9">
  							
							<input type="text" class="profile-input" name="email" value="${gui.email }">
							
							<div class="line-box profile-line">
								<div class="line"></div>
							</div>
							
						</div>
					</div> 
					<div class="row profile-row">
						<p class="col-sm-3 col-3 col-form-label">전화번호</p> 
						<div class="col-sm-9 col-9">
							<input type="text" class="profile-input" name="uphn" value="${gui.uphn}">
							<div class="line-box profile-line">
								<div class="line"></div>
							</div>
						</div>
					</div>   
					<div class="row profile-row">
						<p class="col-sm-3 col-3 col-form-label">생일</p> 
						<div class="col-sm-9 col-9">
							<input type="text" class="profile-input"  name="birth" value="${gui.birth }" disabled="disabled">
							<div class="line-box profile-line">
								<div class="line"></div>
							</div>
						</div>
					</div>  
				</form>
				<div class="profile-update-btn-box">
					<button class="profile-update-btn" type="button">내 정보 저장</button> 
				</div>
			</div>
			
				<!-- <form class="info-update-form">
					<div class="row">
     				   <div class="col-md-12 form-group">
    			   	  		<input type="text" class="form-control"  name="nickname" placeholder="닉네임 ">
   					   </div>
  					</div>
				</form> -->
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

	
	
	$(".right-menu-btn").on("click",function(){
		
		if(!$(".right-menu-side").hasClass("open")){
			$(".right-menu-side").css("right","0");
			$(".right-menu-side").css("width","30%");
			$(".right-menu-side").addClass("open");
		
		}else{
			
			$(".right-menu-side").css("right","0");
			$(".right-menu-side").css("width","0");
			$(".right-menu-side").removeClass("open");
		}
		
	})

	
	$("#profileImgFile").on("change",function(){
		
		//alert("profileImgFile");
		
		var usercode = "${gui.usercode}";
		
		var output = document.createElement("button");
		if(this.files && this.files[0]){
			var reader = new FileReader;
			reader.onload = function(data){
				
				$("#profile_img_"+usercode).attr("src" , data.target.result).width("100%");
			}
			
			reader.readAsDataURL(this.files[0]);
			
			output.setAttribute("id","chgProfile_"+usercode);
			output.setAttribute("name","chgProfile_reg");
			output.setAttribute("class","chgProfile_reg");
			output.innerHTML= "저장";
			
			var parent = document.getElementById("profileImg-collapse");
			parent.appendChild(output);
		}
	})
	
	$(document).on("click", ".chgProfile_reg", function(){
		
	
				var formData = new FormData($("#fileForm")[0]);
				formData.append("basic","no");
				changeProfile(formData);

			})
	 function profileBasicImg(){
	
		var formData = new FormData($("#fileForm")[0]);
		formData.append("basic","yes");
		changeProfile(formData);
		
	}
	
	function changeProfile(formData){
		
		$.ajax({
			type : "POST",
			url : "/update/profileImg",
			data : formData,
			processData : false,
			contentType : false,
			success : function(data) {
				if (data == "success") {
					alert("프로필이 변경되었습니다.");
					window.location.reload();
				} else {
					alert("프로필 변경 실패하였습니다.");
				}
			},
			error : function(request, status, error) {
				alert("code : " + request.status + "\n" + "message : "
						+ request.responseText + "\n" + "error : "
						+ error);
			}
		});
	}
	
	function logout() {

		$.ajax({

			url : "/logout",
			success : function(data) {

				location.href = "/YooNPlanner";
			}
		})
	}

	function collapse() {

		$('div[name=profile-collapse-container]').each(function() {

			if ($(this).hasClass('show')) {

				$(this).collapse('toggle');
			}
			;
		})
	}

	$(".profile-update-btn").on("click", function() {

				/* 유효성 검사  */
				var usercode = "${gui.usercode}";
				var queryString = $("form[name=profile-update-form]")
						.serialize()
						+ "&usercode=" + usercode;

				//alert(queryString);

				$.ajax({

					url : "/update/profileUpdate",
					type : "POST",
					data : queryString,
					success : function(data) {
						if (data == "updateSuccess") {

							alert("회원 정보가 수정되었습니다.");
							window.location.reload();
						} else {

							alert("정보수정실패 ");
							window.location.reload();

						}

					},
					error : function() {
						alert("error");
					}

				})
			})

	$("#beforePw").blur(function() {

		var usercode = "${gui.usercode}";
		var beforePw = $("#beforePw").val();

		if (beforePw != "") {
			var queryString = "userpw=" + beforePw + "&usercode=" + usercode;

			$.ajax({

				url : "/update/beforePwChk",
				type : "POST",
				data : queryString,
				success : function(data) {

					if (data == "beforePwSuccess") {
						$(".pwChk-text-box").css("display", "block");
						$(".pwChk-text-box").css("color", "green");
						$(".pwChk-text").text("※ 비밀번호 확인 되었습니다.");
						$("#beforePw").addClass("pwChkOkay");

					} else {
						$(".pwChk-text-box").css("display", "block");
						$(".pwChk-text-box").css("color", "red");
						$(".pwChk-text").text("※ 비밀번호를 정확히 입력해주세요.");

						if ($("#beforePw").hasClass("pwChkOkay")) {

							$("#beforePw").removeClass("pwChkOkay");
						}

					}
				},
				error : function() {
					alert("error");
				}

			})
		} else {

			if ($("#beforePw").hasClass("pwChkOkay")) {
				$(".pwChk-text-box").css("display", "none");
				$("#beforePw").removeClass("pwChkOkay");
			}

		}

	})

	$(".pw-update-btn").on("click", function() {

		/* 유효성 검사  */
		var usercode = "${gui.usercode}";
		var afterPw = $("#afterPw").val();
		var queryString = "userpw=" + afterPw + "&usercode=" + usercode;

		var pwChk = $("#beforePw").hasClass("pwChkOkay");

		if (!pwChk) {

			alert("기존 사용하던 비밀번호를 확인해주세요.");
			$("#beforePw").focus();
			return false;
		}

		if (afterPw == "") {
			alert("변경하실 비밀번호를 입력하세요.");
			$("#afterPw").focus();
			return false;
		}

		if (afterPw != "" && pwChk) {

			$.ajax({

				url : "/update/pwUpdate",
				type : "POST",
				data : queryString,
				success : function(data) {
					if (data == "updateSuccess") {

						alert("비밀번호가 수정되었습니다.");
						window.location.reload();
					} else {

						alert("정보수정실패 ");
						window.location.reload();

					}

				},
				error : function() {
					alert("error");
				}

			})

		}
	})
</script>