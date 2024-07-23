<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            font-weight: 400;
            font-size: 15px;
            line-height: 1.8;
            color: #333;
            margin: 0 !important;
            padding: 0 !important;
            transition: all 0.5s;
            background: #f8f8f8;
            line-height: 1.8;
        }
        .container {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 900px;
            background: #fff;
            margin: 50px auto;
            box-shadow: 0 15px 16.83px 2.17px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .image-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .image-container img {
            max-width: 100%;
            height: auto;
        }
        .form-container {
            flex: 1;
            padding: 20px;
            text-align: center;
        }
        .form-title {
            margin-bottom: 30px;
            font-weight: 600;
            color: #222;
            font-size: 30px;
            text-transform: uppercase;
        }
        .form-button {
            display: block;
            width: 100%;
            background: #6dabe4;
            color: #fff;
            border: none;
            padding: 15px 0;
            border-radius: 5px;
            cursor: pointer;
            margin: 20px 0;
            text-transform: uppercase;
            font-weight: 600;
        }
        .form-button:hover {
            background: #4292dc;
        }
    </style>
    <script>
        function redirectToRole(role) {
            document.getElementById('role').value = role;
            if (role === 'admin') {
                document.getElementById('loginForm').action = 'admin_login.jsp';
            } else {
                document.getElementById('loginForm').action = 'customer_login.jsp';
            }
            document.getElementById('loginForm').submit();
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="image-container">
            <img src="images/signup-image.jpg" alt="Login Image">
        </div>
        <div class="form-container">
            <h2 class="form-title">Choose Account</h2>
            <form id="loginForm" action="loginServlet" method="post">
                <input type="hidden" name="role" id="role" value="">
                <button type="button" class="form-button" onclick="redirectToRole('admin')">Admin Login</button>
                <button type="button" class="form-button" onclick="redirectToRole('customer')">Customer Login</button>
            </form>
        </div>
    </div>
</body>
</html>
