package rights;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class RightsDAO {
	DataSource dataSource;

	
	
	public RightsDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/WebERP");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/* DB 입력 */
	public int insertrights(String rightsCode, String rightsName) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO RIGHTS VALUES(?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, rightsCode);
			pstmt.setString(2, rightsName);
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
	
	/* DB 수정 */
	public int updaterights(String editRightsCode, String rightsCode, String rightsName) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "UPDATE RIGHTS SET rightsCode = ?, rightsName = ? WHERE rightsCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, rightsCode);
			pstmt.setString(2, rightsName);
			pstmt.setString(3, editRightsCode);
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
	
	/* DB 삭제 */
	public int deleterights(String rightsCode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "DELETE FROM RIGHTS WHERE rightsCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, rightsCode);
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
	
	/* 리스트 불러오기 */
	public ArrayList<RightsDTO> getRightsList() {
		ArrayList<RightsDTO> rightList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM RIGHTS";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			rightList = new ArrayList<RightsDTO>();
			while(rs.next()) {
				RightsDTO list = new RightsDTO();
				list.setRightsCode(rs.getString("rightsCode"));
				list.setRightsName(rs.getString("rightsName"));
				rightList.add(list);
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
		return rightList;
	}
}
