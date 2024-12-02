package com.example.demo;


import com.example.demo.Reviews;
import com.example.demo.ReviewsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reviews")
public class ReviewsController {

    @Autowired
    private ReviewsRepository reviewsRepository;

    @Autowired
    private OrdersRepository OrdersRepository;

    // GET: Fetch all reviews

    @GetMapping
    public ResponseEntity<String> getAllReviews() {
        List<Reviews> reviews = reviewsRepository.findAll();

        if (reviews.isEmpty()) {
            return ResponseEntity.ok("No reviews found.");
        }

        String reviewsAsString = reviews.stream()
                .map(Reviews::toString)
                .reduce((review1, review2) -> review1 + "\n" + review2)
                .orElse("No reviews found.");

        return ResponseEntity.ok(reviewsAsString);
    }

    // GET: Fetch a specific review by ID
    @GetMapping("/{id}")
    public ResponseEntity<String> getReviewById(@PathVariable Long id) {
        Reviews review = reviewsRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Review not found with ID: " + id));
        return ResponseEntity.ok(review.toString());
    }

    // GET: Fetch reviews for a specific product
    @GetMapping("/product/{productId}")
    public ResponseEntity<String> getReviewsByProduct(@PathVariable Long productId) {
        List<Reviews> reviews = reviewsRepository.findByProduct_ProductId(productId);

        if (reviews.isEmpty()) {
            return ResponseEntity.ok("No reviews found for product with ID: " + productId);
        }

        String reviewsAsString = reviews.stream()
                .map(Reviews::toString)
                .reduce((review1, review2) -> review1 + "\n" + review2)
                .orElse("No reviews found for product with ID: " + productId);

        return ResponseEntity.ok(reviewsAsString);
    }


    // GET: Fetch reviews by a specific buyer
    @GetMapping("/buyer/{buyerId}")
    public List<Reviews> getReviewsByBuyer(@PathVariable Long buyerId) {
        return reviewsRepository.findByBuyer_UserId(buyerId);
    }

    // GET: Fetch reviews with a specific rating
    @GetMapping("/rating/{rating}")
    public List<Reviews> getReviewsByRating(@PathVariable Integer rating) {
        return reviewsRepository.findByRating(rating);
    }

    // POST: Create a new review
    @PostMapping
    public ResponseEntity<?> createReview(@RequestBody Reviews review) {
        Reviews createdReview = reviewsRepository.save(review);
        return ResponseEntity.ok(createdReview);
    }


    // PUT: Update an existing review
    // PUT: Update an existing review
    @PutMapping("/{id}")
    public ResponseEntity<Reviews> updateReview(@PathVariable Long id, @RequestBody Reviews reviewDetails) {
        Reviews review = reviewsRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Review not found with ID: " + id));

        // Update only non-null fields
        if (reviewDetails.getRating() != null) {
            review.setRating(reviewDetails.getRating());
        }
        if (reviewDetails.getReviewText() != null) {
            review.setReviewText(reviewDetails.getReviewText());
        }
        if (reviewDetails.getReviewDate() != null) {
            review.setReviewDate(reviewDetails.getReviewDate());
        }
        if (reviewDetails.getProduct() != null) {
            review.setProduct(reviewDetails.getProduct());
        }
        if (reviewDetails.getBuyer() != null) {
            review.setBuyer(reviewDetails.getBuyer());
        }

        Reviews updatedReview = reviewsRepository.save(review);
        return ResponseEntity.ok(updatedReview);
    }


    // DELETE: Delete a review by ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteReview(@PathVariable Long id) {
        Reviews review = reviewsRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Review not found with ID: " + id));

        reviewsRepository.delete(review);
        return ResponseEntity.noContent().build();
    }
}

