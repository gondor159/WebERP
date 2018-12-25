<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="department.DepartmentDAO"%>
<%@ page import="department.DepartmentDTO"%>
<%@ page import="field.FieldDAO"%>
<%@ page import="field.FieldDTO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String companyCode = request.getParameter("companyCode");
	
	ArrayList<FieldDTO> fieldList = new FieldDAO().getFieldList(companyCode);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
/* 부문 불러오기 function */
function findFieldList() {
	var companyCode = $('#companyCode').val();
	$.ajax({
		type : 'POST',
		url : './fieldGetListServlet',
		data : {
			companyCode : companyCode
		},
		success : function(data) {
			if(data == '') {
				$('#fieldTable').empty();
				$('#fieldTable').append('');
			} else {
				var parsed = JSON.parse(data);
				var result = parsed.result;
				$('#fieldTable').empty();
				$('#fieldTable').append('<h5>부문선택</h5><table class="table table-striped table-bordered table-hover">' + 
						'<thead><tr><td>선택</td><td>부문코드</td><td>부문명</td></tr></thead><tbody id="fieldTbody">');
				for(var i = 0; i < result.length; i++) {
					viewDept(result[i][0].value, result[i][1].value);
				}
				$('#fieldTable').append('</tbody></table>');
			}
		}
	});
}
function viewDept(fieldCodeSel, fieldNameSel) {
	$('#fieldTbody').append('<tr><td><input type="radio" name="selectFieldCode" value="' + fieldCodeSel + '"></td><td>' + fieldCodeSel + '</td><td>' + fieldNameSel + '</td></tr>');
}
/* 부서 불러오기 */
function findDeptList() {
	var companyCode = $('#companyCode').val();
	var fieldCode = $('input[name="selectFieldCode"]:checked').val();
	$.ajax({
		type : 'POST',
		url : './departmentGetListServlet',
		data : {
			companyCode : companyCode,
			fieldCode : fieldCode
		},
		success : function(data) {
			if(data == '') {
				$('#departmentTable').empty();
				$('#footer').empty();
				$('#departmentTable').append('');
			} else {
				var parsed = JSON.parse(data);
				var result = parsed.result;
				$('#departmentTable').empty();
				$('#footer').empty();
				$('#departmentTable').append('<h5>부서선택</h5><table class="table table-striped table-bordered table-hover">' + 
						'<thead><tr><td>선택</td><td>부서코드</td><td>부서명</td></tr></thead><tbody id="departmentTbody">');
				for(var i = 0; i < result.length; i++) {
					viewField(result[i][0].value, result[i][1].value);
				}
				$('#departmentTable').append('</tbody></table>');
				$('#footer').append('<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>' +
						'<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="insertFieldCode();">확인</button>');
			}
		}
	});
}
function viewField(departmentCodeSel, departmentNameSel) {
	$('#departmentTbody').append('<tr><td><input type="radio" name="selectDepartment" value="' + departmentCodeSel + '"></td><td>' + departmentCodeSel + '</td><td>' + departmentNameSel + '</td></tr>')
}
</script>
<script>
	findFieldList();
</script>
</head>
<body>
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="serchFieldLabel">부문 부서 검색</h4>
	</div>
	<div class="modal-body">
		<input type="hidden" id="companyCode" value="<%= companyCode %>">
		<div id="fieldTable"></div>
		<button class="btn btn-default" type="button" onclick="findDeptList();">선택</button>
		<div id="departmentTable"></div>
	</div>
	<div class="modal-footer" id="footer">
		
	</div>
</body>
</html>