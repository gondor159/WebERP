<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 상단 네비게이션 -->
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse"
			data-target=".navbar-collapse">
			<span class="sr-only">WebERP</span> <span
				class="icon-bar"></span> <span class="icon-bar"></span> <span
				class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="../main/mainDashboard.jsp">WebERP</a>
	</div>
	<!-- /.네비게이션 버튼 -->
	<ul class="nav navbar-top-links navbar-right">
		<li class="dropdown">
			<a class="dropdown-toggle" data-toggle="dropdown" href="#"> 
				<i class="fa fa-envelope fa-fw"></i>
				<i class="fa fa-caret-down"></i>
			</a>
			<ul class="dropdown-menu dropdown-messages">
				<li>
					<a href="#">
						<div>
							<strong>보낸사람 이름</strong>
							<span class="pull-right text-muted">
								<em>날짜</em>
							</span>
						</div>
						<div>간략한 내용</div>
					</a>
				</li>
				<li class="divider"></li>
				<li>
					<a class="text-center" href="#">
						<strong>Read All Messages</strong>
						<i class="fa fa-angle-right"></i>
					</a>
				</li>
			</ul>
		</li>
		<!-- /.메시지 파트 -->
		<li class="dropdown">
			<a class="dropdown-toggle"	data-toggle="dropdown" href="#"> 
				<i class="fa fa-tasks fa-fw"></i>
				<i class="fa fa-caret-down"></i>
			</a>
			<ul class="dropdown-menu dropdown-tasks">
				<li>
					<a href="#">
						<div>
							<p>
								<strong>작업명</strong>
								<span class="pull-right text-muted">40% Complete</span>
							</p>
							<div class="progress progress-striped active">
								<div class="progress-bar progress-bar-success"
									role="progressbar" aria-valuenow="40" aria-valuemin="0"
									aria-valuemax="100" style="width: 40%">
										<!-- now 현재 값, min 최소값, max 최대값, success/info/warning/danger  -->
									<span class="sr-only">40% Complete (success)</span>
								</div>
							</div>
						</div>
					</a>
				</li>
				<li class="divider"></li>
				<li>
					<a class="text-center" href="#">
						<strong>See All Tasks</strong>
						<i class="fa fa-angle-right"></i>
					</a>
				</li>
			</ul> 
		</li>
		<!-- /.작업진행 -->	
		<li class="dropdown">
			<a class="dropdown-toggle" data-toggle="dropdown" href="#">
				<i class="fa fa-bell fa-fw"></i>
				<i class="fa fa-caret-down"></i>
			</a>
			<ul class="dropdown-menu dropdown-alerts">
				<li>
					<a href="#">
						<div>
							<i class="fa fa-comment fa-fw"></i>
							새로운 메세지
							<span class="pull-right text-muted small"> 몇분전 </span>
						</div>
					</a>
				</li>
				<li class="divider"></li>
				<li>
					<a href="#">
						<div>
							<i class="fa fa-envelope fa-fw"></i>
							메세지 보내기 
							<span class="pull-right text-muted small">몇분전</span>
						</div>
					</a>
				</li>
				<li class="divider"></li>
				<li>
					<a href="#">
						<div>
							<i class="fa fa-tasks fa-fw"></i>
							새로운 작업 
							<span class="pull-right text-muted small">몇분전</span>
						</div>
					</a>
				</li>
				<li class="divider"></li>
				<li>
					<a href="#">
						<div>
							<i class="fa fa-upload fa-fw"></i>
							서버 재시작 시간
							<span class="pull-right text-muted small">몇분전</span>
						</div>
					</a>
				</li>
				<li class="divider"></li>
				<li>
					<a class="text-center" href="#">
						<strong>See All Alerts</strong>
						<i class="fa fa-angle-right"></i>
					</a>
				</li>
			</ul> 
		</li>
		<!-- /.알림 -->
		<li class="dropdown">
			<a class="dropdown-toggle" data-toggle="dropdown" href="#">
				<i class="fa fa-user fa-fw"></i>
				<i class="fa fa-caret-down"></i>
			</a>
			<ul class="dropdown-menu dropdown-user">
				<li>
					<a href="#">
						<i class="fa fa-user fa-fw"></i>
						User Profile
					</a>
				</li>
				<li>
					<a href="#">
						<i class="fa fa-gear fa-fw"></i>
						Settings
					</a>
				</li>
				<li class="divider"></li>
				<li>
					<a href="./logout.jsp">
						<i class="fa fa-sign-out fa-fw"></i>
						Logout
					</a>
				</li>
			</ul>
		</li>
		<!-- /.마이페이지 -->
	</ul>