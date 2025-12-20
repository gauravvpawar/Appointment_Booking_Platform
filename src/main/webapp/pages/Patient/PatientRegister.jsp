<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Patient Registration</title>

<style>
    body {
        font-family: Arial, sans-serif;
        background: #f0f4f8;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .container {
        background: white;
        width: 380px;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.15);
    }

    h2 {
        text-align: center;
        margin-bottom: 20px;
        color: #333;
    }

    input, select {
        width: 100%;
        padding: 12px;
        margin: 10px 0;
        border: 1px solid #ccc;
        border-radius: 8px;
        font-size: 15px;
    }

    input:focus, select:focus {
        border-color: #007bff;
        outline: none;
        box-shadow: 0 0 5px rgba(0,123,255,0.4);
    }

    button {
        width: 100%;
        padding: 12px;
        background: #007bff;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        cursor: pointer;
        transition: 0.3s;
        margin-top: 10px;
    }

    button:hover {
        background: #0056b3;
    }

</style>

</head>
<body>

<div class="container">
    <h2>Patient Registration</h2>

    <form action="/patient/savePatient" method="post">

        <input type="text" placeholder="Enter your name" name="name" required>

        <input type="email" placeholder="Enter your email" name="email" required>

        <input type="text" placeholder="Enter your password" name="password" required>

        <input type="text" placeholder="Confirm password" name="cnfPassword" required>

        <input type="text" placeholder="Enter your phone number" name="phone" required>

        <select name="gender" required>
            <option disabled selected>Select Gender</option>
            <option value="male">Male</option>
            <option value="female">Female</option>
            <option value="other">Other</option>
        </select>
        
        <input type="text" placeholder="Enter you age" name="age" required>

        <button type="submit">Register</button>

    </form>
</div>

</body>
</html>