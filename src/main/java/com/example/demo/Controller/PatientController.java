package com.example.demo.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	    p.setPassword(passwordEncoder.encode(p.getPassword()));
	    System.out.println(p);
	    
	    p.setCnfPassword(null); 
	    
	    
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
}
