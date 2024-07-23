package com.uniquedeveloper.registration;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uniquedeveloper.database.Database;

@WebServlet("/AdminStatus")
public class AdminStatus extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accountNo = request.getParameter("accountNo");
        String status = request.getParameter("status");

        if (status != null && (status.equals("Active") || status.equals("Closed"))) {
            if (status.equals("Active")) {
                changeAccountStatus(accountNo, "Active", request, response);
            } else if (status.equals("Closed")) {
                changeAccountStatus(accountNo, "Closed", request, response);
            }
        } else {
            // Handle invalid status scenario
            request.setAttribute("status", "error");
            request.setAttribute("message", "Invalid status provided.");
            request.getRequestDispatcher("status.jsp").forward(request, response);
        }
    }

    private void changeAccountStatus(String accountNo, String status, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = "UPDATE customer SET account_status = ? WHERE account_no = ?";
        if ("Active".equals(status)) {
            query += " AND account_status = 'Closed'";
        } else if ("Closed".equals(status)) {
            query += " AND account_status = 'Active'";
        }

        try (Connection con = Database.getConnection();
             PreparedStatement pstmt = con.prepareStatement(query)) {
            
            pstmt.setString(1, status);
            pstmt.setString(2, accountNo);
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                request.setAttribute("status", "success");
                request.setAttribute("message", "Account status updated to " + status + " successfully.");
            } else {
                request.setAttribute("status", "error");
                request.setAttribute("message", "Account status could not be updated. Make sure the account is in the correct initial status.");
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            request.setAttribute("status", "error");
            request.setAttribute("message", "Database error: " + ex.getMessage());
        }

        request.getRequestDispatcher("status.jsp").forward(request, response);
    }
}
