<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>酒店预订系统</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        h1 { color: #333; text-align: center; }
        .search-form { background-color: #f5f5f5; padding: 20px; border-radius: 5px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input[type="date"], input[type="text"] { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        button { background-color: #4CAF50; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background-color: #45a049; }
        .error { color: red; margin-bottom: 10px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>欢迎来到豪华酒店</h1>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>

        <div class="search-form">
            <h2>查询可用房间</h2>
            <form action="searchRooms" method="post">
                <div class="form-group">
                    <label>入住日期:</label>
                    <input type="date" name="checkInDate" required>
                </div>
                <div class="form-group">
                    <label>退房日期:</label>
                    <input type="date" name="checkOutDate" required>
                </div>
                <button type="submit">查询房间</button>
            </form>
        </div>
    </div>
</body>
</html>