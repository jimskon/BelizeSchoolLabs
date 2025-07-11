import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import SchoolSelector from '../components/SchoolSelector';

const API_BASE_URL = import.meta.env.VITE_API_URL;

export default function LoginPage() {
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
  const navigate = useNavigate();
  const [pinSentAt, setPinSentAt] = useState(null);
  const [timer, setTimer] = useState(0);
    const [isRequesting, setIsRequesting] = useState(false);

  // Mask email for display: show partial local part and full domain
  const maskEmail = (email) => {
    const [local, domain] = email.split('@');
    if (!domain) return email;
    if (local.length <= 2) return '*@' + domain;
    const start = local[0];
    const end = local[local.length - 1];
    return `${start}***${end}@${domain}`;
  };

  useEffect(() => {
    async function fetchMoeEmail() {
      setMoeEmail('');
      if (!selectedSchool) return;
      try {
        const res = await fetch(
          `${API_BASE_URL}/api/school/moe-school?name=${encodeURIComponent(selectedSchool)}`
        );
        const data = await res.json();
        setMoeEmail(data.email || '');
      } catch (err) {
        console.error('Error fetching MOE email:', err);
      }
    }
    fetchMoeEmail();
  }, [selectedSchool]);

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
      if (data.needsValidation) {
        navigate(`/validate?name=${encodeURIComponent(selectedSchool)}`);
      } else if (data.needsPasswordReset) {
        navigate('/reset-password');
      } else {
        navigate('/main');
      }
    } else {
      setError(data.error || 'Login failed. Please check your credentials.');
    }
  };

  const handleSendPasswordEmail = async () => {
    const now = Date.now();
    if (pinSentAt && now - pinSentAt < 5 * 60 * 1000) {
      alert('PIN has already been sent, you can resend after 5 minutes');
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
        alert('PIN has been sent to ' + moeEmail);
        setPinSentAt(now);
        setTimer(5 * 60);
      } else {
        alert(result.error || 'Failed to send PIN');
      }
    } catch (err) {
      console.error('Error sending PIN email:', err);
      alert('An error occurred while sending the email.');
    } finally {
      setIsRequesting(false);
    }
  };
  useEffect(() => {
    if (timer > 0) {
      const interval = setInterval(() => setTimer(t => t - 1), 1000);
      return () => clearInterval(interval);
    }
  }, [timer]);

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
        alert('Your correction request has been submitted.');
        setShowCorrectionForm(false);
      } else {
        alert(result.error || 'Failed to submit correction.');
      }
    } catch (err) {
      console.error('Error submitting correction:', err);
      alert('An error occurred while submitting the correction.');
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
                selectedDistrict={selectedDistrict}
                setSelectedDistrict={setSelectedDistrict}
                selectedType={selectedType}
                setSelectedType={setSelectedType}
                selectedSchool={selectedSchool}
                setSelectedSchool={setSelectedSchool}
              />

              {!selectedSchool && (
                <div className="alert alert-info mt-3">
                  Please select a district, type, and school to continue.
                </div>
              )}

              {selectedSchool && (
                <>
                  <div className="mb-3">
                    <label className="form-label fw-semibold">PIN</label>
                    <input
                      type="password"
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

                  <div className="mt-4">
                    <p>
                      Send your School's PIN to this email address:{' '}
                      <strong>
                        {moeEmail ? maskEmail(moeEmail) : 'xx@xx.xx'}
                      </strong>
                    </p>
                    <button
                      className="btn btn-secondary"
                      onClick={handleSendPasswordEmail}
                      disabled={!moeEmail || isRequesting}
                    >
                      {timer > 0
                        ? `Resend PIN in ${Math.floor(timer / 60)}:${String(timer % 60).padStart(2, '0')}`
                        : 'Email the PIN'}
                    </button>
                  </div>

                  <div className="mt-3">
                    <p>
                      If the above email is invalid, kindly request to correct this email address
                    </p>
                    <button
                      className="btn btn-secondary"
                      onClick={() => setShowCorrectionForm(true)}
                    >
                      Email Correction Request
                    </button>
                  </div>

                  {showCorrectionForm && (
                    <div className="mt-3">
                      <div className="mb-3">
                        <label className="form-label">
                          School’s contact person’s corrected email
                        </label>
                        <input
                          type="email"
                          className="form-control"
                          value={correctedEmail}
                          onChange={(e) => setCorrectedEmail(e.target.value)}
                        />
                      </div>
                      <div className="mb-3">
                        <label className="form-label">
                          School’s contact person’s name
                        </label>
                        <input
                          type="text"
                          className="form-control"
                          value={correctedName}
                          onChange={(e) => setCorrectedName(e.target.value)}
                        />
                      </div>
                      <div className="mb-3">
                        <label className="form-label">
                          School’s contact person’s WhatsApp phone number (someone will be contacting you)
                        </label>
                        <input
                          type="text"
                          className="form-control"
                          value={correctedPhone}
                          onChange={(e) => setCorrectedPhone(e.target.value)}
                        />
                      </div>
                      <button className="btn btn-primary" onClick={handleSubmitCorrection}>
                        Submit Email Correction Request
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