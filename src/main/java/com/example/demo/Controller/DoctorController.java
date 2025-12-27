package com.example.demo.Controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.example.demo.Config.AppConfig;
import com.example.demo.Model.Appointments;
import com.example.demo.Model.Doctor;
import com.example.demo.Model.DoctorInfo;
import com.example.demo.Model.Patient;
import com.example.demo.Service.AppointmentService;
import com.example.demo.Service.DoctorService;
import com.example.demo.Service.PatientService;

@Controller
@RequestMapping("/doctor")
public class DoctorController 
{

    private final PasswordEncoder passwordEncoder;

	@Autowired
	DoctorService ds;

	@Autowired
	 AppointmentService as;
	
	@Autowired
	PatientService ps;


    DoctorController(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    
	@RequestMapping("/")
	public String home(Model m)
	{
		List<Doctor> doctorList = ds.findAllDoctor();
		m.addAttribute("doctorList", doctorList);
		return "index";
	}
	
	
	
	
	@GetMapping("/login")
	public String loginPage()
	{
		return "Doctor/DoctorLogin";
	}
	
	@GetMapping("/DoctorRegistrationForm")
	public String registrationForm()
	{
		return "Doctor/DoctorRegistrationForm";
	}
	
	// doctor registration
	@PostMapping("/DoctorRegistration")
	public String DoctorRegister(@ModelAttribute Doctor doctor , Model m, RedirectAttributes redirectAttributes)
	{
		
		if(doctor.getPassword().equals(doctor.getCnfPassword()))
		{
			doctor.setPassword(passwordEncoder.encode(doctor.getPassword()));
			doctor.setCnfPassword(passwordEncoder.encode(doctor.getPassword()));
		}else {

			redirectAttributes.addFlashAttribute("msg", "Password and confirm Password not matched");
			
			return "redirect:/";
		}
		
		ds.saveDoctor(doctor);
		
		redirectAttributes.addFlashAttribute("msg", "Doctor Registered Successfully");
		
		return "redirect:/";
	}
	
	// doctor login
	@PostMapping("/DoctorLogin")
	public String DoctorLogin(@RequestParam("email") String email , @RequestParam("password") String password , Model m , HttpSession hs, RedirectAttributes redirectAttributes)
	{
	
		if(email == null || password == null || email.isEmpty() || password.isEmpty()) {
	        redirectAttributes.addFlashAttribute("msg", "Please enter email and password");
	        return "redirect:/";
	    }
		
		Doctor doctor = ds.findByEmail(email);
		
		
		 if (doctor == null) {
		        redirectAttributes.addFlashAttribute("msg", "Doctor email not found");
		        return "redirect:/";
		    }
		 
		System.out.println(doctor.getName());
		
		if(!passwordEncoder.matches(password, doctor.getPassword()))
		{
			redirectAttributes.addFlashAttribute("msg", " Wrong Password ,try again");
			return "redirect:/";
		}
		
		
		List<Appointments> allAppointments = as.findByDoctor(doctor);
	    
	    // Get today's appointments
	    List<Appointments> todayAppointments = allAppointments.stream()
	        .filter(appt -> appt.getAppointment_date().equals(LocalDate.now()))
	        .collect(Collectors.toList());
	    
	    // Get recent appointments (last 10)
	    List<Appointments> recentAppointments = allAppointments.stream()
	        .sorted((a1, a2) -> a2.getAppointment_date().compareTo(a1.getAppointment_date()))
	        .limit(10)
	        .collect(Collectors.toList());
	    
	    // Get unique patients
	    long uniquePatients = allAppointments.stream()
	        .map(appt -> appt.getPatient().getId())
	        .distinct()
	        .count();
	    
	    // Count by status
	    long pendingAppointments = allAppointments.stream()
	        .filter(appt -> "Pending".equals(appt.getAppointment_status()))
	        .count();
	    
	    long confirmedAppointments = allAppointments.stream()
	        .filter(appt -> "Confirmed".equals(appt.getAppointment_status()))
	        .count();
	    
	    // Add statistics to model
	    m.addAttribute("totalAppointments", allAppointments.size());
	    m.addAttribute("todayAppointments", todayAppointments);
	    m.addAttribute("recentPatients", recentAppointments);
	    m.addAttribute("uniquePatients", uniquePatients);
	    m.addAttribute("pendingAppointments", pendingAppointments);
	    m.addAttribute("confirmedAppointments", confirmedAppointments);
	    m.addAttribute("allAppointments", allAppointments);
	    m.addAttribute("doctor", doctor);
		
		m.addAttribute("msg", "Welcome to Dashboard");
		
		
		
		return "Doctor/DoctorDashBoard";	
	}
	
	// for doctor log out
	@GetMapping("/DoctorLogOutProcess")
	public String Logout(HttpSession hs , RedirectAttributes redirectAttributes)
	{
		hs.invalidate();
		redirectAttributes.addFlashAttribute("msg", "Doctor LogOut Successfully");
		return "redirect:/";
	}
	
	// forgot password Mapping
	@GetMapping("/DoctorForgotPasswordForm")
	public String forgotPassword()
	{
		return "Doctor/DoctorForgotPasswordForm";
	}
	
	
	// update password
	@PostMapping("/DoctorUpdatePassword")
	public String updatePassword(@RequestParam("email") String email , @RequestParam("password") String password , @RequestParam("cnfPassword") String cnfPassword , RedirectAttributes redirectAttributes)
	{
		if(email == null || password == null || cnfPassword == null || email.isEmpty() || password.isEmpty() || cnfPassword.isEmpty()) {
	        redirectAttributes.addFlashAttribute("msg", "Please enter email and password");
	        return "redirect:/";
	    }
		Doctor doctor =  ds.findByEmail(email);
		
		if(doctor == null)
		{
			redirectAttributes.addFlashAttribute("msg", "Please enter valid email , email not exist!");
	        return "redirect:/";
		}
		
		if(!password.equals(cnfPassword))
		{
			redirectAttributes.addFlashAttribute("msg", " Password and confirm password not matched");
	        return "redirect:/";
		}
		
		password = passwordEncoder.encode(password);
		cnfPassword = passwordEncoder.encode(cnfPassword);
		
		doctor.setPassword(password);
		doctor.setCnfPassword(cnfPassword);
		
		ds.saveDoctor(doctor);
		redirectAttributes.addFlashAttribute("msg", "Password Updated Successfully");
		
		return "redirect:/";
	}
	
//	DoctorEditForm page
	@GetMapping("/DoctorEditForm/{did}")
	public String editForm(@PathVariable int did, Model m)
	{
		Doctor doctor = ds.findById(did);
		
		m.addAttribute("doctor", doctor);
		
		return "Doctor/DoctorEditForm";
	}
	
	
//	doctor dashboard
	@GetMapping("/dashboard/{id}")
	public String dashboard(@PathVariable int id , Model m , HttpSession hs)
	{
		Doctor doctor = ds.findById(id);
		
		    
		    hs.setAttribute("doctor", doctor);
		    m.addAttribute("doctor", doctor);
		    
		    // Get all appointments for this doctor
		    List<Appointments> allAppointments = as.findByDoctor(doctor);
		    
		    // Get today's appointments
		    List<Appointments> todayAppointments = allAppointments.stream()
		        .filter(appt -> appt.getAppointment_date().equals(LocalDate.now()))
		        .collect(Collectors.toList());
		    
		    // Get recent appointments (last 10)
		    List<Appointments> recentAppointments = allAppointments.stream()
		        .sorted((a1, a2) -> a2.getAppointment_date().compareTo(a1.getAppointment_date()))
		        .limit(10)
		        .collect(Collectors.toList());
		    
		    // Get unique patients
		    long uniquePatients = allAppointments.stream()
		        .map(appt -> appt.getPatient().getId())
		        .distinct()
		        .count();
		    
		    // Count by status
		    long pendingAppointments = allAppointments.stream()
		        .filter(appt -> "Pending".equals(appt.getAppointment_status()))
		        .count();
		    
		    long confirmedAppointments = allAppointments.stream()
		        .filter(appt -> "Confirmed".equals(appt.getAppointment_status()))
		        .count();
		    
		    // Add statistics to model
		    m.addAttribute("totalAppointments", allAppointments.size());
		    m.addAttribute("todayAppointments", todayAppointments);
		    m.addAttribute("recentPatients", recentAppointments);
		    m.addAttribute("uniquePatients", uniquePatients);
		    m.addAttribute("pendingAppointments", pendingAppointments);
		    m.addAttribute("confirmedAppointments", confirmedAppointments);
		    m.addAttribute("allAppointments", allAppointments);
		    
		
		return "Doctor/DoctorDashBoard";
	}
	
	
//	DoctorUpdateData remaining work
	@PostMapping("/doctorUpdateData/{did}")
	public String UpdateData(@PathVariable int did , @ModelAttribute Doctor formDoctor ,@RequestParam MultipartFile licenseCertificate  ,@RequestParam MultipartFile fname , RedirectAttributes redirectAttributes) throws IllegalStateException, IOException
	{
		Doctor existingDoctor = ds.findById(did);
		
		existingDoctor.setName(formDoctor.getName());
		existingDoctor.setEmail(formDoctor.getEmail());
		existingDoctor.setPhone(formDoctor.getPhone());
		existingDoctor.setSpecialization(formDoctor.getSpecialization());
		existingDoctor.setQualification(formDoctor.getQualification());
		existingDoctor.setExperience(formDoctor.getExperience());
		existingDoctor.setGender(formDoctor.getGender());
		existingDoctor.setStatus(formDoctor.getStatus());
		
		if(formDoctor.getPassword() != null && !formDoctor.getPassword().isEmpty())
		{
			if(formDoctor.getPassword().equals(formDoctor.getCnfPassword()))
			{
				String password = formDoctor.getPassword();
				existingDoctor.setPassword(passwordEncoder.encode(password));
				existingDoctor.setCnfPassword(passwordEncoder.encode(password));
			}
		}
		
		DoctorInfo doctorInfo = existingDoctor.getDoctorInfo();
		
		// if the data is already not exist then he create new one
		if(doctorInfo == null)
		{
			doctorInfo = new DoctorInfo();
		}
		
		doctorInfo.setDob(formDoctor.getDoctorInfo().getDob());
		doctorInfo.setAddress(formDoctor.getDoctorInfo().getAddress());
		doctorInfo.setBloodGroup(formDoctor.getDoctorInfo().getBloodGroup());
		doctorInfo.setEmergencyContact(formDoctor.getDoctorInfo().getEmergencyContact());
		doctorInfo.setLicenseNumber(formDoctor.getDoctorInfo().getLicenseNumber());
		
		// to save the license Certificate
		if(licenseCertificate != null && !licenseCertificate.isEmpty())
		{
			String path = "C:\\Users\\ASUS\\OneDrive\\Desktop\\Appointment_Booking_Platform\\Appointment_Booking_Application\\src\\main\\resources\\static\\images\\Doctor\\License";
			
			File file = new File(path);
			
			String fn = licenseCertificate.getOriginalFilename();
			
			licenseCertificate.transferTo(new File(file , fn));
			
			doctorInfo.setLicenseCertificate(fn);
		}
		
		if(fname != null && !fname.isEmpty())
		{
			String path = "C:\\Users\\ASUS\\OneDrive\\Desktop\\Appointment_Booking_Platform\\Appointment_Booking_Application\\src\\main\\resources\\static\\images\\Doctor\\Profiles";
			File file = new File(path);
			String fn = fname.getOriginalFilename();
			
			fname.transferTo(new File(file , fn));
			
			doctorInfo.setFileName(fn);
		}
		
		existingDoctor.setDoctorInfo(doctorInfo);
		
//		System.out.println("Doctor : " + existingDoctor);
		
		ds.saveDoctor(existingDoctor);
		
		redirectAttributes.addFlashAttribute("msg", "Data updated Successfully");
		
		return "redirect:/doctor/dashboard/{did}";
	}

	
	  @GetMapping("/ViewAppointments/{doctorId}")
	    public String viewDoctorAppointments(@PathVariable int doctorId, Model m, HttpSession hs) {
	        Doctor doctor = ds.findById(doctorId);
	        
	        if(doctor == null) {
	            return "redirect:/";
	        }
	        
	        List<Appointments> appointments = as.findByDoctor(doctor);
	        
	        
	        // Calculate statistics
	        long totalAppointments = appointments.size();
	        
	        long confirmedCount = appointments.stream()
	            .filter(appt -> "Confirmed".equals(appt.getAppointment_status()))
	            .count();
	        
	        long pendingCount = appointments.stream()
	            .filter(appt -> "Pending".equals(appt.getAppointment_status()))
	            .count();
	        
	        long uniquePatientsCount = appointments.stream()
	            .map(appt -> appt.getPatient().getId())
	            .distinct()
	            .count();
	        
	        // Add to model
	        m.addAttribute("doctor", doctor);
	        m.addAttribute("appointments", appointments);
	        m.addAttribute("totalAppointments", totalAppointments);
	        m.addAttribute("confirmedCount", confirmedCount);
	        m.addAttribute("pendingCount", pendingCount);
	        m.addAttribute("uniquePatientsCount", uniquePatientsCount);
	        
	        return "Doctor/DoctorAppointments";
	    }
	    
	    // Update appointment status (Accept/Reject)
	    @PostMapping("/UpdateAppointmentStatus/{doctorId}")
	    public String updateAppointmentStatus(
	            @PathVariable int doctorId,
	            @RequestParam("appointmentId") int appointmentId,
	            @RequestParam("status") String status,
	            RedirectAttributes redirectAttributes) {
	        
	        Appointments appointment = as.findById(appointmentId);
	        
	        if(appointment != null && appointment.getDoctor().getDid() == doctorId) {
	            appointment.setAppointment_status(status);
	            as.saveAppointment(appointment);
	            redirectAttributes.addFlashAttribute("msg", "Appointment status updated to: " + status);
	        } else {
	            redirectAttributes.addFlashAttribute("msg", "Cannot update appointment status!");
	        }
	        
	        return "redirect:/doctor/ViewAppointments/" + doctorId;
	    }
	    
	    // View single appointment details
	    @GetMapping("/ViewAppointmentDetails/{doctorId}/{appointmentId}")
	    public String viewAppointmentDetails(@PathVariable int doctorId, @PathVariable int appointmentId, Model m) {
	        Doctor doctor = ds.findById(doctorId);
	        Appointments appointment = as.findById(appointmentId);
	        
	        if(doctor != null && appointment != null) {
	            m.addAttribute("doctor", doctor);
	            m.addAttribute("appointment", appointment);
	            m.addAttribute("patient", appointment.getPatient());
	        }
	        
	        return "Doctor/AppointmentDetails";
	    }
	
	    // to show reports
	    @GetMapping("/DoctorReport/{id}")
	    public String ShowReport(@PathVariable int id , Model m , HttpSession hs)
	    {
	    	
	    	Doctor doctor = ds.findById(id);

	         
	         if(doctor == null) {
	             return "redirect:/doctor/login";
	         }
	         
	         m.addAttribute("doctor", doctor);
	         
	         // Get basic statistics for quick view
	         List<Appointments> allAppointments = as.findByDoctor(doctor);
	         
	         // Calculate statistics
	         Map<String, Object> stats = calculateStatistics(doctor, allAppointments);
	         m.addAttribute("stats", stats);
	         
	         return "Doctor/DoctorReport";
	     }
	     
	     @GetMapping("/GenerateReport")
	     public String generateReport(@RequestParam String reportType,
	                                 @RequestParam(required = false) String startDate,
	                                 @RequestParam(required = false) String endDate,
	                                 @RequestParam(required = false) String filterBy,
	                                 HttpSession hs, Model m) {
	         
	         Doctor doctor = (Doctor) hs.getAttribute("doctor");
	         if(doctor == null) {
	             return "redirect:/doctor/login";
	         }
	         
	         m.addAttribute("doctor", doctor);
	         
	         // Parse dates if provided
	         LocalDate start = startDate != null ? LocalDate.parse(startDate) : LocalDate.now().minusMonths(1);
	         LocalDate end = endDate != null ? LocalDate.parse(endDate) : LocalDate.now();
	         
	         List<Appointments> appointments = as.findByDoctor(doctor);
	         
	         // Filter appointments by date range
	         List<Appointments> filteredAppointments = appointments.stream()
	             .filter(appt -> {
	                 LocalDate apptDate = appt.getAppointment_date();
	                 return !apptDate.isBefore(start) && !apptDate.isAfter(end);
	             })
	             .collect(Collectors.toList());
	         
	         // Filter by status if specified
	         if(filterBy != null && !filterBy.equals("all")) {
	             filteredAppointments = filteredAppointments.stream()
	                 .filter(appt -> appt.getAppointment_status().equalsIgnoreCase(filterBy))
	                 .collect(Collectors.toList());
	         }
	         
	         Map<String, Object> reportData = new HashMap<>();
	         
	         switch(reportType.toLowerCase()) {
	             case "appointments":
	                 reportData = generateAppointmentReport(doctor, filteredAppointments, start, end);
	                 break;
	             case "patients":
	                 reportData = generatePatientReport(doctor, filteredAppointments, start, end);
	                 break;
	             case "earnings":
	                 reportData = generateEarningsReport(doctor, filteredAppointments, start, end);
	                 break;
	             case "prescriptions":
	                 reportData = generatePrescriptionReport(doctor, filteredAppointments, start, end);
	                 break;
	         }
	         
	         m.addAttribute("reportData", reportData);
	         m.addAttribute("reportType", reportType);
	         m.addAttribute("startDate", start);
	         m.addAttribute("endDate", end);
	         m.addAttribute("filterBy", filterBy);
	         
	         return "Doctor/DoctorReport";
	     }
	     
	     @GetMapping("/PatientHistory/{patientId}")
	     public String viewPatientHistory(@PathVariable int patientId, 
	                                     HttpSession hs, Model m) {
	         Doctor doctor = (Doctor) hs.getAttribute("doctor");
	         if(doctor == null) {
	             return "redirect:/doctor/login";
	         }
	         
	         Patient patient = ps.findById(patientId);
	         if(patient == null) {
	             m.addAttribute("errorMsg", "Patient not found");
	             return "redirect:/doctor/Report";
	         }
	         
	         // Get all appointments for this patient with this doctor
	         List<Appointments> patientAppointments = as.findByDoctor(doctor).stream()
	             .filter(appt -> appt.getPatient().getId() == patientId)
	             .collect(Collectors.toList());
	         
	         m.addAttribute("doctor", doctor);
	         m.addAttribute("patient", patient);
	         m.addAttribute("appointments", patientAppointments);
	         
	         // Calculate patient statistics
	         Map<String, Object> patientStats = new HashMap<>();
	         patientStats.put("totalVisits", patientAppointments.size());
	         patientStats.put("firstVisit", patientAppointments.isEmpty() ? null : 
	             patientAppointments.get(patientAppointments.size() - 1).getAppointment_date());
	         patientStats.put("lastVisit", patientAppointments.isEmpty() ? null : 
	             patientAppointments.get(0).getAppointment_date());
	         
	         // Count by status
	         long confirmedVisits = patientAppointments.stream()
	             .filter(appt -> "Confirmed".equals(appt.getAppointment_status()))
	             .count();
	         long cancelledVisits = patientAppointments.stream()
	             .filter(appt -> "Cancelled".equals(appt.getAppointment_status()))
	             .count();
	         
	         patientStats.put("confirmedVisits", confirmedVisits);
	         patientStats.put("cancelledVisits", cancelledVisits);
	         
	         m.addAttribute("patientStats", patientStats);
	         
	         return "Doctor/PatientHistory";
	     }
	     
	     // Helper methods
	     private Map<String, Object> calculateStatistics(Doctor doctor, List<Appointments> appointments) {
	         Map<String, Object> stats = new HashMap<>();
	         
	         LocalDate today = LocalDate.now();
	         LocalDate monthStart = today.withDayOfMonth(1);
	         LocalDate yearStart = today.withDayOfYear(1);
	         
	         // Today's appointments
	         long todayAppointments = appointments.stream()
	             .filter(appt -> appt.getAppointment_date().equals(today))
	             .count();
	         
	         // This month appointments
	         long monthAppointments = appointments.stream()
	             .filter(appt -> !appt.getAppointment_date().isBefore(monthStart))
	             .count();
	         
	         // This year appointments
	         long yearAppointments = appointments.stream()
	             .filter(appt -> !appt.getAppointment_date().isBefore(yearStart))
	             .count();
	         
	         // Unique patients
	         long uniquePatients = appointments.stream()
	             .map(appt -> appt.getPatient().getId())
	             .distinct()
	             .count();
	         
	         // Status counts
	         long confirmedCount = appointments.stream()
	             .filter(appt -> "Confirmed".equals(appt.getAppointment_status()))
	             .count();
	         
	         long pendingCount = appointments.stream()
	             .filter(appt -> "Pending".equals(appt.getAppointment_status()))
	             .count();
	         
	         long cancelledCount = appointments.stream()
	             .filter(appt -> "Cancelled".equals(appt.getAppointment_status()))
	             .count();
	         
	         stats.put("totalAppointments", appointments.size());
	         stats.put("todayAppointments", todayAppointments);
	         stats.put("monthAppointments", monthAppointments);
	         stats.put("yearAppointments", yearAppointments);
	         stats.put("uniquePatients", uniquePatients);
	         stats.put("confirmedCount", confirmedCount);
	         stats.put("pendingCount", pendingCount);
	         stats.put("cancelledCount", cancelledCount);
	         
	         // Calculate satisfaction rate (for demo purposes)
	         double satisfactionRate = appointments.isEmpty() ? 0 : 
	             (confirmedCount * 1.0 / appointments.size()) * 100;
	         stats.put("satisfactionRate", Math.round(satisfactionRate));
	         
	         // Calculate average consultation time (for demo purposes)
	         stats.put("avgConsultationTime", "25 mins");
	         
	         // Calculate cancellation rate
	         double cancellationRate = appointments.isEmpty() ? 0 : 
	             (cancelledCount * 1.0 / appointments.size()) * 100;
	         stats.put("cancellationRate", Math.round(cancellationRate));
	         
	         return stats;
	     }
	     
	     private Map<String, Object> generateAppointmentReport(Doctor doctor, 
	    		 							List<Appointments> appointments, 
				                 LocalDate start, LocalDate end) {
				Map<String, Object> report = new HashMap<>();
				report.put("title", "Appointments Report");
				report.put("period", start + " to " + end);
				
				// Daily appointment count
				Map<String, Integer> dailyCounts = new LinkedHashMap<>();
				LocalDate current = start;
				int totalCount = 0;
				
				while (!current.isAfter(end)) {
				final LocalDate date = current;
				long count = appointments.stream()
				.filter(appt -> appt.getAppointment_date().equals(date))
				.count();
				dailyCounts.put(current.format(DateTimeFormatter.ofPattern("dd/MM")), (int) count);
				totalCount += count;
				current = current.plusDays(1);
				}
				
				report.put("dailyCounts", dailyCounts);
				report.put("totalAppointments", totalCount);
	         // Status distribution
	         Map<String, Long> statusDistribution = appointments.stream()
	             .collect(Collectors.groupingBy(
	                 Appointments::getAppointment_status,
	                 Collectors.counting()
	             ));
	         report.put("statusDistribution", statusDistribution);
	         
	         // Top patients by visits
	         Map<String, Long> topPatients = appointments.stream()
	             .collect(Collectors.groupingBy(
	                 appt -> appt.getPatient().getName(),
	                 Collectors.counting()
	             ))
	             .entrySet().stream()
	             .sorted((e1, e2) -> e2.getValue().compareTo(e1.getValue()))
	             .limit(10)
	             .collect(Collectors.toMap(
	                 Map.Entry::getKey,
	                 Map.Entry::getValue,
	                 (e1, e2) -> e1,
	                 LinkedHashMap::new
	             ));
	         report.put("topPatients", topPatients);
	         
	         // Appointment reasons
	         Map<String, Long> reasonAnalysis = new HashMap<>();
	         appointments.forEach(appt -> {
	             String reason = appt.getReason();
	             if(reason != null && !reason.trim().isEmpty()) {
	                 reasonAnalysis.put(reason, reasonAnalysis.getOrDefault(reason, 0L) + 1);
	             }
	         });
	         report.put("reasonAnalysis", reasonAnalysis);
	         
	         return report;
	     }
	     
	     private Map<String, Object> generatePatientReport(Doctor doctor,
	                                                      List<Appointments> appointments,
	                                                      LocalDate start, LocalDate end) {
	         Map<String, Object> report = new HashMap<>();
	         report.put("title", "Patients Report");
	         report.put("period", start + " to " + end);
	         
	         // Patient demographics
	         List<Patient> patients = appointments.stream()
	             .map(Appointments::getPatient)
	             .distinct()
	             .collect(Collectors.toList());
	         
	         report.put("totalPatients", patients.size());
	         
	         // Age distribution
	         Map<String, Long> ageDistribution = patients.stream()
	             .collect(Collectors.groupingBy(
	                 patient -> {
	                     int age = patient.getAge();
	                     if(age < 20) return "Under 20";
	                     else if(age < 30) return "20-29";
	                     else if(age < 40) return "30-39";
	                     else if(age < 50) return "40-49";
	                     else if(age < 60) return "50-59";
	                     else return "60+";
	                 },
	                 Collectors.counting()
	             ));
	         report.put("ageDistribution", ageDistribution);
	         
	         // Gender distribution
	         Map<String, Long> genderDistribution = patients.stream()
	             .collect(Collectors.groupingBy(
	                 Patient::getGender,
	                 Collectors.counting()
	             ));
	         report.put("genderDistribution", genderDistribution);
	         
	         // New vs returning patients
	         LocalDate periodStart = start;
	         long newPatients = patients.stream()
	             .filter(patient -> {
	                 // Check if patient had appointments before this period
	                 return appointments.stream()
	                     .filter(appt -> appt.getPatient().getId() == patient.getId())
	                     .allMatch(appt -> !appt.getAppointment_date().isBefore(periodStart));
	             })
	             .count();
	         
	         report.put("newPatients", newPatients);
	         report.put("returningPatients", patients.size() - newPatients);
	         
	         // Patient status
	         Map<String, Long> patientStatus = patients.stream()
	             .collect(Collectors.groupingBy(
	                 Patient::getStatus,
	                 Collectors.counting()
	             ));
	         report.put("patientStatus", patientStatus);
	         
	         return report;
	     }
	     
	     private Map<String, Object> generateEarningsReport(Doctor doctor,
	                                                       List<Appointments> appointments,
	                                                       LocalDate start, LocalDate end) {
	         Map<String, Object> report = new HashMap<>();
	         report.put("title", "Earnings Report");
	         report.put("period", start + " to " + end);
	         
	         // Note: You'll need to add consultation_fee field to Appointments model
	         // or create a separate Earnings model. For now, using mock data.
	         
	         // Mock consultation fees based on appointment type/reason
	         Map<String, Double> feeStructure = new HashMap<>();
	         feeStructure.put("Consultation", 500.0);
	         feeStructure.put("Follow-up", 300.0);
	         feeStructure.put("Emergency", 1000.0);
	         feeStructure.put("Routine Checkup", 400.0);
	         
	         // Calculate earnings
	         double totalEarnings = 0;
	         Map<String, Double> earningsByType = new HashMap<>();
	         Map<String, Double> dailyEarnings = new LinkedHashMap<>();
	         
	         LocalDate current = start;
	         while (!current.isAfter(end)) {
	             dailyEarnings.put(current.format(DateTimeFormatter.ofPattern("dd/MM")), 0.0);
	             current = current.plusDays(1);
	         }
	         
	         for(Appointments appt : appointments) {
	             if("Confirmed".equals(appt.getAppointment_status())) {
	                 String reason = appt.getReason();
	                 double fee = feeStructure.getOrDefault(reason, 500.0);
	                 
	                 totalEarnings += fee;
	                 
	                 // Add to reason-based earnings
	                 earningsByType.put(reason, earningsByType.getOrDefault(reason, 0.0) + fee);
	                 
	                 // Add to daily earnings
	                 String dateKey = appt.getAppointment_date().format(DateTimeFormatter.ofPattern("dd/MM"));
	                 dailyEarnings.put(dateKey, dailyEarnings.get(dateKey) + fee);
	             }
	         }
	         
	         report.put("totalEarnings", totalEarnings);
	         report.put("earningsByType", earningsByType);
	         report.put("dailyEarnings", dailyEarnings);
	         
	         // Calculate average per appointment
	         long confirmedAppointments = appointments.stream()
	             .filter(appt -> "Confirmed".equals(appt.getAppointment_status()))
	             .count();
	         
	         double avgPerAppointment = confirmedAppointments > 0 ? totalEarnings / confirmedAppointments : 0;
	         report.put("avgPerAppointment", avgPerAppointment);
	         report.put("totalConsultations", confirmedAppointments);
	         
	         return report;
	     }
	     
	     private Map<String, Object> generatePrescriptionReport(Doctor doctor,
	                                                           List<Appointments> appointments,
	                                                           LocalDate start, LocalDate end) {
	         Map<String, Object> report = new HashMap<>();
	         report.put("title", "Prescriptions Report");
	         report.put("period", start + " to " + end);
	         
	         // Note: You'll need to create a Prescription model and repository
	         // For now, using mock data
	         
	         // Mock prescription data
	         List<Map<String, Object>> prescriptions = new ArrayList<>();
	         String[] medications = {"Paracetamol", "Amoxicillin", "Ibuprofen", "Cetirizine", "Omeprazole"};
	         String[] frequencies = {"Once daily", "Twice daily", "Thrice daily", "As needed"};
	         
	         Random random = new Random();
	         for(Appointments appt : appointments) {
	             if("Confirmed".equals(appt.getAppointment_status())) {
	                 Map<String, Object> prescription = new HashMap<>();
	                 prescription.put("date", appt.getAppointment_date());
	                 prescription.put("patient", appt.getPatient().getName());
	                 prescription.put("medication", medications[random.nextInt(medications.length)]);
	                 prescription.put("dosage", (random.nextInt(3) + 1) + " tablet(s)");
	                 prescription.put("frequency", frequencies[random.nextInt(frequencies.length)]);
	                 prescription.put("duration", (random.nextInt(7) + 3) + " days");
	                 prescriptions.add(prescription);
	             }
	         }
	         
	         report.put("prescriptions", prescriptions);
	         report.put("totalPrescriptions", prescriptions.size());
	         
	         // Medication frequency
	         Map<String, Long> medicationFrequency = new HashMap<>();
	         for(Map<String, Object> pres : prescriptions) {
	             String med = (String) pres.get("medication");
	             medicationFrequency.put(med, medicationFrequency.getOrDefault(med, 0L) + 1);
	         }
	         report.put("medicationFrequency", medicationFrequency);
	         
	         return report;
	     }
	    
}
