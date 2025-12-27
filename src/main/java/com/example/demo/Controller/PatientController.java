package com.example.demo.Controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

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

import com.example.demo.Model.Appointments;
import com.example.demo.Model.Doctor;
import com.example.demo.Model.Patient;
import com.example.demo.Model.PatientInfo;
import com.example.demo.Service.AppointmentService;
import com.example.demo.Service.DoctorService;
import com.example.demo.Service.PatientService;


@Controller
@RequestMapping("/patient")
public class PatientController 
{

    private final PasswordEncoder passwordEncoder;

	@Autowired
	PatientService ps;
	
	@Autowired
	DoctorService ds;

	@Autowired
	AppointmentService as;


    PatientController(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }
	
    
	@RequestMapping("/")
	public String home(Model m)
	{
		List<Doctor> doctorList = ds.findAllDoctor();
		m.addAttribute("doctorList", doctorList);
		return "index";
	}
	
	
	@RequestMapping("/login")
	public String PatientLogin()
	{
		return "Patient/PatientLogin";
	}

	@RequestMapping("/register")
	public String PatientRegister()
	{
		
		return "Patient/PatientRegister";
	}
	
//	to register user
	@RequestMapping("/savePatient")
	public String savePatient(@ModelAttribute Patient p , RedirectAttributes redirectAttribute)
	{
		
	    if (p.getPatientinfo() == null) {
	        PatientInfo info = new PatientInfo();
	        p.setPatientinfo(info);
	    }

	    // to encypt password
	    if(p.getPassword().equals(p.getCnfPassword()))
	    {
	    	p.setPassword(passwordEncoder.encode(p.getPassword()));
	    	System.out.println(p);
	    	p.setCnfPassword(passwordEncoder.encode(p.getCnfPassword())); 	    	
	    }else {
	    	redirectAttribute.addFlashAttribute("msg","Patient password not match with Confirm Password");
			
			return "redirect:/";
	    }
	    
	    
	    
		ps.savePatient(p);
		
		redirectAttribute.addFlashAttribute("msg","Patient registered Successfully");
		
		return "redirect:/";
	}
	
	
	// patient login action
	@RequestMapping("/loginPatient")
	public String loginPatient(@RequestParam("email") String email , @RequestParam("password") String password , RedirectAttributes redirectattributes , Model m , HttpSession hs , RedirectAttributes redirectAttributes)
	{
		
		System.out.println(email + " " + password);
		
//		Patient patient =  ps.loginPatient(email, password);
		
		Patient patient = ps.findByEmail(email);

		if(patient == null|| patient.getPassword() == null || !passwordEncoder.matches(password, patient.getPassword()))
		{
			redirectattributes.addFlashAttribute("msg","Patient Login Failure");
			return "redirect:/";
		}
		
		hs.setAttribute("patient", patient);
		
		System.out.println("Patient details : "  + patient.getName());
		
		m.addAttribute("patient", patient);
		
		m.addAttribute("msg", "Logged in successfully");
		
		 // Get patient's existing appointments
        List<Appointments> patientAppointments = as.findByPatient(patient);
        m.addAttribute("patientAppointments", patientAppointments);
		
		return "Patient/PatientDashBoard";
	}
	
	@GetMapping("/DashBoard/{id}")
	public String dashboard(@PathVariable int id ,Model m,  RedirectAttributes redirectAttributes , HttpSession hs)
	{
		Patient patient =  ps.findById(id);
		
		hs.setAttribute("patient", patient);
		
//		System.out.println("Patient details : "  + patient.getName());
		
		m.addAttribute("patient", patient);
		
		redirectAttributes.addFlashAttribute("msg", "Logged in successfully");
		
		 // Get patient's existing appointments
        List<Appointments> patientAppointments = as.findByPatient(patient);
        m.addAttribute("patientAppointments", patientAppointments);
		
		return "Patient/PatientDashBoard";
	}
	
	
	@GetMapping("/logOut")
	public String logOut(HttpSession hs , RedirectAttributes redirectAttributes)
	{
		hs.invalidate();
		redirectAttributes.addFlashAttribute("msg", "Logged Out successfully");
		return "redirect:/";
	}
	
	@GetMapping("/forgotPassword")
	public String forgotPassword()
	{
		return "Patient/ForgotPassword";
	}
	
	// to update password
	@RequestMapping("/updatePassword")
	public String UpdatePassword(@RequestParam("email") String email , @RequestParam("password") String password , @RequestParam("cnfPassword") String cnfPassword , RedirectAttributes redirectAttribute)
	{
		Patient patient = ps.findByEmail(email);
		
		if(patient == null)
		{
			redirectAttribute.addFlashAttribute("msg","Patient Login Failure");
			return "redirect:/";
		}
		
		patient.setPassword(passwordEncoder.encode(password));
		patient.setCnfPassword(passwordEncoder.encode(cnfPassword));
		
		ps.savePatient(patient);
		
		redirectAttribute.addFlashAttribute("msg","Password Updated Successfully");
		
		
		return "redirect:/";
	}
	
	// to edit patient data 
	@GetMapping("/PatientEditForm/{id}")
	public String editForm(@PathVariable int id , Model m)
	{
		Patient patient = ps.findById(id);
		
		
		// to encode the patient password
		
//		System.out.println(patient);
		
		m.addAttribute("patient", patient);
		
		return "Patient/PatientEditForm";
	}
	
	@PostMapping("/UpdateData/{id}")
	public String UpdateDate(@PathVariable int id , @ModelAttribute Patient formPatient , RedirectAttributes redirectAttributes , @RequestParam MultipartFile fname) throws IllegalStateException, IOException
	{
		Patient existingPatient = ps.findById(id);


		 existingPatient.setName(formPatient.getName());
	     existingPatient.setPhone(formPatient.getPhone());
	     existingPatient.setGender(formPatient.getGender());
	     existingPatient.setAge(formPatient.getAge());
	     existingPatient.setStatus(formPatient.getStatus());
		
	     
	     if (formPatient.getPassword() != null && !formPatient.getPassword().isEmpty()) {
	         if (formPatient.getPassword().equals(formPatient.getCnfPassword())) {
	        	 String password = formPatient.getPassword();
	             existingPatient.setPassword(passwordEncoder.encode(password));
	             existingPatient.setCnfPassword(passwordEncoder.encode(password));
	         } else {
	             redirectAttributes.addFlashAttribute("msg", "Passwords do not match!");
	             return  "redirect:/patient/DashBoard/{id}";
	         }
	     }
	     
	     // Update embedded PatientInfo
	        PatientInfo info = existingPatient.getPatientinfo();
	        if (info == null) {
	            info = new PatientInfo();
	        }
	        info.setDob(formPatient.getPatientinfo().getDob());
	        info.setAddress(formPatient.getPatientinfo().getAddress());
	        info.setBloodGroup(formPatient.getPatientinfo().getBloodGroup());
	        info.setEmergencyContact(formPatient.getPatientinfo().getEmergencyContact());
	        
	        
//	        to set file
	        if(fname != null && !fname.isEmpty())
	        {
	        	String path = "C:\\Users\\ASUS\\OneDrive\\Desktop\\Appointment_Booking_Platform\\Appointment_Booking_Application\\src\\main\\resources\\static\\images";
	        	File file = new File(path);
	        	
	        	String fn = fname.getOriginalFilename();
	        	
	        	fname.transferTo(new File(file , fn));
	        	
	        	info.setFileName(fn);
	        }
	        
	       
	     existingPatient.setPatientinfo(info);
	     
	     System.out.println(existingPatient);
	     
	     ps.savePatient(existingPatient);
	     
	     redirectAttributes.addFlashAttribute("msg", "Patient updated successfully!");
		
		return "redirect:/patient/DashBoard/{id}";
	}
	
	
	// to book appointment
	@GetMapping("/BookAppointment/{id}")
    public String bookAppointment(@PathVariable int id , Model m, HttpSession session)
    {
        Patient patient = ps.findById(id);
        
        if(patient == null) {
            return "redirect:/";
        }
        
        m.addAttribute("patient", patient);
        
       
        
        // to return the list of doctor who is active
        List<Doctor> doctorList = ds.findAllDoctor().stream()
                                                    .filter(d -> "Active".equals(d.getStatus())).toList();
        
        m.addAttribute("doctors", doctorList);
        
        // Add new appointment object for form binding
        Appointments newAppointment = new Appointments();
        m.addAttribute("appointment", newAppointment);
        
        return "Patient/AppointmentBook";
    }

	// to book Appointment
	@PostMapping("/RegisterAppointment/{patientId}")
	public String registerAppointment(
	        @PathVariable int patientId,
	        @ModelAttribute Appointments appointment,
	        @RequestParam("doctorId") int doctorId,
	        RedirectAttributes redirectAttributes) {

	    try {
	        Patient patient = ps.findById(patientId);
	        Doctor doctor = ds.findById(doctorId);

	        if (patient == null || doctor == null) {
	            redirectAttributes.addFlashAttribute("msg", "Invalid patient or doctor!");
	            return "redirect:/patient/BookAppointment/" + patientId;
	        }

	        appointment.setPatient(patient);
	        appointment.setDoctor(doctor);
	        appointment.setAppointment_status("Pending");

	        as.saveAppointment(appointment);

	        redirectAttributes.addFlashAttribute(
	                "msg",
	                "Appointment booked successfully! Waiting for doctor confirmation."
	        );

	    } catch (Exception e) {
	        e.printStackTrace();
	        redirectAttributes.addFlashAttribute(
	                "errorMsg",
	                "Error booking appointment!"
	        );
	    }

	    return "redirect:/patient/DashBoard/" + patientId;
	}

	
	// to view Booked Appointments
	 @GetMapping("/ViewAppointment/{patientId}/{appointmentId}")
	    public String viewAppointmentDetails(@PathVariable int patientId, 
	                                         @PathVariable int appointmentId, 
	                                         Model m, HttpSession hs) {
	        Patient patient = (Patient) hs.getAttribute("patient");
	        
	        if(patient == null) {
	            return "redirect:/patient/login";
	        }
	        
	        if(patient.getId() != patientId) {
	            return "redirect:/patient/DashBoard/" + patient.getId();
	        }
	        
	        Appointments appointment = as.findById(appointmentId);
	        
	        if(appointment == null || appointment.getPatient().getId() != patientId) {
	            m.addAttribute("errorMsg", "Appointment not found");
	            return "redirect:/patient/DashBoard/" + patientId;
	        }
	        
	        m.addAttribute("patient", patient);
	        m.addAttribute("appointment", appointment);
	        m.addAttribute("doctor", appointment.getDoctor());
	        
	        return "Patient/AppointmentDetailsModal"; 
	    }
	    
	    // Add method to cancel appointment
	    @PostMapping("/CancelAppointment/{patientId}/{appointmentId}")
	    public String cancelAppointment(@PathVariable int patientId, 
	                                    @PathVariable int appointmentId,
	                                    RedirectAttributes redirectAttributes,
	                                    HttpSession hs) {
	        Patient patient = (Patient) hs.getAttribute("patient");
	        
	        if(patient == null || patient.getId() != patientId) {
	            return "redirect:/patient/login";
	        }
	        
	        Appointments appointment = as.findById(appointmentId);
	        
	        if(appointment == null || appointment.getPatient().getId() != patientId) {
	            redirectAttributes.addFlashAttribute("msg", "Appointment not found");
	            return "redirect:/patient/DashBoard/" + patientId;
	        }
	        
	        // Only allow cancellation if status is Pending or Confirmed
	        if(appointment.getAppointment_status().equals("Pending") || 
	           appointment.getAppointment_status().equals("Confirmed")) {
	            appointment.setAppointment_status("Cancelled");
	            as.saveAppointment(appointment);
	            redirectAttributes.addFlashAttribute("msg", "Appointment cancelled successfully");
	        } else {
	            redirectAttributes.addFlashAttribute("msg", "Cannot cancel this appointment");
	        }
	        
	        return "redirect:/patient/DashBoard/" + patientId;
	    }

	
	

}
