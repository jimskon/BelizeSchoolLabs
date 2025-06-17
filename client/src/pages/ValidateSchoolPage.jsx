import React, { useEffect, useState } from 'react';

const API_BASE_URL = import.meta.env.VITE_API_URL;

export default function ValidateSchoolPage() {
  const [schools, setSchools] = useState([]);
  const [selected, setSelected] = useState('');
  const [schoolData, setSchoolData] = useState(null);
  const [password, setPassword] = useState('');
  const [districts, setDistricts] = useState([]);
  const [selectedDistrict, setSelectedDistrict] = useState('');

  useEffect(() => {
    const fetchSchools = async () => {
      try {
        const res = await fetch(`${API_BASE_URL}/api/school/moe-schools`);
        const data = await res.json();
        setSchools(data);

        // Extract and set unique districts
        const uniqueDistricts = [...new Set(data.map(s => s.district).filter(Boolean))].sort();
        setDistricts(uniqueDistricts);
      } catch (err) {
        console.error("Error fetching schools:", err);
      }
    };

    fetchSchools();
  }, []);

  const handleSelect = async (e) => {
    const name = e.target.value;
    setSelected(name);
    const res = await fetch(`${API_BASE_URL}/api/school/moe-school?name=${encodeURIComponent(name)}`);
    const data = await res.json();
    setSchoolData(data);
  };

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
      setPassword(result.password);
    } else {
      alert("Error: " + result.error);
    }
  };

  return (
    <div className="container mt-4">
      <h2 className="mb-3">Select Your School</h2>

      {!schoolData && (
        <>
          <div className="mb-3">
            <label className="form-label fw-semibold">Filter by District (optional)</label>
            <select
              className="form-select"
              value={selectedDistrict}
              onChange={(e) => setSelectedDistrict(e.target.value)}
              style={{ width: '20ch' }}
            >
              <option value="">-- All Districts --</option>
              {districts.map((district, i) => (
                <option key={i} value={district}>{district}</option>
              ))}
            </select>
          </div>

          <div className="mb-3">
            <label className="form-label fw-semibold">Select School</label>
            <select
              className="form-select"
              onChange={handleSelect}
              value={selected}
              style={{ width: '60ch' }}
            >
              <option value="">-- Select a School --</option>
              {schools
                .filter(s => !selectedDistrict || s.district === selectedDistrict)
                .map((s, i) => (
                  <option key={i} value={s.name}>{s.name}</option>
                ))}
            </select>
          </div>
        </>
      )}
      {schoolData && (
        <>
          <h4 className="mb-3">Selected School: <strong>{schoolData.name}</strong></h4>
          <div className="row">
            {[
              { key: 'name' },
              { key: 'address' },
              { key: 'contact_person' },
              { key: 'telephone' },
              { key: 'email' },
              {
                key: 'district',
                options: ['Belize', 'Cayo', 'Corozal', 'Orange Walk', 'Stann Creek', 'Toledo']
              },
              {
                key: 'locality',
                options: ['Rural', 'Urban', 'Other']
              },
              {
                key: 'type',
                options: ['Preschool', 'Primary', 'Secondary', 'Tertiary', 'Vocational', 'Adult and Continuing', 'University']
              },
              {
                key: 'sector',
                options: ['Government', 'Government Aided', 'Private', 'Specially Assisted']
              },
              { key: 'ownership' } // free text
            ].map(({ key, options }) => (
              <div className="col-md-6 mb-3" key={key}>
                <label className="form-label fw-semibold">
                  {key.replace(/_/g, ' ').replace(/\b\w/g, c => c.toUpperCase())}
                </label>
                {options ? (
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
                ) : (
                  <input
                    type="text"
                    className="form-control"
                    value={schoolData[key] || ''}
                    onChange={(e) => handleChange(key, e.target.value)}
                  />
                )}
              </div>
            ))}

          </div>
          <button className="btn btn-primary mt-3" onClick={handleSubmit}>Validate & Create</button>
        </>
      )}


      {password && (
        <div className="alert alert-success mt-4">
          <strong>Account created!</strong> Your temporary password is: <code>{password}</code>
        </div>
      )}
    </div>
  );
}