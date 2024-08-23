<%@ page contentType="text/html; charset=US-ASCII"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
    <title>Car Listing</title>
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
    </style>
</head>
<body>
    <%@ include file="header.jsp"%> 

    <div class="container"> 
        <sec:authorize access="hasRole('Users')">
            <div class="row p-3 mb-5" style="background-color: #333; color: #fff;">
                <div class="col-md-5">
                    <h3 style="margin-bottom: 0;">Sell Your Car Today!</h3>
                    <p style="margin-bottom: 0;">Sell Your Car in a click with Us</p>
                </div>
                <div class="col-md-5"></div>
                <div class="col-md-2 text-end">
                    <button type="button" class="btn btn-light" data-bs-toggle="modal" data-bs-target="#exampleModal">
                        Sell Now
                    </button>
                </div>
            </div>
            <div class="modal fade" id="exampleModal" tabindex="-1"
						aria-labelledby="exampleModalLabel" aria-hidden="true"
						role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">

								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">Want to start business? Sell your car here!</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<c:if test="${success_post != null}">
										<div class="alert alert-success">${success_post}</div>
									</c:if>

									<!-- Car Post Form -->
									<sf:form action="car_post" method="post" class="was-validated"
										modelAttribute="car" enctype="multipart/form-data">
										<div class="mb-3 mt-3">
											<label for="name" class="d-flex form-label">Name:</label>
											<sf:input type="text" class="form-control"
												placeholder="Enter car name" name="name" path="name"
												required="true" />
											<div class="valid-feedback">Valid.</div>
											<div class="invalid-feedback">Fill out this field.</div>
										</div>
										<div class="mb-3">
											<label for="model" class="d-flex form-label">Model:</label>
											<sf:input type="text" class="form-control"
												placeholder="Enter model" name="model" path="model"
												required="true" />
											<div class="valid-feedback">Valid.</div>
											<div class="invalid-feedback">Fill out this field.</div>
										</div>
										<div class="mb-3">
											<label for="price" class="d-flex form-label">Price
												(USD):</label>
											<sf:input type="text" class="form-control" id="price"
												placeholder="Enter car price" name="price" path="price"
												required="true" />
											<div class="valid-feedback">Valid.</div>
											<div class="invalid-feedback">Fill out this field.</div>
										</div>
										<div class="mb-3">
											<label for="make" class="d-flex form-label">Make
												Year:</label>
											<sf:input type="text" class="form-control"
												placeholder="Enter make year" name="make" path="make"
												required="true" />
											<div class="valid-feedback">Valid.</div>
											<div class="invalid-feedback">Fill out this field.</div>
										</div>
										<div class="mb-3">
											<label for="registeration" class="d-flex form-label">Registration
												Date:</label>
											<sf:input type="text" class="form-control" id="registration"
												placeholder="Enter registeration date" name="registration"
												path="registration" required="true" />
											<div class="valid-feedback">Valid.</div>
											<div class="invalid-feedback">Fill out this field.</div>
										</div>
										<div class="mb-3">
											<label class="d-flex form-label">Photo:</label> <input
												type="file" class="form-control" name="fileImage" id="photo"
												accept="image/png, image/jpeg" required="true" />
											<div class="valid-feedback">Valid.</div>
											<div class="invalid-feedback">Fill out this field.</div>
										</div>

										<div class="holder"
											style="height: 300px; width: 300px; margin: auto;">
											<img id="imgPreview" src="#" alt="image preview"
												style="width: inherit;" />
										</div>

										<button type="submit" class="btn btn-primary d-flex">Post</button>
									</sf:form>
									<script>
						            $(document).ready(() => {
						            	
						                $("#photo").change(function () {
						                    const file = this.files[0];
						                    if (file) {
						                        let reader = new FileReader();
						                        reader.onload = function (event) {
						                            $("#imgPreview")
						                              .attr("src", event.target.result);
						                        };
						                        reader.readAsDataURL(file);
						                    }
						                });
						            });
						        </script>
									<!-- Car Post Form -->
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Close</button>
								</div>
							</div>
						</div>
					</div>
        </sec:authorize>

		<div class="row">
	          <c:if test="${success_post != null}">
	              <div class="alert alert-success">
	                  ${success_post}
	                  Click here to <a href="/car_detail?cid=${id}">View</a> your car post
	              </div>
	          </c:if>
		</div> 
        <div class="row row-cols-1 row-cols-md-3 g-4">
            <c:forEach items="${cars}" var="c">
                <c:set var="id" value="${c.id}"></c:set>
                    <c:if test="${c.sellStatus != 'sold'}">
                        <div class="col">
                            <div class="card h-100">
                                <img class="card-img-top" src="${c.photoImagePath}" alt="${c.photos}">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title">${c.name}</h5>
                                    <p class="card-text"><i class="fas fa-tags"></i>&nbsp;USD ${c.price}</p>
                                    <a href="/car_detail?cid=${c.id}" class="btn btn-primary mt-auto">View Car Details</a>
                                </div>
                            </div>
                        </div>
                    </c:if>
            </c:forEach>
        </div>
    </div> 



    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</body>
</html>