<%@ page contentType="text/html; charset=US-ASCII"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html >

<html lang="en">

<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Users Manager</title>
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
		<h3 style="margin-bottom: 20px;">User Management</h3>
		<div class="row">
			<div class="col-12">
				<table class="table table-striped table-bordered">
					<thead>
						<tr>
							<th scope="col">No.</th>
							<th scope="col">Name</th>
							<th scope="col">Username</th>
							<th scope="col">Email</th>
							<th scope="col">Role</th>
							<th scope="col">Action</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${user}" var="u" varStatus="status">
							<tr>
								<th scope="row">${status.count}</th>
								<td>${u.name}</td>
								<td>${u.userName}</td>
								<td>${u.email}</td>
								<c:forEach items="${u.roles}" var="r">
								    <td>
								        <div class="dropdown">
								            <button class="btn btn-sm btn-secondary dropdown-toggle" type="button" id="userRoleDropdown${status.index}" data-bs-toggle="dropdown" aria-expanded="false">
								                ${r.name}
								            </button>
								            <ul class="dropdown-menu" aria-labelledby="userRoleDropdown${status.index}">
								                <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#userRoleModal${status.index}">Update User Role</a></li>
								            </ul>
								        </div>
								        <!-- Modal -->
								        <div class="modal fade" id="userRoleModal${status.index}" tabindex="-1" aria-labelledby="userRoleModalLabel" aria-hidden="true">
								            <div class="modal-dialog">
								                <div class="modal-content">
								                    <div class="modal-header">
								                        <h5 class="modal-title" id="userRoleModalLabel">Assign User Role</h5>
								                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								                    </div>
								                    <div class="modal-body">
								                        <!-- Assign Role Form -->
								                        <sf:form action="/assign_role?uid=${u.id}" method="post" class="was-validated" modelAttribute="user">
								                            <div class="mb-3 mt-3">
								                                <label for="name" class="form-label">Role:</label>
								                                <div class="form-check">
								                                    <input class="form-check-input" type="radio" name="role" value="Administrator" id="roleAdministrator" required>
								                                    <label class="form-check-label" for="roleAdministrator">Administrator</label>
								                                </div>
								                                <div class="form-check">
								                                    <input class="form-check-input" type="radio" name="role" value="Users" id="roleUsers" required>
								                                    <label class="form-check-label" for="roleUsers">Users</label>
								                                </div>
								                                <div class="valid-feedback">Valid.</div>
								                                <div class="invalid-feedback">Please select a role.</div>
								                            </div>
								                            <button type="submit" class="btn btn-primary">Assign</button>
								                        </sf:form>
								                    </div>
								                </div>
								            </div>
								        </div>
								    </td>
								</c:forEach>
								<td><a type="button" class="btn btn-primary"
									href="/view?uid=${u.id}"> <i class="far fa-eye"></i>
								</a> <!-- Button trigger modal -->
									<button type="button" class="btn btn-success"
										data-bs-toggle="modal"
										data-bs-target="#exampleModal${status.index}">
										<i class="fas fa-edit"></i>
									</button> <!-- Modal -->

									<div class="modal fade" id="exampleModal${status.index}"
										tabindex="-1" aria-labelledby="exampleModalLabel"
										aria-hidden="true" role="dialog">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													<h5 class="modal-title" id="exampleModalLabel">Edit
														User</h5>
													<button type="button" class="btn-close"
														data-bs-dismiss="modal" aria-label="Close"></button>
												</div>
												<div class="modal-body">

													<!-- User Update Form -->
													<sf:form action="/edit?uid=${u.id}" method="post"
														class="was-validated" modelAttribute="user">
														<div class="mb-3 mt-3">
															<label for="name" class="form-label">Name:</label> <input
																type="text" class="form-control"
																placeholder="Enter name" name="name" value="${u.name}"
																required="true" />
															<div class="valid-feedback">Valid.</div>
															<div class="invalid-feedback">Please fill out this
																field.</div>
														</div>
														<div class="mb-3">
															<label for="userName" class="form-label">Username:</label>
															<input type="text" class="form-control" id="userName"
																placeholder="Enter username" name="userName"
																value="${u.userName}" />
															<div class="valid-feedback">Valid.</div>
															<div class="invalid-feedback">Please fill out this
																field.</div>
														</div>
														
														<div class="mb-3">
															<label for="email" class="form-label">Email:</label> <input
																type="email" class="form-control"
																placeholder="Enter username" name="email"
																value="${u.email}" required="true" />
															<div class="valid-feedback">Valid.</div>
															<div class="invalid-feedback">Please fill out this
																field.</div>
														</div>
														<div class="mb-3">
															<label for="mobile" class="form-label">Mobile:</label> <input
																type="text" class="form-control" id="mobile"
																placeholder="Enter mobile" name="mobile"
																value="${u.mobile}"  />
															
														</div>
														<div class="mb-3">
															<label for="address" class="form-label">Address:</label>
															<input type="text" class="form-control" id="address"
																placeholder="Enter address" name="address"
																value="${u.address}" " />
															
														</div>

														<button type="submit" class="btn btn-primary">Edit</button>
													</sf:form>
													<!-- User Update Form -->
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-secondary"
														data-bs-dismiss="modal">Close</button>

												</div>
											</div>
										</div>

									</div> 
									<!-- delete car -->
						            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal${status.index}">
						                <i class="far fa-trash-alt"></i>
						            </button>
									<!-- Delete Car Confirmation Modal -->
						            <div class="modal fade" id="deleteModal${status.index}" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
						                <div class="modal-dialog">
						                    <div class="modal-content">
						                        <div class="modal-header">
						                            <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
						                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						                        </div>
						                        <div class="modal-body">
						                            Are you sure you want to delete this user "${u.name}"?
						                        </div>
						                        <div class="modal-footer">
						                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
						                            <a type="button" class="btn btn-danger" href="/delete?uid=${u.id}">Delete</a>
						                        </div>
						                    </div>
						                </div>
						            </div>
           						 	<!-- delete car -->
									</td>
							</tr>

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
    <script>
        $(document).ready(function () {
            $('#carsTable').DataTable();
        });
    </script>

</body>
</html>