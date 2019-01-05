<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="company.CompanyDAO"%>
<%@ page import="company.CompanyDTO"%>
<%@ page import="financialcustom.FinancialCustomDAO" %>
<%@ page import="financialcustom.FinancialCustomDTO" %>
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
	ArrayList<FinancialCustomDTO> list = new FinancialCustomDAO().getFinancialCustomList(companyCont.getCompanyCode());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>기초정보관리 - 금융거래처등록</title>

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
/* 분류 선택 */
function tabAction() {
	var select = document.getElementById("defaultDivision");
	var division = select.options[select.selectedIndex].value;
	var code = $('#defaultFcCode').val();
	var name = $('#defaultFcName').val();
	
	if (code == '' || name == '') {
		alert('코드와 이름은 필수 입력 사항입니다.');
		return;
	}
	$('div.tab-content form').removeClass('in active');
	$("#" + division).addClass('in active');
	
	if(division == 'fi') {
		$('#fiFcCode').attr('value', code);
		$('#fiFcName').attr('value', name);
	} else if(division == 'td') {
		$('#tdFcCode').attr('value', code);
		$('#tdFcName').attr('value', name);
	} else if(division == 'isd') {
		$('#isdFcCode').attr('value', code);
		$('#isdFcName').attr('value', name);
	} else if(division == 'ccc') {
		$('#cccFcCode').attr('value', code);
		$('#cccFcName').attr('value', name);
	} else if(division == 'cd') {
		$('#cdFcCode').attr('value', code);
		$('#cdFcName').attr('value', name);
	}
}
/* 거래처 수정 */
function editCustom() {
	var companyCode  = encodeURIComponent('<%=companyCont.getCompanyCode()%>');
	var checked = $('input[name="selectCustom"]:checked').val();
	location.href = "generalCustomerEdit.jsp?companyCode=" + compnayCode + "&customcode=" + checked;
}
/* 주소 등록 */
function insertAddFunction() {
	var entry_postcode5 = $('#nomal_postcode5').val();
	var entry_address = $('#nomal_address').val();
	var entry_details = $('#nomal_extra_info').val();
	var entry_extra_info = $('#nomal_details').val();
	var select = document.getElementById("defaultDivision");
	var division = select.options[select.selectedIndex].value;
	
	if(division == 'fi') {
		$('#fiPostNum').attr('value', entry_postcode5);
		$('#fiAddress').attr('value', entry_address + entry_extra_info + " " + entry_details);
	} else if(division == 'td') {
		$('#tdPostNum').attr('value', entry_postcode5);
		$('#tdAddress').attr('value', entry_address + entry_extra_info + " " + entry_details);
	} else if(division == 'isd') {
		$('#isdPostNum').attr('value', entry_postcode5);
		$('#isdAddress').attr('value', entry_address + entry_extra_info + " " + entry_details);
	} else if(division == 'ccc') {
		$('#cccPostNum').attr('value', entry_postcode5);
		$('#cccAddress').attr('value', entry_address + entry_extra_info + " " + entry_details);
	} else if(division == 'cd') {
		$('#cdPostNum').attr('value', entry_postcode5);
		$('#cdAddress').attr('value', entry_address + entry_extra_info + " " + entry_details);
	}
}
/* 거래처 그룹 등록 */
function insertCGFunction() {
	var companyCode =  encodeURIComponent('<%=companyCont.getCompanyCode()%>');
	var customGroup = $('input[name="selectCustomGroup"]:checked').val();
	var select = document.getElementById("defaultDivision");
	var division = select.options[select.selectedIndex].value;
	$.ajax({
		type : 'POST',
		url : './customGroupGetServlet',
		data : {
			companyCode : companyCode,
			customGroup : customGroup
		},
		success : function(data) {
			if(data == "") return;
			var parsed = JSON.parse(data);
			var result = parsed.result;
			if(division == 'fi') {
				$('#fiCustomGroup').attr('value', result[0].value);
				$('#fiCustomGroupName').attr('value', result[1].value);
			} else if(division == 'td') {
				$('#tdCustomGroup').attr('value', result[0].value);
				$('#tdCustomGroupName').attr('value', result[1].value);
			} else if(division == 'isd') {
				$('#isdCustomGroup').attr('value', result[0].value);
				$('#isdCustomGroupName').attr('value', result[1].value);
			} else if(division == 'ccc') {
				$('#cccCustomGroup').attr('value', result[0].value);
				$('#cccCustomGroupName').attr('value', result[1].value);
			} else if(division == 'cd') {
				$('#cdCustomGroup').attr('value', result[0].value);
				$('#cdCustomGroupName').attr('value', result[1].value);
			}
		}
	});
}
/* 프로젝트 등록 */
function insertPFunction() {
	var companyCode =  encodeURIComponent('<%=companyCont.getCompanyCode()%>');
	var checked = $('input[name="selectProject"]:checked').val();
	var select = document.getElementById("defaultDivision");
	var division = select.options[select.selectedIndex].value;
	$.ajax({
		type : 'POST',
		url : './projectGetNameServlet',
		data : {
			companyCode : companyCode,
			projectCode : checked
		},
		success : function(result) {
			if(result == "") return;
			if(division == 'fi') {
				$('#fiProjectCode').attr('value', checked);
				$('#fiProjectName').attr('value', result);
			} else if(division == 'td') {
				$('#tdProjectCode').attr('value', checked);
				$('#tdProjectName').attr('value', result);
			} else if(division == 'isd') {
				$('#isdProjectCode').attr('value', checked);
				$('#isdProjectName').attr('value', result);
			} else if(division == 'ccc') {
				$('#cccProjectCode').attr('value', checked);
				$('#cccProjectName').attr('value', result);
			} else if(division == 'cd') {
				$('#cdProjectCode').attr('value', checked);
				$('#cdProjectName').attr('value', result);
			}
		}
	});
}
/* 금융기관 등록 */
function insertFIFunction() {
	var checked = $('input[name="fiCode"]:checked').val();
	var select = document.getElementById("defaultDivision");
	var division = select.options[select.selectedIndex].value;
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
			if(division == 'fi') {
				$('#fiFinancialInstitutionCode').attr('value', checked);
				$('#fiFinancialInstitutionName').attr('value', result[0].value);
			} else if(division == 'td') {
				$('#tdFinancialInstitutionCode').attr('value', checked);
				$('#tdFinancialInstitutionName').attr('value', result[0].value);
			} else if(division == 'isd') {
				$('#isdFinancialInstitutionCode').attr('value', checked);
				$('#isdFinancialInstitutionName').attr('value', result[0].value);
			} else if(division == 'ccc') {
				$('#cccFinancialInstitutionCode').attr('value', checked);
				$('#cccFinancialInstitutionName').attr('value', result[0].value);
			} else if(division == 'cd') {
				$('#cdFinancialInstitutionCode').attr('value', checked);
				$('#cdFinancialInstitutionName').attr('value', result[0].value);
			}
			
		}
	});
}
/* 금융거래처 등록 */
function insertFCFunction() {
	var companyCode =  encodeURIComponent('<%=companyCont.getCompanyCode()%>');
	var checked = $('input[name="selectFinancialCustomModal"]:checked').val();
	var select = document.getElementById("defaultDivision");
	var division = select.options[select.selectedIndex].value;
	$.ajax({
		type : 'POST',
		url : './financialCustomGetNameServlet',
		data : {
			companyCode : companyCode,
			fcCode : checked
		},
		success : function(result) {
			if(division == 'ccc') {
				$('#cccPaymentAccount').attr('value', checked);
				$('#cccPaymentAccountName').attr('value', result);
			} else if(division == 'cd') {
				$('#cdPaymentAccount').attr('value', checked);
				$('#cdPaymentAccountName').attr('value', result);
			}
			
		}
	});
}
</script>

<!-- Button 활성화 -->
<script>
$(function(){
	var companyCode = encodeURIComponent('<%=companyCont.getCompanyCode()%>');
	/* 거래처 분류 등록 버튼 */
	$("#registCustomGroupBtn").click(function(){
		$('#insertCustomGroup').modal({
			remote : 'modal/insertCustomGroupModal.jsp?companyCode=' + companyCode
		});
	})
	/* 주소 검색 버튼 */
	$("#searchAddressBtnFi").click(function(){
		$('#searchAddress').modal({
			remote : 'modal/searchAddressModal.jsp'
		});
	})
	$("#searchAddressBtnTd").click(function(){
		$('#searchAddress').modal({
			remote : 'modal/searchAddressModal.jsp'
		});
	})
	$("#searchAddressBtnIsd").click(function(){
		$('#searchAddress').modal({
			remote : 'modal/searchAddressModal.jsp'
		});
	})
	$("#searchAddressBtnCcc").click(function(){
		$('#searchAddress').modal({
			remote : 'modal/searchAddressModal.jsp'
		});
	})
	$("#searchAddressBtnCd").click(function(){
		$('#searchAddress').modal({
			remote : 'modal/searchAddressModal.jsp'
		});
	})
	/* 프로젝트 검색 버튼 */
	$("#searchProjectBtnFi").click(function(){
		$('#searchProject').modal({
			remote : 'modal/searchProjectModal.jsp?companyCode=' + companyCode
		});
	})
	$("#searchProjectBtnTd").click(function(){
		$('#searchProject').modal({
			remote : 'modal/searchProjectModal.jsp?companyCode=' + companyCode
		});
	})
	$("#searchProjectBtnIsd").click(function(){
		$('#searchProject').modal({
			remote : 'modal/searchProjectModal.jsp?companyCode=' + companyCode
		});
	})
	$("#searchProjectBtnCcc").click(function(){
		$('#searchProject').modal({
			remote : 'modal/searchProjectModal.jsp?companyCode=' + companyCode
		});
	})
	$("#searchProjectBtnCd").click(function(){
		$('#searchProject').modal({
			remote : 'modal/searchProjectModal.jsp?companyCode=' + companyCode
		});
	})
	/* 거래처 분류 검색 버튼 */
	$("#searchCustomGroupBtnFi").click(function(){
		$('#searchCustomGroup').modal({
			remote : 'modal/searchCustomGroupModal.jsp?companyCode=' + companyCode
		});
	})
	$("#searchCustomGroupBtnTd").click(function(){
		$('#searchCustomGroup').modal({
			remote : 'modal/searchCustomGroupModal.jsp?companyCode=' + companyCode
		});
	})
	$("#searchCustomGroupBtnIsd").click(function(){
		$('#searchCustomGroup').modal({
			remote : 'modal/searchCustomGroupModal.jsp?companyCode=' + companyCode
		});
	})
	$("#searchCustomGroupBtnCcc").click(function(){
		$('#searchCustomGroup').modal({
			remote : 'modal/searchCustomGroupModal.jsp?companyCode=' + companyCode
		});
	})
	$("#searchCustomGroupBtnCd").click(function(){
		$('#searchCustomGroup').modal({
			remote : 'modal/searchCustomGroupModal.jsp?companyCode=' + companyCode
		});
	})
	/* 금융기관 검색 버튼 */
	$("#searchFinancialInstitutionBtnFi").click(function(){
		$('#searchFinancialInstitution').modal({
			remote : 'modal/searchFinancialInstitutionModal.jsp'
		});
	})
	$("#searchFinancialInstitutionBtnTd").click(function(){
		$('#searchFinancialInstitution').modal({
			remote : 'modal/searchFinancialInstitutionModal.jsp'
		});
	})
	$("#searchFinancialInstitutionBtnIsd").click(function(){
		$('#searchFinancialInstitution').modal({
			remote : 'modal/searchFinancialInstitutionModal.jsp'
		});
	})
	$("#searchFinancialInstitutionBtnCcc").click(function(){
		$('#searchFinancialInstitution').modal({
			remote : 'modal/searchFinancialInstitutionModal.jsp'
		});
	})
	$("#searchFinancialInstitutionBtnCd").click(function(){
		$('#searchFinancialInstitution').modal({
			remote : 'modal/searchFinancialInstitutionModal.jsp'
		});
	})
	/* 금융거래처 검색 버튼 */
	$("#searchFinancialCustomBtnCcc").click(function(){
		$('#searchFinancialCustom').modal({
			remote : 'modal/searchFinancialCustomModal.jsp?companyCode=' + companyCode
		});
	})
	$("#searchFinancialCustomBtnCd").click(function(){
		$('#searchFinancialCustom').modal({
			remote : 'modal/searchFinancialCustomModal.jsp?companyCode=' + companyCode
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
					<div class="panel-body">
						<table class="table table-striped table-bordered table-hover">
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
									for(int i = 0; i < list.size(); i++) {
										FinancialCustomDTO financialCustom = list.get(i);
								%>
								<tr>
									<td><input type="radio" name="selectFinancialCustom" value="<%= financialCustom.getFcCode() %>"></td>
									<td><%= financialCustom.getFcCode() %></td>
									<td><%= financialCustom.getFcName() %></td>
									<td>
										<% 
											if(financialCustom.getDivision().equals("fi")) { out.println("금융거래처"); } 
											else if(financialCustom.getDivision().equals("td")) { out.println("정기예금"); } 
											else if(financialCustom.getDivision().equals("isd")) { out.println("정기적금"); } 
											else if(financialCustom.getDivision().equals("ccc")) { out.println("카드사"); } 
											else if(financialCustom.getDivision().equals("cd")) { out.println("신용카드"); } 
										%>
									</td>
								</tr>
								<% } %>
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
								<h5>금융거래처 등록</h5>
							</div>
							<div class="col-md-2">
								<button class="btn btn-default" id="registCustomGroupBtn" type="button">거래처 분류등록</button>
							</div>
						</div>
					</div>
					<div class="panel-body">
                        <br>
                        <table class="table table-striped">
                        	<tr>
                        		<td style="text-align: right;"><h5>코드</h5></td>
                        		<td><input class="form-control" id="defaultFcCode" type="text"></td>
                        		<td style="text-align: right;"><h5>금융거래처명</h5></td>
                        		<td><input class="form-control" id="defaultFcName" type="text"></td>
                        		<td style="text-align: right;"><h5>구분</h5></td>
                        		<td>
                        			<select class="form-control" id="defaultDivision" onchange="tabAction();">
                                    	<option value=""></option>
                                    	<option value="fi">금융기관</option>
                                        <option value="td">정기예금</option>
                                        <option value="isd">정기적금</option>
                                        <option value="ccc">카드사</option>
                                        <option value="cd">신용카드</option>
                                    </select>
                                </td>
                        	</tr>
                        </table>
                        <hr>
                        <div class="tab-content">
                            <form class="tab-pane fade" id="fi" method="POST" action="./financialCustomRegistServelt">
                            	<input type="hidden" value="<%= companyCont.getCompanyCode() %>" name="companyCode">
                            	<br>
                            	<table class="table table-striped">
                            		<tr>
                            			<td style="text-align: right;"><h5>* 금융 거래처 코드</h5></td>
                            			<td><input class="form-control" type="text" id="fiFcCode" name="fcCode" readonly></td>
                            			<td style="text-align: right;"><h5>* 구분</h5></td>
                            			<td>
                            				<input class="form-control" type="hidden" name="division" value="fi">
                            				<input class="form-control" type="text" value="금융기관" readonly>
                            			</td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>* 금융 거래처 이름</h5></td>
                            			<td><input class="form-control" id="fiFcName" type="text" name="fcName" readonly></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>계좌번호</h5></td>
                            			<td><input class="form-control" type="text" name="accountNum"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>계좌개설점</h5></td>
                            			<td><input class="form-control" type="text" name="accountBranch"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>사업자 등록번호</h5></td>
                            			<td><input class="form-control" type="text" name="businessLicenseNum"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>우편번호</h5></td>
                            			<td><input class="form-control" type="text" style="width: 50%;" maxlength="5" name="postNum" id="fiPostNum" readonly></td>
                            			<td colspan="2"><button class="btn btn-default" id="searchAddressBtnFi" type="button"><i class="fa fa-search-plus"></i></button></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>주소</h5></td>
                            			<td colspan="3"><input class="form-control" type="text" name="address" id="fiAddress" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>전화번호</h5></td>
                            			<td><input class="form-control" type="text" name="tel"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>팩스번호</h5></td>
                            			<td><input class="form-control" type="text" name="fax"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>홈페이지</h5></td>
                            			<td colspan="3"><input class="form-control" type="url" name="homepage" placeholder="https://~ or http://~"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>메일 주소</h5></td>
                            			<td colspan="2"><input class="form-control" type="email" name="email"></td>
                            			<td></td>
                            		</tr>
                            	</table>
                            	<hr>
                            	<table class="table table-striped">
                            		 <tr>
                            			<td style="text-align: right;"><h5>프로젝트</h5></td>
                            			<td><input class="form-control" id="fiProjectCode" type="text" name="projectCode" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchProjectBtnFi" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="fiProjectName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>거래처분류</h5></td>
                            			<td><input class="form-control" id="fiCustomGroup" type="text" name="customGroup" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchCustomGroupBtnFi" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="fiCustomGroupName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>금융기관코드</h5></td>
                            			<td><input class="form-control" id="fiFinancialInstitutionCode" type="text" name="financialInstitutionCode" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchFinancialInstitutionBtnFi" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="fiFinancialInstitutionName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>예금종류</h5></td>
                            			<td>
                            				<select class="form-control" name="accountDivision">
                                    			<option value="1">보통예금</option>
                                    			<option value="2">당좌예금</option>
                                    			<option value="3">외화예금</option>
                                    			<option value="4">별단예금</option>
                                    			<option value="5">정기예금</option>
                                    			<option value="6">정기적금</option>
                                    			<option value="7">신탁연금</option>
                                    			<option value="8">연금보험</option>
                                    			<option value="9">기타</option>
                                    		</select>
                            			</td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>예금주</h5></td>
                            			<td><input class="form-control" type="text" name="accountHolder"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>예금명</h5></td>
                            			<td><input class="form-control" type="text" name="accountName"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>당좌한도액</h5></td>
                            			<td><input class="form-control" type="text" name="accountLimit"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>SWIFTY 코드</h5></td>
                            			<td><input class="form-control" type="text" name="swiftCode"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            	</table>
                            	<hr>
                            	<table class="table table-striped">
                            		<tr>
                            			<td style="text-align: right;"><h5>계좌개설일</h5></td>
                            			<td><input class="form-control" type="date" placeholder="YYYY-MM-DD" name="accountOpenDate"></td>
                            			<td style="text-align: right;"><h5>거래종료일</h5></td>
                            			<td><input class="form-control" type="date" placeholder="YYYY-MM-DD" name="tradeEndDate"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>사용여부</h5></td>
                            			<td>
                            				<select class="form-control" name="useBoolean">
                                            	<option value="1">여</option>
                                            	<option value="0">부</option>
                                        	</select>
                                        </td>
                            			<td style="text-align: right;"><h5>조회 설정</h5></td>
                            			<td>
                            				<select class="form-control" name="inquiryLimit">
                                            	<option value="all">전체</option>
                                            	<option value="financial">회계</option>
                                        	</select>
                                        </td>
                            		</tr>
                            	</table>
                            	<input type="hidden" name="lastUser" value="<%= userID %>">
                        		<button class="btn btn-outline btn-primary btn-lg btn-block" type="submit">등록</button>
                            </form>
                            <form class="tab-pane fade" id="td" method="POST" action="./financialCustomRegistServelt">
                            	<input type="hidden" value="<%= companyCont.getCompanyCode() %>" name="companyCode">
                            	<br>
                            	<table class="table table-striped">
                            		<tr>
                            			<td style="text-align: right;"><h5>* 금융 거래처 코드</h5></td>
                            			<td><input class="form-control" type="text" id="tdFcCode" name="fcCode" readonly></td>
                            			<td style="text-align: right;"><h5>* 구분</h5></td>
                            			<td>
                            				<input class="form-control" type="hidden" name="division" value="td">
                            				<input class="form-control" type="text" value="정기예금" readonly>
                            			</td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>* 금융 거래처 이름</h5></td>
                            			<td><input class="form-control" id="tdFcName" type="text" name="fcName" readonly></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>계좌번호</h5></td>
                            			<td><input class="form-control" type="text" name="accountNum"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>계좌개설점</h5></td>
                            			<td><input class="form-control" type="text" name="accountBranch"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>사업자 등록번호</h5></td>
                            			<td><input class="form-control" type="text" name="businessLicenseNum"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>우편번호</h5></td>
                            			<td><input class="form-control" type="text" style="width: 50%;" maxlength="5" name="postNum" id="tdPostNum" readonly></td>
                            			<td colspan="2"><button class="btn btn-default" id="searchAddressBtnTd" type="button"><i class="fa fa-search-plus"></i></button></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>주소</h5></td>
                            			<td colspan="3"><input class="form-control" type="text" name="address" id="tdAddress" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>전화번호</h5></td>
                            			<td><input class="form-control" type="text" name="tel"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>팩스번호</h5></td>
                            			<td><input class="form-control" type="text" name="fax"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>홈페이지</h5></td>
                            			<td colspan="3"><input class="form-control" type="url" name="homepage" placeholder="https://~ or http://~"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>메일 주소</h5></td>
                            			<td colspan="2"><input class="form-control" type="email" name="email"></td>
                            			<td></td>
                            		</tr>
                            	</table>
                            	<hr>
                            	<table class="table table-striped">
                            		 <tr>
                            			<td style="text-align: right;"><h5>프로젝트</h5></td>
                            			<td><input class="form-control" id="tdProjectCode" type="text" name="projectCode" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchProjectBtnTd" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="tdProjectName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>거래처분류</h5></td>
                            			<td><input class="form-control" id="tdCustomGroup" type="text" name="customGroup" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchCustomGroupBtnTd" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="tdCustomGroupName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>금융기관코드</h5></td>
                            			<td><input class="form-control" id="tdFinancialInstitutionCode" type="text" name="financialInstitutionCode" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchFinancialInstitutionBtnTd" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="tdFinancialInstitutionName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>예금종류</h5></td>
                            			<td>
                            				<select class="form-control" name="accountDivision">
                                    			<option value="1">보통예금</option>
                                    			<option value="2">당좌예금</option>
                                    			<option value="3">외화예금</option>
                                    			<option value="4">별단예금</option>
                                    			<option value="5">정기예금</option>
                                    			<option value="6">정기적금</option>
                                    			<option value="7">신탁연금</option>
                                    			<option value="8">연금보험</option>
                                    			<option value="9">기타</option>
                                    		</select>
                            			</td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>예금주</h5></td>
                            			<td><input class="form-control" type="text" name="accountHolder"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>예금명</h5></td>
                            			<td><input class="form-control" type="text" name="accountName"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>금액</h5></td>
                            			<td><input class="form-control" type="text" name="sum" style="text-align: rihgt;"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>월수입이자</h5></td>
                            			<td><input class="form-control" type="text" name="monthlyIncomeInterest" style="text-align: rihgt;"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>계약기간</h5></td>
                            			<td><input class="form-control" type="date" placeholder="YYYY-MM-DD" name="ttoacStart"></td>
                            			<td style="text-align: right;"><h5> ~</h5></td>
                            			<td><input class="form-control" type="date" placeholder="YYYY-MM-DD" name="ttoacEnd"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>이자이체일</h5></td>
                            			<td>
                            				<div class="form-group input-group">
                                            	<input type="text" class="form-control" name="interestTransferDate">
                                            	<span class="input-group-addon">日</span>
                                        	</div>
                            			</td>
                            			<td style="text-align: right;"><h5>이자율</h5></td>
                            			<td>
                            				<div class="form-group input-group">
                                            	<input type="text" class="form-control" name="interestRatio">
                                            	<span class="input-group-addon">%</span>
                                        	</div>
                                        </td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>SWIFTY 코드</h5></td>
                            			<td><input class="form-control" type="text" name="swiftCode"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            	</table>
                            	<hr>
                            	<table class="table table-striped">
                            		<tr>
                            			<td style="text-align: right;"><h5>거래시작일</h5></td>
                            			<td><input class="form-control" type="date" placeholder="YYYY-MM-DD" name="tradeStartDate"></td>
                            			<td style="text-align: right;"><h5>만기지급일</h5></td>
                            			<td><input class="form-control" type="date" placeholder="YYYY-MM-DD" name="maturityDate"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>사용여부</h5></td>
                            			<td>
                            				<select class="form-control" name="useBoolean">
                                            	<option value="1">여</option>
                                            	<option value="0">부</option>
                                        	</select>
                                        </td>
                            			<td style="text-align: right;"><h5>조회 설정</h5></td>
                            			<td>
                            				<select class="form-control" name="inquiryLimit">
                                            	<option value="all">전체</option>
                                            	<option value="financial">회계</option>
                                        	</select>
                                        </td>
                            		</tr>
                            	</table>
                            	<input type="hidden" name="lastUser" value="<%= userID %>">
                        		<button class="btn btn-outline btn-primary btn-lg btn-block" type="submit">등록</button>
                            </form>
                            <form class="tab-pane fade" id="isd" method="POST" action="./financialCustomRegistServelt">
                            	<input type="hidden" value="<%= companyCont.getCompanyCode() %>" name="companyCode">
                            	<br>
                            	<table class="table table-striped">
                            		<tr>
                            			<td style="text-align: right;"><h5>* 금융 거래처 코드</h5></td>
                            			<td><input class="form-control" type="text" id="isdFcCode" name="fcCode" readonly></td>
                            			<td style="text-align: right;"><h5>* 구분</h5></td>
                            			<td>
                            				<input class="form-control" type="hidden" name="division" value="isd">
                            				<input class="form-control" type="text" value="정기적금" readonly>
                            			</td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>* 금융 거래처 이름</h5></td>
                            			<td><input class="form-control" id="isdFcName" type="text" name="fcName" readonly></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>계좌번호</h5></td>
                            			<td><input class="form-control" type="text" name="accountNum"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>계좌개설점</h5></td>
                            			<td><input class="form-control" type="text" name="accountBranch"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>사업자 등록번호</h5></td>
                            			<td><input class="form-control" type="text" name="businessLicenseNum"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>우편번호</h5></td>
                            			<td><input class="form-control" type="text" style="width: 50%;" maxlength="5" name="postNum" id="isdPostNum" readonly></td>
                            			<td colspan="2"><button class="btn btn-default" id="searchAddressBtnIsd" type="button"><i class="fa fa-search-plus"></i></button></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>주소</h5></td>
                            			<td colspan="3"><input class="form-control" type="text" name="address" id="isdAddress" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>전화번호</h5></td>
                            			<td><input class="form-control" type="text" name="tel"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>팩스번호</h5></td>
                            			<td><input class="form-control" type="text" name="fax"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>홈페이지</h5></td>
                            			<td colspan="3"><input class="form-control" type="url" name="homepage" placeholder="https://~ or http://~"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>메일 주소</h5></td>
                            			<td colspan="2"><input class="form-control" type="email" name="email"></td>
                            			<td></td>
                            		</tr>
                            	</table>
                            	<hr>
                            	<table class="table table-striped">
                            		 <tr>
                            			<td style="text-align: right;"><h5>프로젝트</h5></td>
                            			<td><input class="form-control" id="isdProjectCode" type="text" name="projectCode" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchProjectBtnIsd" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="isdProjectName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>거래처분류</h5></td>
                            			<td><input class="form-control" id="isdCustomGroup" type="text" name="customGroup" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchCustomGroupBtnIsd" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="isdCustomGroupName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>금융기관코드</h5></td>
                            			<td><input class="form-control" id="isdFinancialInstitutionCode" type="text" name="financialInstitutionCode" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchFinancialInstitutionBtnIsd" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="isdFinancialInstitutionName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>적금종류</h5></td>
                            			<td>
                            				<select class="form-control" name="accountDivision">
                                    			<option value="1">보통예금</option>
                                    			<option value="2">당좌예금</option>
                                    			<option value="3">외화예금</option>
                                    			<option value="4">별단예금</option>
                                    			<option value="5">정기예금</option>
                                    			<option value="6">정기적금</option>
                                    			<option value="7">신탁연금</option>
                                    			<option value="8">연금보험</option>
                                    			<option value="9">기타</option>
                                    		</select>
                            			</td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>예금주</h5></td>
                            			<td><input class="form-control" type="text" name="accountHolder"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>적금명</h5></td>
                            			<td><input class="form-control" type="text" name="accountName"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>계약금액</h5></td>
                            			<td><input class="form-control" type="text" name="contractSum" style="text-align: rihgt;"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>매회불입액</h5></td>
                            			<td><input class="form-control" type="text" name="etdSum" style="text-align: rihgt;"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>계약기간</h5></td>
                            			<td><input class="form-control" type="date" placeholder="YYYY-MM-DD" name="ttoacStart"></td>
                            			<td style="text-align: right;"><h5> ~</h5></td>
                            			<td><input class="form-control" type="date" placeholder="YYYY-MM-DD" name="ttoacEnd"></td>
                            		</tr>
                            		<tr>
                            			<td><h5 style="text-align: right;">매회납일일</h5></td>
                            			<td>
                            				<div class="form-group input-group">
                                            	<input type="text" class="form-control" name="etdDate">
                                            	<span class="input-group-addon">日</span>
                                        	</div>
                            			</td>
                            			<td><h5 style="text-align: right;">이자율</h5></td>
                            			<td>
                            				<div class="form-group input-group">
                                            	<input type="text" class="form-control" name="interestRatio">
                                            	<span class="input-group-addon">%</span>
                                        	</div>
                                        </td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>SWIFTY 코드</h5></td>
                            			<td><input class="form-control" type="text" name="swiftCode"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            	</table>
                            	<hr>
                            	<table class="table table-striped">
                            		<tr>
                            			<td style="text-align: right;"><h5>거래시작일</h5></td>
                            			<td><input class="form-control" type="date" placeholder="YYYY-MM-DD" name="tradeStartDate"></td>
                            			<td style="text-align: right;"><h5>만기지급일</h5></td>
                            			<td><input class="form-control" type="date" placeholder="YYYY-MM-DD" name="maturityDate"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>사용여부</h5></td>
                            			<td>
                            				<select class="form-control" name="useBoolean">
                                            	<option value="1">여</option>
                                            	<option value="0">부</option>
                                        	</select>
                                        </td>
                            			<td style="text-align: right;"><h5>조회 설정</h5></td>
                            			<td>
                            				<select class="form-control" name="inquiryLimit">
                                            	<option value="all">전체</option>
                                            	<option value="financial">회계</option>
                                        	</select>
                                        </td>
                            		</tr>
                            	</table>
                            	<input type="hidden" name="lastUser" value="<%= userID %>">
                        		<button class="btn btn-outline btn-primary btn-lg btn-block" type="submit">등록</button>
                            </form>
                            <form class="tab-pane fade" id="ccc" method="POST" action="./financialCustomRegistServelt">
                            	<input type="hidden" value="<%= companyCont.getCompanyCode() %>" name="companyCode">
                            	<br>
                            	<table class="table table-striped">
                            		<tr>
                            			<td style="text-align: right;"><h5>* 금융 거래처 코드</h5></td>
                            			<td><input class="form-control" type="text" id="cccFcCode" name="fcCode" readonly></td>
                            			<td style="text-align: right;"><h5>* 구분</h5></td>
                            			<td>
                            				<input class="form-control" type="hidden" name="division" value="ccc">
                            				<input class="form-control" type="text" value="카드사" readonly>
                            			</td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>* 금융 거래처 이름</h5></td>
                            			<td colspan="3"><input class="form-control" id="cccFcName" type="text" name="fcName" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>사업자 등록번호</h5></td>
                            			<td><input class="form-control" type="text" name="businessLicenseNum"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>우편번호</h5></td>
                            			<td><input class="form-control" type="text" style="width:50%;" maxlength="5" name="postNum" id="cccPostNum" readonly></td>
                            			<td colspan="2"><button class="btn btn-default" id="searchAddressBtnCcc" type="button"><i class="fa fa-search-plus"></i></button></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>주소</h5></td>
                            			<td colspan="3"><input class="form-control" type="text" name="address" id="cccAddress" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>전화번호</h5></td>
                            			<td><input class="form-control" type="text" name="tel"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>팩스번호</h5></td>
                            			<td><input class="form-control" type="text" name="fax"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>홈페이지</h5></td>
                            			<td colspan="3"><input class="form-control" type="url" name="homepage" placeholder="https://~ or http://~"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>메일 주소</h5></td>
                            			<td colspan="2"><input class="form-control" type="email" name="email"></td>
                            			<td></td>
                            		</tr>
                            	</table>
                            	<hr>
                            	<table class="table table-striped">
                            		 <tr>
                            			<td style="text-align: right;"><h5>프로젝트</h5></td>
                            			<td><input class="form-control" id="cccProjectCode" type="text" name="projectCode" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchProjectBtnCcc" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="cccProjectName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>거래처분류</h5></td>
                            			<td><input class="form-control" id="cccCustomGroup" type="text" name="customGroup" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchCustomGroupBtnCcc" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="cccCustomGroupName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>금융기관코드</h5></td>
                            			<td><input class="form-control" id="cccFinancialInstitutionCode" type="text" name="financialInstitutionCode" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchFinancialInstitutionBtnCcc" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="cccFinancialInstitutionName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>입금계좌</h5></td>
                            			<td><input class="form-control" id="cccPaymentAccount" type="text" name="paymentAccount" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchFinancialCustomBtnCcc" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="cccPaymentAccountName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>예금주</h5></td>
                            			<td><input class="form-control" type="text" name="accountHolder"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>수수료율</h5></td>
                            			<td>
                            				<div class="form-group input-group">
                                            	<input type="text" class="form-control" name="commissionRatio">
                                            	<span class="input-group-addon">%</span>
                                        	</div>
                                        </td>
                                        <td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>SWIFTY 코드</h5></td>
                            			<td><input class="form-control" type="text" name="swiftCode"></td>
                            			<td colspan="2"></td>
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
                                            	<option value="1">여</option>
                                            	<option value="0">부</option>
                                        	</select>
                                        </td>
                            			<td style="text-align: right;"><h5>조회 설정</h5></td>
                            			<td>
                            				<select class="form-control" name="inquiryLimit">
                                            	<option value="all">전체</option>
                                            	<option value="financial">회계</option>
                                        	</select>
                                        </td>
                            		</tr>
                            	</table>
                            	<input type="hidden" name="lastUser" value="<%= userID %>">
                        		<button class="btn btn-outline btn-primary btn-lg btn-block" type="submit">등록</button>
                            </form>
                            <form class="tab-pane fade" id="cd" method="POST" action="./financialCustomRegistServelt">
                            	<input type="hidden" value="<%= companyCont.getCompanyCode() %>" name="companyCode">
                            	<br>
                            	<table class="table table-striped">
                            		<tr>
                            			<td style="text-align: right;"><h5>* 금융 거래처 코드</h5></td>
                            			<td><input class="form-control" type="text" id="cdFcCode" name="fcCode" readonly></td>
                            			<td style="text-align: right;"><h5>* 구분</h5></td>
                            			<td>
                            				<input class="form-control" type="hidden" name="division" value="cd">
                            				<input class="form-control" type="text" value="신용카드" readonly>
                            			</td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>* 금융 거래처 이름</h5></td>
                            			<td><input class="form-control" id="cdFcName" type="text" name="fcName" readonly></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>카드번호</h5></td>
                            			<td><input class="form-control" type="text" name="cardNum"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>카드분류</h5></td>
                            			<td>
                            				<select class="form-control" id="cardDivision">
                                    			<option value="1">법인</option>
                                        		<option value="2">개인</option>
                                        		<option value="3">화물운전자복지카드</option>
                                        		<option value="4">사업용신용카드</option>
                                   			</select>
                            			</td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>사업자 등록번호</h5></td>
                            			<td><input class="form-control" type="text" name="businessLicenseNum"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>카드회원명</h5></td>
                            			<td><input class="form-control" type="text" name="cardMember"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>계좌개설점</h5></td>
                            			<td><input class="form-control" type="text" name="accountBranch"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>우편번호</h5></td>
                            			<td><input class="form-control" type="text" style="width: 50%;" maxlength="5" name="postNum" id="cdPostNum" readonly></td>
                            			<td colspan="2"><button class="btn btn-default" id="searchAddressBtnCd" type="button"><i class="fa fa-search-plus"></i></button></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>주소</h5></td>
                            			<td colspan="3"><input class="form-control" type="text" name="address" id="cdAddress" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>전화번호</h5></td>
                            			<td><input class="form-control" type="text" name="tel"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>팩스번호</h5></td>
                            			<td><input class="form-control" type="text" name="fax"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>홈페이지</h5></td>
                            			<td colspan="3"><input class="form-control" type="url" name="homepage" placeholder="https://~ or http://~"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>메일 주소</h5></td>
                            			<td colspan="2"><input class="form-control" type="email" name="email"></td>
                            			<td></td>
                            		</tr>
                            	</table>
                            	<hr>
                            	<table class="table table-striped">
                            		 <tr>
                            			<td style="text-align: right;"><h5>프로젝트</h5></td>
                            			<td><input class="form-control" id="cdProjectCode" type="text" name="projectCode" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchProjectBtnCd" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="cdProjectName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>거래처분류</h5></td>
                            			<td><input class="form-control" id="cdCustomGroup" type="text" name="customGroup" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchCustomGroupBtnCd" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="cdCustomGroupName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>금융기관코드</h5></td>
                            			<td><input class="form-control" id="cdFinancialInstitutionCode" type="text" name="financialInstitutionCode" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchFinancialInstitutionBtnCd" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="cdFinancialInstitutionName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>결제계좌</h5></td>
                            			<td><input class="form-control" id="cdPaymentAccount" type="text" name="paymentAccount" readonly></td>
                            			<td style="text-align: left;"><button class="btn btn-default" id="searchFinancialCustomBtnCd" type="button"><i class="fa fa-search-plus "></i></button></td>
                            			<td><input class="form-control" id="cdPaymentAccountName" type="text" readonly></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>예금주</h5></td>
                            			<td><input class="form-control" type="text" name="accountHolder"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>월 한도액</h5></td>
                            			<td><input class="form-control" type="text" name="monthlyLimitSum"></td>
                            			<td colspan="2"></td>
                            		</tr>
                            		<tr>
                            			<td style="text-align: right;"><h5>유효기간</h5></td>
                            			<td><input class="form-control" type="text" name="effectiveLife" placeholder="mm/yy"></td>
                            			<td colspan="2"></td>
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
                                            	<option value="1">여</option>
                                            	<option value="0">부</option>
                                        	</select> 
                                        </td>
                            			<td style="text-align: right;"><h5>조회 설정</h5></td>
                            			<td>
                            				<select class="form-control" name="inquiryLimit">
                                            	<option value="all">전체</option>
                                            	<option value="financial">회계</option>
                                        	</select>
                                        </td>
                            		</tr>
                            	</table>
                            	<input type="hidden" name="lastUser" value="<%= userID %>">
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
	<!-- 분류 등록 -->
	<div class="modal fade" id="insertCustomGroup" tabindex="-1" role="dialog"
		aria-labelledby="insertCustomGroupLabel" aria-hidden="true">
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
	<!-- 프로젝트 검색 -->
	<div class="modal fade" id="searchProject" tabindex="-1" role="dialog"
		aria-labelledby="searchProjectLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
		</div>
	</div>
	<!-- 거래처 분류 검색 -->
	<div class="modal fade" id="searchCustomGroup" tabindex="-1" role="dialog"
		aria-labelledby="searchCustomGroupLabel" aria-hidden="true">
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
	<!-- 금융거래처코드 검색 -->
	<div class="modal fade" id="searchFinancialCustom" tabindex="-1" role="dialog"
		aria-labelledby="searchFinancialCustomLabel" aria-hidden="true">
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