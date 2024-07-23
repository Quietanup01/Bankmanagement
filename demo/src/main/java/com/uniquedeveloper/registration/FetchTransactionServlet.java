package com.uniquedeveloper.registration;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

@WebServlet("/FetchTransactionServlet")
public class FetchTransactionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String dbURL = "jdbc:mysql://localhost:3306/banking_app";
        String dbUser = "root";
        String dbPassword = "Nirmal@2919";
        String accountNo = request.getParameter("accountNo");

        boolean accountExists = false;
        List<Transaction> transactions = new ArrayList<>();
        double totalDeposit = 0;
        double initialBalance = 0;

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
            // Check if account number exists and fetch initial balance
            String checkAccountQuery = "SELECT initial_balance FROM customer WHERE account_no = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkAccountQuery)) {
                checkStmt.setString(1, accountNo);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next()) {
                    accountExists = true;
                    initialBalance = rs.getDouble("initial_balance");
                }
            }

            if (accountExists) {
                // Fetch transactions for the account
                String fetchTransactionsQuery = "SELECT * FROM transactions WHERE account_no = ? ORDER BY transaction_date DESC LIMIT 10";
                try (PreparedStatement pstmt = conn.prepareStatement(fetchTransactionsQuery)) {
                    pstmt.setString(1, accountNo);
                    ResultSet rs = pstmt.executeQuery();

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String transactionType = rs.getString("transaction_type");
                        Date transactionDate = rs.getDate("transaction_date");
                        double amount = rs.getDouble("amount");
                        String description = rs.getString("description");
                        String paymentMethod = rs.getString("payment_method");

                        Transaction transaction = new Transaction(id, accountNo, transactionType, transactionDate, amount, description, paymentMethod);
                        transactions.add(transaction);

                        if (transactionType.equalsIgnoreCase("deposit")) {
                            totalDeposit += amount;
                        }
                    }
                    
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            request.setAttribute("error", "An error occurred while processing your request.");
        }
        
        request.setAttribute("accountExists", accountExists);
        request.setAttribute("transactions", transactions);
        request.setAttribute("totalDeposit", totalDeposit);
        request.setAttribute("initialBalance", initialBalance);

        if (request.getParameter("generatePdf") != null) {
            generatePdf(response, transactions, accountNo);
        } else {
            request.getRequestDispatcher("view_transactions.jsp").forward(request, response);
        }
    }

    private void generatePdf(HttpServletResponse response, List<Transaction> transactions, String accountNo) {
        Document document = new Document();
        try {
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=transaction_report.pdf");
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            Font boldFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);

            Paragraph title = new Paragraph("Transaction Report for Account No: " + accountNo, boldFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);

            document.add(new Paragraph(" ")); // Add empty line

            PdfPTable table = new PdfPTable(6);
            table.setWidthPercentage(100);
            table.setSpacingBefore(10f);
            table.setSpacingAfter(10f);

            PdfPCell cell;

            cell = new PdfPCell(new Phrase("Transaction ID", boldFont));
            table.addCell(cell);
            cell = new PdfPCell(new Phrase("Transaction Type", boldFont));
            table.addCell(cell);
            cell = new PdfPCell(new Phrase("Transaction Date", boldFont));
            table.addCell(cell);
            cell = new PdfPCell(new Phrase("Amount", boldFont));
            table.addCell(cell);
            cell = new PdfPCell(new Phrase("Description", boldFont));
            table.addCell(cell);
            cell = new PdfPCell(new Phrase("Payment Method", boldFont));
            table.addCell(cell);

            double totalDeposits = 0;
            double totalWithdrawals = 0;

            for (Transaction transaction : transactions) {
                table.addCell(String.valueOf(transaction.getId()));
                table.addCell(transaction.getTransactionType());
                table.addCell(String.valueOf(transaction.getTransactionDate()));
                table.addCell(String.valueOf(transaction.getAmount()));
                table.addCell(transaction.getDescription());
                table.addCell(transaction.getPaymentMethod());

                if (transaction.getTransactionType().equalsIgnoreCase("deposit")) {
                    totalDeposits += transaction.getAmount();
                } else if (transaction.getTransactionType().equalsIgnoreCase("withdrawal")) {
                    totalWithdrawals += transaction.getAmount();
                }
            }

            document.add(table);

            // Print total deposits and total withdrawals
            Paragraph totalParagraph = new Paragraph();
            totalParagraph.add(new Phrase("Total Deposits: ", boldFont));
            totalParagraph.add(new Phrase(String.valueOf(totalDeposits)));
            totalParagraph.add(new Phrase("\nTotal Withdrawals: ", boldFont));
            totalParagraph.add(new Phrase(String.valueOf(totalWithdrawals)));
            totalParagraph.setAlignment(Element.ALIGN_RIGHT);
            document.add(totalParagraph);

            document.close();
        } catch (DocumentException | IOException e) {
            e.printStackTrace();
        }
    }

}
