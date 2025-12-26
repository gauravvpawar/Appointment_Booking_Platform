<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Appointment Form</title>
 <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
        }
        .container {
            width: 450px;
            margin: 50px auto;
            padding: 25px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        input, select, textarea {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        textarea {
            height: 80px;
        }
        button {
            width: 100%;
            padding: 12px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover {
            background: #0056b3;
        }
        h2 {
            text-align: center;
        }
       
       .back-btn{ 
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
    

        
    </style>
</head>
<body>
<a href="/patient/DashBoard/${patient.id}" class="back-btn">← Back</a>



<div class="container">
    <h2>Book Appointment</h2>
    <form action="/patient/RegisterAppointment/${patient.id}" method="POST">

        <!-- Patient Name -->
        <label>Patient Name</label>
        <input type="text" name="name" value="${patient.name}" required>

        <!-- Patient Email -->
        <label>Email</label>
        <input type="email" name="email" value="${patient.email}"  required>

        <!-- Phone -->
        <label>Phone</label>
        <input type="text" name="phone"  value="${patient.phone}" required>

        <!-- Select Doctor (dynamic later) -->
       <label>Select Doctor</label>
	<select name="did" required>
	    <option value="">-- Select Doctor --</option>
	    <c:forEach var="doctor" items="${doctors}">
	        <option value="${doctor.did}">
	            ${doctor.name} - ${doctor.specialization}
	        </option>
	    </c:forEach>
	</select>


        <!-- Appointment Date -->
        <label>Appointment Date</label>
        <input type="date" id="appointment"  name="appointment_date" required>

        <!-- Appointment Time -->
        <label>Appointment Time</label>
        <input type="time" name="appointment_time" required>

        <!-- Reason -->
        <label>Reason for Appointment</label>
        <textarea name="reason" placeholder="Describe your symptoms or reason for visit..."></textarea>

        <button type="submit">Book Appointment</button>
    </form>
</div>

<script>
    const today = new Date().toISOString().split('T')[0]; // get yyyy-mm-dd
    document.getElementById('appointment').setAttribute('min', today);
</script>
</body>
</html>