<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Appointment Details</title>
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
        --card-bg: #ffffff;
        --text-dark: #1e293b;
        --text-light: #64748b;
        --border: #e2e8f0;
        --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
        --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
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
        padding: 20px;
    }

    .container {
        max-width: 1000px;
        margin: 0 auto;
    }

    /* HEADER */
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        padding-bottom: 20px;
        border-bottom: 1px solid var(--border);
    }

    .page-title h1 {
        font-size: 1.8rem;
        font-weight: 700;
        color: var(--text-dark);
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .back-btn {
        padding: 10px 20px;
        background: linear-gradient(135deg, var(--primary), var(--primary-light));
        color: white;
        text-decoration: none;
        border-radius: 8px;
        font-weight: 600;
        font-size: 0.9rem;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s ease;
    }

    .back-btn:hover {
        background: linear-gradient(135deg, var(--primary-dark), var(--primary));
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(37, 99, 235, 0.3);
    }

    /* CARD */
    .card {
        background: white;
        border-radius: 16px;
        box-shadow: var(--shadow);
        overflow: hidden;
        margin-bottom: 20px;
    }

    .card-header {
        padding: 20px 30px;
        border-bottom: 1px solid var(--border);
        background: linear-gradient(135deg, #f0f9ff, #e0f2fe);
    }

    .card-header h2 {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--text-dark);
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .card-body {
        padding: 30px;
    }

    /* INFO SECTIONS */
    .info-section {
        margin-bottom: 30px;
    }

    .info-section h3 {
        font-size: 1.2rem;
        font-weight: 600;
        color: var(--text-dark);
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 2px solid var(--border);
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 20px;
    }

    .info-item {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .info-label {
        font-size: 0.85rem;
        font-weight: 600;
        color: var(--text-light);
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .info-value {
        font-size: 1rem;
        font-weight: 500;
        color: var(--text-dark);
        padding: 10px;
        background: var(--light-bg);
        border-radius: 8px;
        border: 1px solid var(--border);
    }

    /* STATUS BADGE */
    .status-badge {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 0.9rem;
        font-weight: 600;
        margin: 10px 0;
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

    /* ACTION BUTTONS */
    .action-buttons {
        display: flex;
        gap: 15px;
        margin-top: 30px;
        padding-top: 20px;
        border-top: 1px solid var(--border);
    }

    .action-btn {
        padding: 12px 24px;
        border: none;
        border-radius: 8px;
        font-size: 0.9rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        text-decoration: none;
    }

    .btn-accept {
        background: linear-gradient(135deg, var(--success), #34d399);
        color: white;
    }

    .btn-accept:hover {
        background: linear-gradient(135deg, #059669, var(--success));
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(16, 185, 129, 0.3);
    }

    .btn-reject {
        background: linear-gradient(135deg, var(--danger), #f87171);
        color: white;
    }

    .btn-reject:hover {
        background: linear-gradient(135deg, #dc2626, var(--danger));
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(239, 68, 68, 0.3);
    }

    .btn-cancel {
        background: linear-gradient(135deg, var(--warning), #fbbf24);
        color: white;
    }

    .btn-cancel:hover {
        background: linear-gradient(135deg, #d97706, var(--warning));
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(245, 158, 11, 0.3);
    }

    /* ALERT */
    .alert {
        padding: 15px 20px;
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

    /* PATIENT INFO */
    .patient-avatar {
        width: 80px;
        height: 80px;
        border-radius: 50%;
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: 600;
        font-size: 1.5rem;
        margin-bottom: 15px;
        border: 4px solid white;
        box-shadow: 0 4px 12px rgba(37, 99, 235, 0.2);
    }

    /* RESPONSIVE */
    @media (max-width: 768px) {
        body {
            padding: 15px;
        }
        
        .header {
            flex-direction: column;
            gap: 15px;
            text-align: center;
        }
        
        .info-grid {
            grid-template-columns: 1fr;
        }
        
        .action-buttons {
            flex-direction: column;
        }
        
        .action-btn {
            justify-content: center;
        }
    }

    /* UTILITY */
    .text-center {
        text-align: center;
    }
    
    .mt-20 {
        margin-top: 20px;
    }
    
    .mb-20 {
        margin-bottom: 20px;
    }
</style>
</head>
<body>

<c:if test="${not empty appointment && not empty doctor && not empty patient}">
    <div class="container">
        <!-- HEADER -->
        <div class="header">
            <div class="page-title">
                <h1><i class="fas fa-calendar-check"></i> Appointment Details</h1>
            </div>
            <a href="${pageContext.request.contextPath}/doctor/ViewAppointments/${doctor.did}" class="back-btn">
                <i class="fas fa-arrow-left"></i>
                Back to Appointments
            </a>
        </div>

        <!-- ALERTS -->
        <c:if test="${not empty msg}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                ${msg}
            </div>
        </c:if>
        
        <c:if test="${not empty errorMsg}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                ${errorMsg}
            </div>
        </c:if>

        <!-- APPOINTMENT CARD -->
        <div class="card">
            <div class="card-header">
                <h2><i class="fas fa-calendar-alt"></i> Appointment Information</h2>
                <span class="status-badge 
                    <c:choose>
                        <c:when test="${appointment.appointment_status == 'Pending'}">status-pending</c:when>
                        <c:when test="${appointment.appointment_status == 'Confirmed'}">status-confirmed</c:when>
                        <c:when test="${appointment.appointment_status == 'Cancelled'}">status-cancelled</c:when>
                        <c:when test="${appointment.appointment_status == 'Rejected'}">status-rejected</c:when>
                        <c:otherwise>status-pending</c:otherwise>
                    </c:choose>">
                    <i class="fas fa-circle"></i> ${appointment.appointment_status}
                </span>
            </div>
            
            <div class="card-body">
                <!-- APPOINTMENT DETAILS -->
                <div class="info-section">
                    <h3><i class="fas fa-info-circle"></i> Appointment Details</h3>
                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">Appointment ID</span>
                            <span class="info-value">#${appointment.appt_id}</span>
                        </div>
                        
                        <div class="info-item">
                            <span class="info-label">Appointment Date</span>
                            <span class="info-value">
                                <i class="fas fa-calendar"></i> ${appointment.appointment_date}
                            </span>
                        </div>
                        
                        <div class="info-item">
                            <span class="info-label">Appointment Time</span>
                            <span class="info-value">
                                <i class="fas fa-clock"></i> ${appointment.appointment_time}
                            </span>
                        </div>
                        
                        <div class="info-item">
                            <span class="info-label">Reason for Visit</span>
                            <span class="info-value" style="min-height: 80px;">${appointment.reason}</span>
                        </div>
                        
                        <c:if test="${not empty appointment.createdAt}">
                            <div class="info-item">
                                <span class="info-label">Created On</span>
                                <span class="info-value">
                                    <fmt:formatDate value="${appointment.createdAt}" pattern="dd MMM yyyy, hh:mm a" />
                                </span>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- PATIENT INFORMATION -->
                <div class="info-section">
                    <h3><i class="fas fa-user-injured"></i> Patient Information</h3>
                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">Patient Name</span>
                            <span class="info-value">${patient.name}</span>
                        </div>
                        
                        <div class="info-item">
                            <span class="info-label">Age</span>
                            <span class="info-value">${patient.age} years</span>
                        </div>
                        
                        <div class="info-item">
                            <span class="info-label">Gender</span>
                            <span class="info-value">${patient.gender}</span>
                        </div>
                        
                        <div class="info-item">
                            <span class="info-label">Email</span>
                            <span class="info-value">${patient.email}</span>
                        </div>
                        
                        <div class="info-item">
                            <span class="info-label">Phone</span>
                            <span class="info-value">${patient.phone}</span>
                        </div>
                        
                        <div class="info-item">
                            <span class="info-label">Patient Status</span>
                            <span class="info-value">${patient.status}</span>
                        </div>
                    </div>
                    
                    <!-- PATIENT ADDITIONAL INFO -->
                    <c:if test="${not empty patient.patientinfo}">
                        <div class="info-grid mt-20">
                            <c:if test="${not empty patient.patientinfo.dob}">
                                <div class="info-item">
                                    <span class="info-label">Date of Birth</span>
                                    <span class="info-value">${patient.patientinfo.dob}</span>
                                </div>
                            </c:if>
                            
                            <c:if test="${not empty patient.patientinfo.address}">
                                <div class="info-item">
                                    <span class="info-label">Address</span>
                                    <span class="info-value">${patient.patientinfo.address}</span>
                                </div>
                            </c:if>
                            
                            <c:if test="${not empty patient.patientinfo.bloodGroup}">
                                <div class="info-item">
                                    <span class="info-label">Blood Group</span>
                                    <span class="info-value">${patient.patientinfo.bloodGroup}</span>
                                </div>
                            </c:if>
                            
                            <c:if test="${not empty patient.patientinfo.emergencyContact}">
                                <div class="info-item">
                                    <span class="info-label">Emergency Contact</span>
                                    <span class="info-value">${patient.patientinfo.emergencyContact}</span>
                                </div>
                            </c:if>
                        </div>
                    </c:if>
                </div>

                <!-- DOCTOR INFORMATION -->
                <div class="info-section">
                    <h3><i class="fas fa-user-md"></i> Doctor Information</h3>
                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">Doctor Name</span>
                            <span class="info-value">Dr. ${doctor.name}</span>
                        </div>
                        
                        <div class="info-item">
                            <span class="info-label">Specialization</span>
                            <span class="info-value">${doctor.specialization}</span>
                        </div>
                        
                        <div class="info-item">
                            <span class="info-label">Email</span>
                            <span class="info-value">${doctor.email}</span>
                        </div>
                        
                        <div class="info-item">
                            <span class="info-label">Phone</span>
                            <span class="info-value">${doctor.phone}</span>
                        </div>
                        
                        <div class="info-item">
                            <span class="info-label">Qualification</span>
                            <span class="info-value">${doctor.qualification}</span>
                        </div>
                        
                        <div class="info-item">
                            <span class="info-label">Experience</span>
                            <span class="info-value">${doctor.experience} years</span>
                        </div>
                    </div>
                </div>

                <!-- ACTION BUTTONS -->
                <c:if test="${appointment.appointment_status == 'Pending'}">
                    <div class="action-buttons">
                        <form action="${pageContext.request.contextPath}/doctor/UpdateAppointmentStatus/${doctor.did}" 
                              method="post" onsubmit="return confirm('Are you sure you want to accept this appointment?')">
                            <input type="hidden" name="appointmentId" value="${appointment.appt_id}">
                            <button type="submit" name="status" value="Confirmed" class="action-btn btn-accept">
                                <i class="fas fa-check"></i> Accept Appointment
                            </button>
                        </form>
                        
                        <form action="${pageContext.request.contextPath}/doctor/UpdateAppointmentStatus/${doctor.did}" 
                              method="post" onsubmit="return confirm('Are you sure you want to reject this appointment?')">
                            <input type="hidden" name="appointmentId" value="${appointment.appt_id}">
                            <button type="submit" name="status" value="Rejected" class="action-btn btn-reject">
                                <i class="fas fa-times"></i> Reject Appointment
                            </button>
                        </form>
                    </div>
                </c:if>
                
                <c:if test="${appointment.appointment_status == 'Confirmed'}">
                    <div class="action-buttons">
                        <form action="${pageContext.request.contextPath}/doctor/UpdateAppointmentStatus/${doctor.did}" 
                              method="post" onsubmit="return confirm('Are you sure you want to cancel this appointment?')">
                            <input type="hidden" name="appointmentId" value="${appointment.appt_id}">
                            <button type="submit" name="status" value="Cancelled" class="action-btn btn-cancel">
                                <i class="fas fa-ban"></i> Cancel Appointment
                            </button>
                        </form>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- QUICK LINKS -->
        <div class="card mt-20">
            <div class="card-body">
                <div class="info-grid">
                    <a href="${pageContext.request.contextPath}/doctor/ViewAppointments/${doctor.did}" class="action-btn" style="background: var(--light-bg); color: var(--text-dark);">
                        <i class="fas fa-list"></i> All Appointments
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/doctor/dashboard/${doctor.did}" class="action-btn" style="background: var(--light-bg); color: var(--text-dark);">
                        <i class="fas fa-home"></i> Dashboard
                    </a>
                    
                    <c:if test="${not empty patient.id}">
                        <a href="#" class="action-btn" style="background: var(--light-bg); color: var(--text-dark);">
                            <i class="fas fa-prescription"></i> Create Prescription
                        </a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</c:if>

<c:if test="${empty appointment || empty doctor || empty patient}">
    <div style="width: 100%; display: flex; justify-content: center; align-items: center; min-height: 100vh; background: var(--light-bg);">
        <div style="text-align: center; padding: 40px; background: white; border-radius: 16px; box-shadow: var(--shadow); max-width: 400px;">
            <div style="font-size: 3rem; color: var(--danger); margin-bottom: 20px;">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            <h2 style="color: var(--text-dark); margin-bottom: 10px;">Appointment Not Found</h2>
            <p style="color: var(--text-light); margin-bottom: 25px;">The requested appointment details could not be found.</p>
            <a href="${pageContext.request.contextPath}/doctor/dashboard/${doctor.did}" style="display: inline-block; padding: 12px 30px; 
               background: linear-gradient(135deg, var(--primary), var(--primary-light)); color: white; 
               text-decoration: none; border-radius: 8px; font-weight: 600;">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>
</c:if>

<script>
    // Auto-dismiss alerts after 5 seconds
    document.addEventListener('DOMContentLoaded', function() {
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
    
    // Print appointment details
    function printAppointment() {
        window.print();
    }
    
    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Ctrl+P to print
        if (e.ctrlKey && e.key === 'p') {
            e.preventDefault();
            printAppointment();
        }
        
        // Escape key to go back
        if (e.key === 'Escape') {
            window.history.back();
        }
    });
</script>
</body>
</html>