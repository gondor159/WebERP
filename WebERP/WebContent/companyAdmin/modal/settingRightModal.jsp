<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="rights.RightsDAO"%>
<%@ page import="rights.RightsDTO"%>
<%
	request.setCharacterEncoding("UTF-8");
	String companyCode = request.getParameter("companyCode");
	String settingID = request.getParameter("settingID");

	ArrayList<RightsDTO> rightList = new RightsDAO().getRightsList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
function registRight() {
	var companyCode = $('#settingCompanyCode').val();
	var userID = $('#settingUserID').val();
	$("input[name='rights']:checked").each(function(i){   //jQuery로 for문 돌면서 check 된값 배열에 담는다
		$.ajaxSettings.traditional = true;
		$.ajax({
			type : 'POST',
			url : './rightsRegistServlet',
			data : {
				companyCode : companyCode,
				userID : userID,
				right : $(this).val()
			},
			success : function(result) {
				if(result == 0 || result == -1) {
					alert('권한등록에 실패 하였습니다.');
					return;
				}
			}
		});
	});
	alert('권한등록에 성공 하였습니다.');
}
</script>
</head>
<body>
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="settingRightLabel">권한 설정</h4>
	</div>
	<div class="modal-body">
		<input type="hidden" id="settingCompanyCode" value="<%= companyCode %>">
		<input type="hidden" id="settingUserID" value="<%= settingID %>">
		<table width="100%"
			class="table table-striped table-bordered table-hover"
			id="dataTables-example">
			<thead>
				<tr>
					<th>선택</th>
					<th>권한명</th>
				</tr>
			</thead>
			<tbody>
				<%
				
					for (int i = 0; i < rightList.size(); i++) {
						RightsDTO right = rightList.get(i);
				%>
				<tr class="odd gradeX">
					<td><input type="checkbox" name="rights" value="<%= right.getRightsCode() %>"></td>
					<td><%= right.getRightsName() %></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
		<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="registRight();">등록</button>
	</div>
</body>
</html>