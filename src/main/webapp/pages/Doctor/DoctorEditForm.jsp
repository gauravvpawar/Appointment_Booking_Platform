
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
    <%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doctor Edit Form</title>
</head>

<style>
    * {
        box-sizing: border-box;
    }

    body {
        font-family: 'Segoe UI', Arial, sans-serif;
        background: linear-gradient(135deg, #e6ecf3, #f5f7fb);
        margin: 0;
        padding: 20px;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
    }
    
    .back-btn {
    position: absolute;
    top: 20px;
    left: 20px;
    text-decoration: none;
    font-size: 14px;
    font-weight: 600;
    color: #2563eb;
    background: #eef2ff;
    padding: 6px 12px;
    border-radius: 8px;
    transition: all 0.25s ease;
}

.back-btn:hover {
    background: #2563eb;
    color: #ffffff;
}
    

    .registration-container {
     position: relative;
        width: 100%;
        max-width: 450px;
        background: #ffffff;
        padding: 25px 30px;
        border-radius: 14px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        max-height: 90vh;
        overflow-y: auto;
    }

    h2 {
        text-align: center;
        margin-bottom: 20px;
        font-size: 24px;
        color: #1f2937;
        font-weight: 600;
    }

    label {
        font-size: 13px;
        font-weight: 600;
        margin-bottom: 5px;
        color: #374151;
        display: block;
    }

    input,
    select {
        width: 100%;
        padding: 9px 12px;
        margin-bottom: 14px;
        border: 1px solid #d1d5db;
        border-radius: 8px;
        font-size: 14px;
        background: #f9fafb;
        transition: all 0.25s ease;
    }

    input:focus,
    select:focus {
        outline: none;
        border-color: #2563eb;
        background: #fff;
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
    }

    input[readonly] {
        background: #eef2f7;
        cursor: not-allowed;
    }

    input[type="file"] {
        padding: 6px;
        background: #fff;
    }

    button {
        width: 100%;
        padding: 12px;
        background: linear-gradient(135deg, #2563eb, #1d4ed8);
        border: none;
        color: #fff;
        font-size: 15px;
        font-weight: 600;
        border-radius: 10px;
        cursor: pointer;
        transition: all 0.3s ease;
        margin-top: 10px;
    }

    button:hover {
        background: linear-gradient(135deg, #1d4ed8, #1e40af);
        transform: translateY(-1px);
    }

    button:active {
        transform: translateY(0);
    }

    /* Scrollbar styling */
    .registration-container::-webkit-scrollbar {
        width: 6px;
    }

    .registration-container::-webkit-scrollbar-thumb {
        background: #c7d2fe;
        border-radius: 10px;
    }

    .registration-container::-webkit-scrollbar-track {
        background: transparent;
    }

    @media (max-width: 480px) {
        .registration-container {
            padding: 20px;
        }
    }
    
    .doc-image {
    width: 140px;
    height: 140px;
    object-fit: cover;
    border-radius: 10px;
	border: 1px solid #d1d5db;
	margin-bottom: 10px;
	}
	.file-hint {
	    font-size: 12px;
	    color: #6b7280;
	    margin-bottom: 6px;
	}
    
</style>


<body>

<a href="/doctor/dashboard/${doctor.did}" class="back-btn">← Back</a>


<div class="registration-container">
    <h2>Doctor Update Data</h2>

    <form action="/doctor/doctorUpdateData/${doctor.did}" method="post" enctype="multipart/form-data">

    <label>Full Name:</label>
    <input type="text" name="name" value="${doctor.name}" required>

    <label>Email:</label>
    <input type="email" name="email" value="${doctor.email}" readonly required>

    <label>Password:</label>
    <input type="text" name="password" placeholder="Enter new Password">

    <label>Confirm Password:</label>
    <input type="text" name="cnfPassword" placeholder="Confirm new Password">

    <label>Phone:</label>
    <input type="text" name="phone" value="${doctor.phone}" required>

		<label>Date of Birth:</label>
		<input type="date" name="doctorInfo.dob" 
	      value="${doctor.doctorInfo.dob != null ? doctor.doctorInfo.dob : ''}" required>

    <label>Gender:</label>
    <select name="gender" required>
        <option value="Male" ${doctor.gender == 'Male' ? 'selected' : ''}>Male</option>
        <option value="Female" ${doctor.gender == 'Female' ? 'selected' : ''}>Female</option>
        <option value="Other" ${doctor.gender == 'Other' ? 'selected' : ''}>Other</option>
    </select>

    <label>Address:</label>
    <input type="text" name="doctorInfo.address" value="${doctor.doctorInfo.address}" required>

    <label>Blood Group:</label>
    <select name="doctorInfo.bloodGroup" required>
        <option value="A+" ${doctor.doctorInfo.bloodGroup == 'A+' ? 'selected' : ''}>A+</option>
        <option value="A-" ${doctor.doctorInfo.bloodGroup == 'A-' ? 'selected' : ''}>A-</option>
        <option value="B+" ${doctor.doctorInfo.bloodGroup == 'B+' ? 'selected' : ''}>B+</option>
        <option value="B-" ${doctor.doctorInfo.bloodGroup == 'B-' ? 'selected' : ''}>B-</option>
        <option value="O+" ${doctor.doctorInfo.bloodGroup == 'O+' ? 'selected' : ''}>O+</option>
        <option value="O-" ${doctor.doctorInfo.bloodGroup == 'O-' ? 'selected' : ''}>O-</option>
        <option value="AB+" ${doctor.doctorInfo.bloodGroup == 'AB+' ? 'selected' : ''}>AB+</option>
        <option value="AB-" ${doctor.doctorInfo.bloodGroup == 'AB-' ? 'selected' : ''}>AB-</option>
    </select>

    <label>Emergency Contact:</label>
    <input type="text" name="doctorInfo.emergencyContact" value="${doctor.doctorInfo.emergencyContact}" >

    <label>Specialization:</label>
    <select name="specialization" required>
        <option value="Cardiologist" ${doctor.specialization == 'Cardiologist' ? 'selected' : ''}>Cardiologist</option>
        <option value="Dentist" ${doctor.specialization == 'Dentist' ? 'selected' : ''}>Dentist</option>
        <option value="Neurologist" ${doctor.specialization == 'Neurologist' ? 'selected' : ''}>Neurologist</option>
        <option value="General Physician" ${doctor.specialization == 'General Physician' ? 'selected' : ''}>General Physician</option>
        <option value="Dermatologist" ${doctor.specialization == 'Dermatologist' ? 'selected' : ''}>Dermatologist</option>
    </select>

    <label>Qualification:</label>
    <input type="text" name="qualification" value="${doctor.qualification}" required>

    <label>Experience (years):</label>
    <input type="number" name="experience" value="${doctor.experience}" min="0">

    <label>License Number:</label>
    <input type="text" name="doctorInfo.licenseNumber" value="${doctor.doctorInfo.licenseNumber}" required>

  <label>License Certificate:</label>

<c:if test="${not empty doctor.doctorInfo.licenseCertificate}">

    <c:if test="${doctor.doctorInfo.licenseCertificate.endsWith('.jpg')
              || doctor.doctorInfo.licenseCertificate.endsWith('.jpeg')
              || doctor.doctorInfo.licenseCertificate.endsWith('.png')}">
        <img src="/images/Doctor/License/${doctor.doctorInfo.licenseCertificate}"
             class="doc-image"
             alt="License Certificate">
    </c:if>

    <c:if test="${doctor.doctorInfo.licenseCertificate.endsWith('.pdf')}">
        <a href="/images/Doctor/License/${doctor.doctorInfo.licenseCertificate}"
           target="_blank">
           View License Certificate (PDF)
        </a>
    </c:if>

    <div class="file-hint">
        Upload new certificate to replace (pdf / jpg / png)
    </div>
</c:if>

<input type="file"
       name="licenseCertificate"
       accept=".pdf,.jpg,.jpeg,.png"
       <c:if test="${empty doctor.doctorInfo.licenseCertificate}">required</c:if>>




<label>Profile Image:</label>

<c:if test="${not empty doctor.doctorInfo.fileName}">
    <img src="/images/Doctor/profiles/${doctor.doctorInfo.fileName}"
         class="doc-image"
         alt="Profile Image">

    <div class="file-hint">Upload new image to replace (jpg / png)</div>
</c:if>

<input type="file"
       name="fname"
       accept=".jpg,.jpeg,.png"
       <c:if test="${empty doctor.doctorInfo.fileName}">required</c:if>>


    <label>Status:</label>
    <select name="status" required>
        <option value="Active" ${doctor.status == 'Active' ? 'selected' : ''}>Active</option>
        <option value="Inactive" ${doctor.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
        <option value="Out Off Town" ${doctor.status == 'Out Off Town' ? 'selected' : ''}>Out Off Town</option>
    </select>

    <button type="submit">Update</button>
</form>

</div>

</body>
</html>
