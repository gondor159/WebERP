package financialInstitution;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class FinancialInstitutionDAO {
	DataSource dataSource;
	public FinancialInstitutionDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/WebERP");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/*DB INSERT*/
	public int insertFinancialInstitution(String financialInstitutionCode, String financialInstitutionName) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO FINANCIALINSTITUTION VALUES(?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, financialInstitutionCode);
			pstmt.setString(2, financialInstitutionName);
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
	
	/* DB UPDATE */
	public int updateFinancialInstitution(String editFinancialInstitutionCode, String financialInstitutionCode, String financialInstitutionName) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "UPDATE FINANCIALINSTITUTION SET financialinstitutionCode = ?, financialinstitutionName = ? WHERE financialinstitutionCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, financialInstitutionCode);
			pstmt.setString(2, financialInstitutionName);
			pstmt.setString(3, editFinancialInstitutionCode);
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
	
	/* DB DELETE*/
	public int deleteFinancialInstitution(String financialInstitutionCode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "DELETE FROM FINANCIALINSTITUTION WHERE financialInstitutionCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, financialInstitutionCode);
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
	/* 금융거래처 전체 검색 */
	public ArrayList<FinancialInstitutionDTO> getFinancialInstitution() {
		ArrayList<FinancialInstitutionDTO> list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM FINANCIALINSTITUTION";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			list = new ArrayList<FinancialInstitutionDTO>();
			while(rs.next()) {
				FinancialInstitutionDTO fi = new FinancialInstitutionDTO();
				fi.setFinancialInstitutionCode(rs.getString("financialinstitutionCode"));
				fi.setFinancialInstitutionName(rs.getString("financialinstitutionName"));
				list.add(fi);
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
	/* 금융거래처 이름 검색 */
	public ArrayList<FinancialInstitutionDTO> getFinancialInstitutionToName(String financialinstitutionName) {
		ArrayList<FinancialInstitutionDTO> list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM FINANCIALINSTITUTION WHERE financialinstitutionName LIKE ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + financialinstitutionName + "%");
			rs = pstmt.executeQuery();
			list = new ArrayList<FinancialInstitutionDTO>();
			while(rs.next()) {
				FinancialInstitutionDTO fi = new FinancialInstitutionDTO();
				fi.setFinancialInstitutionCode(rs.getString("financialinstitutionCode"));
				fi.setFinancialInstitutionName(rs.getString("financialinstitutionName"));
				list.add(fi);
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
	/* 금융거래처 코드로 검색 */
	public FinancialInstitutionDTO getFinancialInstitutionToCode(String financialinstitutionCode) {
		FinancialInstitutionDTO dto = new FinancialInstitutionDTO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM FINANCIALINSTITUTION WHERE financialinstitutionCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, financialinstitutionCode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setFinancialInstitutionCode(rs.getString("financialinstitutionCode"));
				dto.setFinancialInstitutionName(rs.getString("financialinstitutionName"));
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
		return dto;
	}
}
