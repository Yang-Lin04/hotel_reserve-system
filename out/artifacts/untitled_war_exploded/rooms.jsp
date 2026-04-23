<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hotel.model.Room" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>可用房间列表 - 酒店预订系统</title>
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

    .search-summary {
      background-color: #e8f4fd;
      border-left: 4px solid #3498db;
      padding: 15px 20px;
      border-radius: 0 4px 4px 0;
      margin-bottom: 30px;
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
    }

    .summary-item {
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .summary-item i {
      color: #3498db;
    }

    /* 房间列表样式 */
    .room-list {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 20px;
      margin-bottom: 30px;
    }

    .room-card {
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
      overflow: hidden;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .room-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    }

    .card-header {
      padding: 15px 20px;
      background-color: #f8f9fa;
      border-bottom: 1px solid #eee;
    }

    .card-header h3 {
      font-size: 18px;
      font-weight: 600;
      color: #2c3e50;
    }

    .card-body {
      padding: 20px;
    }

    .room-info {
      margin-bottom: 15px;
    }

    .info-row {
      display: flex;
      margin-bottom: 10px;
      padding-bottom: 10px;
      border-bottom: 1px dashed #eee;
    }

    .info-label {
      width: 80px;
      color: #7f8c8d;
      font-weight: 500;
    }

    .info-value {
      flex: 1;
      color: #2c3e50;
    }

    .price {
      color: #e74c3c;
      font-weight: 600;
      font-size: 18px;
    }

    .action-btn {
      display: block;
      width: 100%;
      padding: 12px;
      background-color: #3498db;
      color: #fff;
      border: none;
      border-radius: 4px;
      text-align: center;
      cursor: pointer;
      transition: background-color 0.3s ease;
      text-decoration: none;
      font-weight: 500;
    }

    .action-btn:hover {
      background-color: #2980b9;
    }

    .empty-state {
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
      padding: 40px;
      text-align: center;
      margin-bottom: 30px;
    }

    .empty-state i {
      font-size: 60px;
      color: #f39c12;
      margin-bottom: 20px;
    }

    .empty-state h3 {
      font-size: 24px;
      font-weight: 600;
      color: #2c3e50;
      margin-bottom: 10px;
    }

    .empty-state p {
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

      .room-list {
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
    <a href="${pageContext.request.contextPath}/search.jsp" class="back-btn">
      <i class="fa fa-arrow-left"></i>
      返回查询
    </a>
  </div>
</header>

<!-- 主要内容 -->
<main class="container">
  <div class="page-title">
    <h2>可用房间列表</h2>
    <p>根据您的查询条件，以下是可用房间</p>
  </div>

  <!-- 搜索条件摘要 -->
  <div class="search-summary">
    <div class="summary-item">
      <i class="fa fa-calendar"></i>
      <span>入住日期：${checkInDate}</span>
    </div>
    <div class="summary-item">
      <i class="fa fa-calendar-check-o"></i>
      <span>退房日期：${checkOutDate}</span>
    </div>
  </div>

  <%
    List<Room> rooms = (List<Room>) request.getAttribute("availableRooms");
    if (rooms == null || rooms.isEmpty()) {
  %>

  <!-- 无可用房间提示 -->
  <div class="empty-state">
    <i class="fa fa-exclamation-triangle"></i>
    <h3>抱歉，暂无可预订房间</h3>
    <p>请尝试调整日期或选择其他房型</p>
    <a href="${pageContext.request.contextPath}/search.jsp" class="back-btn">
      <i class="fa fa-search"></i> 重新查询
    </a>
  </div>

  <% } else { %>

  <!-- 房间卡片列表 -->
  <div class="room-list">
    <% for (Room room : rooms) { %>
    <div class="room-card">
      <div class="card-header">
        <h3><%= room.getRoomNumber() %></h3>
      </div>
      <div class="card-body">
        <div class="room-info">
          <div class="info-row">
            <div class="info-label">房间类型</div>
            <div class="info-value"><%= room.getRoomType() %></div>
          </div>
          <div class="info-row">
            <div class="info-label">价格</div>
            <div class="info-value price">¥<%= room.getPricePerNight() %> / 晚</div>
          </div>
          <div class="info-row">
            <div class="info-label">状态</div>
            <div class="info-value">
              <span style="color: #27ae60; font-weight: bold;">可预订</span>
            </div>
          </div>
        </div>
        <a href="customerInfo.jsp?roomId=<%= room.getRoomId() %>&checkInDate=${checkInDate}&checkOutDate=${checkOutDate}" class="action-btn">
          <i class="fa fa-book"></i> 立即预订
        </a>
      </div>
    </div>
    <% } %>
  </div>

  <% } %>

  <div style="text-align: center; margin-top: 30px;">
    <a href="${pageContext.request.contextPath}/search.jsp" class="back-btn">
      <i class="fa fa-search"></i> 返回重新查询
    </a>
  </div>
</main>

<!-- 页脚 -->
<footer>
  <div class="container footer-content">
    <p>© 2023 酒店预订系统 | 提供优质的住宿预订服务</p>
  </div>
</footer>

<!-- 交互脚本 -->
<script>
  // 卡片悬停效果增强
  document.querySelectorAll('.room-card').forEach(card => {
    card.addEventListener('mouseenter', function() {
      this.style.transform = 'translateY(-5px)';
      this.style.boxShadow = '0 10px 25px rgba(0, 0, 0, 0.1)';
    });

    card.addEventListener('mouseleave', function() {
      this.style.transform = 'translateY(0)';
      this.style.boxShadow = '0 5px 15px rgba(0, 0, 0, 0.05)';
    });
  });
</script>
</body>
</html>