import React, { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import GenericForm from '../components/GenericForm';

// Load backend API URL from environment variables
const API_BASE_URL = import.meta.env.VITE_API_URL;

export default function EditPage() {
  const { table } = useParams();               // Extracts the table name from the route (e.g., /edit/:table)
  const navigate = useNavigate();              // Used for programmatic navigation
  const [formData, setFormData] = useState({}); // Holds the form data for the current table
  const [loading, setLoading] = useState(true); // Flag to control loading UI

  // ==========================
  // useEffect to fetch table data on load
  // ==========================
  useEffect(() => {
    async function fetchData() {
      try {
        const school = JSON.parse(localStorage.getItem('school'));
        if (!school?.code) throw new Error('No school session');

        // Fetch existing data from server using school code and table name
        const res = await fetch(`${API_BASE_URL}/api/${table}?code=${school.code}`);
        const raw = await res.json();

        if (!res.ok) {
          alert(raw.error || 'Failed to load data');
          navigate('/main'); // Redirect if fetch fails
          return;
        }

        // Check if there's a saved draft in localStorage
        const draft = localStorage.getItem(`draft_${table}`);
        if (draft) {
          setFormData(JSON.parse(draft)); // Use draft if available
        } else {
          setFormData(raw); // Otherwise use server data
        }
      } catch (err) {
        console.error('Error fetching table data:', err);
        navigate('/main'); // Redirect on any error
      } finally {
        setLoading(false); // Hide loading state once done
      }
    }

    fetchData();
  }, [table, navigate]); // Re-run this effect when the table or navigate function changes

  // ==========================
  // Handle form submission (Save)
  // ==========================
  const handleSubmit = async (updatedData) => {
    try {
      const school = JSON.parse(localStorage.getItem('school'));

      // Prepare payload with updated data and school code
      const payload = { ...updatedData, code: school.code };

      const res = await fetch(`${API_BASE_URL}/api/${table}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
      });

      const result = await res.json();
      console.log('Save result:', result);

      if (result.success) {
        // Clear saved draft on successful submission
        localStorage.removeItem(`draft_${table}`);
        alert('Saved successfully!');
        navigate('/main'); // Redirect to main page
      } else {
        alert(`Save failed: ${result.error || JSON.stringify(result)}`);
      }
    } catch (err) {
      console.error('Save error:', err);
      alert(`An error occurred while saving: ${err.message}`);
    }
  };

  // ==========================
  // Handle cancel (Save partial + draft)
  // ==========================
  const handleCancel = async (cancelData) => {
    try {
      const school = JSON.parse(localStorage.getItem('school'));

      // Save partial data to server to track progress
      const payload = { ...cancelData, code: school.code };

      await fetch(`${API_BASE_URL}/api/${table}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload),
      });
    } catch (err) {
      console.error('Cancel save error:', err);
    } finally {
      // Save draft locally to restore later
      localStorage.setItem(`draft_${table}`, JSON.stringify(cancelData));
      navigate('/main'); // Return to main page
    }
  };

  // ==========================
  // Loading state UI
  // ==========================
  if (loading) return <div className="container mt-4">Loading {table}...</div>;

  // ==========================
  // Main form render
  // ==========================
  return (
    <div className="container mt-4">
      <div className="row justify-content-center">
        <div className="col-md-8">
          <div className="card shadow-sm">
            <div className="card-header bg-light">
              {/* Convert camelCase table names into spaced capitalized text */}
              <h4 className="mb-0">
                Edit: {table.replace(/([A-Z])/g, ' $1').replace(/^./, str => str.toUpperCase())}
              </h4>
            </div>
            <div className="card-body">
              {/* Render the reusable form component */}
              <GenericForm
                tableName={table}
                initialData={formData}
                onSubmit={handleSubmit}
                onCancel={handleCancel}
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
