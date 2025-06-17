import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';

const API_BASE_URL = import.meta.env.VITE_API_URL;

export default function ValidateSchoolPage() {
  const [schoolData, setSchoolData] = useState(null);
  const [password, setPassword] = useState('');
  const navigate = useNavigate();

  useEffect(() => {
    const fetchSchoolData = async () => {
      try {
        const res = await fetch(`${API_BASE_URL}/api/school/validate-needed`);
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
  }, []);

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

  return (
    <div className="container mt-4">
      <h2 className="mb-3">Validate School Information</h2>
      <div className="row">
        {["name", "address", "contact_person", "telephone", "email"].map((key) => (
          <div className="col-md-6 mb-3" key={key}>
            <label className="form-label fw-semibold">
              {key.replace(/_/g, ' ').replace(/^\w/, c => c.toUpperCase())}
            </label>
            <input
              type="text"
              className="form-control"
              value={schoolData[key] || ''}
              onChange={(e) => handleChange(key, e.target.value)}
            />
          </div>
        ))}

        {[{
          key: 'district',
          options: ['Belize', 'Cayo', 'Corozal', 'Orange Walk', 'Stann Creek', 'Toledo']
        }, {
          key: 'locality',
          options: ['Rural', 'Urban', 'Other']
        }, {
          key: 'type',
          options: ['Preschool', 'Primary', 'Secondary', 'Tertiary', 'Vocational', 'Adult and Continuing', 'University']
        }, {
          key: 'sector',
          options: ['Government', 'Government Aided', 'Private', 'Specially Assisted']
        }].map(({ key, options }) => (
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
              {options.map((opt, i) => (
                <option key={i} value={opt}>{opt}</option>
              ))}
            </select>
          </div>
        ))}

        <div className="col-md-6 mb-3">
          <label className="form-label fw-semibold">Ownership</label>
          <input
            type="text"
            className="form-control"
            value={schoolData.ownership || ''}
            onChange={(e) => handleChange('ownership', e.target.value)}
          />
        </div>
      </div>
      <button className="btn btn-primary mt-3" onClick={handleSubmit}>Validate & Create</button>
    </div>
  );
}
