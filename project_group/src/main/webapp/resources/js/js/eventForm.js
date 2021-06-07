$(document).ready(function(){
	var formInputs = $('input[type="text"],#pmemo');
	var pmemoIcon = $(".note-pad-icon");

	formInputs.focus(function() {
       $(this).parent().children('p.formLabel').addClass('formTop');
       $(this).next().addClass("icon-color");
       $('div#formWrapper').addClass('darken-bg');
       $('div.logo').addClass('logo-active');
	});
	formInputs.focusout(function() {
		if ($.trim($(this).val()).length == 0){
		$(this).parent().children('p.formLabel').removeClass('formTop');
		 $(this).next().removeClass("icon-color");
		}
		
		$('div#formWrapper').removeClass('darken-bg');
		$('div.logo').removeClass('logo-active');
	});
	$('p.formLabel').click(function(){
		 $(this).parent().children('.form-style').focus();
	});
	
	pmemoIcon.on("click", function(){
	
		if($(".pmemo-box").hasClass("memoBox-show")){
		
			$(".ptitle-box").css("margin-bottom","1rem");
			$(".note-pad-icon").removeClass("icon-color");
			$(".pmemo-box").removeClass("memoBox-show");
		}else{
			
			
			$(".ptitle-box").css("margin-bottom","2rem");
			$(".note-pad-icon").addClass("icon-color");
			$(".pmemo-box").addClass("memoBox-show");
		}
	
	});
	 
	$(".radio-label").on("change",function(){
	
	
		if($(this).attr("id") == "allDay-btn-left"){
		
			$(this).addClass("allDay-btn-chk");	
			$(".day-box").css("width","100%");
			$(".time-box").css("display","none");

			if($("#allDay-btn-right").hasClass("allDay-btn-chk")){
				$("#allDay-btn-right").removeClass("allDay-btn-chk");	
			}
			
				
		}
		if($(this).attr("id") == "allDay-btn-right"){
			if($("#allDay-btn-left").hasClass("allDay-btn-chk")){
				$("#allDay-btn-left").removeClass("allDay-btn-chk");	
			}
			
			$(this).addClass("allDay-btn-chk");	
			$(".day-box").css("width","unset");
			$(".time-box").css("display","flex");
				
				
				
		}
	})
	
	$(".color-radio").each(function(){
		
			if($(this).is(":checked")){
				$(this).parent().css("border" , "3px inset #bbb");
			}else{
			
				$(this).parent().css("border" , "unset");
			}
	})
	
	$(".color-radio").on("change",function(){
		
		
		$(".color-radio").each(function(){
		
			if($(this).is(":checked")){
				$(this).parent().css("border" , "3px inset #bbb");
			}else{
			
				$(this).parent().css("border" , "unset");
			}
		})
		
	})
});