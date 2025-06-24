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

  /*const handleLogin = async () => {
    setError('');
    const res = await fetch(`${API_BASE_URL}/api/auth/login`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ name: selectedSchool, password })
    });

    const data = await res.json();

    if (res.ok && data.success) {
      const school = { name: selectedSchool }; // Save session data
      localStorage.setItem('school', JSON.stringify(school));

      if (data.needsValidation) {
        navigate(`/validate?name=${encodeURIComponent(data.name)}`);
      } else if (data.needsPasswordReset) {
        navigate('/reset-password'); // ✅ Redirect here for temp password reset
      } else {
        navigate('/main');
      }
    } else {
      setError(data.error || 'Login failed. Please check your credentials.');
    }
  };*/

  const handleLogin = async () => {
    setError('');
    const res = await fetch(`${API_BASE_URL}/api/auth/login`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ name: selectedSchool, password })
    });
    const data = await res.json();
    if (res.ok && data.success) {
      const schoolSession = { id: data.schoolId, name: data.name };
      localStorage.setItem('school', JSON.stringify(schoolSession));
      if (data.needsValidation) {
        navigate(`/validate?name=${encodeURIComponent(data.name)}`);
      } else if (data.needsPasswordReset) {
        navigate('/reset-password');
      } else {
        navigate('/main');
      }
    } else {
      setError(data.error || 'Login failed. Please check your credentials.');
    }
  };



  return (
    <div className="container mt-5">
      <div className="row justify-content-center">
        <div className="col-md-6">
          <div className="card shadow-sm">
            <div className="card-header bg-primary text-white">
              <h4 className="mb-0 text-center">School Login</h4>
            </div>
            <div className="card-body">
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

              <button className="btn btn-primary w-100" onClick={handleLogin}>
                Login
              </button>

              {error && <div className="alert alert-danger mt-3">{error}</div>}

              <p className="mt-4 text-center">
                Don't have an account?{' '}
                <Link to="/request-account">Request one here.</Link>
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}