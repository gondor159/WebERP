package projectgroup;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ProjectGroupDAO {
	DataSource dataSource;

	public ProjectGroupDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/WebERP");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/* 프로젝트 그룹 등록 */
	public int insertProjectGroup(String companyCode, String projectGroup, String groupName, String startDate, String endDate, String note) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO PROJECTGROUP VALUES (?, ?, ?, ?, ?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, projectGroup);
			pstmt.setString(3, groupName);
			pstmt.setString(4, startDate);
			pstmt.setString(5, endDate);
			pstmt.setString(6, note);
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
	
	/* 리스트 프로젝트 그룹 검색 */
	public ArrayList<ProjectGroupDTO> getProjectGroupList(String companyCode) {
		ArrayList<ProjectGroupDTO> list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM PROJECTGROUP WHERE companyCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			rs = pstmt.executeQuery();
			list = new ArrayList<ProjectGroupDTO>();
			while(rs.next()) {
				ProjectGroupDTO group = new ProjectGroupDTO();
				group.setCompanyCode(rs.getString("companyCode"));
				group.setProjectGroup(rs.getString("projectGroup"));
				group.setGroupName(rs.getString("groupName"));
				group.setStartDate(rs.getString("startDate"));
				group.setEndDate(rs.getString("endDate"));
				group.setNote(rs.getString("note"));
				list.add(group);
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
	/* 리스트 프로젝트 그룹 검색 (분류명) */
	public ArrayList<ProjectGroupDTO> getProjectGroupListToName(String companyCode, String groupName) {
		ArrayList<ProjectGroupDTO> list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM PROJECTGROUP WHERE companyCode = ? AND groupName LIKE ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, "%" + groupName + "%");
			rs = pstmt.executeQuery();
			list = new ArrayList<ProjectGroupDTO>();
			while(rs.next()) {
				ProjectGroupDTO group = new ProjectGroupDTO();
				group.setCompanyCode(rs.getString("companyCode"));
				group.setProjectGroup(rs.getString("projectGroup"));
				group.setGroupName(rs.getString("groupName"));
				group.setStartDate(rs.getString("startDate"));
				group.setEndDate(rs.getString("endDate"));
				group.setNote(rs.getString("note"));
				list.add(group);
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
	/* 리스트 프로젝트 그룹 검색 (분류코드) */
	public ArrayList<ProjectGroupDTO> getProjectGroupListToCode(String companyCode, String projectGroup) {
		ArrayList<ProjectGroupDTO> list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM PROJECTGROUP WHERE companyCode = ? AND projectGroup = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, projectGroup);
			rs = pstmt.executeQuery();
			list = new ArrayList<ProjectGroupDTO>();
			while(rs.next()) {
				ProjectGroupDTO group = new ProjectGroupDTO();
				group.setCompanyCode(rs.getString("companyCode"));
				group.setProjectGroup(rs.getString("projectGroup"));
				group.setGroupName(rs.getString("groupName"));
				group.setStartDate(rs.getString("startDate"));
				group.setEndDate(rs.getString("endDate"));
				group.setNote(rs.getString("note"));
				list.add(group);
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
	/* 단일 프로젝트 그룹 검색 (분류코드) */
	ProjectGroupDTO getProjectGroup(String companyCode, String projectGroup) {
		ProjectGroupDTO group = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM PROJECTGROUP WHERE companyCode = ? AND projectGroup = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, projectGroup);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				group = new ProjectGroupDTO();
				group.setCompanyCode(rs.getString("companyCode"));
				group.setProjectGroup(rs.getString("projectGroup"));
				group.setGroupName(rs.getString("groupName"));
				group.setStartDate(rs.getString("startDate"));
				group.setEndDate(rs.getString("endDate"));
				group.setNote(rs.getString("note"));
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
		return group;
	}
}
