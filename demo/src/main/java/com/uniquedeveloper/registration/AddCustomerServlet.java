package com.uniquedeveloper.registration;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Random;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddCustomerServlet")
public class AddCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("fullName");
        String address = request.getParameter("address");
        String mobile = request.getParameter("mobile");
        String email = request.getParameter("email");
        String accountType = request.getParameter("accountType");
        String initialBalance = request.getParameter("initialBalance");
        String dob = request.getParameter("dob");
        String idProof = request.getParameter("idProof");

        // Generate account number and temporary password
        String accountNo = generateAccountNo();
        String tempPassword = generateTempPassword();

        Connection con = null;
        PreparedStatement pst = null;
        RequestDispatcher dispatcher = null;

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection to the database
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking_app", "root", "Nirmal@2919");

            // Insert customer details into the database
            String sql = "INSERT INTO customer (name, address, mobile, email, account_type, initial_balance, dob, id_proof, account_no, temp_password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pst = con.prepareStatement(sql);

            pst.setString(1, name);
            pst.setString(2, address);
            pst.setString(3, mobile);
            pst.setString(4, email);
            pst.setString(5, accountType);
            pst.setDouble(6, Double.parseDouble(initialBalance)); // Assuming initial_balance is numeric in the database
            pst.setString(7, dob);
            pst.setString(8, idProof);
            pst.setString(9, accountNo);
            pst.setString(10, tempPassword);

            int rowCount = pst.executeUpdate();

            if (rowCount > 0) {
                request.setAttribute("status", "success");
                request.setAttribute("accountNo", accountNo);
                request.setAttribute("tempPassword", tempPassword);
            } else {
                request.setAttribute("status", "failed");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("status", "error");
        } finally {
            try {
                if (pst != null) {
                    pst.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        dispatcher = request.getRequestDispatcher("add_customer.jsp");
        dispatcher.forward(request, response);
    }

    private String generateAccountNo() {
        // Generate account number (for example, a random 8-digit number)
        Random rand = new Random();
        int accountNumber = rand.nextInt(90000000) + 10000000; // Generates an 8-digit random number
        return String.valueOf(accountNumber);
    }

    private String generateTempPassword() {
        // Generate temporary password (for example, a random alphanumeric string)
        String allowedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder(8);
        Random rand = new Random();
        for (int i = 0; i < 8; i++) {
            sb.append(allowedChars.charAt(rand.nextInt(allowedChars.length())));
        }
        return sb.toString();
    }
}
