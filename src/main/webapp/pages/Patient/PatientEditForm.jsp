<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Patient Edit Form</title>

<style>
    /* Body Styling */
    body {
        font-family: 'Segoe UI', Arial, sans-serif;
        background: #f4f7fa;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
    }

    /* Container Styling */
    .registration-container {
        width: 450px;
        background: #ffffff;
        padding: 35px 40px;
        border-radius: 15px;
        box-shadow: 0px 10px 25px rgba(0, 0, 0, 0.1);
        text-align: center;
        transition: transform 0.3s;
    }

    .registration-container:hover {
        transform: translateY(-3px);
    }

    h2 {
        font-size: 26px;
        color: #1a1a1a;
        font-weight: 700;
        margin-bottom: 25px;
    }

    label {
        display: block;
        text-align: left;
        font-size: 15px;
        font-weight: 600;
        color: #333;
        margin-bottom: 6px;
    }

    input, select {
        width: 100%;
        padding: 10px 12px;
        margin-bottom: 15px;
        border: 1px solid #d1d9e6;
        border-radius: 8px;
        font-size: 14px;
        transition: border 0.3s, box-shadow 0.3s;
        outline: none;
    }

    input:focus, select:focus {
        border-color: #007bff;
        box-shadow: 0 0 6px rgba(0, 123, 255, 0.3);
    }

    button {
        width: 48%;
        padding: 12px;
        font-size: 16px;
        font-weight: 600;
        border-radius: 8px;
        cursor: pointer;
        transition: background 0.3s, transform 0.2s;
        border: none;
    }

    button[type="submit"] {
        background: #007bff;
        color: #fff;
        margin-right: 4%;
    }

    button[type="submit"]:hover {
        background: #0056b3;
        transform: scale(1.02);
    }

    button.previous {
        background: #6c757d;
        color: #fff;
    }

    button.previous:hover {
        background: #5a6268;
        transform: scale(1.02);
    }

    img {
        width: 70px;
        height: 70px;
        object-fit: cover;
        border-radius: 10px;
        margin-bottom: 10px;
        border: 1px solid #ddd;
    }

    input[type="file"] {
        padding: 5px;
    }

    .form-row {
        display: flex;
        justify-content: space-between;
    }
    
    /* Styled Back Link as Button */
.btn-back {
    display: inline-block;
    text-decoration: none;
    text-align: center;
    padding: 12px 25px;
    background-color: #6c757d; /* gray color */
    color: #fff;
    font-size: 16px;
    font-weight: 600;
    border-radius: 8px;
    transition: background 0.3s, transform 0.2s;
    margin-top: 10px;
}

.btn-back:hover {
    background-color: #5a6268;
    transform: scale(1.05);
}
    
</style>
</head>

<body>
<div class="registration-container">
    <h2>Patient Update Data</h2>

    <form action="/patient/UpdateData/${patient.id}" method="post" enctype="multipart/form-data">

        <label>Full Name:</label>
        <input type="text" name="name" value="${patient.name}" required>

        <label>Email:</label>
        <input type="email" name="email" value="${patient.email}" readOnly required>

        <label>Password:</label>
        <input type="text" name="password" placeholder="New Password (optional)">

        <label>Confirm Password:</label>
        <input type="text" name="cnfPassword" placeholder="New Confirm Password (optional)">

        <label>Phone:</label>
        <input type="text" name="phone" value="${patient.phone}" required>

        <label>Gender:</label>
        <select name="gender" required>
            <option value="Male" ${patient.gender == 'Male' ? 'selected' : ''}>Male</option>
            <option value="Female" ${patient.gender == 'Female' ? 'selected' : ''}>Female</option>
            <option value="Other" ${patient.gender == 'Other' ? 'selected' : ''}>Other</option>
        </select>

        <label>Age:</label>
        <input type="number" name="age" value="${patient.age}" min="0">

        <label>Date Of Birth:</label>
        <input type="date" name="patientinfo.dob" value="${patient.patientinfo.dob}" placeholder="Enter Date Of Birth">

        <label>Address:</label>
        <input type="text" name="patientinfo.address" value="${patient.patientinfo.address}" placeholder="Enter Address">

        <label>Blood Group:</label>
        <input type="text" name="patientinfo.bloodGroup" value="${patient.patientinfo.bloodGroup}" placeholder="Enter Blood Group">

        <label>Status:</label>
        <select name="status" required>
            <option value="Active">Active</option>
            <option value="Inactive">Inactive</option>
        </select>

        <div style="margin-bottom: 15px;">
            <img src="/images/${patient.patientinfo.fileName}" alt="Patient Image">
            <label>Upload Image</label>
            <input type="file" name="fname">
        </div>

        <div class="form-row">
            <button type="submit">Update</button>
            <a href="/patient/DashBoard/${patient.id}" class="btn-back">back</a>
        </div>
    </form>
    
    <script>
    // JS Back Button
    document.getElementById('backBtn').addEventListener('click', function() {
        window.history.back();
    });
</script>
    
</div>
</body>
</html>
