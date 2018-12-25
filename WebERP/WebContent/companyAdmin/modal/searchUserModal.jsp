<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="user.UserDTO" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>  
$(document).ready(function(){
    $('#findIDButton').click(function(){
    	$("#resultFindID").empty();
    	var userID = $('#findUserID').val();
      $.ajax({
    	  type : 'GET',
    	  url : './userFindToIDServlet',
    	  data : {
    		  userID: userID
    	  },
    	  success : function(data) {
			  if(data == "") {
				  $('#resultFindID').append('');
			  } else {
			  	var parsed = JSON.parse(data);
			 	var result = parsed.result;
			  	$('#resultFindID').append('<table class="table table-striped table-bordered table-hover">' +
			  	'<thead><tr><td>선택</td><td>아이디</td><td>이름</td><td>생년월일</td><td>전화번호</td></tr></thead><tbody id="resultFindIDTbody">');
			  	$('#resultFindIDTbody').append('<tr><td><input type="radio" name="selectUser" value="' + result[0].value + '"></td>' +
			  			'<td>' + result[0].value + '</td>' +
			  			'<td>' + result[1].value + '</td>' +
			  			'<td>' + result[2].value + '</td>' +
			  			'<td>' + result[3].value + '</td></tr></tbody></table>');
			  }
    	  }
      });
    })
     $('#findNameButton').click(function(){
    	$("#resultFindName").empty();
    	var userName = $('#findUserName').val();
      $.ajax({
    	  type : 'GET',
    	  url : './userFindToNameServlet',
    	  data : {
    		  userName: userName
    	  },
    	  success : function(data) {
			  if(data == "") {
				  $('#resultFindName').append('');
			  } else {
			  	var parsed = JSON.parse(data);
			 	var result = parsed.result;
			  	$('#resultFindName').append('<table class="table table-striped table-bordered table-hover">' +
					  	'<thead><tr><td>선택</td><td>아이디</td><td>이름</td><td>생년월일</td><td>전화번호</td></tr></thead><tbody id="resultFindNameTbody">');
			  	for(var i = 0; i < result.length; i++) {
			  		$('#resultFindNameTbody').append('<tr><td style="text-align: center;"><input type="radio" name="selectUser" value="' + result[i][0].value + '"></td>' +
		  			'<td>' + result[i][0].value + '</td>' +
		  			'<td>' + result[i][1].value + '</td>' +
		  			'<td>' + result[i][2].value + '</td>' +
		  			'<td>' + result[i][3].value + '</td></tr>');
			  	}
			  	$('#resultFindName').append('</tbody></table>');
			  }
    	  }
      });
    })
});
</script>
</head>
<body>
<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="serchFieldLabel">유저검색</h4>
	</div>
	<div class="modal-body">
		<div class="panel panel-default">
            <div class="panel-body">
            	<!-- Nav tabs -->
                <ul class="nav nav-tabs">
                	<li class="active"><a href="#toID" data-toggle="tab">아이디로 찾기</a>
                    </li>
                    <li><a href="#toName" data-toggle="tab">이름으로 찾기</a>
                    </li>
                </ul>
                <!-- Tab panes -->
                <div class="tab-content">
                	<!-- 아이디로 찾기 -->
                	<div class="tab-pane fade in active" id="toID">
                		<br>
                    	<div class="form-group input-group">
							<input type="text" class="form-control" type="text" id="findUserID" name="findUserID">
							<span class="input-group-btn">
								<button class="btn btn-default" type="button" id="findIDButton">
									<i class="fa fa-search"></i>
								</button>
							</span>
						</div>
						<div id="resultFindID">
						</div>
                    </div>
                    <!-- /.아이디로 찾기 -->
                    <!-- 이름으로 찾기 -->
               		<div class="tab-pane fade" id="toName">
                    	<br>
                    	<div class="form-group input-group">
							<input type="text" class="form-control" type="text" id="findUserName" name="findUserName">
							<span class="input-group-btn">
								<button class="btn btn-default" type="button" id="findNameButton">
									<i class="fa fa-search"></i>
								</button>
							</span>
						</div>
						<div id="resultFindName">
						</div>
                    </div>
                    <!-- /.이름으로 찾기 -->
            	</div>
            </div>
        	<!-- /.panel-body -->
        </div>
    	<!-- /.panel -->
    </div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="insertUserID();">확인</button> <!-- 팝업 처리처럼 똑같이 -->
	</div>
</body>
</html>