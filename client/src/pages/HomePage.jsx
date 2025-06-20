// client/src/pages/HomePage.jsx
import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';

const API_BASE_URL = import.meta.env.VITE_API_URL;

export default function HomePage() {
  const [schoolName, setSchoolName] = useState('');
  const [tables, setTables] = useState([]);
  const [schoolId, setSchoolId] = useState(null);
  const navigate = useNavigate();

  useEffect(() => {
  const schoolData = JSON.parse(localStorage.getItem('school'));
  if (schoolData && schoolData.id) {
    setSchoolId(schoolData.id);
    setSchoolName(schoolData.name);
    fetchTableStatus(schoolData.id);
  } else {
    navigate('/login'); // fallback if no session
  }
}, []);

  const fetchTableStatus = async (id) => {
    try {
      const res = await fetch(`${API_BASE_URL}/api/school/status/${id}`);
      const data = await res.json();
      if (data.success) {
        setTables(data.tables);
      }
    } catch (err) {
      console.error('Failed to fetch table statuses:', err);
    }
  };

  return (
    <div className="container mt-5">
      <div className="d-flex justify-content-between align-items-center">
        <h2>School Dashboard</h2>
        <span className="fw-bold">{schoolName}</span>
      </div>

      <table className="table mt-4">
        <thead>
          <tr>
            <th>Table</th>
            <th>Status</th>
            <th>Last Updated</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          {tables.map(({ table, status, lastUpdated }) => (
            <tr key={table}>
              <td>{table}</td>
              <td>
                <span className={`badge ${
                  status === 'Complete' ? 'bg-success' :
                  status === 'In Progress' ? 'bg-warning text-dark' :
                  'bg-secondary'
                }`}>
                  {status}
                </span>
              </td>
              <td>{lastUpdated ? new Date(lastUpdated).toLocaleString() : '—'}</td>
              <td>
                <button
                  className="btn btn-sm btn-outline-primary"
                  onClick={() => navigate(`/${table}/edit`)}
                >
                  Edit
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
