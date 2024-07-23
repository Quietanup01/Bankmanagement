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

@WebServlet("/ModifyCustomerServlet")
public class ModifyCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("Action: " + action);
        
        if ("update".equals(action)) {
            // Update customer details
            String accountNo = request.getParameter("accountNo");
            String fullName = request.getParameter("fullName");
            String address = request.getParameter("address");
            String mobile = request.getParameter("mobile");
            String email = request.getParameter("email");
            String accountType = request.getParameter("accountType");
            String dob = request.getParameter("dob");
            String idProof = request.getParameter("idProof");

            System.out.println("Updating customer with accountNo: " + accountNo);
            
            // Trim and handle null values
            if (fullName != null) fullName = fullName.trim();
            if (address != null) address = address.trim();
            if (mobile != null) mobile = mobile.trim();
            if (email != null) email = email.trim();
            if (dob != null) dob = dob.trim();
            if (idProof != null) idProof = idProof.trim();

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking_app?useSSL=false&requireSSL=false", "root", "Nirmal@2919");

                String sql = "UPDATE customer SET name = ?, address = ?, mobile = ?, email = ?, account_type = ?, dob = ?, id_proof = ? WHERE account_no = ?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, fullName);
                pst.setString(2, address);
                pst.setString(3, mobile);
                pst.setString(4, email);
                pst.setString(5, accountType);
                pst.setString(6, dob);
                pst.setString(7, idProof);
                pst.setString(8, accountNo);

                int rowCount = pst.executeUpdate();
                System.out.println("Update row count: " + rowCount);

                RequestDispatcher dispatcher = request.getRequestDispatcher("modify_customer.jsp");
                if (rowCount > 0) {
                    request.setAttribute("status", "success");
                } else {
                    request.setAttribute("status", "failed");
                }
                dispatcher.forward(request, response);
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            // Search customer by account number
            String accountNo = request.getParameter("accountNo");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking_app?useSSL=false&requireSSL=false", "root", "Nirmal@2919");

                String sql = "SELECT * FROM customer WHERE account_no = ?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, accountNo);
                ResultSet rs = pst.executeQuery();

                if (rs.next()) {
                    Customer customer = new Customer();
                    customer.setAccountNo(rs.getString("account_no"));
                    customer.setFullName(rs.getString("name"));
                    customer.setAddress(rs.getString("address"));
                    customer.setMobile(rs.getString("mobile"));
                    customer.setEmail(rs.getString("email"));
                    customer.setAccountType(rs.getString("account_type"));
                    customer.setDob(rs.getString("dob"));
                    customer.setIdProof(rs.getString("id_proof"));

                    request.setAttribute("customer", customer);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("modify_customer.jsp");
                    dispatcher.forward(request, response);
                } else {
                    request.setAttribute("status", "notfound");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("modify_customer.jsp");
                    dispatcher.forward(request, response);
                }
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
