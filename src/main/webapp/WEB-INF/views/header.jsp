<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm header">
    <div class="container-fluid">
        <a href="cars" class="navbar-brand" data-toggle="tooltip" data-placement="top" title="Home">
            <img src="/images/logo (2).png" height="40" alt="Logo">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <sec:authorize access="!isAuthenticated()">
                <div class="navbar-nav me-auto">
                    <a href="registration_form" class="nav-link">Register</a>
                    <a href="about_us" class="nav-link">About Us</a>
                    <a href="contact_us" class="nav-link">Contact Us</a>
                </div>
                <div class="navbar-nav ms-auto">
                    <a href="login" class="nav-link">Login</a>
                </div>
            </sec:authorize> 

            <sec:authorize access="isAuthenticated()">
                <sec:authorize access="hasRole('Users')">
                    <div class="navbar-nav me-auto">
                        <a class="nav-link" href="cars">Home</a>
                        <a href="about_us" class="nav-link">About Us</a>
                        <a href="contact_us" class="nav-link">Contact Us</a>
                    </div>
                </sec:authorize>
                <sec:authorize access="hasRole('Administrator')">
                    <div class="navbar-nav me-auto">
                        <a class="nav-link" href="cars">Home</a>
                        <a class="nav-link" href="all_cars">Car Management</a>
                        <a class="nav-link" href="users">User Management</a>
                    </div>
                </sec:authorize>
                <sec:authorize access="hasAnyRole('Administrator','Users')">
                    <div class="navbar-nav mx-auto">
                        <sf:form action="search" method="get" class="d-flex">
                            <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" name="keyword">
                            <button class="btn btn-outline-primary" type="submit">Search</button>
                        </sf:form>
                    </div>
                    <div class="navbar-nav ms-auto">
                        <a class="nav-link" href="profile">Profile</a>
                        <form action="logout" method="post" class="d-flex align-items-center">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <button type="submit" class="btn btn-primary ms-2">Logout</button>
                        </form>
                    </div>
                </sec:authorize>
            </sec:authorize>
        </div>
    </div>
</nav>