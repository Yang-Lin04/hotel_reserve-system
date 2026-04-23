<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hotel.dao.RoomDAO, com.hotel.model.Room" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>填写预订信息 - 酒店预订系统</title>
    <style>
        /* 基础样式 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Microsoft YaHei", sans-serif;
        }

        body {
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
            min-height: 100vh;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* 头部样式 */
        header {
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo i {
            font-size: 24px;
            color: #3498db;
        }

        .logo h1 {
            font-size: 20px;
            font-weight: 600;
            color: #2c3e50;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            background: none;
            border: 1px solid #ddd;
            color: #555;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .back-btn i {
            margin-right: 5px;
        }

        .back-btn:hover {
            background-color: #f5f5f5;
            color: #3498db;
            border-color: #3498db;
        }

        /* 主要内容样式 */
        main {
            padding: 30px 0;
        }

        .page-title {
            text-align: center;
            margin-bottom: 30px;
        }

        .page-title h2 {
            font-size: 28px;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 10px;
        }

        .page-title p {
            color: #7f8c8d;
            font-size: 16px;
        }

        .error-message {
            background-color: #fce9e9;
            border-left: 4px solid #e74c3c;
            padding: 15px;
            margin-bottom: 30px;
            border-radius: 0 4px 4px 0;
        }

        .error-message p {
            color: #e74c3c;
            font-weight: 500;
        }

        /* 卡片样式 */
        .card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 30px;
            margin-bottom: 30px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .card-header i {
            font-size: 20px;
            color: #3498db;
            margin-right: 10px;
        }

        .card-header h3 {
            font-size: 20px;
            font-weight: 600;
            color: #2c3e50;
        }

        .room-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .info-item {
            padding: 15px;
            background-color: #f9f9f9;
            border-radius: 6px;
        }

        .info-item label {
            display: block;
            font-size: 14px;
            color: #7f8c8d;
            margin-bottom: 5px;
        }

        .info-item p {
            font-size: 16px;
            font-weight: 500;
            color: #2c3e50;
        }

        .price {
            color: #e74c3c;
        }

        .available {
            color: #27ae60;
        }

        .unavailable {
            color: #e74c3c;
        }

        /* 表单样式 */
        .form-group {
            margin-bottom: 20px;
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        label {
            display: block;
            font-size: 14px;
            color: #7f8c8d;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .required::after {
            content: " *";
            color: #e74c3c;
        }

        input, select, textarea {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
        }

        .submit-btn {
            display: block;
            width: 100%;
            padding: 15px;
            background-color: #3498db;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .submit-btn:hover {
            background-color: #2980b9;
        }

        /* 错误提示样式 */
        .error-card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 40px;
            text-align: center;
            margin-bottom: 30px;
        }

        .error-card i {
            font-size: 60px;
            color: #e74c3c;
            margin-bottom: 20px;
        }

        .error-card h3 {
            font-size: 24px;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 10px;
        }

        .error-card p {
            color: #7f8c8d;
            margin-bottom: 20px;
        }

        /* 页脚样式 */
        footer {
            background-color: #2c3e50;
            color: #ecf0f1;
            padding: 30px 0;
            margin-top: 50px;
        }

        .footer-content {
            text-align: center;
        }

        .footer-content p {
            font-size: 14px;
            color: #bdc3c7;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .page-title h2 {
                font-size: 24px;
            }

            .card {
                padding: 20px;
            }

            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<!-- 头部 -->
<header>
    <div class="container header-content">
        <div class="logo">
            <i class="fa fa-building-o"></i>
            <h1>酒店预订系统</h1>
        </div>
        <a href="rooms.jsp" class="back-btn">
            <i class="fa fa-arrow-left"></i>
            返回房间列表
        </a>
    </div>
</header>

<!-- 主要内容 -->
<main class="container">
    <div class="page-title">
        <h2>填写预订信息</h2>
        <p>请填写以下信息完成房间预订</p>
    </div>

    <!-- 错误提示 -->
    <c:if test="${not empty error}">
        <div class="error-message">
            <p><i class="fa fa-exclamation-circle"></i> ${error}</p>
        </div>
    </c:if>

    <%
        try {
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            RoomDAO roomDAO = new RoomDAO();
            Room room = roomDAO.getRoomById(roomId);

            if (room != null) {
    %>

    <!-- 房间信息卡片 -->
    <div class="card">
        <div class="card-header">
            <i class="fa fa-room"></i>
            <h3>房间信息</h3>
        </div>
        <div class="room-info">
            <div class="info-item">
                <label>房间号</label>
                <p><%= room.getRoomNumber() %></p>
            </div>
            <div class="info-item">
                <label>房间类型</label>
                <p><%= room.getRoomType() %></p>
            </div>
            <div class="info-item">
                <label>价格</label>
                <p class="price"><%= room.getPricePerNight() %> 元/晚</p>
            </div>

        </div>
    </div>

    <!-- 预订表单 -->
    <div class="card">
        <form action="makeReservation" method="post">
            <input type="hidden" name="roomId" value="<%= room.getRoomId()%>">

            <div class="card-header">
                <i class="fa fa-user-plus"></i>
                <h3>客户与预订信息</h3>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="checkInDate" class="required">入住日期</label>
                    <input type="date" id="checkInDate" name="checkInDate" required>
                </div>
                <div class="form-group">
                    <label for="checkOutDate" class="required">退房日期</label>
                    <input type="date" id="checkOutDate" name="checkOutDate" required>
                </div>
                <div class="form-group">
                    <label for="customerName" class="required">客户姓名</label>
                    <input type="text" id="customerName" name="customerName" required>
                </div>
                <div class="form-group">
                    <label for="customerPhone" class="required">联系电话</label>
                    <input type="text" id="customerPhone" name="customerPhone" required>
                </div>
                <div class="form-group">
                    <label for="customerEmail">电子邮箱</label>
                    <input type="email" id="customerEmail" name="customerEmail">
                </div>
            </div>

            <button type="submit" class="submit-btn">
                <i class="fa fa-check-circle"></i> 确认预订
            </button>
        </form>
    </div>

    <%
    } else {
    %>

    <!-- 房间不存在提示 -->
    <div class="error-card">
        <i class="fa fa-exclamation-triangle"></i>
        <h3>房间信息不存在</h3>
        <p>您请求的房间可能已被删除或不存在</p>
        <a href="rooms.jsp" class="back-btn">
            <i class="fa fa-arrow-left"></i> 返回房间列表
        </a>
    </div>

    <%
        }
    } catch (Exception e) {
    %>

    <!-- 错误提示 -->
    <div class="error-card">
        <i class="fa fa-exclamation-triangle"></i>
        <h3>获取房间信息失败</h3>
        <p>处理请求时发生错误，请稍后再试</p>
        <a href="rooms.jsp" class="back-btn">
            <i class="fa fa-arrow-left"></i> 返回房间列表
        </a>
    </div>

    <%
        }
    %>
</main>

<!-- 页脚 -->
<footer>
    <div class="container footer-content">
        <p>© 2023 酒店预订系统 | 提供优质的住宿预订服务</p>
    </div>
</footer>

<!-- 前端验证脚本 -->
<script>
    // 表单验证
    document.querySelector('form').addEventListener('submit', function(e) {
        const checkInDate = document.getElementById('checkInDate').value;
        const checkOutDate = document.getElementById('checkOutDate').value;

        // 验证日期
        if (checkInDate && checkOutDate) {
            const inDate = new Date(checkInDate);
            const outDate = new Date(checkOutDate);

            if (outDate <= inDate) {
                alert('退房日期必须晚于入住日期');
                e.preventDefault();
            }
        }
    });
</script>
</body>
</html>