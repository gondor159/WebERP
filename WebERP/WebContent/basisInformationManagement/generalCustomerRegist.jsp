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

<!-- CSS -->
	<!-- Modal table CSS -->
	<link href="../css/table.css" rel="stylesheet">
	<!-- Bootstrap Core CSS -->
	<link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<!-- MetisMenu CSS -->
	<link href="../vendor/metisMenu/metisMenu.min.css" rel="stylesheet">
	<!-- DataTables CSS -->
	<link href="../vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">
	<!-- DataTables Responsive CSS -->
	<link href="../vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
	<!-- Custom CSS -->
	<link href="../dist/css/sb-admin-2.css" rel="stylesheet">
	<!-- Custom Fonts -->
	<link href="../vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->
<!-- /CSS -->

<!-- jQuery -->
	<script type="text/javascript" src="//code.jquery.com/jquery-3.3.1.js" charset="UTF-8"></script>
<!-- /jQuery -->

<!-- function -->
<script>
/* 거래처 수정 */
function editCustom() {
	var companyCode  = encodeURIComponent('<%=companyCont.getCompanyCode()%>');
	var checked = $('input[name="selectCustom"]:checked').val();
	location.href = "generalCustomerEdit.jsp?companyCode=" + companyCode + "&customcode=" + checked;
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
	/* 거래처 분류 등록 버튼 */
	$("#registCustomGroupBtn").click(function(){
		$('#insertCustomGroup').modal({
			remote : 'modal/insertCustomGroupModal.jsp'
		});
	})
	/* 거래처 검색 버튼 */
	$("#searchCustomBtn").click(function(){
		$('#searchCustom').modal({
			remote : 'modal/searchCustomModal.jsp'
		});
	})
	/* 거래처 주소 검색 버튼 */
	$("#searchAddressBtn").click(function(){
		$('#searchAddress').modal({
			remote : 'modal/searchAddressModal.jsp'
		});
	})
	/* 업태/종목 검색 버튼 */
	$("#searchTypeBtn").click(function(){
		$('#searchType').modal({
			remote : 'modal/searchTypeModal.jsp'
		});
	})
	/* 프로젝트 검색 버튼 */
	$("#searchProjectBtn").click(function(){
		$('#searchProject').modal({
			remote : 'modal/searchProjectModal.jsp?companyCode=' + companyCode
		});
	})
	/* 거래처 그룹 검색 버튼 */
	$("#searchCustomGroupBtn").click(function(){
		$('#searchCustomGroup').modal({
			remote : 'modal/searchCustomGroupModal.jsp?companyCode=' + companyCode
		});
	})
	/* 거래처 등급 검색 버튼 */
	$("#searchCustomGradeBtn").click(function(){
		$('#searchCustomGrade').modal({
			remote : 'modal/searchCustomGradeModal.jsp?companyCode=' + companyCode
		});
	})
	/* 수금 거래처 검색 버튼 */
	$("#searchCollectCompanyBtn").click(function(){
		$('#searchCollectCompany').modal({
			remote : 'modal/searchCollectCompanyModal.jsp?companyCode=' + companyCode
		});
	})
	/* 금융기관 검색 버튼 */
	$("#searchFinancialInstitutionBtn").click(function(){
		$('#searchFinancialInstitution').modal({
			remote : 'modal/searchFinancialInstitutionModal.jsp'
		});
	})
	/* 은행코드 검색 버튼 */
	$("#searchAccountCodeBtn").click(function(){
		$('#searchAccountCode').modal({
			remote : 'modal/searchAccountCodeModal.jsp?companyCode=' + companyCode
		});
	})
	/* 부서검색 버튼 */
	$("#searchChargeDeptCodeBtn").click(function(){
		$('#searchChargeDeptCode').modal({
			remote : 'modal/searchChargeDeptCodeModal.jsp?companyCode=' + companyCode
		});
	})
	/* 직급 검색 버튼 */
	$("#searchPositionCodeBtn").click(function(){
		$('#searchPositionCode').modal({
			remote : 'modal/searchPositionCodeModal.jsp'
		});
	})
	/* 사원 검색 버튼 */
	$("#searchChargeEmployeeCodeBtn").click(function(){
		$('#searchChargeEmployeeCode').modal({
			remote : 'modal/searchChargeEmployeeCodeModal.jsp?companyCode=' + companyCode + '&departmentCode=' + $('#chargeDeptCode').val()
		});
	})
	/* 수신처 주소검색 버튼 */
	$("#serchReceiveAddressBtn").click(function(){
		$('#serchReceiveAddress').modal({
			remote : 'modal/searchReceiveAddressModal.jsp'
		});
	})
});
</script>
</head>
<body>
	<nav class="navbar navbar-default navbar-static-top" role="navigation"
		style="margin-bottom: 0">
		<%@include file="../main/headNav.jsp"%>
		<%@include file="../main/sideNav.jsp" %>
	</nav>
	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">일반거래처등록</h1>
			</div>
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
					</div>
				</div>
			</div>
			<div class="col-lg-7">
				<div class="panel panel-default">
					<div class="panel-heading">
						<div class="row">
							<div class="col-md-10">
								<h5>거래처 등록</h5>
							</div>
							<div class="col-md-2">
								<button class="btn btn-default" id="registCustomGroupBtn" type="button">거래처 분류등록</button>
							</div>
						</div>
					</div>
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
                        <div class="tab-content">
                            <div class="tab-pane fade in active" id="baseSession">
                            	<br>
                            	<table class="table table-striped">
                            		<tr>
                            			<td style="text-align: right;"><h5>* 거래처 코드</h5></td>
                            			<td><input class="form-control" type="text" name="customCode"></td>
                            			<td style="text-align: right;"><h5>* 구분</h5></td>
                            			<td>
                            				<select class="form-control" name="division">
                                            	<option value="nomal">일반</option>
                                            	<option value="trade">무역</option>
                                            	<option value="regident">주민</option>
                                            	<option value="etc">기타</option>
                                        	</select>
                                        </td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>* 거래처 이름</h5></td>
                            			<td colspan="3"><input class="form-control" id="customerName" type="text" name="customerName"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>* 사업자 등록번호</h5></td>
                            			<td><input class="form-control" id="businessLicenseNum" type="text" name="businessLicenseNum"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>대표자 이름</h5></td>
                            			<td><input class="form-control" id="chiefName" type="text" name="chiefName"></td>
                            			<td colspan="2">
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>우편번호</h5></td>
                            			<td><input class="form-control" type="text" maxlength="5" name="postNum" id="postNum" readonly></td>
                            			<td><button class="btn btn-default" id="searchAddressBtn" type="button"><i class="fa fa-search-plus"></i></button></td>
                            			<td></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>주소</h5></td>
                            			<td colspan="3"><input class="form-control" type="text" name="address" id="address" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>전화번호</h5></td>
                            			<td><input class="form-control" id="tel" type="text" name="tel"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>팩스번호</h5></td>
                            			<td><input class="form-control" type="text" name="fax"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>업태</h5></td>
                            			<td><input class="form-control" id="businessCondition" type="text" name="businessCondition" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchTypeBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="businessConditionName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>종목</h5></td>
                            			<td><input class="form-control" id="businessType" type="text" name="businessType" readonly></td>
                            			<td></td>
                            			<td><input class="form-control" id="businessTypeName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>홈페이지</h5></td>
                            			<td colspan="3"><input class="form-control" id="homepage" type="url" name="homepage" placeholder="https://~ or http://~"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>환종</h5></td>
                            			<td>
                            				<select class="form-control" name="monetaryUnit">
												<option value="KRW">￦ KRW</option>
												<option value="USD">$ USD</option>
												<option value="JPY">￥ JPY</option>
												<option value="CNY">元 CNY</option>
												<option value="EUR">€ EUR</option>
											</select>
                            			</td>
                            			<td colspan="2"></td>
                            		</tr>
                            	</table>
                            	<hr>
                            	<table class="table table-striped">
                            		 <tr>
                            			<td style="text-align: right;"><h5>프로젝트</h5></td>
                            			<td><input class="form-control" id="project" type="text" name="project" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchProjectBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="projectName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>거래처분류</h5></td>
                            			<td><input class="form-control" id="customGroup" type="text" name="customGroup" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchCustomGroupBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="customGroupName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>거래처등급</h5></td>
                            			<td><input class="form-control" id="customGrade" type="text" name="customGrade" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchCustomGradeBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="customGradeName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>수금거래처</h5></td>
                            			<td><input class="form-control" id="collectCompany" type="text" name="collectCompany" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchCollectCompanyBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="collectCompanyName" type="text" readonly></td>
                            		</tr>
                            	</table>
                            	<hr>
                            	<table class="table table-striped">
                            		<tr>
                            			<td style="text-align: right;"><h5>거래시작일</h5></td>
                            			<td><input class="form-control" type="date" placeholder="YYYY-MM-DD" name="tradeStartDate"></td>
                            			<td style="text-align: right;"><h5>거래종료일</h5></td>
                            			<td><input class="form-control" type="date" placeholder="YYYY-MM-DD" name="tradeEndDate"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>사용여부</h5></td>
                            			<td>
                            				<select class="form-control" name="useBoolean">
                                            	<option value="true">여</option>
                                            	<option value="false">부</option>
                                        	</select>
                                        </td>
                                        <td colspan="2"></td>
                            		</tr>
                            	</table>
                            </div>
                            <div class="tab-pane fade" id="tradeSession">
                            	<h5><i class="fa fa-tag"></i>&nbsp;계약정보</h5>
                                <table class="table table-striped">
                                	<tr>
                            			<td style="text-align: right;"><h5>거래형태</h5></td>
                            			<td>
                            				<select class="form-control" name="tradeForm">
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
                            			<td style="text-align: right;"><h5>할인율</h5></td>
                            			<td>
                            				<div class="form-group input-group">
                                            	<input type="text" class="form-control" style = "text-align:right;" name="discountRate">
                                            	<span class="input-group-addon">%</span>
                                        	</div>
                            			</td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>계약금액</h5></td>
                            			<td><input class="form-control" type="text" name="contractSum"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>결제조건</h5></td>
                            			<td colspan="3"><input class="form-control" type="text" name="paymentCondition"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>여신한도액</h5></td>
                            			<td><input class="form-control" type="text" name="loanLimit"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>한도회귀일</h5></td>
                            			<td>
                            				<div class="form-group input-group">
                                            	<input type="text" class="form-control" style = "text-align:right;" name="limitReturnDate">
                                            	<span class="input-group-addon">日</span>
                                        	</div>
                            			</td>
                            			<td colspan="2"></td>
                            		</tr>
                                </table>
                                <h5><i class="fa fa-tag"></i>&nbsp;거래처 계좌관리</h5>
                                <table class="table table-striped">
                                	<tr>
                            			<td style="text-align: right;"><h5>금융기관</h5></td>
                            			<td><input class="form-control" id="financialInstitutionCode" type="text" name="financialInstitutionCode" readonly></td>
                            			<td style="text-align: left;"><button id="searchFinancialInstitutionBtn" class="btn btn-default" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="financialInstitutionName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>지점명</h5></td>
                            			<td><input class="form-control" type="text" name="branchName"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>계좌번호</h5></td>
                            			<td><input class="form-control" type="text" name="accountNum"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>예금주</h5></td>
                            			<td><input class="form-control" type="text" name="accountHolder"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>지금예정일(매월)</h5></td>
                            			<td>
                            				<div class="form-group input-group">
                                            	<input type="text" class="form-control" style = "text-align:right;" maxlength="2" name="payDueDate">
                                            	<span class="input-group-addon">日</span>
                                        	</div>
                            			</td>
                            			<td colspan="2"></td>
                            		</tr>
                                </table>
                                <h5><i class="fa fa-tag"></i>&nbsp;수금 계좌관리</h5>
                                <table class="table table-striped">
                                	<tr>
                            			<td style="text-align: right;"><h5>은행코드</h5></td>
                            			<td><input class="form-control" id="accountCode" type="text" name="accountCode" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchAccountCodeBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="accountCodeName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>지점명</h5></td>
                            			<td colspan="3"><input class="form-control" id="codeBranchName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>계좌번호</h5></td>
                            			<td><input class="form-control" id="codeAccountNum" type="text" readonly></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>수금예정일(매월)</h5></td>
                            			<td>
                            				<div class="form-group input-group">
                                            	<input type="text" class="form-control" style = "text-align:right;" maxlength="2" name="collectionDueDate">
                                            	<span class="input-group-addon">日</span>
                                        	</div>
                            			</td>
                            			<td colspan="2"></td>
                            		</tr>
                                </table>
                            </div>
                            <div class="tab-pane fade" id="alphaSession">
                                <h5><i class="fa fa-tag"></i>&nbsp;관리 담당자</h5>
                                <table class="table table-striped">
                                	<tr>
                            			<td style="text-align: right;"><h5>담당 부서코드</h5></td>
                            			<td><input class="form-control" type="text" id="chargeDeptCode" name="chargeDeptCode" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchChargeDeptCodeBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" type="text" id="chargeDeptName" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>직급 코드</h5></td>
                            			<td><input class="form-control" type="text" name="positionCode" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchPositionCodeBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="positionName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>담당업무</h5></td>
                            			<td colspan="3"><input class="form-control" type="text" name="chargeTask"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>담당사원번호</h5></td>
                            			<td><input class="form-control" id="chargeEmployeeCode" type="text" name="chargeEmployeeCode" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchChargeEmployeeCodeBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="chargeEmployeeName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>전화번호</h5></td>
                            			<td><input class="form-control" id="employeeTel" type="text" name="employeeTel" readonly></td>
                            			<td style="text-align: right;"><h5>내선</h5></td>
                            			<td><input class="form-control" type="text" name="employeeExtension"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>비고</h5></td>
                            			<td colspan="3"><textarea class="form-control" rows="3" name="chargeNote"></textarea></td>
                            		</tr>
                                </table>
                                <h5><i class="fa fa-tag"></i>&nbsp;수신처 관리</h5>
                                <table class="table table-striped">
                                	<tr>
                            			<td style="text-align: right;"><h5>우편번호</h5></td>
                            			<td><input class="form-control" type="text" style="width: 30%;" maxlength="5" id="receivePostNum" name="receivePostNum" readonly></td>
                            			<td><button class="btn btn-default" type="button" id="serchReceiveAddressBtn"><i class="fa fa-search-plus "></i></button></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>수신처주소</h5></td>
                            			<td colspan="2"><input class="form-control" type="text" id="receiveAddress" name="receiveAddress" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>전화번호</h5></td>
                            			<td><input class="form-control" type="text" style="width: 45%;" name="receiveTel"></td>
                            			<td></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>팩스번호</h5></td>
                            			<td><input class="form-control" type="text" style="width: 45%;" name="receiveFax"></td>
                            			<td></td>
                            		</tr>
                                </table>
                            </div>
                        </div>
                        <br>
                        <input type="hidden" name="lastSetting" value="<%= userID %>">
                        <button class="btn btn-outline btn-primary btn-lg btn-block" type="submit">등록</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal -->
	<!-- 회사 검색 -->
	<div class="modal fade" id="searchCustom" tabindex="-1" role="dialog"
		aria-labelledby="searchCustomLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
		</div>
	</div>
	<!-- 주소 검색 -->
	<div class="modal fade" id="searchAddress" tabindex="-1" role="dialog"
		aria-labelledby="serchAddressLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
		</div>
	</div>
	<!-- 업태업종 검색 -->
	<div class="modal fade" id="searchType" tabindex="-1" role="dialog"
		aria-labelledby="searchTypeLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
		</div>
	</div>
	<!-- 프로젝트 검색 -->
	<div class="modal fade" id="searchProject" tabindex="-1" role="dialog"
		aria-labelledby="searchProjectLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
		</div>
	</div>
	<!-- 거래처분류 검색 -->
	<div class="modal fade" id="searchCustomGroup" tabindex="-1" role="dialog"
		aria-labelledby="searchCustomGroupLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
		</div>
	</div>
	<!-- 거래처등급 검색 -->
	<div class="modal fade" id="searchCustomGrade" tabindex="-1" role="dialog"
		aria-labelledby="searchCustomGradeLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
		</div>
	</div>
	<!-- 수금거래처 검색 -->
	<div class="modal fade" id="searchCollectCompany" tabindex="-1" role="dialog"
		aria-labelledby="searchCollectCompanyLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
		</div>
	</div>
	<!-- 금융기관 검색 -->
	<div class="modal fade" id="searchFinancialInstitution" tabindex="-1" role="dialog"
		aria-labelledby="searchFinancialInstitutionLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
		</div>
	</div>
	<!-- 은행코드 검색 -->
	<div class="modal fade" id="searchAccountCode" tabindex="-1" role="dialog"
		aria-labelledby="searchAccountCodeLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
		</div>
	</div>
	<!-- 부서 검색 -->
	<div class="modal fade" id="searchChargeDeptCode" tabindex="-1" role="dialog"
		aria-labelledby="searchChargeDeptCodeLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
		</div>
	</div>
	<!-- 직금 검색 -->
	<div class="modal fade" id="searchPositionCode" tabindex="-1" role="dialog"
		aria-labelledby="searchPositionCodeLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
		</div>
	</div>
	<!-- 사원 검색 -->
	<div class="modal fade" id="searchChargeEmployeeCode" tabindex="-1" role="dialog"
		aria-labelledby="searchChargeEmployeeCodeLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
		</div>
	</div>
	<!-- 수신처주소 검색 -->
	<div class="modal fade" id="searchReceiveAddress" tabindex="-1" role="dialog"
		aria-labelledby="searchReceiveAddressLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
		</div>
	</div>
	
<!-- Java Script -->
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
<!-- /Java Script -->
</body>
</html>