package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
	/* 리스트 프로젝트 불러오기 */
	public ArrayList<ProjectDTO> getProjectList(String companyCode) {
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ArrayList<ProjectDTO> list = null;
		String SQL = "SELECT * FROM PROJECT WHERE COMPANYCODE = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			rs = pstmt.executeQuery();
			list = new ArrayList<ProjectDTO>();
			while(rs.next()) {
				ProjectDTO project = new ProjectDTO();
				project.setCompanyCode(rs.getString("companyCode"));
				project.setProjectCode(rs.getString("projectCode"));
				project.setProjectName(rs.getString("projectName"));
				project.setDivision(rs.getString("division"));
				project.setProjectSince(rs.getString("projectSince"));
				project.setProjectTill(rs.getString("projectTill"));
				project.setContractCompany(rs.getString("contractCompany"));
				project.setStartDate(rs.getString("startDate"));
				project.setCostDivision(rs.getString("costDivision"));
				project.setProjectType(rs.getString("projectType"));
				project.setProjectSum(rs.getString("projectSum"));
				project.setProjectGroup(rs.getString("projectGroup"));
				project.setNote(rs.getString("note"));
				project.setEmploymentManager(rs.getString("employmentManager"));
				project.setEmploymentManagerIdentityNum(rs.getString("employmentManagerIdentityNum"));
				project.setEMposition(rs.getString("EMposition"));
				project.setEMtask(rs.getString("EMtask"));
				project.setEmployment(rs.getString("employment"));
				list.add(project);
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
		return list;
	}
	/* 리스트 프로젝트 불러오기(프로젝트명) */
	public ArrayList<ProjectDTO> getProjectListToName(String companyCode, String projectName) {
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ArrayList<ProjectDTO> list = null;
		String SQL = "SELECT * FROM PROJECT WHERE companyCode = ? AND projectName LIKE ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, "%" + projectName + "%");
			rs = pstmt.executeQuery();
			list = new ArrayList<ProjectDTO>();
			while(rs.next()) {
				ProjectDTO project = new ProjectDTO();
				project.setCompanyCode(rs.getString("companyCode"));
				project.setProjectCode(rs.getString("projectCode"));
				project.setProjectName(rs.getString("projectName"));
				project.setDivision(rs.getString("division"));
				project.setProjectSince(rs.getString("projectSince"));
				project.setProjectTill(rs.getString("projectTill"));
				project.setContractCompany(rs.getString("contractCompany"));
				project.setStartDate(rs.getString("startDate"));
				project.setCostDivision(rs.getString("costDivision"));
				project.setProjectType(rs.getString("projectType"));
				project.setProjectSum(rs.getString("projectSum"));
				project.setProjectGroup(rs.getString("projectGroup"));
				project.setNote(rs.getString("note"));
				project.setEmploymentManager(rs.getString("employmentManager"));
				project.setEmploymentManagerIdentityNum(rs.getString("employmentManagerIdentityNum"));
				project.setEMposition(rs.getString("EMposition"));
				project.setEMtask(rs.getString("EMtask"));
				project.setEmployment(rs.getString("employment"));
				list.add(project);
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
		return list;
	}
	/* 리스트 프로젝트 불러오기(프로젝트 코드) */
	public ArrayList<ProjectDTO> getProjectListToCode(String companyCode, String projectCode) {
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ArrayList<ProjectDTO> list = null;
		String SQL = "SELECT * FROM PROJECT WHERE companyCode = ? AND projectCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, projectCode);
			rs = pstmt.executeQuery();
			list = new ArrayList<ProjectDTO>();
			while(rs.next()) {
				ProjectDTO project = new ProjectDTO();
				project.setCompanyCode(rs.getString("companyCode"));
				project.setProjectCode(rs.getString("projectCode"));
				project.setProjectName(rs.getString("projectName"));
				project.setDivision(rs.getString("division"));
				project.setProjectSince(rs.getString("projectSince"));
				project.setProjectTill(rs.getString("projectTill"));
				project.setContractCompany(rs.getString("contractCompany"));
				project.setStartDate(rs.getString("startDate"));
				project.setCostDivision(rs.getString("costDivision"));
				project.setProjectType(rs.getString("projectType"));
				project.setProjectSum(rs.getString("projectSum"));
				project.setProjectGroup(rs.getString("projectGroup"));
				project.setNote(rs.getString("note"));
				project.setEmploymentManager(rs.getString("employmentManager"));
				project.setEmploymentManagerIdentityNum(rs.getString("employmentManagerIdentityNum"));
				project.setEMposition(rs.getString("EMposition"));
				project.setEMtask(rs.getString("EMtask"));
				project.setEmployment(rs.getString("employment"));
				list.add(project);
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
		return list;
	}
	/* 단일 프로젝트 불러오기 */
	public ProjectDTO getProject(String companyCode, String projectCode) {
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ProjectDTO project = null;
		String SQL = "SELECT * FROM PROJECT WHERE companyCode = ? AND projectCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, projectCode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				project = new ProjectDTO();
				project.setCompanyCode(rs.getString("companyCode"));
				project.setProjectCode(rs.getString("projectCode"));
				project.setProjectName(rs.getString("projectName"));
				project.setDivision(rs.getString("division"));
				project.setProjectSince(rs.getString("projectSince"));
				project.setProjectTill(rs.getString("projectTill"));
				project.setContractCompany(rs.getString("contractCompany"));
				project.setStartDate(rs.getString("startDate"));
				project.setCostDivision(rs.getString("costDivision"));
				project.setProjectType(rs.getString("projectType"));
				project.setProjectSum(rs.getString("projectSum"));
				project.setProjectGroup(rs.getString("projectGroup"));
				project.setNote(rs.getString("note"));
				project.setEmploymentManager(rs.getString("employmentManager"));
				project.setEmploymentManagerIdentityNum(rs.getString("employmentManagerIdentityNum"));
				project.setEMposition(rs.getString("EMposition"));
				project.setEMtask(rs.getString("EMtask"));
				project.setEmployment(rs.getString("employment"));
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
		return project;
	}
	/* 프로젝트 삭제 */
	public int deleteProject(String companyCode, String projectCode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "DELETE FROM PROJECT WHERE companyCode = ? AND projectCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, projectCode);
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
	/* 프로젝트 수정 */
	public int updateProject(String companyCode, String projectCode, String projectName, String division, String projectSince, String projectTill, String contractCompany, String startDate , String costDivision , String projectType , String projectSum , String projectGroup , String note , String employmentManager , String employmentManagerIdentityNum , String EMposition , String EMtask , String employment, String editProjectCode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "UPDATE PROJECT SET projectCode = ?, projectName = ?, division = ?, projectSince = ?, projectTill = ?," +
				" contractCompany = ?, startDate = ?, costDivision = ?, projectType = ?, projectSum = ?, projectGroup = ?, note = ?," +
				" employmentManager = ?, employmentManagerIdentityNum = ?, EMposition = ?, EMtask = ?, employment = ? WHERE companyCode = ? AND projectCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, projectCode);
			pstmt.setString(2, projectName);
			pstmt.setString(3, division);
			pstmt.setString(4, projectSince);
			pstmt.setString(5, projectTill);
			pstmt.setString(6, contractCompany);
			pstmt.setString(7, startDate);
			pstmt.setString(8, costDivision);
			pstmt.setString(9, projectType);
			pstmt.setString(10, projectSum);
			pstmt.setString(11, projectGroup);
			pstmt.setString(12, note);
			pstmt.setString(13, employmentManager);
			pstmt.setString(14, employmentManagerIdentityNum);
			pstmt.setString(15, EMposition);
			pstmt.setString(16, EMtask);
			pstmt.setString(17, employment);
			pstmt.setString(18, companyCode);
			pstmt.setString(19, editProjectCode);
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
	
	/* 단일 프로젝트 이름 불러오기 */
	public String getProjectName(String companyCode, String projectCode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String name = "";
		String SQL = "SELECT projectName FROM PROJECT WHERE companyCode = ? AND projectCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, projectCode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				name = rs.getString("projectName");
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
		return name;
	}
}

