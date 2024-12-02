package com.example.demo;

import com.example.demo.Reviews;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewsRepository extends JpaRepository<Reviews, Long> {

    // Custom query method to find all reviews for a specific product
    List<Reviews> findByProduct_ProductId(Long productId);

    // Custom query method to find all reviews by a specific buyer
    List<Reviews> findByBuyer_UserId(Long userId);

    // Custom query method to find all reviews with a specific rating
    List<Reviews> findByRating(Integer rating);

    // Custom query method to find all reviews for a specific product with a rating greater than or equal to a threshold
    List<Reviews> findByProduct_ProductIdAndRatingGreaterThanEqual(Long productId, Integer rating);
}

