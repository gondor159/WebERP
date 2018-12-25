package placebusiness;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class PlaceBusinessDAO {
	DataSource dataSource;

	public PlaceBusinessDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/WebERP");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/* 사업장 등록 */
	public int registPlace(String companyCode, String placeCode, String businessLicenseNum, String corporateLicenseNum,
			String companyName, String companyEngName, String chiefID, String postNum, String address,
			String addressEng, String tel, String fax, String businessCondition, String businessType,
			String establishmentDate, String startDate, String monetaryUnit, String taxOfiice, boolean headBoolean) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO PLACEBUSINESS VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, placeCode);
			pstmt.setString(3, businessLicenseNum);
			pstmt.setString(4, corporateLicenseNum);
			pstmt.setString(5, companyName);
			pstmt.setString(6, companyEngName);
			pstmt.setString(7, chiefID);
			pstmt.setString(8, postNum);
			pstmt.setString(9, address);
			pstmt.setString(10, addressEng);
			pstmt.setString(11, tel);
			pstmt.setString(12, fax);
			pstmt.setString(13, businessCondition);
			pstmt.setString(14, businessType);
			pstmt.setString(15, establishmentDate);
			pstmt.setString(16, startDate);
			pstmt.setString(17, monetaryUnit);
			pstmt.setString(18, taxOfiice);
			pstmt.setBoolean(19, headBoolean);
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
	/* 리스트 사업장검색 */
	public ArrayList<PlaceBusinessDTO> getPlaceList(String companyCode) {
		ArrayList<PlaceBusinessDTO> placeList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM PLACEBUSINESS WHERE companyCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			rs = pstmt.executeQuery();
			placeList = new ArrayList<PlaceBusinessDTO>();
			while(rs.next()) {
				PlaceBusinessDTO list = new PlaceBusinessDTO();
				list.setCompanyCode(rs.getString("companyCode"));
				list.setPlaceCode(rs.getString("placeCode"));
				list.setBusinessLicenseNum(rs.getString("businessLicenseNum"));
				list.setCorporateLicenseNum(rs.getString("corporateLicenseNum"));
				list.setCompanyName(rs.getString("companyName"));
				list.setCompanyEngName(rs.getString("companyEngName"));
				list.setChiefID(rs.getString("chiefID"));
				list.setPostNum(rs.getString("postNum"));
				list.setAddress(rs.getString("address"));
				list.setAddressEng(rs.getString("addressEng"));
				list.setTel(rs.getString("tel"));
				list.setFax(rs.getString("fax"));
				list.setBusinessCondition(rs.getString("businessCondition"));
				list.setBusinessType(rs.getString("businessType"));
				list.setEstablishmentDate(rs.getString("establishmentDate"));
				list.setStartDate(rs.getString("startDate"));
				list.setMonetaryUnit(rs.getString("monetaryUnit"));
				list.setTaxOfiice(rs.getString("taxOfiice"));
				list.setHeadBoolean(rs.getString("placeCode"));
				placeList.add(list);
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
		return placeList;
	}
	/* 사업장 이름 검색 */
	public String getPlaceName(String companyCode, String placeCode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT companyName FROM PLACEBUSINESS WHERE companyCode = ? AND placeCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, placeCode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString("companyName");
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
		return "";
	}
}
