<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
   	<link rel="stylesheet" href="/css/style.css"> 
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f8f9fa;
        }
        .container {
            max-width: 900px;
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
		    height: 400px; /* Set a fixed height */
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
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-group label {
            font-weight: bold;
            color: #555;
        }
        .form-control {
            border-radius: 0.25rem;
            padding: 0.75rem 1rem;
            border: 1px solid #ced4da;
            font-size: 1rem;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            padding: 0.75rem 1.5rem;
            font-size: 1rem;
            font-weight: bold;
        }
        .btn-primary:hover {
            background-color: #0069d9;
            border-color: #0062cc;
        }
        .error {
            color: #dc3545;
            font-size: 0.875rem;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp"%>
    <div class="container py-5">
        <div class="row">
            <div class="col-md-6 order-md-2">
                <h2 class="mb-4">Register Now!</h2>
                <form:form action="registration_process" method="post" modelAttribute="user">
                    <div class="form-group">
                        <label for="fullname">Full Name:</label>
                        <form:input path="name" type="text" class="form-control" id="fullname" placeholder="Enter Full Name" name="fullname" required="true" />
                        <form:errors path="name" cssClass="error" />
                    </div>
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <form:input path="email" type="email" class="form-control" id="email" placeholder="Enter Email" name="email" required="true" />
                        <form:errors path="email" cssClass="error" />
                    </div>
                    <div class="form-group">
                        <label for="pwd">Password:</label>
                        <form:input path="password" type="password" class="form-control" id="pwd" placeholder="Enter Password" name="pwd" required="true" />
                        <form:errors path="password" cssClass="error" />
                    </div>
                    <button type="submit" class="btn btn-primary">Register</button>
                </form:form>
                <p class="mt-3">Already have an account? <a href="login">Sign In</a></p>
            </div>
            <div class="col-md-6 order-md-1 mb-4">
            	<div class="image-container"> 
                	<img src="<c:url value='images/register.png'/>" alt="Finance related image" class="img-fluid">
            	</div>
            </div>
        </div>
    </div>
</body>
</html>