<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h2>Error</h2>
        <p>An error occurred: <%= request.getAttribute("errorMessage") %></p>
        <a href="admin_dashboard.jsp">Go back to Dashboard</a>
    </div>
</body>
</html>
