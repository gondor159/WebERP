<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="businesstype.BusinessTypeDAO" %>
<%@ page import="businesstype.BusinessTypeDTO" %>
<%@ page import="java.util.ArrayList" %>
<%
	ArrayList<String[]> businessConditionList = new BusinessTypeDAO().searchCondition();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
function printType() {
	var businessCondition = $('#conditionSelect').val();
	$.ajax({
		type : 'POST',
		url : './searchTypeServlet',
		data : {
			businessCondition : businessCondition
		},
		success : function(data) {
			if (data == "")
				return;
			var parsed = JSON.parse(data);
			var result = parsed.result;
			$('.businessTypeClass').empty();
			for (var i = 0; i < result.length; i++) {
				addTypeSelect(result[i][0].value, result[i][1].value);
			}
		}
	});
}
function addTypeSelect(businessType, businessTypeName) {
	$('#typeSelect').append(
			'<option class="businessTypeClass" value="' + businessType + '">'
					+ businessTypeName + '</option>');
}
</script>
</head>
<body>
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="searchTypeLabel">업태/종목 선택</h4>
	</div>
	<div class="modal-body">
		<div class="form-group">
			<label>업태</label>
			<select class="form-control" name="conditionSelect" id="conditionSelect">
				<%
					for (int i = 0; i < businessConditionList.size(); i++) {
				%>
				<option value="<%=businessConditionList.get(i)[0]%>"><%=businessConditionList.get(i)[1]%></option>
				<%
					}
				%>
			</select>
		</div>
		<div class="form-group float-right">
			<button type="button" class="btn btn-default" onclick="printType();">검색</button>
		</div>
		<div class="form-group">
			<label>종목</label> <select class="form-control" name="typeSelect"
				id="typeSelect">

			</select>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		<button type="button" class="btn btn-primary"
			onclick="insertConTypeFunction();" data-dismiss="modal">확인</button>
	</div>
</body>
</html>