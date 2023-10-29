package com.example.savis_intern_project.repository;

import com.example.savis_intern_project.entity.Customer;
import com.example.savis_intern_project.entity.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;
@Repository
public interface CustomerRepository extends JpaRepository<Customer,UUID> {
    @Query("SELECT c from Customer c WHERE c.phone=?1")
    List<Customer> timKiem(String phone);

    @Query("SELECT c from Customer c where c.username=?1 and c.password=?2")
    Customer login(String username, String password);

    @Query("SELECT c from Customer c where c.username = ?1")
    Customer getCustomerByName(String username);
}
