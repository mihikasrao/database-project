CREATE TABLE Users (
    user_id INT PRIMARY KEY, 
    name VARCHAR(100) NOT NULL, 
    email VARCHAR(100) UNIQUE NOT NULL, 
    password VARCHAR(100) NOT NULL, 
    role VARCHAR(10) NOT NULL CHECK (role IN ('buyer', 'seller')),
    address VARCHAR(200)
);

-- Step 1: Create a database master key with a strong password
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'StrongMasterKeyPassword123!';

-- Step 2: Create a certificate to protect the symmetric key
CREATE CERTIFICATE PasswordCert
WITH SUBJECT = 'Certificate for Password Encryption';

-- Step 3: Create a symmetric key with AES_256 encryption, protected by the certificate
CREATE SYMMETRIC KEY PasswordKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE PasswordCert;

-- Step 4: Add a new column to store the encrypted password
ALTER TABLE Users
ADD EncryptedPassword VARBINARY(128); -- Adjust the size as needed

-- Step 5: Encrypt existing data and update the `EncryptedPassword` column
OPEN SYMMETRIC KEY PasswordKey
    DECRYPTION BY CERTIFICATE PasswordCert;

UPDATE Users
SET EncryptedPassword = EncryptByKey(Key_GUID('PasswordKey'), CAST(password AS VARBINARY));

-- Close the symmetric key after encrypting the data
CLOSE SYMMETRIC KEY PasswordKey;

-- (Optional) Drop the original `password` column if plaintext storage is no longer required
-- ALTER TABLE Users DROP COLUMN password;
