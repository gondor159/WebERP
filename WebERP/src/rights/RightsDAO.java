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
				list.setRigtsName(rs.getString("rightsName"));
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
