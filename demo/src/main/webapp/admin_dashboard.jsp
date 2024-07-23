<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard</title>
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
    }
    .dashboard-welcome {
        text-align: center;
        margin-bottom: 20px;
    }
</style>
</head>
<body>
    <input type="hidden" id="status" value="<%=request.getAttribute("status")%>">
    <div class="main">
        <section class="admin-dashboard">
            <div class="container">
                <div class="dashboard-content">
                    <div class="dashboard-welcome">
                        <h2>Welcome, <%= session.getAttribute("adminname") %></h2>
                    </div>
                    <div class="dashboard-links">
                        <a href="add_customer.jsp" class="button-link">
                            <i class="material-icons">person_add</i> Add Customer
                        </a>
                        <a href="view_customer.jsp" class="button-link">
                            <i class="material-icons">view_list</i> View Customers
                        </a>
                        <a href="modify_customer.jsp" class="button-link">
                            <i class="material-icons">edit</i> Modify Customer
                        </a>
                        <a href="delete_customer.jsp" class="button-link">
                            <i class="material-icons">delete</i> Delete Customer
                        </a>
                        <a href="admin_logout.jsp" class="button-link">
                            <i class="material-icons">exit_to_app</i> Logout
                        </a>
                       
                        <a href="status.jsp" class="button-link">
                            <i class="material-icons">toggle_on</i> Status 
                        </a>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <script src="js/main.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/sweetalert/dist/sweetalert.css">
</body>
</html>
