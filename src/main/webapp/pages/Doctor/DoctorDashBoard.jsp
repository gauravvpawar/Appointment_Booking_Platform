<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

    .status-confirmed {
        background: linear-gradient(135deg, rgba(37, 99, 235, 0.15), rgba(37, 99, 235, 0.2));
        color: var(--primary);
    }

    .status-cancelled {
        background: linear-gradient(135deg, rgba(239, 68, 68, 0.15), rgba(239, 68, 68, 0.2));
        color: var(--danger);
    }

    .status-rejected {
        background: linear-gradient(135deg, rgba(120, 120, 120, 0.15), rgba(120, 120, 120, 0.2));
        color: #64748b;
    }

    .action-btn {
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
        text-decoration: none;
    }

    .action-btn:hover {
        background: linear-gradient(135deg, var(--primary-dark), var(--primary));
        transform: translateY(-1px);
    }

    .action-btn-danger {
        background: linear-gradient(135deg, var(--danger), #f87171);
    }

    .action-btn-danger:hover {
        background: linear-gradient(135deg, #dc2626, var(--danger));
    }

    .action-btn-success {
        background: linear-gradient(135deg, var(--success), #34d399);
    }

    .action-btn-success:hover {
        background: linear-gradient(135deg, #059669, var(--success));
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
    
    /* Appointment Actions */
    .appointment-actions {
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
    }
    
    .file-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background-size: cover;
        background-position: center;
        border: 2px solid var(--border);
    }
    
    /* Alert Messages */
    .alert {
        padding: 12px 20px;
        border-radius: 8px;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 12px;
    }
    
    .alert-success {
        background: linear-gradient(135deg, rgba(16, 185, 129, 0.1), rgba(16, 185, 129, 0.15));
        color: var(--success);
        border: 1px solid rgba(16, 185, 129, 0.2);
    }
    
    .alert-error {
        background: linear-gradient(135deg, rgba(239, 68, 68, 0.1), rgba(239, 68, 68, 0.15));
        color: var(--danger);
        border: 1px solid rgba(239, 68, 68, 0.2);
    }
    
    .alert i {
        font-size: 1.2rem;
    }
</style>
</head>
<body>

<c:if test="${not empty doctor}">
    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="sidebar-header">
            <div class="brand">
                <div class="brand-logo">
                    <i class="fas fa-stethoscope"></i>
                </div>
                <div class="brand-text">
                    <h2>MediCare</h2>
                    <p>Doctor Portal</p>
                </div>
            </div>
        </div>
        
        <div class="sidebar-menu">
            <ul class="nav-list">
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/doctor/dashboard/${doctor.did}" class="nav-link active">
                        <span class="nav-icon"><i class="fas fa-home"></i></span>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#upcoming-appointments" class="nav-link">
                        <span class="nav-icon"><i class="fas fa-calendar-alt"></i></span>
                        <span>Appointments</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="/doctor/ViewAppointments/${doctor.did}" class="nav-link">
                        <span class="nav-icon"><i class="fas fa-user-injured"></i></span>
                        <span>All Appointments</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="/doctor/DoctorEditForm/${doctor.did}" class="nav-link">
                        <span class="nav-icon"><i class="fas fa-user-edit"></i></span>
                        <span>Edit Profile</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="/doctor/DoctorReport/${doctor.did}" class="nav-link">
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
                    <c:choose>
                        <c:when test="${not empty doctor.doctorInfo.fileName}">
                            <div class="user-avatar" style="background-image: url('${pageContext.request.contextPath}/images/Doctor/Profiles/${doctor.doctorInfo.fileName}'); background-size: cover; background-position: center;">
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="user-avatar">
                                ${doctor.name.charAt(0)}
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <div class="user-info">
                        <h4>Dr. ${doctor.name}</h4>
                        <p>${doctor.specialization}</p>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/doctor/DoctorLogOutProcess" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i>
                    Logout
                </a>
            </div>
        </div>

        <!-- CONTENT AREA -->
        <div class="content-area">
            <!-- Display Messages -->
            <c:if test="${not empty msg}">
                <div class="alert alert-success fade-in">
                    <i class="fas fa-check-circle"></i>
                    ${msg}
                </div>
            </c:if>
            
            <c:if test="${not empty errorMsg}">
                <div class="alert alert-error fade-in">
                    <i class="fas fa-exclamation-circle"></i>
                    ${errorMsg}
                </div>
            </c:if>

            <!-- STATISTICS -->
            <div class="stats-grid">
                <div class="stat-card fade-in">
                    <div class="stat-header">
                        <div class="stat-icon" style="background: linear-gradient(135deg, var(--primary), var(--primary-light));">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="stat-content">
                            <h3>
                                <c:choose>
                                    <c:when test="${not empty totalAppointments}">${totalAppointments}</c:when>
                                    <c:otherwise>0</c:otherwise>
                                </c:choose>
                            </h3>
                            <p>Total Appointments</p>
                        </div>
                    </div>
                </div>
                
                <div class="stat-card fade-in delay-1">
                    <div class="stat-header">
                        <div class="stat-icon" style="background: linear-gradient(135deg, var(--success), #34d399);">
                            <i class="fas fa-user-check"></i>
                        </div>
                        <div class="stat-content">
                            <h3>
                                <c:choose>
                                    <c:when test="${not empty confirmedAppointments}">${confirmedAppointments}</c:when>
                                    <c:otherwise>0</c:otherwise>
                                </c:choose>
                            </h3>
                            <p>Confirmed Today</p>
                        </div>
                    </div>
                </div>
                
                <div class="stat-card fade-in delay-2">
                    <div class="stat-header">
                        <div class="stat-icon" style="background: linear-gradient(135deg, var(--warning), #fbbf24);">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="stat-content">
                            <h3>
                                <c:choose>
                                    <c:when test="${not empty pendingAppointments}">${pendingAppointments}</c:when>
                                    <c:otherwise>0</c:otherwise>
                                </c:choose>
                            </h3>
                            <p>Pending Approval</p>
                        </div>
                    </div>
                </div>
                
                <div class="stat-card fade-in delay-3">
                    <div class="stat-header">
                        <div class="stat-icon" style="background: linear-gradient(135deg, var(--info), #22d3ee);">
                            <i class="fas fa-user-injured"></i>
                        </div>
                        <div class="stat-content">
                            <h3>
                                <c:choose>
                                    <c:when test="${not empty uniquePatients}">${uniquePatients}</c:when>
                                    <c:otherwise>0</c:otherwise>
                                </c:choose>
                            </h3>
                            <p>Unique Patients</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- PROFILE SECTION -->
            <div class="profile-section">
                <!-- PROFILE CARD -->
                <div class="profile-card fade-in">
                    <div class="profile-avatar">
                        <c:choose>
                            <c:when test="${not empty doctor.doctorInfo.fileName}">
                                <img src="${pageContext.request.contextPath}/images/Doctor/Profiles/${doctor.doctorInfo.fileName}" 
                                     alt="Doctor Profile" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;">
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-user-md"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="doctor-info">
                        <h2>Dr. ${doctor.name}</h2>
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
                                <div class="contact-label">Qualification</div>
                                <div class="contact-value">${doctor.qualification}</div>
                            </div>
                        </div>
                        
                        <div class="contact-item">
                            <div class="contact-icon">
                                <i class="fas fa-briefcase"></i>
                            </div>
                            <div class="contact-text">
                                <div class="contact-label">Experience</div>
                                <div class="contact-value">${doctor.experience} years</div>
                            </div>
                        </div>
                        
                        <c:if test="${not empty doctor.doctorInfo.dob}">
                            <div class="contact-item">
                                <div class="contact-icon">
                                    <i class="fas fa-birthday-cake"></i>
                                </div>
                                <div class="contact-text">
                                    <div class="contact-label">Date of Birth</div>
                                    <div class="contact-value">${doctor.doctorInfo.dob}</div>
                                </div>
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty doctor.doctorInfo.address}">
                            <div class="contact-item">
                                <div class="contact-icon">
                                    <i class="fas fa-map-marker-alt"></i>
                                </div>
                                <div class="contact-text">
                                    <div class="contact-label">Address</div>
                                    <div class="contact-value">${doctor.doctorInfo.address}</div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                    
                    <div class="status-badge">
                        <i class="fas fa-circle"></i>
                        ${doctor.status}
                    </div>
                    
                    <div class="profile-actions">
                        <a href="${pageContext.request.contextPath}/doctor/DoctorEditForm/${doctor.did}" class="btn btn-primary">
                            <i class="fas fa-edit"></i>
                            Edit Profile
                        </a>
                        <a href="${pageContext.request.contextPath}/doctor/DoctorLogOutProcess" class="btn btn-danger">
                            <i class="fas fa-sign-out-alt"></i>
                            Logout
                        </a>
                    </div>
                </div>

                <!-- RECENT PATIENTS TABLE -->
                <div class="data-card fade-in delay-1">
                    <div class="card-header">
                        <h3><i class="fas fa-user-injured"></i> Recent Patients</h3>
                        <a href="${pageContext.request.contextPath}/doctor/ViewAppointments/${doctor.did}" class="action-btn">
                            <i class="fas fa-eye"></i>
                            View All
                        </a>
                    </div>
                    <div class="card-body">
                        <div class="table-container">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>Patient Name</th>
                                        <th>Last Appointment</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty recentPatients}">
                                            <c:forEach var="appointment" items="${recentPatients}">
                                                <tr>
                                                    <td>
                                                        <div style="display: flex; align-items: center; gap: 12px;">
                                                            <c:choose>
                                                                <c:when test="${not empty appointment.patient.patientinfo.fileName}">
                                                                    <div class="file-avatar" 
                                                                         style="background-image: url('${pageContext.request.contextPath}/images/${appointment.patient.patientinfo.fileName}')">
                                                                    </div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="user-avatar" style="width: 32px; height: 32px; font-size: 0.8rem;">
                                                                        ${appointment.patient.name.charAt(0)}
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <div>
                                                                <strong>${appointment.patient.name}</strong><br>
                                                                <small style="color: var(--text-light); font-size: 0.8rem;">${appointment.patient.phone}</small>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        ${appointment.appointment_date}<br>
                                                        <small style="color: var(--text-light);">${appointment.appointment_time}</small>
                                                    </td>
                                                    <td>
                                                        <span class="status-tag 
                                                            <c:choose>
                                                                <c:when test="${appointment.appointment_status == 'Confirmed'}">status-confirmed</c:when>
                                                                <c:when test="${appointment.appointment_status == 'Pending'}">status-pending</c:when>
                                                                <c:when test="${appointment.appointment_status == 'Cancelled'}">status-cancelled</c:when>
                                                                <c:when test="${appointment.appointment_status == 'Rejected'}">status-rejected</c:when>
                                                                <c:otherwise>status-pending</c:otherwise>
                                                            </c:choose>">
                                                            <i class="fas fa-circle"></i> ${appointment.appointment_status}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <div class="appointment-actions">
                                                            <a href="${pageContext.request.contextPath}/doctor/ViewAppointmentDetails/${doctor.did}/${appointment.appt_id}" 
                                                               class="action-btn" style="padding: 4px 12px;">
                                                                <i class="fas fa-eye"></i> View
                                                            </a>
                                                            <c:if test="${appointment.appointment_status == 'Pending'}">
                                                                <form action="/doctor/UpdateAppointmentStatus/${doctor.did}" 
                                                                      method="post" style="display: inline;">
                                                                    <input type="hidden" name="appointmentId" value="${appointment.appt_id}">
                                                                    <button type="submit" name="status" value="Confirmed" 
                                                                            class="action-btn action-btn-success" style="padding: 4px 12px;">
                                                                        <i class="fas fa-check"></i> Accept
                                                                    </button>
                                                                </form>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="4" style="text-align: center; padding: 40px; color: var(--text-light);">
                                                    <i class="fas fa-user-injured" style="font-size: 2rem; margin-bottom: 10px; opacity: 0.5;"></i>
                                                    <p>No recent patients</p>
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- APPOINTMENTS SECTION -->
            <div class="data-card fade-in delay-2" id="upcoming-appointments">
                <div class="card-header">
                    <h3><i class="fas fa-calendar-alt"></i> Today's Appointments</h3>
                    <a href="/doctor/ViewAppointments/${doctor.did}" class="action-btn">
                        <i class="fas fa-calendar"></i>
                        View All Appointments
                    </a>
                </div>
                
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty todayAppointments}">
                            <div class="table-container">
                                <table class="data-table">
                                    <thead>
                                        <tr>
                                            <th>Patient Name</th>
                                            <th>Time</th>
                                            <th>Reason</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="appointment" items="${todayAppointments}">
                                            <tr>
                                                <td>
                                                    <div style="display: flex; align-items: center; gap: 12px;">
                                                        <div class="user-avatar" style="width: 32px; height: 32px; font-size: 0.8rem;">
                                                            ${appointment.patient.name.charAt(0)}
                                                        </div>
                                                        <div>
                                                            <strong>${appointment.patient.name}</strong><br>
                                                            <small style="color: var(--text-light); font-size: 0.8rem;">
                                                                Age: ${appointment.patient.age} | ${appointment.patient.gender}
                                                            </small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <strong>${appointment.appointment_time}</strong><br>
                                                    <small style="color: var(--text-light);">Today</small>
                                                </td>
                                                <td>${appointment.reason}</td>
                                                <td>
                                                    <span class="status-tag 
                                                        <c:choose>
                                                            <c:when test="${appointment.appointment_status == 'Confirmed'}">status-confirmed</c:when>
                                                            <c:when test="${appointment.appointment_status == 'Pending'}">status-pending</c:when>
                                                            <c:when test="${appointment.appointment_status == 'Cancelled'}">status-cancelled</c:when>
                                                            <c:when test="${appointment.appointment_status == 'Rejected'}">status-rejected</c:when>
                                                            <c:otherwise>status-pending</c:otherwise>
                                                        </c:choose>">
                                                        <i class="fas fa-circle"></i> ${appointment.appointment_status}
                                                    </span>
                                                </td>
                                                <td>
                                                    <div class="appointment-actions">
                                                        <a href="${pageContext.request.contextPath}/doctor/ViewAppointmentDetails/${doctor.did}/${appointment.appt_id}" 
                                                           class="action-btn" style="padding: 4px 12px;">
                                                            <i class="fas fa-eye"></i> View
                                                        </a>
                                                        <c:if test="${appointment.appointment_status == 'Pending'}">
                                                            <form action="${pageContext.request.contextPath}/doctor/UpdateAppointmentStatus/${doctor.did}" 
                                                                  method="post" style="display: inline;">
                                                                <input type="hidden" name="appointmentId" value="${appointment.appt_id}">
                                                                <div style="display: flex; gap: 4px;">
                                                                    <button type="submit" name="status" value="Confirmed" 
                                                                            class="action-btn action-btn-success" style="padding: 4px 8px;">
                                                                        <i class="fas fa-check"></i>
                                                                    </button>
                                                                    <button type="submit" name="status" value="Rejected" 
                                                                            class="action-btn action-btn-danger" style="padding: 4px 8px;">
                                                                        <i class="fas fa-times"></i>
                                                                    </button>
                                                                </div>
                                                            </form>
                                                        </c:if>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-calendar-times"></i>
                                <h4>No Appointments Today</h4>
                                <p>You don't have any scheduled appointments for today.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</c:if>

<c:if test="${empty doctor}">
    <div style="width: 100%; display: flex; justify-content: center; align-items: center; min-height: 100vh; background: var(--light-bg);">
        <div style="text-align: center; padding: 40px; background: white; border-radius: 16px; box-shadow: var(--shadow); max-width: 400px;">
            <div style="font-size: 3rem; color: var(--danger); margin-bottom: 20px;">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            <h2 style="color: var(--text-dark); margin-bottom: 10px;">Access Denied</h2>
            <p style="color: var(--text-light); margin-bottom: 25px;">Please log in to access the dashboard</p>
            <a href="${pageContext.request.contextPath}/" style="display: inline-block; padding: 12px 30px; 
               background: linear-gradient(135deg, var(--primary), var(--primary-light)); color: white; 
               text-decoration: none; border-radius: 8px; font-weight: 600;">
                <i class="fas fa-sign-in-alt"></i> Go to Login
            </a>
        </div>
    </div>
</c:if>

<script>
    // Highlight current nav link
    document.addEventListener('DOMContentLoaded', function() {
        const currentUrl = window.location.href;
        const navLinks = document.querySelectorAll('.nav-link');
        
        navLinks.forEach(link => {
            if (link.href === currentUrl) {
                link.classList.add('active');
            } else {
                link.classList.remove('active');
            }
        });
        
        // Add smooth scroll for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const targetId = this.getAttribute('href');
                if(targetId !== '#') {
                    const targetElement = document.querySelector(targetId);
                    if(targetElement) {
                        targetElement.scrollIntoView({
                            behavior: 'smooth',
                            block: 'start'
                        });
                    }
                }
            });
        });
        
        // Auto-dismiss alerts after 5 seconds
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                alert.style.transition = 'opacity 0.5s ease';
                alert.style.opacity = '0';
                setTimeout(() => {
                    alert.style.display = 'none';
                }, 500);
            });
        }, 5000);
    });
    
    // Handle appointment status updates
    function updateAppointmentStatus(appointmentId, status) {
        if(confirm('Are you sure you want to ' + status.toLowerCase() + ' this appointment?')) {
            fetch('${pageContext.request.contextPath}/doctor/UpdateAppointmentStatus/${doctor.did}', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `appointmentId=${appointmentId}&status=${status}`
            })
            .then(response => {
                if(response.ok) {
                    location.reload();
                } else {
                    alert('Error updating appointment status');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error updating appointment status');
            });
        }
    }
</script>
</body>
</html>