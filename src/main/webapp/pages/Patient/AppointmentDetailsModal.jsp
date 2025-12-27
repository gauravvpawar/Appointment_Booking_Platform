<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Appointment Details</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    .modal-overlay {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: rgba(0, 0, 0, 0.5);
        display: flex;
        justify-content: center;
        align-items: center;
        z-index: 1000;
        animation: fadeIn 0.3s ease;
    }

    .modal-content {
        background: white;
        border-radius: 12px;
        width: 90%;
        max-width: 600px;
        max-height: 90vh;
        overflow-y: auto;
        animation: slideIn 0.3s ease;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
    }

    .modal-header {
        padding: 20px 30px;
        border-bottom: 1px solid #e2e8f0;
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: linear-gradient(135deg, #2563eb, #3b82f6);
        color: white;
        border-radius: 12px 12px 0 0;
    }

    .modal-header h2 {
        font-size: 1.5rem;
        font-weight: 600;
        margin: 0;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .close-btn {
        background: rgba(255, 255, 255, 0.2);
        border: none;
        color: white;
        width: 36px;
        height: 36px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        font-size: 1.2rem;
        transition: all 0.3s ease;
    }

    .close-btn:hover {
        background: rgba(255, 255, 255, 0.3);
        transform: rotate(90deg);
    }

    .modal-body {
        padding: 30px;
    }

    .info-section {
        margin-bottom: 25px;
    }

    .info-section h3 {
        font-size: 1.1rem;
        font-weight: 600;
        color: #1e293b;
        margin-bottom: 15px;
        padding-bottom: 10px;
        border-bottom: 2px solid #e2e8f0;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 15px;
    }

    .info-item {
        display: flex;
        flex-direction: column;
        gap: 5px;
    }

    .info-label {
        font-size: 0.85rem;
        font-weight: 600;
        color: #64748b;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .info-value {
        font-size: 1rem;
        font-weight: 500;
        color: #1e293b;
        padding: 10px;
        background: #f8fafc;
        border-radius: 6px;
        border: 1px solid #e2e8f0;
    }

    .status-badge {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 0.9rem;
        font-weight: 600;
        margin: 10px 0;
    }

    .status-pending {
        background: linear-gradient(135deg, rgba(245, 158, 11, 0.15), rgba(245, 158, 11, 0.2));
        color: #f59e0b;
    }

    .status-confirmed {
        background: linear-gradient(135deg, rgba(37, 99, 235, 0.15), rgba(37, 99, 235, 0.2));
        color: #2563eb;
    }

    .status-cancelled {
        background: linear-gradient(135deg, rgba(239, 68, 68, 0.15), rgba(239, 68, 68, 0.2));
        color: #ef4444;
    }

    .status-rejected {
        background: linear-gradient(135deg, rgba(120, 120, 120, 0.15), rgba(120, 120, 120, 0.2));
        color: #64748b;
    }

    .modal-footer {
        padding: 20px 30px;
        border-top: 1px solid #e2e8f0;
        display: flex;
        justify-content: flex-end;
        gap: 15px;
        background: #f8fafc;
        border-radius: 0 0 12px 12px;
    }

    .action-btn {
        padding: 10px 20px;
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

    .btn-close {
        background: #e2e8f0;
        color: #64748b;
    }

    .btn-close:hover {
        background: #cbd5e1;
        transform: translateY(-2px);
    }

    .btn-cancel {
        background: linear-gradient(135deg, #f59e0b, #fbbf24);
        color: white;
    }

    .btn-cancel:hover {
        background: linear-gradient(135deg, #d97706, #f59e0b);
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(245, 158, 11, 0.3);
    }

    .reason-box {
        background: #f8fafc;
        border: 1px solid #e2e8f0;
        border-radius: 8px;
        padding: 15px;
        margin-top: 10px;
        font-size: 0.95rem;
        line-height: 1.5;
        color: #1e293b;
        min-height: 80px;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
        }
        to {
            opacity: 1;
        }
    }

    @keyframes slideIn {
        from {
            transform: translateY(-30px);
            opacity: 0;
        }
        to {
            transform: translateY(0);
            opacity: 1;
        }
    }

    /* Doctor info styling */
    .doctor-info-card {
        background: linear-gradient(135deg, #f0f9ff, #e0f2fe);
        border-radius: 10px;
        padding: 20px;
        margin-top: 15px;
        border: 1px solid rgba(37, 99, 235, 0.2);
    }

    .doctor-info-header {
        display: flex;
        align-items: center;
        gap: 15px;
        margin-bottom: 15px;
    }

    .doctor-avatar {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        background: linear-gradient(135deg, #2563eb, #3b82f6);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: 600;
        font-size: 1.2rem;
    }

    .doctor-name {
        font-size: 1.2rem;
        font-weight: 600;
        color: #1e293b;
        margin-bottom: 5px;
    }

    .doctor-specialization {
        font-size: 0.9rem;
        color: #64748b;
        font-weight: 500;
    }

    /* Alert messages */
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
        color: #10b981;
        border: 1px solid rgba(16, 185, 129, 0.2);
    }

    .alert-error {
        background: linear-gradient(135deg, rgba(239, 68, 68, 0.1), rgba(239, 68, 68, 0.15));
        color: #ef4444;
        border: 1px solid rgba(239, 68, 68, 0.2);
    }
</style>
</head>
<body>

<c:if test="${not empty appointment && not empty patient && not empty doctor}">
    <div class="modal-overlay">
        <div class="modal-content">
            <!-- MODAL HEADER -->
            <div class="modal-header">
                <h2><i class="fas fa-calendar-check"></i> Appointment Details</h2>
                <button class="close-btn" onclick="closeModal(${patient.id})">
                    <i class="fas fa-times"></i>
                </button>
            </div>

            <!-- MODAL BODY -->
            <div class="modal-body">
                <!-- Appointment ID & Status -->
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                    <div>
                        <span style="font-size: 0.9rem; color: #64748b; font-weight: 500;">Appointment ID:</span>
                        <span style="font-size: 1.1rem; font-weight: 700; color: #1e293b; margin-left: 8px;">
                            #${appointment.appt_id}
                        </span>
                    </div>
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

                <!-- Appointment Details -->
                <div class="info-section">
                    <h3><i class="fas fa-info-circle"></i> Appointment Information</h3>
                    <div class="info-grid">
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
                        
                        <c:if test="${not empty appointment.createdAt}">
                            <div class="info-item">
                                <span class="info-label">Booked On</span>
                                <span class="info-value">
                                    <i class="fas fa-calendar-plus"></i> 
                                    <fmt:formatDate value="${appointment.createdAt}" pattern="dd MMM yyyy, hh:mm a" />
                                </span>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Reason for Appointment -->
                <div class="info-section">
                    <h3><i class="fas fa-stethoscope"></i> Reason for Appointment</h3>
                    <div class="reason-box">
                        <c:choose>
                            <c:when test="${not empty appointment.reason}">
                                ${appointment.reason}
                            </c:when>
                            <c:otherwise>
                                <span style="color: #94a3b8; font-style: italic;">No reason specified</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Doctor Information -->
                <div class="info-section">
                    <h3><i class="fas fa-user-md"></i> Doctor Information</h3>
                    <div class="doctor-info-card">
                        <div class="doctor-info-header">
                            <div class="doctor-avatar">
                                ${doctor.name.charAt(0)}
                            </div>
                            <div>
                                <div class="doctor-name">Dr. ${doctor.name}</div>
                                <div class="doctor-specialization">${doctor.specialization}</div>
                            </div>
                        </div>
                        
                        <div class="info-grid">
                            <div class="info-item">
                                <span class="info-label">Qualification</span>
                                <span class="info-value">${doctor.qualification}</span>
                            </div>
                            
                            <div class="info-item">
                                <span class="info-label">Experience</span>
                                <span class="info-value">${doctor.experience} years</span>
                            </div>
                            
                            <div class="info-item">
                                <span class="info-label">Phone</span>
                                <span class="info-value">${doctor.phone}</span>
                            </div>
                            
                            <div class="info-item">
                                <span class="info-label">Email</span>
                                <span class="info-value">${doctor.email}</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Patient Information (Brief) -->
                <div class="info-section">
                    <h3><i class="fas fa-user"></i> Your Information</h3>
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
                            <span class="info-label">Phone</span>
                            <span class="info-value">${patient.phone}</span>
                        </div>
                    </div>
                </div>

                <!-- Important Notes -->
                <div style="background: linear-gradient(135deg, rgba(245, 158, 11, 0.1), rgba(245, 158, 11, 0.15)); 
                     border: 1px solid rgba(245, 158, 11, 0.2); border-radius: 8px; padding: 15px; margin-top: 20px;">
                    <h4 style="color: #f59e0b; margin-bottom: 10px; display: flex; align-items: center; gap: 8px;">
                        <i class="fas fa-exclamation-circle"></i> Important Notes
                    </h4>
                    <ul style="color: #92400e; padding-left: 20px; font-size: 0.9rem; line-height: 1.5;">
                        <li>Arrive 15 minutes before your scheduled appointment time</li>
                        <li>Bring your previous medical reports if any</li>
                        <li>Consultation may be rescheduled in case of doctor's emergency</li>
                        <li>Cancellation is possible up to 2 hours before the appointment</li>
                    </ul>
                </div>
            </div>

            <!-- MODAL FOOTER -->
            <div class="modal-footer">
                
                
                <a href="/patient/DashBoard/${patient.id}" 
					   class="action-btn btn-close">
					    <i class="fas fa-times"></i> Close
					</a>
					                
                <c:if test="${appointment.appointment_status == 'Pending' || appointment.appointment_status == 'Confirmed'}">
                    <form action="${pageContext.request.contextPath}/patient/CancelAppointment/${patient.id}/${appointment.appt_id}" 
                          method="post" onsubmit="return confirmCancel()" style="display: inline;">
                        <button type="submit" class="action-btn btn-cancel">
                            <i class="fas fa-ban"></i> Cancel Appointment
                        </button>
                    </form>
                </c:if>
            </div>
        </div>
    </div>

    <script>
    	function closeModal( id)
    	{
    		// Close modal and redirect to dashboard
    	    window.location.href = '${pageContext.request.contextPath}/patient/DashBoard/'+id;
    	}
    	
    
        function confirmCancel() {
            return confirm('Are you sure you want to cancel this appointment? This action cannot be undone.');
        }
        
        // Close modal on Escape key
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                closeModal();
            }
        });
        
        // Close modal when clicking outside
        document.querySelector('.modal-overlay').addEventListener('click', function(e) {
            if (e.target === this) {
                closeModal();
            }
        });
    </script>
</c:if>

<c:if test="${empty appointment || empty patient || empty doctor}">
    <div class="modal-overlay">
        <div class="modal-content">
            <div class="modal-header">
                <h2><i class="fas fa-exclamation-triangle"></i> Error</h2>
                <button class="close-btn" onclick="closeModal()">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="modal-body">
                <div style="text-align: center; padding: 40px 20px;">
                    <i class="fas fa-calendar-times" style="font-size: 3rem; color: #ef4444; margin-bottom: 20px;"></i>
                    <h3 style="color: #1e293b; margin-bottom: 10px;">Appointment Not Found</h3>
                    <p style="color: #64748b; margin-bottom: 25px;">The requested appointment details could not be found or you don't have permission to view them.</p>
                    <button class="action-btn btn-close" onclick="closeModal()" style="margin: 0 auto;">
                        <i class="fas fa-arrow-left"></i> Go Back
                    </button>
                </div>
            </div>
        </div>
    </div>
</c:if>

</body>
</html>