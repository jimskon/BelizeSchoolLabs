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
          const fullData = {
            ...data,
            school_id: data.school_id || data.id // fallback if available
          };
          setSchoolData(fullData);
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
      const school = {
        id: result.school?.id || schoolData.school_id,
        name: result.school?.name || schoolData.name
      };

      localStorage.setItem('school', JSON.stringify(school));
      console.log('Stored school:', school);
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
    <div className="container py-5">
      <div className="bg-light p-4 rounded shadow-sm">
        <h2 className="mb-4 text-primary border-bottom pb-2">Validate School Information</h2>

        <div className="row g-3">
          {textFields.map((key) => (
            <div className="col-md-6" key={key}>
              <label className="form-label fw-semibold">
                {key.replace(/_/g, ' ').replace(/\b\w/g, l => l.toUpperCase())}
              </label>
              <input
                type={key === 'year_opened' ? 'number' : 'text'}
                className="form-control border-secondary"
                value={schoolData[key] || ''}
                onChange={(e) => handleChange(key, e.target.value)}
              />
            </div>
          ))}

          {selectFields.map(({ key, options }) => (
            <div className="col-md-6" key={key}>
              <label className="form-label fw-semibold">
                {key.replace(/_/g, ' ').replace(/\b\w/g, l => l.toUpperCase())}
              </label>
              <select
                className="form-select border-secondary"
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

        <div className="d-flex justify-content-end mt-4">
          <button className="btn btn-primary px-4 py-2" onClick={handleSubmit}>Validate & Save</button>
        </div>
      </div>
    </div>
  );
}
