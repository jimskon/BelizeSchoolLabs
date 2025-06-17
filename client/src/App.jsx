// client/src/App.jsx
import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import LoginPage from './pages/LoginPage';
import RequestAccountPage from './pages/RequestAccountPage';
import ValidateSchoolPage from './pages/ValidateSchoolPage';
import BootstrapLayout from './components/BootstrapLayout';

export default function App() {
  return (
    <Router>
      <BootstrapLayout>
        <Routes>
          <Route path="/" element={<LoginPage />} />
          <Route path="/login" element={<LoginPage />} />
          <Route path="/request-account" element={<RequestAccountPage />} />
          <Route path="/validate" element={<ValidateSchoolPage />} />
        </Routes>
      </BootstrapLayout>
    </Router>
  );
}
