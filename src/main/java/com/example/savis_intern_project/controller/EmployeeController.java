package com.example.savis_intern_project.controller;


import com.example.savis_intern_project.entity.Employee;
import com.example.savis_intern_project.entity.Role;
import com.example.savis_intern_project.service.EmployeeService;
import com.example.savis_intern_project.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Controller

public class EmployeeController {
    @Autowired
    EmployeeService employeeService;
    @Autowired
    RoleService roleService;

    @GetMapping("/employee/index")
    public String HienThi(Model model) {
        List<Employee> customerList = employeeService.findAll() ;
        model.addAttribute("empList", customerList);

        return "/Employee/index";
    }

    @PostMapping("/employee/update")
    public String updte(Model model,
                          @RequestParam("id") UUID id,
                          @RequestParam("fullName") String fullName,
                          @RequestParam("username") String username,
                          @RequestParam("password") String password,
                          @RequestParam("image") String image,
                          @RequestParam("dateOfBirth") String dateOfBirth,
                          @RequestParam("gender") int gender,

                          @RequestParam("phoneNumber") String phoneNumber,
                          @RequestParam("email") String email,
                          @RequestParam("address") String address,
                          @RequestParam("status") int status,
                          @RequestParam("idRole")String idRole
                          ) {
        Employee employee = new Employee();
        Role rl = roleService.detail(UUID.fromString(idRole));
        employee.setId(id);
        employee.setFullName(fullName);
        employee.setDateOfBirth(dateOfBirth );
        employee.setAddress(address);
        employee.setPhoneNumber(phoneNumber);

        employee.setEmail(email);
        employee.setGender(gender);
        employee.setStatus(status);
        employee.setUsername(username);
        employee.setPassword(password);
        employee.setImage(image);
        employee.setRole(rl);
        employeeService.add(employee);
        return "redirect:/employee/index";
    }

    @PostMapping("/employee/add")
    public String add(
                        @RequestParam("fullName") String fullName,
                        @RequestParam("username") String username,
                        @RequestParam("password") String password,
                        @RequestParam("image") String image,
                        @RequestParam("dateOfBirth") String dateOfBirth,
                        @RequestParam("gender") int gender,
                        @RequestParam("phoneNumber") String phoneNumber,
                        @RequestParam("email") String email,
                        @RequestParam("address") String address,
                        @RequestParam("idRole")String idRole
    ) {
        Employee employee = new Employee();


        Date currentDate = new Date(System.currentTimeMillis());

        employee.setFullName(fullName);
        employee.setDateOfBirth(dateOfBirth );
        employee.setAddress(address);
        employee.setPhoneNumber(phoneNumber);
        employee.setDatecreated(String.valueOf(currentDate));
        employee.setEmail(email);
        employee.setGender(gender);
        employee.setStatus(1);
        employee.setUsername(username);
        employee.setPassword(password);
        employee.setImage(image);
        employee.setRole(roleService.detail(UUID.fromString(idRole)));
        employeeService.add(employee);
        return "redirect:/employee/index";
    }


    @GetMapping("/employee/detail/{id}")
    public String detail(Model model, @PathVariable("id") UUID id) {
        model.addAttribute("emp", employeeService.detail(id));
        model.addAttribute("role", roleService.getAll());


        return "/Employee/detail";

    }

    @GetMapping("/employee/viewAdd")
    public String viewAdd(Model model) {
        model.addAttribute("role", roleService.getAll());
        return "/Employee/add";

    }

    @GetMapping("/employee/role")
    public String role(Model model) {
        model.addAttribute("role",roleService.getAll());
        return "/Employee/role";

    }

    @GetMapping("/employee/timKiem")
    public String timKiem(Model model,
                          @RequestParam("name1")String name,
                          @RequestParam("phone1")String phone) {

        if (name ==""||phone==""){
            model.addAttribute("tim",employeeService.timKiem(name,phone));
        }
        if(name ==""&&phone==""){
            model.addAttribute("empList",employeeService.findAll());
        }
        else{
            model.addAttribute("tim",employeeService.timKiem2(name,phone));
        }

        return "/Employee/index";

    }
}
