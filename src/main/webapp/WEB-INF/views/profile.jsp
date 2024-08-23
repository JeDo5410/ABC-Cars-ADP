<%@ page contentType="text/html; charset=US-ASCII"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="/css/style.css">
    
    <style>
    .container{
    	margin: 50px auto;
    }
    </style>
</head>
<body>
    <%@ include file="header.jsp"%>

    <section class="py-5">
    <section> <c:forEach items="${user}" var="u">
		<c:set var="id" value="${u.id}"></c:set>
		<c:set var="name" value="${u.name}"></c:set>
		<c:set var="uname" value="${u.userName}"></c:set>
		<c:set var="email" value="${u.email}"></c:set>
		<c:set var="mobile" value="${u.mobile}"></c:set>
		<c:set var="address" value="${u.address}"></c:set>
	</c:forEach>
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <div class="card mb-4">
                        <div class="card-body text-center">
                            <img src="/images/img_avatar3.png" alt="Avatar" class="rounded-circle img-fluid" style="width: 150px;">
                            <h5 class="my-3">${name}</h5>
                            <p class="text-muted mb-1">${address}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="card mb-4">
                        <div class="card-body">
                            <h5 class="card-title">User Details <button type="button" class="btn btn-sm btn-primary float-end" data-bs-toggle="modal" data-bs-target="#editModal"><i class="fas fa-edit"></i> Edit</button></h5>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3"><p class="mb-0">Full Name</p></div>
                                <div class="col-sm-9"><p class="text-muted mb-0">${name}</p></div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3"><p class="mb-0">Email</p></div>
                                <div class="col-sm-9"><p class="text-muted mb-0">${email}</p></div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3"><p class="mb-0">Username</p></div>
                                <div class="col-sm-9"><p class="text-muted mb-0">${uname}</p></div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3"><p class="mb-0">Mobile</p></div>
                                <div class="col-sm-9"><p class="text-muted mb-0">${mobile}</p></div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3"><p class="mb-0">Address</p></div>
                                <div class="col-sm-9"><p class="text-muted mb-0">${address}</p></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Edit Modal -->
            <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editModalLabel">Update User</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <!-- User Update Form -->
                            <sf:form action="update" method="post" class="was-validated" modelAttribute="user">
                                <div class="mb-3">
                                    <label for="name" class="form-label">Name:</label>
                                    <input type="text" class="form-control" placeholder="Enter name" name="name" path="name" value="${name}" required>
                                    <div class="invalid-feedback">Please enter your name.</div>
                                </div>
                                <div class="mb-3">
                                    <label for="userName" class="form-label">Username:</label>
                                    <input type="text" class="form-control" id="userName" placeholder="Enter username" name="userName" path="userName" value="${uname}">
                                </div>
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email:</label>
                                    <input type="email" class="form-control" placeholder="Enter email" name="email" path="email" value="${email}" required>
                                    <div class="invalid-feedback">Please enter a valid email address.</div>
                                </div>
                                <div class="mb-3">
                                    <label for="mobile" class="form-label">Mobile:</label>
                                    <input type="text" class="form-control" id="mobile" placeholder="Enter mobile" name="mobile" path="mobile" value="${mobile}">
                                </div>
                                <div class="mb-3">
                                    <label for="address" class="form-label">Address:</label>
                                    <input type="text" class="form-control" id="address" placeholder="Enter address" name="address" path="address" value="${address}">
                                </div>
                                <button type="submit" class="btn btn-primary">Update</button>
                            </sf:form>
                            <!-- User Update Form -->
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mt-4">
                <div class="col-12">
                    <nav>
                        <div class="nav nav-tabs" id="nav-tab" role="tablist">
                            <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">Post Status</button>
                            <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">Booking Status</button>
                        </div>
                    </nav>
                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                            <c:if test="${not empty cars}">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">Car</th>
                                                <th scope="col">Post Date</th>
                                                <th scope="col">Actions</th>
                                                <th scope="col">Current Bid (USD)</th>
                                                <th scope="col">Bidder Name</th>
                                                <th scope="col">Sale Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${cars}" var="c" varStatus="status">
                                                <tr>
                                                    <th scope="row">${status.count}</th>
                                                    <td>${c.name}</td>
                                                    <td>${c.postDate}</td>
                                                    <td>
                                                        <!-- View Car -->
                                                        <a href="/car_detail?cid=${c.id}" class="btn btn-sm btn-primary" title="View Car">
                                                            <i class="far fa-eye"></i>
                                                        </a>
                                                        <!-- Edit Car -->
                                                        <button class="btn btn-sm btn-success" data-bs-toggle="modal" data-bs-target="#editCarModal${status.index}" title="Edit Car">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <!-- Delete Car -->
                                                        <button class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#deleteCarModal${status.index}" title="Delete Car">
                                                            <i class="far fa-trash-alt"></i>
                                                        </button>
                                                    </td>
                                                    <c:forEach items="${c.biddings}" var="b" begin="0" end="0">
                                                        <c:set var="bidPrice" value="${b.bidderPrice}"></c:set>
                                                        <c:if test="${bidPrice > 0}">
                                                            <td>${b.bidderPrice}</td>
                                                            <td>${b.bidderName}</td>
                                                        </c:if>
                                                        <td>${c.sellStatus}</td>
                                                    </c:forEach>
                                                </tr>

                                                <!-- Edit Car Modal -->
                                                <div class="modal fade" id="editCarModal${status.index}" tabindex="-1" aria-labelledby="editCarModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog modal-lg">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="editCarModalLabel">Edit Car Post</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <!-- Car Post Form -->
                                                                <sf:form action="/edit_car1?cid=${c.id}" method="post" class="was-validated" modelAttribute="car" enctype="multipart/form-data">
                                                                    <div class="mb-3">
                                                                        <label for="name" class="form-label">Name:</label>
                                                                        <input type="text" class="form-control" placeholder="Enter car name" name="name" path="name" required value="${c.name}">
                                                                        <div class="invalid-feedback">Please enter the car name.</div>
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="model" class="form-label">Model:</label>
                                                                        <input type="text" class="form-control" placeholder="Enter model" name="model" path="model" value="${c.model}" required>
                                                                        <div class="invalid-feedback">Please enter the car model.</div>
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="price" class="form-label">Price (USD):</label>
                                                                        <input type="text" class="form-control" id="price" placeholder="Enter car price" name="price" path="price" value="${c.price}" required>
                                                                        <div class="invalid-feedback">Please enter the car price.</div>
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="make" class="form-label">Make Year:</label>
                                                                        <input type="text" class="form-control" placeholder="Enter make year" name="make" path="make" value="${c.make}" required>
                                                                        <div class="invalid-feedback">Please enter the make year.</div>
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="registration" class="form-label">Registration Date:</label>
                                                                        <input type="text" class="form-control" id="registration" placeholder="Enter registration date" name="registration" path="registration" value="${c.registration}" required>
                                                                        <div class="invalid-feedback">Please enter the registration date.</div>
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label class="form-label">Photo:</label>
                                                                        <input type="file" class="form-control" name="fileImage" id="photo" accept="image/png, image/jpeg" required>
                                                                        <div class="invalid-feedback">Please select a photo.</div>
                                                                    </div>
                                                                    <input type="hidden" name="sellerId" value="${c.sellerId}">
                                                                    <input type="hidden" name="photos" value="${c.photos}">
                                                                    <input type="hidden" name="photoImagePath" value="${c.photoImagePath}">
                                                                    <div class="holder mb-3" style="height: 300px; width: 300px; margin: auto;">
                                                                        <img id="imgPreview" src="${c.photoImagePath}" alt="Image Preview" class="img-fluid">
                                                                    </div>
                                                                    <button type="submit" class="btn btn-primary">Update</button>
                                                                </sf:form>
                                                                <!-- Car Post Form -->
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Delete Car Modal -->
                                                <div class="modal fade" id="deleteCarModal${status.index}" tabindex="-1" aria-labelledby="deleteCarModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="deleteCarModalLabel">Confirm Delete</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                Are you sure you want to delete the car "${c.name}"?
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                <a href="/delete_car1?cid=${c.id}" class="btn btn-danger">Delete</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:if>
                        </div>
                        <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                            <c:if test="${not empty cars}">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">Car</th>
                                                <th scope="col">Book Date</th>
                                                <th scope="col">Book By</th>
                                                <th scope="col">Book Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${cars}" var="c" varStatus="status">
                                                <c:forEach items="${c.biddings}" var="b">
                                                    <c:set var="bookDate" value="${b.bookDate}"></c:set>
                                                    <c:if test="${bookDate != null}">
                                                        <tr>
                                                            <th scope="row">${status.count}</th>
                                                            <td>${c.name}</td>
                                                            <td>${b.bookDate}</td>
                                                            <td>${b.bidderName}</td>
                                                            <td>${b.bookStatus}</td>
                                                        </tr>
                                                    </c:if>
                                                </c:forEach>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:if>

                            <c:if test="${empty cars}">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">Book Date</th>
                                                <th scope="col">Car</th>
                                                <th scope="col">Book Status</th>
                                                <th scope="col">View Car</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${bids}" var="b" varStatus="status">
                                                <c:set var="bookDate" value="${b.bookDate}"></c:set>
                                                <c:if test="${bookDate != null}">
                                                    <tr>
                                                        <th scope="row">${status.count}</th>
                                                        <td>${b.bookDate}</td>
                                                        <td>${b.car.name}</td>
                                                        <td>${b.bookStatus}</td>
                                                        <td>
                                                            <a href="/car_detail?cid=${b.car.id}" class="btn btn-sm btn-primary" title="View Car">
                                                                <i class="far fa-eye"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- Custom JS -->
    <script src="/js/script.js"></script>
</body>
</html>