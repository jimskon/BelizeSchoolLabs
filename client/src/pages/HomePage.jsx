import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';

const API_BASE_URL = import.meta.env.VITE_API_URL;

export default function HomePage() {
  const [schoolName, setSchoolName] = useState('');
  const [tables, setTables] = useState([]);
  const navigate = useNavigate();

  useEffect(() => {
    const schoolData = JSON.parse(localStorage.getItem('school'));
    if (schoolData && schoolData.id) {
      setSchoolName(schoolData.name);
      fetchTableStatus(schoolData.id);
    } else {
      navigate('/login');
    }
  }, [navigate]);

  const fetchTableStatus = async (id) => {
  try {
  const res = await fetch(`${API_BASE_URL}/api/school/status/${id}`);
  const data = await res.json();
  if (data.success) setTables(data.tables);
  } catch (err) {
  console.error('Failed to fetch table statuses:', err);
  }
  };
  
  // Logout handler: clears session and redirects to login
  const handleLogout = () => {
  localStorage.removeItem('school');
  navigate('/login');
  };

  return (
    <>
      <nav className="navbar navbar-expand-lg navbar-dark bg-primary">
        <div className="container">
          <a className="navbar-brand" href="#">School Dashboard</a>
          <button className="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span className="navbar-toggler-icon"></span>
          </button>
          <div className="collapse navbar-collapse" id="navbarNav">
            <ul className="navbar-nav ms-auto align-items-center">
              <li className="nav-item dropdown me-3">
                <a className="nav-link dropdown-toggle" href="#" id="uploadDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                  Upload
                </a>
                <ul className="dropdown-menu dropdown-menu-end" aria-labelledby="uploadDropdown">
                  <li><button className="dropdown-item" onClick={() => alert('Upload picture functionality here')}>Upload Picture</button></li>
                </ul>
              </li>
              <li className="nav-item">
                <span className="nav-link active fw-bold">{schoolName}</span>
              </li>
              <li className="nav-item">
              </li>
            </ul>
          </div>
        </div>
      </nav>

      <header className="bg-light py-5">
        <div className="container text-center">
          <h1 className="display-5 fw-bold">Welcome, {schoolName}</h1>
          <p className="lead text-muted">Manage your school’s data with ease.</p>
        </div>
      </header>

      <main className="container my-5">
        <div className="row g-4">
          {tables.map(({ table, status, lastUpdated }) => (
            <div key={table} className="col-sm-6 col-md-4">
              <div className="card h-100">
                <div className="card-body d-flex flex-column">
                  <h5 className="card-title text-capitalize">{table.replace(/_/g, ' ')}</h5>
                  <p className="card-text mb-2">
                    <span className={`badge me-2 ${
                      status === 'Input complete' ? 'bg-success' :
                      status === 'Required fields complete' ? 'bg-warning text-dark' :
                      status === 'In progress' ? 'bg-info text-dark' :
                      status === 'Not started' ? 'bg-secondary' :
                      'bg-secondary'
                    }`}>{status}</span>
                    <small className="text-muted">
                      {lastUpdated ? new Date(lastUpdated).toLocaleDateString() : '—'}
                    </small>
                  </p>
                  <button
                    className="btn btn-outline-primary mt-auto"
                    onClick={() => navigate(`/${table}/edit`)}
                  >
                    Edit
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>
      </main>
    </>
  );
}