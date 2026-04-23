package com.hotel.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnectionManager {
    // MySQL 5.x 驱动的 URL 格式（移除了 serverTimezone 参数）
    private static final String URL = "jdbc:mysql://localhost:3306/hotel_db?useUnicode=true&characterEncoding=utf8";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    // 注册驱动（MySQL 5.x 需要显式注册，8.x 可省略）
    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}