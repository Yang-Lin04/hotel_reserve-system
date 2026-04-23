package com.hotel.dao;

import com.hotel.model.Reservation;
import com.hotel.model.Customer;
import com.hotel.model.Room;
import com.hotel.db.DBConnectionManager;
import java.sql.*;
import java.util.*;

public class ReservationDAO {

    // 获取预订信息
    public Reservation getReservationById(int reservationId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Reservation reservation = null;

        try {
            conn = DBConnectionManager.getConnection();
            String sql = "SELECT * FROM reservations " +
                    "JOIN customers ON reservations.customer_id = customers.customer_id " +
                    "JOIN rooms ON reservations.room_id = rooms.room_id " +
                    "WHERE reservations.reservation_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, reservationId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                reservation = new Reservation();
                reservation.setReservationId(rs.getInt("reservation_id"));

                // 处理客户信息
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setCustomerName(rs.getString("customer_name"));
                customer.setCustomerPhone(rs.getString("customer_phone"));
                customer.setCustomerEmail(rs.getString("customer_email"));
                reservation.setCustomer(customer);

                // 处理房间信息
                Room room = new Room();
                room.setRoomId(rs.getInt("room_id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setRoomType(rs.getString("room_type"));
                room.setPricePerNight(rs.getBigDecimal("price_per_night"));
                room.setBooked(rs.getBoolean("is_booked"));
                reservation.setRoom(room);

                // 正确处理日期类型转换（从 java.sql.Date 到 java.util.Date）
                java.sql.Date sqlCheckInDate = rs.getDate("check_in_date");
                java.sql.Date sqlCheckOutDate = rs.getDate("check_out_date");

                if (sqlCheckInDate != null) {
                    reservation.setCheckInDate(new java.util.Date(sqlCheckInDate.getTime()));
                }
                if (sqlCheckOutDate != null) {
                    reservation.setCheckOutDate(new java.util.Date(sqlCheckOutDate.getTime()));
                }

                reservation.setTotalCost(rs.getBigDecimal("total_cost"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt, conn);
        }

        return reservation;
    }

    // 添加预订信息
    public boolean addReservation(Reservation reservation) {
        Connection conn = null;
        PreparedStatement stmt = null;
        int rowsAffected = 0;

        try {
            conn = DBConnectionManager.getConnection();
            String sql = "INSERT INTO reservations " +
                    "(customer_id, room_id, check_in_date, check_out_date, total_cost) " +
                    "VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);

            stmt.setInt(1, reservation.getCustomer().getCustomerId());
            stmt.setInt(2, reservation.getRoom().getRoomId());

            // 正确处理日期类型转换（从 java.util.Date 到 java.sql.Date）
            java.util.Date checkInDate = reservation.getCheckInDate();
            java.util.Date checkOutDate = reservation.getCheckOutDate();

            stmt.setDate(3, checkInDate != null ? new java.sql.Date(checkInDate.getTime()) : null);
            stmt.setDate(4, checkOutDate != null ? new java.sql.Date(checkOutDate.getTime()) : null);

            stmt.setBigDecimal(5, reservation.getTotalCost());

            rowsAffected = stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, conn);
        }

        return rowsAffected > 0;
    }

    // 关闭资源的辅助方法
    private void closeResources(ResultSet rs, Statement stmt, Connection conn) {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}