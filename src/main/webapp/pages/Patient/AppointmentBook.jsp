<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
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
    </style>
</head>
<body>

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
        
        
       
        </select>

        <!-- Appointment Date -->
        <label>Appointment Date</label>
        <input type="date" name="appointment_date" required>

        <!-- Appointment Time -->
        <label>Appointment Time</label>
        <input type="time" name="appointment_time" required>

        <!-- Reason -->
        <label>Reason for Appointment</label>
        <textarea name="reason" placeholder="Describe your symptoms or reason for visit..."></textarea>

        <button type="submit">Book Appointment</button>
    </form>
</div>
</body>
</html>