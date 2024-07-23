package com.uniquedeveloper.registration;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.uniquedeveloper.database.Database;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/CloseAccountServlet")
public class CloseAccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(CloseAccountServlet.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accountNo = request.getParameter("accountNo");

        try {
            if (closeAccount(accountNo)) {
                // Account successfully closed
                request.setAttribute("status", "success");
                request.setAttribute("message", "Your account has been closed successfully.");
            } else {
                // Failed to close account
                request.setAttribute("status", "error");
                request.setAttribute("message", "Failed to close your account. Please try again later.");
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Database error: ", ex);
            ex.printStackTrace();
            request.setAttribute("status", "error");
            request.setAttribute("message", "Database error: " + ex.getMessage());
        }

        // Forward back to close_account.jsp to show the status message
        request.getRequestDispatcher("close_account.jsp").forward(request, response);
    }

    private boolean closeAccount(String accountNo) throws SQLException {
        boolean isSuccess = false;
        try (Connection con = Database.getConnection();
             PreparedStatement pstmtUpdateAccount = con.prepareStatement("UPDATE customer SET account_status = 'Closed' WHERE account_no = ?")) {
            pstmtUpdateAccount.setString(1, accountNo);
            int rowsAffected = pstmtUpdateAccount.executeUpdate();

            if (rowsAffected > 0) {
                isSuccess = true;
                LOGGER.log(Level.INFO, "Account closed successfully: {0}", accountNo);
            } else {
                LOGGER.log(Level.WARNING, "Failed to close account: {0}", accountNo);
            }
        }
        return isSuccess;
    }
}
