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
	<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
		<%@include file="../main/headNav.jsp"%>
		<%@include file="../main/sideNav.jsp" %>
	</nav>
	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">금융거래처등록</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-5">
				<div class="panel panel-default">
					<div class="panel-heading">등록된 금융 거래처를 확인 할 수 있습니다.</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<table width="100%"
							class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th><i class="fa fa-check-square-o"></i></th>
									<th>코드</th>
									<th>금융거래처명</th>
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
					<div class="panel-heading">금융거래처 등록</div>
					<div class="panel-body">
                        <br>
                        <ul class="nav nav-tabs">
                        	<li class="active"><a href="#baseSession" data-toggle="tab">기본등록사항</a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <form class="tab-pane fade in active" id="baseSession" method="POST" action="./">
                            	<input type="hidden" value="<%= companyCont.getCompanyCode() %>" name="companyCode">
                            	<br>
                            	<table class="table table-striped">
                            		<tr>
                            			<td style="text-align: right;"><h5>* 금융 거래처 코드</h5></td>
                            			<td><input class="form-control" type="text" name="customCode"></td>
                            			<td style="text-align: right;"><h5>* 구분</h5></td>
                            			<td>
                            				<select class="form-control" style="width: 70%;" name="division">
                                            	<option value="nomal">금융기관</option>
                                            	<option value="trade">정기예금</option>
                                            	<option value="regident">정기적금</option>
                                            	<option value="etc">카드사</option>
                                            	<option value="etc">신용카드</option>
                                        	</select>
                                        </td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;">* 금융 거래처 이름</td>
                            			<td colspan="3"><input class="form-control" id="customerName" type="text" name="customerName"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>계좌번호</h5></td>
                            			<td colspan="3"><input class="form-control" id="chiefName" type="text" name="chiefName"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>사업자 등록번호</h5></td>
                            			<td colspan="3"><input class="form-control" id="businessLicenseNum" type="text" name="businessLicenseNum"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>우편번호</h5></td>
                            			<td><input class="form-control" type="text" maxlength="5" name="postNum" id="postNum"></td>
                            			<td colspan="2"><button class="btn btn-default" id="searchAddressBtn" type="button"><i class="fa fa-search-plus"></i></button></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>주소</h5></td>
                            			<td colspan="3"><input class="form-control" type="text" style="width: 85%" name="address" id="address"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>전화번호</h5></td>
                            			<td colspan="3"><input class="form-control" id="tel" type="text" name="tel"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>팩스번호</h5></td>
                            			<td colspan="3"><input class="form-control" id="fax" type="text" name="fax"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>홈페이지</h5></td>
                            			<td colspan="3"><input class="form-control" id="homepage" type="url" style="width: 85%;" name="homepage" placeholder="https://~ or http://~"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>메일 주소</h5></td>
                            			<td colspan="3"><input class="form-control" id="email" type="email" style="width: 85%;" name="email"></td>
                            		</tr>
                            	</table>
                            	<hr>
                            	<table class="table table-striped">
                            		 <tr>
                            			<td style="text-align: right;"><h5>프로젝트</h5></td>
                            			<td><input class="form-control" id="project" type="text" name="project"></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchProjectBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="projectName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>거래처분류</h5></td>
                            			<td><input class="form-control" id="customGroup" type="text" name="customGroup"></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchCustomGroupBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="customGroupName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>금융기관코드</h5></td>
                            			<td><input class="form-control" id="customGrade" type="text" name="customGrade"></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchCustomGradeBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="customGradeName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>예금종류</h5></td>
                            			<td><input class="form-control" id="collectCompany" type="text" name="collectCompany"></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchCollectCompanyBtn" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="collectCompanyName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>예금주</h5></td>
                            			<td colspan="3"><input class="form-control" id="email" type="text" style="width: 85%;" name="email"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>예금명</h5></td>
                            			<td colspan="3"><input class="form-control" id="email" type="text" style="width: 85%;" name="email"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>당좌한도액</h5></td>
                            			<td colspan="3"><input class="form-control" id="email" type="text" style="width: 85%;" name="email"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>월불입액</h5></td>
                            			<td colspan="3"><input class="form-control" id="email" type="text" style="width: 85%;" name="email"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>해지일</h5></td>
                            			<td><input class="form-control" id="email" type="date" name="email" placeholder="YYYY-MM-DD"></td>
                            			<td style="text-align: left;"><h5>~</h5></td>
                            			<td><input class="form-control" id="email" type="date" name="email" placeholder="YYYY-MM-DD"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>결제일</h5></td>
                            			<td><input class="form-control" id="email" type="date" name="email" placeholder="YYYY-MM-DD"></td>
                            			<td style="text-align: right;"><h5>이자율</h5></td>
                            			<td><input class="form-control" id="email" type="text" name="email">%</td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>SWIFTY 코드</h5></td>
                            			<td colspan="3"><input class="form-control" id="email" type="text" style="width: 85%;" name="email"></td>
                            		</tr>
                            	</table>
                            	<hr>
                            	<table class="table table-striped">
                            		<tr>
                            			<td style="text-align: right;"><h5>계좌개설일</h5></td>
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
                            			<td style="text-align: right;"><h5>계좌조회 설정</h5></td>
                            			<td>
                            				<select class="form-control" name="useBoolean">
                                            	<option value="true">전체</option>
                                            	<option value="false">회계</option>
                                        	</select>
                                        </td>
                            		</tr>
                            	</table>
                            	<input type="hidden" name="lastSetting" value="<%= userID %>">
                        		<button class="btn btn-outline btn-primary btn-lg btn-block" type="submit">등록</button>
                            </form>
                        </div>
                        <br>
					</div>
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
	
<!-- JavaScript -->
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
<!-- /JavaScript -->
</body>
</html>