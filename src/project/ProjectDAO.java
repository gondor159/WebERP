package project;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ProjectDAO {

	DataSource dataSource;

	public ProjectDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/WebERP");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/* 프로젝트 등록 */
	public int registproject(String companyCode, String projectCode, String projectName, String division, String projectSince, String projectTill, String contractCompany, String startDate , String costDivision , String projectType , String projectSum , String projectGroup , String note , String employmentManager , String employmentManagerIdentityNum , String EMposition , String EMtask , String employment) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO PROJECT VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, projectCode);
			pstmt.setString(3, projectName);
			pstmt.setString(4, division);
			pstmt.setString(5, projectSince);
			pstmt.setString(6, projectTill);
			pstmt.setString(7, contractCompany);
			pstmt.setString(8, startDate);
			pstmt.setString(9, costDivision);
			pstmt.setString(10, projectType);
			pstmt.setString(11, projectSum);
			pstmt.setString(12, projectGroup);
			pstmt.setString(13, note);
			pstmt.setString(14, employmentManager);
			pstmt.setString(15, employmentManagerIdentityNum);
			pstmt.setString(16, EMposition);
			pstmt.setString(17, EMtask);
			pstmt.setString(18, employment);
			return pstmt.executeUpdate();
		}catch(Exception e) {
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
}

