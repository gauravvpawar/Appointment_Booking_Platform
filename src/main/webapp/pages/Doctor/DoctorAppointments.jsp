<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doctor Appointments</title>
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

    .header-actions {
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

    .action-btn {
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
        border: none;
        cursor: pointer;
    }

    .action-btn:hover {
        background: linear-gradient(135deg, var(--primary-dark), var(--primary));
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(37, 99, 235, 0.3);
    }

    /* STATS BAR */
    .stats-bar {
        display: flex;
        gap: 20px;
        margin-bottom: 30px;
        flex-wrap: wrap;
    }

    .stat-badge {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 12px 20px;
        background: white;
        border-radius: 10px;
        box-shadow: var(--shadow-sm);
        border: 1px solid var(--border);
        min-width: 200px;
    }

    .stat-icon {
        width: 40px;
        height: 40px;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.2rem;
        color: white;
    }

    .stat-info h3 {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--text-dark);
        line-height: 1;
        margin-bottom: 4px;
    }

    .stat-info p {
        font-size: 0.85rem;
        color: var(--text-light);
        font-weight: 500;
    }

    /* FILTERS BAR */
    .filters-bar {
        background: white;
        border-radius: 12px;
        padding: 20px;
        margin-bottom: 30px;
        box-shadow: var(--shadow);
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        align-items: center;
    }

    .filter-group {
        display: flex;
        flex-direction: column;
        gap: 8px;
        min-width: 200px;
    }

    .filter-label {
        font-size: 0.85rem;
        font-weight: 600;
        color: var(--text-dark);
    }

    .filter-select, .filter-input {
        padding: 10px 14px;
        border: 1px solid var(--border);
        border-radius: 8px;
        font-size: 0.9rem;
        color: var(--text-dark);
        background: white;
        transition: all 0.3s ease;
    }

    .filter-select:focus, .filter-input:focus {
        outline: none;
        border-color: var(--primary);
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
    }

    .search-box {
        display: flex;
        gap: 10px;
        flex: 1;
        min-width: 300px;
    }

    .search-input {
        flex: 1;
        padding: 10px 14px;
        border: 1px solid var(--border);
        border-radius: 8px;
        font-size: 0.9rem;
    }

    /* DATA CARD */
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

    .card-header h2 {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--text-dark);
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .card-body {
        padding: 0;
    }

    /* TABLE */
    .table-container {
        overflow-x: auto;
    }

    .data-table {
        width: 100%;
        border-collapse: collapse;
        min-width: 1200px;
    }

    .data-table thead {
        background: linear-gradient(135deg, var(--light-bg), #f1f5f9);
    }

    .data-table th {
        padding: 16px 20px;
        text-align: left;
        font-weight: 600;
        color: var(--text-dark);
        font-size: 0.85rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border-bottom: 2px solid var(--border);
        white-space: nowrap;
    }

    .data-table td {
        padding: 16px 20px;
        border-bottom: 1px solid var(--border);
        color: var(--text-dark);
        font-weight: 500;
        vertical-align: middle;
    }

    .data-table tbody tr {
        transition: all 0.2s ease;
    }

    .data-table tbody tr:hover {
        background: rgba(37, 99, 235, 0.03);
    }

    /* STATUS TAGS */
    .status-tag {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 6px 14px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 600;
        white-space: nowrap;
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

    /* PATIENT INFO */
    .patient-info {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .patient-avatar {
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
        flex-shrink: 0;
    }

    .patient-details h4 {
        font-size: 0.95rem;
        font-weight: 600;
        color: var(--text-dark);
        margin-bottom: 4px;
    }

    .patient-details p {
        font-size: 0.8rem;
        color: var(--text-light);
        display: flex;
        align-items: center;
        gap: 8px;
    }

    /* ACTION BUTTONS */
    .action-buttons {
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
    }

    .btn-small {
        padding: 6px 12px;
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
        white-space: nowrap;
    }

    .btn-view {
        background: linear-gradient(135deg, var(--primary), var(--primary-light));
        color: white;
    }

    .btn-view:hover {
        background: linear-gradient(135deg, var(--primary-dark), var(--primary));
        transform: translateY(-1px);
    }

    .btn-accept {
        background: linear-gradient(135deg, var(--success), #34d399);
        color: white;
    }

    .btn-accept:hover {
        background: linear-gradient(135deg, #059669, var(--success));
        transform: translateY(-1px);
    }

    .btn-reject {
        background: linear-gradient(135deg, var(--danger), #f87171);
        color: white;
    }

    .btn-reject:hover {
        background: linear-gradient(135deg, #dc2626, var(--danger));
        transform: translateY(-1px);
    }

    .btn-cancel {
        background: linear-gradient(135deg, var(--warning), #fbbf24);
        color: white;
    }

    .btn-cancel:hover {
        background: linear-gradient(135deg, #d97706, var(--warning));
        transform: translateY(-1px);
    }

    /* EMPTY STATE */
    .empty-state {
        text-align: center;
        padding: 80px 20px;
        color: var(--text-light);
    }

    .empty-state i {
        font-size: 4rem;
        margin-bottom: 20px;
        opacity: 0.5;
    }

    .empty-state h3 {
        font-size: 1.5rem;
        margin-bottom: 10px;
        color: var(--text-dark);
    }

    .empty-state p {
        margin-bottom: 25px;
        max-width: 400px;
        margin: 0 auto 25px;
    }

    /* ALERTS */
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

    /* RESPONSIVE */
    @media (max-width: 768px) {
        .content-area {
            padding: 20px;
        }
        
        .header {
            flex-direction: column;
            gap: 15px;
            padding: 15px;
        }
        
        .header-actions {
            flex-direction: column;
            width: 100%;
        }
        
        .user-profile {
            width: 100%;
            justify-content: center;
        }
        
        .stats-bar {
            flex-direction: column;
        }
        
        .stat-badge {
            min-width: 100%;
        }
        
        .filters-bar {
            flex-direction: column;
            align-items: stretch;
        }
        
        .search-box {
            min-width: 100%;
        }
        
        .action-buttons {
            flex-direction: column;
        }
        
        .btn-small {
            justify-content: center;
        }
    }
</style>
</head>
<body>

<c:if test="${not empty doctor}">
    <!-- HEADER -->
    <div class="header">
        <div class="page-title">
            <h1><i class="fas fa-calendar-alt"></i> Doctor Appointments</h1>
        </div>
        <div class="header-actions">
            <div class="user-profile">
                <div class="user-avatar">
                    <c:choose>
                        <c:when test="${not empty doctor.doctorInfo.fileName}">
                            <img src="${pageContext.request.contextPath}/images/Doctor/Profiles/${doctor.doctorInfo.fileName}" 
                                 alt="Doctor Profile" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;">
                        </c:when>
                        <c:otherwise>
                            ${doctor.name.charAt(0)}
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="user-info">
                    <h4>Dr. ${doctor.name}</h4>
                    <p>${doctor.specialization}</p>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/doctor/dashboard/${doctor.did}" class="action-btn">
                <i class="fas fa-arrow-left"></i>
                Back to Dashboard
            </a>
        </div>
    </div>

    <!-- CONTENT AREA -->
    <div class="content-area">
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

        <!-- STATISTICS BAR -->
        <div class="stats-bar">
            <div class="stat-badge">
                <div class="stat-icon" style="background: linear-gradient(135deg, var(--primary), var(--primary-light));">
                    <i class="fas fa-calendar-alt"></i>
                </div>
                <div class="stat-info">
                    <h3>${not empty appointments ? appointments.size() : 0}</h3>
                    <p>Total Appointments</p>
                </div>
            </div>
            
            <div class="stat-badge">
                <div class="stat-icon" style="background: linear-gradient(135deg, var(--success), #34d399);">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-info">
                    <h3>
                        <c:set var="confirmedCount" value="0" />
                        <c:forEach var="appt" items="${appointments}">
                            <c:if test="${appt.appointment_status == 'Confirmed'}">
                                <c:set var="confirmedCount" value="${confirmedCount + 1}" />
                            </c:if>
                        </c:forEach>
                        ${confirmedCount}
                    </h3>
                    <p>Confirmed</p>
                </div>
            </div>
            
            <div class="stat-badge">
                <div class="stat-icon" style="background: linear-gradient(135deg, var(--warning), #fbbf24);">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-info">
                    <h3>
                        <c:set var="pendingCount" value="0" />
                        <c:forEach var="appt" items="${appointments}">
                            <c:if test="${appt.appointment_status == 'Pending'}">
                                <c:set var="pendingCount" value="${pendingCount + 1}" />
                            </c:if>
                        </c:forEach>
                        ${pendingCount}
                    </h3>
                    <p>Pending</p>
                </div>
            </div>
            
            <div class="stat-badge">
                <div class="stat-icon" style="background: linear-gradient(135deg, var(--info), #22d3ee);">
                    <i class="fas fa-user-injured"></i>
                </div>
                <div class="stat-info">
                    <h3>
                        <c:set var="uniqueCount" value="0" />
                        <c:set var="patientIds" value="" />
                        <c:forEach var="appt" items="${appointments}">
                            <c:if test="${not fn:contains(patientIds, appt.patient.id)}">
                                <c:set var="patientIds" value="${patientIds},${appt.patient.id}" />
                                <c:set var="uniqueCount" value="${uniqueCount + 1}" />
                            </c:if>
                        </c:forEach>
                        ${uniqueCount}
                    </h3>
                    <p>Unique Patients</p>
                </div>
            </div>
        </div>

        <!-- FILTERS -->
        <div class="filters-bar">
            <div class="search-box">
                <input type="text" id="searchInput" class="search-input" placeholder="Search by patient name, reason, or status...">
                <button onclick="searchAppointments()" class="action-btn">
                    <i class="fas fa-search"></i>
                    Search
                </button>
            </div>
            
            <div class="filter-group">
                <label class="filter-label">Status</label>
                <select id="statusFilter" class="filter-select">
                    <option value="all">All Status</option>
                    <option value="Pending">Pending</option>
                    <option value="Confirmed">Confirmed</option>
                    <option value="Cancelled">Cancelled</option>
                    <option value="Rejected">Rejected</option>
                </select>
            </div>
            
            <button onclick="resetFilters()" class="action-btn">
                <i class="fas fa-redo"></i>
                Reset Filters
            </button>
            
            <button onclick="printAppointments()" class="action-btn" style="margin-left: auto;">
                <i class="fas fa-print"></i>
                Print
            </button>
        </div>

        <!-- APPOINTMENTS TABLE -->
        <div class="data-card">
            <div class="card-header">
                <h2><i class="fas fa-list"></i> All Appointments</h2>
                <div>
                    <span>Showing ${not empty appointments ? appointments.size() : 0} appointments</span>
                </div>
            </div>
            
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty appointments && appointments.size() > 0}">
                        <div class="table-container">
                            <table class="data-table" id="appointmentsTable">
                                <thead>
                                    <tr>
                                        <th style="width: 200px;">Patient</th>
                                        <th style="width: 120px;">Date & Time</th>
                                        <th style="width: 200px;">Reason</th>
                                        <th style="width: 100px;">Status</th>
                                        <th style="width: 150px;">Created On</th>
                                        <th style="width: 200px;">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="appointment" items="${appointments}">
                                        <tr class="appointment-row" 
                                            data-patient="${fn:toLowerCase(appointment.patient.name)}"
                                            data-reason="${fn:toLowerCase(appointment.reason)}"
                                            data-status="${appointment.appointment_status}"
                                            data-date="${appointment.appointment_date}">
                                            <td>
                                                <div class="patient-info">
                                                    <div class="patient-avatar">
                                                        <c:choose>
                                                            <c:when test="${not empty appointment.patient.patientinfo.fileName}">
                                                                <img src="${pageContext.request.contextPath}/images/${appointment.patient.patientinfo.fileName}" 
                                                                     alt="Patient" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;">
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${fn:substring(appointment.patient.name, 0, 1)}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div class="patient-details">
                                                        <h4>${appointment.patient.name}</h4>
                                                        <p>
                                                            <i class="fas fa-user"></i> ${appointment.patient.age} yrs
                                                            <span style="margin: 0 5px;">•</span>
                                                            <i class="fas fa-venus-mars"></i> ${appointment.patient.gender}
                                                            <span style="margin: 0 5px;">•</span>
                                                            <i class="fas fa-phone"></i> ${appointment.patient.phone}
                                                        </p>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div style="display: flex; align-items: center; gap: 8px;">
                                                    <i class="fas fa-calendar-day" style="color: var(--primary);"></i>
                                                    <span>${appointment.appointment_date}</span>
                                                </div>
                                                <div style="margin-top: 5px; font-weight: 600; color: var(--text-dark);">
                                                    <i class="fas fa-clock"></i> ${appointment.appointment_time}
                                                </div>
                                            </td>
                                            <td>
                                                <div style="max-width: 200px; word-wrap: break-word;">
                                                    ${appointment.reason}
                                                </div>
                                            </td>
                                            <td>
                                                <span class="status-tag 
                                                    <c:choose>
                                                        <c:when test="${appointment.appointment_status == 'Pending'}">status-pending</c:when>
                                                        <c:when test="${appointment.appointment_status == 'Confirmed'}">status-confirmed</c:when>
                                                        <c:when test="${appointment.appointment_status == 'Cancelled'}">status-cancelled</c:when>
                                                        <c:when test="${appointment.appointment_status == 'Rejected'}">status-rejected</c:when>
                                                        <c:otherwise>status-pending</c:otherwise>
                                                    </c:choose>">
                                                    <i class="fas fa-circle"></i> ${appointment.appointment_status}
                                                </span>
                                            </td>
                                            <td>
                                                <c:if test="${not empty appointment.createdAt}">
                                                    <fmt:formatDate value="${appointment.createdAt}" pattern="dd MMM yyyy HH:mm" />
                                                </c:if>
                                                <c:if test="${empty appointment.createdAt}">
                                                    -
                                                </c:if>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <a href="${pageContext.request.contextPath}/doctor/ViewAppointmentDetails/${doctor.did}/${appointment.appt_id}" 
                                                       class="btn-small btn-view">
                                                        <i class="fas fa-eye"></i> View
                                                    </a>
                                                    
                                                    <c:if test="${appointment.appointment_status == 'Pending'}">
                                                        <form action="${pageContext.request.contextPath}/doctor/UpdateAppointmentStatus/${doctor.did}" 
                                                              method="post" style="display: inline;">
                                                            <input type="hidden" name="appointmentId" value="${appointment.appt_id}">
                                                            <button type="submit" name="status" value="Confirmed" class="btn-small btn-accept">
                                                                <i class="fas fa-check"></i> Accept
                                                            </button>
                                                        </form>
                                                        
                                                        <form action="${pageContext.request.contextPath}/doctor/UpdateAppointmentStatus/${doctor.did}" 
                                                              method="post" style="display: inline;">
                                                            <input type="hidden" name="appointmentId" value="${appointment.appt_id}">
                                                            <button type="submit" name="status" value="Rejected" class="btn-small btn-reject">
                                                                <i class="fas fa-times"></i> Reject
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                    
                                                    <c:if test="${appointment.appointment_status == 'Confirmed'}">
                                                        <form action="${pageContext.request.contextPath}/doctor/UpdateAppointmentStatus/${doctor.did}" 
                                                              method="post" style="display: inline;">
                                                            <input type="hidden" name="appointmentId" value="${appointment.appt_id}">
                                                            <button type="submit" name="status" value="Cancelled" class="btn-small btn-cancel">
                                                                <i class="fas fa-ban"></i> Cancel
                                                            </button>
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
                            <h3>No Appointments Found</h3>
                            <p>You don't have any appointments scheduled yet.</p>
                            <a href="${pageContext.request.contextPath}/doctor/dashboard/${doctor.did}" class="action-btn">
                                <i class="fas fa-arrow-left"></i>
                                Back to Dashboard
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
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
            <p style="color: var(--text-light); margin-bottom: 25px;">Please log in to view appointments</p>
            <a href="${pageContext.request.contextPath}/doctor/login" style="display: inline-block; padding: 12px 30px; 
               background: linear-gradient(135deg, var(--primary), var(--primary-light)); color: white; 
               text-decoration: none; border-radius: 8px; font-weight: 600;">
                <i class="fas fa-sign-in-alt"></i> Go to Login
            </a>
        </div>
    </div>
</c:if>

<script>
    // Simple filter function
    function searchAppointments() {
        const searchText = document.getElementById('searchInput').value.toLowerCase();
        const statusFilter = document.getElementById('statusFilter').value;
        const rows = document.querySelectorAll('.appointment-row');
        let visibleCount = 0;
        
        rows.forEach(row => {
            const patient = row.dataset.patient || '';
            const reason = row.dataset.reason || '';
            const status = row.dataset.status || '';
            
            let shouldShow = true;
            
            // Apply search filter
            if (searchText && !patient.includes(searchText) && !reason.includes(searchText)) {
                shouldShow = false;
            }
            
            // Apply status filter
            if (statusFilter !== 'all' && status !== statusFilter) {
                shouldShow = false;
            }
            
            if (shouldShow) {
                row.style.display = '';
                visibleCount++;
            } else {
                row.style.display = 'none';
            }
        });
        
        // Update count
        document.querySelector('.card-header span').textContent = `Showing ${visibleCount} appointments`;
    }
    
    function resetFilters() {
        document.getElementById('searchInput').value = '';
        document.getElementById('statusFilter').value = 'all';
        searchAppointments();
    }
    
    function printAppointments() {
        window.print();
    }
    
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
        
        // Add enter key listener for search
        document.getElementById('searchInput').addEventListener('keyup', function(event) {
            if (event.key === 'Enter') {
                searchAppointments();
            }
        });
    });
    
    // Add confirmation for actions
    function confirmAction(action, appointmentId) {
        const messages = {
            'accept': 'Are you sure you want to accept this appointment?',
            'reject': 'Are you sure you want to reject this appointment?',
            'cancel': 'Are you sure you want to cancel this appointment?'
        };
        
        return confirm(messages[action] || 'Are you sure?');
    }
    
    // Add event listeners to all action forms
    document.addEventListener('DOMContentLoaded', function() {
        const forms = document.querySelectorAll('form');
        forms.forEach(form => {
            form.addEventListener('submit', function(e) {
                const action = this.querySelector('button[type="submit"]').textContent.toLowerCase();
                if (action.includes('accept')) {
                    if (!confirmAction('accept', this.appointmentId.value)) {
                        e.preventDefault();
                    }
                } else if (action.includes('reject')) {
                    if (!confirmAction('reject', this.appointmentId.value)) {
                        e.preventDefault();
                    }
                } else if (action.includes('cancel')) {
                    if (!confirmAction('cancel', this.appointmentId.value)) {
                        e.preventDefault();
                    }
                }
            });
        });
    });
</script>
</body>
</html>