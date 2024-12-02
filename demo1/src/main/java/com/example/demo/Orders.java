package com.example.demo;


import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "Orders")
public class Orders {

    @Id
    @Column(name = "order_id", nullable = false)
    private Long orderId;

    @Column(name = "order_status", nullable = false)
    private String orderStatus;

    @Temporal(TemporalType.DATE)
    @Column(name = "shipped_date")
    private Date shippedDate;

    @Temporal(TemporalType.DATE)
    @Column(name = "delivered_date")
    private Date deliveredDate;

    @ManyToOne
    @JoinColumn(name = "buyer_id", nullable = false)
    private Users buyer;

    // Default constructor
    public Orders() {
    }

    // Constructor with fields
    public Orders(String orderStatus, Date shippedDate, Date deliveredDate, Users buyer) {
        this.orderStatus = orderStatus;
        this.shippedDate = shippedDate;
        this.deliveredDate = deliveredDate;
        this.buyer = buyer;
    }

    // Getters and Setters
    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Date getShippedDate() {
        return shippedDate;
    }

    public void setShippedDate(Date shippedDate) {
        this.shippedDate = shippedDate;
    }

    public Date getDeliveredDate() {
        return deliveredDate;
    }

    public void setDeliveredDate(Date deliveredDate) {
        this.deliveredDate = deliveredDate;
    }

    public Users getBuyer() {
        return buyer;
    }

    public void setBuyer(Users buyer) {
        this.buyer = buyer;
    }

    @Override
    public String toString() {
        return "Orders{" +
                "orderId=" + orderId +
                ", orderStatus='" + orderStatus + '\'' +
                ", shippedDate=" + shippedDate +
                ", deliveredDate=" + deliveredDate +
                ", buyer=" + (buyer != null ? buyer.getName() : "null") +
                '}';
    }
}

