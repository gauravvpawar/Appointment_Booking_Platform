<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Patient Login form</title>

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
        width: 360px;
        padding: 35px 30px;
        border-radius: 12px;
        box-shadow: 0 5px 18px rgba(0,0,0,0.2);
    }

    h2 {
        text-align: center;
        margin-bottom: 22px;
        color: #1e69de;
        font-weight: 700;
    }

    input {
        width: 100%;
        padding: 12px;
        margin: 10px 0;
        border: 1px solid #ccc;
        border-radius: 8px;
        font-size: 15px;
        transition: .3s;
    }

    input:focus {
        border-color: #1e69de;
        outline: none;
        box-shadow: 0 0 6px rgba(30,105,222,0.4);
    }

    button {
        width: 100%;
        padding: 12px;
        background: #1e69de;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 17px;
        cursor: pointer;
        font-weight: 600;
        transition: 0.3s;
        margin-top: 10px;
    }

    button:hover {
        background: #0f4ead;
    }

    .links {
        margin-top: 20px;
        text-align: center;
    }

    .links a {
        display: block;
        margin: 6px 0;
        color: #1e69de;
        text-decoration: none;
        font-size: 14px;
        transition: .2s;
    }

    .links a:hover {
        text-decoration: underline;
        color: #0f4ead;
    }

</style>
</head>
<body>

<div class="container">
    <h2>Patient Login</h2>

    <form action="${pageContext.request.contextPath}/Controller/PatientLoginProcess.jsp" method="post">

        <input type="email" placeholder="Enter your email" name="email" required>

        <input type="text" placeholder="Enter your password" name="password" required>

        <button type="submit">Log In</button>
    </form>

    <div class="links">
        <a href="/patient/register">Create Account</a>
        <a href="">Forget Password?</a>
    </div>
</div>

</body>
</html>