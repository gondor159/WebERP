<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
	function searchCustomCompany() {
		var select = document.getElementById("companySearchDivision");
		var division = select.options[select.selectedIndex].value;
		var input = $('#companySearchInput').val();
		$.ajax({
			type : 'POST',
			url : './companyFindForCustomServlet',
			data : {
				division : division,
				input : input
			},
			success : function(data) {
				if(data == "") {
					$('#tableCompanyResult').empty();
					$('#tableCompanyResult').append('');
				} else {
					var parsed = JSON.parse(data);
					var result = parsed.result;
					$('#tableCompanyResult').empty();
					$('#tableCompanyResult').append('<h3> 검색 결과</h3><table class="table table-striped table-bordered table-hover">' + 
					'<thead><tr><td><i class="fa fa-check-square-o"></i></td>' + 
					'<td>회사이름</td><td>회사코드</td><td>대표명</td><td>업태</td><td>업종</td></tr></thead><tbody id="tBodyCompanyResult">');
					for(var i = 0; i < result.length; i++) {
						tBodyCompanyResult(result[i][0].value, result[i][1].value, result[i][2].value, result[i][3].value, result[i][4].value);
					}
					$('#tableCompanyResult').append('</tbody></table>');
				}
			}
		});
	}
	function tBodyCompanyResult(companyName, companyCode, chief, condition, type) {
		$('#tBodyCompanyResult').append('<tr><td><input type="radio" name="selectCompanyForCustom" value="' + companyCode + '"></td>' +
				'<td>' + companyName + '</td>' +
				'<td>' + companyCode + '</td>' +
				'<td>' + chief + '</td>' +
				'<td>' + condition + '</td>' +
				'<td>' + type + '</td></tr>');
	}
</script>
</head>
<body>
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="searchCustomLabel">등록회사 검색</h4>
	</div>
	<div class="modal-body">
		<div class="panel panel-default">
			<div class="row" style="margin-top: 10px; margin-bottom: 10px;">
				<div class="col-md-4">
					<select id="companySearchDivision" style="width: 85%; height: 34px; float: right;">
						<option value="companyName">회사명</option>
						<option value="companyCode">회사코드</option>
						<option value="businessLicenseNum">사업자등록번호</option>
					</select>
				</div>
				<div class="col-md-5">
					<input id="companySearchInput" type="text" style="width: 100%; height: 34px;">
				</div>
				<div class="col-md-1">
					<button class="btn btn-default" type="button" onclick="searchCustomCompany();">
						<i class="fa fa-search-plus "></i>
					</button>
				</div>
				<div class="col-md-2"></div>
			</div>
			<div id="tableCompanyResult"></div>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		<button type="button" class="btn btn-primary" onclick="selectCompanyToCustom();"
			data-dismiss="modal">확인</button>
	</div>
</body>
</html>