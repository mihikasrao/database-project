package com.example.demo;


import com.example.demo.Orders;
import com.example.demo.OrdersRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/api/orders")
public class OrdersController {

    @Autowired
    private OrdersRepository ordersRepository;

    // GET: Fetch all orders
    @GetMapping
    public ResponseEntity<String> getAllOrders() {
        List<Orders> orders = ordersRepository.findAll();

        if (orders.isEmpty()) {
            return ResponseEntity.ok("No orders found.");
        }

        String ordersAsString = orders.stream()
                .map(Orders::toString)
                .reduce((order1, order2) -> order1 + "\n" + order2)
                .orElse("No orders found.");

        return ResponseEntity.ok(ordersAsString);
    }

    // GET: Fetch a specific order by ID
    @GetMapping("/{id}")
    public ResponseEntity<String> getOrderById(@PathVariable Long id) {
        Orders order = ordersRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Order not found with ID: " + id));
        return ResponseEntity.ok(order.toString());
    }

    // GET: Fetch orders by buyer ID
    @GetMapping("/buyer/{buyerId}")
    public List<Orders> getOrdersByBuyer(@PathVariable Long buyerId) {
        return ordersRepository.findByBuyer_UserId(buyerId);
    }

    // GET: Fetch orders by status
    @GetMapping("/status/{status}")
    public ResponseEntity<String> getOrdersByStatus(@PathVariable String status) {
        List<Orders> orders = ordersRepository.findByOrderStatus(status);

        if (orders.isEmpty()) {
            return ResponseEntity.ok("No orders found with status: " + status);
        }

        String ordersAsString = orders.stream()
                .map(Orders::toString)
                .reduce((order1, order2) -> order1 + "\n" + order2)
                .orElse("No orders found with status: " + status);

        return ResponseEntity.ok(ordersAsString);
    }


    // GET: Fetch orders shipped after a specific date
    @GetMapping("/shipped-after")
    public List<Orders> getOrdersShippedAfter(@RequestParam Date date) {
        return ordersRepository.findByShippedDateAfter(date);
    }

    // POST: Create a new order
    @PostMapping
    public ResponseEntity<Orders> createOrder(@RequestBody Orders order) {
        Orders createdOrder = ordersRepository.save(order);
        return ResponseEntity.ok(createdOrder);
    }

    // PUT: Update an existing order
    @PutMapping("/{id}")
    public ResponseEntity<Orders> updateOrder(@PathVariable Long id, @RequestBody Orders orderDetails) {
        Orders order = ordersRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Order not found with ID: " + id));

        // Update only non-null fields
        if (orderDetails.getOrderStatus() != null) {
            order.setOrderStatus(orderDetails.getOrderStatus());
        }
        if (orderDetails.getShippedDate() != null) {
            order.setShippedDate(orderDetails.getShippedDate());
        }
        if (orderDetails.getDeliveredDate() != null) {
            order.setDeliveredDate(orderDetails.getDeliveredDate());
        }
        if (orderDetails.getBuyer() != null) {
            order.setBuyer(orderDetails.getBuyer());
        }

        Orders updatedOrder = ordersRepository.save(order);
        return ResponseEntity.ok(updatedOrder);
    }

    // DELETE: Delete an order by ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteOrder(@PathVariable Long id) {
        Orders order = ordersRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Order not found with ID: " + id));

        ordersRepository.delete(order);
        return ResponseEntity.noContent().build();
    }
}

