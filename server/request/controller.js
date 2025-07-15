// NOTE: This file is currently not used in the main workflow.
// It is kept for future admin or donor features (e.g., onboarding, account requests).
// All exports are commented out below.
// server/request/controller.js
// This code is responsible for executing the logic when someone submits a request account correction 

const pool = require('../db');
const { sendEmail } = require('../utils/email');
const crypto = require('crypto');

// ============================================
// POST /submit-request
// ============================================
// Accepts a request from a school to be contacted or registered in the system.
// Stores the information in the `account_requests` table for admin review.
// This might be used when a school is requesting onboarding manually.( will be useful when the admin page has been finalized)
// exports.submitRequest = async (req, res) => {
//   ...existing code...
// };

// ============================================
// GET /requests
// ============================================
// Returns a list of all account requests stored in the `account_requests` table.
// Used by admins to review incoming school requests, optionally approve or reject them.
// exports.getRequests = async (req, res) => {
//   ...existing code...
// };

// ============================================
// POST /request-account
// ============================================
// Automatically registers a new school account in the system:
//  1. Inserts the school into the `school` table
//  2. Tracks the request in `account_requests` with status 'approved'
//  3. Emails the auto-generated password to the school's email
// exports.requestAccount = async (req, res) => {
//   ...existing code...
// };
