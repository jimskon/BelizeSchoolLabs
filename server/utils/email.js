// Load the Nodemailer library for sending emails
const nodemailer = require("nodemailer");

// Load environment variables from .env file
require('dotenv').config();

// ==============================================
// Configure the email transporter using Gmail
// ==============================================
const transporter = nodemailer.createTransport({
  service: 'gmail', // Use Gmail as the mail service
  auth: {
    user: 'belizeschoollabs@gmail.com',         // Sender email address
    pass: process.env.EMAIL_PASSWORD            // App password stored in .env
  },
});

// ==============================================
// Send an email using the configured transporter
// ==============================================
// Accepts an object with `to`, `subject`, and `text`
// Returns a promise that resolves when the email is sent
const sendEmail = async ({ to, subject, text }) => {
  const mailOptions = {
    from: 'belizeschoollabs@gmail.com', // Sender address
    to,                                 // Recipient address
    subject,                            // Email subject line
    text                                // Plain text body
  };

  try {
    await transporter.sendMail(mailOptions);
    console.log('✅ Email sent to', to);
  } catch (error) {
    console.error('❌ Error sending email:', error);
    throw error; // Propagate error to be handled by caller
  }
};

// Export the sendEmail function for use in other modules
module.exports = { sendEmail };
