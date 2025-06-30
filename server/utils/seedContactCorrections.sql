-- SQL to create table for storing contact correction submissions
CREATE TABLE contact_corrections (
  id INT AUTO_INCREMENT PRIMARY KEY,
  school_name VARCHAR(100) NOT NULL,
  contact_email VARCHAR(255) NOT NULL,
  contact_name VARCHAR(100),
  contact_phone VARCHAR(50),
  status ENUM('pending','approved','rejected') DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
