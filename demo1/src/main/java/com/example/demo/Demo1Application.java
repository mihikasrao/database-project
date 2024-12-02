package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

@SpringBootApplication
public class Demo1Application {

    public static void main(String[] args) {
        SpringApplication.run(Demo1Application.class, args);
        System.out.println("Spring Boot Application connected to the database and ready to test APIs via Postman!");
    }

//    @Bean
//    CommandLineRunner testDatabaseConnection(DataSource dataSource) {
//        return args -> {
//            try (var connection = dataSource.getConnection()) {
//                System.out.println("Successfully connected to the database: " + connection.getMetaData().getURL());
//                System.out.println("Database Product Name: " + connection.getMetaData().getDatabaseProductName());
//            } catch (Exception e) {
//                System.err.println("Failed to connect to the database: " + e.getMessage());
//            }
//        };
//    }
//    @Bean
//    CommandLineRunner listTables(DataSource dataSource) {
//        return args -> {
//            try (Connection connection = dataSource.getConnection()) {
//                System.out.println("Connected to the database: " + connection.getMetaData().getURL());
//
//                // Fetch and print table names
//                System.out.println("Fetching table names...");
//                ResultSet tables = connection.getMetaData().getTables(null, null, "%", new String[]{"TABLE"});
//                while (tables.next()) {
//                    String tableName = tables.getString("TABLE_NAME");
//                    System.out.println("Table: " + tableName);
//                }
//            } catch (SQLException e) {
//                System.err.println("Error while fetching table names: " + e.getMessage());
//            }
//        };
//    }
}
