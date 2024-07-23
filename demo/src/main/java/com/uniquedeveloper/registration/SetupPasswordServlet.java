package com.uniquedeveloper.registration;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/SetupPasswordServlet")
public class SetupPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accountNo = request.getParameter("accountNo");
        String tempPassword = request.getParameter("tempPassword");
        String newPassword = request.getParameter("newPassword");

        Connection con = null;
        PreparedStatement pst = null;
        RequestDispatcher dispatcher = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking_app", "root", "Nirmal@2919");

            // Check if the account number and temporary password are correct
            String sqlCheck = "SELECT * FROM customer WHERE account_no = ? AND temp_password = ?";
            pst = con.prepareStatement(sqlCheck);
            pst.setString(1, accountNo);
            pst.setString(2, tempPassword);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                // Hash the new password
                String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

                // Update the password and clear temp_password
                String sqlUpdate = "UPDATE customer SET password = ?, temp_password = '' WHERE account_no = ?";
                pst = con.prepareStatement(sqlUpdate);
                pst.setString(1, hashedPassword);
                pst.setString(2, accountNo);
                int rowCount = pst.executeUpdate();

                if (rowCount > 0) {
                    request.setAttribute("status", "success");
                } else {
                    request.setAttribute("status", "failed");
                }
            } else {
                request.setAttribute("status", "notfound");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("status", "error");
            request.setAttribute("errorMessage", e.getMessage()); // Capture the exception message
        } finally {
            try {
                if (pst != null) {
                    pst.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        dispatcher = request.getRequestDispatcher("setup_password.jsp");
        dispatcher.forward(request, response);
    }
}
