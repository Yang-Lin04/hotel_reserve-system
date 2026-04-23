package com.hotel.model;

import java.math.BigDecimal;
import java.util.Date;

public class Reservation {
    private int reservationId;
    private Customer customer;
    private Room room;
    private Date checkInDate;
    private Date checkOutDate;
    private BigDecimal totalCost;

    // 无参构造方法
    public Reservation() {}

    // 有参构造方法
    public Reservation(int reservationId, Customer customer, Room room, Date checkInDate, Date checkOutDate, BigDecimal totalCost) {
        this.reservationId = reservationId;
        this.customer = customer;
        this.room = room;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.totalCost = totalCost;
    }

    // Getter和Setter方法
    public int getReservationId() {
        return reservationId;
    }

    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }

    public Date getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(Date checkInDate) {
        this.checkInDate = checkInDate;
    }

    public Date getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(Date checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public BigDecimal getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(BigDecimal totalCost) {
        this.totalCost = totalCost;
    }
}