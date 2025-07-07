-- Migration: Create admin_users table and seed initial admin

-- Create table for admin user accounts
CREATE TABLE IF NOT EXISTS admin_users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(100) NOT NULL UNIQUE,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NULL,
  login_pin VARCHAR(6) NULL,
  pin_expires_at DATETIME NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert a default admin user (replace email and username as needed)
INSERT IGNORE INTO admin_users (username, email) VALUES
('Wisdom', 'wakanwe@gmail.com');
