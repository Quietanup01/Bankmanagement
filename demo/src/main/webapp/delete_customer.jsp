<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Customer</title>
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
    .form-group input {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 14px;
    }
    .form-group input:focus {
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
        margin-bottom: 15px;
    }
    .form-submit {
        background: #dc3545;
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
    .form-submit:hover {
        background-color: #c82333;
    }
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
    .form-back:hover {
        background-color: #4292dc;
    }
    </style>
</head>
<body>
    <div class="container">
        <h2>Delete Customer</h2>
        <form action="DeleteCustomerServlet" method="post">
            <div class="form-group">
                <label for="accountNo"></label>
                <input type="text" id="accountNo" name="accountNo" required placeholder="Enter account number">
            </div>
            <div class="form-button">
                <input type="submit" value="Delete" class="form-submit">
            </div>
            <div class="form-button">
                <button type="button" onclick="window.location.href='admin_dashboard.jsp'" class="form-back">Back to Dashboard</button>
            </div>
        </form>

        <% 
            if (request.getAttribute("status") != null) {
                String status = (String) request.getAttribute("status");
                if ("success".equals(status)) {
        %>
            <script>
                Swal.fire({
                    icon: 'success',
                    title: 'Success!',
                    text: 'Customer deleted successfully.'
                });
            </script>
        <% 
                } else if ("failed".equals(status)) {
        %>
            <script>
                Swal.fire({
                    icon: 'error',
                    title: 'Failed!',
                    text: 'Failed to delete customer. Please try again.'
                });
            </script>
        <% 
                } else if ("no_records_found".equals(status)) {
        %>
            <script>
                Swal.fire({
                    icon: 'warning',
                    title: 'Not Found!',
                    text: 'Customer not found.'
                });
            </script>
        <% 
                }
            } 
        %>
    </div>
</body>
</html>
