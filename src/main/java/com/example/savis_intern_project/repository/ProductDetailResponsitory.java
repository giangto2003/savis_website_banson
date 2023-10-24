package com.example.savis_intern_project.repository;


import com.example.savis_intern_project.entity.Customer;
import com.example.savis_intern_project.entity.ProductDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface ProductDetailResponsitory extends JpaRepository<ProductDetail, UUID> {
    @Query("SELECT c from ProductDetail c WHERE c.id=?1")
    ProductDetail getProductDetailById(UUID id);
}
