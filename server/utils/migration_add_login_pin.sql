-- Migration: Add login PIN support to school table
-- Run this script against your MySQL database to add the required columns

ALTER TABLE school
  ADD COLUMN login_pin VARCHAR(6) NULL,
  ADD COLUMN pin_expires_at DATETIME NULL;
