<%@ page contentType="text/html; charset=US-ASCII"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>

<!--  Enable Bootstrap -->
	<title>Search Results</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
    <link href="/css/style.css" rel="stylesheet" />
    <link rel="stylesheet" href="/css/style.css"> 
    <script src="/js/script.js"></script>
       <style>
        .container {
            max-width: 1200px;
            margin: 80px auto;
            padding: 20px;
        }
        .card {
            border: none; 
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: 0.3s;
            overflow: hidden;
        }     
        .card:hover {
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }
        .card-img-top {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .card-body {
            padding: 20px;
        }
        .card-title {
            font-size: 1.2rem;
            font-weight: 600;
        }
        .card-text {
            font-size: 1rem;
            color: #777;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0069d9;
            border-color: #0062cc;
        }        
        </style>

</head>

<body>

	<%@ include file="header.jsp"%>


	<div class="container">


		<c:if test="${empty searchCar}">

			<div class="alert alert-danger">No search results found for
			${keyword}</div>

		</c:if>
		<!-- list of all cars posted -->
		<div class="row row-cols-1 row-cols-md-3 g-4">
			<c:forEach items="${searchCar}" var="c">
				<c:if test="${c.sellStatus != 'sold'}">
					<div class="col"> 
						<div class="card h-100" >
							<img class="card-img-top" src="${c.photoImagePath}" alt="${c.photos}" >
							<div class="card-body d-flex flex-column">
								<h5 class="card-title">${c.name}</h5>
								<p class="card-text"><i class="fas fa-tags"></i>&nbsp;RM ${c.price}</p>
								<a href="/car_detail?cid=${c.id}" class="btn btn-primary mt-auto">View Car Details</a>
							</div>
						</div>
					</div>
				</c:if>
			</c:forEach>
		</div>
		<!-- list of all cars posted -->
	</div>

</body>
</html>