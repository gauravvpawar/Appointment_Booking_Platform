package com.example.demo.Controller;

import java.io.File;
import java.io.IOException;

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

import com.example.demo.Model.Patient;
import com.example.demo.Model.PatientInfo;
import com.example.demo.Service.PatientService;


@Controller
@RequestMapping("/patient")
public class PatientController 
{

    private final PasswordEncoder passwordEncoder;
	@Autowired
	PatientService ps;

    PatientController(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }
	
	@RequestMapping("/")
	public String home()
	{
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
		
		System.out.println("Patient details : "  + patient);
		
		m.addAttribute("patient", patient);
		
		redirectAttributes.addFlashAttribute("msg", "Logged in successfully");

		
		return "Patient/PatientDashBoard";
	}
	
	@GetMapping("/DashBoard/{id}")
	public String dashboard(@PathVariable int id ,Model m,  RedirectAttributes redirectAttributes , HttpSession hs)
	{
		Patient patient =  ps.findById(id);
		
		hs.setAttribute("patient", patient);
		
		System.out.println("Patient details : "  + patient);
		
		m.addAttribute("patient", patient);
		
		redirectAttributes.addFlashAttribute("msg", "Logged in successfully");
		
		return "Patient/PatientDashBoard";
	}
	
	
	@GetMapping("/logOut")
	public String logOut(HttpSession hs)
	{
		hs.invalidate();
		
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
		
		System.out.println(patient);
		
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
	     
	     redirectAttributes.addFlashAttribute("success", "Patient updated successfully!");
		
		return "redirect:/patient/DashBoard/{id}";
	}
	
	
	// to book appointment
	@GetMapping("/BookAppointment/{id}")
	public String bookAppointment(@PathVariable int id , Model m)
	{
		Patient patient = ps.findById(id);
		
		m.addAttribute("patient", patient);
		
		return "Patient/AppointmentBook";
	}

	// register appointment on working
	// working
//	@PostMapping("/RegisterAppointment/${id}")
//	public String registerAppointment(@PathVariable int id)
//	{
//		return null;
//	}
}
