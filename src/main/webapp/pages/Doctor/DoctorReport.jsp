<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

    .back-btn {
        background: linear-gradient(135deg, #f1f5f9, #e2e8f0);
        color: var(--text-dark);
    }

    .back-btn:hover {
        background: linear-gradient(135deg, #e2e8f0, #cbd5e1);
        box-shadow: 0 6px 20px rgba(100, 116, 139, 0.2);
    }

    /* CONTENT AREA */
    .content-area {
        padding: 30px;
        max-width: 1400px;
        margin: 0 auto;
    }

    /* REPORTS DASHBOARD */
    .reports-dashboard {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 25px;
        margin-bottom: 30px;
    }

    .report-card {
        background: white;
        border-radius: 16px;
        padding: 25px;
        box-shadow: var(--shadow);
        transition: all 0.3s ease;
        border: 1px solid var(--border);
        text-decoration: none;
        color: var(--text-dark);
        display: block;
    }

    .report-card:hover {
        transform: translateY(-5px);
        box-shadow: var(--shadow-lg);
        border-color: var(--primary);
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

    /* FILTER SECTION */
    .filter-section {
        background: white;
        border-radius: 16px;
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

    .filter-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
    }

    .filter-group {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .filter-label {
        font-size: 0.9rem;
        font-weight: 600;
        color: var(--text-dark);
    }

    .filter-input, .filter-select {
        padding: 12px 16px;
        border: 1px solid var(--border);
        border-radius: 8px;
        font-size: 0.95rem;
        color: var(--text-dark);
        background: white;
        transition: all 0.3s ease;
    }

    .filter-input:focus, .filter-select:focus {
        outline: none;
        border-color: var(--primary);
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
    }

    /* REPORT CONTENT */
    .report-content {
        background: white;
        border-radius: 16px;
        padding: 30px;
        box-shadow: var(--shadow);
        margin-bottom: 30px;
    }

    .report-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        padding-bottom: 20px;
        border-bottom: 1px solid var(--border);
    }

    .report-header h2 {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--text-dark);
        display: flex;
        align-items: center;
        gap: 10px;
    }

    /* STATS GRID */
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }

    .stat-box {
        background: linear-gradient(135deg, #f8fafc, #f1f5f9);
        border-radius: 12px;
        padding: 20px;
        border: 1px solid var(--border);
    }

    .stat-title {
        font-size: 0.9rem;
        font-weight: 600;
        color: var(--text-light);
        margin-bottom: 10px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .stat-value {
        font-size: 2rem;
        font-weight: 700;
        color: var(--text-dark);
        margin-bottom: 5px;
    }

    .stat-change {
        font-size: 0.85rem;
        font-weight: 500;
    }

    .stat-positive {
        color: var(--success);
    }

    .stat-negative {
        color: var(--danger);
    }

    /* TABLE */
    .table-container {
        overflow-x: auto;
        border-radius: 12px;
        border: 1px solid var(--border);
        margin-bottom: 30px;
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
        font-size: 0.85rem;
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

    .data-table tbody tr:hover {
        background: rgba(37, 99, 235, 0.03);
    }

    /* CHART CONTAINER */
    .chart-container {
        background: white;
        border-radius: 12px;
        padding: 20px;
        border: 1px solid var(--border);
        margin-bottom: 30px;
        min-height: 300px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .chart-placeholder {
        text-align: center;
        color: var(--text-light);
    }

    .chart-placeholder i {
        font-size: 4rem;
        margin-bottom: 20px;
        opacity: 0.5;
    }

    .chart-placeholder h4 {
        font-size: 1.2rem;
        margin-bottom: 10px;
        color: var(--text-dark);
    }

    /* EMPTY STATE */
    .empty-state {
        text-align: center;
        padding: 60px 20px;
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

    /* PRINT BUTTONS */
    .print-options {
        display: flex;
        gap: 15px;
        margin-top: 30px;
        padding-top: 20px;
        border-top: 1px solid var(--border);
    }

    .print-btn {
        padding: 10px 20px;
        background: linear-gradient(135deg, var(--primary), var(--primary-light));
        color: white;
        border: none;
        border-radius: 8px;
        font-weight: 600;
        font-size: 0.9rem;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s ease;
    }

    .print-btn:hover {
        background: linear-gradient(135deg, var(--primary-dark), var(--primary));
        transform: translateY(-2px);
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
        
        .reports-dashboard {
            grid-template-columns: 1fr;
        }
        
        .filter-grid {
            grid-template-columns: 1fr;
        }
        
        .stats-grid {
            grid-template-columns: 1fr;
        }
        
        .print-options {
            flex-direction: column;
        }
    }

    /* PRINT STYLES */
    @media print {
        .header-actions,
        .filter-section,
        .print-options,
        .action-btn:not(.print-btn) {
            display: none;
        }
        
        .report-card {
            break-inside: avoid;
            page-break-inside: avoid;
        }
        
        .data-table {
            min-width: auto;
        }
        
        .data-table th,
        .data-table td {
            padding: 8px;
            font-size: 0.9rem;
        }
    }
</style>
</head>
<body>

<c:if test="${not empty doctor}">
    <!-- HEADER -->
    <div class="header">
        <div class="page-title">
            <h1><i class="fas fa-chart-line"></i> Doctor Reports</h1>
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
            <a href="${pageContext.request.contextPath}/doctor/dashboard/${doctor.did}" class="action-btn back-btn">
                <i class="fas fa-arrow-left"></i>
                Back to Dashboard
            </a>
        </div>
    </div>

    <!-- CONTENT AREA -->
    <div class="content-area">
        <!-- ALERTS -->
        <c:if test="${not empty msg}">
            <div style="padding: 15px 20px; background: linear-gradient(135deg, rgba(16, 185, 129, 0.1), rgba(16, 185, 129, 0.15)); 
                 color: var(--success); border-radius: 8px; margin-bottom: 20px; border: 1px solid rgba(16, 185, 129, 0.2); 
                 display: flex; align-items: center; gap: 12px;">
                <i class="fas fa-check-circle"></i>
                ${msg}
            </div>
        </c:if>
        
        <c:if test="${not empty errorMsg}">
            <div style="padding: 15px 20px; background: linear-gradient(135deg, rgba(239, 68, 68, 0.1), rgba(239, 68, 68, 0.15)); 
                 color: var(--danger); border-radius: 8px; margin-bottom: 20px; border: 1px solid rgba(239, 68, 68, 0.2); 
                 display: flex; align-items: center; gap: 12px;">
                <i class="fas fa-exclamation-circle"></i>
                ${errorMsg}
            </div>
        </c:if>

        <!-- REPORTS DASHBOARD -->
        <div class="reports-dashboard">
            <a href="javascript:void(0)" onclick="showAppointmentReport()" class="report-card">
                <div class="report-icon" style="background: linear-gradient(135deg, var(--primary), var(--primary-light));">
                    <i class="fas fa-calendar-alt"></i>
                </div>
                <div class="report-info">
                    <h3>Appointments Report</h3>
                    <p>View detailed reports on appointments, cancellations, and patient visits over time.</p>
                    <div style="color: var(--primary); font-weight: 600; font-size: 0.9rem;">
                        <i class="fas fa-arrow-right"></i> View Report
                    </div>
                </div>
            </a>
            
            <a href="javascript:void(0)" onclick="showPatientReport()" class="report-card">
                <div class="report-icon" style="background: linear-gradient(135deg, var(--success), #34d399);">
                    <i class="fas fa-user-injured"></i>
                </div>
                <div class="report-info">
                    <h3>Patients Report</h3>
                    <p>Analyze patient demographics, visit patterns, and health statistics.</p>
                    <div style="color: var(--success); font-weight: 600; font-size: 0.9rem;">
                        <i class="fas fa-arrow-right"></i> View Report
                    </div>
                </div>
            </a>
            
            <a href="javascript:void(0)" onclick="showEarningsReport()" class="report-card">
                <div class="report-icon" style="background: linear-gradient(135deg, var(--warning), #fbbf24);">
                    <i class="fas fa-money-bill-wave"></i>
                </div>
                <div class="report-info">
                    <h3>Earnings Report</h3>
                    <p>Track your earnings, consultation fees, and financial performance.</p>
                    <div style="color: var(--warning); font-weight: 600; font-size: 0.9rem;">
                        <i class="fas fa-arrow-right"></i> View Report
                    </div>
                </div>
            </a>
            
            <a href="javascript:void(0)" onclick="showPrescriptionReport()" class="report-card">
                <div class="report-icon" style="background: linear-gradient(135deg, var(--info), #22d3ee);">
                    <i class="fas fa-prescription"></i>
                </div>
                <div class="report-info">
                    <h3>Prescriptions Report</h3>
                    <p>View medication statistics and prescription patterns.</p>
                    <div style="color: var(--info); font-weight: 600; font-size: 0.9rem;">
                        <i class="fas fa-arrow-right"></i> View Report
                    </div>
                </div>
            </a>
        </div>

        <!-- FILTER SECTION -->
        <div class="filter-section" id="filterSection" style="display: none;">
            <h2 class="filter-title"><i class="fas fa-filter"></i> Filter Report</h2>
            <div class="filter-grid">
                <div class="filter-group">
                    <label class="filter-label">Date Range</label>
                    <div style="display: flex; gap: 10px;">
                        <input type="date" id="dateFrom" class="filter-input" style="flex: 1;">
                        <span style="display: flex; align-items: center;">to</span>
                        <input type="date" id="dateTo" class="filter-input" style="flex: 1;">
                    </div>
                </div>
                
                <div class="filter-group">
                    <label class="filter-label">Report Type</label>
                    <select id="reportType" class="filter-select">
                        <option value="daily">Daily Report</option>
                        <option value="weekly">Weekly Report</option>
                        <option value="monthly">Monthly Report</option>
                        <option value="yearly">Yearly Report</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label class="filter-label">Status Filter</label>
                    <select id="statusFilter" class="filter-select">
                        <option value="all">All Status</option>
                        <option value="confirmed">Confirmed Only</option>
                        <option value="pending">Pending Only</option>
                        <option value="cancelled">Cancelled Only</option>
                    </select>
                </div>
                
                <div class="filter-group" style="align-self: flex-end;">
                    <button onclick="applyFilters()" class="action-btn" style="width: 100%;">
                        <i class="fas fa-chart-bar"></i>
                        Generate Report
                    </button>
                </div>
            </div>
        </div>

        <!-- REPORT CONTENT AREA -->
        <div class="report-content" id="reportContent" style="display: none;">
            <div class="report-header">
                <h2><i class="fas fa-file-alt"></i> <span id="reportTitle">Appointments Report</span></h2>
                <div class="print-options">
                    <button onclick="printReport()" class="print-btn">
                        <i class="fas fa-print"></i>
                        Print Report
                    </button>
                    <button onclick="downloadPDF()" class="print-btn">
                        <i class="fas fa-file-pdf"></i>
                        Download PDF
                    </button>
                    <button onclick="downloadExcel()" class="print-btn">
                        <i class="fas fa-file-excel"></i>
                        Download Excel
                    </button>
                </div>
            </div>

            <!-- REPORT STATS -->
            <div class="stats-grid" id="reportStats">
                <!-- Stats will be populated by JavaScript -->
            </div>

            <!-- CHART AREA -->
            <div class="chart-container">
                <div class="chart-placeholder" id="chartPlaceholder">
                    <i class="fas fa-chart-bar"></i>
                    <h4>Report Chart</h4>
                    <p>Select a report type and apply filters to view the chart</p>
                </div>
                <canvas id="reportChart" style="width: 100%; height: 300px; display: none;"></canvas>
            </div>

            <!-- REPORT TABLE -->
            <div class="table-container">
                <table class="data-table" id="reportTable">
                    <thead>
                        <tr id="tableHeader">
                            <!-- Table headers will be populated by JavaScript -->
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                        <!-- Table data will be populated by JavaScript -->
                    </tbody>
                </table>
            </div>

            <!-- REPORT SUMMARY -->
            <div class="filter-section" id="reportSummary" style="display: none;">
                <h2 class="filter-title"><i class="fas fa-chart-pie"></i> Report Summary</h2>
                <div id="summaryContent">
                    <!-- Summary will be populated by JavaScript -->
                </div>
            </div>
        </div>

        <!-- QUICK STATS -->
        <div class="stats-grid">
            <div class="stat-box">
                <div class="stat-title">Total Appointments</div>
                <div class="stat-value">${totalAppointments}</div>
                <div class="stat-change stat-positive">
                    <i class="fas fa-arrow-up"></i> 12% from last month
                </div>
            </div>
            
            <div class="stat-box">
                <div class="stat-title">Patient Satisfaction</div>
                <div class="stat-value">94%</div>
                <div class="stat-change stat-positive">
                    <i class="fas fa-arrow-up"></i> 5% from last month
                </div>
            </div>
            
            <div class="stat-box">
                <div class="stat-title">Avg. Consultation Time</div>
                <div class="stat-value">24 min</div>
                <div class="stat-change stat-negative">
                    <i class="fas fa-arrow-down"></i> 2 min from last month
                </div>
            </div>
            
            <div class="stat-box">
                <div class="stat-title">Cancellation Rate</div>
                <div class="stat-value">8%</div>
                <div class="stat-change stat-positive">
                    <i class="fas fa-arrow-down"></i> 3% from last month
                </div>
            </div>
        </div>

        <!-- RECENT ACTIVITY -->
        <div class="report-content">
            <div class="report-header">
                <h2><i class="fas fa-history"></i> Recent Activity</h2>
            </div>
            
            <div class="table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Date & Time</th>
                            <th>Activity</th>
                            <th>Patient</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Today, 10:30 AM</td>
                            <td>Appointment Scheduled</td>
                            <td>Rajesh Kumar</td>
                            <td><span style="color: var(--success); font-weight: 600;">Confirmed</span></td>
                        </tr>
                        <tr>
                            <td>Yesterday, 2:15 PM</td>
                            <td>Prescription Issued</td>
                            <td>Priya Sharma</td>
                            <td><span style="color: var(--primary); font-weight: 600;">Completed</span></td>
                        </tr>
                        <tr>
                            <td>Dec 12, 11:00 AM</td>
                            <td>Appointment Cancelled</td>
                            <td>Amit Patel</td>
                            <td><span style="color: var(--danger); font-weight: 600;">Cancelled</span></td>
                        </tr>
                        <tr>
                            <td>Dec 11, 4:45 PM</td>
                            <td>Follow-up Scheduled</td>
                            <td>Sunita Singh</td>
                            <td><span style="color: var(--warning); font-weight: 600;">Pending</span></td>
                        </tr>
                        <tr>
                            <td>Dec 10, 9:30 AM</td>
                            <td>New Patient Registered</td>
                            <td>Vikram Joshi</td>
                            <td><span style="color: var(--success); font-weight: 600;">Active</span></td>
                        </tr>
                    </tbody>
                </table>
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
    // Sample report data
    const reportData = {
        appointments: {
            title: "Appointments Report",
            stats: [
                { title: "Total Appointments", value: "156", change: "+12%", positive: true },
                { title: "Confirmed", value: "128", change: "+8%", positive: true },
                { title: "Pending", value: "18", change: "-3%", positive: false },
                { title: "Cancelled", value: "10", change: "-2%", positive: true }
            ],
            chartLabels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
            chartData: [25, 28, 30, 32, 35, 40],
            tableHeaders: ["Date", "Patient", "Time", "Reason", "Status"],
            tableRows: [
                ["2023-12-15", "Rajesh Kumar", "10:30 AM", "Routine Checkup", "Confirmed"],
                ["2023-12-14", "Priya Sharma", "2:15 PM", "Follow-up", "Completed"],
                ["2023-12-13", "Amit Patel", "11:00 AM", "Consultation", "Cancelled"],
                ["2023-12-12", "Sunita Singh", "4:45 PM", "New Patient", "Pending"],
                ["2023-12-11", "Vikram Joshi", "9:30 AM", "Emergency", "Confirmed"]
            ],
            summary: "Appointments have increased by 12% compared to last month. The cancellation rate has improved by 3%."
        },
        patients: {
            title: "Patients Report",
            stats: [
                { title: "Total Patients", value: "89", change: "+15%", positive: true },
                { title: "New Patients", value: "24", change: "+8%", positive: true },
                { title: "Regular Patients", value: "65", change: "+12%", positive: true },
                { title: "Avg. Age", value: "42", change: "0%", positive: null }
            ],
            chartLabels: ["<30", "30-40", "40-50", "50-60", "60+"],
            chartData: [15, 25, 30, 15, 4],
            tableHeaders: ["Patient ID", "Name", "Age", "Gender", "Last Visit"],
            tableRows: [
                ["P001", "Rajesh Kumar", "45", "Male", "2023-12-15"],
                ["P002", "Priya Sharma", "32", "Female", "2023-12-14"],
                ["P003", "Amit Patel", "58", "Male", "2023-12-13"],
                ["P004", "Sunita Singh", "29", "Female", "2023-12-12"],
                ["P005", "Vikram Joshi", "65", "Male", "2023-12-11"]
            ],
            summary: "Patient base has grown by 15% this month. The majority of patients are in the 40-50 age group."
        },
        earnings: {
            title: "Earnings Report",
            stats: [
                { title: "Total Earnings", value: "₹85,400", change: "+18%", positive: true },
                { title: "Avg. per Appointment", value: "₹1,200", change: "+5%", positive: true },
                { title: "Consultation Fees", value: "₹72,000", change: "+15%", positive: true },
                { title: "Other Income", value: "₹13,400", change: "+25%", positive: true }
            ],
            chartLabels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
            chartData: [45000, 52000, 58000, 62000, 70000, 85400],
            tableHeaders: ["Date", "Appointment", "Patient", "Service", "Amount"],
            tableRows: [
                ["2023-12-15", "A001", "Rajesh Kumar", "Consultation", "₹1,500"],
                ["2023-12-14", "A002", "Priya Sharma", "Follow-up", "₹1,000"],
                ["2023-12-13", "A003", "Amit Patel", "Procedure", "₹5,000"],
                ["2023-12-12", "A004", "Sunita Singh", "Consultation", "₹1,500"],
                ["2023-12-11", "A005", "Vikram Joshi", "Emergency", "₹2,500"]
            ],
            summary: "Total earnings have increased by 18% this month. The average consultation fee has risen by 5%."
        },
        prescriptions: {
            title: "Prescriptions Report",
            stats: [
                { title: "Total Prescriptions", value: "68", change: "+10%", positive: true },
                { title: "Medications", value: "42", change: "+8%", positive: true },
                { title: "Lab Tests", value: "26", change: "+12%", positive: true },
                { title: "Avg. Items", value: "3.2", change: "+0.2", positive: true }
            ],
            chartLabels: ["Antibiotics", "Painkillers", "Vitamins", "Other"],
            chartData: [25, 35, 20, 20],
            tableHeaders: ["Prescription ID", "Date", "Patient", "Items", "Status"],
            tableRows: [
                ["RX001", "2023-12-15", "Rajesh Kumar", "3", "Issued"],
                ["RX002", "2023-12-14", "Priya Sharma", "2", "Completed"],
                ["RX003", "2023-12-13", "Amit Patel", "4", "Issued"],
                ["RX004", "2023-12-12", "Sunita Singh", "3", "Pending"],
                ["RX005", "2023-12-11", "Vikram Joshi", "5", "Issued"]
            ],
            summary: "Prescription volume has increased by 10%. Painkillers are the most prescribed medications."
        }
    };

    let currentChart = null;

    // Show filter section
    function showFilterSection() {
        document.getElementById('filterSection').style.display = 'block';
        document.getElementById('reportContent').style.display = 'block';
        
        // Set default dates
        const today = new Date();
        const lastMonth = new Date();
        lastMonth.setMonth(lastMonth.getMonth() - 1);
        
        document.getElementById('dateFrom').value = lastMonth.toISOString().split('T')[0];
        document.getElementById('dateTo').value = today.toISOString().split('T')[0];
        
        // Scroll to report
        document.getElementById('reportContent').scrollIntoView({ behavior: 'smooth' });
    }

    // Show appointment report
    function showAppointmentReport() {
        showFilterSection();
        loadReport('appointments');
    }

    // Show patient report
    function showPatientReport() {
        showFilterSection();
        loadReport('patients');
    }

    // Show earnings report
    function showEarningsReport() {
        showFilterSection();
        loadReport('earnings');
    }

    // Show prescription report
    function showPrescriptionReport() {
        showFilterSection();
        loadReport('prescriptions');
    }

    // Load report data
    function loadReport(reportType) {
        const report = reportData[reportType];
        
        // Set title
        document.getElementById('reportTitle').textContent = report.title;
        
        // Load stats
        const statsContainer = document.getElementById('reportStats');
        statsContainer.innerHTML = '';
        
        report.stats.forEach(stat => {
            const statBox = document.createElement('div');
            statBox.className = 'stat-box';
            
            let changeHtml = '';
            if (stat.change !== '0%' && stat.change !== '0') {
                const icon = stat.positive === true ? 'fa-arrow-up' : 
                            stat.positive === false ? 'fa-arrow-down' : 'fa-minus';
                const colorClass = stat.positive === true ? 'stat-positive' : 
                                 stat.positive === false ? 'stat-negative' : '';
                changeHtml = `<div class="stat-change ${colorClass}">
                    <i class="fas ${icon}"></i> ${stat.change} from last month
                </div>`;
            }
            
            statBox.innerHTML = `
                <div class="stat-title">${stat.title}</div>
                <div class="stat-value">${stat.value}</div>
                ${changeHtml}
            `;
            
            statsContainer.appendChild(statBox);
        });
        
        // Load chart
        renderChart(report.chartLabels, report.chartData, report.title);
        
        // Load table
        const tableHeader = document.getElementById('tableHeader');
        const tableBody = document.getElementById('tableBody');
        
        tableHeader.innerHTML = '';
        tableBody.innerHTML = '';
        
        // Add headers
        report.tableHeaders.forEach(header => {
            const th = document.createElement('th');
            th.textContent = header;
            tableHeader.appendChild(th);
        });
        
        // Add rows
        report.tableRows.forEach(row => {
            const tr = document.createElement('tr');
            row.forEach(cell => {
                const td = document.createElement('td');
                td.textContent = cell;
                tr.appendChild(td);
            });
            tableBody.appendChild(tr);
        });
        
        // Load summary
        const summaryContent = document.getElementById('summaryContent');
        summaryContent.innerHTML = `
            <p style="font-size: 1rem; line-height: 1.6; color: var(--text-dark);">
                ${report.summary}
            </p>
            <div style="margin-top: 15px; padding: 15px; background: linear-gradient(135deg, #f0f9ff, #e0f2fe); 
                 border-radius: 8px; border: 1px solid rgba(37, 99, 235, 0.2);">
                <h4 style="font-size: 1rem; margin-bottom: 10px; color: var(--primary);">
                    <i class="fas fa-lightbulb"></i> Recommendations:
                </h4>
                <ul style="color: var(--text-dark); padding-left: 20px;">
                    <li>Continue current patient engagement strategies</li>
                    <li>Consider expanding appointment slots during peak hours</li>
                    <li>Review cancellation patterns to optimize scheduling</li>
                </ul>
            </div>
        `;
        
        document.getElementById('reportSummary').style.display = 'block';
    }

    // Render chart
    function renderChart(labels, data, title) {
        const chartPlaceholder = document.getElementById('chartPlaceholder');
        const chartCanvas = document.getElementById('reportChart');
        
        chartPlaceholder.style.display = 'none';
        chartCanvas.style.display = 'block';
        
        // Destroy existing chart
        if (currentChart) {
            currentChart.destroy();
        }
        
        // Create new chart
        const ctx = chartCanvas.getContext('2d');
        currentChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: title,
                    data: data,
                    backgroundColor: 'rgba(37, 99, 235, 0.5)',
                    borderColor: 'rgba(37, 99, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    title: {
                        display: true,
                        text: title,
                        font: {
                            size: 16,
                            weight: 'bold'
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Count'
                        }
                    },
                    x: {
                        title: {
                            display: true,
                            text: 'Categories'
                        }
                    }
                }
            }
        });
    }

    // Apply filters
    function applyFilters() {
        const dateFrom = document.getElementById('dateFrom').value;
        const dateTo = document.getElementById('dateTo').value;
        const reportType = document.getElementById('reportType').value;
        const statusFilter = document.getElementById('statusFilter').value;
        
        if (!dateFrom || !dateTo) {
            alert('Please select date range');
            return;
        }
        
        // Show loading
        const chartPlaceholder = document.getElementById('chartPlaceholder');
        chartPlaceholder.innerHTML = `
            <i class="fas fa-spinner fa-spin"></i>
            <h4>Generating Report...</h4>
            <p>Applying filters and generating report for ${dateFrom} to ${dateTo}</p>
        `;
        chartPlaceholder.style.display = 'block';
        document.getElementById('reportChart').style.display = 'none';
        
        // Simulate API call delay
        setTimeout(() => {
            // Reload current report with filters applied
            const currentReport = document.getElementById('reportTitle').textContent.toLowerCase();
            if (currentReport.includes('appointment')) {
                loadReport('appointments');
            } else if (currentReport.includes('patient')) {
                loadReport('patients');
            } else if (currentReport.includes('earning')) {
                loadReport('earnings');
            } else if (currentReport.includes('prescription')) {
                loadReport('prescriptions');
            }
            
            // Show success message
            showToast('Report generated successfully with applied filters');
        }, 1000);
    }

    // Print report
    function printReport() {
        window.print();
    }

    // Download PDF
    function downloadPDF() {
        showToast('PDF report download started');
        // In real implementation, this would generate and download a PDF
        setTimeout(() => {
            showToast('PDF report downloaded successfully');
        }, 2000);
    }

    // Download Excel
    function downloadExcel() {
        showToast('Excel report download started');
        // In real implementation, this would generate and download an Excel file
        setTimeout(() => {
            showToast('Excel report downloaded successfully');
        }, 2000);
    }

    // Show toast message
    function showToast(message) {
        // Remove existing toast
        const existingToast = document.querySelector('.toast');
        if (existingToast) {
            existingToast.remove();
        }
        
        // Create new toast
        const toast = document.createElement('div');
        toast.className = 'toast';
        toast.style.cssText = `
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: var(--success);
            color: white;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: var(--shadow-lg);
            z-index: 1000;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: slideIn 0.3s ease;
        `;
        
        toast.innerHTML = `
            <i class="fas fa-check-circle"></i>
            <span>${message}</span>
        `;
        
        document.body.appendChild(toast);
        
        // Remove toast after 3 seconds
        setTimeout(() => {
            toast.style.animation = 'slideOut 0.3s ease';
            setTimeout(() => {
                toast.remove();
            }, 300);
        }, 3000);
    }

    // Add CSS animations
    const style = document.createElement('style');
    style.textContent = `
        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
        
        @keyframes slideOut {
            from {
                transform: translateX(0);
                opacity: 1;
            }
            to {
                transform: translateX(100%);
                opacity: 0;
            }
        }
    `;
    document.head.appendChild(style);

    // Initialize date inputs
    document.addEventListener('DOMContentLoaded', function() {
        const today = new Date();
        const lastMonth = new Date();
        lastMonth.setMonth(lastMonth.getMonth() - 1);
        
        document.getElementById('dateFrom')?.value = lastMonth.toISOString().split('T')[0];
        document.getElementById('dateTo')?.value = today.toISOString().split('T')[0];
        
        // Auto-dismiss alerts
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert, [style*="background: linear-gradient"]');
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

<!-- Include Chart.js library -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</body>
</html>