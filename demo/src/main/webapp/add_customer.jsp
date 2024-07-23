<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Customer</title>
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
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
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
        <h2>Add New Customer</h2>
        <form method="post" action="AddCustomerServlet" class="form">
            <div class="form-group">
                <label for="fullName"></label>
                <input type="text" name="fullName" id="fullName" placeholder="Enter full name" required>
            </div>
            <div class="form-group">
                <label for="address"></label>
                <input type="text" name="address" id="address" placeholder="Enter address" required>
            </div>
            <div class="form-group">
                <label for="mobile"></label>
                <input type="text" name="mobile" id="mobile" placeholder="Enter mobile number" required>
            </div>
            <div class="form-group">
                <label for="email"></label>
                <input type="email" name="email" id="email" placeholder="Enter email ID" required>
            </div>
            <div class="form-group">
                <label for="accountType"></label>
                <select name="accountType" id="accountType" required>
                    <option value="Saving">Saving Account</option>
                    <option value="Current">Current Account</option>
                </select>
            </div>
            <div class="form-group">
                <label for="initialBalance"></label>
                <input type="number" name="initialBalance" id="initialBalance" min="1000" placeholder="Enter initial balance" required>
            </div>
            <div class="form-group">
                <label for="dob"></label>
                <input type="date" name="dob" id="dob" required>
            </div>
            <div class="form-group">
                <label for="idProof"></label>
                <input type="text" name="idProof" id="idProof" placeholder="Enter ID proof" required>
            </div>
            <div class="form-group">
                <input type="submit" name="addCustomer" id="addCustomer" class="form-submit" value="Add Customer">
            </div>    
            <div  class="form-group">
                <button type="button" onclick="window.location.href='admin_dashboard.jsp'" class="form-back">Back to Dashboard</button>
            </div>
        </form>
    </div>

    <!-- Script to handle success message -->
    <script>
        var status = "<%= request.getAttribute("status") %>";
        var accountNo = "<%= request.getAttribute("accountNo") %>";
        var tempPassword = "<%= request.getAttribute("tempPassword") %>";
        
        if (status === "success") {
            Swal.fire({
                icon: 'success',
                title: 'Success!',
                html: 'New customer account added.<br>Account Number: ' + accountNo + '<br>Temporary Password: ' + tempPassword
            });
        } else if (status === "underage") {
            Swal.fire({
                icon: 'error',
                title: 'Underage!',
                text: 'Customer must be at least 18 years old.'
            });
        }
    </script>
</body>
</html>
