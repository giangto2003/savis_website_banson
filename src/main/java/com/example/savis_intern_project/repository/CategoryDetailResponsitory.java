package com.example.savis_intern_project.repository;

import com.example.savis_intern_project.entity.CategoryDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface CategoryDetailResponsitory extends JpaRepository<CategoryDetail,UUID> {
}
