<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hotel.model.Reservation, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>预订成功</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        .success-message { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; border-radius: 5px; padding: 20px; margin-bottom: 20px; }
        .reservation-details { background-color: #f8f9fa; border: 1px solid #e9ecef; border-radius: 5px; padding: 20px; }
        .detail-row { margin-bottom: 10px; }
        .detail-label { font-weight: bold; }
        .home-button { background-color: #007BFF; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; margin-top: 20px; }
        .home-button:hover { background-color: #0069d9; }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-message">
            <h2>预订成功！</h2>
            <p>您的房间已成功预订。预订详情如下：</p>
        </div>
        
        <div class="reservation-details">
            <% 
                Reservation reservation = (Reservation) request.getAttribute("reservation");
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            %>
            <div class="detail-row">
                <span class="detail-label">预订编号:</span> 
                <span><%= reservation.getReservationId() %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">客户姓名:</span> 
                <span><%= reservation.getCustomer().getCustomerName() %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">联系电话:</span> 
                <span><%= reservation.getCustomer().getCustomerPhone() %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">房间号:</span> 
                <span><%= reservation.getRoom().getRoomNumber() %> (<%= reservation.getRoom().getRoomType() %>)</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">入住日期:</span> 
                <span><%= sdf.format(reservation.getCheckInDate()) %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">退房日期:</span> 
                <span><%= sdf.format(reservation.getCheckOutDate()) %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">总费用:</span> 
                <span>¥<%= reservation.getTotalCost() %></span>
            </div>
        </div>
        
        <button class="home-button" onclick="window.location.href='index.jsp'">返回首页</button>
    </div>
</body>
</html>    