<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="businesstype.BusinessTypeDAO"%>
<%@ page import="businesstype.BusinessTypeDTO"%>
<%@ page import="field.FieldDAO"%>
<%@ page import="field.FieldDTO"%>
<%@ page import="placebusiness.PlaceBusinessDAO"%>
<%@ page import="placebusiness.PlaceBusinessDTO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String companyCode = request.getParameter("companyCode");

	ArrayList<PlaceBusinessDTO> placeList = new PlaceBusinessDAO().getPlaceList(companyCode);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="serchFieldLabel">부문검색</h4>
	</div>
	<div class="modal-body">
		<table class="table table-striped table-bordered table-hover">
			<thead>
				<tr>
					<th>선택</th>
					<th>사업장 코드</th>
					<th>사업장명</th>
					<th>대표자</th>
					<th>업태</th>
					<th>종목</th>
				</tr>
			</thead>
			<tbody>
				<%
					if (placeList != null) {
						for (int i = 0; i < placeList.size(); i++) {
							PlaceBusinessDTO place = placeList.get(i);
							BusinessTypeDTO businessConType = new BusinessTypeDAO()
									.getBusinessType(place.getBusinessCondition(), place.getBusinessType());
							String chiefName = new UserDAO().findUserName(place.getChiefID());
				%>
				<tr class="odd gradeX">
					<td class="center"><input type="radio" name="selectPlace" value="<%=place.getPlaceCode()%>"></td>
					<td class="center"><%=place.getPlaceCode()%></td>
					<td class="center"><%=place.getCompanyName()%></td>
					<td class="center"><%=chiefName%></td>
					<td class="center"><%=businessConType.getBusinessConditionName()%></td>
					<td class="center"><%=businessConType.getBusinessTypeName()%></td>
				</tr>
				<%
					}
					} else {
				%>
				<tr class="odd gradeX">
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		<button type="button" class="btn btn-primary" data-dismiss="modal"
			onclick="insertPlaceCode();">확인</button>
	</div>
</body>
</html>