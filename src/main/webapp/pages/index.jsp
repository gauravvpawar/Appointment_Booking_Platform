<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${not empty msg}">
    <div id="toast" class="toast show">
        ${msg}
    </div>
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>MediCare - Doctor Appointment System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #2c7fb8;
            --secondary: #7fcdbb;
            --accent: #edf8b1;
            --dark: #253237;
            --light: #f8f9fa;
            --danger: #e74c3c;
            --success: #2ecc71;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background-color: #f5f7fa;
            color: var(--dark);
            line-height: 1.6;
        }
        
        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 15px;
        }
        
        /* Header Styles */
        header {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
        }
        
        .logo {
            font-size: 24px;
            font-weight: 700;
            color: var(--primary);
            text-decoration: none;
            display: flex;
            align-items: center;
        }
        
        .logo i {
            margin-right: 8px;
        }
        
        .nav-links {
            display: flex;
            list-style: none;
        }
        
        .nav-links li {
            margin-left: 25px;
        }
        
        .nav-links a {
            text-decoration: none;
            color: var(--dark);
            font-weight: 500;
            transition: color 0.3s;
        }
        
        .nav-links a:hover {
            color: var(--primary);
        }
        
        /* Button Styles */
        .btn {
            display: inline-block;
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            text-align: center;
            font-size: 15px;
            border: none;
        }
        
        .btn-primary {
            background-color: var(--primary);
            color: white;
        }
        
        .btn-primary:hover {
            background-color: #1a68a4;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(44, 127, 184, 0.3);
        }
        
        .btn-outline {
            background-color: transparent;
            border: 1px solid var(--primary);
            color: var(--primary);
        }
        
        .btn-outline:hover {
            background-color: var(--primary);
            color: white;
            transform: translateY(-2px);
        }
        
        .auth-buttons {
            display: flex;
            gap: 12px;
        }
        
        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            padding: 80px 0;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 600" opacity="0.05"><path d="M0,300 C150,350 300,250 450,300 C600,350 750,250 900,300 C1050,350 1200,250 1200,300 L1200,600 L0,600 Z" fill="white"/></svg>');
            background-size: cover;
        }
        
        .hero .container {
            position: relative;
            z-index: 1;
        }
        
        .hero h1 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            font-weight: 700;
        }
        
        .hero p {
            font-size: 1.1rem;
            max-width: 700px;
            margin: 0 auto 30px;
            opacity: 0.9;
        }
        
        /* Features Section */
        .features {
            padding: 80px 0;
            background-color: white;
        }
        
        .section-title {
            text-align: center;
            margin-bottom: 50px;
        }
        
        .section-title h2 {
            font-size: 2rem;
            color: var(--dark);
            margin-bottom: 15px;
            font-weight: 700;
            position: relative;
            display: inline-block;
        }
        
        .section-title h2::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            border-radius: 2px;
        }
        
        .section-title p {
            color: #666;
            font-size: 1rem;
            max-width: 600px;
            margin: 20px auto 0;
            line-height: 1.6;
        }
        
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
        }
        
        .feature-card {
            background-color: var(--light);
            border-radius: 10px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            border: 1px solid rgba(0, 0, 0, 0.03);
        }
        
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        
        .feature-icon {
            font-size: 40px;
            color: var(--primary);
            margin-bottom: 20px;
        }
        
        .feature-card h3 {
            margin-bottom: 12px;
            color: var(--dark);
            font-size: 1.2rem;
        }
        
        .feature-card p {
            color: #666;
            line-height: 1.6;
            font-size: 0.95rem;
        }
        
    /* Doctors Section */
.doctors {
    padding: 80px 0;
    background: #f8fafc;
}

/* Center the grid container */
.doctors .container {
    display: flex;
    flex-direction: column;
    align-items: center;
}

/* Doctors Grid - Centered */
.doctors-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
    gap: 25px;
    width: 100%;
    justify-content: center;
}

/* Doctor Card */
.doctor-card {
    width: 100%;
    max-width: 280px;
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
    transition: all 0.3s ease;
    border: 1px solid rgba(0, 0, 0, 0.05);
    display: flex;
    flex-direction: column;
    margin: 0 auto; /* Center individual cards */
}

/* When there's only 1 or 2 cards, they should still be centered */
@media (min-width: 768px) {
    .doctors-grid:has(.doctor-card:nth-child(1):last-child) {
        justify-content: center;
    }
    
    .doctors-grid:has(.doctor-card:nth-child(2):last-child) {
        justify-content: center;
    }
}

/* Alternative Method: Using Flexbox instead of Grid for better centering */
/* Uncomment this if grid centering doesn't work perfectly */

/*
.doctors-grid {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 25px;
    width: 100%;
}

.doctor-card {
    flex: 0 0 260px;
    max-width: 260px;
}
*/

/* Or use this for perfect centering with grid: */
.doctors-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, 260px);
    justify-content: center;
    gap: 25px;
    width: 100%;
}

.doctor-card {
    width: 260px;
}

/* Doctor Image Container */
.doctor-img {
    position: relative;
    height: 180px;
    width: 100%;
    overflow: hidden;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.doctor-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.5s ease;
}

.doctor-card:hover .doctor-image {
    transform: scale(1.05);
}

/* Doctor Info */
.doctor-info {
    padding: 20px;
    text-align: center;
    flex-grow: 1;
    display: flex;
    flex-direction: column;
}

.doctor-info h3 {
    color: #253237;
    font-size: 1.1rem;
    margin-bottom: 8px;
    font-weight: 700;
    line-height: 1.3;
}

.doctor-specialty {
    display: inline-block;
    background: linear-gradient(135deg, #2c7fb8, #7fcdbb);
    color: white;
    padding: 5px 15px;
    border-radius: 15px;
    font-size: 0.8rem;
    font-weight: 600;
    margin-bottom: 10px;
    text-transform: uppercase;
    letter-spacing: 0.3px;
    max-width: fit-content;
    margin-left: auto;
    margin-right: auto;
}

/* Responsive Design */
@media (max-width: 992px) {
    .doctors-grid {
        grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
        justify-content: center;
    }
    
    .doctor-card {
        max-width: 240px;
    }
}

@media (max-width: 768px) {
    .doctors-grid {
        grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
        gap: 20px;
    }
    
    .doctor-card {
        max-width: 220px;
    }
}

@media (max-width: 576px) {
    .doctors-grid {
        grid-template-columns: 1fr;
        max-width: 300px;
        margin: 0 auto;
    }
    
    .doctor-card {
        max-width: 100%;
        width: 100%;
    }
}
        
        .doctor-experience {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
        }
        
        .doctor-experience::before {
            content: '⏳';
            font-size: 0.9rem;
        }
        
        .doctor-qualification {
            color: #7f8c8d;
            font-size: 0.85rem;
            margin-bottom: 15px;
            font-style: italic;
            line-height: 1.4;
        }
        
        /* Compact Rating Styles */
        .doctor-rating {
            margin-top: auto;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }
        
        .stars {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 2px;
            margin-bottom: 5px;
        }
        
        .stars i {
            color: #FFD700;
            font-size: 0.9rem;
        }
        
        .rating-text {
            color: #666;
            font-size: 0.85rem;
            font-weight: 600;
        }
        
        /* Footer */
        footer {
            background: linear-gradient(135deg, var(--dark), #1a252f);
            color: white;
            padding: 60px 0 20px;
            position: relative;
            overflow: hidden;
        }
        
        footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" opacity="0.05"><path d="M0,120 C150,80 300,140 450,120 C600,100 750,140 900,120 C1050,100 1200,140 1200,120 L1200,120 L0,120 Z"/></svg>');
            background-size: cover;
        }
        
        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 30px;
            margin-bottom: 30px;
            position: relative;
            z-index: 1;
        }
        
        .footer-column h3 {
            margin-bottom: 20px;
            font-size: 1.2rem;
            color: white;
            position: relative;
            padding-bottom: 8px;
        }
        
        .footer-column h3::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 35px;
            height: 2px;
            background: var(--primary);
        }
        
        .footer-links {
            list-style: none;
        }
        
        .footer-links li {
            margin-bottom: 10px;
        }
        
        .footer-links a {
            color: #ccc;
            text-decoration: none;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.95rem;
        }
        
        .footer-links a:hover {
            color: white;
            transform: translateX(3px);
        }
        
        .footer-links i {
            width: 14px;
        }
        
        .copyright {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: #aaa;
            font-size: 0.85rem;
            position: relative;
            z-index: 1;
        }
        
        /* Toast Notification */
        .toast {
            position: fixed;
            top: 20px;
            right: 20px;
            background: linear-gradient(135deg, #10b981, #34d399);
            color: white;
            padding: 12px 22px;
            border-radius: 10px;
            font-weight: 600;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
            z-index: 9999;
            opacity: 0;
            transform: translateX(100px);
            transition: all 0.3s ease;
            font-size: 0.95rem;
        }
        
        .toast.show {
            opacity: 1;
            transform: translateX(0);
        }
        
        /* Responsive Design */
        @media (max-width: 1200px) {
            .doctors-grid {
                grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
                gap: 20px;
            }
        }
        
        @media (max-width: 992px) {
            .hero h1 {
                font-size: 2rem;
            }
            
            .section-title h2 {
                font-size: 1.8rem;
            }
            
            .doctors-grid {
                grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
                gap: 20px;
            }
            
            .doctor-card {
                max-width: 100%;
            }
            
            .navbar {
                flex-wrap: wrap;
            }
            
            .auth-buttons {
                width: 100%;
                justify-content: center;
                margin-top: 15px;
            }
        }
        
        @media (max-width: 768px) {
            .container {
                width: 95%;
                padding: 0 10px;
            }
            
            .hero {
                padding: 60px 0;
            }
            
            .hero h1 {
                font-size: 1.8rem;
            }
            
            .features, .doctors {
                padding: 60px 0;
            }
            
            .features-grid {
                grid-template-columns: 1fr;
                max-width: 400px;
                margin: 0 auto;
            }
            
            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
                margin-top: 15px;
            }
            
            .nav-links li {
                margin: 5px 10px;
            }
            
            .doctor-img {
                height: 160px;
            }
            
            .doctors-grid {
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
                gap: 15px;
            }
        }
        
        @media (max-width: 576px) {
            .doctors-grid {
                grid-template-columns: 1fr;
                max-width: 300px;
                margin: 0 auto;
            }
            
            .doctor-card {
                max-width: 100%;
            }
            
            .footer-content {
                grid-template-columns: 1fr;
                text-align: center;
                gap: 25px;
            }
            
            .footer-column h3::after {
                left: 50%;
                transform: translateX(-50%);
            }
            
            .doctor-img {
                height: 150px;
            }
        }
        
        @media (max-width: 400px) {
            .doctors-grid {
                max-width: 280px;
            }
            
            .doctor-card {
                max-width: 100%;
            }
            
            .hero h1 {
                font-size: 1.6rem;
            }
        }
        
        /* Animation */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .doctor-card {
            animation: fadeInUp 0.4s ease forwards;
            animation-delay: calc(var(--card-index, 0) * 0.05s);
            opacity: 0;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        <div class="container">
            <nav class="navbar">
                <a href="#" class="logo">
                    <i class="fas fa-stethoscope"></i>
                    MediCare
                </a>
                <ul class="nav-links">
                    <li><a href="#">Home</a></li>
                    <li><a href="#doctors">Doctors</a></li>
                    <li><a href="#services">Services</a></li>
                    <li><a href="#about">About</a></li>
                    <li><a href="#contact">Contact</a></li>
                </ul>
                
                <div class="auth-buttons">
                    <a href="patient/login" class="btn btn-outline">Patient Login</a>
                    <a href="/doctor/login" class="btn btn-primary">Doctor Login</a>
                </div>
            </nav>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <h1>Book Your Doctor's Appointment Online</h1>
            <p>Find the best doctors, book appointments instantly, and manage your healthcare needs all in one place.</p>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features" id="services">
        <div class="container">
            <div class="section-title">
                <h2>Why Choose MediCare?</h2>
                <p>We provide a seamless healthcare experience with our advanced appointment booking system.</p>
            </div>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <h3>Easy Appointment Booking</h3>
                    <p>Book appointments with your preferred doctors in just a few clicks.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-user-md"></i>
                    </div>
                    <h3>Verified Doctors</h3>
                    <p>All our doctors are verified and have excellent patient reviews.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-bell"></i>
                    </div>
                    <h3>Instant Notifications</h3>
                    <p>Get instant confirmation and reminders for your appointments.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Doctor Section -->
    <section class="doctors" id="doctors">
        <div class="container">
            <div class="section-title">
                <h2>Our Specialist Doctors</h2>
                <p>Meet our team of experienced and qualified healthcare professionals.</p>
            </div>

            <div class="doctors-grid">
                <c:forEach var="doc" items="${doctorList}" varStatus="status">
                    <c:if test="${not empty doc.doctorInfo.licenseNumber}">
                        <div class="doctor-card" style="--card-index: ${status.index}">
                            <div class="doctor-img">
                                <!-- Display doctor's image from database or use fallback icon -->
                                <c:choose>
                                    <c:when test="${not empty doc.doctorInfo.fileName}">
                                        <img src="/images/Doctor/Profiles/${doc.doctorInfo.fileName}" 
                                             alt="Dr. ${doc.name}" 
                                             class="doctor-image"
                                             onerror="this.style.display='none'; this.parentElement.querySelector('.doctor-icon').style.display='flex';">
                                        <div class="doctor-icon" style="display: none;">
                                            <i class="fas fa-user-md"></i>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="doctor-icon">
                                            <i class="fas fa-user-md"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="doctor-img-overlay"></div>
                                
                                <!-- Verified Badge (only if licenseNumber exists) -->
                                <div class="verified-badge">
                                    <i class="fas fa-shield-alt"></i>
                                    Verified
                                </div>
                            </div>
                            <div class="doctor-info">
                                <h3>Dr. ${doc.name}</h3>
                                <p class="doctor-specialty">${doc.specialization}</p>
                                <p class="doctor-experience">${doc.experience} years</p>
                                <c:if test="${not empty doc.qualification}">
                                    <p class="doctor-qualification">${doc.qualification}</p>
                                </c:if>
                                <div class="doctor-rating">
                                    <div class="stars">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star-half-alt"></i>
                                    </div>
                                    <div class="rating-text">4.5/5.0</div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
                
                <!-- Show message if no doctors have license numbers -->
                <c:if test="${empty doctorList or (empty doctorList.stream().filter(d -> not empty d.doctorInfo.licenseNumber).toList())}">
                    <div class="no-doctors">
                        <i class="fas fa-user-md"></i>
                        <h3>No Verified Doctors Available</h3>
                        <p>Currently, there are no verified doctors with valid licenses. Please check back later.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer id="contact">
        <div class="container">
            <div class="footer-content">
                <div class="footer-column">
                    <h3>MediCare</h3>
                    <p>Your trusted partner in healthcare management and appointment booking.</p>
                </div>
                <div class="footer-column">
                    <h3>Quick Links</h3>
                    <ul class="footer-links">
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Home</a></li>
                        <li><a href="#doctors"><i class="fas fa-chevron-right"></i> Doctors</a></li>
                        <li><a href="#services"><i class="fas fa-chevron-right"></i> Services</a></li>
                        <li><a href="#about"><i class="fas fa-chevron-right"></i> About Us</a></li>
                    </ul>
                </div>
                <div class="footer-column">
                    <h3>Contact Us</h3>
                    <ul class="footer-links">
                        <li><a href="#"><i class="fas fa-map-marker-alt"></i> 123 Health St, Medical City</a></li>
                        <li><a href="tel:+15551234567"><i class="fas fa-phone"></i> +1122334455</a></li>
                        <li><a href="mailto:info@medicare.com"><i class="fas fa-envelope"></i> info@medicare.com</a></li>
                    </ul>
                </div>
            </div>
            <div class="copyright">
                <p>&copy; 2025 MediCare. All rights reserved.</p>
            </div>
        </div>
    </footer>
    
    <script>
        // Toast notification handling
        const toast = document.getElementById("toast");
        if (toast) {
            setTimeout(() => {
                toast.classList.remove("show");
                setTimeout(() => toast.remove(), 400);
            }, 3000);
        }
        
        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                const targetId = this.getAttribute('href');
                if (targetId === '#') return;
                
                const targetElement = document.querySelector(targetId);
                if (targetElement) {
                    window.scrollTo({
                        top: targetElement.offsetTop - 80,
                        behavior: 'smooth'
                    });
                }
            });
        });
        
        // Add animation to doctor cards on scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };
        
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.animationPlayState = 'running';
                }
            });
        }, observerOptions);
        
        document.querySelectorAll('.doctor-card').forEach(card => {
            observer.observe(card);
        });
    </script>
</body>
</html>