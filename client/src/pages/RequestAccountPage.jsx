import React, { useState, useEffect } from 'react';
import SchoolSelector from '../components/SchoolSelector';
import { useNavigate } from 'react-router-dom';

export default function RequestAccountPage() {
  const [selectedSchool, setSelectedSchool] = useState('');
  const [selectedDistrict, setSelectedDistrict] = useState('');
  const [moeEmail, setMoeEmail] = useState('');
  const [showForm, setShowForm] = useState(false);
  const navigate = useNavigate();
  const [contact, setContact] = useState({
    email: '',
    phone: '',
    address: '',
    manager: '',
    managerEmail: '',
    managerPhone: ''
  });
  const [successMessage, setSuccessMessage] = useState('');
  const [error, setError] = useState('');

  useEffect(() => {
    const fetchMoeEmail = async () => {
      if (selectedSchool) {
        setMoeEmail('');
        setError('');
        try {
          const res = await fetch(`/api/school/moe-school?name=${encodeURIComponent(selectedSchool)}`);
          const data = await res.json();
          if (res.ok && data.email) {
            setMoeEmail(data.email);
          } else {
            setError('No email found for this school.');
          }
        } catch (err) {
          setError('Error retrieving MOE email.');
        }
      }
    };

    fetchMoeEmail();
  }, [selectedSchool]);

  const handleSendPassword = async () => {
    setError('');
    setSuccessMessage('');
    try {
      const res = await fetch('/api/auth/send-login-pin', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ school_name: selectedSchool })
      });
      const data = await res.json();
      if (res.ok && data.success) {
        setSuccessMessage('Password has been sent to the MOE email.');
        setTimeout(() => navigate('/'), 2000); // wait 2 sec to show message
      } else {
        setError(data.error || 'Failed to send password.');
      }
    } catch (err) {
      setError('Error sending password.');
    }
  };

  const handleSubmit = async () => {
    setError('');
    const res = await fetch('/api/request', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        school_name: selectedSchool,
        district: selectedDistrict,
        school_address: contact.address,
        school_phone: contact.phone,
        school_email: contact.email,
        contact_name: contact.manager,
        contact_email: contact.managerEmail,
        contact_phone: contact.managerPhone
      })
    });
    const data = await res.json();
    if (res.ok && data.success) {
      setSuccessMessage('Your request has been submitted for review.');
      setTimeout(() => navigate('/'), 2000); // delay to show success message
    } else {
      setError(data.error || 'Submission failed.');
    }
  };



  return (
    <div className="container mt-5">
      <h2>Request an Account</h2>
      <p className="mb-4">Select your school to proceed with sending a password or requesting a new account.</p>

      <SchoolSelector
        selectedSchool={selectedSchool}
        setSelectedSchool={setSelectedSchool}
        selectedDistrict={selectedDistrict}
        setSelectedDistrict={setSelectedDistrict}
      />

      {selectedSchool && !showForm && (
        <div className="mb-4">
          <p className="fw-semibold">MOE email on file:</p>
          <div className="mb-2">
            <strong>{moeEmail || <em>(No email found)</em>}</strong>
          </div>
          <div className="d-flex gap-3">
            <button
              className="btn btn-primary"
              onClick={handleSendPassword}
              disabled={!moeEmail}
            >
              Send Password
            </button>
            <button
              className="btn btn-outline-secondary"
              onClick={() => setShowForm(true)}
            >
              Request an Account
            </button>
          </div>
        </div>
      )}

      {showForm && selectedSchool && (
        <div className="mt-4">
          <h4>Verification Form</h4>
          <div className="row">
            {['email', 'phone', 'address', 'manager', 'managerEmail', 'managerPhone'].map(field => (
              <div className="col-md-6 mb-3" key={field}>
                <label className="form-label fw-semibold">
                  {field.replace(/([A-Z])/g, ' $1').replace(/^./, c => c.toUpperCase())}
                </label>
                <input
                  type="text"
                  className="form-control"
                  value={contact[field]}
                  onChange={(e) => setContact(prev => ({ ...prev, [field]: e.target.value }))}
                />
              </div>
            ))}
          </div>
          <button className="btn btn-success" onClick={handleSubmit}>Submit Request</button>
        </div>
      )}

      {successMessage && <div className="alert alert-success mt-4">{successMessage}</div>}
      {error && <div className="alert alert-danger mt-4">{error}</div>}
    </div>
  );
}
