import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import SchoolSelector from '../components/SchoolSelector';

// Load API URL from environment
const API_BASE_URL = import.meta.env.VITE_API_URL;

export default function LoginPage() {
  // =====================
  // State declarations
  // =====================
  const [selectedDistrict, setSelectedDistrict] = useState('');
  const [selectedType, setSelectedType] = useState('');
  const [selectedSchool, setSelectedSchool] = useState('');
  const [error, setError] = useState('');
  const [showCorrectionForm, setShowCorrectionForm] = useState(false);
  const [correctedEmail, setCorrectedEmail] = useState('');
  const [correctedName, setCorrectedName] = useState('');
  const [correctedPhone, setCorrectedPhone] = useState('');
  const [moeEmail, setMoeEmail] = useState('');
  const [password, setPassword] = useState('');
  const [pinSentAt, setPinSentAt] = useState(null); // Track last PIN send time
  const [timer, setTimer] = useState(0); // Cooldown timer for resending PIN
  const [isRequesting, setIsRequesting] = useState(false);
  const navigate = useNavigate();

  // Helper to mask email for display (e.g., j***e@email.com)
  const maskEmail = (email) => {
    const [local, domain] = email.split('@');
    if (!domain) return email;
    if (local.length <= 2) return '*@' + domain;
    return `${local[0]}***${local[local.length - 1]}@${domain}`;
  };

  // =====================
  // Fetch MOE email on school selection
  // =====================
  useEffect(() => {
    async function fetchMoeEmail() {
      setMoeEmail('');
      if (!selectedSchool) return;
      try {
        const res = await fetch(`${API_BASE_URL}/api/school/moe-school?name=${encodeURIComponent(selectedSchool)}`);
        const data = await res.json();
        setMoeEmail(data.email || '');
      } catch (err) {
        console.error('Error fetching MOE email:', err);
      }
    }
    fetchMoeEmail();
  }, [selectedSchool]);

  // =====================
  // Handle login logic
  // =====================
  const handleLogin = async () => {
    setError('');
    const res = await fetch(`${API_BASE_URL}/api/auth/login`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ name: selectedSchool, pin: password })
    });
    const data = await res.json();
    if (res.ok && data.success) {
      const schoolSession = { name: selectedSchool, code: data.code };
      localStorage.setItem('school', JSON.stringify(schoolSession));

      // Redirect depending on backend flag
      if (data.needsValidation) {
        navigate(`/validate?name=${encodeURIComponent(selectedSchool)}`);
      } else if (data.needsPasswordReset) {
        navigate('/reset-password');
      } else {
        navigate('/main');
      }
    } else {
      setError(data.error || 'Login failed. Please check your PIN');
    }
  };

  // =====================
  // Handle sending login PIN
  // =====================
  const handleSendPasswordEmail = async () => {
    const now = Date.now();
    if (pinSentAt && now - pinSentAt < 60000) {
      alert('A new PIN has already been sent. Try again in a minute.');
      return;
    }

    try {
      setIsRequesting(true);
      const res = await fetch(`${API_BASE_URL}/api/auth/send-login-pin`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ school_name: selectedSchool })
      });

      const result = await res.json();
      if (result.success) {
        alert('A new PIN has been sent to ' + moeEmail);
        setPinSentAt(now);
        setTimer(300); // 5 minutes cooldown
      } else {
        alert(result.error || 'Failed to send the PIN via Email');
      }
    } catch (err) {
      console.error('Error sending the new PIN:', err);
      alert('An error occurred while sending the Email.');
    } finally {
      setIsRequesting(false);
    }
  };

  // Countdown timer for resend cooldown
  useEffect(() => {
    if (timer > 0) {
      const interval = setInterval(() => setTimer(t => t - 1), 1000);
      return () => clearInterval(interval);
    }
  }, [timer]);

  // =====================
  // Handle contact correction form submission
  // =====================
  const handleSubmitCorrection = async () => {
    try {
      const res = await fetch(`${API_BASE_URL}/api/auth/correct-contact`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          schoolName: selectedSchool,
          contactEmail: correctedEmail,
          contactName: correctedName,
          contactPhone: correctedPhone
        })
      });
      const result = await res.json();
      if (result.success) {
        alert('The correction request has been submitted.');
        setShowCorrectionForm(false);
      } else {
        alert(result.error || 'Failed to submit the correction request.');
      }
    } catch (err) {
      console.error('Error submitting the correction request:', err);
      alert('An error occurred while submitting the correction request.');
    }
  };

  // =====================
  // JSX Render
  // =====================
  return (
    <div className="container mt-5">
      <div className="row justify-content-center">
        <div className="col-md-6">
          <div className="card shadow-sm">
            <div className="card-header bg-primary text-white">
              <h4 className="mb-0 text-center">Login</h4>
            </div>
            <div className="card-body">
              {/* School selector dropdowns */}
              <SchoolSelector
                selectedDistrict={selectedDistrict}
                setSelectedDistrict={setSelectedDistrict}
                selectedType={selectedType}
                setSelectedType={setSelectedType}
                selectedSchool={selectedSchool}
                setSelectedSchool={setSelectedSchool}
              />

              {/* No school selected message */}
              {!selectedSchool && (
                <div className="alert alert-info mt-3">
                  Please select a district, type, and school to continue.
                </div>
              )}

              {/* Login form if school selected */}
              {selectedSchool && (
                <>
                  <div className="mb-3">
                    <label className="form-label fw-semibold">PIN</label>
                    <input
                      type="password"
                      style={{ width: '10ch' }}
                      className="form-control"
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                    />
                  </div>

                  <button
                    className="btn btn-primary w-100"
                    onClick={handleLogin}
                    disabled={!password}
                  >
                    Login
                  </button>

                  {error && <div className="alert alert-danger mt-3">{error}</div>}

                  {/* PIN resend section */}
                  <div className="mt-4">
                    <p>
                      If you do not have a valid PIN we can Email a new one to: {' '}
                      <strong>
                        {moeEmail ? maskEmail(moeEmail) : ' ERROR - No Email found, please submit correction'}
                      </strong>
                    </p>
                    <button
                      className="btn btn-secondary"
                      onClick={handleSendPasswordEmail}
                      disabled={!moeEmail || isRequesting}
                    >
                      {timer > 0
                        ? `Resend PIN in ${Math.floor(timer / 60)}:${String(timer % 60).padStart(2, '0')}`
                        : 'Email a new PIN'}
                    </button>
                  </div>

                  {/* Correction request option */}
                  <div className="mt-3">
                    <p>If the above Email is incorrect, please request an update:</p>
                    <button
                      className="btn btn-secondary"
                      onClick={() => setShowCorrectionForm(true)}
                    >
                      Email Correction Request
                    </button>
                  </div>

                  {/* Correction request form */}
                  {showCorrectionForm && (
                    <div className="mt-3">
                      <div className="mb-3">
                        <label className="form-label">
                          School’s contact person’s Email address
                        </label>
                        <input
                          type="email"
                          className="form-control"
                          value={correctedEmail}
                          onChange={(e) => setCorrectedEmail(e.target.value)}
                        />
                      </div>
                      <div className="mb-3">
                        <label className="form-label">Contact person's name</label>
                        <input
                          type="text"
                          className="form-control"
                          value={correctedName}
                          onChange={(e) => setCorrectedName(e.target.value)}
                        />
                      </div>
                      <div className="mb-3">
                        <label className="form-label">WhatsApp phone number</label>
                        <input
                          type="text"
                          className="form-control"
                          value={correctedPhone}
                          onChange={(e) => setCorrectedPhone(e.target.value)}
                        />
                      </div>
                      <button className="btn btn-primary" onClick={handleSubmitCorrection}>
                        Submit Correction Request
                      </button>
                    </div>
                  )}
                </>
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
