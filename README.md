# WebERP
Git - Web ERP Project (서지훈, 우상무, 임혜지, 김가민)

# WebContent

    index.jsp : 접속시 페이지
    join.jsp : 회원가입 페이지
    login.jsp : 로그인 페이지
    NewFile.jsp : jsp 기능 테스트용 페이지
  
  basicInformationManagement : 기초정보관리
  
    generalCustomerEdit.jsp : 일반거래처 수정 페이지
    generalCustomerRegist.jsp : 일반거래처 등록 페이지
    searchAccountCodeModal.jsp : 금융거래처 검색 모달
    searchAddressModal.jsp : 주소 검색 모달
    searchChargeDeptCodeModal.jsp : 담당 부서 검색 모달
    searchChargeEmployeeCodeModal.jsp : 담당 사원 검색 모달
    searchCollectCompanyModal.jsp : 수금 거래처 검색 모달
    searchCustomGradeModal.jsp : 거래처 등급 검색 모달
    searchCustomGroupModal.jsp : 거래처 분류 검색 모달
    searchCustomModal.jsp : 거래처 검색 모달
    searchFinancialInstitutionModal.jsp : 금융기관 
    searchPositionCodeModal.jsp : 직책 검색 모달
    searchProjectModal.jsp : 프로젝트 검색 모달
    searchReceiveAddressModal.jsp : 수신처 주소 검색 모달
    searchTypeModal.jsp : 업태 / 종목 검색 모달
    
  companyAdmin : 회사등록정보
  
    departmentRegist.jsp : 부서/부문 등록 페이지
    employeeRegist.jsp : 사원 등록 페이지
    fieldListModal.jsp : 업태 / 종목 선택 모달
    findDeptModal.jsp : 부문 검색 모달
    findPlaceModal.jsp : 사업장 검색 모달
    findUserModal.jsp : 유저 검색 모달
    placeRegist.jsp : 사업장 등록 페이지
    register.jsp : 회사등록 페이지
    rightsRegist.jsp : 권한등록 페이지
    settingRightModal.jsp : 권한 설정 
    
  main : 초기화면 또는 공통요소
    
    mainDashboard.jsp : 메인 페이지
    sideNav.jsp : 사이드 네비게이션 모듈
  
  css, data, dist, js, less, partials, vendor
    
    페이지 구성에 필요한 javascript, css 등등
  
  WEB-INF
  
    cos.jar : 파일 업로드를 위한 lib
    json-simple-1.1.1.jar : json을 사용하기 위한 lib
    mysql-connection-java-8.0.12.jar : database connector lib
  
  META-INF
  
    context.xml : url을 192.168.123.139/WebERP?serverTimezone=UTC 로 해서 외부 MySQL에 접속

# src

  businessType : 업태 / 업종 관련 패키지
    
    BusinessTypeGetNameServlet.java : 업태명 / 업종명을 불러오는 Servlet
    SearchTypeServlet.java : 업태 / 업종을 불러오는 Servlet
    
  company : 회사 관련 패키지
  
    CompanyFindForCustomServlet.java : 거래처 등록에서 사용하는 등록된 회사를 불러오는 Servlet
    CompanyRegisterServlet.java : 회사 등록 Servlet
    FindCompanyToCompanyCodeServlet.java : 회사코드를 사용하여 회사를 검색하는 Servlet
  
  custom : 거래처 관련 패키지
  
    CustomerGetNameServlet.java : 거래처명을 불러오는 Servlet
    CustomFindToModalServlet.java : 모달창에서 사용되는 거래처 검색 Servlet
    CustomRegistServlet.java : 거래처 등록 Servlet

  department : 부서 관련 패키지
  
    DepartmentGetListServlet.java : 부문을 조건으로 부서 리스트를 불러오는 Servlet
    DepartmentGetListToAllServlet.java : 부문에 관계없이 모든 부서 리스트를 불러오는 Servlet
    DepartmentGetNameOnlyServlet.java : 부문에 관계없이 부서명을 불러오는 Servlet
    DepartmentGetNameServlet.java : 부문을 조건으로 부서명을 불러오는 Servlet
    DepartmentRegistServlet.java : 부서 등록 Servlet
    
  employee : 사원 관련 패키지
  
    EmployeeFindToModalServlet.java : 모달창에서 사용되는 사원 검색 Servlet
    EmployeeRegistServlet.java : 사원 등록 Servlet
    
  field : 부문 관련 패키지
  
    FieldGetListServlet.java : 부문 리스트를 불러오는 Servlet
    FieldGetNameServlet.java : 부문명을 불러오는 Servlet
    FieldRegistServlet.java : 부문 등록 Servlet
    
  financialInstitution : 금융기관 관련 패키지
  
    FinancialInstitutionFindServlet.java : 금융기관 검색 Servlet
    FinancialInstitutionFindToCodeServlet.java : 금융기관 코드를 사용한 금융기관 검색 Servlet
    
  placebusiness : 사업장 관련 패키지
  
    PlaceBusinessGetNameServlet.java : 사업장명 검색 Servlet
    PlaceBusinessRegisterServlet.java : 사업장 등록 Servlet
    
  position : 직책 관련 패키지
  
  rights : 권한 관련 패키지
  
  rightsrelation : 사원과 권한의 관계 관련 패키지
  
    RightsRegistServlet : 사원과 권환의 관계 등록 Servlet
    
  user : 사용자 관련 패키지
  
    UserFindToIDServlet.java : ID를 사용한 사용자 검색 Servlet
    UserFindToNameServlet.java : 사용자 이름을 사용한 사용자 검색 Servlet
    UserIdCheckServlet.java : ID 중복확인용 Serlvet
    UserJoinSerlvet.java : 회원가입 Servlet
    UserLoginServlet.java : 로그인 Servlet
# page_for_study
HTML 및 Project 화면 구성 





# formReference
자주 사용하는 소스코드 
