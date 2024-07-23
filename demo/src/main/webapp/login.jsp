<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://unpkg.com/sweetalert/dist/sweetalert.css">
    <style>
        .login-toggle {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }
        .login-toggle button {
            background-color: #6dabe4;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .login-toggle button.active {
            background-color: #4292dc;
        }
        .login-toggle button:hover {
            background-color: #4292dc;
        }
        .login-form {
            display: none;
        }
        .login-form.active {
            display: block;
        }
    </style>
</head>
<body>
    <input type="hidden" id="status" value="<%=request.getAttribute("status")%>">
    <input type="hidden" id="activeForm" value="<%=request.getAttribute("activeForm") != null ? request.getAttribute("activeForm") : "admin" %>">
    <div class="main">
        <section class="sign-in">
            <div class="container">
                <div class="signin-content">
                    <div class="signin-image">
                        <figure>
                            <img src="images/signin-image.jpg" alt="sign in image">
                        </figure>
                    </div>
                    <div class="signin-form">
                        <div class="login-toggle">
                            <button id="admin-login-btn" class="active">Admin Login</button>
                            <button id="customer-login-btn">Customer Login</button>
                        </div>
                        <!-- Admin Login Form -->
                        <div id="admin-login-form" class="login-form active">
                            <h2 class="form-title">Admin Sign In</h2>
                            <form method="post" action="AdminLoginServlet" class="register-form" id="login-form">
                                <div class="form-group">
                                    <label for="username"><i class="material-icons">account_circle</i></label>
                                    <input type="text" name="email" id="email" placeholder="Your Email" />
                                </div>
                                <div class="form-group">
                                    <label for="password"><i class="material-icons">lock</i></label>
                                    <input type="password" name="password" id="password" placeholder="Password" />
                                </div>
                                <input type="hidden" name="activeForm" value="admin">
                                <div class="form-group form-button">
                                    <input type="submit" name="signin" id="signin" class="form-submit" value="Log in" />
                                </div>
                            </form>
                        </div>
                        <!-- Customer Login Form -->
                        <div id="customer-login-form" class="login-form">
                            <h2 class="form-title">Customer Sign In</h2>
                            <div class="form-group">
                                <p>If you are visiting this page for the first time, please check your email or contact your administrator for account details and temporary password. Then, click the link below to set your new password.</p>
                            </div>
                            <form method="post" action="CustomerLoginServlet" class="register-form" id="login-form">
                                <div class="form-group">
                                    <label for="accountNo"><i class="material-icons">account_circle</i></label>
                                    <input type="text" name="accountNo" id="accountNo" placeholder="Account Number" />
                                </div>
                                <div class="form-group">
                                    <label for="password"><i class="material-icons">lock</i></label>
                                    <input type="password" name="password" id="password" placeholder="Password" />
                                </div>
                                <input type="hidden" name="activeForm" value="customer">
                                <div class="form-group form-button">
                                    <input type="submit" name="signin" id="signin" class="form-submit" value="Log in" />
                                </div>
                                <a href="setup_password.jsp" class="link">First Time? Setup New Password</a>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var status = document.getElementById("status").value;
            var activeForm = document.getElementById("activeForm").value;
            if (status === "failed") {
                swal("Error", "Invalid credentials, please try again.", "error");
            } else if (status === "error") {
                swal("Error", "An error occurred. Please try again later.", "error");
            }
            document.getElementById(activeForm + "-login-btn").classList.add("active");
            document.getElementById(activeForm + "-login-form").classList.add("active");
        });

        document.getElementById("admin-login-btn").addEventListener("click", function() {
            switchForm("admin");
        });

        document.getElementById("customer-login-btn").addEventListener("click", function() {
            switchForm("customer");
        });

        function switchForm(formType) {
            var forms = document.getElementsByClassName("login-form");
            for (var i = 0; i < forms.length; i++) {
                forms[i].classList.remove("active");
            }
            var buttons = document.querySelectorAll(".login-toggle button");
            buttons.forEach(button => button.classList.remove("active"));
            document.getElementById(formType + "-login-form").classList.add("active");
            document.getElementById(formType + "-login-btn").classList.add("active");
        }
    </script>
</body>
</html>