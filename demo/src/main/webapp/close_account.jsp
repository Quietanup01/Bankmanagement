<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Close Account</title>
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
        <h2>Close Account</h2>
        <form method="POST" action="CloseAccountServlet" class="form">
            <div class="form-group">
                <input type="hidden" name="accountNo" value="<%= session.getAttribute("accountNo") %>">
                <p>Are you sure you want to close your account?</p>
            </div>
            <div class="form-actions">
                <button type="submit" class="form-submit">Close Account</button>
            </div>
            <div class="form-button">
                <button type="button" onclick="window.location.href='customer_dashboard.jsp'" class="form-back">Back to Dashboard</button>
            </div>
        </form>
    </div>

    <!-- Script to handle success and error messages -->
    <script>
        <% if ("success".equals(request.getAttribute("status"))) { %>
            Swal.fire({
                icon: 'success',
                title: 'Account Closed Successfully!',
                text: 'Your account has been successfully closed.',
                showConfirmButton: false,
                timer: 3000
            }).then((result) => {
                window.location.href = 'login.jsp';
            });
        <% } else if ("error".equals(request.getAttribute("status"))) { %>
            Swal.fire({
                icon: 'error',
                title: 'Error!',
                text: '<%= request.getAttribute("message") %>',
                showConfirmButton: false,
                timer: 3000
            }).then((result) => {
                window.location.href = 'close_account.jsp';
            });
        <% } %>
    </script>
</body>
</html>










