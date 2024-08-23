<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
		rel="stylesheet">
	<link
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css"
		rel="stylesheet">
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
	
	<link rel="stylesheet" href="/css/style.css"> 
	<style>
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f8f9fa;
        }

        .container {
            max-width: 1000px;
            margin: 80px auto;
            padding: 2rem;
            background-color: #fff;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            border-radius: 0.5rem;
        }

        .image-container {
            position: relative;
            overflow: hidden;
            border-radius: 0.5rem;
            height: 100%;
        }

        .image-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
		
		.image-container:hover img {
		    transform: scale(1.1);
		}

        .form-container {
            padding: 2rem;
            background-color: #f8f9fa;
            border-radius: 0.5rem;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: none;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0069d9;
            border-color: #0062cc;
        }

        .social-login {
            margin-top: 1rem;
            text-align: center;
        }

        .social-login a {
            margin-right: 0.5rem;
            color: #333;
            transition: color 0.3s ease;
        }

        .social-login a:hover {
            color: #007bff;
        }
    </style>
</head>
<body>
   <%@ include file="header.jsp" %>
<div class="container ">
    <div class="row">
    	<div class="col-md-6">
            <div class="form-container">
                <c:if test="${error_string != null}">
                    <div class="alert alert-danger">${error_string} Click here to <a href="registration_form">Register</a>
                    </div>
                </c:if>
                <c:if test="${success_register != null}">
                    <div class="alert alert-success">${success_register} Please Login</div>
                </c:if>

                <h1 class="text-center mb-4">Sign In</h1>

                <c:url var="post_url" value="/login"/>
                <form action="${post_url}" method="post" class="needs-validation" novalidate>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                    <div class="mb-3">
                        <label for="username" class="form-label">Email:</label>
                        <input type="email" class="form-control" id="username" placeholder="Enter email" name="username"
                               value="" required>
                        <div class="invalid-feedback">Please enter a valid email address.</div>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password:</label>
                        <input type="password" class="form-control" id="password" placeholder="Enter password"
                               name="password" value="" required>
                        <div class="invalid-feedback">Please enter your password.</div>
                    </div>

                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="remember-me">
                        <label class="form-check-label" for="remember-me">Remember me</label>
                    </div>

                    <button type="submit" class="btn btn-primary btn-block">Sign In</button>
                </form>

                <div class="social-login">
                    <p>Or sign in with:</p>
                    <a href="#"><i class="fab fa-google"></i></a>
                    <a href="#"><i class="fab fa-facebook"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                </div>

                <div class="text-center mt-3">
                    <p>Don't have an account yet? <a href="registration_form">Sign up</a></p>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="image-container">
			    <img src="/images/login.png" alt="Image" class="img-fluid">
			    </div>
			</div>
        </div>
    </div>
</div>

<script>
    // Example validation script
    (function () {
        'use strict'

        var forms = document.querySelectorAll('.needs-validation')

        Array.prototype.slice.call(forms)
            .forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }

                    form.classList.add('was-validated')
                }, false)
            })
    })()
</script>
</body>
</html>