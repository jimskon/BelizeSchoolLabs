// client/src/pages/ValidateSchoolPage.jsx
import React, { useEffect, useState } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';

const API_BASE_URL = import.meta.env.VITE_API_URL;

export default function ValidateSchoolPage() {
  const [schoolData, setSchoolData] = useState(null);
  const navigate = useNavigate();
  const location = useLocation();
  const schoolName = new URLSearchParams(location.search).get('name');

  useEffect(() => {
    const fetchSchoolData = async () => {
      try {
        const res = await fetch(`${API_BASE_URL}/api/school/validate-needed?name=${encodeURIComponent(schoolName)}`);
        const data = await res.json();
        if (res.ok) {
          setSchoolData(data);
        } else {
          alert('Error loading school data: ' + data.error);
        }
      } catch (err) {
        console.error("Error fetching school data:", err);
        alert("Failed to load school data.");
      }
    };

    fetchSchoolData();
  }, [schoolName]);

  const handleChange = (key, value) => {
    setSchoolData(prev => ({ ...prev, [key]: value }));
  };

  const handleSubmit = async () => {
    const res = await fetch(`${API_BASE_URL}/api/school/validate`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(schoolData),
    });
    const result = await res.json();
    if (result.success) {
      navigate('/main');
    } else {
      alert("Error: " + result.error);
    }
  };

  if (!schoolData) return <div className="container mt-4">Loading...</div>;

  const textFields = [
    'name', 'address', 'contact_person', 'telephone',
    'telephone_alt1', 'telephone_alt2', 'email', 'email_alt',
    'website', 'year_opened', 'ownership', 'school_administrator_1', 'school_administrator_2'
  ];

  const selectFields = [
    { key: 'district', options: ['Belize', 'Cayo', 'Corozal', 'Orange Walk', 'Stann Creek', 'Toledo'] },
    { key: 'locality', options: ['Rural', 'Urban'] },
    { key: 'type', options: ['Preschool', 'Primary', 'Secondary', 'Tertiary', 'Vocational', 'Adult and Continuing', 'University'] },
    { key: 'sector', options: ['Government', 'Government Aided', 'Private', 'Specially Assisted'] },
  ];

  return (
    <div className="container mt-4">
      <h2 className="mb-4">Validate School Information</h2>
      <div className="row">
        {textFields.map((key) => (
          <div className="col-md-6 mb-3" key={key}>
            <label className="form-label fw-semibold">
              {key.replace(/_/g, ' ').replace(/^\w/, c => c.toUpperCase())}
            </label>
            <input
              type={key === 'year_opened' ? 'number' : 'text'}
              className="form-control"
              value={schoolData[key] || ''}
              onChange={(e) => handleChange(key, e.target.value)}
            />
          </div>
        ))}

        {selectFields.map(({ key, options }) => (
          <div className="col-md-6 mb-3" key={key}>
            <label className="form-label fw-semibold">
              {key.replace(/_/g, ' ').replace(/^\w/, c => c.toUpperCase())}
            </label>
            <select
              className="form-select"
              value={schoolData[key] || ''}
              onChange={(e) => handleChange(key, e.target.value)}
            >
              <option value="">-- Select --</option>
              {options.map((opt) => (
                <option key={opt} value={opt}>{opt}</option>
              ))}
            </select>
          </div>
        ))}
      </div>

      <button className="btn btn-primary mt-4" onClick={handleSubmit}>Validate & Save</button>
    </div>
  );
}
