<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="company.CompanyDAO"%>
<%@ page import="company.CompanyDTO"%>
<%@ page import="customer.CustomerDAO"%>
<%@ page import="customer.CustomerDTO"%>
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
	ArrayList<CustomerDTO> customerList = new CustomerDAO().getCustomerListToCompanyCode(companyCont.getCompanyCode());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>기초정보관리 - 일반거래처등록</title>

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
<script type="text/javascript" src="//code.jquery.com/jquery-3.3.1.js" charset="UTF-8"></script>

<!-- function -->
<script>
/* 거래처 수정 */
function editCustom() {
	var companyCode  = encodeURIComponent('<%=companyCont.getCompanyCode()%>');
	var checked = $('input[name="selectCustom"]:checked').val();
	location.href = "generalCustomerEdit.jsp?companyCode=" + compnayCode + "&customcode=" + checked;
}
/* 회사 복사 */
function selectCompanyToCustom() {
	var checked = $('input[name="selectCompanyForCustom"]:checked').val();
	$.ajax({
		type : 'POST',
		url : './findCompanyToCompanyCodeServlet',
		data : {
			companyCode : checked
		},
		success : function(data) {
			if(data == "") return;
			var parsed = JSON.parse(data);
			var result = parsed.result;
			$('#customerName').attr('value', result[0].value);
			$('#businessLicenseNum').attr('value', result[1].value);
			$('#chiefName').attr('value', result[2].value);
			$('#postNum').attr('value', result[3].value);
			$('#address').attr('value', result[4].value);
			$('#tel').attr('value', result[5].value);
			$('#fax').attr('value', result[6].value);
			$('#businessCondition').attr('value', result[7].value);
			$('#businessConditionName').attr('value', result[8].value);
			$('#businessType').attr('value', result[9].value);
			$('#businessTypeName').attr('value', result[10].value);
			$('#homepage').attr('value', result[11].value);
		}
	});
}
/* 주소 등록 */
function insertAddFunction() {
	var entry_postcode5 = $('#nomal_postcode5').val();
	var entry_address = $('#nomal_address').val();
	var entry_details = $('#nomal_extra_info').val();
	var entry_extra_info = $('#nomal_details').val();
	$('#postNum').attr('value', entry_postcode5);
	$('#address').attr('value',
			entry_address + entry_extra_info + " " + entry_details);
}
/* 업태 종목 등록 */
function insertConTypeFunction() {
	var conditionSelect = $('#conditionSelect').val();
	var typeSelecet = $('#typeSelect').val();
	$.ajax({
		type : 'POST',
		url : './businessTypeGetNameServlet',
		data : {
			businessCondition : conditionSelect,
			businessType : typeSelecet
		},
		success : function(data) {
			if(data == "") return;
			var parsed = JSON.parse(data);
			var result = parsed.result;
			$('#businessConditionName').attr('value', result[0].value);
			$('#businessTypeName').attr('value', result[1].value);
		}
	});
	$('#businessCondition').attr('value', conditionSelect);
	$('#businessType').attr('value', typeSelecet);
}
/* 수금거래처 등록 */
function insertCollectCompanyFunction() {
	var companyCode = encodeURIComponent('<%=companyCont.getCompanyCode()%>');
	var checked = $('input[name="selectCustomToSearch"]:checked').val();
	$.ajax({
		type : 'POST',
		url : './customerGetNameServlet',
		data : {
			companyCode : companyCode,
			customCode : checked
		},
		success : function(data) {
			if(data == "") return;
			var parsed = JSON.parse(data);
			var result = parsed.result;
			$('#collectCompanyName').attr('value', result[0].value);
		}
	});
	$('#collectCompany').attr('value', checked);
}
/* 금융기관 등록 */
function insertFIFunction() {
	var checked = $('input[name="fiCode"]:checked').val();
	$.ajax({
		type : 'POST',
		url : './financialInstitutionFindToCodeServlet',
		data : {
			financialInstitutionCode : checked
		},
		success : function(data) {
			if(data == "") return;
			var parsed = JSON.parse(data);
			var result = parsed.result;
			$('#financialInstitutionCode').attr('value', checked);
			$('#financialInstitutionName').attr('value', result[0].value);
		}
	});
}
/* 담당 부서 등록 */
function insertCDCFunction() {
	var companyCode = encodeURIComponent('<%=companyCont.getCompanyCode()%>');
	var checked = $('input[name="deptCode"]:checked').val();
	$.ajax({
		type : 'POST',
		url : './departmentGetNameOnlyServlet',
		data : {
			companyCode : companyCode,
			departmentCode : checked
		},
		success : function(result) {
			$('#chargeDeptCode').attr('value', checked);
			$('#chargeDeptName').attr('value', result);
		}
	});
}
/* 수신처 주소 등록 */
function insertCollectAddFunction() {
	var receive_postcode5 = $('#receive_postcode5').val();
	var receive_address = $('#receive_address').val();
	var receive_details = $('#receive_details').val();
	var receive_extra_info = $('#receive_extra_info').val();
	$('#receivePostNum').attr('value', receive_postcode5);
	$('#receiveAddress').attr('value',
			receive_address + receive_details + " " + receive_extra_info);
}
</script>

<!-- Button 활성화 -->
<script>
$(function(){
	var companyCode = encodeURIComponent('<%=companyCont.getCompanyCode()%>');
	/* 거래처 검색 버튼 */
	$("#searchCustomBtn").click(function(){
		$('#searchCustom').modal({
			remote : 'searchCustomModal.jsp'
		});
	})
	/* 거래처 주소 검색 버튼 */
	$("#searchAddressBtn").click(function(){
		$('#searchAddress').modal({
			remote : 'searchAddressModal.jsp'
		});
	})
	/* 업태/종목 검색 버튼 */
	$("#searchTypeBtn").click(function(){
		$('#searchType').modal({
			remote : 'searchTypeModal.jsp'
		});
	})
	/* 프로젝트 검색 버튼 */
	$("#searchProjectBtn").click(function(){
		$('#searchProject').modal({
			remote : 'searchProjectModal.jsp?companyCode=' + companyCode
		});
	})
	/* 거래처 그룹 검색 버튼 */
	$("#searchCustomGroupBtn").click(function(){
		$('#searchCustomGroup').modal({
			remote : 'searchCustomGroupModal.jsp?companyCode=' + companyCode
		});
	})
	/* 거래처 등급 검색 버튼 */
	$("#searchCustomGradeBtn").click(function(){
		$('#searchCustomGrade').modal({
			remote : 'searchCustomGradeModal.jsp?companyCode=' + companyCode
		});
	})
	/* 수금 거래처 검색 버튼 */
	$("#searchCollectCompanyBtn").click(function(){
		$('#searchCollectCompany').modal({
			remote : 'searchCollectCompanyModal.jsp?companyCode=' + companyCode
		});
	})
	/* 금융기관 검색 버튼 */
	$("#searchFinancialInstitutionBtn").click(function(){
		$('#searchFinancialInstitution').modal({
			remote : 'searchFinancialInstitutionModal.jsp'
		});
	})
	/* 은행코드 검색 버튼 */
	$("#searchAccountCodeBtn").click(function(){
		$('#searchAccountCode').modal({
			remote : 'searchAccountCodeModal.jsp?companyCode=' + companyCode
		});
	})
	/* 부서검색 버튼 */
	$("#searchChargeDeptCodeBtn").click(function(){
		$('#searchChargeDeptCode').modal({
			remote : 'searchChargeDeptCodeModal.jsp?companyCode=' + companyCode
		});
	})
	/* 직급 검색 버튼 */
	$("#searchPositionCodeBtn").click(function(){
		$('#searchPositionCode').modal({
			remote : 'searchPositionCodeModal.jsp'
		});
	})
	/* 사원 검색 버튼 */
	$("#searchChargeEmployeeCodeBtn").click(function(){
		$('#searchChargeEmployeeCode').modal({
			remote : 'searchChargeEmployeeCodeModal.jsp?companyCode=' + companyCode + '&departmentCode=' + $('#chargeDeptCode').val()
		});
	})
	/* 수신처 주소검색 버튼 */
	$("#serchReceiveAddressBtn").click(function(){
		$('#serchReceiveAddress').modal({
			remote : 'searchReceiveAddressModal.jsp'
		});
	})
});
</script>
<!-- jQuery -->
<script type="text/javascript" src="//code.jquery.com/jquery-3.3.1.js" charset="UTF-8"></script>
</head>
<body>
	<!-- Navigation -->
	<nav class="navbar navbar-default navbar-static-top" role="navigation"
		style="margin-bottom: 0">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.html">SB Admin v2.0</a>
		</div>
		<!-- /.navbar-header -->

		<ul class="nav navbar-top-links navbar-right">
			<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#"> <i class="fa fa-envelope fa-fw"></i>
					<i class="fa fa-caret-down"></i>
			</a>
				<ul class="dropdown-menu dropdown-messages">
					<li><a href="#">
							<div>
								<strong>John Smith</strong> <span class="pull-right text-muted">
									<em>Yesterday</em>
								</span>
							</div>
							<div>Lorem ipsum dolor sit amet, consectetur adipiscing
								elit. Pellentesque eleifend...</div>
					</a></li>
					<li class="divider"></li>
					<li><a href="#">
							<div>
								<strong>John Smith</strong> <span class="pull-right text-muted">
									<em>Yesterday</em>
								</span>
							</div>
							<div>Lorem ipsum dolor sit amet, consectetur adipiscing
								elit. Pellentesque eleifend...</div>
					</a></li>
					<li class="divider"></li>
					<li><a href="#">
							<div>
								<strong>John Smith</strong> <span class="pull-right text-muted">
									<em>Yesterday</em>
								</span>
							</div>
							<div>Lorem ipsum dolor sit amet, consectetur adipiscing
								elit. Pellentesque eleifend...</div>
					</a></li>
					<li class="divider"></li>
					<li><a class="text-center" href="#"> <strong>Read
								All Messages</strong> <i class="fa fa-angle-right"></i>
					</a></li>
				</ul> <!-- /.dropdown-messages --></li>
			<!-- /.dropdown -->
			<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#"> <i class="fa fa-tasks fa-fw"></i>
					<i class="fa fa-caret-down"></i>
			</a>
				<ul class="dropdown-menu dropdown-tasks">
					<li><a href="#">
							<div>
								<p>
									<strong>Task 1</strong> <span class="pull-right text-muted">40%
										Complete</span>
								</p>
								<div class="progress progress-striped active">
									<div class="progress-bar progress-bar-success"
										role="progressbar" aria-valuenow="40" aria-valuemin="0"
										aria-valuemax="100" style="width: 40%">
										<span class="sr-only">40% Complete (success)</span>
									</div>
								</div>
							</div>
					</a></li>
					<li class="divider"></li>
					<li><a href="#">
							<div>
								<p>
									<strong>Task 2</strong> <span class="pull-right text-muted">20%
										Complete</span>
								</p>
								<div class="progress progress-striped active">
									<div class="progress-bar progress-bar-info" role="progressbar"
										aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"
										style="width: 20%">
										<span class="sr-only">20% Complete</span>
									</div>
								</div>
							</div>
					</a></li>
					<li class="divider"></li>
					<li><a href="#">
							<div>
								<p>
									<strong>Task 3</strong> <span class="pull-right text-muted">60%
										Complete</span>
								</p>
								<div class="progress progress-striped active">
									<div class="progress-bar progress-bar-warning"
										role="progressbar" aria-valuenow="60" aria-valuemin="0"
										aria-valuemax="100" style="width: 60%">
										<span class="sr-only">60% Complete (warning)</span>
									</div>
								</div>
							</div>
					</a></li>
					<li class="divider"></li>
					<li><a href="#">
							<div>
								<p>
									<strong>Task 4</strong> <span class="pull-right text-muted">80%
										Complete</span>
								</p>
								<div class="progress progress-striped active">
									<div class="progress-bar progress-bar-danger"
										role="progressbar" aria-valuenow="80" aria-valuemin="0"
										aria-valuemax="100" style="width: 80%">
										<span class="sr-only">80% Complete (danger)</span>
									</div>
								</div>
							</div>
					</a></li>
					<li class="divider"></li>
					<li><a class="text-center" href="#"> <strong>See
								All Tasks</strong> <i class="fa fa-angle-right"></i>
					</a></li>
				</ul> <!-- /.dropdown-tasks --></li>
			<!-- /.dropdown -->
			<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#"> <i class="fa fa-bell fa-fw"></i>
					<i class="fa fa-caret-down"></i>
			</a>
				<ul class="dropdown-menu dropdown-alerts">
					<li><a href="#">
							<div>
								<i class="fa fa-comment fa-fw"></i> New Comment <span
									class="pull-right text-muted small">4 minutes ago</span>
							</div>
					</a></li>
					<li class="divider"></li>
					<li><a href="#">
							<div>
								<i class="fa fa-twitter fa-fw"></i> 3 New Followers <span
									class="pull-right text-muted small">12 minutes ago</span>
							</div>
					</a></li>
					<li class="divider"></li>
					<li><a href="#">
							<div>
								<i class="fa fa-envelope fa-fw"></i> Message Sent <span
									class="pull-right text-muted small">4 minutes ago</span>
							</div>
					</a></li>
					<li class="divider"></li>
					<li><a href="#">
							<div>
								<i class="fa fa-tasks fa-fw"></i> New Task <span
									class="pull-right text-muted small">4 minutes ago</span>
							</div>
					</a></li>
					<li class="divider"></li>
					<li><a href="#">
							<div>
								<i class="fa fa-upload fa-fw"></i> Server Rebooted <span
									class="pull-right text-muted small">4 minutes ago</span>
							</div>
					</a></li>
					<li class="divider"></li>
					<li><a class="text-center" href="#"> <strong>See
								All Alerts</strong> <i class="fa fa-angle-right"></i>
					</a></li>
				</ul> <!-- /.dropdown-alerts --></li>
			<!-- /.dropdown -->
			<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#"> <i class="fa fa-user fa-fw"></i>
					<i class="fa fa-caret-down"></i>
			</a>
				<ul class="dropdown-menu dropdown-user">
					<li><a href="#"><i class="fa fa-user fa-fw"></i> User
							Profile</a></li>
					<li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a>
					</li>
					<li class="divider"></li>
					<li><a href="login.html"><i class="fa fa-sign-out fa-fw"></i>
							Logout</a></li>
				</ul> <!-- /.dropdown-user --></li>
			<!-- /.dropdown -->
		</ul>
		<!-- /.navbar-top-links -->

		<%@include file="../main/sideNav.jsp" %>
		<!-- /.navbar-static-side -->
	</nav>
	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">일반거래처등록</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<div class="row">
			<div class="col-lg-5">
				<div class="panel panel-default">
					<div class="panel-heading">등록된 거래처를 확인 할 수 있습니다.</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<table width="100%"
							class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th><i class="fa fa-check-square-o"></i></th>
									<th>코드</th>
									<th>거래처명</th>
									<th>구분</th>
								</tr>
							</thead>
							<tbody>
								<%
									if(customerList != null) {
										for(int i = 0; i < customerList.size(); i++) {
											CustomerDTO customer = customerList.get(i);
								%>
								<tr>
									<td><input type="radio" name="selecCustom"
								value="<%= customer.getCustomCode() %>"></td>
									<td><%= customer.getCustomCode() %></td>
									<td><%= customer.getCustomerName() %></td>
									<td><%= customer.getDivision() %></td>
								</tr>
								<%
										}
									}
								%>
							</tbody>
						</table>
						<div style="float: right;">
							<button class="btn btn-outline btn-primary" type="button" onclick="editCustom();">수정</button>
							<button class="btn btn-outline btn-danger" type="button">삭제</button>
						</div>
						<!-- /.table-responsive -->
					</div>
					<!-- /.panel-body -->
				</div>
				<!-- /.panel -->
			</div>
			<!-- /.col-lg-6 -->
			<div class="col-lg-7">
				<div class="panel panel-default">
					<div class="panel-heading">거래처 정보를 확인합니다.</div>
					<!-- /.panel-heading -->
					<form class="panel-body" method="POST" action="./customRegistServlet"> <!-- 이부분에 if 를 써서 파라미터 값이 없으면 등록 있으면 수정 -->
						<input type="hidden" value="<%= companyCont.getCompanyCode() %>" name="companyCode">
						<div class="row">
                            <div class="col-md-6" style="text-align: right"><h5>시스템에 등록된 회사를 조회합니다.</h5></div>
                            <div class="col-md-6"><button class="btn btn-default float-right" id="searchCustomBtn" type="button">회사 검색</button></div>
                        </div>
                        <br>
                        <ul class="nav nav-tabs">
                        	<li class="active"><a href="#baseSession" data-toggle="tab">기본등록사항</a>
                            </li>
                            <li><a href="#tradeSession" data-toggle="tab">거래등록사항</a>
                            </li>
                            <li><a href="#alphaSession" data-toggle="tab">추가등록사항</a>
                            </li>
                        </ul>
                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div class="tab-pane fade in active" id="baseSession">
                            	<br>
                            	<table class="table table-striped">
                            		<tr>
                            			<td style="text-align: right;">*거래처 코드</td>
                            			<td><input type="text" name="customCode"></td>
                            			<td style="text-align: right;">*구분</td>
                            			<td>
                            				<select style="width: 70%; height: 25px;" name="division">
                                            	<option value="nomal">일반</option>
                                            	<option value="trade">무역</option>
                                            	<option value="regident">주민</option>
                                            	<option value="etc">기타</option>
                                        	</select>
                                        </td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">*거래처 이름</td>
                            			<td colspan="3"><input id="customerName" type="text" name="customerName"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">*사업자 등록번호</td>
                            			<td colspan="3"><input id="businessLicenseNum" type="text" name="businessLicenseNum"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">대표자 이름</td>
                            			<td colspan="3"><input id="chiefName" type="text" name="chiefName"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">우편번호</td>
                            			<td><input type="text" maxlength="5" name="postNum" id="postNum"></td>
                            			<td colspan="2"><button class="btn btn-default" id="searchAddressBtn" type="button"><i class="fa fa-search-plus"></i></button></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">주소</td>
                            			<td colspan="3"><input type="text" style="width: 85%" name="address" id="address"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">전화번호</td>
                            			<td colspan="3"><input id="tel" type="text" name="tel"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">팩스번호</td>
                            			<td colspan="3"><input id="fax" type="text" name="fax"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">업태</td>
                            			<td><input id="businessCondition" type="text" name="businessCondition" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchTypeBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input id="businessConditionName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">종목</td>
                            			<td><input id="businessType" type="text" name="businessType" readonly></td>
                            			<td style="text-align: left;"></td>
                            			<td><input id="businessTypeName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">홈페이지</td>
                            			<td colspan="3"><input id="homepage" type="url" style="width: 85%;" name="homepage" placeholder="https://~ or http://~"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">환종</td>
                            			<td colspan="3">
                            				<select style="width: 30%; height: 25px;" name="monetaryUnit">
												<option value="KRW">￦ KRW</option>
												<option value="USD">$ USD</option>
												<option value="JPY">￥ JPY</option>
												<option value="CNY">元 CNY</option>
												<option value="EUR">€ EUR</option>
											</select>
                            			</td>
                            		</tr>
                            	</table>
                            	<hr>
                            	<table class="table table-striped">
                            		 <tr>
                            			<td style="text-align: right;">프로젝트</td>
                            			<td><input id="project" type="text" name="project"></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchProjectBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input id="projectName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">거래처분류</td>
                            			<td><input id="customGroup" type="text" name="customGroup"></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchCustomGroupBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input id="customGroupName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">거래처등급</td>
                            			<td><input id="customGrade" type="text" name="customGrade"></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchCustomGradeBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input id="customGradeName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">수금거래처</td>
                            			<td><input id="collectCompany" type="text" name="collectCompany"></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchCollectCompanyBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input id="collectCompanyName" type="text" readonly></td>
                            		</tr>
                            	</table>
                            	<hr>
                            	<table class="table table-striped">
                            		<tr>
                            			<td style="text-align: right;">거래시작일</td>
                            			<td><input type="date" placeholder="YYYY-MM-DD" name="tradeStartDate"></td>
                            			<td style="text-align: right;">거래종료일</td>
                            			<td><input type="date" placeholder="YYYY-MM-DD" name="tradeEndDate"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">사용여부</td>
                            			<td colspan="3">
                            				<select style="height: 25px;" name="useBoolean">
                                            	<option value="true">여</option>
                                            	<option value="false">부</option>
                                        	</select>
                                        </td>
                                        
                            		</tr>
                            	</table>
                            </div>
                            <div class="tab-pane fade" id="tradeSession">
                            	<h5><i class="fa fa-tag"></i>&nbsp;계약정보</h5>
                                <table class="table table-striped">
                                	<tr>
                            			<td style="text-align: right;">거래형태</td>
                            			<td>
                            				<select style="width: 85%; height: 25px;" name="tradeForm">
                            					<option value="null">  </option>
                                            	<option value="sales">매출</option>
                                            	<option value="purchase">매입</option>
                                            	<option value="export">수출</option>
                                            	<option value="import">수입</option>
                                            	<option value="service">용역</option>
                                            	<option value="nomal">일반</option>
                                            	<option value="etc">기타</option>
                                        	</select>
                                        </td>
                            			<td style="text-align: right;">할인율</td>
                            			<td><input type="text" name="discountRate">%</td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">계약금액</td>
                            			<td colspan="3"><input type="text" name="contractSum"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">결제조건</td>
                            			<td colspan="3"><input type="text" name="paymentCondition"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">여신한도액</td>
                            			<td colspan="3"><input type="text" name="loanLimit"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">한도회귀일</td>
                            			<td colspan="3"><input type="text" name="limitReturnDate">일</td>
                            		</tr>
                                </table>
                                <h5><i class="fa fa-tag"></i>&nbsp;거래처 계좌관리</h5>
                                <table class="table table-striped">
                                	<tr>
                            			<td style="text-align: right;">금융기관</td>
                            			<td><input id="financialInstitutionCode" type="text" name="financialInstitutionCode" readonly></td>
                            			<td style="text-align: left;"><button id="searchFinancialInstitutionBtn" class="btn btn-default" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input id="financialInstitutionName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">지점명</td>
                            			<td colspan="3"><input type="text" name="branchName"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">계좌번호</td>
                            			<td colspan="3"><input type="text" name="accountNum"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">예금주</td>
                            			<td colspan="3"><input type="text" name="accountHolder"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">지금예정일(매월)</td>
                            			<td colspan="3"><input type="text" maxlength="2" name="payDueDate">일</td>
                            		</tr>
                                </table>
                                <h5><i class="fa fa-tag"></i>&nbsp;수금 계좌관리</h5>
                                <table class="table table-striped">
                                	<tr>
                            			<td style="text-align: right;">은행코드</td>
                            			<td><input id="accountCode" type="text" name="accountCode" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchAccountCodeBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input id="accountCodeName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">지점명</td>
                            			<td colspan="3"><input id="codeBranchName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">계좌번호</td>
                            			<td colspan="3"><input id="codeAccountNum" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">수금예정일(매월)</td>
                            			<td colspan="3"><input type="text" maxlength="2" name="collectionDueDate">일</td>
                            		</tr>
                                </table>
                            </div>
                            <div class="tab-pane fade" id="alphaSession">
                                <h5><i class="fa fa-tag"></i>&nbsp;관리 담당자</h5>
                                <table class="table table-striped">
                                	<tr>
                            			<td style="text-align: right;">담당 부서코드</td>
                            			<td><input type="text" id="chargeDeptCode" name="chargeDeptCode" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchChargeDeptCodeBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input type="text" id="chargeDeptName" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">직급 코드</td>
                            			<td><input type="text" name="positionCode" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchPositionCodeBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input id="positionName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">담당업무</td>
                            			<td colspan="3"><input type="text" style="width: 81%;" name="chargeTask"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">담당사원번호</td>
                            			<td><input id="chargeEmployeeCode" type="text" name="chargeEmployeeCode" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchChargeEmployeeCodeBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input id="chargeEmployeeName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">전화번호</td>
                            			<td><input id="employeeTel" type="text" name="employeeTel" readonly></td>
                            			<td style="text-align: right;">내선</td>
                            			<td><input type="text" name="employeeExtension"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">비고</td>
                            			<td colspan="3"><textarea style="width: 81%;" rows="3" name="chargeNote"></textarea></td>
                            		</tr>
                                </table>
                                <h5><i class="fa fa-tag"></i>&nbsp;수신처 관리</h5>
                                <table class="table table-striped">
                                	<tr>
                            			<td style="text-align: right;">우편번호</td>
                            			<td><input type="text" maxlength="5" id="receivePostNum" name="receivePostNum" readonly></td>
                            			<td><button class="btn btn-default" type="button" id="serchReceiveAddressBtn"><i class="fa fa-search-plus "></i></button></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">수신처주소</td>
                            			<td colspan="2"><input type="text" style="width: 85%" id="receiveAddress" name="receiveAddress" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">전화번호</td>
                            			<td colspan="2"><input type="text" name="receiveTel"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">팩스번호</td>
                            			<td colspan="2"><input type="text" name="receiveFax"></td>
                            		</tr>
                                </table>
                            </div>
                        </div>
                        <br>
                        <input type="hidden" name="lastSetting" value="<%= userID %>">
                        <button class="btn btn-outline btn-primary btn-lg btn-block" type="submit">등록</button>
					</form>
					<!-- /.panel-body -->
				</div>
				<!-- /.panel -->
			</div>
			<!-- /.col-lg-6 -->
		</div>
		<!-- /.row -->
	</div>
	<!-- Modal -->
	<!-- 회사 검색 -->
	<div class="modal fade" id="searchCustom" tabindex="-1" role="dialog"
		aria-labelledby="searchCustomLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 주소 검색 -->
	<div class="modal fade" id="searchAddress" tabindex="-1" role="dialog"
		aria-labelledby="serchAddressLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 업태업종 검색 -->
	<div class="modal fade" id="searchType" tabindex="-1" role="dialog"
		aria-labelledby="searchTypeLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 프로젝트 검색 -->
	<div class="modal fade" id="searchProject" tabindex="-1" role="dialog"
		aria-labelledby="searchProjectLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 거래처분류 검색 -->
	<div class="modal fade" id="searchCustomGroup" tabindex="-1" role="dialog"
		aria-labelledby="searchCustomGroupLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 거래처등급 검색 -->
	<div class="modal fade" id="searchCustomGrade" tabindex="-1" role="dialog"
		aria-labelledby="searchCustomGradeLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 수금거래처 검색 -->
	<div class="modal fade" id="searchCollectCompany" tabindex="-1" role="dialog"
		aria-labelledby="searchCollectCompanyLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 금융기관 검색 -->
	<div class="modal fade" id="searchFinancialInstitution" tabindex="-1" role="dialog"
		aria-labelledby="searchFinancialInstitutionLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 은행코드 검색 -->
	<div class="modal fade" id="searchAccountCode" tabindex="-1" role="dialog"
		aria-labelledby="searchAccountCodeLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 부서 검색 -->
	<div class="modal fade" id="searchChargeDeptCode" tabindex="-1" role="dialog"
		aria-labelledby="searchChargeDeptCodeLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 직금 검색 -->
	<div class="modal fade" id="searchPositionCode" tabindex="-1" role="dialog"
		aria-labelledby="searchPositionCodeLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 사원 검색 -->
	<div class="modal fade" id="searchChargeEmployeeCode" tabindex="-1" role="dialog"
		aria-labelledby="searchChargeEmployeeCodeLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 수신처주소 검색 -->
	<div class="modal fade" id="searchReceiveAddress" tabindex="-1" role="dialog"
		aria-labelledby="searchReceiveAddressLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
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