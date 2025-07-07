import React, { useEffect, useState } from 'react';

const API_BASE_URL = import.meta.env.VITE_API_URL;

export default function SchoolSelector({ selectedSchool, setSelectedSchool, selectedDistrict, setSelectedDistrict, selectedType, setSelectedType }) {
  const [schools, setSchools] = useState([]);
  const [districts, setDistricts] = useState([]);
  const [types, setTypes] = useState([]);

  useEffect(() => {
    const fetchSchools = async () => {
      try {
        const res = await fetch(`${API_BASE_URL}/api/school/moe-schools`);
        const data = await res.json();
        setSchools(data);

        // Extract districts from data
        const uniqueDistricts = [...new Set(data.map(s => s.district).filter(Boolean))].sort();
        setDistricts(uniqueDistricts);

        // Extract types from data
        const uniqueTypes = [...new Set(data.map(s => s.type).filter(Boolean))].sort();
        setTypes(uniqueTypes);
      } catch (err) {
        console.error("Error fetching school list:", err);
      }
    };

    fetchSchools();
  }, []);

  const filteredSchools = schools.filter(
    s =>
      (!selectedDistrict || s.district === selectedDistrict) &&
      (!selectedType || s.type === selectedType)
  );

  return (
    <div className="mb-3">
      <div className="mb-2">
        <label className="form-label fw-semibold">District</label>
        <select
          className="form-select"
          value={selectedDistrict}
          onChange={e => setSelectedDistrict(e.target.value)}
          style={{ width: '20ch' }}
        >
          <option value="">-- All Districts --</option>
          {districts.map((d, i) => (
            <option key={i} value={d}>
              {d}
            </option>
          ))}
        </select>
      </div>

      <div className="mb-2">
        <label className="form-label fw-semibold">Type</label>
        <select
          className="form-select"
          value={selectedType}
          onChange={e => setSelectedType(e.target.value)}
          style={{ width: '20ch' }}
        >
          <option value="">-- All Types --</option>
          {types.map((t, i) => (
            <option key={i} value={t}>
              {t}
            </option>
          ))}
        </select>
      </div>

      <div>
        <label className="form-label fw-semibold">School</label>
        <select
          className="form-select"
          value={selectedSchool}
          onChange={e => setSelectedSchool(e.target.value)}
          disabled={!selectedDistrict || !selectedType}
          style={{ width: '60ch' }}
        >
          <option value="">-- Select a School --</option>
          {filteredSchools.map((s, i) => (
            <option key={i} value={s.name}>
              {s.name}
            </option>
          ))}
        </select>
      </div>
    </div>
  );
}