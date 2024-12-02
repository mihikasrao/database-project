package com.example.demo;


import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "Sellers")
public class Sellers {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "seller_id")
    private Long sellerId;

    @Column(name = "business_name", nullable = false, unique = true)
    private String businessName;


    @OneToMany(mappedBy = "seller", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Products> products;

    // Default constructor
    public Sellers() {
    }

    // Constructor with fields
    public Sellers(String businessName) {
        this.businessName = businessName;

    }

    // Getters and Setters
    public Long getSellerId() {
        return sellerId;
    }

    public void setSellerId(Long sellerId) {
        this.sellerId = sellerId;
    }

    public String getBusinessName() {
        return businessName;
    }

    public void setBusinessName(String businessName) {
        this.businessName = businessName;
    }


    public List<Products> getProducts() {
        return products;
    }

    public void setProducts(List<Products> products) {
        this.products = products;
    }

    @Override
    public String toString() {
        return "Sellers{" +
                "sellerId=" + sellerId +
                ", businessName='" + businessName + '\''+
                '}';
    }
}

