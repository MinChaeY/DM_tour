package com.servlet.step4;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.JDBCUtil;

public class MemberDAO {

    // 로그인 정보가 DB에 저장돼 있는지 확인하는 메소드 
    public boolean loginCheck(String id, String password) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean loginCon = false;

        try {
            conn = JDBCUtil.getConnection(); // 1,2단계
            String strQuery = "select id, password from membertbl where id = ? and password = ?";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, id);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery(); // 3단계
            loginCon = rs.next();
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
            JDBCUtil.close(rs, pstmt, conn); // 4단계
        }
        return loginCon;
    }

    // 회원가입 메소드
    public boolean memberInsert(MemberDTO mDto) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean insertResult = false;
        try {
            conn = JDBCUtil.getConnection(); // 1,2단계
            String insertQuery = "INSERT INTO memberTbl (id, password, nick, gen) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(insertQuery);

            pstmt.setString(1, mDto.getId());
            pstmt.setString(2, mDto.getPassword());
            pstmt.setString(3, mDto.getNick());
            pstmt.setString(4, mDto.getGen());

            int affectedRows = pstmt.executeUpdate(); // 3단계

            if (affectedRows > 0) {
                insertResult = true;
            }
        } catch (Exception ex) {
            System.out.println("Exception: " + ex);
        } finally {
            JDBCUtil.close(pstmt, conn); // 4단계
        }

        return insertResult;
    }

    
 // 사용자의 역할 정보를 가져오는 메서드(관리자 확인)
    public String getRole(String id) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String role = null;

        try {
            conn = JDBCUtil.getConnection();

            // 사용자의 역할 정보를 가져오는 SQL 쿼리를 작성
            String sql = "SELECT role FROM membertbl WHERE id = ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                role = rs.getString("role");
            }

        } finally {
            // 리소스 해제
            JDBCUtil.close(rs, pstmt, conn);
        }

        return role;
    }
    
 // 사용자의 닉네임 정보를 가져오는 메서드
    public String getNick(String id) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String nick = null;

        try {
            conn = JDBCUtil.getConnection();

            // 사용자의 닉네임 정보를 가져오는 SQL 쿼리를 작성
            String sql = "SELECT nick FROM membertbl WHERE id = ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                nick = rs.getString("nick");
            }

        } finally {
            // 리소스 해제
            JDBCUtil.close(rs, pstmt, conn);
        }

        return nick;
    }

    
    // 회원 목록 조회 메소드
    public ArrayList<MemberDTO> selectMemberList() throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        final String USER_LIST = "select * from membertbl;";

        try {
            conn = JDBCUtil.getConnection();
            pstmt = conn.prepareStatement(USER_LIST);
            rs = pstmt.executeQuery();
            ArrayList<MemberDTO> aList = new ArrayList<MemberDTO>();
            while (rs.next()) {
                MemberDTO rd = new MemberDTO();
                rd.setId(rs.getString("id"));
                rd.setPassword(rs.getString("password"));
                rd.setNick(rs.getString("nick"));
                rd.setGen(rs.getString("gen"));
                rd.setRole(rs.getInt("role"));
                aList.add(rd);
            }
            return aList;
        } finally {
            JDBCUtil.close(rs, pstmt, conn);
        }
    }
    
 // 회원 삭제 메소드
    public boolean deleteMember(String id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean deleteResult = false;

        try {
            conn = JDBCUtil.getConnection(); // 1,2단계
            String deleteQuery = "DELETE FROM membertbl WHERE id = ?";
            pstmt = conn.prepareStatement(deleteQuery);
            pstmt.setString(1, id);

            int affectedRows = pstmt.executeUpdate(); // 3단계

            if (affectedRows > 0) {
                deleteResult = true;
            }
        } catch (Exception ex) {
            System.out.println("Exception: " + ex);
        } finally {
            JDBCUtil.close(pstmt, conn); // 4단계
        }

        return deleteResult;
    }
    
 // 회원 수정 메소드
    public boolean updateMember(MemberDTO mDto) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean updateResult = false;

        try {
            conn = JDBCUtil.getConnection(); // 1,2단계
            String updateQuery = "UPDATE membertbl SET password = ?, nick = ?, gen = ?, role = ? WHERE id = ?";
            pstmt = conn.prepareStatement(updateQuery);

            pstmt.setString(1, mDto.getPassword());
            pstmt.setString(2, mDto.getNick());
            pstmt.setString(3, mDto.getGen());
            pstmt.setInt(4, mDto.getRole());
            pstmt.setString(5, mDto.getId());

            int affectedRows = pstmt.executeUpdate(); // 3단계

            if (affectedRows > 0) {
                updateResult = true;
            }
        } catch (Exception ex) {
            System.out.println("Exception: " + ex);
        } finally {
            JDBCUtil.close(pstmt, conn); // 4단계
        }

        return updateResult;
    }

 

}
