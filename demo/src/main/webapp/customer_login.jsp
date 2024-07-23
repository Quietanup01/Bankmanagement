<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Login</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://unpkg.com/sweetalert/dist/sweetalert.css">
</head>
<body>
    <input type="hidden" id="status" value="<%=request.getAttribute("status")%>">
    <div class="main">
        <section class="sign-in">
            <div class="container">
                <div class="signin-content">
                    <div class="signin-image">
                        <figure>
                            <img src="images/signin-image.jpg" alt="sign up image">
                        </figure>
                    </div>
                    <div class="signin-form">
                        <h2 class="form-title">Customer Sign In</h2>
                        <p>If you are visiting this page for the first time, please check your email or contact your administrator for account details and temporary password. Then, click the link below to set your new password.</p>
                        <%-- Display error message --%>
                        <br>
                        <% if ("error".equals(request.getAttribute("status"))) { %>
                            <div class="form-group">
                                <p class="error-message"><%=request.getAttribute("errorMessage")%></p>
                            </div>
                        <% } %>
                        <form method="post" action="CustomerLoginServlet" class="register-form" id="login-form">
                            <div class="form-group">
                                <label for="accountNo"><i class="material-icons">account_circle</i></label>
                                <input type="text" name="accountNo" id="accountNo" placeholder="Account Number" />
                            </div>
                            <div class="form-group">
                                <label for="password"><i class="material-icons">lock</i></label>
                                <input type="password" name="password" id="password" placeholder="Password" />
                            </div>
                            <div class="form-group form-button">
                                <input type="submit" name="signin" id="signin" class="form-submit" value="Log in" />
                            </div>
                            <div class="form-group">
                                   <input type="button" value="Back" class="form-submit form-back" onclick="window.location.href='newlogin.jsp';" />
                           </div>

                            
                            
                        </form>
                        <%-- Provide link only if needed --%>
                        <br>
                        <div class="form-group">
                            <a href="setup_password.jsp" class="set-password-link">Set new password</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <script src="js/main.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    
    <script>
        var status = document.getElementById("status").value;
        if (status === "failed") {
            swal("Error!", "Invalid account number or password", "error");
        } else if (status === "error") {
            swal("Error!", "<%=request.getAttribute("errorMessage")%>", "error");
        }
    </script>
</body>
</html>
