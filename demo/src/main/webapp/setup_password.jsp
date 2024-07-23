<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Setup Password</title>
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
    <!-- Display any success or error messages here -->
    <%
    String status = (String) request.getAttribute("status");
    if (status != null) {
        if ("success".equals(status)) {
%>
            <script>
                Swal.fire({
                    icon: 'success',
                    title: 'Success!',
                    text: 'Password successfully updated.'
                });
            </script>
<%      } else if ("failed".equals(status)) { %>
            <script>
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Failed to update password. Please try again.'
                });
            </script>
<%      } else if ("notfound".equals(status)) { %>
            <script>
                Swal.fire({
                    icon: 'error',
                    title: 'Error!',
                    text: 'Invalid account number or temporary password.'
                });
            </script>
<%      } else if ("alreadyupdated".equals(status)) { %>
            <script>
                Swal.fire({
                    icon: 'info',
                    title: 'Already Updated!',
                    text: 'You have already updated your password.'
                });
            </script>
<%      } else if ("error".equals(status)) { %>
            <script>
                Swal.fire({
                    icon: 'error',
                    title: 'Error!',
                    text: 'An error occurred. Please try again later.'
                });
            </script>
<%      }
    }
%>


    <!-- Your HTML content for setup password form -->
    <div class="container">
        <h2>Setup Password</h2>
        <form method="post" action="SetupPasswordServlet" class="form">
            <div class="form-group">
                <label for="accountNo"></label>
                <input type="text" name="accountNo" id="accountNo" placeholder="Enter account number" required>
            </div>
            <div class="form-group">
                <label for="tempPassword"></label>
                <input type="password" name="tempPassword" id="tempPassword" placeholder="Enter temporary password" required>
            </div>
            <div class="form-group">
                <label for="newPassword"></label>
                <input type="password" name="newPassword" id="newPassword" placeholder="Enter new password" required>
            </div>
            <div class="form-group">
                <input type="submit" name="setupPassword" id="setupPassword" class="form-submit" value="Setup Password">
            </div>
            <div class ="form-button">
                <button type="button" onclick="window.location.href='customer_login.jsp'" class="form-back">Back to Login Page</button>
            </div>
        </form>
    </div>
</body>
</html>
