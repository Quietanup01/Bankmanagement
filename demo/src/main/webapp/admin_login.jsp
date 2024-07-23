<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Login</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

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
                            <div class="form-group form-button">
                                <input type="submit" name="signin" id="signin" class="form-submit" value="Log in" />
                            </div>
                            <div class="form-group">
                                   <input type="button" value="Back" class="form-submit form-back" onclick="window.location.href='newlogin.jsp';" />
                           </div>
                            
                            
                        </form>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <script src="js/main.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    
<script type = "text/javascript">
 var status = document.getElementById("status").value;
 if(status == "failed"){
	 swal("Error!","Invalid username or password", "error");
 }
</script>
</body>
</html>
