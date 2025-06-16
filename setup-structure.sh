#!/bin/bash

# Create server directories
mkdir -p server/{school,organization,user,utils}
touch server/{index.js,db.js}
touch server/utils/password.js

# School component
cat > server/school/controller.js <<EOF
exports.getSchools = (req, res) => {
  res.json({ message: 'List of schools' });
};
EOF

cat > server/school/routes.js <<EOF
const express = require('express');
const router = express.Router();
const schoolController = require('./controller');

router.get('/', schoolController.getSchools);

module.exports = router;
EOF

# Organization component
cat > server/organization/controller.js <<EOF
exports.createOrganization = (req, res) => {
  res.json({ message: 'Organization created' });
};
EOF

cat > server/organization/routes.js <<EOF
const express = require('express');
const router = express.Router();
const orgController = require('./controller');

router.post('/', orgController.createOrganization);

module.exports = router;
EOF

# User component
cat > server/user/controller.js <<EOF
exports.createUser = (req, res) => {
  res.json({ message: 'User created' });
};
EOF

cat > server/user/routes.js <<EOF
const express = require('express');
const router = express.Router();
const userController = require('./controller');

router.post('/', userController.createUser);

module.exports = router;
EOF

# db.js
cat > server/db.js <<EOF
const mysql = require('mysql2/promise');
require('dotenv').config();

const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 10
});

module.exports = pool;
EOF

# password.js
cat > server/utils/password.js <<EOF
const words = ['blue', 'tree', 'cat', 'storm', 'river', 'mountain', 'ocean'];

function generateMnemonicPassword() {
  return Array.from({ length: 3 }, () =>
    words[Math.floor(Math.random() * words.length)]
  ).join('-');
}

module.exports = { generateMnemonicPassword };
EOF

# index.js (Express server entry point)
cat > server/index.js <<EOF
const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());

// Import routes
app.use('/api/school', require('./school/routes'));
app.use('/api/organization', require('./organization/routes'));
app.use('/api/user', require('./user/routes'));

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(\`Server running on port \${PORT}\`));
EOF

# Create client structure
mkdir -p client/public
mkdir -p client/src/{components,pages,utils}
touch client/src/{App.js,index.js}

# App.js template
cat > client/src/App.js <<EOF
import React from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';

function App() {
  return (
    <div className="container mt-4">
      <h1>Belize School App</h1>
    </div>
  );
}

export default App;
EOF

# index.js template
cat > client/src/index.js <<EOF
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(<App />);
EOF

echo "✅ Express + React project initialized with custom structure."
