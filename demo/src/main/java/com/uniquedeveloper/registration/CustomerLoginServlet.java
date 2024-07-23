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
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/CustomerLoginServlet")
public class CustomerLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accountNo = request.getParameter("accountNo").trim();
        String password = request.getParameter("password");

        Connection con = null;
        PreparedStatement pst = null;
        RequestDispatcher dispatcher = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking_app", "root", "Nirmal@2919");

            // Check if the account number exists
            String sqlCheck = "SELECT * FROM customer WHERE account_no = ?";
            pst = con.prepareStatement(sqlCheck);
            pst.setString(1, accountNo);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");
                String accountStatus = rs.getString("account_status");

                // Verify the password
                if (BCrypt.checkpw(password, storedPassword)) {
                    if ("Active".equals(accountStatus) || accountStatus == null) {
                        // Retrieve initial balance
                        double initialBalance = rs.getDouble("initial_balance");

                        // Store account details in session
                        HttpSession session = request.getSession();
                        session.setAttribute("accountNo", accountNo);
                        session.setAttribute("name", rs.getString("name"));
                        session.setAttribute("initialBalance", initialBalance); // Store initial balance in session

                        // Redirect to customer dashboard
                        dispatcher = request.getRequestDispatcher("customer_dashboard.jsp");
                    } else {
                        // Account status is not active (e.g., closed)
                        dispatcher = request.getRequestDispatcher("customer_login.jsp");
                        request.setAttribute("status", "error");
                        request.setAttribute("errorMessage", "Account is closed and cannot be accessed. Please contact your Admin");
                        
                       
                    }
                } else {
                    // Check if the account exists but password is not set (redirect to setup password)
                    String sqlCheckTempPassword = "SELECT * FROM customer WHERE account_no = ? AND temp_password = ?";
                    pst = con.prepareStatement(sqlCheckTempPassword);
                    pst.setString(1, accountNo);
                    pst.setString(2, password);
                    rs = pst.executeQuery();

                    if (rs.next()) {
                        // If temp password is set, redirect to setup password page
                        dispatcher = request.getRequestDispatcher("setup_password.jsp");
                    } else {
                        // Invalid credentials
                        dispatcher = request.getRequestDispatcher("customer_login.jsp");
                        request.setAttribute("status", "error");
                        request.setAttribute("errorMessage", "Invalid account number or password.");
                    }
                }
            } else {
                // Account number does not exist
                dispatcher = request.getRequestDispatcher("customer_login.jsp");
                request.setAttribute("status", "error");
                request.setAttribute("errorMessage", "Invalid account number or password.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("status", "error");
            request.setAttribute("errorMessage", e.getMessage()); // Capture the exception message
            dispatcher = request.getRequestDispatcher("newlogin.jsp");
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

        dispatcher.forward(request, response);
    }
}
