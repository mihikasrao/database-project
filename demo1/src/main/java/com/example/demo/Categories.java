package com.example.demo;


import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "Categories")
public class Categories {

    @Id
    @Column(name = "category_id", nullable = false)
    private Long categoryId;

    @Column(name = "category_name", nullable = false, unique = true)
    private String categoryName;

    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Products> products;

    // Default constructor
    public Categories() {
    }

    // Constructor with fields
    public Categories(String categoryName) {
        this.categoryName = categoryName;
    }

    // Getters and Setters
    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public List<Products> getProducts() {
        return products;
    }

    public void setProducts(List<Products> products) {
        this.products = products;
    }

    @Override
    public String toString() {
        String productNames = products != null && !products.isEmpty()
                ? products.stream()
                .map(Products::getName) // Assuming `getName()` retrieves the product name
                .reduce((name1, name2) -> name1 + ", " + name2)
                .orElse("No products available")
                : "No products available";

        return "Categories{" +
                "categoryId=" + categoryId +
                ", categoryName='" + categoryName + '\'' +
                ", products=[" + productNames + "]" +
                '}';
    }
}

