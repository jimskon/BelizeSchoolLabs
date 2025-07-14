import React, { useState, useEffect } from 'react';
import SchoolSelector from '../components/SchoolSelector';
import { useNavigate } from 'react-router-dom';

export default function RequestAccountPage() {
  // State for selected school and district from the dropdown
  const [selectedSchool, setSelectedSchool] = useState('');
  const [selectedDistrict, setSelectedDistrict] = useState('');

  // MOE email from the backend for the selected school
  const [moeEmail, setMoeEmail] = useState('');

  // Whether to show the full account request form
  const [showForm, setShowForm] = useState(false);

  const navigate = useNavigate();

  // Contact form state for new account request
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

  // Fetch the MOE email once a school is selected
  useEffect(() => {
    const fetchMoeEmail = async () => {
      if (selectedSchool) {
        setMoeEmail('');
        setError('');
        try {
          const res = await fetch(`/api/school/moe-school?name=${encodeURIComponent(selectedSchool)}`);
          const data = await res.json();
          if (res.ok && data.email) {
            setMoeEmail(data.email); // Set email if found
          } else {
            setError('No email found for this school.');
          }
        } catch (err) {
          setError('Error retrieving MOE Email address');
        }
      }
    };

    fetchMoeEmail();
  }, [selectedSchool]);

  // Send login PIN to the MOE email address
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
        setSuccessMessage('A new PIN has been sent to the current Email address for this school.');
        setTimeout(() => navigate('/'), 2000); // Redirect after 2s
      } else {
        setError(data.error || 'Failed to Email a new PIN.');
      }
    } catch (err) {
      setError('Error Emailing a new PIN.');
    }
  };

  // Submit the full account request form
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
      setTimeout(() => navigate('/'), 2000);
    } else {
      setError(data.error || 'Submission failed.');
    }
  };

  return (
    <div className="container mt-5">
      <h2>Request an Account</h2>
      <p className="mb-4">Select a school to proceed with Emailing a new PIN</p>

      {/* School dropdown component */}
      <SchoolSelector
        selectedSchool={selectedSchool}
        setSelectedSchool={setSelectedSchool}
        selectedDistrict={selectedDistrict}
        setSelectedDistrict={setSelectedDistrict}
      />

      {/* Once school is selected and form is not shown */}
      {selectedSchool && !showForm && (
        <div className="mb-4">
          <p className="fw-semibold">MOE Email address on file:</p>
          <div className="mb-2">
            <strong>{moeEmail || <em>(No MOE Email address found)</em>}</strong>
          </div>
          <div className="d-flex gap-3">
            {/* Button to send PIN to MOE email */}
            <button
              className="btn btn-primary"
              onClick={handleSendPassword}
              disabled={!moeEmail}
            >
              Send Password
            </button>

            {/* Toggle account request form */}
            <button
              className="btn btn-outline-secondary"
              onClick={() => setShowForm(true)}
            >
              Request an Account
            </button>
          </div>
        </div>
      )}

      {/* Display full form if user clicks "Request an Account" */}
      {showForm && selectedSchool && (
        <div className="mt-4">
          <h4>Verification Form</h4>
          <div className="row">
            {/* Render all 6 fields dynamically */}
            {['email', 'phone', 'address', 'manager', 'managerEmail', 'managerPhone'].map(field => (
              <div className="col-md-6 mb-3" key={field}>
                <label className="form-label fw-semibold">
                  {field.replace(/([A-Z])/g, ' $1').replace(/^./, c => c.toUpperCase())}
                </label>
                <input
                  type="text"
                  className="form-control"
                  value={contact[field]}
                  onChange={(e) =>
                    setContact(prev => ({ ...prev, [field]: e.target.value }))
                  }
                />
              </div>
            ))}
          </div>
          <button className="btn btn-success" onClick={handleSubmit}>Submit Request</button>
        </div>
      )}

      {/* Success and error alerts */}
      {successMessage && <div className="alert alert-success mt-4">{successMessage}</div>}
      {error && <div className="alert alert-danger mt-4">{error}</div>}
    </div>
  );
}
