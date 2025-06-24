// client/src/App.jsx
import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import LoginPage from './pages/LoginPage';
import RequestAccountPage from './pages/RequestAccountPage';
import ValidateSchoolPage from './pages/ValidateSchoolPage';
import BootstrapLayout from './components/BootstrapLayout';
import HomePage from './pages/HomePage';
import ListPage from './pages/ListPage'; // Generic list view
import EditPage from './pages/EditPage';
import ResetPasswordPage from './pages/ResetPasswordPage';



export default function App() {
  return (
    <Router>
      <BootstrapLayout>
        <Routes>
          <Route path="/" element={<LoginPage />} />
          <Route path="/login" element={<LoginPage />} />
          <Route path="/request-account" element={<RequestAccountPage />} />
          <Route path="/validate" element={<ValidateSchoolPage />} />
          <Route path="/main" element={<HomePage />} />
          <Route path="/:table/list" element={<ListPage />} />
          <Route path="/:table/edit" element={<EditPage />} />
          <Route path="/reset-password" element={<ResetPasswordPage />} />
        </Routes>
      </BootstrapLayout>
    </Router>
  );
}
