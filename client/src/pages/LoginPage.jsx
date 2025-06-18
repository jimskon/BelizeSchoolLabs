// client/src/pages/LoginPage.jsx
import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import SchoolSelector from '../components/SchoolSelector';

const API_BASE_URL = import.meta.env.VITE_API_URL;

export default function LoginPage() {
  const [selectedSchool, setSelectedSchool] = useState('');
  const [selectedDistrict, setSelectedDistrict] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const navigate = useNavigate();

  const handleLogin = async () => {
    setError('');
    const res = await fetch(`${API_BASE_URL}/api/auth/login`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        name: selectedSchool,
        password
      })
    });

    const data = await res.json();
    if (res.ok && data.success) {
      if (data.needsValidation) {
        navigate(`/validate?name=${encodeURIComponent(data.name)}`);
      } else {
        navigate('/main');
      }
    } else {
      setError(data.error || 'Login failed. Please check your credentials.');
    }
  };

  return (
    <div className="container mt-5">
      <h2>School Login</h2>
      <SchoolSelector
        selectedSchool={selectedSchool}
        setSelectedSchool={setSelectedSchool}
        selectedDistrict={selectedDistrict}
        setSelectedDistrict={setSelectedDistrict}
      />

      <div className="mb-3">
        <label className="form-label fw-semibold">Password</label>
        <input
          type="password"
          className="form-control"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
      </div>

      <button className="btn btn-primary" onClick={handleLogin}>Login</button>

      {error && <div className="alert alert-danger mt-3">{error}</div>}

      <p className="mt-4">
        Don't have an account?{' '}
        <Link to="/request-account">Request one here.</Link>
      </p>
    </div>
  );
}
