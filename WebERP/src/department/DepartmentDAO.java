package department;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DepartmentDAO {
	DataSource dataSource;
	public DepartmentDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/WebERP");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/* 부서등록 */
	public int registDepartment(String companyCode, String fieldCode, String departmentCode, String departmentName) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO DEPARTMENT VALUES (?, ?, ?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, fieldCode);
			pstmt.setString(3, departmentCode);
			pstmt.setString(4, departmentName);
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
	/* 리스트 부서 검색  (회사코드)*/
	public ArrayList<DepartmentDTO> getDepartmentList(String companyCode) {
		 ArrayList<DepartmentDTO> departmentList = null;
		 Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String SQL = "SELECT * FROM DEPARTMENT WHERE companyCode = ?";
			try {
				conn = dataSource.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, companyCode);
				rs = pstmt.executeQuery();
				departmentList = new ArrayList<DepartmentDTO>();
				while(rs.next()) {
					DepartmentDTO list = new DepartmentDTO();
					list.setCompanyCode(rs.getString("companyCode"));
					list.setFieldCode(rs.getString("fieldCode"));
					list.setDepartmentCode(rs.getString("departmentCode"));
					list.setDepartmentName(rs.getString("departmentName"));
					departmentList.add(list);
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
			return departmentList;
	}
	/* 리스트 부서 검색  (회사코드, 사업장코드)*/
	public ArrayList<DepartmentDTO> getDepartmentList(String companyCode, String fieldCode) {
		 ArrayList<DepartmentDTO> departmentList = null;
		 Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String SQL = "SELECT * FROM DEPARTMENT WHERE companyCode = ? AND fieldCode = ?";
			try {
				conn = dataSource.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, companyCode);
				pstmt.setString(2, fieldCode);
				rs = pstmt.executeQuery();
				departmentList = new ArrayList<DepartmentDTO>();
				while(rs.next()) {
					DepartmentDTO list = new DepartmentDTO();
					list.setCompanyCode(rs.getString("companyCode"));
					list.setFieldCode(rs.getString("fieldCode"));
					list.setDepartmentCode(rs.getString("departmentCode"));
					list.setDepartmentName(rs.getString("departmentName"));
					departmentList.add(list);
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
			return departmentList;
	}
	/* 리스트 부서 검색  (회사코드)*/
	public ArrayList<DepartmentDTO> getDepartmentListToCompanyCode(String companyCode) {
		ArrayList<DepartmentDTO> departmentList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM DEPARTMENT WHERE companyCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			rs = pstmt.executeQuery();
			departmentList = new ArrayList<DepartmentDTO>();
			while(rs.next()) {
				DepartmentDTO list = new DepartmentDTO();
				list.setCompanyCode(rs.getString("companyCode"));
				list.setFieldCode(rs.getString("fieldCode"));
				list.setDepartmentCode(rs.getString("departmentCode"));
				list.setDepartmentName(rs.getString("departmentName"));
				departmentList.add(list);
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
			return departmentList;
	}
	/* 리스트 부서 검색  (회사코드, 부서명)*/
	public ArrayList<DepartmentDTO> getDepartmentListToDepartmentName(String companyCode, String departmentName) {
		 ArrayList<DepartmentDTO> departmentList = null;
		 Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String SQL = "SELECT * FROM DEPARTMENT WHERE companyCode = ? AND departmentName LIKE ?";
			try {
				conn = dataSource.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, companyCode);
				pstmt.setString(2, "%" + departmentName + "%");
				rs = pstmt.executeQuery();
				departmentList = new ArrayList<DepartmentDTO>();
				while(rs.next()) {
					DepartmentDTO list = new DepartmentDTO();
					list.setCompanyCode(rs.getString("companyCode"));
					list.setFieldCode(rs.getString("fieldCode"));
					list.setDepartmentCode(rs.getString("departmentCode"));
					list.setDepartmentName(rs.getString("departmentName"));
					departmentList.add(list);
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
			return departmentList;
	}
	/* 부서 이름 검색 */
	public String getDepartmentName(String companyCode, String fieldCode, String departmentCode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT departmentName FROM DEPARTMENT WHERE companyCode = ? AND fieldCode = ? AND departmentCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, fieldCode);
			pstmt.setString(3, departmentCode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString("departmentName");
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
	/* 부서 이름 검색 */
	public String getDepartmentNameOnly(String companyCode, String departmentCode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT departmentName FROM DEPARTMENT WHERE companyCode = ? AND departmentCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, departmentCode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString("departmentName");
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
