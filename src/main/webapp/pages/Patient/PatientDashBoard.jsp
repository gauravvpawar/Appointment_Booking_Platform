<%@page import="com.example.demo.Model.Patient"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %><%@page import="java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
HttpSession hs =  request.getSession();
Patient patient = (Patient) hs.getAttribute("patient");

if(patient == null)
{
    out.println("<script>");
    out.println("alert('You can not access directly to patient dashboard, Login First!')");
    out.println("window.location.href = './PatientLoginForm.jsp'");
    out.println("</script>");
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Patient Dashboard</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
    :root {
        --primary: #2563eb;
        --primary-dark: #1d4ed8;
        --primary-light: #3b82f6;
        --secondary: #0ea5e9;
        --light-bg: #f8fafc;
        --text-dark: #1e293b;
        --text-light: #64748b;
        --success: #10b981;
        --warning: #f59e0b;
        --danger: #ef4444;
        --border: #e2e8f0;
        --card-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        --hover-shadow: 0 20px 40px -10px rgba(0, 0, 0, 0.15);
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
    }

    body {
        background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
        color: var(--text-dark);
        line-height: 1.6;
        min-height: 100vh;
    }

    /* NAVBAR */
    .navbar {
        background: white;
        padding: 1.2rem 2rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        position: sticky;
        top: 0;
        z-index: 1000;
        backdrop-filter: blur(10px);
        background: rgba(255, 255, 255, 0.95);
    }

    .navbar-brand {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .logo {
        width: 40px;
        height: 40px;
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 1.5rem;
    }

    .brand-text h1 {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--primary);
        line-height: 1.2;
    }

    .brand-text p {
        font-size: 0.75rem;
        color: var(--text-light);
        font-weight: 500;
    }

    .navbar-actions {
        display: flex;
        gap: 1rem;
        align-items: center;
    }

    .btn {
        padding: 0.75rem 1.5rem;
        border-radius: 8px;
        border: none;
        font-weight: 600;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        text-decoration: none;
        font-size: 0.9rem;
        position: relative;
        overflow: hidden;
    }

    .btn::after {
        content: '';
        position: absolute;
        top: 50%;
        left: 50%;
        width: 5px;
        height: 5px;
        background: rgba(255, 255, 255, 0.5);
        opacity: 0;
        border-radius: 100%;
        transform: scale(1, 1) translate(-50%);
        transform-origin: 50% 50%;
    }

    .btn:active::after {
        animation: ripple 0.6s ease-out;
    }

    @keyframes ripple {
        0% {
            transform: scale(0, 0);
            opacity: 0.5;
        }
        100% {
            transform: scale(20, 20);
            opacity: 0;
        }
    }

    .btn-primary {
        background: linear-gradient(135deg, var(--primary), var(--primary-light));
        color: white;
        box-shadow: 0 4px 12px rgba(37, 99, 235, 0.25);
    }

    .btn-primary:hover {
        background: linear-gradient(135deg, var(--primary-dark), var(--primary));
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(37, 99, 235, 0.35);
    }

    .btn-danger {
        background: linear-gradient(135deg, var(--danger), #f87171);
        color: white;
        box-shadow: 0 4px 12px rgba(239, 68, 68, 0.25);
    }

    .btn-danger:hover {
        background: linear-gradient(135deg, #dc2626, var(--danger));
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(239, 68, 68, 0.35);
    }

    /* MAIN CONTENT */
    .container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 2rem;
    }

    .dashboard-grid {
        display: grid;
        grid-template-columns: 1fr 2fr;
        gap: 2rem;
        margin-top: 1rem;
    }

    @media (max-width: 1024px) {
        .dashboard-grid {
            grid-template-columns: 1fr;
        }
    }

    /* STATS SECTION - MOVED TO TOP */
    .stats-section {
        grid-column: 1 / -1;
        margin-bottom: 2rem;
    }

    .stats-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 1.5rem;
        margin-top: 1rem;
    }

    @media (max-width: 768px) {
        .stats-grid {
            grid-template-columns: 1fr;
        }
    }

    .stat-card {
        background: white;
        padding: 1.75rem;
        border-radius: 16px;
        box-shadow: var(--card-shadow);
        display: flex;
        align-items: center;
        gap: 1.25rem;
        transition: all 0.3s ease;
        border-top: 4px solid;
    }

    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: var(--hover-shadow);
    }

    .stat-card:nth-child(1) {
        border-top-color: var(--warning);
    }

    .stat-card:nth-child(2) {
        border-top-color: var(--success);
    }

    .stat-card:nth-child(3) {
        border-top-color: var(--danger);
    }

    .stat-icon {
        width: 60px;
        height: 60px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
    }

    .stat-card:nth-child(1) .stat-icon {
        background: linear-gradient(135deg, rgba(245, 158, 11, 0.1), rgba(245, 158, 11, 0.2));
        color: var(--warning);
    }

    .stat-card:nth-child(2) .stat-icon {
        background: linear-gradient(135deg, rgba(16, 185, 129, 0.1), rgba(16, 185, 129, 0.2));
        color: var(--success);
    }

    .stat-card:nth-child(3) .stat-icon {
        background: linear-gradient(135deg, rgba(239, 68, 68, 0.1), rgba(239, 68, 68, 0.2));
        color: var(--danger);
    }

    .stat-content {
        flex: 1;
    }

    .stat-number {
        font-size: 2rem;
        font-weight: 700;
        color: var(--text-dark);
        margin-bottom: 0.25rem;
    }

    .stat-label {
        font-size: 0.9rem;
        color: var(--text-light);
        font-weight: 500;
    }

    /* PROFILE SECTION */
    .profile-section {
        position: sticky;
        top: 100px;
    }

    .profile-header {
        margin-bottom: 1.5rem;
    }

    .welcome-text {
        font-size: 1.1rem;
        color: var(--text-light);
        margin-bottom: 0.5rem;
    }

    .patient-name {
        font-size: 1.8rem;
        font-weight: 700;
        color: var(--text-dark);
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    .profile-card {
        background: white;
        border-radius: 16px;
        padding: 2rem;
        box-shadow: var(--card-shadow);
        transition: all 0.3s ease;
        height: fit-content;
    }

    .profile-card:hover {
        box-shadow: var(--hover-shadow);
    }

    .profile-avatar-container {
        margin-bottom: 1.5rem;
        text-align: center;
    }

    .profile-avatar-link {
        display: inline-block;
        text-decoration: none;
    }

    .profile-avatar {
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 140px;
        margin: 0 auto;
    }

    .profile-avatar-img {
        width: 120px;
        height: 120px;
        border-radius: 50%;
        border: 4px solid white;
        object-fit: cover;
        box-shadow: 0 8px 20px rgba(37, 99, 235, 0.2);
    }

    .avatar-fallback {
        width: 120px;
        height: 120px;
        border-radius: 50%;
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 2.5rem;
        font-weight: 700;
        border: 4px solid white;
        box-shadow: 0 8px 20px rgba(37, 99, 235, 0.2);
    }

    .file-name {
        margin-top: 8px;
        font-size: 0.9rem;
        color: var(--text-light);
        word-break: break-word;
        text-align: center;
    }

    .profile-details {
        display: flex;
        flex-direction: column;
        gap: 1rem;
    }

    .detail-item {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 0.75rem 0;
        border-bottom: 1px solid var(--border);
    }

    .detail-item:last-child {
        border-bottom: none;
    }

    .detail-icon {
        width: 36px;
        height: 36px;
        background: linear-gradient(135deg, #f0f9ff, #e0f2fe);
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--primary);
        font-size: 1rem;
    }

    .detail-content {
        flex: 1;
    }

    .detail-label {
        font-size: 0.85rem;
        color: var(--text-light);
        font-weight: 500;
        margin-bottom: 2px;
    }

    .detail-value {
        font-size: 1rem;
        color: var(--text-dark);
        font-weight: 600;
    }

    .status-badge {
        display: inline-flex;
        align-items: center;
        padding: 0.5rem 1rem;
        background: linear-gradient(135deg, rgba(16, 185, 129, 0.1), rgba(16, 185, 129, 0.2));
        color: var(--success);
        border-radius: 50px;
        font-size: 0.85rem;
        font-weight: 600;
        margin-top: 1.5rem;
        gap: 6px;
    }

    .edit-profile-link {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        color: var(--primary);
        text-decoration: none;
        font-weight: 600;
        font-size: 0.9rem;
        margin-top: 1.5rem;
        padding: 0.75rem 1.5rem;
        background: linear-gradient(135deg, rgba(37, 99, 235, 0.05), rgba(37, 99, 235, 0.1));
        border-radius: 10px;
        transition: all 0.3s ease;
    }

    .edit-profile-link:hover {
        background: linear-gradient(135deg, rgba(37, 99, 235, 0.1), rgba(37, 99, 235, 0.15));
        transform: translateX(5px);
    }

    /* APPOINTMENTS SECTION */
    .appointments-section {
        margin-top: 0;
    }

    .section-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 2rem;
    }

    .section-title {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--text-dark);
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .section-title i {
        color: var(--primary);
    }

    .appointments-list {
        display: flex;
        flex-direction: column;
        gap: 1.5rem;
    }

    .appointment-card {
        background: white;
        border-radius: 16px;
        padding: 1.75rem;
        box-shadow: var(--card-shadow);
        border-left: 4px solid var(--primary);
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }

    .appointment-card:hover {
        transform: translateY(-5px);
        box-shadow: var(--hover-shadow);
    }

    .appointment-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 4px;
        height: 100%;
        background: linear-gradient(to bottom, var(--primary), var(--secondary));
    }

    .card-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        margin-bottom: 1.25rem;
    }

    .card-title {
        font-size: 1.25rem;
        font-weight: 700;
        color: var(--text-dark);
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .appointment-badge {
        padding: 0.4rem 1rem;
        border-radius: 50px;
        font-size: 0.8rem;
        font-weight: 600;
    }

    .badge-pending {
        background: linear-gradient(135deg, rgba(245, 158, 11, 0.1), rgba(245, 158, 11, 0.2));
        color: var(--warning);
    }

    .badge-confirmed {
        background: linear-gradient(135deg, rgba(16, 185, 129, 0.1), rgba(16, 185, 129, 0.2));
        color: var(--success);
    }

    .badge-cancelled {
        background: linear-gradient(135deg, rgba(239, 68, 68, 0.1), rgba(239, 68, 68, 0.2));
        color: var(--danger);
    }

    .appointment-details-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 1.5rem;
        margin-bottom: 1.25rem;
    }

    .detail-box {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .detail-icon-box {
        width: 40px;
        height: 40px;
        background: linear-gradient(135deg, #f0f9ff, #e0f2fe);
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--primary);
        font-size: 1rem;
    }

    .detail-content-box h4 {
        font-size: 0.85rem;
        color: var(--text-light);
        font-weight: 500;
        margin-bottom: 4px;
    }

    .detail-content-box p {
        font-size: 1rem;
        color: var(--text-dark);
        font-weight: 600;
    }

    .specialization-tag {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 0.5rem 1rem;
        background: linear-gradient(135deg, rgba(14, 165, 233, 0.1), rgba(14, 165, 233, 0.2));
        color: var(--secondary);
        border-radius: 50px;
        font-size: 0.85rem;
        font-weight: 600;
        margin-top: 1rem;
    }

    .appointment-actions {
        display: flex;
        gap: 0.75rem;
        margin-top: 1.5rem;
    }

    .action-btn {
        padding: 0.5rem 1rem;
        border-radius: 8px;
        font-size: 0.85rem;
        font-weight: 500;
        text-decoration: none;
        transition: all 0.3s ease;
        border: none;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }

    .action-view {
        background: linear-gradient(135deg, rgba(37, 99, 235, 0.1), rgba(37, 99, 235, 0.2));
        color: var(--primary);
    }

    .action-view:hover {
        background: linear-gradient(135deg, rgba(37, 99, 235, 0.2), rgba(37, 99, 235, 0.3));
        transform: translateY(-2px);
    }

    .action-cancel {
        background: linear-gradient(135deg, rgba(239, 68, 68, 0.1), rgba(239, 68, 68, 0.2));
        color: var(--danger);
    }

    .action-cancel:hover {
        background: linear-gradient(135deg, rgba(239, 68, 68, 0.2), rgba(239, 68, 68, 0.3));
        transform: translateY(-2px);
    }

    .no-appointments {
        text-align: center;
        padding: 4rem 2rem;
        background: white;
        border-radius: 16px;
        box-shadow: var(--card-shadow);
    }

    .no-appointments i {
        font-size: 3rem;
        color: var(--text-light);
        margin-bottom: 1.5rem;
        opacity: 0.5;
    }

    .no-appointments h3 {
        font-size: 1.5rem;
        color: var(--text-light);
        margin-bottom: 1rem;
        font-weight: 600;
    }

    .no-appointments p {
        color: var(--text-light);
        margin-bottom: 2rem;
    }

    /* TOAST */
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

    /* RESPONSIVE DESIGN */
    @media (max-width: 768px) {
        .navbar {
            flex-direction: column;
            gap: 1rem;
            padding: 1rem;
        }
        
        .navbar-actions {
            width: 100%;
            justify-content: center;
        }
        
        .btn {
            flex: 1;
            padding: 0.75rem;
            font-size: 0.85rem;
        }
        
        .container {
            padding: 1rem;
        }
        
        .appointment-details-grid {
            grid-template-columns: 1fr;
        }
        
        .profile-card {
            padding: 1.5rem;
        }
        
        .card-header {
            flex-direction: column;
            gap: 1rem;
        }
        
        .appointment-actions {
            flex-wrap: wrap;
        }
    }

    /* ANIMATIONS */
    @keyframes fadeIn {
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
        animation: fadeIn 0.6s ease-out forwards;
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
</style>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

</head>
<body>


<c:if test="${not empty msg}">
    <div id="toast" class="toast">
        ${msg}
    </div>
    <script>
        setTimeout(function(){
            var toast = document.getElementById('toast');
            toast.style.opacity = '0';
            setTimeout(function(){ toast.remove(); }, 500);
        }, 3000);
    </script>
</c:if>


<!-- NAVBAR -->
<div class="navbar">
    <div class="navbar-brand">
        <div class="logo">
            <i class="fas fa-heartbeat"></i>
        </div>
        <div class="brand-text">
            <h1>MediCare, Patient Portal</h1>
            <p>Your Health, Our Priority</p>
        </div>
    </div>
    
    <div class="navbar-actions">
        <a href="/patient/BookAppointment/${patient.id}" class="btn btn-primary">
            <i class="fas fa-calendar-plus"></i>
            Book Appointment
        </a>
        <a href="/patient/logOut" class="btn btn-danger">
            <i class="fas fa-sign-out-alt"></i>
            Logout
        </a>
    </div>
</div>

<!-- MAIN CONTENT -->
<div class="container">
    <!-- STATS SECTION - MOVED TO TOP -->
    <div class="stats-section fade-in">
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-content">
                    <div class="stat-number">
                        <c:set var="pendingCount" value="0" />
                        <c:forEach var="appt" items="${patientAppointments}">
                            <c:if test="${appt.appointment_status == 'Pending'}">
                                <c:set var="pendingCount" value="${pendingCount + 1}" />
                            </c:if>
                        </c:forEach>
                        ${pendingCount}
                    </div>
                    <div class="stat-label">Pending Appointments</div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-content">
                    <div class="stat-number">
                        <c:set var="confirmedCount" value="0" />
                        <c:forEach var="appt" items="${patientAppointments}">
                            <c:if test="${appt.appointment_status == 'Confirmed'}">
                                <c:set var="confirmedCount" value="${confirmedCount + 1}" />
                            </c:if>
                        </c:forEach>
                        ${confirmedCount}
                    </div>
                    <div class="stat-label">Confirmed Appointments</div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-times-circle"></i>
                </div>
                <div class="stat-content">
                    <div class="stat-number">
                        <c:set var="cancelledCount" value="0" />
                        <c:forEach var="appt" items="${patientAppointments}">
                            <c:if test="${appt.appointment_status == 'Cancelled'}">
                                <c:set var="cancelledCount" value="${cancelledCount + 1}" />
                            </c:if>
                        </c:forEach>
                        ${cancelledCount}
                    </div>
                    <div class="stat-label">Cancelled Appointments</div>
                </div>
            </div>
        </div>
    </div>

    <div class="dashboard-grid">
        <!-- LEFT COLUMN - PROFILE -->
        <div class="profile-section">
            <div class="profile-card fade-in delay-1">
                <div class="profile-avatar-container">
                    <a href="/patient/PatientEditForm/${patient.id}" class="profile-avatar-link">
                        <div class="profile-avatar">
                            <c:choose>
                                <c:when test="${not empty patient.patientinfo.fileName}">
                                    <img src="/images/${patient.patientinfo.fileName}" 
                                         alt="Profile Picture" 
                                         class="profile-avatar-img"
                                         onerror="this.style.display='none'; this.parentElement.innerHTML='<div class=&quot;avatar-fallback&quot;>${patient.name.substring(0,1)}</div>'">
                                </c:when>
                                <c:otherwise>
                                    <div class="avatar-fallback">
                                        ${patient.name.substring(0,1)}
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </a>
                </div>
                
                <div class="profile-details">
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Full Name</div>
                            <div class="detail-value">${patient.name}</div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Email Address</div>
                            <div class="detail-value">${patient.email}</div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-phone"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Phone Number</div>
                            <div class="detail-value">${patient.phone}</div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-venus-mars"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Gender</div>
                            <div class="detail-value">${patient.gender}</div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-birthday-cake"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Age</div>
                            <div class="detail-value">${patient.age} years</div>
                        </div>
                    </div>
                </div>
                
                <div class="status-badge">
                    <i class="fas fa-check-circle"></i>
                    ${patient.status}
                </div>
                
                <a href="/patient/PatientEditForm/${patient.id}" class="edit-profile-link">
                    <i class="fas fa-edit"></i>
                    Edit Profile Information
                </a>
            </div>
        </div>

        <!-- RIGHT COLUMN - APPOINTMENTS -->
        <div class="appointments-section">
            <div class="section-header fade-in">
                <h2 class="section-title">
                    <i class="fas fa-calendar-check"></i>
                    My Appointments
                </h2>
            </div>

            <!-- Appointments List -->
            <div class="appointments-list">
                <c:choose>
                    <c:when test="${not empty patientAppointments}">
                        <c:forEach var="appt" items="${patientAppointments}">
                            <div class="appointment-card fade-in delay-2">
                                <div class="card-header">
                                    <h3 class="card-title">
                                        <i class="fas fa-user-md"></i>
                                        Appointment with Dr. ${appt.doctor.name}
                                    </h3>
                                    <span class="appointment-badge 
                                        <c:choose>
                                            <c:when test="${appt.appointment_status == 'Pending'}">badge-pending</c:when>
                                            <c:when test="${appt.appointment_status == 'Confirmed'}">badge-confirmed</c:when>
                                            <c:when test="${appt.appointment_status == 'Cancelled'}">badge-cancelled</c:when>
                                        </c:choose>">
                                        ${appt.appointment_status}
                                    </span>
                                </div>
                                
                                <div class="appointment-details-grid">
                                    <div class="detail-box">
                                        <div class="detail-icon-box">
                                            <i class="fas fa-calendar"></i>
                                        </div>
                                        <div class="detail-content-box">
                                            <h4>Appointment Date</h4>
                                            <p>${appt.appointment_date}</p>
                                        </div>
                                    </div>
                                    
                                    <div class="detail-box">
                                        <div class="detail-icon-box">
                                            <i class="fas fa-clock"></i>
                                        </div>
                                        <div class="detail-content-box">
                                            <h4>Appointment Time</h4>
                                            <p>${appt.appointment_time}</p>
                                        </div>
                                    </div>
                                    
                                    <div class="detail-box">
                                        <div class="detail-icon-box">
                                            <i class="fas fa-user-md"></i>
                                        </div>
                                        <div class="detail-content-box">
                                            <h4>Doctor</h4>
                                            <p>Dr. ${appt.doctor.name}</p>
                                        </div>
                                    </div>
                                    
                                    <div class="detail-box">
                                        <div class="detail-icon-box">
                                            <i class="fas fa-stethoscope"></i>
                                        </div>
                                        <div class="detail-content-box">
                                            <h4>Appointment ID</h4>
                                            <p>#${appt.appt_id}</p>
                                        </div>
                                    </div>
                                    
                                    <div class="detail-box">
                                        <div class="detail-icon-box">
                                            <i class="fas fa-comment-medical"></i>
                                        </div>
                                        <div class="detail-content-box">
                                            <h4>Reason</h4>
                                            <p>${appt.reason}</p>
                                        </div>
                                    </div>
                                    
                                    <div class="detail-box">
                                        <div class="detail-icon-box">
                                            <i class="fas fa-tag"></i>
                                        </div>
                                        <div class="detail-content-box">
                                            <h4>Department</h4>
                                            <p>${appt.doctor.specialization}</p>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="specialization-tag">
                                    <i class="fas fa-tag"></i>
                                    ${appt.doctor.specialization}
                                </div>
                                
                                <div class="appointment-actions">
                                    <a href="/patient/ViewAppointment/${patient.id}/${appt.appt_id}" 
                                       class="action-btn action-view">
                                        <i class="fas fa-eye"></i> View Details
                                    </a>
                                    
                                    <c:if test="${appt.appointment_status == 'Pending'}">
                                        <a href="/patient/CancelAppointment/${patient.id}/${appt.appt_id}" 
                                           onclick="return confirm('Are you sure you want to cancel this appointment?')"
                                           class="action-btn action-cancel">
                                            <i class="fas fa-times"></i> Cancel
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    
                    <c:otherwise>
                        <div class="no-appointments fade-in delay-2">
                            <i class="fas fa-calendar-times"></i>
                            <h3>No Upcoming Appointments</h3>
                            <p>You don't have any scheduled appointments at the moment.</p>
                            <a href="/patient/BookAppointment/${patient.id}" class="btn btn-primary">
                                <i class="fas fa-calendar-plus"></i>
                                Schedule Your First Appointment
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
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

</body>
</html>