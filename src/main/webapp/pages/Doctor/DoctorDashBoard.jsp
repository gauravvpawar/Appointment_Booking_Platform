<%@page import="com.example.demo.Model.Doctor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


 <%
HttpSession s1 = request.getSession();
Doctor doctor = (Doctor)s1.getAttribute("doctor");

if(doctor == null)
{
    out.println("<script>");
    out.println("alert('You cannot access directly ! Login first')");
    out.println("window.location.href = './'");
    out.println("</script>");
}
%>   


<c:if test="${not empty msg}">
    <div id="toast" class="toast">
        ${msg}
    </div>
</c:if>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

 <title>Doctor Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
    :root {
        --primary: #2563eb;
        --primary-dark: #1d4ed8;
        --primary-light: #3b82f6;
        --secondary: #0ea5e9;
        --success: #10b981;
        --warning: #f59e0b;
        --danger: #ef4444;
        --info: #06b6d4;
        --light-bg: #f8fafc;
        --sidebar-bg: #1e293b;
        --card-bg: #ffffff;
        --text-dark: #1e293b;
        --text-light: #64748b;
        --border: #e2e8f0;
        --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
        --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        background-color: var(--light-bg);
        color: var(--text-dark);
        line-height: 1.6;
        display: flex;
        min-height: 100vh;
    }

    /* SIDEBAR */
    .sidebar {
        width: 260px;
        background: var(--sidebar-bg);
        color: white;
        height: 100vh;
        position: fixed;
        z-index: 1000;
        transition: all 0.3s ease;
        overflow-y: auto;
    }

    .sidebar-header {
        padding: 24px 20px;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .brand {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .brand-logo {
        width: 40px;
        height: 40px;
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.2rem;
    }

    .brand-text h2 {
        font-size: 1.3rem;
        font-weight: 700;
        color: white;
    }

    .brand-text p {
        font-size: 0.75rem;
        color: rgba(255, 255, 255, 0.7);
        font-weight: 500;
    }

    .sidebar-menu {
        padding: 20px 0;
    }

    .nav-item {
        list-style: none;
    }

    .nav-link {
        display: flex;
        align-items: center;
        padding: 12px 20px;
        color: rgba(255, 255, 255, 0.8);
        text-decoration: none;
        transition: all 0.3s ease;
        font-weight: 500;
        border-left: 3px solid transparent;
    }

    .nav-link:hover {
        background: rgba(255, 255, 255, 0.1);
        color: white;
        border-left-color: var(--primary);
    }

    .nav-link.active {
        background: rgba(255, 255, 255, 0.15);
        color: white;
        border-left-color: var(--primary);
    }

    .nav-icon {
        width: 24px;
        margin-right: 12px;
        font-size: 1.1rem;
        text-align: center;
    }

    /* MAIN CONTENT */
    .main-content {
        flex: 1;
        margin-left: 260px;
        padding: 0;
        transition: all 0.3s ease;
    }

    /* HEADER */
    .header {
        background: white;
        padding: 18px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: var(--shadow-sm);
        position: sticky;
        top: 0;
        z-index: 100;
    }

    .page-title h1 {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--text-dark);
    }

    .user-actions {
        display: flex;
        align-items: center;
        gap: 20px;
    }

    .user-profile {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 8px 16px;
        background: var(--light-bg);
        border-radius: 12px;
        border: 1px solid var(--border);
    }

    .user-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: 600;
        font-size: 1rem;
    }

    .user-info h4 {
        font-size: 0.95rem;
        font-weight: 600;
        color: var(--text-dark);
        margin-bottom: 2px;
    }

    .user-info p {
        font-size: 0.8rem;
        color: var(--text-light);
    }

    .logout-btn {
        padding: 10px 20px;
        background: linear-gradient(135deg, var(--danger), #f87171);
        color: white;
        text-decoration: none;
        border-radius: 8px;
        font-weight: 600;
        font-size: 0.9rem;
        display: flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 12px rgba(239, 68, 68, 0.2);
    }

    .logout-btn:hover {
        background: linear-gradient(135deg, #dc2626, var(--danger));
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(239, 68, 68, 0.3);
    }

    /* CONTENT AREA */
    .content-area {
        padding: 30px;
        max-width: 1400px;
        margin: 0 auto;
    }

    /* STATS CARDS */
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }

    .stat-card {
        background: white;
        border-radius: 16px;
        padding: 24px;
        box-shadow: var(--shadow);
        transition: all 0.3s ease;
        border: 1px solid var(--border);
    }

    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: var(--shadow-lg);
    }

    .stat-header {
        display: flex;
        align-items: center;
        gap: 15px;
        margin-bottom: 20px;
    }

    .stat-icon {
        width: 56px;
        height: 56px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        color: white;
    }

    .stat-content h3 {
        font-size: 2rem;
        font-weight: 700;
        color: var(--text-dark);
        line-height: 1;
        margin-bottom: 4px;
    }

    .stat-content p {
        font-size: 0.9rem;
        color: var(--text-light);
        font-weight: 500;
    }

    /* PROFILE SECTION */
    .profile-section {
        display: grid;
        grid-template-columns: 1fr 2fr;
        gap: 30px;
        margin-bottom: 30px;
    }

    @media (max-width: 1024px) {
        .profile-section {
            grid-template-columns: 1fr;
        }
    }

    .profile-card {
        background: white;
        border-radius: 16px;
        padding: 30px;
        box-shadow: var(--shadow);
        text-align: center;
        border-top: 4px solid var(--primary);
    }

    .profile-avatar {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    background: linear-gradient(135deg, var(--primary), var(--secondary));
    margin: 0 auto 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 2.5rem;
    border: 4px solid white;
    box-shadow: 0 8px 25px rgba(37, 99, 235, 0.2);
    overflow: hidden; /* IMPORTANT */
	}
	
	.profile-avatar img.profile-img {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	}
	

    .doctor-info h2 {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--text-dark);
        margin-bottom: 8px;
    }

    .doctor-specialization {
        display: inline-block;
        padding: 6px 16px;
        background: linear-gradient(135deg, rgba(37, 99, 235, 0.1), rgba(37, 99, 235, 0.15));
        color: var(--primary);
        border-radius: 20px;
        font-size: 0.9rem;
        font-weight: 600;
        margin-bottom: 20px;
    }

    .contact-info {
        text-align: left;
        margin: 25px 0;
    }

    .contact-item {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 10px 0;
        border-bottom: 1px solid var(--border);
    }

    .contact-item:last-child {
        border-bottom: none;
    }

    .contact-icon {
        width: 32px;
        height: 32px;
        background: linear-gradient(135deg, #f0f9ff, #e0f2fe);
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--primary);
        font-size: 0.9rem;
    }

    .contact-text {
        flex: 1;
    }

    .contact-label {
        font-size: 0.8rem;
        color: var(--text-light);
        margin-bottom: 2px;
    }

    .contact-value {
        font-size: 0.95rem;
        color: var(--text-dark);
        font-weight: 500;
    }

    .status-badge {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 8px 18px;
        background: linear-gradient(135deg, rgba(16, 185, 129, 0.15), rgba(16, 185, 129, 0.2));
        color: var(--success);
        border-radius: 50px;
        font-size: 0.85rem;
        font-weight: 600;
        margin: 15px 0;
    }

    .profile-actions {
        display: flex;
        gap: 12px;
        margin-top: 25px;
    }

    .btn {
        flex: 1;
        padding: 12px;
        border: none;
        border-radius: 8px;
        font-weight: 600;
        font-size: 0.9rem;
        cursor: pointer;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }

    .btn-primary {
        background: linear-gradient(135deg, var(--primary), var(--primary-light));
        color: white;
        box-shadow: 0 4px 12px rgba(37, 99, 235, 0.2);
    }

    .btn-primary:hover {
        background: linear-gradient(135deg, var(--primary-dark), var(--primary));
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(37, 99, 235, 0.3);
    }

    .btn-danger {
        background: linear-gradient(135deg, var(--danger), #f87171);
        color: white;
        box-shadow: 0 4px 12px rgba(239, 68, 68, 0.2);
    }

    .btn-danger:hover {
        background: linear-gradient(135deg, #dc2626, var(--danger));
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(239, 68, 68, 0.3);
    }

    /* DATA CARDS */
    .data-card {
        background: white;
        border-radius: 16px;
        box-shadow: var(--shadow);
        margin-bottom: 30px;
        overflow: hidden;
    }

    .card-header {
        padding: 20px 30px;
        border-bottom: 1px solid var(--border);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .card-header h3 {
        font-size: 1.25rem;
        font-weight: 700;
        color: var(--text-dark);
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .card-body {
        padding: 30px;
    }

    /* TABLES */
    .table-container {
        overflow-x: auto;
        border-radius: 12px;
        border: 1px solid var(--border);
    }

    .data-table {
        width: 100%;
        border-collapse: collapse;
        min-width: 800px;
    }

    .data-table thead {
        background: linear-gradient(135deg, var(--light-bg), #f1f5f9);
    }

    .data-table th {
        padding: 16px 20px;
        text-align: left;
        font-weight: 600;
        color: var(--text-dark);
        font-size: 0.9rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border-bottom: 2px solid var(--border);
    }

    .data-table td {
        padding: 16px 20px;
        border-bottom: 1px solid var(--border);
        color: var(--text-dark);
        font-weight: 500;
    }

    .data-table tbody tr {
        transition: all 0.2s ease;
    }

    .data-table tbody tr:hover {
        background: rgba(37, 99, 235, 0.03);
    }

    .status-tag {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 6px 14px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 600;
    }

    .status-active {
        background: linear-gradient(135deg, rgba(16, 185, 129, 0.15), rgba(16, 185, 129, 0.2));
        color: var(--success);
    }

    .status-pending {
        background: linear-gradient(135deg, rgba(245, 158, 11, 0.15), rgba(245, 158, 11, 0.2));
        color: var(--warning);
    }

    .status-monitoring {
        background: linear-gradient(135deg, rgba(6, 182, 212, 0.15), rgba(6, 182, 212, 0.2));
        color: var(--info);
    }

    .view-btn {
        padding: 6px 16px;
        background: linear-gradient(135deg, var(--primary), var(--primary-light));
        color: white;
        border: none;
        border-radius: 6px;
        font-size: 0.8rem;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }

    .view-btn:hover {
        background: linear-gradient(135deg, var(--primary-dark), var(--primary));
        transform: translateY(-1px);
    }

    /* NO APPOINTMENTS STATE */
    .empty-state {
        text-align: center;
        padding: 60px 20px;
        color: var(--text-light);
    }

    .empty-state i {
        font-size: 3rem;
        margin-bottom: 20px;
        opacity: 0.5;
    }

    .empty-state h4 {
        font-size: 1.25rem;
        margin-bottom: 10px;
        color: var(--text-dark);
    }

    .empty-state p {
        margin-bottom: 25px;
        max-width: 400px;
        margin: 0 auto 25px;
    }

    /* RESPONSIVE DESIGN */
    @media (max-width: 1200px) {
        .sidebar {
            width: 80px;
        }
        
        .sidebar-header .brand-text,
        .nav-link span {
            display: none;
        }
        
        .brand {
            justify-content: center;
        }
        
        .nav-link {
            justify-content: center;
            padding: 15px;
        }
        
        .nav-icon {
            margin-right: 0;
            font-size: 1.3rem;
        }
        
        .main-content {
            margin-left: 80px;
        }
    }

    @media (max-width: 768px) {
        .content-area {
            padding: 20px;
        }
        
        .header {
            flex-direction: column;
            gap: 15px;
            padding: 15px;
        }
        
        .user-actions {
            flex-direction: column;
            width: 100%;
        }
        
        .user-profile {
            width: 100%;
            justify-content: center;
        }
        
        .logout-btn {
            width: 100%;
            justify-content: center;
        }
        
        .stats-grid {
            grid-template-columns: 1fr;
        }
        
        .profile-actions {
            flex-direction: column;
        }
        
        .card-body {
            padding: 20px;
        }
    }

    /* ANIMATIONS */
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .fade-in {
        animation: fadeInUp 0.5s ease-out forwards;
    }

    .delay-1 {
        animation-delay: 0.1s;
    }

    .delay-2 {
        animation-delay: 0.2s;
    }

    .delay-3 {
        animation-delay: 0.3s;
    }
    
    
    .toast {
    position: fixed;
    top: 20px;
    right: 20px;
    background: linear-gradient(135deg, #10b981, #34d399);
    color: white;
    padding: 14px 24px;
    border-radius: 10px;
    font-weight: 600;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
    z-index: 9999;
    animation: slideIn 0.5s ease, fadeOut 0.5s ease 3s forwards;
}

@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateX(50px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

@keyframes fadeOut {
    to {
        opacity: 0;
        transform: translateX(50px);
    }
}
    
    
</style>
</head>
<body>



<!-- SIDEBAR -->
<div class="sidebar">
    <div class="sidebar-header">
        <div class="brand">
            <div class="brand-logo">
                <i class="fas fa-stethoscope"></i>
            </div>
            <div class="brand-text">
                <h2>MediCare </h2>
                <p>Doctor Portal</p>
            </div>
        </div>
    </div>
    
    <div class="sidebar-menu">
        <ul class="nav-list">
            <li class="nav-item">
                <a href="#" class="nav-link active">
                    <span class="nav-icon"><i class="fas fa-home"></i></span>
                    <span>Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="#Upcomming_appointment" class="nav-link">
                    <span class="nav-icon"><i class="fas fa-calendar-alt"></i></span>
                    <span>Appointments</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">
                    <span class="nav-icon"><i class="fas fa-user-injured"></i></span>
                    <span>Patients</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">
                    <span class="nav-icon"><i class="fas fa-prescription"></i></span>
                    <span>Prescriptions</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">
                    <span class="nav-icon"><i class="fas fa-chart-line"></i></span>
                    <span>Reports</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">
                    <span class="nav-icon"><i class="fas fa-cog"></i></span>
                    <span>Settings</span>
                </a>
            </li>
        </ul>
    </div>
</div>

<!-- MAIN CONTENT -->
<div class="main-content">
    <!-- HEADER -->
    <div class="header">
        <div class="page-title">
            <h1>Doctor Dashboard</h1>
        </div>
        <div class="user-actions">
            <div class="user-profile">
                <div class="user-avatar">
                     ${doctor.name.charAt(0)}
                </div>
                <div class="user-info">
                    <h4>${doctor.name }</h4>
                    <p>${doctor.specialization}</p>
                </div>
            </div>
            <a href="/doctor/DoctorLogOutProcess" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i>
                Logout
            </a>
        </div>
    </div>

    <!-- CONTENT AREA -->
    <div class="content-area">
        <!-- STATISTICS -->
        <div class="stats-grid">
            <div class="stat-card fade-in">
                <div class="stat-header">
                    <div class="stat-icon" style="background: linear-gradient(135deg, var(--primary), var(--primary-light));">
                        <i class="fas fa-user-injured"></i>
                    </div>
                    <div class="stat-content">
                        <h3>42</h3>
                        <p>Total Patients</p>
                    </div>
                </div>
            </div>
            
            <div class="stat-card fade-in delay-1">
                <div class="stat-header">
                    <div class="stat-icon" style="background: linear-gradient(135deg, var(--success), #34d399);">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="stat-content">
                        <h3>18</h3>
                        <p>Today's Appointments</p>
                    </div>
                </div>
            </div>
            
            <div class="stat-card fade-in delay-2">
                <div class="stat-header">
                    <div class="stat-icon" style="background: linear-gradient(135deg, var(--warning), #fbbf24);">
                        <i class="fas fa-prescription"></i>
                    </div>
                    <div class="stat-content">
                        <h3>36</h3>
                        <p>Prescriptions This Month</p>
                    </div>
                </div>
            </div>
            
            <div class="stat-card fade-in delay-3">
                <div class="stat-header">
                    <div class="stat-icon" style="background: linear-gradient(135deg, var(--info), #22d3ee);">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <div class="stat-content">
                        <h3>92%</h3>
                        <p>Patient Satisfaction</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- PROFILE SECTION -->

 <!-- PROFILE SECTION -->
        <div class="profile-section">
            <!-- PROFILE CARD -->
            <div class="profile-card fade-in">
               
          <div class="profile-avatar">
    <c:choose>
        <c:when test="${doctor.doctorInfo ne null and not empty doctor.doctorInfo.fileName}">
            <img 
                src="/images/Doctor/Profiles/${doctor.doctorInfo.fileName}" 
                alt="Doctor Image"
                class="profile-img"
            />
        </c:when>
        <c:otherwise>
            <i class="fas fa-user-md"></i>
        </c:otherwise>
    </c:choose>
</div>

		
		<div class="doctor-info">
		    <h2>${doctor.name}</h2>
		    <div class="doctor-specialization">
		        ${doctor.specialization}
		    </div>
		</div>
               
                
                <div class="contact-info">
                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <div class="contact-text">
                            <div class="contact-label">Email</div>
                            <div class="contact-value">${doctor.email}</div>
                        </div>
                    </div>
                    
                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="fas fa-phone"></i>
                        </div>
                        <div class="contact-text">
                            <div class="contact-label">Phone</div>
                            <div class="contact-value">${doctor.phone}</div>
                        </div>
                    </div>
                    
                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="fas fa-graduation-cap"></i>
                        </div>
                        <div class="contact-text">
                            <div class="contact-label">Experience</div>
                            <div class="contact-value">${doctor.experience} years</div>
                        </div>
                    </div>
                    
                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="fas fa-venus-mars"></i>
                        </div>
                        <div class="contact-text">
                            <div class="contact-label">Gender</div>
                            <div class="contact-value">${doctor.gender}</div>
                        </div>
                    </div>
                </div>
                
                <div class="status-badge">
                    <i class="fas fa-circle"></i>
                   	${doctor.status}
                </div>
                
                <div class="profile-actions">
                    <a href="/doctor/DoctorEditForm/${doctor.did}" class="btn btn-primary">
                        <i class="fas fa-edit"></i>
                        Edit Profile
                    </a>
                    <a href="/doctor/DoctorDeleteProcess/${doctor.did}" class="btn btn-danger">
                        <i class="fas fa-trash-alt"></i>
                        Delete Profile
                    </a>
                </div>
            </div>



            <!-- PATIENTS TABLE -->
            <div class="data-card fade-in delay-1">
                <div class="card-header">
                    <h3><i class="fas fa-user-injured"></i> Recent Patients</h3>
                    <button class="view-btn">
                        <i class="fas fa-plus"></i>
                        Add Patient
                    </button>
                </div>
                <div class="card-body">
                    <div class="table-container">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Patient Name</th>
                                    <th>Age</th>
                                    <th>Condition</th>
                                    <th>Last Visit</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Rajesh Kumar</td>
                                    <td>45</td>
                                    <td>Hypertension</td>
                                    <td>2023-10-15</td>
                                    <td><span class="status-tag status-active">Stable</span></td>
                                    <td><button class="view-btn"><i class="fas fa-eye"></i> View</button></td>
                                </tr>
                                <tr>
                                    <td>Priya Sharma</td>
                                    <td>32</td>
                                    <td>Diabetes</td>
                                    <td>2023-10-12</td>
                                    <td><span class="status-tag status-active">Improving</span></td>
                                    <td><button class="view-btn"><i class="fas fa-eye"></i> View</button></td>
                                </tr>
                                <tr>
                                    <td>Amit Patel</td>
                                    <td>58</td>
                                    <td>Arthritis</td>
                                    <td>2023-10-10</td>
                                    <td><span class="status-tag status-pending">Follow-up</span></td>
                                    <td><button class="view-btn"><i class="fas fa-eye"></i> View</button></td>
                                </tr>
                                <tr>
                                    <td>Sunita Singh</td>
                                    <td>29</td>
                                    <td>Migraine</td>
                                    <td>2023-10-08</td>
                                    <td><span class="status-tag status-active">Stable</span></td>
                                    <td><button class="view-btn"><i class="fas fa-eye"></i> View</button></td>
                                </tr>
                                <tr>
                                    <td>Vikram Joshi</td>
                                    <td>65</td>
                                    <td>Cardiac Issue</td>
                                    <td>2023-10-05</td>
                                    <td><span class="status-tag status-monitoring">Monitoring</span></td>
                                    <td><button class="view-btn"><i class="fas fa-eye"></i> View</button></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

<script>
    setTimeout(() => {
        const toast = document.getElementById("toast");
        if (toast) toast.remove();
    }, 3500);
</script>

   
</div>
</body>
</html>