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
    <title>All Cars Manager</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
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
        <div class="container">
            <h2 class="mb-4">Car Management</h2>
            <div class="row">
                <div class="col-12">
                    <table id="carsTable" class="table table-striped table-bordered" style="width:100%">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Name</th>
                                <th>Model</th>
                                <th>Price (RM)</th>
                                <th>Seller</th>
                                <th>Actions</th>
                                <th>Sell Status</th>
                                <th>Current Bid (RM)</th>
                                <th>Booking Date</th>
                                <th>Booking Status</th>
                                <th>Bidder Name</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${cars}" var="c" varStatus="status">
                                <tr>
                                    <th scope="row">${status.count}</td>
                                    <td>${c.name}</td>
                                    <td>${c.model}</td>
                                    <td>${c.price}</td>
                                    <td>
                                        <a href="/view?uid=${c.sellerId}" class="btn btn-sm btn-primary" title="View Seller">
                                            <i class="far fa-eye"></i>
                                        </a>
                                    </td>
                                    <td>
                                        <a href="/car_detail?cid=${c.id}" class="btn btn-sm btn-primary" title="View Car">
                                            <i class="far fa-eye"></i>
                                        </a>
                                        <button class="btn btn-sm btn-success" data-bs-toggle="modal" data-bs-target="#editCarModal${status.index}" title="Edit Car">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#deleteCarModal${status.index}" title="Delete Car">
                                            <i class="far fa-trash-alt"></i>
                                        </button>
                                    </td>
                                    <td>
                                        <div class="dropdowns">
                                            <button class="btn btn-sm btn-secondary dropdown-toggle" type="button" id="sellStatusDropdown${status.index}" data-bs-toggle="dropdown" aria-expanded="false">
                                                ${c.sellStatus}
                                            </button>
                                            <ul class="dropdown-menu" aria-labelledby="sellStatusDropdown${status.index}">
                                                <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#sellStatusModal${status.index}">Update Sell Status</a></li>
                                            </ul>
                                        </div>
                                    </td>
                                    <c:forEach items="${c.biddings}" var="b" begin="0" end="0">
                                        <td>${b.bidderPrice}</td>
                                        <td>${b.bookDate}</td>
                                        <td>
                                            <div class="dropdown">
                                                <button class="btn btn-sm btn-secondary dropdown-toggle" type="button" id="bookStatusDropdown${status.index}" data-bs-toggle="dropdown" aria-expanded="false">
                                                    ${b.bookStatus}
                                                </button>
                                                <ul class="dropdown-menu" aria-labelledby="bookStatusDropdown${status.index}">
                                                    <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#bookStatusModal${status.index}">Update Book Status</a></li>
                                                </ul>
                                            </div>
			                                <!-- Book Status Modal -->
			                                <div class="modal fade" id="bookStatusModal${status.index}" tabindex="-1" aria-labelledby="bookStatusModalLabel" aria-hidden="true">
			                                    <div class="modal-dialog">
			                                        <div class="modal-content">
			                                            <div class="modal-header">
			                                                <h5 class="modal-title" id="bookStatusModalLabel">Set Booking Status</h5>
			                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			                                            </div>
			                                            <div class="modal-body">
			                                                <!-- Booking Status Form -->
			                                                <!-- Booking Status Form -->
			                                                <sf:form action="/booking_status?bid=${b.id}" method="post" class="was-validated" modelAttribute="book">
			                                                    <div class="mb-3">
			                                                        <label for="bookStatus" class="form-label">Booking Status:</label>
			                                                        <input type="text" class="form-control" placeholder="Enter booking status" name="bookStatus" value="${b.bookStatus}" required>
			                                                        <div class="invalid-feedback">Please enter the booking status.</div>
			                                                    </div>
			                                                    <button type="submit" class="btn btn-primary">Set</button>
			                                                </sf:form>
			                                            </div>
			                                        </div>
			                                    </div>
			                                </div>                                    
                                        </td>
                                        <td>${b.bidderName}</td>
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
                                                <sf:form action="/edit_car?cid=${c.id}" method="post" class="was-validated" modelAttribute="car" enctype="multipart/form-data">
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
                                                        <label for="price" class="form-label">Price (RM):</label>
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
                                                <a href="/delete_car?cid=${c.id}" class="btn btn-danger">Delete</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Sell Status Modal -->
                                
                                <div class="modal fade" id="sellStatusModal${status.index}" tabindex="-1" aria-labelledby="sellStatusModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="sellStatusModalLabel">Set Car Sale Status</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <!-- Sale Status Form -->
                                                <sf:form action="/sale_status?cid=${c.id}" method="post" class="was-validated" modelAttribute="biddings">
                                                    <div class="mb-3 mt-3">
                                                        <label for="sellStatus" class="form-label">Sale Status:</label>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="sellStatus" value="" id="sellStatusBlank${status.index}" required>
                                                            <label class="form-check-label" for="sellStatusBlank${status.index}">
                                                                Blank
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="sellStatus" value="sold" id="sellStatusSold${status.index}" required>
                                                            <label class="form-check-label" for="sellStatusSold${status.index}">
                                                                Sold
                                                            </label>
                                                        </div>
                                                        <div class="valid-feedback">Valid.</div>
                                                        <div class="invalid-feedback">Please select the sale status.</div>
                                                    </div>
                                                    <button type="submit" class="btn btn-primary">Set</button>
                                                </sf:form>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
    <!-- Custom JS -->
    <script src="/js/script.js"></script>

</body>
</html>