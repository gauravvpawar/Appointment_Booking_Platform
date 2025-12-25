<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Form</title>

<style>
    body {
        margin: 0;
        padding: 0;
        font-family: Arial, Helvetica, sans-serif;
        background: #f0f2f5;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    .container {
        background: white;
        padding: 35px 40px;
        border-radius: 10px;
        box-shadow: 0px 4px 15px rgba(0,0,0,0.1);
        width: 350px;
        text-align: center;
    }

    h2 {
        margin-bottom: 20px;
        color: #333;
        font-weight: 600;
    }

    label {
        display: block;
        text-align: left;
        margin-bottom: 6px;
        margin-top: 15px;
        font-size: 14px;
        color: #555;
    }

    input {
        width: 100%;
        padding: 10px;
        border-radius: 5px;
        border: 1px solid #ccc;
        font-size: 15px;
        box-sizing: border-box;
    }

    input:focus {
        border-color: #3b82f6;
        outline: none;
        box-shadow: 0 0 4px rgba(59,130,246,0.5);
    }

    button {
        margin-top: 20px;
        width: 100%;
        padding: 12px;
        background: #3b82f6;
        color: white;
        border: none;
        font-size: 16px;
        border-radius: 5px;
        cursor: pointer;
    }

    button:hover {
        background: #2563eb;
    }

    .register-link {
        margin-top: 15px;
        display: block;
        color: #2563eb;
        font-size: 14px;
        text-decoration: none;
    }

    .register-link:hover {
        text-decoration: underline;
    }
</style>
</head>

<body>

<div class="container">

    <h2>Doctor Login</h2>

    <form action="/doctor/DoctorLogin" method="post">
        <label>Email:</label>
        <input type="email" name="email" required>

        <label>Password:</label>
        <input type="text" name="password" required>

        <button type="submit">Login</button>
    </form>

    <a class="register-link" href="/doctor/DoctorRegistrationForm">Create Account</a>
	 <a class="register-link" href="/doctor/DoctorForgotPasswordForm">Forget Password</a>

</div>

</body>
</html>