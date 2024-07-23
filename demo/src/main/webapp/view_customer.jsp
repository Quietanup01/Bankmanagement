<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.uniquedeveloper.registration.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Customers</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
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
        <h2>View Customers</h2>
        
        <!-- Button to trigger fetching customer details -->
        <h4>Please click the 'Fetch Customer Details' button to retrieve customer information</h4>
        <form method="post" action="ViewCustomerServlet">
            <div class="form-group form-button">
                <input type="submit" name="fetchCustomers" class="form-submit" value="Fetch Customer Details">
            </div>
        </form>
        
        <!-- Display customer details -->
        <div class="customer-details">
            <h3>Customer Details</h3>
            <% 
                List<Customer> customers = (List<Customer>) request.getAttribute("customers");
                if (customers != null && !customers.isEmpty()) {
            %>
            <table>
                <tr>
                    <th>Full Name</th>
                    <th>Address</th>
                    <th>Mobile No</th>
                    <th>Email ID</th>
                    <th>Type of Account</th>
                    <th>Initial Balance</th>
                    <th>Date of Birth</th>
                    <th>ID Proof</th>
                    <th>Status</th>
                </tr>
                <% 
                    for (Customer customer : customers) {
                %>
                <tr>
                    <td><%= customer.getFullName() %></td>
                    <td><%= customer.getAddress() %></td>
                    <td><%= customer.getMobile() %></td>
                    <td><%= customer.getEmail() %></td>
                    <td><%= customer.getAccountType() %></td>
                    <td><%= customer.getInitialBalance() %></td>
                    <td><%= customer.getDob() %></td>
                    <td><%= customer.getIdProof() %></td>
                    <td><%= customer.getAccount_status() %>
                </tr>
                <% 
                    }
                %>
            </table>
            <% 
                } else {
                    out.println("<p>No customers found.</p>");
                }
            %>
            <div class="form-button">
                <button type="button" onclick="window.location.href='admin_dashboard.jsp'" class="form-back">Back to Dashboard</button>
            </div>
        </div>
    </div>
</body>
</html>
