<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.uniquedeveloper.registration.Transaction" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Transactions</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
    .form-submit,
    .form-back,
    .form-print {
        background: #6dabe4;
        color: #fff;
        padding: 10px 0;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s;
        width: 100%;
        text-align: center;
        display: flex;
        align-items: center;
        justify-content: center;
        height: 50px; /* Ensures both buttons have the same height */
        margin-top: 15px;
    }
    .form-submit:hover,
    .form-back:hover,
    .form-print:hover {
        background-color: #4292dc;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }
    th {
        background-color: #f2f2f2;
    }
    </style>
</head>
<body>
    <div class="container">
        <h2>View Transactions</h2>
        
        <!-- Form to input account number -->
        <form method="post" action="FetchTransactionServlet">
            <div class="form-group">
                <input type="text" id="readonlyInput" name="accountNo" value="<%= session.getAttribute("accountNo") %>" readonly>
            </div>
            <div class="form-group form-button">
                <input type="submit" name="fetchTransactions" class="form-submit" value="Fetch Transaction Details">
            </div>
        </form>
        
        <!-- Display transaction details -->
        <div class="transaction-details">
            <h3>Transaction Details</h3>
            <%
                Boolean accountExists = (Boolean) request.getAttribute("accountExists");
                if (accountExists != null && accountExists) {
                    List<Transaction> transactions = (List<Transaction>) request.getAttribute("transactions");
                    Double totalDeposit = (Double) request.getAttribute("totalDeposit");
                    Double totalWithdrawal = 0.0; // Initialize total withdrawal amount
                    Double initialBalance = (Double) request.getAttribute("initialBalance");
                    if (transactions != null && !transactions.isEmpty()) {
            %>
            <table>
                <tr>
                    <th>Transaction ID</th>
                    <th>Account No</th>
                    <th>Transaction Type</th>
                    <th>Transaction Date</th>
                    <th>Amount</th>
                    <th>Balance</th>
                    <th>Description</th>
                    <th>Payment Method</th>
                </tr>
                <% 
                    double currentBalance = initialBalance;
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    for (Transaction transaction : transactions) {
                        if (transaction.getTransactionType().equalsIgnoreCase("deposit")) {
                            currentBalance += transaction.getAmount();
                            totalDeposit += transaction.getAmount();
                        } else if (transaction.getTransactionType().equalsIgnoreCase("withdrawal")) {
                            currentBalance -= transaction.getAmount();
                            totalWithdrawal += transaction.getAmount();
                        }
                %>
                <tr>
                    <td><%= transaction.getId() %></td>
                    <td><%= transaction.getAccountNo() %></td>
                    <td><%= transaction.getTransactionType() %></td>
                    <td><%= sdf.format(transaction.getTransactionDate()) %></td>
                    <td><%= transaction.getAmount() %></td>
                    <td><%= currentBalance %></td>
                    <td><%= transaction.getDescription() %></td>
                    <td><%= transaction.getPaymentMethod() %></td>
                </tr>
                <% 
                    }
                %>
            </table>
            <div>
                <p>Total Deposits: <%= totalDeposit/2 %></p>
                <p>Total Withdrawals: <%= totalWithdrawal %></p>
            </div>
            <form method="post" action="FetchTransactionServlet">
                <input type="hidden" name="accountNo" value="<%= session.getAttribute("accountNo") %>">
                <input type="hidden" name="generatePdf" value="true">
                <div class="form-button">
                    <input type="submit" class="form-print" value="Print Mini Statement">
                </div>
            </form>
            <% 
                    } else {
                        out.println("<p>No transactions found.</p>");
                    }
                } else if (accountExists != null) {
                    out.println("<p>Account number not found.</p>");
                }
            %>
            <div class="form-button">
                <button type="button" onclick="window.location.href='customer_dashboard.jsp'" class="form-back">Back to Dashboard</button>
            </div>
        </div>
    </div>
</body>
</html>
