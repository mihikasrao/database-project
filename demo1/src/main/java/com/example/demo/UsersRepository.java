package com.example.demo;

import com.example.demo.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UsersRepository extends JpaRepository<Users, Long> {

    // Custom query method to find a user by email
    Optional<Users> findByEmail(String email);

    // Custom query method to check if a user exists by email
    boolean existsByEmail(String email);
}
