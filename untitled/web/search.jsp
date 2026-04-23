<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>酒店房间查询 - 预订系统</title>
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
      max-width: 600px;
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

    /* 主要内容样式 */
    main {
      padding: 50px 0;
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

    /* 表单样式 */
    .form-card {
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
      padding: 30px;
      margin-bottom: 30px;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .form-card:hover {
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-label {
      display: block;
      font-size: 16px;
      color: #2c3e50;
      margin-bottom: 10px;
      font-weight: 500;
    }

    .form-input {
      width: 100%;
      padding: 12px 15px;
      border: 1px solid #ddd;
      border-radius: 4px;
      font-size: 16px;
      transition: border-color 0.3s ease;
    }

    .form-input:focus {
      outline: none;
      border-color: #3498db;
      box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
    }

    .error-message {
      background-color: #fce9e9;
      border-left: 4px solid #e74c3c;
      padding: 15px;
      margin-bottom: 20px;
      border-radius: 0 4px 4px 0;
    }

    .error-message p {
      color: #e74c3c;
      font-weight: 500;
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

    .submit-btn i {
      margin-right: 5px;
    }

    /* 页脚样式 */
    footer {
      background-color: #2c3e50;
      color: #ecf0f1;
      padding: 20px 0;
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

      .form-card {
        padding: 20px;
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
    <a href="<%= request.getContextPath() %>/" class="back-btn">
      <i class="fa fa-home"></i> 首页
    </a>
  </div>
</header>

<!-- 主要内容 -->
<main class="container">
  <div class="page-title">
    <h2>查询可用房间</h2>
    <p>请输入入住和退房日期进行查询</p>
  </div>

  <!-- 错误提示 -->
  <%
    String errorMsg = (String) request.getAttribute("error");
    if (errorMsg != null) {
  %>
  <div class="error-message">
    <p><i class="fa fa-exclamation-circle"></i> <%= errorMsg %></p>
  </div>
  <% } %>

  <!-- 查询表单 -->
  <div class="form-card">
    <form action="<%= request.getContextPath() %>/searchRooms" method="get">
      <div class="form-group">
        <label for="checkInDate" class="form-label">
          <i class="fa fa-calendar"></i> 入住日期
        </label>
        <input type="date" id="checkInDate" name="checkInDate"
               value="<%= request.getParameter("checkInDate") != null ? request.getParameter("checkInDate") : "" %>"
               class="form-input" required>
      </div>

      <div class="form-group">
        <label for="checkOutDate" class="form-label">
          <i class="fa fa-calendar-check-o"></i> 退房日期
        </label>
        <input type="date" id="checkOutDate" name="checkOutDate"
               value="<%= request.getParameter("checkOutDate") != null ? request.getParameter("checkOutDate") : "" %>"
               class="form-input" required>
      </div>

      <button type="submit" class="submit-btn">
        <i class="fa fa-search"></i> 查询可用房间
      </button>
    </form>
  </div>
</main>

<!-- 页脚 -->
<footer>
  <div class="container footer-content">
    <p>© 2023 酒店预订系统 | 提供优质的住宿预订服务</p>
  </div>
</footer>

<!-- 前端验证脚本 -->
<script>
  // 设置日期选择器的最小值为今天
  document.addEventListener('DOMContentLoaded', function() {
    const today = new Date().toISOString().split('T')[0];
    document.getElementById('checkInDate').min = today;

    // 如果已有入住日期，设置退房日期的最小值
    const checkInDate = document.getElementById('checkInDate').value;
    if (checkInDate) {
      document.getElementById('checkOutDate').min = checkInDate;
    }

    // 当入住日期改变时，更新退房日期的最小值
    document.getElementById('checkInDate').addEventListener('change', function() {
      document.getElementById('checkOutDate').min = this.value;
    });
  });
</script>
</body>
</html>