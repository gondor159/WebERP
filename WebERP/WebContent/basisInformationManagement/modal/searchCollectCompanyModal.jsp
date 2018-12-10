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
	function searchCustom() {
		var companyCode = $('#paramCompanyCodeToSCCM').val();
		var select = document.getElementById("customSearchDivision");
		var division = select.options[select.selectedIndex].value;
		var input = $('#customSearchInput').val();
		$.ajax({
			type : 'POST',
			url : './customFindToModalServlet',
			data : {
				companyCode : companyCode,
				division : division,
				input : input
			},
			success : function(data) {
				if(data == "") {
					$('#tableCustomResult').empty();
					$('#tableCustomResult').append('');
				} else {
					var parsed = JSON.parse(data);
					var result = parsed.result;
					$('#tableCustomResult').empty();
					$('#tableCustomResult').append('<h3> 검색 결과</h3><table class="table table-striped table-bordered table-hover">' + 
					'<thead><tr><td><i class="fa fa-check-square-o"></i></td>' + 
					'<td>거래처이름</td><td>거래처코드</td><td>대표명</td><td>업태</td><td>업종</td></tr></thead><tbody id="tBodyCustomResult">');
					for(var i = 0; i < result.length; i++) {
						tBodyCompanyResult(result[i][0].value, result[i][1].value, result[i][2].value, result[i][3].value, result[i][4].value);
					}
					$('#tableCustomResult').append('</tbody></table>');
				}
			}
		});
	}
	function tBodyCompanyResult(customName, customCode, chief, condition, type) {
		$('#tBodyCustomResult').append('<tr><td><input type="radio" name="selectCustomToSearch" value="' + customCode + '"></td>' +
				'<td>' + customName + '</td>' +
				'<td>' + customCode + '</td>' +
				'<td>' + chief + '</td>' +
				'<td>' + condition + '</td>' +
				'<td>' + type + '</td></tr>');
	}
</script>
</head>
<body>
	<input type="hidden" id="paramCompanyCodeToSCCM" value="<%= companyCode %>">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="searchCollectCustomLabel">수금거래처 검색</h4>
	</div>
	<div class="modal-body">
		<div class="panel panel-default">
			<div class="row" style="margin-top: 10px; margin-bottom: 10px;">
				<div class="col-md-4">
					<select id="customSearchDivision" style="width: 85%; height: 34px; float: right;">
						<option value="searchCustomName">거래처명</option>
						<option value="searchCustomCode">거래처코드</option>
						<option value="searchCustomBusinessLicenseNum">사업자등록번호</option>
					</select>
				</div>
				<div class="col-md-5">
					<input id="customSearchInput" type="text" style="width: 100%; height: 34px;">
				</div>
				<div class="col-md-1">
					<button class="btn btn-default" type="button" onclick="searchCustom();">
						<i class="fa fa-search-plus "></i>
					</button>
				</div>
				<div class="col-md-2"></div>
			</div>
			<div id="tableCustomResult"></div>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		<button type="button" class="btn btn-primary"
			onclick="insertCollectCompanyFunction();" data-dismiss="modal">확인</button>
	</div>
</body>
</html>