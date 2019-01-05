<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String companyCode = request.getParameter("companyCode");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
	function registCGFunction() {
		var companyCode = $('#paramCompanyCodeToICG').val();
		var customGroup = $('#customGroupICG').val();
		var groupName = $('#groupNameICG').val();
		var startDate = $('#startDateICG').val();
		var endDate = $('#endDateICG').val();
		var note = $('#noteICG').val();
		$.ajax({
			type : 'POST',
			url : './customGroupRegistServlet',
			data : {
				companyCode : companyCode,
				customGroup : customGroup,
				groupName : groupName,
				startDate : startDate,
				endDate : endDate,
				note : note
			},
			success : function(result) {
				if(result == 0) {
					// 분류 코드와 분류 이름이 모두 입력이 안됨
					alert('분류코드와 분류이름은 필수입니다.');
					return;
				} else if(result == 1) {
					// 등록 완료
					alert('등록이 완료되었습니다.');
					location.reload();
					modal.close();
				} else {
					// 데이터베이스 오류
					alert('데이터베이스 오류가 발생했습니다.');
					return;
				}
			}
		});
	}
</script>
</head>
<body>
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="insertCustomGroupLabel">프로젝트 분류 등록</h4>
	</div>
	<div class="modal-body">
		<div class="panel panel-default">
			<input type="hidden" id="paramCompanyCodeToICG" value="<%= companyCode %>">
			<table class="table table-striped">
				<tr>
					<td><h5>* 코드</h5></td>
					<td><input class="form-control" type="text" id="customGroupICG"></td>
					<td><h5>* 이름</h5></td>
					<td><input class="form-control" type="text" id="groupNameICG"></td>
				</tr>
				<tr>
					<td><h5>시작일</h5></td>
					<td><input class="form-control" type="date" id="startDateICG" placeholder="YYYY-MM-DD"></td>
					<td><h5>종료일</h5></td>
					<td><input class="form-control" type="date" id="endDateICG" placeholder="YYYY-MM-DD"></td>
				</tr>
				<tr>
					<td colspan="4"><h5>비고</h5><textarea class="form-control" id="noteICG"></textarea></td>
				</tr>
			</table>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		<button type="button" class="btn btn-primary"
			onclick="registCGFunction();">등록</button>
	</div>
</body>
</html>