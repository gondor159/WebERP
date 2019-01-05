package financialcustom;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class FinancialCustomDAO {
	
	DataSource dataSource;
	public FinancialCustomDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/WebERP");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/* 금융기관등록 */
	public int fiRegist(String companyCode, String fcCode, String division, String fcName, String accountNum, String accountBranch, String businessLicenseNum, 
			String postNum, String address, String tel, String fax, String homepage, String email, String projectCode, String customGroup, String financialInstitutionCode,
			String accountDivision, String accountHolder, String accountName, String accountLimit, String swiftCode, String accountOpenDate, String tradeEndDate,
			String useBoolean, String inquiryLimit, String lastUser) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO FINANCIALCUSTOM(" + 
				"companyCode, fcCode, division, fcName, accountNum, accountBranch, businessLicenseNum," +
				"postNum, address, tel, fax, homepage, email, projectCode, customGroup, financialInstitutionCode," + 
				"accountDivision, accountHolder, accountName, accountLimit, swiftCode, accountOpenDate, tradeEndDate," +
				"useBoolean, inquiryLimit, lastUser, lastDate" +
				") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now())";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, fcCode);
			pstmt.setString(3, division);
			pstmt.setString(4, fcName);
			pstmt.setString(5, accountNum);
			pstmt.setString(6, accountBranch);
			pstmt.setString(7, businessLicenseNum);
			pstmt.setString(8, postNum);
			pstmt.setString(9, address);
			pstmt.setString(10, tel);
			pstmt.setString(11, fax);
			pstmt.setString(12, homepage);
			pstmt.setString(13, email);
			pstmt.setString(14, projectCode);
			pstmt.setString(15, customGroup);
			pstmt.setString(16, financialInstitutionCode);
			pstmt.setString(17, accountDivision);
			pstmt.setString(18, accountHolder);
			pstmt.setString(19, accountName);
			pstmt.setString(20, accountLimit);
			pstmt.setString(21, swiftCode);
			pstmt.setString(22, accountOpenDate);
			pstmt.setString(23, tradeEndDate);
			pstmt.setString(24, useBoolean);
			pstmt.setString(25, inquiryLimit);
			pstmt.setString(26, lastUser);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			} 
		}
		return -1;
	}
	/* 정기예금등록 */
	public int tdRegist(String companyCode, String fcCode, String division, String fcName, String accountNum, String accountBranch, String businessLicenseNum, 
			String postNum, String address, String tel, String fax, String homepage, String email, String projectCode, String customGroup, String financialInstitutionCode,
			String accountDivision, String accountHolder, String accountName, String sum, String monthlyIncomeInterest, String ttoacStart, String ttoacEnd,
			String interestTransferDate, String interestRatio, String swiftCode, String tradeStartDate, String maturityDate, String useBoolean, String inquiryLimit, String lastUser) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO FINANCIALCUSTOM(" + 
				"companyCode, fcCode, division, fcName, accountNum, accountBranch, businessLicenseNum," +
				"postNum, address, tel, fax, homepage, email, projectCode, customGroup, financialInstitutionCode," + 
				"accountDivision, accountHolder, accountName, sum, monthlyIncomeInterest, ttoacStart, ttoacEnd," +
				"interestTransferDate, interestRatio, swiftCode, tradeStartDate, maturityDate, useBoolean, inquiryLimit, lastUser, lastDate" +
				") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now())";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, fcCode);
			pstmt.setString(3, division);
			pstmt.setString(4, fcName);
			pstmt.setString(5, accountNum);
			pstmt.setString(6, accountBranch);
			pstmt.setString(7, businessLicenseNum);
			pstmt.setString(8, postNum);
			pstmt.setString(9, address);
			pstmt.setString(10, tel);
			pstmt.setString(11, fax);
			pstmt.setString(12, homepage);
			pstmt.setString(13, email);
			pstmt.setString(14, projectCode);
			pstmt.setString(15, customGroup);
			pstmt.setString(16, financialInstitutionCode);
			pstmt.setString(17, accountDivision);
			pstmt.setString(18, accountHolder);
			pstmt.setString(19, accountName);
			pstmt.setString(20, sum);
			pstmt.setString(21, monthlyIncomeInterest);
			pstmt.setString(22, ttoacStart);
			pstmt.setString(23, ttoacEnd);
			pstmt.setString(24, interestTransferDate);
			pstmt.setString(25, interestRatio);
			pstmt.setString(26, swiftCode);
			pstmt.setString(27, tradeStartDate);
			pstmt.setString(28, maturityDate);
			pstmt.setString(29, useBoolean);
			pstmt.setString(30, inquiryLimit);
			pstmt.setString(31, lastUser);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			} 
		}
		return -1;
	}
	/* 정기적금등록 */
	public int isdRegist(String companyCode, String fcCode, String division, String fcName, String accountNum, String accountBranch, String businessLicenseNum, 
			String postNum, String address, String tel, String fax, String homepage, String email, String projectCode, String customGroup, String financialInstitutionCode,
			String accountDivision, String accountHolder, String accountName, String contractSum, String etdSum, String ttoacStart, String ttoacEnd,
			String etdDate, String interestRatio, String swiftCode, String tradeStartDate, String maturityDate, String useBoolean, String inquiryLimit, String lastUser) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO FINANCIALCUSTOM(" + 
				"companyCode, fcCode, division, fcName, accountNum, accountBranch, businessLicenseNum," +
				"postNum, address, tel, fax, homepage, email, projectCode, customGroup, financialInstitutionCode," + 
				"accountDivision, accountHolder, accountName, contractSum, etdSum, ttoacStart, ttoacEnd," +
				"etdDate, interestRatio, swiftCode, tradeStartDate, maturityDate, useBoolean, inquiryLimit, lastUser, lastDate" +
				") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now())";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, fcCode);
			pstmt.setString(3, division);
			pstmt.setString(4, fcName);
			pstmt.setString(5, accountNum);
			pstmt.setString(6, accountBranch);
			pstmt.setString(7, businessLicenseNum);
			pstmt.setString(8, postNum);
			pstmt.setString(9, address);
			pstmt.setString(10, tel);
			pstmt.setString(11, fax);
			pstmt.setString(12, homepage);
			pstmt.setString(13, email);
			pstmt.setString(14, projectCode);
			pstmt.setString(15, customGroup);
			pstmt.setString(16, financialInstitutionCode);
			pstmt.setString(17, accountDivision);
			pstmt.setString(18, accountHolder);
			pstmt.setString(19, accountName);
			pstmt.setString(20, contractSum);
			pstmt.setString(21, etdSum);
			pstmt.setString(22, ttoacStart);
			pstmt.setString(23, ttoacEnd);
			pstmt.setString(24, etdDate);
			pstmt.setString(25, interestRatio);
			pstmt.setString(26, swiftCode);
			pstmt.setString(27, tradeStartDate);
			pstmt.setString(28, maturityDate);
			pstmt.setString(29, useBoolean);
			pstmt.setString(30, inquiryLimit);
			pstmt.setString(31, lastUser);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			} 
		}
		return -1;
	}
	/* 카드사등록 */
	public int cccRegist(String companyCode, String fcCode, String division, String fcName, String accountNum, String accountBranch, String businessLicenseNum, 
			String postNum, String address, String tel, String fax, String homepage, String email, String projectCode, String customGroup, String financialInstitutionCode,
			String paymentAccount, String accountHolder, String commissionRatio, String swiftCode, String tradeStartDate, String tradeEndDate,
			String useBoolean, String inquiryLimit, String lastUser) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO FINANCIALCUSTOM(" + 
				"companyCode, fcCode, division, fcName, accountNum, accountBranch, businessLicenseNum," +
				"postNum, address, tel, fax, homepage, email, projectCode, customGroup, financialInstitutionCode," + 
				"paymentAccount, accountHolder, commissionRatio, swiftCode, tradeStartDate, tradeEndDate," +
				"useBoolean, inquiryLimit, lastUser, lastDate" +
				") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now())";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, fcCode);
			pstmt.setString(3, division);
			pstmt.setString(4, fcName);
			pstmt.setString(5, accountNum);
			pstmt.setString(6, accountBranch);
			pstmt.setString(7, businessLicenseNum);
			pstmt.setString(8, postNum);
			pstmt.setString(9, address);
			pstmt.setString(10, tel);
			pstmt.setString(11, fax);
			pstmt.setString(12, homepage);
			pstmt.setString(13, email);
			pstmt.setString(14, projectCode);
			pstmt.setString(15, customGroup);
			pstmt.setString(16, financialInstitutionCode);
			pstmt.setString(17, paymentAccount);
			pstmt.setString(18, accountHolder);
			pstmt.setString(19, commissionRatio);
			pstmt.setString(20, swiftCode);
			pstmt.setString(21, tradeStartDate);
			pstmt.setString(22, tradeEndDate);
			pstmt.setString(23, useBoolean);
			pstmt.setString(24, inquiryLimit);
			pstmt.setString(25, lastUser);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			} 
		}
		return -1;
	}
	/* 신용카드등록 */
	public int cdRegist(String companyCode, String fcCode, String division, String fcName, String cardNum, String cardDivision, String accountBranch, String businessLicenseNum, String cardMember, 
			String postNum, String address, String tel, String fax, String homepage, String email, String projectCode, String customGroup, String financialInstitutionCode,
			String paymentAccount, String accountHolder, String monthlyLimitSum, String effectiveLife, String tradeStartDate, String tradeEndDate,
			String useBoolean, String inquiryLimit, String lastUser) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO FINANCIALCUSTOM(" + 
				"companyCode, fcCode, division, fcName, cardNum, cardDivision, accountBranch, businessLicenseNum, cardMember," +
				"postNum, address, tel, fax, homepage, email, projectCode, customGroup, financialInstitutionCode," + 
				"paymentAccount, accountHolder, monthlyLimitSum, effectiveLife, tradeStartDate, tradeEndDate," +
				"useBoolean, inquiryLimit, lastUser, lastDate" +
				") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now())";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, fcCode);
			pstmt.setString(3, division);
			pstmt.setString(4, fcName);
			pstmt.setString(5, cardNum);
			pstmt.setString(6, cardDivision);
			pstmt.setString(7, accountBranch);
			pstmt.setString(8, businessLicenseNum);
			pstmt.setString(9, cardMember);
			pstmt.setString(10, postNum);
			pstmt.setString(11, address);
			pstmt.setString(12, tel);
			pstmt.setString(13, fax);
			pstmt.setString(14, homepage);
			pstmt.setString(15, email);
			pstmt.setString(16, projectCode);
			pstmt.setString(17, customGroup);
			pstmt.setString(18, financialInstitutionCode);
			pstmt.setString(19, paymentAccount);
			pstmt.setString(20, accountHolder);
			pstmt.setString(21, monthlyLimitSum);
			pstmt.setString(22, effectiveLife);
			pstmt.setString(23, tradeStartDate);
			pstmt.setString(24, tradeEndDate);
			pstmt.setString(25, useBoolean);
			pstmt.setString(26, inquiryLimit);
			pstmt.setString(27, lastUser);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			} 
		}
		return -1;
	}
	/* 리스트 금융거래처 전체 불러오기 */
	public ArrayList<FinancialCustomDTO> getFinancialCustomList(String companyCode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<FinancialCustomDTO> list = null;
		String SQL = "SELECT * FROM FINANCIALCUSTOM WHERE companyCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			rs = pstmt.executeQuery();
			list = new ArrayList<FinancialCustomDTO>();
			while(rs.next()) {
				FinancialCustomDTO financialCustom = new FinancialCustomDTO();
				financialCustom.setCompanyCode(rs.getString("companyCode"));
				financialCustom.setFcCode(rs.getString("fcCode"));
				financialCustom.setFcName(rs.getString("fcName"));
				financialCustom.setDivision(rs.getString("division"));
				financialCustom.setBusinessLicenseNum(rs.getString("businessLicenseNum"));
				financialCustom.setPostNum(rs.getString("postNum"));
				financialCustom.setAddress(rs.getString("address"));
				financialCustom.setTel(rs.getString("tel"));
				financialCustom.setFax(rs.getString("fax"));
				financialCustom.setHomepage(rs.getString("homepage"));
				financialCustom.setEmail(rs.getString("email"));
				financialCustom.setAccountNum(rs.getString("accountNum"));
				financialCustom.setAccountBranch(rs.getString("accountBranch"));
				financialCustom.setCardNum(rs.getString("cardNum"));
				financialCustom.setCardDivision(rs.getString("cardDivision"));
				financialCustom.setCardMember(rs.getString("cardMember"));
				financialCustom.setProjectCode(rs.getString("projectCode"));
				financialCustom.setCustomGroup(rs.getString("customGroup"));
				financialCustom.setFinancialInstitutionCode(rs.getString("financialInstitutionCode"));
				financialCustom.setAccountDivision(rs.getString("accountDivision"));
				financialCustom.setAccountName(rs.getString("accountName"));
				financialCustom.setAccountHolder(rs.getString("accountHolder"));
				financialCustom.setSwiftCode(rs.getString("swiftCode"));
				financialCustom.setAccountLimit(rs.getString("accountLimit"));
				financialCustom.setSum(rs.getString("sum"));
				financialCustom.setMonthlyIncomeInterest(rs.getString("monthlyIncomeInterest"));
				financialCustom.setTtoacStart(rs.getString("ttoacStart"));
				financialCustom.setTtoacEnd(rs.getString("ttoacEnd"));
				financialCustom.setInterestTransferDate(rs.getString("interestTransferDate"));
				financialCustom.setInterestRatio(rs.getString("interestRatio"));
				financialCustom.setContractSum(rs.getString("contractSum"));
				financialCustom.setEtdSum(rs.getString("etdSum"));
				financialCustom.setEtdDate(rs.getString("etdDate"));
				financialCustom.setCommissionRatio(rs.getString("commissionRatio"));
				financialCustom.setPaymentAccount(rs.getString("paymentAccount"));
				financialCustom.setMonthlyLimitSum(rs.getString("monthlyLimitSum"));
				financialCustom.setEffectiveLife(rs.getString("effectiveLife"));
				financialCustom.setUseBoolean(rs.getString("useBoolean"));
				financialCustom.setInquiryLimit(rs.getString("inquiryLimit"));
				financialCustom.setAccountOpenDate(rs.getString("accountOpenDate"));
				financialCustom.setTradeStartDate(rs.getString("tradeStartDate"));
				financialCustom.setTradeEndDate(rs.getString("tradeEndDate"));
				financialCustom.setMaturityDate(rs.getString("maturityDate"));
				financialCustom.setLastUser(rs.getString("lastUser"));
				financialCustom.setLastDate(rs.getString("lastDate"));
				list.add(financialCustom);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	/* 리스트 금융거래처 불러오기(거래처명) */
	public ArrayList<FinancialCustomDTO> getFinancialCustomListToName(String companyCode, String fcName) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<FinancialCustomDTO> list = null;
		String SQL = "SELECT * FROM FINANCIALCUSTOM WHERE companyCode = ? AND fcName LIKE ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, "%" + fcName + "%");
			rs = pstmt.executeQuery();
			list = new ArrayList<FinancialCustomDTO>();
			while(rs.next()) {
				FinancialCustomDTO financialCustom = new FinancialCustomDTO();
				financialCustom.setCompanyCode(rs.getString("companyCode"));
				financialCustom.setFcCode(rs.getString("fcCode"));
				financialCustom.setFcName(rs.getString("fcName"));
				financialCustom.setDivision(rs.getString("division"));
				financialCustom.setBusinessLicenseNum(rs.getString("businessLicenseNum"));
				financialCustom.setPostNum(rs.getString("postNum"));
				financialCustom.setAddress(rs.getString("address"));
				financialCustom.setTel(rs.getString("tel"));
				financialCustom.setFax(rs.getString("fax"));
				financialCustom.setHomepage(rs.getString("homepage"));
				financialCustom.setEmail(rs.getString("email"));
				financialCustom.setAccountNum(rs.getString("accountNum"));
				financialCustom.setAccountBranch(rs.getString("accountBranch"));
				financialCustom.setCardNum(rs.getString("cardNum"));
				financialCustom.setCardDivision(rs.getString("cardDivision"));
				financialCustom.setCardMember(rs.getString("cardMember"));
				financialCustom.setProjectCode(rs.getString("projectCode"));
				financialCustom.setCustomGroup(rs.getString("customGroup"));
				financialCustom.setFinancialInstitutionCode(rs.getString("financialInstitutionCode"));
				financialCustom.setAccountDivision(rs.getString("accountDivision"));
				financialCustom.setAccountName(rs.getString("accountName"));
				financialCustom.setAccountHolder(rs.getString("accountHolder"));
				financialCustom.setSwiftCode(rs.getString("swiftCode"));
				financialCustom.setAccountLimit(rs.getString("accountLimit"));
				financialCustom.setSum(rs.getString("sum"));
				financialCustom.setMonthlyIncomeInterest(rs.getString("monthlyIncomeInterest"));
				financialCustom.setTtoacStart(rs.getString("ttoacStart"));
				financialCustom.setTtoacEnd(rs.getString("ttoacEnd"));
				financialCustom.setInterestTransferDate(rs.getString("interestTransferDate"));
				financialCustom.setInterestRatio(rs.getString("interestRatio"));
				financialCustom.setContractSum(rs.getString("contractSum"));
				financialCustom.setEtdSum(rs.getString("etdSum"));
				financialCustom.setEtdDate(rs.getString("etdDate"));
				financialCustom.setCommissionRatio(rs.getString("commissionRatio"));
				financialCustom.setPaymentAccount(rs.getString("paymentAccount"));
				financialCustom.setMonthlyLimitSum(rs.getString("monthlyLimitSum"));
				financialCustom.setEffectiveLife(rs.getString("effectiveLife"));
				financialCustom.setUseBoolean(rs.getString("useBoolean"));
				financialCustom.setInquiryLimit(rs.getString("inquiryLimit"));
				financialCustom.setAccountOpenDate(rs.getString("accountOpenDate"));
				financialCustom.setTradeStartDate(rs.getString("tradeStartDate"));
				financialCustom.setTradeEndDate(rs.getString("tradeEndDate"));
				financialCustom.setMaturityDate(rs.getString("maturityDate"));
				financialCustom.setLastUser(rs.getString("lastUser"));
				financialCustom.setLastDate(rs.getString("lastDate"));
				list.add(financialCustom);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	/* 리스트 금융거래처 전체 불러오기(코드) */
	public ArrayList<FinancialCustomDTO> getFinancialCustomListToCode(String companyCode, String fcCode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<FinancialCustomDTO> list = null;
		String SQL = "SELECT * FROM FINANCIALCUSTOM WHERE companyCode = ? AND fcCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, fcCode);
			rs = pstmt.executeQuery();
			list = new ArrayList<FinancialCustomDTO>();
			while(rs.next()) {
				FinancialCustomDTO financialCustom = new FinancialCustomDTO();
				financialCustom.setCompanyCode(rs.getString("companyCode"));
				financialCustom.setFcCode(rs.getString("fcCode"));
				financialCustom.setFcName(rs.getString("fcName"));
				financialCustom.setDivision(rs.getString("division"));
				financialCustom.setBusinessLicenseNum(rs.getString("businessLicenseNum"));
				financialCustom.setPostNum(rs.getString("postNum"));
				financialCustom.setAddress(rs.getString("address"));
				financialCustom.setTel(rs.getString("tel"));
				financialCustom.setFax(rs.getString("fax"));
				financialCustom.setHomepage(rs.getString("homepage"));
				financialCustom.setEmail(rs.getString("email"));
				financialCustom.setAccountNum(rs.getString("accountNum"));
				financialCustom.setAccountBranch(rs.getString("accountBranch"));
				financialCustom.setCardNum(rs.getString("cardNum"));
				financialCustom.setCardDivision(rs.getString("cardDivision"));
				financialCustom.setCardMember(rs.getString("cardMember"));
				financialCustom.setProjectCode(rs.getString("projectCode"));
				financialCustom.setCustomGroup(rs.getString("customGroup"));
				financialCustom.setFinancialInstitutionCode(rs.getString("financialInstitutionCode"));
				financialCustom.setAccountDivision(rs.getString("accountDivision"));
				financialCustom.setAccountName(rs.getString("accountName"));
				financialCustom.setAccountHolder(rs.getString("accountHolder"));
				financialCustom.setSwiftCode(rs.getString("swiftCode"));
				financialCustom.setAccountLimit(rs.getString("accountLimit"));
				financialCustom.setSum(rs.getString("sum"));
				financialCustom.setMonthlyIncomeInterest(rs.getString("monthlyIncomeInterest"));
				financialCustom.setTtoacStart(rs.getString("ttoacStart"));
				financialCustom.setTtoacEnd(rs.getString("ttoacEnd"));
				financialCustom.setInterestTransferDate(rs.getString("interestTransferDate"));
				financialCustom.setInterestRatio(rs.getString("interestRatio"));
				financialCustom.setContractSum(rs.getString("contractSum"));
				financialCustom.setEtdSum(rs.getString("etdSum"));
				financialCustom.setEtdDate(rs.getString("etdDate"));
				financialCustom.setCommissionRatio(rs.getString("commissionRatio"));
				financialCustom.setPaymentAccount(rs.getString("paymentAccount"));
				financialCustom.setMonthlyLimitSum(rs.getString("monthlyLimitSum"));
				financialCustom.setEffectiveLife(rs.getString("effectiveLife"));
				financialCustom.setUseBoolean(rs.getString("useBoolean"));
				financialCustom.setInquiryLimit(rs.getString("inquiryLimit"));
				financialCustom.setAccountOpenDate(rs.getString("accountOpenDate"));
				financialCustom.setTradeStartDate(rs.getString("tradeStartDate"));
				financialCustom.setTradeEndDate(rs.getString("tradeEndDate"));
				financialCustom.setMaturityDate(rs.getString("maturityDate"));
				financialCustom.setLastUser(rs.getString("lastUser"));
				financialCustom.setLastDate(rs.getString("lastDate"));
				list.add(financialCustom);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	/* 리스트 금융거래처 전체 불러오기(분류) */
	public ArrayList<FinancialCustomDTO> getFinancialCustomListToDivision(String companyCode, String division) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<FinancialCustomDTO> list = null;
		String SQL = "SELECT * FROM FINANCIALCUSTOM WHERE companyCode = ? AND division = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, division);
			rs = pstmt.executeQuery();
			list = new ArrayList<FinancialCustomDTO>();
			while(rs.next()) {
				FinancialCustomDTO financialCustom = new FinancialCustomDTO();
				financialCustom.setCompanyCode(rs.getString("companyCode"));
				financialCustom.setFcCode(rs.getString("fcCode"));
				financialCustom.setFcName(rs.getString("fcName"));
				financialCustom.setDivision(rs.getString("division"));
				financialCustom.setBusinessLicenseNum(rs.getString("businessLicenseNum"));
				financialCustom.setPostNum(rs.getString("postNum"));
				financialCustom.setAddress(rs.getString("address"));
				financialCustom.setTel(rs.getString("tel"));
				financialCustom.setFax(rs.getString("fax"));
				financialCustom.setHomepage(rs.getString("homepage"));
				financialCustom.setEmail(rs.getString("email"));
				financialCustom.setAccountNum(rs.getString("accountNum"));
				financialCustom.setAccountBranch(rs.getString("accountBranch"));
				financialCustom.setCardNum(rs.getString("cardNum"));
				financialCustom.setCardDivision(rs.getString("cardDivision"));
				financialCustom.setCardMember(rs.getString("cardMember"));
				financialCustom.setProjectCode(rs.getString("projectCode"));
				financialCustom.setCustomGroup(rs.getString("customGroup"));
				financialCustom.setFinancialInstitutionCode(rs.getString("financialInstitutionCode"));
				financialCustom.setAccountDivision(rs.getString("accountDivision"));
				financialCustom.setAccountName(rs.getString("accountName"));
				financialCustom.setAccountHolder(rs.getString("accountHolder"));
				financialCustom.setSwiftCode(rs.getString("swiftCode"));
				financialCustom.setAccountLimit(rs.getString("accountLimit"));
				financialCustom.setSum(rs.getString("sum"));
				financialCustom.setMonthlyIncomeInterest(rs.getString("monthlyIncomeInterest"));
				financialCustom.setTtoacStart(rs.getString("ttoacStart"));
				financialCustom.setTtoacEnd(rs.getString("ttoacEnd"));
				financialCustom.setInterestTransferDate(rs.getString("interestTransferDate"));
				financialCustom.setInterestRatio(rs.getString("interestRatio"));
				financialCustom.setContractSum(rs.getString("contractSum"));
				financialCustom.setEtdSum(rs.getString("etdSum"));
				financialCustom.setEtdDate(rs.getString("etdDate"));
				financialCustom.setCommissionRatio(rs.getString("commissionRatio"));
				financialCustom.setPaymentAccount(rs.getString("paymentAccount"));
				financialCustom.setMonthlyLimitSum(rs.getString("monthlyLimitSum"));
				financialCustom.setEffectiveLife(rs.getString("effectiveLife"));
				financialCustom.setUseBoolean(rs.getString("useBoolean"));
				financialCustom.setInquiryLimit(rs.getString("inquiryLimit"));
				financialCustom.setAccountOpenDate(rs.getString("accountOpenDate"));
				financialCustom.setTradeStartDate(rs.getString("tradeStartDate"));
				financialCustom.setTradeEndDate(rs.getString("tradeEndDate"));
				financialCustom.setMaturityDate(rs.getString("maturityDate"));
				financialCustom.setLastUser(rs.getString("lastUser"));
				financialCustom.setLastDate(rs.getString("lastDate"));
				list.add(financialCustom);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	/* 단일 금융거래처명 불러오기 */
	public String getFcName(String companyCode, String fcCode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String name = "";
		String SQL = "SELECT fcName FROM FINANCIALCUSTOM WHERE companyCode = ? AND fcCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, fcCode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				name = rs.getString("fcName");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return name;
	}
}
