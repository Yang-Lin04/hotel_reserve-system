package com.hotel.dao;

import com.hotel.db.DBConnectionManager;
import com.hotel.model.Room;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {
    // 获取可用房间（根据入住和退房日期）
    public List<Room> getAvailableRooms(Date checkInDate, Date checkOutDate) {
        List<Room> availableRooms = new ArrayList<>();
        String sql = "SELECT * FROM rooms r " +
                "WHERE r.room_id NOT IN (" +
                "    SELECT room_id FROM reservations " +
                "    WHERE ? < check_out_date AND ? > check_in_date" +
                ")";

        try (Connection conn = DBConnectionManager.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setDate(1, checkInDate);
            stmt.setDate(2, checkOutDate);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Room room = new Room();
                    room.setRoomId(rs.getInt("room_id"));
                    room.setRoomNumber(rs.getString("room_number"));
                    room.setRoomType(rs.getString("room_type"));
                    room.setPricePerNight(rs.getBigDecimal("price_per_night"));
                    room.setBooked(false); // 标记为可用
                    availableRooms.add(room);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return availableRooms;
    }
    public Room getRoomById(int roomId) {
        String sql = "SELECT * FROM rooms WHERE room_id = ?";
        Room room = null;

        try (Connection conn = DBConnectionManager.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, roomId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    room = new Room();
                    room.setRoomId(rs.getInt("room_id"));
                    room.setRoomNumber(rs.getString("room_number"));
                    room.setRoomType(rs.getString("room_type"));
                    room.setPricePerNight(rs.getBigDecimal("price_per_night"));
                    room.setBooked(rs.getBoolean("is_booked"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return room;
    }
}