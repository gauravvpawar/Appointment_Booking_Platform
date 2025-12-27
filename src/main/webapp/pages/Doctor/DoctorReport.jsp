<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doctor Reports</title>
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
        max-width: 1200px;
        margin: 0 auto;
    }

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
    }

    /* STATS GRID */
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }

    .stat-card {
        background: white;
        border-radius: 12px;
        padding: 20px;
        box-shadow: var(--shadow);
        border: 1px solid var(--border);
        transition: all 0.3s ease;
    }

    .stat-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
    }

    .stat-icon {
        width: 50px;
        height: 50px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        color: white;
        margin-bottom: 15px;
    }

    .stat-title {
        font-size: 0.9rem;
        font-weight: 600;
        color: var(--text-light);
        margin-bottom: 8px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .stat-value {
        font-size: 2rem;
        font-weight: 700;
        color: var(--text-dark);
        margin-bottom: 5px;
    }

    /* REPORTS GRID */
    .reports-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }

    .report-card {
        background: white;
        border-radius: 12px;
        padding: 25px;
        box-shadow: var(--shadow);
        text-decoration: none;
        color: var(--text-dark);
        display: block;
        transition: all 0.3s ease;
        border: 2px solid transparent;
    }

    .report-card:hover {
        transform: translateY(-5px);
        border-color: var(--primary);
        box-shadow: 0 10px 30px rgba(37, 99, 235, 0.15);
    }

    .report-icon {
        width: 60px;
        height: 60px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.8rem;
        color: white;
        margin-bottom: 20px;
    }

    .report-info h3 {
        font-size: 1.3rem;
        font-weight: 700;
        color: var(--text-dark);
        margin-bottom: 10px;
    }

    .report-info p {
        font-size: 0.9rem;
        color: var(--text-light);
        margin-bottom: 15px;
        line-height: 1.5;
    }

    /* FILTER FORM */
    .filter-form {
        background: white;
        border-radius: 12px;
        padding: 25px;
        margin-bottom: 30px;
        box-shadow: var(--shadow);
    }

    .filter-title {
        font-size: 1.3rem;
        font-weight: 700;
        color: var(--text-dark);
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .form-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
    }

    .form-group {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .form-label {
        font-size: 0.9rem;
        font-weight: 600;
        color: var(--text-dark);
    }

    .form-input, .form-select {
        padding: 12px 16px;
        border: 1px solid var(--border);
        border-radius: 8px;
        font-size: 0.95rem;
        color: var(--text-dark);
        background: white;
    }

    .form-input:focus, .form-select:focus {
        outline: none;
        border-color: var(--primary);
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
    }

    .submit-btn {
        padding: 12px 30px;
        background: linear-gradient(135deg, var(--success), #34d399);
        color: white;
        border: none;
        border-radius: 8px;
        font-weight: 600;
        font-size: 0.95rem;
        cursor: pointer;
        transition: all 0.3s ease;
        align-self: flex-end;
    }

    .submit-btn:hover {
        background: linear-gradient(135deg, #059669, var(--success));
        transform: translateY(-2px);
    }

    /* REPORT RESULTS */
    .report-results {
        background: white;
        border-radius: 12px;
        padding: 25px;
        margin-bottom: 30px;
        box-shadow: var(--shadow);
    }

    .results-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        padding-bottom: 15px;
        border-bottom: 1px solid var(--border);
    }

    .results-title {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--text-dark);
    }

    .results-period {
        font-size: 0.9rem;
        color: var(--text-light);
    }

    .results-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 15px;
        margin-bottom: 25px;
    }

    .result-item {
        background: var(--light-bg);
        border-radius: 8px;
        padding: 15px;
        border: 1px solid var(--border);
    }

    .result-label {
        font-size: 0.85rem;
        font-weight: 600;
        color: var(--text-light);
        margin-bottom: 5px;
    }

    .result-value {
        font-size: 1.2rem;
        font-weight: 700;
        color: var(--text-dark);
    }

    /* TABLE */
    .table-container {
        overflow-x: auto;
        border-radius: 8px;
        border: 1px solid var(--border);
        margin-top: 20px;
    }

    .data-table {
        width: 100%;
        border-collapse: collapse;
    }

    .data-table thead {
        background: linear-gradient(135deg, var(--light-bg), #f1f5f9);
    }

    .data-table th {
        padding: 12px 16px;
        text-align: left;
        font-weight: 600;
        color: var(--text-dark);
        font-size: 0.85rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border-bottom: 2px solid var(--border);
    }

    .data-table td {
        padding: 12px 16px;
        border-bottom: 1px solid var(--border);
        color: var(--text-dark);
        font-weight: 500;
    }

    .data-table tbody tr:hover {
        background: rgba(37, 99, 235, 0.03);
    }

    /* ALERTS */
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

    /* RESPONSIVE */
    @media (max-width: 768px) {
        .container {
            padding: 10px;
        }
        
        .header {
            flex-direction: column;
            gap: 15px;
            text-align: center;
        }
        
        .stats-grid,
        .reports-grid {
            grid-template-columns: 1fr;
        }
        
        .form-grid {
            grid-template-columns: 1fr;
        }
        
        .results-header {
            flex-direction: column;
            gap: 10px;
            text-align: center;
        }
    }
</style>
</head>
<body>

<c:if test="${not empty doctor}">
    <div class="container">
        <!-- HEADER -->
        <div class="header">
            <div class="page-title">
                <h1><i class="fas fa-chart-line"></i> Doctor Reports & Analytics</h1>
                <p style="color: var(--text-light); font-size: 0.9rem; margin-top: 5px;">
                    Dr. ${doctor.name} - ${doctor.specialization}
                </p>
            </div>
            <a href="${pageContext.request.contextPath}/doctor/dashboard/${doctor.did}" class="back-btn">
                <i class="fas fa-arrow-left"></i>
                Back to Dashboard
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

        <!-- QUICK STATS -->
        <c:if test="${not empty stats}">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon" style="background: linear-gradient(135deg, var(--primary), var(--primary-light));">
                        <i class="fas fa-calendar-alt"></i>
                    </div>
                    <div class="stat-title">Total Appointments</div>
                    <div class="stat-value">${stats.totalAppointments}</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon" style="background: linear-gradient(135deg, var(--success), #34d399);">
                        <i class="fas fa-user-check"></i>
                    </div>
                    <div class="stat-title">Unique Patients</div>
                    <div class="stat-value">${stats.uniquePatients}</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon" style="background: linear-gradient(135deg, var(--warning), #fbbf24);">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="stat-title">Today's Appointments</div>
                    <div class="stat-value">${stats.todayAppointments}</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon" style="background: linear-gradient(135deg, var(--info), #22d3ee);">
                        <i class="fas fa-chart-pie"></i>
                    </div>
                    <div class="stat-title">Patient Satisfaction</div>
                    <div class="stat-value">${stats.satisfactionRate}%</div>
                </div>
            </div>
        </c:if>

        <!-- REPORTS DASHBOARD -->
        <div class="reports-grid">
            <a href="javascript:void(0)" onclick="showReportForm('appointments')" class="report-card">
                <div class="report-icon" style="background: linear-gradient(135deg, var(--primary), var(--primary-light));">
                    <i class="fas fa-calendar-alt"></i>
                </div>
                <div class="report-info">
                    <h3>Appointments Report</h3>
                    <p>View detailed analysis of appointments, cancellations, and patient visits over time.</p>
                    <div style="color: var(--primary); font-weight: 600;">
                        <i class="fas fa-arrow-right"></i> Generate Report
                    </div>
                </div>
            </a>
            
            <a href="javascript:void(0)" onclick="showReportForm('patients')" class="report-card">
                <div class="report-icon" style="background: linear-gradient(135deg, var(--success), #34d399);">
                    <i class="fas fa-user-injured"></i>
                </div>
                <div class="report-info">
                    <h3>Patients Report</h3>
                    <p>Analyze patient demographics, visit patterns, and health statistics.</p>
                    <div style="color: var(--success); font-weight: 600;">
                        <i class="fas fa-arrow-right"></i> Generate Report
                    </div>
                </div>
            </a>
            
            <a href="javascript:void(0)" onclick="showReportForm('earnings')" class="report-card">
                <div class="report-icon" style="background: linear-gradient(135deg, var(--warning), #fbbf24);">
                    <i class="fas fa-money-bill-wave"></i>
                </div>
                <div class="report-info">
                    <h3>Earnings Report</h3>
                    <p>Track your earnings, consultation fees, and financial performance.</p>
                    <div style="color: var(--warning); font-weight: 600;">
                        <i class="fas fa-arrow-right"></i> Generate Report
                    </div>
                </div>
            </a>
            
            <a href="javascript:void(0)" onclick="showReportForm('prescriptions')" class="report-card">
                <div class="report-icon" style="background: linear-gradient(135deg, var(--info), #22d3ee);">
                    <i class="fas fa-prescription"></i>
                </div>
                <div class="report-info">
                    <h3>Prescriptions Report</h3>
                    <p>View medication statistics and prescription patterns.</p>
                    <div style="color: var(--info); font-weight: 600;">
                        <i class="fas fa-arrow-right"></i> Generate Report
                    </div>
                </div>
            </a>
        </div>

        <!-- REPORT FILTER FORM -->
        <div class="filter-form" id="reportForm" style="display: none;">
            <h2 class="filter-title"><i class="fas fa-filter"></i> Generate Report</h2>
            <form action="${pageContext.request.contextPath}/doctor/GenerateReport" method="get">
                <input type="hidden" id="reportType" name="reportType">
                
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label">Start Date</label>
                        <input type="date" name="startDate" class="form-input" id="startDate" required>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">End Date</label>
                        <input type="date" name="endDate" class="form-input" id="endDate" required>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Filter By Status</label>
                        <select name="filterBy" class="form-select">
                            <option value="all">All Status</option>
                            <option value="Pending">Pending</option>
                            <option value="Confirmed">Confirmed</option>
                            <option value="Cancelled">Cancelled</option>
                            <option value="Rejected">Rejected</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" class="submit-btn">
                            <i class="fas fa-chart-bar"></i>
                            Generate Report
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- REPORT RESULTS -->
        <c:if test="${not empty reportData}">
            <div class="report-results">
                <div class="results-header">
                    <h2 class="results-title">${reportData.title}</h2>
                    <div class="results-period">
                        Period: ${startDate} to ${endDate}
                        <c:if test="${not empty filterBy && filterBy != 'all'}">
                            | Status: ${filterBy}
                        </c:if>
                    </div>
                </div>
                
                <!-- Report specific content -->
                <c:choose>
                    <c:when test="${reportType == 'appointments'}">
                        <div class="results-grid">
                            <div class="result-item">
                                <div class="result-label">Total Appointments</div>
                                <div class="result-value">
                                    <c:set var="appointmentTotal" value="0" />
                                    <c:if test="${not empty reportData.dailyCounts}">
                                        <c:forEach var="count" items="${reportData.dailyCounts}">
                                            <c:set var="appointmentTotal" value="${appointmentTotal + count.value}" />
                                        </c:forEach>
                                    </c:if>
                                    ${appointmentTotal}
                                </div>
                            </div>
                            
                            <c:if test="${not empty reportData.statusDistribution}">
                                <c:forEach var="entry" items="${reportData.statusDistribution}">
                                    <div class="result-item">
                                        <div class="result-label">${entry.key}</div>
                                        <div class="result-value">${entry.value}</div>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </div>
                        
                        <c:if test="${not empty reportData.topPatients}">
                            <h3 style="margin: 20px 0 10px 0; color: var(--text-dark);">Top Patients by Visits</h3>
                            <div class="table-container">
                                <table class="data-table">
                                    <thead>
                                        <tr>
                                            <th>Patient Name</th>
                                            <th>Number of Visits</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="entry" items="${reportData.topPatients}">
                                            <tr>
                                                <td>${entry.key}</td>
                                                <td>${entry.value}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>
                    </c:when>
                    
                    <c:when test="${reportType == 'patients'}">
                        <div class="results-grid">
                            <div class="result-item">
                                <div class="result-label">Total Patients</div>
                                <div class="result-value">${reportData.totalPatients}</div>
                            </div>
                            
                            <div class="result-item">
                                <div class="result-label">New Patients</div>
                                <div class="result-value">${reportData.newPatients}</div>
                            </div>
                            
                            <div class="result-item">
                                <div class="result-label">Returning Patients</div>
                                <div class="result-value">${reportData.returningPatients}</div>
                            </div>
                        </div>
                        
                        <c:if test="${not empty reportData.ageDistribution}">
                            <h3 style="margin: 20px 0 10px 0; color: var(--text-dark);">Age Distribution</h3>
                            <div class="table-container">
                                <table class="data-table">
                                    <thead>
                                        <tr>
                                            <th>Age Group</th>
                                            <th>Number of Patients</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="entry" items="${reportData.ageDistribution}">
                                            <tr>
                                                <td>${entry.key}</td>
                                                <td>${entry.value}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>
                    </c:when>
                    
                    <c:when test="${reportType == 'earnings'}">
                        <div class="results-grid">
                            <div class="result-item">
                                <div class="result-label">Total Earnings</div>
                                <div class="result-value">₹${reportData.totalEarnings}</div>
                            </div>
                            
                            <div class="result-item">
                                <div class="result-label">Total Consultations</div>
                                <div class="result-value">${reportData.totalConsultations}</div>
                            </div>
                            
                            <div class="result-item">
                                <div class="result-label">Average per Appointment</div>
                                <div class="result-value">₹<fmt:formatNumber value="${reportData.avgPerAppointment}" maxFractionDigits="2" /></div>
                            </div>
                        </div>
                        
                        <c:if test="${not empty reportData.earningsByType}">
                            <h3 style="margin: 20px 0 10px 0; color: var(--text-dark);">Earnings by Service Type</h3>
                            <div class="table-container">
                                <table class="data-table">
                                    <thead>
                                        <tr>
                                            <th>Service Type</th>
                                            <th>Earnings</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="entry" items="${reportData.earningsByType}">
                                            <tr>
                                                <td>${entry.key}</td>
                                                <td>₹<fmt:formatNumber value="${entry.value}" maxFractionDigits="2" /></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>
                    </c:when>
                    
                    <c:when test="${reportType == 'prescriptions'}">
                        <div class="results-grid">
                            <div class="result-item">
                                <div class="result-label">Total Prescriptions</div>
                                <div class="result-value">${reportData.totalPrescriptions}</div>
                            </div>
                        </div>
                        
                        <c:if test="${not empty reportData.prescriptions}">
                            <h3 style="margin: 20px 0 10px 0; color: var(--text-dark);">Recent Prescriptions</h3>
                            <div class="table-container">
                                <table class="data-table">
                                    <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Patient</th>
                                            <th>Medication</th>
                                            <th>Dosage</th>
                                            <th>Frequency</th>
                                            <th>Duration</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="pres" items="${reportData.prescriptions}">
                                            <tr>
                                                <td>${pres.date}</td>
                                                <td>${pres.patient}</td>
                                                <td>${pres.medication}</td>
                                                <td>${pres.dosage}</td>
                                                <td>${pres.frequency}</td>
                                                <td>${pres.duration}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>
                    </c:when>
                </c:choose>
                
                <!-- Export Options -->
                <div style="margin-top: 30px; padding-top: 20px; border-top: 1px solid var(--border);">
                    <h3 style="margin-bottom: 15px; color: var(--text-dark);">Export Options</h3>
                    <button onclick="printReport()" style="padding: 10px 20px; background: var(--primary); color: white; 
                           border: none; border-radius: 6px; margin-right: 10px; cursor: pointer;">
                        <i class="fas fa-print"></i> Print Report
                    </button>
                    <button onclick="exportToExcel()" style="padding: 10px 20px; background: var(--success); color: white; 
                           border: none; border-radius: 6px; cursor: pointer;">
                        <i class="fas fa-file-excel"></i> Export to Excel
                    </button>
                </div>
            </div>
        </c:if>

        <!-- VIEW PATIENT HISTORY -->
        <div class="filter-form">
            <h2 class="filter-title"><i class="fas fa-history"></i> View Patient History</h2>
            <form action="${pageContext.request.contextPath}/doctor/PatientHistory" method="get" style="display: flex; gap: 10px; align-items: flex-end;">
                <div class="form-group" style="flex: 1;">
                    <label class="form-label">Enter Patient ID</label>
                    <input type="number" name="patientId" class="form-input" placeholder="Enter patient ID" required>
                </div>
                <button type="submit" class="submit-btn">
                    <i class="fas fa-search"></i>
                    View History
                </button>
            </form>
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
            <p style="color: var(--text-light); margin-bottom: 25px;">Please log in to view reports</p>
            <a href="${pageContext.request.contextPath}/doctor/login" style="display: inline-block; padding: 12px 30px; 
               background: linear-gradient(135deg, var(--primary), var(--primary-light)); color: white; 
               text-decoration: none; border-radius: 8px; font-weight: 600;">
                <i class="fas fa-sign-in-alt"></i> Go to Login
            </a>
        </div>
    </div>
</c:if>

<script>
    // Show report form
    function showReportForm(reportType) {
        document.getElementById('reportForm').style.display = 'block';
        document.getElementById('reportType').value = reportType;
        
        // Set default dates (last 30 days)
        const today = new Date();
        const lastMonth = new Date();
        lastMonth.setDate(today.getDate() - 30);
        
        document.getElementById('startDate').value = lastMonth.toISOString().split('T')[0];
        document.getElementById('endDate').value = today.toISOString().split('T')[0];
        
        // Scroll to form
        document.getElementById('reportForm').scrollIntoView({ behavior: 'smooth' });
    }
    
    // Print report
    function printReport() {
        window.print();
    }
    
    // Export to Excel
    function exportToExcel() {
        alert('Excel export functionality would be implemented here');
        // In real implementation, this would generate and download Excel file
    }
    
    // Initialize date inputs
    document.addEventListener('DOMContentLoaded', function() {
        const today = new Date();
        const lastMonth = new Date();
        lastMonth.setDate(today.getDate() - 30);
        
        // Auto-dismiss alerts
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
</script>
</body>
</html>