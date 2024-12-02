package com.example.demo;


import com.example.demo.Users;
import com.example.demo.UsersRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/users")
public class UsersController {

    @Autowired
    private UsersRepository usersRepository;

    // GET: Fetch all users
    @GetMapping
    public ResponseEntity<String> getAllUsers() {
        List<Users> users = usersRepository.findAll();

        if (users.isEmpty()) {
            return ResponseEntity.ok("No users found.");
        }

        String usersAsString = users.stream()
                .map(Users::toString)
                .reduce((user1, user2) -> user1 + "\n" + user2)
                .orElse("No users found.");

        return ResponseEntity.ok(usersAsString);
    }

    // GET: Fetch a specific user by ID
    @GetMapping("/{id}")
    public ResponseEntity<String> getUserById(@PathVariable Long id) {
        Users user = usersRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("User not found with ID: " + id));
        return ResponseEntity.ok(user.toString());
    }

    // GET: Fetch a user by email
    @GetMapping("/email/{email}")
    public ResponseEntity<String> getUserByEmail(@PathVariable String email) {
        Users user = usersRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found with email: " + email));
        return ResponseEntity.ok(user.toString());
    }

    // POST: Create a new user
    @PostMapping
    public ResponseEntity<Users> createUser(@RequestBody Users user) {
        if (usersRepository.existsByEmail(user.getEmail())) {
            throw new IllegalArgumentException("Email already in use.");
        }
        // Ensure role is set, or provide a default
//        if (user.getRole() == null) {
//            user.setRole("buyer");
//        }
        Users createdUser = usersRepository.save(user);
        return ResponseEntity.ok(createdUser);
    }

    // PUT: Update an existing user
    @PutMapping("/{id}")
    public ResponseEntity<Users> updateUser(@PathVariable Long id, @RequestBody Users userDetails) {
        Users user = usersRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("User not found with ID: " + id));

        user.setName(userDetails.getName());
        user.setEmail(userDetails.getEmail());
        //user.setPassword(userDetails.getPassword());

        Users updatedUser = usersRepository.save(user);
        return ResponseEntity.ok(updatedUser);
    }

    // DELETE: Delete a user by ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
        Users user = usersRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("User not found with ID: " + id));

        usersRepository.delete(user);
        return ResponseEntity.noContent().build();
    }
}

