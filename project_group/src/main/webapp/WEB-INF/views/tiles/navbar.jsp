<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<nav class="navbar navbar-expand-lg navbar-dark">
	<div class="container">
		
			<div class="col-3">
				<div class="user-profile" data-toggle="modal" data-target="#user-profile-modal">
					<img src="${gui.thumnail_img }"/>
				</div>
			</div>
			<div class="col-6">
				<div class="brand-name">
					<h6>STUDYPLANNER</h6>
				</div>
			</div>
			<div class="col-3">
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
					<div class="profile-img img-edit-btn">
						<img class="user_img" src="${gui.profile_img }">
					</div>
				<div class="profile-usertitle">
                	<div class="profile-usertitle-name"> 
                	${gui.username } 
                		<span class="badge badge-light"><i class="fas fa-pencil-alt"></i></span>
                	</div>
				</div>
            	<div class="profile-userbuttons">
					<button type="button" class="btn btn-info  btn-sm" data-toggle="collapse" href="#user-info-form" role="button" aria-expanded="false" aria-controls="user-info-form">
						내 정보</button>
					<button type="button" class="btn btn-info  btn-sm" data-toggle="collapse" href="#" role="button" aria-expanded="false" aria-controls="user-pw-form">
						비밀번호 변경</button>
					<button type="button" class="btn btn-info  btn-sm">로그아웃</button>
            	</div>
				
			</div>
			<div class="collapse mt-2" id="user-info-form">
  				<form>
  					<div class="form-group row">
						<label for="inputEmail3" class="col-sm-3 col-form-label">Email</label>
						<div class="col-sm-9">
							${gui.email}
						</div>
					</div>
					<div class="form-group row">
						<label for="inputPassword3" class="col-sm-3 col-form-label">전화번호</label>
						<div class="col-sm-9">
							 
						</div>
					</div>
					<div class="form-group row">
						
						<label for="inputPassword3" class="col-sm-3 col-form-label">생일</label>
						<div class="col-sm-9">
							 ${gui.birth } 
						</div>
					</div>
					<div class="form-group row submitBtnGroup">
						<button class="btn btn-primary" type="submit">변경사항 저장</button>	
					</div>
				</form>
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
			$(".right-menu-side").css("width","70%");
			$(".right-menu-side").addClass("open");
		
		}else{
			
			$(".right-menu-side").css("right","0");
			$(".right-menu-side").css("width","0");
			$(".right-menu-side").removeClass("open");
		}
		
	})
	
	$(".img-edit-btn").on("click",function(){
		
		
		
		
	})
	
	
	
</script>