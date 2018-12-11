package company;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CompanyDAO {
	DataSource dataSource;
	public CompanyDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/studioour");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/* 회사코드 추가 */
	public int getNextCompanyCode(String businessCondition, String businessType) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT companySequence FROM COMPANY WHERE businessCondition = ? AND businessType = ? ORDER BY companySequence DESC";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, businessCondition);
			pstmt.setString(2, businessType);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
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
		return -1;
	}
	/* 회사등록 */
	public int registCompany(String businessLicenseNum, String corporateLicenseNum, String companyName,
			String companyEngName, String chiefID, String postNum, String address, String addressEng, String tel,
			String fax, String businessCondition, String businessType, String establishmentDate, String startDate,
			String homepage, String monetaryUnit, String companyCode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO COMPANY VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, businessLicenseNum);
			pstmt.setString(2, corporateLicenseNum);
			pstmt.setString(3, companyName);
			pstmt.setString(4, companyEngName);
			pstmt.setString(5, chiefID);
			pstmt.setString(6, postNum);
			pstmt.setString(7, address);
			pstmt.setString(8, addressEng);
			pstmt.setString(9, tel);
			pstmt.setString(10, fax);
			pstmt.setString(11, businessCondition);
			pstmt.setString(12, businessType);
			pstmt.setString(13, establishmentDate);
			pstmt.setString(14, startDate);
			pstmt.setString(15, homepage);
			pstmt.setString(16, monetaryUnit);
			pstmt.setString(17, companyCode);
			pstmt.setInt(18, getNextCompanyCode(businessCondition, businessType));
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
	/* 단일 회사 검색 (회사코드) */
	public CompanyDTO getCompany(String companyCode) {
		CompanyDTO company = new CompanyDTO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM COMPANY WHERE companyCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				company.setBusinessLicenseNum(rs.getString("businessLicenseNum"));
				company.setCorporateLicenseNum(rs.getString("corporateLicenseNum"));
				company.setCompanyName(rs.getString("companyName"));
				company.setCompanyEngName(rs.getString("companyEngName"));
				company.setChiefID(rs.getString("chiefID"));
				company.setPostNum(rs.getString("postNum"));
				company.setAddress(rs.getString("address"));
				company.setAddressEng(rs.getString("addressEng"));
				company.setTel(rs.getString("tel"));
				company.setFax(rs.getString("fax"));
				company.setBusinessCondition(rs.getString("businessCondition"));
				company.setBusinessType(rs.getString("businessType"));
				company.setEstablishmentDate(rs.getString("establishmentDate"));
				company.setStartDate(rs.getString("startDate"));
				company.setHomepage(rs.getString("homepage"));
				company.setMonetaryUnit(rs.getString("monetaryUnit"));
				company.setCompanyCode(rs.getString("companyCode"));
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
		return company;
	}
	/* 단일 회사 검색 (대표ID) */
	public CompanyDTO getCompanyToID(String chiefID) {
		CompanyDTO company = new CompanyDTO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM COMPANY WHERE chiefID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, chiefID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				company.setBusinessLicenseNum(rs.getString("businessLicenseNum"));
				company.setCorporateLicenseNum(rs.getString("corporateLicenseNum"));
				company.setCompanyName(rs.getString("companyName"));
				company.setCompanyEngName(rs.getString("companyEngName"));
				company.setChiefID(rs.getString("chiefID"));
				company.setPostNum(rs.getString("postNum"));
				company.setAddress(rs.getString("address"));
				company.setAddressEng(rs.getString("addressEng"));
				company.setTel(rs.getString("tel"));
				company.setFax(rs.getString("fax"));
				company.setBusinessCondition(rs.getString("businessCondition"));
				company.setBusinessType(rs.getString("businessType"));
				company.setEstablishmentDate(rs.getString("establishmentDate"));
				company.setStartDate(rs.getString("startDate"));
				company.setHomepage(rs.getString("homepage"));
				company.setMonetaryUnit(rs.getString("monetaryUnit"));
				company.setCompanyCode(rs.getString("companyCode"));
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
		return company;
	}
	/* 단일 회사 검색 (사업자등록번호) */
	public CompanyDTO getCompanyToLicense(String businessLicenseNum) {
		CompanyDTO company = new CompanyDTO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM COMPANY WHERE businessLicenseNum = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, businessLicenseNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				company.setBusinessLicenseNum(rs.getString("businessLicenseNum"));
				company.setCorporateLicenseNum(rs.getString("corporateLicenseNum"));
				company.setCompanyName(rs.getString("companyName"));
				company.setCompanyEngName(rs.getString("companyEngName"));
				company.setChiefID(rs.getString("chiefID"));
				company.setPostNum(rs.getString("postNum"));
				company.setAddress(rs.getString("address"));
				company.setAddressEng(rs.getString("addressEng"));
				company.setTel(rs.getString("tel"));
				company.setFax(rs.getString("fax"));
				company.setBusinessCondition(rs.getString("businessCondition"));
				company.setBusinessType(rs.getString("businessType"));
				company.setEstablishmentDate(rs.getString("establishmentDate"));
				company.setStartDate(rs.getString("startDate"));
				company.setHomepage(rs.getString("homepage"));
				company.setMonetaryUnit(rs.getString("monetaryUnit"));
				company.setCompanyCode(rs.getString("companyCode"));
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
		return company;
	}
	/* 리스트 회사검색 */
	public ArrayList<CompanyDTO> getCompanyList() {
		ArrayList<CompanyDTO> companyList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM COMPANY";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			companyList = new ArrayList<CompanyDTO>();
			while(rs.next()) {
				CompanyDTO companies = new CompanyDTO();
				companies.setBusinessLicenseNum(rs.getString("businessLicenseNum"));
				companies.setCorporateLicenseNum(rs.getString("corporateLicenseNum"));
				companies.setCompanyName(rs.getString("companyName"));
				companies.setCompanyEngName(rs.getString("companyEngName"));
				companies.setChiefID(rs.getString("chiefID"));
				companies.setPostNum(rs.getString("postNum"));
				companies.setAddress(rs.getString("address"));
				companies.setAddressEng(rs.getString("addressEng"));
				companies.setTel(rs.getString("tel"));
				companies.setFax(rs.getString("fax"));
				companies.setBusinessCondition(rs.getString("businessCondition"));
				companies.setBusinessType(rs.getString("businessType"));
				companies.setEstablishmentDate(rs.getString("establishmentDate"));
				companies.setStartDate(rs.getString("startDate"));
				companies.setHomepage(rs.getString("homepage"));
				companies.setMonetaryUnit(rs.getString("monetaryUnit"));
				companies.setCompanyCode(rs.getString("companyCode"));
				companyList.add(companies);
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
		return companyList;
	}
	/* 리스트 회사검색 (사장 아이디) */
	public ArrayList<CompanyDTO> getCompanyListToCheif(String chiefID) {
		ArrayList<CompanyDTO> companyList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM COMPANY WHERE chiefID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, chiefID);
			rs = pstmt.executeQuery();
			companyList = new ArrayList<CompanyDTO>();
			while(rs.next()) {
				CompanyDTO companies = new CompanyDTO();
				companies.setBusinessLicenseNum(rs.getString("businessLicenseNum"));
				companies.setCorporateLicenseNum(rs.getString("corporateLicenseNum"));
				companies.setCompanyName(rs.getString("companyName"));
				companies.setCompanyEngName(rs.getString("companyEngName"));
				companies.setChiefID(rs.getString("chiefID"));
				companies.setPostNum(rs.getString("postNum"));
				companies.setAddress(rs.getString("address"));
				companies.setAddressEng(rs.getString("addressEng"));
				companies.setTel(rs.getString("tel"));
				companies.setFax(rs.getString("fax"));
				companies.setBusinessCondition(rs.getString("businessCondition"));
				companies.setBusinessType(rs.getString("businessType"));
				companies.setEstablishmentDate(rs.getString("establishmentDate"));
				companies.setStartDate(rs.getString("startDate"));
				companies.setHomepage(rs.getString("homepage"));
				companies.setMonetaryUnit(rs.getString("monetaryUnit"));
				companies.setCompanyCode(rs.getString("companyCode"));
				companyList.add(companies);
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
		return companyList;
	}
	/* 리스트 회사검색 (회사명) */
	public ArrayList<CompanyDTO> getCompanyListToCompanyName(String companyName) {
		ArrayList<CompanyDTO> companyList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM COMPANY WHERE companyName LIKE ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + companyName + "%");
			rs = pstmt.executeQuery();
			companyList = new ArrayList<CompanyDTO>();
			while(rs.next()) {
				CompanyDTO companies = new CompanyDTO();
				companies.setBusinessLicenseNum(rs.getString("businessLicenseNum"));
				companies.setCorporateLicenseNum(rs.getString("corporateLicenseNum"));
				companies.setCompanyName(rs.getString("companyName"));
				companies.setCompanyEngName(rs.getString("companyEngName"));
				companies.setChiefID(rs.getString("chiefID"));
				companies.setPostNum(rs.getString("postNum"));
				companies.setAddress(rs.getString("address"));
				companies.setAddressEng(rs.getString("addressEng"));
				companies.setTel(rs.getString("tel"));
				companies.setFax(rs.getString("fax"));
				companies.setBusinessCondition(rs.getString("businessCondition"));
				companies.setBusinessType(rs.getString("businessType"));
				companies.setEstablishmentDate(rs.getString("establishmentDate"));
				companies.setStartDate(rs.getString("startDate"));
				companies.setHomepage(rs.getString("homepage"));
				companies.setMonetaryUnit(rs.getString("monetaryUnit"));
				companies.setCompanyCode(rs.getString("companyCode"));
				companyList.add(companies);
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
		return companyList;
	}
}
