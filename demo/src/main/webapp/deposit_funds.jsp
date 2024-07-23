<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Deposit Funds</title>
    <link rel="stylesheet" href="css/style.css">
    <!-- SweetAlert library -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background: #fff;
            padding: 20px 40px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }
        .form-group input:focus,
        .form-group select:focus {
            border-color: #6dabe4;
            outline: none;
        }
        .form-group input::placeholder {
            color: #999;
        }
        .form-button {
            text-align: center;
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
        }
        .form-submit,
        .form-back {
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
        }
        .form-submit:hover,
        .form-back:hover {
            background-color: #4292dc;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Deposit Funds</h2>
        <form method="POST" action="DepositFundsServlet" class="form">
            <div class="form-group">
                 <label for="readonlyInput"></label>
                <input type="text" id="readonlyInput" name="accountNo" value="<%= session.getAttribute("accountNo") %>" readonly>
            </div>
            <div class="form-group">
                <input type="number" name="depositAmount" min="0.01" step="0.01" placeholder="Enter deposit amount" required>
            </div>
            <div class="form-group">
                <input type="date" name="depositDate" id="depositDate" readonly required>
            </div>
            <div class="form-group">
                <select name="paymentMethod" required>
                    <option value="Online Transfer">Online Transfer</option>
                    <option value="Cash">Cash</option>
                    <option value="Check">Check</option>
                </select>
            </div>
            <div class="form-group">
                <input type="text" name="description" placeholder="Add a Note">
            </div>
            <div class="form-actions">
                <button type="submit" class="form-submit">Confirm Deposit</button>
            </div>
            <div class="form-button">
                <button type="button" onclick="window.location.href='customer_dashboard.jsp'" class="form-back">Back to Dashboard</button>
            </div>
        </form>
    </div>

    <!-- Script to set today's date in the date input field -->
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var today = new Date();
            var day = String(today.getDate()).padStart(2, '0');
            var month = String(today.getMonth() + 1).padStart(2, '0'); // January is 0!
            var year = today.getFullYear();
            var todayDate = year + '-' + month + '-' + day;
            document.getElementById('depositDate').value = todayDate;
        });

        <% if ("success".equals(request.getAttribute("status"))) { %>
            Swal.fire({
                icon: 'success',
                title: 'Deposit Successful!',
                html: 'Transaction Type: Deposit<br>Deposit Amount: <%= request.getAttribute("depositAmount") %><br>Deposit Date: <%= request.getAttribute("depositDate") %>',
                showConfirmButton: false,
                timer: 3000
            }).then((result) => {
                window.location.href = 'customer_dashboard.jsp';
            });
        <% } else if ("error".equals(request.getAttribute("status"))) { %>
            Swal.fire({
                icon: 'error',
                title: 'Error!',
                text: '<%= request.getAttribute("errorMessage") %>',
                showConfirmButton: false,
                timer: 3000
            }).then((result) => {
                window.location.href = 'deposit_funds.jsp';
            });
        <% } %>
    </script>
</body>
</html>
