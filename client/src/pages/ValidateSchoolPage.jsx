import React, { useEffect, useState } from 'react';

const API_BASE_URL = import.meta.env.VITE_API_URL;

export default function ValidateSchoolPage() {
  const [schools, setSchools] = useState([]);
  const [selected, setSelected] = useState('');
  const [schoolData, setSchoolData] = useState(null);
  const [password, setPassword] = useState('');

  useEffect(() => {
    fetch(`${API_BASE_URL}/api/school/moe-schools`)
      .then(res => res.json())
      .then(setSchools)
      .catch(console.error);
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
      <h2>Select Your School</h2>
      <select className="form-select" onChange={handleSelect} value={selected}>
        <option value="">-- Select a School --</option>
        {schools.map((s, i) => (
          <option key={i} value={s.name}>{s.name}</option>
        ))}
      </select>

      {schoolData && (
        <>
          <h3 className="mt-4">Confirm and Edit School Info</h3>
          {['name', 'address', 'contact_person', 'telephone', 'email', 'district', 'locality', 'type', 'sector', 'ownership'].map(field => (
            <div className="mb-3" key={field}>
              <label className="form-label">{field.replace(/_/g, ' ')}</label>
              <input
                type="text"
                className="form-control"
                value={schoolData[field] || ''}
                onChange={(e) => handleChange(field, e.target.value)}
              />
            </div>
          ))}
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
