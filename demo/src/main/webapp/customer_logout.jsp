<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>


<%
    HttpSession sessionss = request.getSession(false);
    if (sessionss != null) {
        session.invalidate(); // Invalidate the session
    }
    response.sendRedirect("customer_login.jsp"); // Redirect to login page
%>
