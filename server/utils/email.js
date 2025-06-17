const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
  service: 'gmail', // or change to another provider if needed
  auth: {
    user: process.env.EMAIL_USER,       // example: belizeschoollabs@gmail.com
    pass: process.env.EMAIL_PASSWORD    // Gmail App Password or real password
  }
});

/**
 * Send a basic email.
 * @param {Object} options - { to, subject, text }
 */
async function sendEmail({ to, subject, text }) {
  const mailOptions = {
    from: process.env.EMAIL_USER,
    to,
    subject,
    text
  };

  return transporter.sendMail(mailOptions);
}

module.exports = { sendEmail };
