<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <style>
        .button-link {
            display: inline-block;
            background-color: #6dabe4;
            color: #fff;
            width: auto;
            padding: 15px 39px;
            border-radius: 5px;
            margin: 10px;
            text-decoration: none;
            font-size: 16px;
            text-align: center;
            transition: background-color 0.3s;
            cursor: pointer;
        }
        .button-link:hover {
            background-color: #4292dc;
        }
        .dashboard-links {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 30px;
        }
        .dashboard-welcome {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="main">
        <section class="customer-dashboard">
            <div class="container">
                <div class="dashboard-content">
                    <div class="dashboard-welcome">
                        <h2>Welcome <%= session.getAttribute("name") %> </h2>
                        <p><strong>Account Number:</strong> <%= session.getAttribute("accountNo") %></p>
                        <p><strong>Balance:</strong> click view transactions to view balance</p>

                    </div>
                    <div class="dashboard-links">
                        <a href="view_transactions.jsp" class="button-link">
                            <i class="material-icons">list_alt</i> View Transactions
                        </a>
                        <a href="deposit_funds.jsp" class="button-link">
                            <i class="material-icons">attach_money</i> Deposit Funds
                        </a>
                        <a href="withdraw_funds.jsp" class="button-link">
                            <i class="material-icons">money_off</i> Withdraw Funds
                        </a>
                        <a href="close_account.jsp" class="button-link">
                            <i class="material-icons">close</i> Close Account
                        </a>
                        <a href="customer_logout.jsp" class="button-link">
                            <i class="material-icons">exit_to_app</i> Logout
                        </a>
                    </div>
                </div>
            </div>
        </section>
    </div>
</body>
</html>
