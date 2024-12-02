package com.example.demo;


import com.example.demo.Orders;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface OrdersRepository extends JpaRepository<Orders, Long> {

    // Custom query method to find all orders for a specific buyer
    List<Orders> findByBuyer_UserId(Long userId);

    // Custom query method to find orders by order status
    List<Orders> findByOrderStatus(String orderStatus);

    // Custom query method to find orders shipped after a specific date
    List<Orders> findByShippedDateAfter(Date date);

    // Custom query method to find orders delivered between two dates
    List<Orders> findByDeliveredDateBetween(Date startDate, Date endDate);
}

