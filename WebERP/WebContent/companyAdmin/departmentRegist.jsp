<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="businesstype.BusinessTypeDAO"%>
<%@ page import="businesstype.BusinessTypeDTO"%>
<%@ page import="placebusiness.PlaceBusinessDAO"%>
<%@ page import="placebusiness.PlaceBusinessDTO"%>
<%@ page import="field.FieldDAO"%>
<%@ page import="field.FieldDTO"%>
<%@ page import="department.DepartmentDAO"%>
<%@ page import="department.DepartmentDTO"%>
<%@ page import="company.CompanyDAO"%>
<%@ page import="company.CompanyDTO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.')");
		script.println("location.href = '../login.jsp'");
		script.println("</script>");
		return;
	}
	CompanyDTO companyCont = new CompanyDAO().getCompanyToID(userID);
	ArrayList<PlaceBusinessDTO> placeList = new PlaceBusinessDAO().getPlaceList(companyCont.getCompanyCode());
	ArrayList<DepartmentDTO> departmentList = new DepartmentDAO()
			.getDepartmentList(companyCont.getCompanyCode());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>회사 정보 등록</title>

<!-- Modal table CSS -->
<link href="../css/table.css" rel="stylesheet">

<!-- Bootstrap Core CSS -->
<link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="../vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!-- DataTables CSS -->
<link href="../vendor/datatables-plugins/dataTables.bootstrap.css"
	rel="stylesheet">

<!-- DataTables Responsive CSS -->
<link href="../vendor/datatables-responsive/dataTables.responsive.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="../dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="../vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

<!-- jQuery -->
<script type="text/javascript" src="//code.jquery.com/jquery-3.3.1.js"
	charset="UTF-8"></script>
<script>
	/* 사업장 이름 불러오기 function */
	function insertPlaceCode1() {
		var placeCode = $('input[name="selectPlace1"]:checked').val();
		var companyCode = encodeURIComponent('<%=companyCont.getCompanyCode()%>');
		$.ajax({
			type : 'POST',
			url : './placeBusinessGetNameServlet',
			data : {
				companyCode : companyCode,
				placeCode : placeCode
			},
			success : function(result) {
				$('#companyName1').attr('value', result);
				$('#placeCode1').attr('value', placeCode);
			}
		});
	}
	function insertPlaceCode2() {
		var placeCode = $('input[name="selectPlace2"]:checked').val();
		var companyCode = encodeURIComponent('<%=companyCont.getCompanyCode()%>');
		$.ajax({
			type : 'POST',
			url : './placeBusinessGetNameServlet',
			data : {
				companyCode : companyCode,
				placeCode : placeCode
			},
			success : function(result) {
				$('#companyName2').attr('value', result);
				$('#placeCode2').attr('value', placeCode);
			}
		});
	}
	/* 부서명 불러오기 function */
	function insertFieldCode() {
		var fieldCode = $('input[name="selectField"]:checked').val();
		var placeCode = $('input[name="selectPlace1"]:checked').val();
		var companyCode = encodeURIComponent('<%=companyCont.getCompanyCode()%>');
		$.ajax({
			type : 'POST',
			url : './fieldGetNameServlet',
			data : {
				companyCode : companyCode,
				placeCode : placeCode,
				fieldCode : fieldCode
			},
			success : function(result) {
				$('#fieldName').attr('value', result);
				$('#fieldCode').attr('value', fieldCode);
			}
		});
	}
</script>
<script>
$(function(){
	var companyCode = encodeURIComponent('<%=companyCont.getCompanyCode()%>');
		$("#serchFieldButton").click(
				function() {
					$('#serchField').modal(
							{
								remote : 'fieldListModal.jsp?companyCode='
										+ companyCode + '&placeCode='
										+ $('#placeCode1').val()
							});
				})
	});
</script>
</head>
<body>
	<!-- Navigation -->
	<nav class="navbar navbar-default navbar-static-top" role="navigation"
		style="margin-bottom: 0">
		<%@include file="../main/headNav.jsp"%>
		<!-- /.navbar-top-links -->

		<%@include file="../main/sideNav.jsp" %>
		<!-- /.navbar-static-side -->
	</nav>
	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-6">
				<h1 class="page-header">등록부서</h1>
			</div>
			<div class="col-lg-6">
				<h1 class="page-header">부서/부문 등록</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<div class="row">
			<div class="col-lg-6">
				<div class="panel panel-default">
					<div class="panel-heading">등록된 부서를 확인 할 수 있습니다.</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<table width="100%"
							class="table table-striped table-bordered table-hover"
							id="dataTables-example">
							<thead>
								<tr>
									<th>부문코드</th>
									<th>부문명</th>
									<th>부서코드</th>
									<th>부서명</th>
								</tr>
							</thead>
							<tbody>
								<%
									if (departmentList != null) {
										for (int i = 0; i < departmentList.size(); i++) {
											DepartmentDTO department = departmentList.get(i);
											String fieldName = new FieldDAO().getFieldName(department.getCompanyCode(),
													department.getFieldCode());
								%>
								<tr class="odd gradeX">
									<td class="center"><%=department.getFieldCode()%></td>
									<td class="center"><%=fieldName%></td>
									<td class="center"><%=department.getDepartmentCode()%></td>
									<td class="center"><%=department.getDepartmentName()%></td>
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
								</tr>
								<%
									}
								%>
							</tbody>
						</table>
						<!-- /.table-responsive -->
					</div>
					<!-- /.panel-body -->
				</div>
				<!-- /.panel -->
			</div>
			<div class="col-lg-6">
				<div class="panel panel-default">
					<div class="panel-heading">부문을 먼저 등록 하고 부서를 등록해야 합니다.</div>
					<div class="panel-body">
						<ul class="nav nav-tabs">
        					<li class="active"><a href="#departmentTab" data-toggle="tab">부서등록</a>
        					</li>
        					<li><a href="#fieldTab" data-toggle="tab">부문등록</a>
        					</li>
        				</ul>
        				<div class="tab-content">
							<div class="tab-pane fade in active" id="departmentTab">
								<form role="form" method="POST" action="./departmentRegistServlet">
									<input type="hidden" name="companyCode" value="<%=companyCont.getCompanyCode()%>">
									<table class="table table-striped">
										<tr>
											<td style="text-align: right;">부문코드</td>
											<td><input id="fieldCode" type="text" name="fieldCode" readonly></td>
											<td><button class="btn btn-default" id="serchFieldButton" type="button"><i class="fa fa-search-plus"></i></button></td>
											<td><input id="fieldName" type="text" name="fieldName" readonly></td>
										</tr>
										<tr>
											<td style="text-align: right;">부서코드</td>
											<td colspan="2"><input type="text" name="departmentCode"></td>
											<td></td>
										</tr>
										<tr>
											<td style="text-align: right;">부서명</td>
											<td colspan="2"><input type="text" name="departmentName"></td>
											<td></td>
										</tr>
									</table>
									<button class="btn btn-outline btn-primary btn-lg btn-block" type="submit">등록</button>
								</form>
							</div>
							<div class="tab-pane fade in" id="fieldTab">
								<form role="form" method="POST" action="./fieldRegistServlet">
									<input type="hidden" name="companyCode" value="<%=companyCont.getCompanyCode()%>">
									<table class="table table-striped">
										<tr>
											<td style="text-align: right;">부서코드</td>
											<td colspan="2"><input type="text" name="fieldCode"></td>
											<td></td>
										</tr>
										<tr>
											<td style="text-align: right;">부서명</td>
											<td colspan="2"><input type="text" name="fieldName"></td>
											<td></td>
										</tr>
									</table>
									<button class="btn btn-outline btn-primary btn-lg btn-block" type="submit">등록</button>
								</form>
							</div>
						</div>
						<!-- /.row (nested) -->
					</div>
					<!-- /.panel-body -->
				</div>
				<!-- /.panel -->
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
	</div>
	<!-- Modal -->
	<!-- 부서 등록 사업장 검색 -->
	<div class="modal fade" id="searchPlace1" tabindex="-1" role="dialog"
		aria-labelledby="searchPlaceLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="searchPlaceLabel">Modal title</h4>
				</div>
				<div class="modal-body">
					<table class="table table-striped table-bordered table-hover">
						<%
							if (placeList != null) {
								for (int i = 0; i < placeList.size(); i++) {
									PlaceBusinessDTO place = placeList.get(i);
									BusinessTypeDTO businessConType = new BusinessTypeDAO()
											.getBusinessType(place.getBusinessCondition(), place.getBusinessType());
									String chiefName = new UserDAO().findUserName(place.getChiefID());
						%>
						<tr>
							<td class="center"><input type="radio" name="selectPlace1"
								value="<%=place.getPlaceCode()%>"></td>
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
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal"
						onclick="insertPlaceCode1();">확인</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 부문 검색 -->
	<div class="modal fade" id="serchField" tabindex="-1" role="dialog"
		aria-labelledby="serchFieldLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content"></div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 부문 등록 사업장 검색 -->
	<div class="modal fade" id="searchPlace2" tabindex="-1" role="dialog"
		aria-labelledby="searchPlaceLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="searchPlaceLabel">Modal title</h4>
				</div>
				<div class="modal-body">
					<table class="table table-striped table-bordered table-hover">
						<%
							if (placeList != null) {
								for (int i = 0; i < placeList.size(); i++) {
									PlaceBusinessDTO place = placeList.get(i);
									BusinessTypeDTO businessConType = new BusinessTypeDAO()
											.getBusinessType(place.getBusinessCondition(), place.getBusinessType());
									String chiefName = new UserDAO().findUserName(place.getChiefID());
						%>
						<tr>
							<td class="center"><input type="radio" name="selectPlace2"
								value="<%=place.getPlaceCode()%>"></td>
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
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal"
						onclick="insertPlaceCode2();">확인</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- jQuery -->
	<script src="../vendor/jquery/jquery.min.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="../vendor/bootstrap/js/bootstrap.min.js"></script>

	<!-- Metis Menu Plugin JavaScript -->
	<script src="../vendor/metisMenu/metisMenu.min.js"></script>

	<!-- DataTables JavaScript -->
	<script src="../vendor/datatables/js/jquery.dataTables.min.js"></script>
	<script src="../vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
	<script src="../vendor/datatables-responsive/dataTables.responsive.js"></script>

	<!-- Custom Theme JavaScript -->
	<script src="../dist/js/sb-admin-2.js"></script>

	<!-- Page-Level Demo Scripts - Tables - Use for reference -->
	<script>
		$(document).ready(function() {
			$('#dataTables-example').DataTable({
				responsive : true
			});
		});
	</script>
	<!-- Page-Level Demo Scripts - Notifications - Use for reference -->
	<script>
		// tooltip demo
		$('.tooltip-demo').tooltip({
			selector : "[data-toggle=tooltip]",
			container : "body"
		})
		// popover demo
		$("[data-toggle=popover]").popover()
	</script>
</body>
</html>