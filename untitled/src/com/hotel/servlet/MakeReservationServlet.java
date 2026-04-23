package com.hotel.servlet;

import com.hotel.dao.CustomerDAO;
import com.hotel.dao.ReservationDAO;
import com.hotel.dao.RoomDAO;
import com.hotel.model.Customer;
import com.hotel.model.Reservation;
import com.hotel.model.Room;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/makeReservation")
public class MakeReservationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 获取表单数据
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            String checkInStr = request.getParameter("checkInDate");
            String checkOutStr = request.getParameter("checkOutDate");
            String customerName = request.getParameter("customerName");
            String customerPhone = request.getParameter("customerPhone");
            String customerEmail = request.getParameter("customerEmail");

            // 转换日期格式
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date checkInDate = sdf.parse(checkInStr);
            Date checkOutDate = sdf.parse(checkOutStr);

            // 计算入住天数
            long diffInMillis = checkOutDate.getTime() - checkInDate.getTime();
            int nights = (int) (diffInMillis / (1000 * 60 * 60 * 24));

            // 获取房间信息
            RoomDAO roomDAO = new RoomDAO();
            Room room = roomDAO.getRoomById(roomId);

            // 计算总价
            double totalCost = room.getPricePerNight().doubleValue() * nights;

            // 创建客户对象
            Customer customer = new Customer();
            customer.setCustomerName(customerName);
            customer.setCustomerPhone(customerPhone);
            customer.setCustomerEmail(customerEmail);

            // 添加客户到数据库
            CustomerDAO customerDAO = new CustomerDAO();
            int customerId = customerDAO.addCustomer(customer);
            customer.setCustomerId(customerId);

            // 创建预订对象
            Reservation reservation = new Reservation();
            reservation.setCustomer(customer);
            reservation.setRoom(room);
            reservation.setCheckInDate(checkInDate);
            reservation.setCheckOutDate(checkOutDate);
            reservation.setTotalCost(new java.math.BigDecimal(totalCost));

            // 添加预订到数据库
            ReservationDAO reservationDAO = new ReservationDAO();
            boolean success = reservationDAO.addReservation(reservation);

            if (success) {
                request.setAttribute("reservation", reservation);
                request.getRequestDispatcher("/reservationSuccess.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "预订失败，请重试");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "发生错误: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}    