package com.example.demo;


import jakarta.persistence.*;

@Entity
@Table(name = "Products")
public class Products {

    @Id
    @Column(name = "product_id", nullable = false)
    private Long productId;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "description", nullable = false)
    private String description;

    @Column(name = "price", nullable = false)
    private Double price;

    @Column(name = "availability_status", nullable = false)
    private String availabilityStatus;

    @Column(name = "quantity_in_stock", nullable = false)
    private Integer quantityInStock;

    @Column(name = "product_image_url", nullable = true)
    private String productImageUrl;

    @ManyToOne
    @JoinColumn(name = "category_id", nullable = false)
    private Categories category;

    @ManyToOne
    @JoinColumn(name = "seller_id", nullable = false)
    private Sellers seller;

    // Default constructor
    public Products() {
    }

    // Constructor with fields
    public Products(String name, String description, Double price, String availabilityStatus,
                    Integer quantityInStock, String productImageUrl, Categories category, Sellers seller) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.availabilityStatus = availabilityStatus;
        this.quantityInStock = quantityInStock;
        this.productImageUrl = productImageUrl;
        this.category = category;
        this.seller = seller;
    }

    // Getters and Setters
    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getAvailabilityStatus() {
        return availabilityStatus;
    }

    public void setAvailabilityStatus(String availabilityStatus) {
        this.availabilityStatus = availabilityStatus;
    }

    public Integer getQuantityInStock() {
        return quantityInStock;
    }

    public void setQuantityInStock(Integer quantityInStock) {
        this.quantityInStock = quantityInStock;
    }

    public String getProductImageUrl() {
        return productImageUrl;
    }

    public void setProductImageUrl(String productImageUrl) {
        this.productImageUrl = productImageUrl;
    }

    public Categories getCategory() {
        return category;
    }

    public void setCategory(Categories category) {
        this.category = category;
    }

    public Sellers getSeller() {
        return seller;
    }

    public void setSeller(Sellers seller) {
        this.seller = seller;
    }

    @Override
    public String toString() {
        return "Products{" +
                "productId=" + productId +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", availabilityStatus='" + availabilityStatus + '\'' +
                ", quantityInStock=" + quantityInStock +
                ", productImageUrl='" + productImageUrl + '\'' +
                ", category=" + (category != null ? category.getCategoryName() : "null") +
                ", seller=" + (seller != null ? seller.getBusinessName() : "null") +
                '}';
    }
}

