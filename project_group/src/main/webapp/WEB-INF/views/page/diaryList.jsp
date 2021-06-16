<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<div class="container diary-container">
	<div id="planner_${gui.usercode}" class="diary">
		<div class="diary-list">
			<div class="diary-list-nav">
				<div class="col-10 d-list-head-title">제목</div>
				<div class="col-1 d-insert-icon"><a href="/diaryWrite"><i class="fas fa-pen"></i></a></div>
				<div class="col-1 d-update-icon"><i class="fas fa-wrench"></i></div>
			</div>
			<c:forEach  items="${dList}" var="list">
				<div class="diary-row">
				<a  class="diary-collapse-btn col-8" data-toggle="collapse" href="#diaryCollapse-${list.dnum }" role="button" aria-expanded="false" aria-controls="diaryCollapse-${list.dnum }">
					<div class="d-list-title ">
						<c:if test="${list.dtitle eq null }"> 
						- 제목 없음
						</c:if>
						${list.dtitle}
					</div>
				</a>
					<c:set var="writeDaySplit" value="${fn:split(list.writeDay,' ')}"/>
					<div class="d-list-writeDay col-4">
						<c:forEach items="${writeDaySplit}" var="writeDay" varStatus="w">
							<c:if test="${w.count == 1 }">
								${writeDay }
							</c:if>
						</c:forEach>
					</div>
				</div>	
				<div class="collapse" id="diaryCollapse-${list.dnum }" name="diaryContents-collapse">
					<div class="card card-body diary-contents-box">
						<c:if test="${list.dcontents eq null }"> 
						- 내용 없음
						</c:if>
						
						<pre>${list.dcontents}</pre>
					</div>
				</div>
			</c:forEach>
			<p>
 

		</div>
	</div>
</div> 

<script>

	$(".diary-row").on("click", function(){
		
		$('div[name=diaryContents-collapse]').each(function() {

			if ($(this).hasClass('show')) {

				$(this).collapse('toggle');
			};
		})
		
	})
	
	$(".d-update-icon").on("click",function(){
		
		if(!$(".diary-collapse-btn").hasClass("diary-edit-add")){
			$(".diary-collapse-btn").removeClass("col-8");
			$(".diary-collapse-btn").addClass("col-6");
			$(".diary-collapse-btn").addClass("diary-edit-add");
			$(".diary-row").append("<div class='diary-update-btn col-1'><i class='far fa-edit'></i></div><div class='diary-delete-btn col-1'><i class='far fa-trash-alt'></i></div>")
		}else{
			
			$(".diary-collapse-btn").removeClass("col-6");
			$(".diary-collapse-btn").removeClass("diary-edit-add");
			$(".diary-collapse-btn").addClass("col-8");
			$(".diary-update-btn").remove();
			$(".diary-delete-btn").remove();
		}
		
	})
</script>
