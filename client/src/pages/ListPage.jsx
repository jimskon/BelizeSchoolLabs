import React, { useEffect, useState, useMemo } from 'react';
import { useParams, useNavigate } from 'react-router-dom';

const API_BASE_URL = import.meta.env.VITE_API_URL;

export default function ListPage() {
  const { table } = useParams();
  const navigate = useNavigate();
  const [rows, setRows] = useState([]);
  const [fields, setFields] = useState([]);

  // Determine which columns to display: for demographics show all except metadata
  const displayFields = useMemo(() => {
    if (table === 'demographics' && rows.length > 0) {
      return Object.keys(rows[0]).filter(
        key => !['id', 'school_id', 'admin_comments', 'created_at', 'updated_at'].includes(key)
      );
    }
    return fields.map(f => f.field_name);
  }, [table, rows, fields]);

  // Load form field metadata
  useEffect(() => {
    fetch(`${API_BASE_URL}/api/form-config/${table}`)
      .then(res => res.json())
      .then(data => {
        if (data.success) setFields(data.fields);
      });
  }, [table]);

  // Load table data (filtered by school_id if available)
  useEffect(() => {
    const school = JSON.parse(localStorage.getItem('school')) || {};
    let url = `${API_BASE_URL}/api/${table}/list`;
    if (school.id) {
      url += `?school_id=${school.id}`;
    }
    fetch(url)
      .then(res => res.json())
      .then(data => {
        setRows(data);
      });
  }, [table]);

  const handleEdit = (id) => {
    navigate(`/${table}/edit`);
  };

  const handleDelete = async (id) => {
    if (!window.confirm('Are you sure you want to delete this record?')) return;
    try {
      await fetch(`${API_BASE_URL}/api/${table}/${id}`, { method: 'DELETE' });
      setRows(prev => prev.filter(r => r.id !== id));
    } catch (err) {
      console.error('Delete failed', err);
      alert('Failed to delete record.');
    }
  };

  return (
    <div className="container my-4">
      <h4 className="mb-3 text-primary">List {table.replace(/([A-Z])/g, ' $1')}</h4>
      <table className="table table-striped">
        <thead>
          <tr>
            <th>ID</th>
            {displayFields.map(key => (
              <th key={key}>
                {table === 'demographics'
                  ? key.replace(/_/g, ' ').replace(/\b\w/g, c => c.toUpperCase())
                  : fields.find(f => f.field_name === key)?.prompt}
              </th>
            ))}
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {rows.map(row => (
            <tr key={row.id}>
              <td>{row.id}</td>
              {displayFields.map(key => (
                <td key={key}>{row[key] ?? ''}</td>
              ))}
              <td>
                <button className="btn btn-sm btn-outline-primary me-2" onClick={() => handleEdit(row.id)}>
                  Edit
                </button>
                <button className="btn btn-sm btn-outline-danger" onClick={() => handleDelete(row.id)}>
                  Delete
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
