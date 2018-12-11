<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="searchCustomGradeLabel">거래처 등급 검색</h4>
	</div>
	<div class="modal-body">
		<div class="panel panel-default">
			<div class="row" style="margin-top: 10px; margin-bottom: 10px;">
				<div class="col-md-1">
				</div>
				<div class="col-md-8">
					<input id="customGradeSearchInput" type="text"
						style="width: 100%; height: 34px;">
				</div>
				<div class="col-md-1">
					<button class="btn btn-default" type="button"
						onclick="searchCustomGrade();">
						<i class="fa fa-search-plus "></i>
					</button>
				</div>
				<div class="col-md-2"><button class="btn btn-default" onclick="">추가</button></div>
			</div>
			<div id="tableCustomGradeResult"></div>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		<button type="button" class="btn btn-primary"
			onclick="" data-dismiss="modal">확인</button>
	</div>
</body>
</html>