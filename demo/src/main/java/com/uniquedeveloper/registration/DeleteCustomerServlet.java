package com.uniquedeveloper.registration;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteCustomerServlet")
public class DeleteCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accountNo = request.getParameter("accountNo");
        System.out.println("Account Number: " + accountNo);

        Connection con = null;
        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking_app", "root", "Nirmal@2919");
            System.out.println("Database connection established.");

            boolean customerExists = false;
            boolean transactionsExist = false;

            // Check if customer exists
            String checkCustomerSql = "SELECT * FROM customer WHERE account_no = ?";
            PreparedStatement checkCustomerPst = con.prepareStatement(checkCustomerSql);
            checkCustomerPst.setString(1, accountNo);
            ResultSet customerRs = checkCustomerPst.executeQuery();

            if (customerRs.next()) {
                System.out.println("Customer found.");
                customerExists = true;
            } 

            // Check if transactions exist for the account number
            String checkTransactionSql = "SELECT * FROM transactions WHERE account_no = ?";
            PreparedStatement checkTransactionPst = con.prepareStatement(checkTransactionSql);
            checkTransactionPst.setString(1, accountNo);
            ResultSet transactionRs = checkTransactionPst.executeQuery();

            if (transactionRs.next()) {
                System.out.println("Transactions found.");
                transactionsExist = true;
            }

            // Perform deletion if either customer or transactions exist
            if (customerExists || transactionsExist) {
                // Delete from transactions table
                String deleteTransactionsSql = "DELETE FROM transactions WHERE account_no = ?";
                PreparedStatement deleteTransactionsPst = con.prepareStatement(deleteTransactionsSql);
                deleteTransactionsPst.setString(1, accountNo);
                int transactionRowCount = deleteTransactionsPst.executeUpdate();
                System.out.println("Transactions Rows affected: " + transactionRowCount);

                // Delete from customer table
                String deleteCustomerSql = "DELETE FROM customer WHERE account_no = ?";
                PreparedStatement deleteCustomerPst = con.prepareStatement(deleteCustomerSql);
                deleteCustomerPst.setString(1, accountNo);
                int customerRowCount = deleteCustomerPst.executeUpdate();
                System.out.println("Customer Rows affected: " + customerRowCount);

                if (transactionRowCount > 0 || customerRowCount > 0) {
                    request.setAttribute("status", "success");
                } else {
                    request.setAttribute("status", "failed");
                }
            } else {
                System.out.println("No records found for account number.");
                request.setAttribute("status", "no_records_found");
            }

            // Forward request to delete_customer.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("delete_customer.jsp");
            dispatcher.forward(request, response);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
