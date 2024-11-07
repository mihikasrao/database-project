-- Index 1: Non-clustered index on the 'email' column in the Users table
-- This index will improve performance for queries that search for users by email.
CREATE NONCLUSTERED INDEX idx_users_email
ON Users (email);