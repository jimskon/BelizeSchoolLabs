import React, { useEffect, useState } from 'react';

const API_BASE_URL = import.meta.env.VITE_API_URL;

function ValidateSchoolPage() {
  const [schools, setSchools] = useState([]);

  useEffect(() => {
    fetch(`${API_BASE_URL}/api/school`)
      .then(res => res.json())
      .then(data => setSchools(data))
      .catch(err => console.error("Failed to fetch schools:", err));
  }, []);

  return (
    <div className="container mt-4">
      <h2>Select Your School</h2>
      <select className="form-select">
        {schools.map((s, i) => (
          <option key={i}>{s.name}</option>
        ))}
      </select>
    </div>
  );
}

export default ValidateSchoolPage;
