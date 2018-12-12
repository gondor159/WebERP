package field;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class FieldDAO {
	DataSource dataSource;
	public FieldDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/WebERP");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/* 부문 등록 */
	public int registField(String companyCode, String fieldCode, String fieldName) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO Field VALUES (?, ?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, fieldCode);
			pstmt.setString(3, fieldName);
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
	/* 부문 이름 검색 */
	public String getFieldName(String companyCode, String fieldCode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT fieldName FROM FIELD WHERE companyCode = ? AND fieldCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, fieldCode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString("fieldName");
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
		return "";
	}
	/* 리스트 부문 검색 */
	public ArrayList<FieldDTO> getFieldList(String companyCode) {
		 ArrayList<FieldDTO> fieldList = null;
		 Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String SQL = "SELECT * FROM FIELD WHERE companyCode = ?";
			try {
				conn = dataSource.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, companyCode);
				rs = pstmt.executeQuery();
				fieldList = new ArrayList<FieldDTO>();
				while(rs.next()) {
					FieldDTO list = new FieldDTO();
					list.setCompanyCode(rs.getString("companyCode"));
					list.setFieldCode(rs.getString("fieldCode"));
					list.setFieldName(rs.getString("fieldName"));
					fieldList.add(list);
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
			return fieldList;
	}
}
