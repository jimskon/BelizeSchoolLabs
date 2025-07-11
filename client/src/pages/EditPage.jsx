import React, { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import GenericForm from '../components/GenericForm';

const API_BASE_URL = import.meta.env.VITE_API_URL;

export default function EditPage() {
  const { table } = useParams();
  const navigate = useNavigate();
  const [formData, setFormData] = useState({});
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function fetchData() {
      try {
        const school = JSON.parse(localStorage.getItem('school'));
        if (!school?.code) throw new Error('No school session');
        const res = await fetch(`${API_BASE_URL}/api/${table}?code=${school.code}`);
        const raw = await res.json();
        if (!res.ok) {
          alert(raw.error || 'Failed to load data');
          navigate('/main');
          return;
        }
        // Load draft if exists, else use fetched data
        const draft = localStorage.getItem(`draft_${table}`);
        if (draft) {
          setFormData(JSON.parse(draft));
        } else {
          setFormData(raw);
        }
      } catch (err) {
        console.error('Error fetching table data:', err);
        navigate('/main');
      } finally {
        setLoading(false);
      }
    }
    fetchData();
  }, [table, navigate]);

  const handleSubmit = async (updatedData) => {  // add this line
    try {
      const school = JSON.parse(localStorage.getItem('school'));
      const payload = { ...updatedData, code: school.code };
      const res = await fetch(`${API_BASE_URL}/api/${table}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
      });
      const result = await res.json();
      console.log('Save result:', result); 
      
      if (result.success) {
          // Clear draft on successful save
          localStorage.removeItem(`draft_${table}`);
-         navigate('/main', { replace: true });
+         alert('Saved successfully!');
+        navigate('/main');
      } else {
        // Display backend error details
        alert(`Save failed: ${result.error || JSON.stringify(result)}`);
      }
    } catch (err) {
      console.error('Save error:', err);
      // Show detailed error message
      alert(`An error occurred while saving: ${err.message}`);
    }
  };

  const handleCancel = async (cancelData) => {
    try {
      // Persist partial data to server
      const school = JSON.parse(localStorage.getItem('school'));
      const payload = { ...cancelData, code: school.code };
      await fetch(`${API_BASE_URL}/api/${table}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload),
      });
    } catch (err) {
      console.error('Cancel save error:', err);
    } finally {
      // Save draft locally and navigate back
      localStorage.setItem(`draft_${table}`, JSON.stringify(cancelData));
      navigate('/main');
    }
  };

  if (loading) return <div className="container mt-4">Loading {table}...</div>;

  return (
    <div className="container mt-4">
      <div className="row justify-content-center">
        <div className="col-md-8">
          <div className="card shadow-sm">
            <div className="card-header bg-light">
              <h4 className="mb-0">Edit: {table.replace(/([A-Z])/g, ' $1').replace(/^./, str => str.toUpperCase())}</h4>
            </div>
            <div className="card-body">
              <GenericForm tableName={table} initialData={formData} onSubmit={handleSubmit} onCancel={handleCancel} />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
