package com.uniquedeveloper.registration;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uniquedeveloper.database.Database;

@WebServlet("/DepositFundsServlet")
public class DepositFundsServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(DepositFundsServlet.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accountNo = request.getParameter("accountNo");
        double depositAmount = Double.parseDouble(request.getParameter("depositAmount"));
        String depositDate = request.getParameter("depositDate");
        String paymentMethod = request.getParameter("paymentMethod");
        String description = request.getParameter("description");

        // Queries
        String checkAccountQuery = "SELECT initial_balance FROM customer WHERE account_no = ?";
        String getLastTransactionQuery = "SELECT balance FROM transactions WHERE account_no = ? ORDER BY id DESC LIMIT 1";
        String insertTransactionQuery = "INSERT INTO transactions (account_no, transaction_type, transaction_date, amount, balance, description, payment_method) VALUES (?, 'Deposit', ?, ?, ?, ?, ?)";

        response.setContentType("text/html");

        try (Connection con = Database.getConnection();
             PreparedStatement pstmtCheckAccount = con.prepareStatement(checkAccountQuery);
             PreparedStatement pstmtGetLastTransaction = con.prepareStatement(getLastTransactionQuery);
             PreparedStatement pstmtInsertTransaction = con.prepareStatement(insertTransactionQuery)) {

            con.setAutoCommit(false);  // Start transaction and disable auto-commit

            // Check if account exists and get the initial balance
            pstmtCheckAccount.setString(1, accountNo);
            ResultSet rs = pstmtCheckAccount.executeQuery();

            if (rs.next()) {
                double initialBalance = rs.getDouble("initial_balance");

                // Get the last balance value
                pstmtGetLastTransaction.setString(1, accountNo);
                ResultSet rsLastTransaction = pstmtGetLastTransaction.executeQuery();

                double balance = initialBalance;
                if (rsLastTransaction.next()) {
                    balance = rsLastTransaction.getDouble("balance");
                }

                // Update the balance amount
                balance += depositAmount;

                // Insert new transaction
                pstmtInsertTransaction.setString(1, accountNo);
                pstmtInsertTransaction.setString(2, depositDate);
                pstmtInsertTransaction.setDouble(3, depositAmount);
                pstmtInsertTransaction.setDouble(4, balance);
                pstmtInsertTransaction.setString(5, description);
                pstmtInsertTransaction.setString(6, paymentMethod);
                pstmtInsertTransaction.executeUpdate();

                con.commit();  // Commit transaction

                // Set attributes for success message
                request.setAttribute("status", "success");
                request.setAttribute("transactionType", "Deposit");
                request.setAttribute("depositAmount", depositAmount);
                request.setAttribute("depositDate", depositDate);

                // Print the total deposited amount
                LOGGER.log(Level.INFO, "Total Deposited: {0}", balance);
            } else {
                // Account does not exist
                LOGGER.log(Level.INFO, "Account number does not exist: {0}", accountNo);
                request.setAttribute("status", "error");
                request.setAttribute("errorMessage", "Account number does not exist.");
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Database error: ", ex);
            ex.printStackTrace();
            request.setAttribute("status", "error");
            request.setAttribute("errorMessage", "Database error: " + ex.getMessage());
            try (Connection conn = Database.getConnection()) {
                conn.rollback();  // Rollback transaction in case of error
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        } finally {
            try (Connection conn = Database.getConnection()) {
                conn.setAutoCommit(true);  // Restore auto-commit mode
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        // Forward to the deposit_funds.jsp page
        request.getRequestDispatcher("deposit_funds.jsp").forward(request, response);
    }
}
