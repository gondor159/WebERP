package employee;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class EmployeeDAO {
	DataSource dataSource;
	public EmployeeDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/WebERP");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/* 사원등록 */
	public int registEmployee(String companyCode, String employeeNum, String placeCode, String userID, String fieldCode, String departmentCode, String positionCode, String allowance, String allowanceType, String joinDate) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO EMPLOYEE VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, employeeNum);
			pstmt.setString(3, placeCode);
			pstmt.setString(4, userID);
			pstmt.setString(5, fieldCode);
			pstmt.setString(6, departmentCode);
			pstmt.setString(7, positionCode);
			pstmt.setString(8, allowance);
			pstmt.setString(9, allowanceType);
			pstmt.setString(10, joinDate);
			pstmt.setString(11, "");
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
	/* 단일 사원찾기 (아이디) */
	public EmployeeDTO getEmployee(String userID) {
		EmployeeDTO employee = new EmployeeDTO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM EMPLOYEE WHERE userID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				employee.setCompanyCode(rs.getString("companyCode"));
				employee.setEmployeeNum(rs.getString("employeeNum"));
				employee.setPlaceCode(rs.getString("placeCode"));
				employee.setUserID(userID);
				employee.setFieldCode(rs.getString("fieldCode"));
				employee.setDepartmentCode(rs.getString("departmentCode"));
				employee.setPositionCode(rs.getString("positionCode"));
				employee.setAllowance(rs.getString("allowance"));
				employee.setAllowanceType(rs.getString("allowanceType"));
				employee.setJoinDate(rs.getString("joinDate"));
				employee.setEmployeeExtension(rs.getString("employeeExtension"));
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
		return employee;
	}
	/* 리스트 사원찾기 (회사코드) */
	public ArrayList<EmployeeDTO> getEmployeeListToCompany(String companyCode) {
		ArrayList<EmployeeDTO> employeeList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM EMPLOYEE WHERE companycode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			rs = pstmt.executeQuery();
			employeeList = new ArrayList<EmployeeDTO>();
			while(rs.next()) {
				EmployeeDTO employees = new EmployeeDTO();
				employees.setCompanyCode(rs.getString("companyCode"));
				employees.setEmployeeNum(rs.getString("employeeNum"));
				employees.setPlaceCode(rs.getString("placeCode"));
				employees.setUserID(rs.getString("userID"));
				employees.setFieldCode(rs.getString("fieldCode"));
				employees.setDepartmentCode(rs.getString("departmentCode"));
				employees.setPositionCode(rs.getString("positionCode"));
				employees.setAllowance(rs.getString("allowance"));
				employees.setAllowanceType(rs.getString("allowanceType"));
				employees.setJoinDate(rs.getString("joinDate"));
				employees.setEmployeeExtension(rs.getString("employeeExtension"));
				employeeList.add(employees);
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
		return employeeList;
	}
	/* 리스트 사원찾기 (부문코드) */
	public ArrayList<EmployeeDTO> getEmployeeListToField(String companyCode, String fieldCode) {
		ArrayList<EmployeeDTO> employeeList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM EMPLOYEE WHERE companyCode = ? AND fieldCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, fieldCode);
			rs = pstmt.executeQuery();
			employeeList = new ArrayList<EmployeeDTO>();
			while(rs.next()) {
				EmployeeDTO employees = new EmployeeDTO();
				employees.setCompanyCode(rs.getString("companyCode"));
				employees.setEmployeeNum(rs.getString("employeeNum"));
				employees.setUserID(rs.getString("userID"));
				employees.setFieldCode(rs.getString("fieldCode"));
				employees.setDepartmentCode(rs.getString("departmentCode"));
				employees.setPositionCode(rs.getString("positionCode"));
				employees.setAllowance(rs.getString("allowance"));
				employees.setAllowanceType(rs.getString("allowanceType"));
				employees.setJoinDate(rs.getString("joinDate"));
				employees.setEmployeeExtension(rs.getString("employeeExtension"));
				employeeList.add(employees);
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
		return employeeList;
	}
	/* 리스트 사원찾기 (부서) */
	public ArrayList<EmployeeDTO> getEmployeeListToDepartment(String companyCode, String fieldCode, String departmentCode) {
		ArrayList<EmployeeDTO> employeeList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM EMPLOYEE WHERE companyCode = ? AND fieldCode = ? AND departmentCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, fieldCode);
			pstmt.setString(3, departmentCode);
			rs = pstmt.executeQuery();
			employeeList = new ArrayList<EmployeeDTO>();
			while(rs.next()) {
				EmployeeDTO employees = new EmployeeDTO();
				employees.setCompanyCode(rs.getString("companyCode"));
				employees.setEmployeeNum(rs.getString("employeeNum"));
				employees.setUserID(rs.getString("userID"));
				employees.setFieldCode(rs.getString("fieldCode"));
				employees.setDepartmentCode(rs.getString("departmentCode"));
				employees.setPositionCode(rs.getString("positionCode"));
				employees.setAllowance(rs.getString("allowance"));
				employees.setAllowanceType(rs.getString("allowanceType"));
				employees.setJoinDate(rs.getString("joinDate"));
				employees.setEmployeeExtension(rs.getString("employeeExtension"));
				employeeList.add(employees);
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
		return employeeList;
	}
	/* 리스트 사원찾기 (직위) */
	public ArrayList<EmployeeDTO> getEmployeeListToPosition(String companyCode, String positionCode) {
		ArrayList<EmployeeDTO> employeeList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM EMPLOYEE WHERE companyCode = ? AND departmentCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, positionCode);
			rs = pstmt.executeQuery();
			employeeList = new ArrayList<EmployeeDTO>();
			while(rs.next()) {
				EmployeeDTO employees = new EmployeeDTO();
				employees.setCompanyCode(rs.getString("companyCode"));
				employees.setEmployeeNum(rs.getString("employeeNum"));
				employees.setUserID(rs.getString("userID"));
				employees.setFieldCode(rs.getString("fieldCode"));
				employees.setDepartmentCode(rs.getString("departmentCode"));
				employees.setPositionCode(rs.getString("positionCode"));
				employees.setAllowance(rs.getString("allowance"));
				employees.setAllowanceType(rs.getString("allowanceType"));
				employees.setJoinDate(rs.getString("joinDate"));
				employees.setEmployeeExtension(rs.getString("employeeExtension"));
				employeeList.add(employees);
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
		return employeeList;
	}
	/* 단일 사원찾기 (회사코드, 사원번호) */
	public EmployeeDTO findEmployee(String companyCode, String employeeNum) {
		EmployeeDTO employee = new EmployeeDTO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM EMPLOYEE WHERE companyCode = ? AND employeeNum = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, employeeNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				employee.setCompanyCode(rs.getString("companyCode"));
				employee.setEmployeeNum(rs.getString("employeeNum"));
				employee.setUserID(rs.getString("userID"));
				employee.setFieldCode(rs.getString("fieldCode"));
				employee.setDepartmentCode(rs.getString("departmentCode"));
				employee.setPositionCode(rs.getString("positionCode"));
				employee.setAllowance(rs.getString("allowance"));
				employee.setAllowanceType(rs.getString("allowanceType"));
				employee.setJoinDate(rs.getString("joinDate"));
				employee.setEmployeeExtension(rs.getString("employeeExtension"));
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
		return employee;
	}
}
