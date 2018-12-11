package customer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CustomerDAO {
	DataSource dataSource;

	public CustomerDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/studioour");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/* 거래처 등록 */
	public int registCustom(String companyCode, String customCode, String division, String customerName, String businessLicenseNum, 
			String chiefName, String postNum, String address, String tel, String fax, String businessCondition, String businessType, 
			String homepage, String monetaryUnit, String project, String customGroup, String customGrade, String collectCompany, 
			String tradeStartDate, String tradeEndDate, String useBoolean, String tradeForm, String discountRate, String contractSum, 
			String paymentCondition, String loanLimit, String limitReturnDate, String financialInstitution, String branchName, 
			String accountNum, String accountHolder, String payDueDate, String accountCode, String collectionDueDate, String chargeFieldCode, String chargeDeptCode, 
			String positionCode, String chargeTask, String chargeEmployeeCode, String employeeExtension, String chargeNote, String receivePostNum, 
			String receiveAddress, String receiveTel, String receiveFax, String lastSetting) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO CUSTOMER VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, customCode);
			pstmt.setString(3, division);
			pstmt.setString(4, customerName);
			pstmt.setString(5, businessLicenseNum);
			pstmt.setString(6, chiefName);
			pstmt.setString(7, postNum);
			pstmt.setString(8, address);
			pstmt.setString(9, tel);
			pstmt.setString(10, fax);
			pstmt.setString(11, businessCondition);
			pstmt.setString(12, businessType);
			pstmt.setString(13, homepage);
			pstmt.setString(14, monetaryUnit);
			pstmt.setString(15, project);
			pstmt.setString(16, customGroup);
			pstmt.setString(17, customGrade);
			pstmt.setString(18, collectCompany);
			pstmt.setString(19, tradeStartDate);
			pstmt.setString(20, tradeEndDate);
			pstmt.setString(21, useBoolean);
			pstmt.setString(22, tradeForm);
			pstmt.setDouble(23, Double.parseDouble(discountRate));
			pstmt.setString(24, contractSum);
			pstmt.setString(25, paymentCondition);
			pstmt.setString(26, loanLimit);
			pstmt.setInt(27, Integer.parseInt(limitReturnDate));
			pstmt.setString(28, financialInstitution);
			pstmt.setString(29, branchName);
			pstmt.setString(30, accountNum);
			pstmt.setString(31, accountHolder);
			pstmt.setString(32, payDueDate);
			pstmt.setString(33, accountCode);
			pstmt.setString(34, collectionDueDate);
			pstmt.setString(35, chargeFieldCode);
			pstmt.setString(36, chargeDeptCode);
			pstmt.setString(37, positionCode);
			pstmt.setString(38, chargeTask);
			pstmt.setString(39, chargeEmployeeCode);
			pstmt.setString(40, employeeExtension);
			pstmt.setString(41, chargeNote);
			pstmt.setString(42, receivePostNum);
			pstmt.setString(43, receiveAddress);
			pstmt.setString(44, receiveTel);
			pstmt.setString(45, receiveFax);
			pstmt.setString(46, lastSetting);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null); conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	/* 해당 회사의 거래처 전체 검색 */
	public ArrayList<CustomerDTO> getCustomerListToCompanyCode(String companyCode) {
		ArrayList<CustomerDTO> customerList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM CUSTOMER WHERE companyCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			rs = pstmt.executeQuery();
			customerList = new ArrayList<CustomerDTO>();
			while(rs.next()) {
				CustomerDTO customer = new CustomerDTO();
				customer.setCompanyCode(rs.getString("companyCode"));
				customer.setCustomCode(rs.getString("customCode"));
				customer.setDivision(rs.getString("division"));
				customer.setCustomerName(rs.getString("customerName"));
				customer.setBusinessLicenseNum(rs.getString("businessLicenseNum"));
				customer.setChiefName(rs.getString("chiefName"));
				customer.setPostNum(rs.getString("postNum"));
				customer.setAddress(rs.getString("address"));
				customer.setTel(rs.getString("tel"));
				customer.setFax(rs.getString("fax"));
				customer.setBusinessCondition(rs.getString("businessCondition"));
				customer.setBusinessType(rs.getString("businessType"));
				customer.setHomepage(rs.getString("homepage"));
				customer.setMonetaryUnit(rs.getString("monetaryUnit"));
				customer.setProject(rs.getString("project"));
				customer.setCustomGroup(rs.getString("customGroup"));
				customer.setCustomGrade(rs.getString("customGrade"));
				customer.setCollectCompany(rs.getString("collectCompany"));
				customer.setTradeStartDate(rs.getString("tradeStartDate"));
				customer.setTradeEndDate(rs.getString("tradeEndDate"));
				customer.setUseBoolean(rs.getString("useBoolean"));
				customer.setTradeForm(rs.getString("tradeForm"));
				customer.setDiscountRate(rs.getString("discountRate"));
				customer.setContractSum(rs.getString("contractSum"));
				customer.setPaymentCondition(rs.getString("paymentCondition"));
				customer.setLoanLimit(rs.getString("loanLimit"));
				customer.setLimitReturnDate(rs.getString("limitReturnDate"));
				customer.setFinancialInstitution(rs.getString("financialInstitution"));
				customer.setBranchName(rs.getString("branchName"));
				customer.setAccountNum(rs.getString("accountNum"));
				customer.setAccountHolder(rs.getString("accountHolder"));
				customer.setPayDueDate(rs.getString("payDueDate"));
				customer.setAccountCode(rs.getString("accountCode"));
				customer.setCollectionDueDate(rs.getString("collectionDueDate"));
				customer.setChargeFieldCode(rs.getString("chargeFieldCode"));
				customer.setChargeDeptCode(rs.getString("chargeDeptCode"));
				customer.setPositionCode(rs.getString("positionCode"));
				customer.setChargeTask(rs.getString("chargeTask"));
				customer.setChargeEmployeeCode(rs.getString("chargeEmployeeCode"));
				customer.setEmployeeExtension(rs.getString("employeeExtension"));
				customer.setChargeNote(rs.getString("chargeNote"));
				customer.setReceivePostNum(rs.getString("receivePostNum"));
				customer.setReceiveAddress(rs.getString("receiveAddress"));
				customer.setReceiveTel(rs.getString("receiveTel"));
				customer.setReceiveFax(rs.getString("receiveFax"));
				customer.setLastSetting(rs.getString("lastSetting"));
				customerList.add(customer);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null); conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return customerList;
	}
	/* 해당 회사의 거래처 이름으로 검색 */
	public ArrayList<CustomerDTO> getCustomerListToName(String companyCode, String customerName) {
		ArrayList<CustomerDTO> customerList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM CUSTOMER WHERE companyCode = ? AND customerName LIKE ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, "%" + customerName + "%");
			rs = pstmt.executeQuery();
			customerList = new ArrayList<CustomerDTO>();
			while(rs.next()) {
				CustomerDTO customer = new CustomerDTO();
				customer.setCompanyCode(rs.getString("companyCode"));
				customer.setCustomCode(rs.getString("customCode"));
				customer.setDivision(rs.getString("division"));
				customer.setCustomerName(rs.getString("customerName"));
				customer.setBusinessLicenseNum(rs.getString("businessLicenseNum"));
				customer.setChiefName(rs.getString("chiefName"));
				customer.setPostNum(rs.getString("postNum"));
				customer.setAddress(rs.getString("address"));
				customer.setTel(rs.getString("tel"));
				customer.setFax(rs.getString("fax"));
				customer.setBusinessCondition(rs.getString("businessCondition"));
				customer.setBusinessType(rs.getString("businessType"));
				customer.setHomepage(rs.getString("homepage"));
				customer.setMonetaryUnit(rs.getString("monetaryUnit"));
				customer.setProject(rs.getString("project"));
				customer.setCustomGroup(rs.getString("customGroup"));
				customer.setCustomGrade(rs.getString("customGrade"));
				customer.setCollectCompany(rs.getString("collectCompany"));
				customer.setTradeStartDate(rs.getString("tradeStartDate"));
				customer.setTradeEndDate(rs.getString("tradeEndDate"));
				customer.setUseBoolean(rs.getString("useBoolean"));
				customer.setTradeForm(rs.getString("tradeForm"));
				customer.setDiscountRate(rs.getString("discountRate"));
				customer.setContractSum(rs.getString("contractSum"));
				customer.setPaymentCondition(rs.getString("paymentCondition"));
				customer.setLoanLimit(rs.getString("loanLimit"));
				customer.setLimitReturnDate(rs.getString("limitReturnDate"));
				customer.setFinancialInstitution(rs.getString("financialInstitution"));
				customer.setBranchName(rs.getString("branchName"));
				customer.setAccountNum(rs.getString("accountNum"));
				customer.setAccountHolder(rs.getString("accountHolder"));
				customer.setPayDueDate(rs.getString("payDueDate"));
				customer.setAccountCode(rs.getString("accountCode"));
				customer.setCollectionDueDate(rs.getString("collectionDueDate"));
				customer.setChargeFieldCode(rs.getString("chargeFieldCode"));
				customer.setChargeDeptCode(rs.getString("chargeDeptCode"));
				customer.setPositionCode(rs.getString("positionCode"));
				customer.setChargeTask(rs.getString("chargeTask"));
				customer.setChargeEmployeeCode(rs.getString("chargeEmployeeCode"));
				customer.setEmployeeExtension(rs.getString("employeeExtension"));
				customer.setChargeNote(rs.getString("chargeNote"));
				customer.setReceivePostNum(rs.getString("receivePostNum"));
				customer.setReceiveAddress(rs.getString("receiveAddress"));
				customer.setReceiveTel(rs.getString("receiveTel"));
				customer.setReceiveFax(rs.getString("receiveFax"));
				customer.setLastSetting(rs.getString("lastSetting"));
				customerList.add(customer);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null); conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return customerList;
	}
	/* 해당 회사의 거래처 코드로 검색 */
	public CustomerDTO getCustomerListToCustomCode(String companyCode, String customCode) {
		CustomerDTO customer = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM CUSTOMER WHERE companyCode = ? AND customCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, customCode);
			rs = pstmt.executeQuery();
			customer = new CustomerDTO();
			if(rs.next()) {
				customer.setCompanyCode(rs.getString("companyCode"));
				customer.setCustomCode(rs.getString("customCode"));
				customer.setDivision(rs.getString("division"));
				customer.setCustomerName(rs.getString("customerName"));
				customer.setBusinessLicenseNum(rs.getString("businessLicenseNum"));
				customer.setChiefName(rs.getString("chiefName"));
				customer.setPostNum(rs.getString("postNum"));
				customer.setAddress(rs.getString("address"));
				customer.setTel(rs.getString("tel"));
				customer.setFax(rs.getString("fax"));
				customer.setBusinessCondition(rs.getString("businessCondition"));
				customer.setBusinessType(rs.getString("businessType"));
				customer.setHomepage(rs.getString("homepage"));
				customer.setMonetaryUnit(rs.getString("monetaryUnit"));
				customer.setProject(rs.getString("project"));
				customer.setCustomGroup(rs.getString("customGroup"));
				customer.setCustomGrade(rs.getString("customGrade"));
				customer.setCollectCompany(rs.getString("collectCompany"));
				customer.setTradeStartDate(rs.getString("tradeStartDate"));
				customer.setTradeEndDate(rs.getString("tradeEndDate"));
				customer.setUseBoolean(rs.getString("useBoolean"));
				customer.setTradeForm(rs.getString("tradeForm"));
				customer.setDiscountRate(rs.getString("discountRate"));
				customer.setContractSum(rs.getString("contractSum"));
				customer.setPaymentCondition(rs.getString("paymentCondition"));
				customer.setLoanLimit(rs.getString("loanLimit"));
				customer.setLimitReturnDate(rs.getString("limitReturnDate"));
				customer.setFinancialInstitution(rs.getString("financialInstitution"));
				customer.setBranchName(rs.getString("branchName"));
				customer.setAccountNum(rs.getString("accountNum"));
				customer.setAccountHolder(rs.getString("accountHolder"));
				customer.setPayDueDate(rs.getString("payDueDate"));
				customer.setAccountCode(rs.getString("accountCode"));
				customer.setCollectionDueDate(rs.getString("collectionDueDate"));
				customer.setChargeFieldCode(rs.getString("chargeFieldCode"));
				customer.setChargeDeptCode(rs.getString("chargeDeptCode"));
				customer.setPositionCode(rs.getString("positionCode"));
				customer.setChargeTask(rs.getString("chargeTask"));
				customer.setChargeEmployeeCode(rs.getString("chargeEmployeeCode"));
				customer.setEmployeeExtension(rs.getString("employeeExtension"));
				customer.setChargeNote(rs.getString("chargeNote"));
				customer.setReceivePostNum(rs.getString("receivePostNum"));
				customer.setReceiveAddress(rs.getString("receiveAddress"));
				customer.setReceiveTel(rs.getString("receiveTel"));
				customer.setReceiveFax(rs.getString("receiveFax"));
				customer.setLastSetting(rs.getString("lastSetting"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null); conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return customer;
	}
	/* 해당 회사의 거래처 사업자등록번호로 검색 */
	public ArrayList<CustomerDTO> getCustomerListToBusinessLicenseNum(String companyCode, String businessLicenseNum) {
		ArrayList<CustomerDTO> customerList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM CUSTOMER WHERE companyCode = ? AND businessLicenseNum = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, businessLicenseNum);
			rs = pstmt.executeQuery();
			customerList = new ArrayList<CustomerDTO>();
			while(rs.next()) {
				CustomerDTO customer = new CustomerDTO();
				customer.setCompanyCode(rs.getString("companyCode"));
				customer.setCustomCode(rs.getString("customCode"));
				customer.setDivision(rs.getString("division"));
				customer.setCustomerName(rs.getString("customerName"));
				customer.setBusinessLicenseNum(rs.getString("businessLicenseNum"));
				customer.setChiefName(rs.getString("chiefName"));
				customer.setPostNum(rs.getString("postNum"));
				customer.setAddress(rs.getString("address"));
				customer.setTel(rs.getString("tel"));
				customer.setFax(rs.getString("fax"));
				customer.setBusinessCondition(rs.getString("businessCondition"));
				customer.setBusinessType(rs.getString("businessType"));
				customer.setHomepage(rs.getString("homepage"));
				customer.setMonetaryUnit(rs.getString("monetaryUnit"));
				customer.setProject(rs.getString("project"));
				customer.setCustomGroup(rs.getString("customGroup"));
				customer.setCustomGrade(rs.getString("customGrade"));
				customer.setCollectCompany(rs.getString("collectCompany"));
				customer.setTradeStartDate(rs.getString("tradeStartDate"));
				customer.setTradeEndDate(rs.getString("tradeEndDate"));
				customer.setUseBoolean(rs.getString("useBoolean"));
				customer.setTradeForm(rs.getString("tradeForm"));
				customer.setDiscountRate(rs.getString("discountRate"));
				customer.setContractSum(rs.getString("contractSum"));
				customer.setPaymentCondition(rs.getString("paymentCondition"));
				customer.setLoanLimit(rs.getString("loanLimit"));
				customer.setLimitReturnDate(rs.getString("limitReturnDate"));
				customer.setFinancialInstitution(rs.getString("financialInstitution"));
				customer.setBranchName(rs.getString("branchName"));
				customer.setAccountNum(rs.getString("accountNum"));
				customer.setAccountHolder(rs.getString("accountHolder"));
				customer.setPayDueDate(rs.getString("payDueDate"));
				customer.setAccountCode(rs.getString("accountCode"));
				customer.setCollectionDueDate(rs.getString("collectionDueDate"));
				customer.setChargeFieldCode(rs.getString("chargeFieldCode"));
				customer.setChargeDeptCode(rs.getString("chargeDeptCode"));
				customer.setPositionCode(rs.getString("positionCode"));
				customer.setChargeTask(rs.getString("chargeTask"));
				customer.setChargeEmployeeCode(rs.getString("chargeEmployeeCode"));
				customer.setEmployeeExtension(rs.getString("employeeExtension"));
				customer.setChargeNote(rs.getString("chargeNote"));
				customer.setReceivePostNum(rs.getString("receivePostNum"));
				customer.setReceiveAddress(rs.getString("receiveAddress"));
				customer.setReceiveTel(rs.getString("receiveTel"));
				customer.setReceiveFax(rs.getString("receiveFax"));
				customer.setLastSetting(rs.getString("lastSetting"));
				customerList.add(customer);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null); conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return customerList;
	}
	
	public String getCustomerName(String companyCode, String customCode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String result = "";
		String SQL = "SELECT customerName FROM CUSTOMER WHERE companyCode = ? AND customCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, customCode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getString("customerName");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
}
