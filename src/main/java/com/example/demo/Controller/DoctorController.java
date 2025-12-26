package com.example.demo.Controller;

import java.io.File;
import java.io.IOException;
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
import com.example.demo.Config.AppConfig;
import com.example.demo.Model.Doctor;
import com.example.demo.Model.DoctorInfo;
import com.example.demo.Service.DoctorService;

@Controller
@RequestMapping("/doctor")
public class DoctorController 
{

    private final PasswordEncoder passwordEncoder;

	@Autowired
	DoctorService ds;


    DoctorController(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    
	@RequestMapping("/")
	public String home()
	{
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
		
		System.out.println(doctor);
		
		 if (doctor == null) {
		        redirectAttributes.addFlashAttribute("msg", "Doctor email not found");
		        return "redirect:/";
		    }
		
		if(!passwordEncoder.matches(password, doctor.getPassword()))
		{
			redirectAttributes.addFlashAttribute("msg", " Wrong Password ,try again");
			return "redirect:/";
		}
		
		hs.setAttribute("doctor", doctor);
		
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
		
		System.out.println("Doctor : " + existingDoctor);
		
		ds.saveDoctor(existingDoctor);
		
		redirectAttributes.addFlashAttribute("msg", "Data updated Successfully");
		
		return "redirect:/doctor/dashboard/{did}";
	}
	
	
//	to get all doctor data
//	@GetMapping("/getAllDoctor")
//	public List<Doctor> findAll(Model m)
//	{
//		List<Doctor> list =  ds.findAllDoctor();
//		System.out.println(list);
//		m.addAttribute("doctors", list);
//		
//		return list;
//	}
	
}
