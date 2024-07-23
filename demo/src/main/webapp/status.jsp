<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Customer Status</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
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
        .form-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
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
            font-weight: bold;
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
        .btn-submit, .btn-back {
            background-color: #6dabe4;
            color: #fff;
            border: none;
            padding: 10px 20px;
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
        .btn-submit:hover, .btn-back:hover {
            background-color: #4292dc;
        }
        .btn-back {
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Change Customer Status</h2>
        <p>Please check the customer status in the "View Customer" feature provided in the Dashboard.</p>
        
        <br>
        <form action="AdminStatus" method="post">
            <div class="form-group">
                <input type="text" id="accountNo" name="accountNo" placeholder="Enter Account No" required>
            </div>
            <div class="form-group">
                <select id="status" name="status" required>
                    <option value="Active">Active</option>
                </select>
            </div>
            <div class="form-group">
                <input type="submit" value="Update Status" class="btn-submit">
            </div>
        </form>
        <button type="button" onclick="window.location.href='admin_dashboard.jsp'" class="btn-back">Back to Dashboard</button>
    </div>

    <!-- Script to handle success and error messages -->
    <script>
        <% if ("success".equals(request.getAttribute("status"))) { %>
            Swal.fire({
                icon: 'success',
                title: 'Success!',
                text: '<%= request.getAttribute("message") %>',
                showConfirmButton: false,
                timer: 3000
            }).then((result) => {
                window.location.href = 'admin_dashboard.jsp';
            });
        <% } else if ("error".equals(request.getAttribute("status"))) { %>
            Swal.fire({
                icon: 'error',
                title: 'Error!',
                text: '<%= request.getAttribute("message") %>',
                showConfirmButton: false,
                timer: 3000
            }).then((result) => {
                window.location.href = 'status.jsp';
            });
        <% } %>
    </script>
</body>
</html>
