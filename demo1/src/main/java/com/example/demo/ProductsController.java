package com.example.demo;


import com.example.demo.Products;
import com.example.demo.ProductsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/products")
public class ProductsController {

    @Autowired
    private ProductsRepository productsRepository;

    // GET: Fetch all products
    @GetMapping
    public ResponseEntity<String> getAllProducts() {
        List<Products> products = productsRepository.findAll();

        if (products.isEmpty()) {
            return ResponseEntity.ok("No products found.");
        }

        String productsAsString = products.stream()
                .map(Products::toString)
                .reduce((product1, product2) -> product1 + "\n" + product2)
                .orElse("No products found.");

        return ResponseEntity.ok(productsAsString);
    }

    // GET: Fetch a specific product by ID
    @GetMapping("/{id}")
    public ResponseEntity<String> getProductById(@PathVariable Long id) {
        Products product = productsRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found with ID: " + id));
        return ResponseEntity.ok(product.toString());
    }

    // GET: Fetch products by category ID
    @GetMapping("/category/{categoryId}")
    public ResponseEntity<String> getProductsByCategory(@PathVariable Long categoryId) {
        List<Products> products = productsRepository.findByCategory_CategoryId(categoryId);

        if (products.isEmpty()) {
            return ResponseEntity.ok("No products found for category with ID: " + categoryId);
        }

        String productsAsString = products.stream()
                .map(Products::toString)
                .reduce((product1, product2) -> product1 + "\n" + product2)
                .orElse("No products found for category with ID: " + categoryId);

        return ResponseEntity.ok(productsAsString);
    }


    // GET: Search products by name
    @GetMapping("/search")
    public List<Products> searchProductsByName(@RequestParam String name) {
        return productsRepository.findByNameContainingIgnoreCase(name);
    }

    // POST: Create a new product
    @PostMapping
    public ResponseEntity<Products> createProduct(@RequestBody Products product) {
        Products createdProduct = productsRepository.save(product);
        return ResponseEntity.ok(createdProduct);
    }

    // PUT: Update an existing product
    @PutMapping("/{id}")
    public ResponseEntity<Products> updateProduct(@PathVariable Long id, @RequestBody Products productDetails) {
        Products product = productsRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found with ID: " + id));

        // Update only non-null fields
        if (productDetails.getName() != null) {
            product.setName(productDetails.getName());
        }
        if (productDetails.getDescription() != null) {
            product.setDescription(productDetails.getDescription());
        }
        if (productDetails.getPrice() != null) {
            product.setPrice(productDetails.getPrice());
        }
        if (productDetails.getAvailabilityStatus() != null) {
            product.setAvailabilityStatus(productDetails.getAvailabilityStatus());
        }
        if (productDetails.getQuantityInStock() != null) {
            product.setQuantityInStock(productDetails.getQuantityInStock());
        }
        if (productDetails.getProductImageUrl() != null) {
            product.setProductImageUrl(productDetails.getProductImageUrl());
        }

        Products updatedProduct = productsRepository.save(product);
        return ResponseEntity.ok(updatedProduct);
    }


    // DELETE: Delete a product by ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteProduct(@PathVariable Long id) {
        Products product = productsRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found with ID: " + id));

        productsRepository.delete(product);
        return ResponseEntity.noContent().build();
    }
}

