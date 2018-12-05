<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link href="../css/table.css" rel="stylesheet">
<div class="navbar-default sidebar" role="navigation">
	<div class="sidebar-nav navbar-collapse">
		<ul class="nav" id="side-menu">
			<li class="sidebar-search">
				<div class="input-group custom-search-form">
					<input type="text" class="form-control" placeholder="Search...">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button">
							<i class="fa fa-search"></i>
						</button>
					</span>
				</div> <!-- /input-group -->
			</li>
			<li><a href="../main/mainDashboard.jsp"><i class="fa fa-dashboard fa-fw"></i>
					대시보드</a></li>
			<li><a href="#"><i class="fa fa-star fa-fw"></i> 즐겨찾기<span
					class="fa arrow"></span></a>
				<ul class="nav nav-second-level">
					<li><a href="#">1</a></li>
					<li><a href="#">2</a></li>
				</ul> <!-- /.nav-second-level --></li>
			<li><a href="#"><i class="fa fa-gears fa-fw"></i> 시스템관리<span
					class="fa arrow"></span></a>
				<ul class="nav nav-second-level">
					<li><a href="#"><i class="fa fa-building fa-fw"></i>
							회사등록정보<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="../companyAdmin/register.jsp">회사등록</a></li>
							<li><a href="../companyAdmin/placeRegist.jsp">사업장등록</a></li>
							<li><a href="../companyAdmin/departmentRegist.jsp">부서등록</a></li>
							<li><a href="../companyAdmin/employeeRegist.jsp">사원등록</a></li>
							<li><a href="../companyAdmin/rightsRegist.jsp">권한등록</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-columns fa-fw"></i> 기초정보관리<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="../basisInformationManagement/generalCustomerRegist.jsp">일반거래처등록</a></li>
							<li><a href="#">금융거래처등록</a></li>
							<li><a href="#">품목군등록</a></li>
							<li><a href="#">품목등록</a></li>
							<li><a href="#">창고/공정(생산)/외주공정등록</a></li>
							<li><a href="#">프로젝트등록</a></li>
							<li><a href="#">관리내역관리</a></li>
							<li><a href="#">회계연결계정과목등록</a></li>
							<li><a href="#">물류관리내역등록</a></li>
							<li><a href="#">물류담당자코드등록</a></li>
							<li><a href="#">물류실적(품목/고객)담당자등록</a></li>
							<li><a href="#">붐목분류(대/중/소)등록</a></li>
							<li><a href="#">검사유형등록</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-share-square-o fa-fw"></i>
							초기이월관리<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">회계초기이월등록</a></li>
							<li><a href="#">재고이월등록</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-sign-out fa-fw"></i>
							마감/데이터관리<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">영업마감/통제등록</a></li>
							<li><a href="#">자재마감/통제등록</a></li>
							<li><a href="#">마감및년도이월</a></li>
						</ul> <!-- /.nav-third-level --></li>
				</ul></li>
			<li><a href="#"><i class="fa fa-briefcase fa-fw"></i> 영업관리<span
					class="fa arrow"></span></a>
				<ul class="nav nav-second-level">
					<li><a href="#"><i class="fa fa-briefcase fa-fw"></i> 영업관리<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">판매계획등록</a></li>
							<li><a href="#">견적등록</a></li>
							<li><a href="#">수주등록</a></li>
							<li><a href="#">수주등록(유상사급)</a></li>
							<li><a href="#">출고의뢰등록</a></li>
							<li><a href="#">출고검사등록</a></li>
							<li><a href="#">출고처리(국내수주)</a></li>
							<li><a href="#">거래명세서발행</a></li>
							<li><a href="#">매출마감(국내거래)</a></li>
							<li><a href="#">세금계산서처리</a></li>
							<li><a href="#">회계처리(매출마감)</a></li>
							<li><a href="#">수금등록</a></li>
							<li><a href="#">회계처리(수금)</a></li>
							<li><a href="#">수주마감처리</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-list-ul fa-fw"></i> 영업현황<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">판매계획현황</a></li>
							<li><a href="#">팡매계획대비출고현황</a></li>
							<li><a href="#">견적현황</a></li>
							<li><a href="#">견적대비수주현황</a></li>
							<li><a href="#">수주현황</a></li>
							<li><a href="#">수주대비출고현황</a></li>
							<li><a href="#">수주미납현황</a></li>
							<li><a href="#">출고현황</a></li>
							<li><a href="#">출고반품현황</a></li>
							<li><a href="#">매출마감현황</a></li>
							<li><a href="#">매출미마감현황</a></li>
							<li><a href="#">세금계산서발행대장</a></li>
							<li><a href="#">수금현황</a></li>
							<li><a href="#">받을어음현황</a></li>
							<li><a href="#">미수채권집계</a></li>
							<li><a href="#">미수채권상세현황</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-bar-chart-o fa-fw"></i>
							영업분석<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">수주미납집계</a></li>
							<li><a href="#">출고실적집계표(월별)</a></li>
							<li><a href="#">매출현황(부서별)</a></li>
							<li><a href="#">매출집계표(월별)</a></li>
							<li><a href="#">매출집계표(관리분류별)</a></li>
							<li><a href="#">매출순위표(마감기준)</a></li>
							<li><a href="#">매출채권회전율</a></li>
							<li><a href="#">추정매출원가보고서</a></li>
							<li><a href="#">미수채권연령분석표</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-columns fa-fw"></i> 기초정보관리<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">품목단가등록</a></li>
							<li><a href="#">고객별단가등록</a></li>
							<li><a href="#">납품처등록</a></li>
							<li><a href="#">채권기초/이월/조정(출고기준)</a></li>
						</ul> <!-- /.nav-third-level --></li>
				</ul></li>
			<li><a href="#"><i class="fa fa-truck fa-fw"></i> 구매/자재관리<span
					class="fa arrow"></span></a>
				<ul class="nav nav-second-level">
					<li><a href="#"><i class="fa fa-shopping-cart fa-fw"></i>
							구매관리<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">주계획작성(MPS)</a></li>
							<li><a href="#">수요량전개(MRP)</a></li>
							<li><a href="#">청구등록</a></li>
							<li><a href="#">발주등록</a></li>
							<li><a href="#">입고의뢰등록</a></li>
							<li><a href="#">입고검사등록</a></li>
							<li><a href="#">입고처리(국내발주)</a></li>
							<li><a href="#">매입마감(국내거래)</a></li>
							<li><a href="#">회계처리(매입마감)</a></li>
							<li><a href="#">발주마감처리</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-list-ul fa-fw"></i> 구매현황<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">소요량전개현황</a></li>
							<li><a href="#">청구현황</a></li>
							<li><a href="#">발주현황</a></li>
							<li><a href="#">발주대비입고현황</a></li>
							<li><a href="#">발주미납현황</a></li>
							<li><a href="#">입고현황</a></li>
							<li><a href="#">매입마감현황</a></li>
							<li><a href="#">매입미마감현황</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-bar-chart-o fa-fw"></i>
							구매분석<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">발주미납집계</a></li>
							<li><a href="#">입고집계표(월별)</a></li>
							<li><a href="#">매입집계표(월별)</a></li>
							<li><a href="#">매입집계표(관리분류별)</a></li>
							<li><a href="#">매입순위표(마감기준)</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-cubes fa-fw"></i> 재고관리<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">재고이동등록(창고)</a></li>
							<li><a href="#">재고이동등록(사업장)</a></li>
							<li><a href="#">재고실사등록</a></li>
							<li><a href="#">기초재고/재고조정등록</a></li>
							<li><a href="#">재고이동현황(창고)</a></li>
							<li><a href="#">재고이동현황(사업장)</a></li>
							<li><a href="#">재고실사현황</a></li>
							<li><a href="#">기초재고/재고조정현황</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-list-ul fa-fw"></i> 재고수불현황<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">현재고현황(전사/사업장)</a></li>
							<li><a href="#">재고수불현황(일자별)</a></li>
							<li><a href="#">재고수불현황(유형별)</a></li>
							<li><a href="#">재고수불상세현황(일자별)</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-file-text-o fa-fw"></i>
							재고평가<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">생산품표준원가등록</a></li>
							<li><a href="#">재고평가작업</a></li>
							<li><a href="#">재고평가보고서</a></li>
							<li><a href="#">재고자산명세서</a></li>
							<li><a href="#">재고자산수불부</a></li>
							<li><a href="#">대체출고내역현황</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-columns fa-fw"></i> 기초정보관리<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">품목단가등록</a></li>
							<li><a href="#">거래처별단가등록</a></li>
						</ul> <!-- /.nav-third-level --></li>
				</ul></li>
			<li><a href="#"><i class="fa fa-anchor fa-fw"></i> 무역관리<span
					class="fa arrow"></span></a>
				<ul class="nav nav-second-level">
					<li><a href="#"><i class="fa fa-paste fa-fw"></i>
							구매승인서(수출)<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">L/C등록</a></li>
							<li><a href="#">출고의뢰등록</a></li>
							<li><a href="#">출고검사등록</a></li>
							<li><a href="#">출고처리(L/C)</a></li>
							<li><a href="#">거래명세서발행</a></li>
							<li><a href="#">매출마감(LOCAL L/C)</a></li>
							<li><a href="#">세금계산서처리(LOCAL L/C)</a></li>
							<li><a href="#">회계처리(매출마감)</a></li>
							<li><a href="#">수금등록</a></li>
							<li><a href="#">회계처리(수금)</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-file-text-o fa-fw"></i>
							LOCAL L/C(수출)<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">L/C등록</a></li>
							<li><a href="#">출고의뢰등록</a></li>
							<li><a href="#">출고검사등록</a></li>
							<li><a href="#">출고처리(L/C)</a></li>
							<li><a href="#">거래명세서발행</a></li>
							<li><a href="#">매출마감(LOCAL L/C)</a></li>
							<li><a href="#">세금계산서처리(LOCAL L/C)</a></li>
							<li><a href="#">회계처리(매출마감)</a></li>
							<li><a href="#">NEGO등록</a></li>
							<li><a href="#">회계처리(NEGO)</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-file-text-o fa-fw"></i>
							MASTER L/C(수출)<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">L/C등록</a></li>
							<li><a href="#">출고의뢰등록</a></li>
							<li><a href="#">출고검사등록</a></li>
							<li><a href="#">출고처리(L/C)</a></li>
							<li><a href="#">COMMERCIAL INVOICE 등록</a></li>
							<li><a href="#">PACKING LIST 등록</a></li>
							<li><a href="#">선적등록</a></li>
							<li><a href="#">회계처리(선적)</a></li>
							<li><a href="#">NEGO등록</a></li>
							<li><a href="#">회계처리(NEGO)</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-ellipsis-h fa-fw"></i>
							기타(수출)<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">해외수주등록</a></li>
							<li><a href="#">출고의뢰등록</a></li>
							<li><a href="#">출고검사등록</a></li>
							<li><a href="#">출고처리(해외수주)</a></li>
							<li><a href="#">COMMERCIAL INVOICE 등록</a></li>
							<li><a href="#">PACKING LIST 등록</a></li>
							<li><a href="#">선적등록</a></li>
							<li><a href="#">회계처리(선적)</a></li>
							<li><a href="#">NEGO등록</a></li>
							<li><a href="#">회계처리(NEGO)</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-list fa-fw"></i> 수출현황<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">해외수주현황</a></li>
							<li><a href="#">선적현황</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-paste fa-fw"></i>
							구매승인서(수입)<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">L/C개설</a></li>
							<li><a href="#">입고의뢰등록</a></li>
							<li><a href="#">입고검사등록</a></li>
							<li><a href="#">입고처리(L/C)</a></li>
							<li><a href="#">매입등록(LOCAL L/C)</a></li>
							<li><a href="#">회계처리(매입마감)</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-file-text-o fa-fw"></i>
							LOCAL L/C(수입)<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">L/C개설</a></li>
							<li><a href="#">입고의뢰등록</a></li>
							<li><a href="#">입고검사등록</a></li>
							<li><a href="#">입고처리(L/C)</a></li>
							<li><a href="#">매입등록(LOCAL L/C)</a></li>
							<li><a href="#">회계처리(매입마감)</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-file-text-o fa-fw"></i>
							MASTER L/C(수입)<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">L/C개설</a></li>
							<li><a href="#">B/L접수</a></li>
							<li><a href="#">수입제비용등록</a></li>
							<li><a href="#">입고의뢰등록</a></li>
							<li><a href="#">입고검사등록</a></li>
							<li><a href="#">입고처리(L/C)</a></li>
							<li><a href="#">미착품원가정산</a></li>
							<li><a href="#">회계처리(매입마감)</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-ellipsis-h fa-fw"></i>
							기타(수입)<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">해외발주등록</a></li>
							<li><a href="#">B/L접수</a></li>
							<li><a href="#">수입제비용등록</a></li>
							<li><a href="#">입고의뢰등록</a></li>
							<li><a href="#">입고검사등록</a></li>
							<li><a href="#">입고처리(해외발주)</a></li>
							<li><a href="#">미착품원가정산</a></li>
							<li><a href="#">회계처리(매입마감)</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-list fa-fw"></i> 수입현황<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">L/C개설및해외발주현황</a></li>
							<li><a href="#">수입선적현황</a></li>
							<li><a href="#">미착품원가정산현황</a></li>
							<li><a href="#">품목별배부현황</a></li>
							<li><a href="#">B/L결제예정일별조회</a></li>
							<li><a href="#">수입진행현황</a></li>
						</ul> <!-- /.nav-third-level --></li>
				</ul></li>
			<li><a href="#"><i class="fa fa-legal fa-fw"></i> 생산관리공통<span
					class="fa arrow"></span></a>
				<ul class="nav nav-second-level">
					<li><a href="#"><i class="fa fa-legal fa-fw"></i> 생산관리<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">생산계획등록</a></li>
							<li><a href="#">작업지시등록</a></li>
							<li><a href="#">작업지시확정</a></li>
							<li><a href="#">생산자재출고</a></li>
							<li><a href="#">작업실적등록</a></li>
							<li><a href="#">생산자재사용등록</a></li>
							<li><a href="#">생산실적검사</a></li>
							<li><a href="#">생산품창고입고처리</a></li>
							<li><a href="#">작업지시마감처리</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-expand fa-fw"></i> 외주관리<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">외주발주등록</a></li>
							<li><a href="#">외주발주확정</a></li>
							<li><a href="#">외주자재출고</a></li>
							<li><a href="#">외주실적등록</a></li>
							<li><a href="#">외주자재사용등록</a></li>
							<li><a href="#">외주실적검사</a></li>
							<li><a href="#">외주마감</a></li>
							<li><a href="#">회계처리(외주마감)</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-filter fa-fw"></i> 재공관리<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">기초재공등록</a></li>
							<li><a href="#">재공창고입고/이동/조정등록</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-list fa-fw"></i>
							생산/외주/재공현황<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">작업지시/외주발주 현황</a></li>
							<li><a href="#">수주대비지시현황</a></li>
							<li><a href="#">청구대비지시현황</a></li>
							<li><a href="#">실적현황</a></li>
							<li><a href="#">실적대비입고현황</a></li>
							<li><a href="#">자재사용현황(작업별)</a></li>
							<li><a href="#">자재사용현황(제품별)</a></li>
							<li><a href="#">생산일보</a></li>
							<li><a href="#">생산월보</a></li>
							<li><a href="#">현재공현황(전사/사업장)</a></li>
							<li><a href="#">현재공현황(공정/작업장)</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-columns fa-fw"></i> 기초정보관리<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">BOM등록</a></li>
							<li><a href="#">BOM정전개</a></li>
							<li><a href="#">BOM역전개</a></li>
							<li><a href="#">외주단가등록</a></li>
							<li><a href="#">불량유형등록</a></li>
						</ul> <!-- /.nav-third-level --></li>
				</ul></li>
			<li><a href="#"><i class="fa fa-group fa-fw"></i> 인사/급여관리<span
					class="fa arrow"></span></a>
				<ul class="nav nav-second-level">
					<li><a href="#"><i class="fa fa-wrench fa-fw"></i> 기초환경설정<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">소득/세액공제환경설정</a></li>
							<li><a href="#">호봉테이블등록</a></li>
							<li><a href="#">급/상여지급일자등록</a></li>
							<li><a href="#">지급공제항목등록</a></li>
							<li><a href="#">사회보험환경설정</a></li>
							<li><a href="#">인사/급여환경설정</a></li>
							<li><a href="#">인사기초코드등록</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-group fa-fw"></i> 인사관리<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">인사정보등록</a></li>
							<li><a href="#">인사기록카드</a></li>
							<li><a href="#">인사기록카드2</a></li>
							<li><a href="#">인사발령등록</a></li>
							<li><a href="#">인사발령(사원별)</a></li>
							<li><a href="#">인사발령공고</a></li>
							<li><a href="#">인사발령리포트</a></li>
							<li><a href="#">사원정보현황</a></li>
							<li><a href="#">인사고과/상벌현황</a></li>
							<li><a href="#">사원입퇴사현황</a></li>
							<li><a href="#">책정임금현황</a></li>
							<li><a href="#">근속년수현황</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-dollar fa-fw"></i> 급여관리<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">근태결과입력</a></li>
							<li><a href="#">상용직급여입력및계산</a></li>
							<li><a href="#">급여대장</a></li>
							<li><a href="#">급여명세</a></li>
							<li><a href="#">급/상여이체현황</a></li>
							<li><a href="#">사원별 급/상여변동현황</a></li>
							<li><a href="#">급/상여증감현황</a></li>
							<li><a href="#">연간급여관리</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-plus-square fa-fw"></i>
							사회보험관리<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">사회보험취득관리</a></li>
							<li><a href="#">사회보험상실관리</a></li>
							<li><a href="#">자격취득신고서</a></li>
							<li><a href="#">자격상실신고서</a></li>
							<li><a href="#">고용보험이직확인서</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-history fa-fw"></i> 연말정산관리<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">연말정산자료입력</a></li>
							<li><a href="#">연말정산현황</a></li>
							<li><a href="#">근로소득원천징수부</a></li>
							<li><a href="#">근로소득원천징수영수증</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-gift fa-fw"></i> 퇴직정산관리<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">퇴직기준설정</a></li>
							<li><a href="#">퇴직금산정</a></li>
							<li><a href="#">퇴직소득원천징수영수증</a></li>
							<li><a href="#">퇴직금추계액</a></li>
							<li><a href="#">퇴직금산정현황</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-paste fa-fw"></i> 세무관리<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">원천징수이행상황보고서</a></li>
							<li><a href="#">지방소득세특별징수명세/납부서</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-paste fa-fw"></i> 전표관리<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">계정과목설정</a></li>
							<li><a href="#">소득자별계정유형설정</a></li>
							<li><a href="#">전표집계및생성</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-user fa-fw"></i> 일용직관리<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">일용직사원등록</a></li>
							<li><a href="#">일용직급여지급일자등록</a></li>
							<li><a href="#">일용직급여입력및계산</a></li>
						</ul> <!-- /.nav-third-level --></li>
				</ul></li>
			<li><a href="#"><i class="fa fa-won fa-fw"></i> 회계관리<span
					class="fa arrow"></span></a>
				<ul class="nav nav-second-level">
					<li><a href="#"><i class="fa fa-file fa-fw"></i> 전표/장부관리<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">전표입력</a></li>
							<li><a href="#">전표승인해제</a></li>
							<li><a href="#">전표출력</a></li>
							<li><a href="#">분개장</a></li>
							<li><a href="#">일월계표</a></li>
							<li><a href="#">총계정원장</a></li>
							<li><a href="#">현금출납장</a></li>
							<li><a href="#">계정별원장</a></li>
							<li><a href="#">거래처원장</a></li>
							<li><a href="#">관리항목원장</a></li>
							<li><a href="#">관리내역현황</a></li>
							<li><a href="#">매입매출장</a></li>
							<li><a href="#">기간비용현황</a></li>
							<li><a href="#">외화명세서</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-stack-overflow fa-fw"></i>
							결산/재무제표관리<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">결산자료입력</a></li>
							<li><a href="#">합계잔액시산표</a></li>
							<li><a href="#">재무상태표</a></li>
							<li><a href="#">손익계산서</a></li>
							<li><a href="#">원가보고서</a></li>
							<li><a href="#">이익잉여금처분계산서</a></li>
							<li><a href="#">기간별손익계산서</a></li>
							<li><a href="#">관리항목별손익계산서</a></li>
							<li><a href="#">기간별원가보고서</a></li>
							<li><a href="#">관리항목별원가보고서</a></li>
							<li><a href="#">현금흐름표</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-road fa-fw"></i> 자금관리<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">일자별자금계획입력</a></li>
							<li><a href="#">자금계획일정</a></li>
							<li><a href="#">자금현항</a></li>
							<li><a href="#">자금일보</a></li>
							<li><a href="#">자금입출력내역</a></li>
							<li><a href="#">예적금현황</a></li>
							<li><a href="#">받을어음명세서</a></li>
							<li><a href="#">지급어음명세서</a></li>
							<li><a href="#">유가증권명세서</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-forward fa-fw"></i> 예산관리<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">예산신청입력</a></li>
							<li><a href="#">예산편성입력</a></li>
							<li><a href="#">예산조정입력</a></li>
							<li><a href="#">예실대비현황</a></li>
							<li><a href="#">예산실적현황</a></li>
							<li><a href="#">예산초과현황</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-building-o fa-fw"></i>
							고정자산관리<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">고정자산등록</a></li>
							<li><a href="#">감가상각비현황</a></li>
							<li><a href="#">고정자산명세서</a></li>
							<li><a href="#">고정자산변동현황</a></li>
							<li><a href="#">고정자산관리대장</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-plus fa-fw"></i> 부가가치세관리<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">부가세신고서</a></li>
							<li><a href="#">세금계산서합계표</a></li>
							<li><a href="#">계산서합계표</a></li>
							<li><a href="#">신용카드발행집계표/수취명세서</a></li>
							<li><a href="#">매입세액불공제내역</a></li>
							<li><a href="#">건물등감가상각자산취득명세서</a></li>
							<li><a href="#">수출실적명세서</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-columns fa-fw"></i> 기초정보관리<span
							class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">계정과목등록</a></li>
						</ul> <!-- /.nav-third-level --></li>
					<li><a href="#"><i class="fa fa-credit-card fa-fw"></i>
							금융CMS연동관리<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#">계좌번호등록</a></li>
							<li><a href="#">카드번호등록</a></li>
							<li><a href="#">계좌거래조회/전표발행</a></li>
							<li><a href="#">카드승인조회/전표발행</a></li>
							<li><a href="#">카드청구조회/전표발행</a></li>
						</ul> <!-- /.nav-third-level --></li>
				</ul></li>
			<li><a href="#"><i class="fa fa-money fa-fw"></i> 원가관리<span
					class="fa arrow"></span></a>
				<ul class="nav nav-second-level">
					<li><a href="#">원가계산차수등록</a></li>
					<li><a href="#">원가요소등록</a></li>
					<li><a href="#">가공비집계</a></li>
					<li><a href="#">원가요소배부기준등록</a></li>
					<li><a href="#">재료비원가계산</a></li>
					<li><a href="#">장기재료비분석</a></li>
					<li><a href="#">당기외주가공비분석</a></li>
					<li><a href="#">당기제조원가분석</a></li>
					<li><a href="#">단위별매출원가추이분석</a></li>
				</ul> <!-- /.nav-second-level --></li>
		</ul>
	</div>
	<!-- /.sidebar-collapse -->
</div>
<!-- /.navbar-static-side -->