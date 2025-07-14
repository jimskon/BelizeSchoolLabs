
// React and React Router imports
import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';


// Get API base URL from environment variable
const API_BASE_URL = import.meta.env.VITE_API_URL;


// Admin login page component
export default function AdminLoginPage() {
  // State for admin email input
  const [email, setEmail] = useState('');
  // State for PIN input
  const [pin, setPin] = useState('');
  // Tracks if PIN has been sent
  const [pinSent, setPinSent] = useState(false);
  // Error message state
  const [error, setError] = useState('');
  // React Router navigation
  const navigate = useNavigate();


  // Sends a login PIN to the admin's email
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


  // Handles admin login using email and PIN
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
        // Store admin email in localStorage and redirect to dashboard
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

  // Render the admin login form
  return (
    <div className="container mt-5">
      <div className="row justify-content-center">
        <div className="col-md-6">
          <div className="card shadow-sm">
            <div className="card-header bg-dark text-white">
              <h4 className="mb-0 text-center">Admin Login</h4>
            </div>
            <div className="card-body">
              {/* Admin email input */}
              <div className="mb-3">
                <label className="form-label">Admin Email</label>
                <input
                  type="email"
                  className="form-control"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                />
              </div>

              {/* PIN input, shown after PIN is sent */}
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

              {/* Error message display */}
              {error && <div className="alert alert-danger">{error}</div>}

              {/* Action button: Send PIN or Log In */}
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
