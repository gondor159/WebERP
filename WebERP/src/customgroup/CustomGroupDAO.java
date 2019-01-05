package customgroup;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CustomGroupDAO {
	
	DataSource dataSource;
	public CustomGroupDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/WebERP");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/* 거래처 그룹 등록 */
	public int insertCustomGroup(String companyCode, String customGroup, String groupName, String startDate, String endDate, String note) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO CUSTOMGROUP VALUES (?, ?, ?, ?, ?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, customGroup);
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
	
	/* 리스트 거래처 그룹 검색 */
	public ArrayList<CustomGroupDTO> getCustomGroupList(String companyCode) {
		ArrayList<CustomGroupDTO> list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM CUSTOMGROUP WHERE companyCode = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			rs = pstmt.executeQuery();
			list = new ArrayList<CustomGroupDTO>();
			while(rs.next()) {
				CustomGroupDTO group = new CustomGroupDTO();
				group.setCompanyCode(rs.getString("companyCode"));
				group.setCustomGroup(rs.getString("customGroup"));
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
	/* 리스트 거래처 그룹 검색 (분류명) */
	public ArrayList<CustomGroupDTO> getCustomGroupListToName(String companyCode, String groupName) {
		ArrayList<CustomGroupDTO> list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM CUSTOMGROUP WHERE companyCode = ? AND groupName LIKE ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, "%" + groupName + "%");
			rs = pstmt.executeQuery();
			list = new ArrayList<CustomGroupDTO>();
			while(rs.next()) {
				CustomGroupDTO group = new CustomGroupDTO();
				group.setCompanyCode(rs.getString("companyCode"));
				group.setCustomGroup(rs.getString("customGroup"));
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
	/* 리스트 거래처 그룹 검색 (분류코드) */
	public ArrayList<CustomGroupDTO> getCustomGroupListToCode(String companyCode, String customGroup) {
		ArrayList<CustomGroupDTO> list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM CUSTOMGROUP WHERE companyCode = ? AND customGroup = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, customGroup);
			rs = pstmt.executeQuery();
			list = new ArrayList<CustomGroupDTO>();
			while(rs.next()) {
				CustomGroupDTO group = new CustomGroupDTO();
				group.setCompanyCode(rs.getString("companyCode"));
				group.setCustomGroup(rs.getString("customGroup"));
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
	/* 단일 거래처 그룹 검색 (분류코드) */
	public CustomGroupDTO getCustomGroup(String companyCode, String customGroup) {
		CustomGroupDTO group = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM CUSTOMGROUP WHERE companyCode = ? AND customGroup = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, customGroup);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				group = new CustomGroupDTO();
				group.setCompanyCode(rs.getString("companyCode"));
				group.setCustomGroup(rs.getString("customGroup"));
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
	
	/* 단일 거래처 분류 이름 가져오기 */
	public String getCustomGroupName(String companyCode, String customGroup) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String name = "";
		String SQL = "SELECT groupName FROM CUSTOMGROUP WHERE companyCode = ? AND customGroup = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, companyCode);
			pstmt.setString(2, customGroup);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				name = rs.getString("groupName");
			}
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
		return name;
	}
}
