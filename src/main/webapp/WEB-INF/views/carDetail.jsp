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
    <title>Car Details</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="/css/style.css">
    <style>
    	.container{
    		margin: 50px auto;
    	}
        .carousel-item img {
            max-height: 500px;
            object-fit: contain;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp"%>

    <c:forEach items="${car}" var="c">
        <c:set var="id" value="${c.id}"></c:set>
        <c:set var="name" value="${c.name}"></c:set>
        <c:set var="image" value="${c.photoImagePath}"></c:set>
        <c:set var="make" value="${c.make}"></c:set>
        <c:set var="model" value="${c.model}"></c:set>
        <c:set var="registration" value="${c.registration}"></c:set>
        <c:set var="price" value="${c.price}"></c:set>
        <c:set var="sellStatus" value="${c.sellStatus}"></c:set>
    </c:forEach>

    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div id="carImageCarousel" class="carousel slide" data-bs-ride="carousel">
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="${image}" class="d-block w-100" alt="${name}">
                            </div>
                            <!-- Add additional carousel items for multiple images if needed -->
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#carImageCarousel" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carImageCarousel" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>
                </div>
                <div class="col-md-6">
                    <h2>${name}</h2>
                    <p class="lead">Condition: <span class="badge bg-secondary"><i class="fas fa-car"></i> Used Car</span></p>
                    <hr>
                    <div class="row">
                        <div class="col-md-6">
                            <p><i class="fas fa-calendar"></i> Manufacture Year: ${make}</p>
                            <p><i class="fas fa-tag"></i> Model: ${model}</p>
                        </div>
                        <div class="col-md-6">
                            <p><i class="fas fa-calendar"></i> Registration Date: ${registration}</p>
                        </div>
                    </div>
                    <c:if test="${sellStatus == 'sold'}">
                        <div class="alert alert-danger" role="alert">
                            <h4 class="alert-heading">Car Sold!</h4>
                            This car has been sold. Please check our other listings for available vehicles.
                        </div>
                    </c:if>
                    <c:if test="${sellStatus != 'sold'}">
                        <h3 class="mt-4"><i class="fas fa-dollar-sign"></i> Current Price: USD ${price}</h3>
                        <h4 class="mt-3">
                            <i class="fas fa-gavel"></i> Current Bid:
                            <c:if test="${empty highest}">
                                USD 0
                            </c:if>
                            <c:if test="${not empty highest}">
                                USD ${highest}
                            </c:if>
                        </h4>
                        <div class="mt-4">
                            <!-- Button trigger modal -->
                            <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#bookModal">
                                <i class="fas fa-calendar-alt"></i> Book for Test Drive
                            </button>
                            <!-- Button trigger modal -->
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#bidModal">
                                <i class="fas fa-gavel"></i> Bid
                            </button>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Book Modal -->
            <div class="modal fade" id="bookModal" tabindex="-1" aria-labelledby="bookModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="bookModalLabel">Book for Test Drive</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <!-- Book Form -->
                            <sf:form action="book" method="post" class="was-validated" modelAttribute="booking">
                                <div class="mb-3">
                                    <label for="bookDate" class="form-label">Booking Date:</label>
                                    <input type="date" class="form-control" name="bookDate" required>
                                    <div class="invalid-feedback">Please select a booking date.</div>
                                </div>
                                <input type="hidden" name="cid" value="${id}">
                                <button type="submit" class="btn btn-primary">Book on this Date</button>
                            </sf:form>
                            <!-- Book Form -->
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bid Modal -->
            <div class="modal fade" id="bidModal" tabindex="-1" aria-labelledby="bidModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="bidModalLabel">Car Bidding</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <!-- Bid Form -->
                            <sf:form action="bid" method="post" class="was-validated" modelAttribute="bidding">
                                <div class="mb-3">
                                    <label for="bidderPrice" class="form-label">Bid Price (USD):</label>
                                    <input type="text" class="form-control" placeholder="Enter bidding price" name="bidderPrice" required>
                                    <div class="invalid-feedback">Please enter a valid bid price.</div>
                                </div>
                                <input type="hidden" name="cid" value="${id}">
                                <button type="submit" class="btn btn-primary">Bid at this price</button>
                            </sf:form>
                            <!-- Bid Form -->
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bidding & Booking Status -->
            <c:if test="${not empty bid}">
                <div class="row mt-5">
                    <div class="col-12">
                        <h3 class="mb-3">Bidding & Booking Status</h3>
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Bidding Date</th>
                                        <th>Bidding Price (RM)</th>
                                        <th>Test Drive Book Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${bid}" var="b">
                                        <tr>
                                            <td>${b.bidderName}</td>
                                            <td>${b.bidDate}</td>
                                            <td>${b.bidderPrice}</td>
                                            <td>${b.bookDate}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </section>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script src="/js/script.js"></script>
</body>
</html>