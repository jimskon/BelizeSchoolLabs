import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import ValidateSchoolPage from './pages/ValidateSchoolPage.jsx';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<ValidateSchoolPage />} />
      </Routes>
    </Router>
  );
}

export default App;

