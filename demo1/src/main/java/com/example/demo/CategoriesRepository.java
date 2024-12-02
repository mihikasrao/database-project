package com.example.demo;


import com.example.demo.Categories;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CategoriesRepository extends JpaRepository<Categories, Long> {

    // Custom query method to find a category by its name
    Optional<Categories> findByCategoryName(String categoryName);

    // Custom query method to check if a category exists by its name
    boolean existsByCategoryName(String categoryName);
}

