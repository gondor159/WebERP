<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String companyCode = request.getParameter("companyCode");
	String departmentCode = request.getParameter("departmentCode");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
	function searchChargeEmployee() {
		var companyCode = $('#paramCompanyCodeToSCEC').val();
		var select = document.getElementById("employeeSearchDivision");
		var division = select.options[select.selectedIndex].value;
		var input = $('#chargeEmployeeSearchInput').val();
		$.ajax({
			type : 'POST',
			url : './employeeFindToModalServlet',
			data : {
				companyCode : companyCode,
				division : division,
				input : input
			},
			success : function(data) {
				if(data == "") {
					$('#tableChargeEmployeeResult').empty();
					$('#tableChargeEmployeeResult').append('');
				} else {
					var parsed = JSON.parse(data);
					var result = parsed.result;
					$('#tableChargeEmployeeResult').empty();
					$('#tableChargeEmployeeResult').append('<h3>검색결과</h3><table class="table table-striped table-bordered table-hover">' +
							'<thead><tr><td><i class="fa fa-check-square-o"></i></td>' + 
							'<td>사원번호</td><td>사원이름</td><td>부문</td><td>부서</td></tr></thead><tbody id="tBodyChargeEmployeeResult">');
					for(var i = 0; i < result.length; i++) {
						tBodyChargeEmployeeResult(result[i][0].value, result[i][1].value, result[i][2].value, result[i][3].value);
					}
					$('#tableChargeEmployeeResult').append('</tbody></table>');
				}
			}
		});
	}
	function tBodyChargeEmployeeResult(employeeNum, employeeName, fieldName, deptName) {
		$('#tBodyChargeEmployeeResult').append('<tr><td><input type="radio" name="selectEmployeeToSearch" value="' + employeeNum + '"></td>' +
				'<td>' + employeeNum + '</td>' +
				'<td>' + employeeName + '</td>' +
				'<td>' + fieldName + '</td>' +
				'<td>' + deptName + '</td></tr>');
	}
</script>
</head>
<body>
	<input type="hidden" id="paramCompanyCodeToSCEC" value="<%= companyCode %>">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="searchChargeEmployeeCodeLabel">사원 검색</h4>
	</div>
	<div class="modal-body">
		<div class="panel panel-default">
			<div class="row" style="margin-top: 10px; margin-bottom: 10px;">
				<div class="col-md-4">
					<select id="employeeSearchDivision"
						style="width: 85%; height: 34px; float: right;">
						<option value="chargeEmployeeName">사원명</option>
						<option value="chargeEmployeeCode">사원번호</option>
					</select>
				</div>
				<div class="col-md-5">
					<input id="chargeEmployeeSearchInput" type="text"
						style="width: 100%; height: 34px;">
				</div>
				<div class="col-md-1">
					<button class="btn btn-default" type="button"
						onclick="searchChargeEmployee();">
						<i class="fa fa-search-plus "></i>
					</button>
				</div>
				<div class="col-md-2"></div>
			</div>
			<div id="tableChargeEmployeeResult"></div>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		<button type="button" class="btn btn-primary"
			onclick="" data-dismiss="modal">확인</button>
	</div>
</body>
</html>