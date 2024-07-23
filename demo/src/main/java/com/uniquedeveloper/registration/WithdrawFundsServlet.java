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

@WebServlet("/WithdrawFundsServlet")
public class WithdrawFundsServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(WithdrawFundsServlet.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accountNo = request.getParameter("accountNo");
        String withdrawAmountStr = request.getParameter("withdrawAmount");
        String transactionDate = request.getParameter("transactionDate");
        String paymentMethod = request.getParameter("paymentMethod");
        String description = request.getParameter("description");

        LOGGER.log(Level.INFO, "Received withdrawal request: accountNo={0}, withdrawAmount={1}, transactionDate={2}, paymentMethod={3}, description={4}",
                new Object[]{accountNo, withdrawAmountStr, transactionDate, paymentMethod, description});

        if (accountNo == null || withdrawAmountStr == null || transactionDate == null || paymentMethod == null) {
            request.setAttribute("status", "error");
            request.setAttribute("message", "All fields are required.");
            request.getRequestDispatcher("withdraw_funds.jsp").forward(request, response);
            return;
        }

        double withdrawAmount;
        try {
            withdrawAmount = Double.parseDouble(withdrawAmountStr);
        } catch (NumberFormatException e) {
            request.setAttribute("status", "error");
            request.setAttribute("message", "Invalid withdrawal amount.");
            request.getRequestDispatcher("withdraw_funds.jsp").forward(request, response);
            return;
        }

        String getLastTransactionQuery = "SELECT balance FROM transactions WHERE account_no = ? ORDER BY id DESC LIMIT 1";
        String insertTransactionQuery = "INSERT INTO transactions (account_no, transaction_type, transaction_date, amount, balance, description, payment_method) VALUES (?, 'Withdrawal', ?, ?, ?, ?, ?)";

        response.setContentType("text/html");

        try (Connection con = Database.getConnection();
             PreparedStatement pstmtGetLastTransaction = con.prepareStatement(getLastTransactionQuery);
             PreparedStatement pstmtInsertTransaction = con.prepareStatement(insertTransactionQuery)) {

            con.setAutoCommit(false);

            pstmtGetLastTransaction.setString(1, accountNo);
            ResultSet rsLastTransaction = pstmtGetLastTransaction.executeQuery();

            double balance = 0;
            if (rsLastTransaction.next()) {
                balance = rsLastTransaction.getDouble("balance");
            } else {
                request.setAttribute("status", "error");
                request.setAttribute("message", "Account number does not exist.");
                request.getRequestDispatcher("withdraw_funds.jsp").forward(request, response);
                return;
            }

            if (withdrawAmount <= 0) {
                request.setAttribute("status", "error");
                request.setAttribute("message", "Withdrawal amount must be greater than zero.");
            } else if (withdrawAmount > balance) {
                request.setAttribute("status", "error");
                request.setAttribute("message", "Insufficient funds. Current balance: " + balance);
            } else {
                balance -= withdrawAmount;

                pstmtInsertTransaction.setString(1, accountNo);
                pstmtInsertTransaction.setString(2, transactionDate);
                pstmtInsertTransaction.setDouble(3, withdrawAmount);
                pstmtInsertTransaction.setDouble(4, balance);
                pstmtInsertTransaction.setString(5, description);
                pstmtInsertTransaction.setString(6, paymentMethod);
                pstmtInsertTransaction.executeUpdate();

                con.commit();

                request.setAttribute("status", "success");
                request.setAttribute("transactionType", "Withdrawal");
                request.setAttribute("withdrawAmount", withdrawAmount);
                request.setAttribute("transactionDate", transactionDate);
                request.setAttribute("message", "Withdrawal successful. Remaining balance: " + balance);
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Database error: ", ex);
            ex.printStackTrace();
            request.setAttribute("status", "error");
            request.setAttribute("message", "Database error: " + ex.getMessage());
            try (Connection conn = Database.getConnection()) {
                conn.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        } finally {
            try (Connection conn = Database.getConnection()) {
                conn.setAutoCommit(true);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        request.getRequestDispatcher("withdraw_funds.jsp").forward(request, response);
    }
}
