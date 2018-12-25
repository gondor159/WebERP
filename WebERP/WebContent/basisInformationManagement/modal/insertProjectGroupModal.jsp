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
	function insertPGFunction() {
		var companyCode = $('#paramCompanyCodeToIPG').val();
		var projectGroup = $('#projectGroupIPG').val();
		var groupName = $('#groupNameIPG').val();
		var startDate = $('#startDateIPG').val();
		var endDate = $('#endDateIPG').val();
		var note = $('#noteIPG').val();
		$.ajax({
			type : 'POST',
			url : './projectGroupRegistServlet',
			data : {
				companyCode : companyCode,
				projectGroup : projectGroup,
				groupName : groupName,
				startDate : startDate,
				endDate : endDate,
				note : note
			},
			success : function(result) {
				if(result == 0) {
					// 분류 코드와 분류 이름이 모두 입력이 안됨
					alert(companyCode + ',' + projectGroup + ',' + groupName);
				} else if(result == 1) {
					// 등록 완료
					alert('등록이 완료되었습니다.');
					location.reload();
					modal.close();
				} else {
					// 데이터베이스 오류
					alert('데이터베이스 오류가 발생했습니다.');
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
		<h4 class="modal-title" id="insertProjectGroupLabel">프로젝트 분류 등록</h4>
	</div>
	<div class="modal-body">
		<div class="panel panel-default">
			<input type="hidden" id="paramCompanyCodeToIPG" value="<%= companyCode %>">
			<table class="table table-striped">
				<tr>
					<td><h5>* 코드</h5></td>
					<td><input class="form-control" type="text" id="projectGroupIPG"></td>
					<td><h5>* 이름</h5></td>
					<td><input class="form-control" type="text" id="groupNameIPG"></td>
				</tr>
				<tr>
					<td><h5>시작일</h5></td>
					<td><input class="form-control" type="date" id="startDateIPG" placeholder="YYYY-MM-DD"></td>
					<td><h5>종료일</h5></td>
					<td><input class="form-control" type="date" id="endDateIPG" placeholder="YYYY-MM-DD"></td>
				</tr>
				<tr>
					<td colspan="4"><h5>비고</h5><textarea class="form-control" id="noteIPG"></textarea></td>
				</tr>
			</table>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		<button type="button" class="btn btn-primary"
			onclick="insertPGFunction();">등록</button>
	</div>
</body>
</html>