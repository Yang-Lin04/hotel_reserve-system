package com.hotel.dao;

import com.hotel.db.DBConnectionManager;
import com.hotel.model.Customer;

import java.sql.*;

public class CustomerDAO {
    // 添加新客户
    public int addCustomer(Customer customer) {
        String sql = "INSERT INTO customers (customer_name, customer_phone, customer_email) " +
                "VALUES (?, ?, ?)";
        int generatedId = -1;

        try (Connection conn = DBConnectionManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, customer.getCustomerName());
            pstmt.setString(2, customer.getCustomerPhone());
            pstmt.setString(3, customer.getCustomerEmail());

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedId = rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return generatedId;
    }

    // 其他数据库操作方法省略
}    