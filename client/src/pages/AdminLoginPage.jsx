import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';

const API_BASE_URL = import.meta.env.VITE_API_URL;

export default function AdminLoginPage() {
  const [email, setEmail] = useState('');
  const [pin, setPin] = useState('');
  const [pinSent, setPinSent] = useState(false);
  const [error, setError] = useState('');
  const navigate = useNavigate();

  const handleSendPin = async () => {
    setError('');
    try {
      const res = await fetch(`${API_BASE_URL}/api/admin/send-pin`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email })
      });
      const data = await res.json();
      if (res.ok && data.success) {
        setPinSent(true);
        alert('A PIN has been sent to your admin email.');
      } else {
        setError(data.error || 'Failed to send PIN.');
      }
    } catch (err) {
      console.error('Send PIN failed:', err);
      setError('An error occurred while sending the PIN.');
    }
  };

  const handleLogin = async () => {
    setError('');
    try {
      const res = await fetch(`${API_BASE_URL}/api/admin/login`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, pin })
      });
      const data = await res.json();
      if (res.ok && data.success) {
        localStorage.setItem('admin_email', email);
        navigate('/admin/dashboard');
      } else {
        setError(data.error || 'Login failed.');
      }
    } catch (err) {
      console.error('Admin login failed:', err);
      setError('An error occurred during login.');
    }
  };

  return (
    <div className="container mt-5">
      <div className="row justify-content-center">
        <div className="col-md-6">
          <div className="card shadow-sm">
            <div className="card-header bg-dark text-white">
              <h4 className="mb-0 text-center">Admin Login</h4>
            </div>
            <div className="card-body">
              <div className="mb-3">
                <label className="form-label">Admin Email</label>
                <input
                  type="email"
                  className="form-control"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                />
              </div>

              {pinSent && (
                <div className="mb-3">
                  <label className="form-label">PIN</label>
                  <input
                    type="text"
                    className="form-control"
                    value={pin}
                    onChange={(e) => setPin(e.target.value)}
                  />
                </div>
              )}

              {error && <div className="alert alert-danger">{error}</div>}

              <div className="d-grid gap-2">
                {!pinSent ? (
                  <button className="btn btn-primary" onClick={handleSendPin}>
                    Send Login PIN
                  </button>
                ) : (
                  <button className="btn btn-success" onClick={handleLogin}>
                    Log In
                  </button>
                )}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
