// Enable CORS for your Express backend
const cors = require('cors');

module.exports = function(app) {
  app.use(cors({
    origin: '*', // Change to your frontend URL in production
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization'],
    credentials: true
  }));
};
