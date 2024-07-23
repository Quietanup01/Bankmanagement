package com.uniquedeveloper.registration;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ViewCustomerServlet")
public class ViewCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Customer> customers = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking_app", "root", "Nirmal@2919");

            String sql = "SELECT * FROM customer";
            PreparedStatement pst = con.prepareStatement(sql);

            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                Customer customer = new Customer();
                
                customer.setFullName(rs.getString("name"));
                customer.setAddress(rs.getString("address"));
                customer.setMobile(rs.getString("mobile"));
                customer.setEmail(rs.getString("email"));
                customer.setAccountType(rs.getString("account_type"));
                customer.setInitialBalance(rs.getDouble("initial_balance"));
                customer.setDob(rs.getString("dob"));
                customer.setIdProof(rs.getString("id_proof"));
                customer.setAccount_status(rs.getString("account_status"));
                customers.add(customer);
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("customers", customers);
        RequestDispatcher dispatcher = request.getRequestDispatcher("view_customer.jsp");
        dispatcher.forward(request, response);
    }
}
