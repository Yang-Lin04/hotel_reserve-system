package com.hotel.servlet;

import com.hotel.dao.RoomDAO;
import com.hotel.model.Room;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import java.util.List;

@WebServlet("/searchRooms")
public class SearchRoomsServlet extends HttpServlet {

    // 日期格式化（与前端HTML5 date类型统一：yyyy-MM-dd）
    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 设置编码（避免中文乱码）
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 2. 获取前端参数
        String checkInStr = request.getParameter("checkInDate");
        String checkOutStr = request.getParameter("checkOutDate");

        // 3. 校验参数非空
        if (checkInStr == null || checkOutStr == null || checkInStr.isEmpty() || checkOutStr.isEmpty()) {
            request.setAttribute("error", "请填写完整的入住和退房日期！");
            request.getRequestDispatcher("/search.jsp").forward(request, response);
            return;
        }

        // 4. 解析日期（兼容HTML5 date的yyyy-MM-dd格式）
        java.util.Date checkInUtil = null;
        java.util.Date checkOutUtil = null;
        try {
            checkInUtil = DATE_FORMAT.parse(checkInStr);
            checkOutUtil = DATE_FORMAT.parse(checkOutStr);
        } catch (ParseException e) {
            request.setAttribute("error", "日期格式错误！请使用 yyyy-MM-dd 格式");
            // 回显用户输入，避免重新填写
            request.setAttribute("checkInDate", checkInStr);
            request.setAttribute("checkOutDate", checkOutStr);
            request.getRequestDispatcher("/search.jsp").forward(request, response);
            return;
        }

        // 5. 转换为 java.sql.Date（适配JDBC）
        Date checkInSql = new Date(checkInUtil.getTime());
        Date checkOutSql = new Date(checkOutUtil.getTime());

        // 6. 校验日期逻辑：入住日期不能早于今天
        java.util.Date today = new java.util.Date();
        if (checkInSql.before(new Date(today.getTime()))) {
            request.setAttribute("error", "入住日期不能早于今天！");
            request.setAttribute("checkInDate", checkInStr);
            request.setAttribute("checkOutDate", checkOutStr);
            request.getRequestDispatcher("/search.jsp").forward(request, response);
            return;
        }

        // 7. 校验日期逻辑：入住日期不能晚于退房日期
        if (checkInSql.after(checkOutSql)) {
            request.setAttribute("error", "入住日期不能晚于退房日期！");
            request.setAttribute("checkInDate", checkInStr);
            request.setAttribute("checkOutDate", checkOutStr);
            request.getRequestDispatcher("/search.jsp").forward(request, response);
            return;
        }

        // 8. 调用DAO查询可用房间
        RoomDAO roomDAO = new RoomDAO();
        List<Room> availableRooms = roomDAO.getAvailableRooms(checkInSql, checkOutSql);

        // 9. 处理查询结果
        request.setAttribute("availableRooms", availableRooms);
        request.setAttribute("checkInDate", checkInStr);
        request.setAttribute("checkOutDate", checkOutStr);

        // 10. 跳转结果页面（确保是 rooms.jsp）
        request.getRequestDispatcher("/rooms.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 复用GET逻辑
        doGet(request, response);
    }
}