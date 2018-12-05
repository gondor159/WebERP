package businesstype;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BusinessTypeDAO {
	DataSource dataSource;
	public BusinessTypeDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/WebERP");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/* 업태 종목 입력 */ 
	public int insertType(String businessCondition, String businessType, String businessConditionName, String businessTypeName) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO BUSINESSTYPE VALUES(?, ?, ?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, businessCondition);
			pstmt.setString(2, businessType);
			pstmt.setString(3, businessConditionName);
			pstmt.setString(4, businessTypeName);
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
	/* 리스트 업태검색 */
	public ArrayList<String[]> searchCondition() {
		ArrayList<String[]> conditiones = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT DISTINCT businessCondition, businessConditionName FROM BUSINESSTYPE";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			conditiones = new ArrayList<String[]>();
			while(rs.next()) {
				String businessCondition = rs.getString(1);
				String businessConditionName = rs.getString(2);
				conditiones.add(new String[] {businessCondition, businessConditionName});
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
		return conditiones;
	}
	/* 리스트 종목검색 */
	public ArrayList<String[]> searchType(String businessCondition) {
		ArrayList<String[]> types = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT businessType, businessTypeName FROM BUSINESSTYPE WHERE businessCondition = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, businessCondition);
			rs = pstmt.executeQuery();
			types = new ArrayList<String[]>();
			while(rs.next()) {
				String businessType = rs.getString(1);
				String businessTypeName = rs.getString(2);
				types.add(new String[] {businessType, businessTypeName});
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
		return types;
	}
	/* 단일 업태 종목 검색 */
	public BusinessTypeDTO getBusinessType(String businessCondition, String businessType) {
		BusinessTypeDTO businessConType = new BusinessTypeDTO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM BUSINESSTYPE WHERE businessCondition = ? AND businessType = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, businessCondition);
			pstmt.setString(2, businessType);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				businessConType.setBusinessCondition(rs.getString("businessCondition"));
				businessConType.setBusinessType(rs.getString("businessType"));
				businessConType.setBusinessConditionName(rs.getString("businessConditionName"));
				businessConType.setBusinessTypeName(rs.getString("businessTypeName"));
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
		return businessConType;
	}
}
