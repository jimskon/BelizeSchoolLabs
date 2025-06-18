const nodemailer = require("nodemailer");
require('dotenv').config();

// Create Gmail transporter using app password
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'belizeschoollabs@gmail.com',
    pass: process.env.EMAIL_PASSWORD,
  },
});

// General-purpose email sender function
const sendEmail = async ({ to, subject, text }) => {
  const mailOptions = {
    from: 'belizeschoollabs@gmail.com',
    to,
    subject,
    text,
  };

  try {
    await transporter.sendMail(mailOptions);
    console.log('✅ Email sent to', to);
  } catch (error) {
    console.error('❌ Error sending email:', error);
    throw error;
  }
};

module.exports = { sendEmail };
