package com.hotel.model;

import java.math.BigDecimal;

public class Room {
    private int roomId;
    private String roomNumber;
    private String roomType;
    private BigDecimal pricePerNight;
    private boolean isBooked;

    // 无参构造方法
    public Room() {}

    // 有参构造方法
    public Room(int roomId, String roomNumber, String roomType, BigDecimal pricePerNight, boolean isBooked) {
        this.roomId = roomId;
        this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.pricePerNight = pricePerNight;
        this.isBooked = isBooked;
    }

    // Getter和Setter方法
    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public BigDecimal getPricePerNight() {
        return pricePerNight;
    }

    public void setPricePerNight(BigDecimal pricePerNight) {
        this.pricePerNight = pricePerNight;
    }

    public boolean isBooked() {
        return isBooked;
    }

    public void setBooked(boolean booked) {
        isBooked = booked;
    }
}