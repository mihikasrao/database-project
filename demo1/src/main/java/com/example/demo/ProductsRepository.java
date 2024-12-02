package com.example.demo;


import com.example.demo.Products;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductsRepository extends JpaRepository<Products, Long> {

    // Custom query method to find products by category ID
    List<Products> findByCategory_CategoryId(Long categoryId);

    // Custom query method to find products by seller ID
    List<Products> findBySeller_SellerId(Long sellerId);

    // Custom query method to search products by name (case-insensitive)
    List<Products> findByNameContainingIgnoreCase(String name);

    // Custom query method to find products by availability status
    List<Products> findByAvailabilityStatus(String availabilityStatus);
}

