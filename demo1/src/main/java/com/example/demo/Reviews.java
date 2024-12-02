package com.example.demo;


import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "Reviews")
public class Reviews {

    @Id
    @Column(name = "review_id", nullable = false)
    private Long reviewId;

    @Column(name = "rating", nullable = false)
    private Integer rating;

    @Column(name = "review_text", length = 1000)
    private String reviewText;

    @Temporal(TemporalType.DATE)
    @Column(name = "review_date", nullable = false)
    private Date reviewDate;

    @ManyToOne
    @JoinColumn(name = "product_id", nullable = false)
    private Products product;

    @ManyToOne
    @JoinColumn(name = "buyer_id", nullable = false)
    private Users buyer;

    @ManyToOne
    @JoinColumn(name = "order_id", nullable = false)
    private Orders order;

    // Default constructor
    public Reviews() {
    }

    // Constructor with fields
    public Reviews(Integer rating, String reviewText, Date reviewDate, Products product, Users buyer, Orders order) {
        this.rating = rating;
        this.reviewText = reviewText;
        this.reviewDate = reviewDate;
        this.product = product;
        this.buyer = buyer;
        this.order=order;
    }

    // Getters and Setters
    public Long getReviewId() {
        return reviewId;
    }

    public void setReviewId(Long reviewId) {
        this.reviewId = reviewId;
    }

    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public String getReviewText() {
        return reviewText;
    }

    public void setReviewText(String reviewText) {
        this.reviewText = reviewText;
    }

    public Date getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(Date reviewDate) {
        this.reviewDate = reviewDate;
    }

    public void setOrder(Orders order) {
        this.order = order;
    }
    public Orders getOrder() {
        return order;
    }

    public Products getProduct() {
        return product;
    }

    public void setProduct(Products product) {
        this.product = product;
    }

    public Users getBuyer() {
        return buyer;
    }

    public void setBuyer(Users buyer) {
        this.buyer = buyer;
    }

    @Override
    public String toString() {
        return "Reviews{" +
                "reviewId=" + reviewId +
                ", rating=" + rating +
                ", reviewText='" + reviewText + '\'' +
                ", reviewDate=" + reviewDate +
                ", product=" + (product != null ? product.getName() : "null") +
                ", buyer=" + (buyer != null ? buyer.getName() : "null") +
                ", order=" + (order != null ? order.getOrderId() : "null") +
                '}';
    }
}

