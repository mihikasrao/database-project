package com.example.demo;

import com.example.demo.Categories;
import com.example.demo.CategoriesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/categories")
public class CategoriesController {

    @Autowired
    private CategoriesRepository categoriesRepository;

    // GET: Fetch all categories
    @GetMapping
    public ResponseEntity<String> getAllCategories() {
        List<Categories> categories = categoriesRepository.findAll();

        if (categories.isEmpty()) {
            return ResponseEntity.ok("No categories found.");
        }

        String categoriesAsString = categories.stream()
                .map(Categories::toString)
                .reduce((category1, category2) -> category1 + "\n" + category2)
                .orElse("No categories found.");

        return ResponseEntity.ok(categoriesAsString);
    }


    // GET: Fetch a specific category by ID
    @GetMapping("/{id}")
    public ResponseEntity<String> getCategoryById(@PathVariable Long id) {
        Categories category = categoriesRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Category not found with ID: " + id));
        return ResponseEntity.ok(category.toString());
    }

    // GET: Fetch a category by name
    @GetMapping("/name/{name}")
    public ResponseEntity<String> getCategoryByName(@PathVariable String name) {
        Categories category = categoriesRepository.findByCategoryName(name)
                .orElseThrow(() -> new ResourceNotFoundException("Category not found with name: " + name));
        return ResponseEntity.ok(category.toString());
    }

    // POST: Create a new category
    @PostMapping
    public ResponseEntity<Categories> createCategory(@RequestBody Categories category) {
        if (categoriesRepository.existsByCategoryName(category.getCategoryName())) {
            throw new IllegalArgumentException("Category name already exists.");
        }
        Categories createdCategory = categoriesRepository.save(category);
        return ResponseEntity.ok(createdCategory);
    }

    // PUT: Update an existing category
    @PutMapping("/{id}")
    public ResponseEntity<Categories> updateCategory(@PathVariable Long id, @RequestBody Categories categoryDetails) {
        Categories category = categoriesRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Category not found with ID: " + id));

        // Update fields only if they are not null
        if (categoryDetails.getCategoryName() != null) {
            category.setCategoryName(categoryDetails.getCategoryName());
        }

        Categories updatedCategory = categoriesRepository.save(category);
        return ResponseEntity.ok(updatedCategory);
    }


    // DELETE: Delete a category by ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCategory(@PathVariable Long id) {
        Categories category = categoriesRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Category not found with ID: " + id));

        categoriesRepository.delete(category);
        return ResponseEntity.noContent().build();
    }
}

