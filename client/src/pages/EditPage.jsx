import React, { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';

const API_BASE_URL = import.meta.env.VITE_API_URL;

// Define schema-based field definitions for school_info
const schoolInfoFields = [
  { key: 'moe_name', label: 'Name of the school from the latest MOE load', type: 'text' },
  { key: 'name', label: 'Corrected school name (as entered by principal)', type: 'text' },
  { key: 'code', label: "MOE's code for each school", type: 'text' },
  { key: 'address', label: "School's main address", type: 'text' },
  { key: 'contact_person', label: "School's contact person (usually the principal)", type: 'text' },
  { key: 'telephone', label: "Principal's phone number", type: 'number' },
  { key: 'telephone_alt1', label: 'Alternate phone number', type: 'number' },
  { key: 'telephone_alt2', label: 'Second alternate phone number', type: 'number' },
  { key: 'moe_email', label: "Email address from MOE load", type: 'email' },
  { key: 'email', label: "Principal's email address", type: 'email' },
  { key: 'email_alt', label: 'Alternate email (e.g. main school email)', type: 'email' },
  { key: 'website', label: "School's website (optional)", type: 'text' },
  { key: 'year_opened', label: 'Year the school opened', type: 'number' },
  { key: 'longitude', label: 'Longitude of school building', type: 'number' },
  { key: 'latitude', label: 'Latitude of school building', type: 'number' },
  { key: 'district', label: 'District', type: 'select', options: ['Belize', 'Cayo', 'Corozal', 'Orange Walk', 'Stann Creek', 'Toledo'] },
  { key: 'locality', label: 'Locality', type: 'select', options: ['Rural', 'Urban'] },
  { key: 'type', label: 'School type', type: 'select', options: ['Preschool', 'Primary', 'Secondary', 'Tertiary', 'Vocational', 'Adult and Continuing', 'University'] },
  { key: 'sector', label: 'Sector', type: 'select', options: ['Government', 'Government Aided', 'Private', 'Specially Assisted'] },
  { key: 'ownership', label: 'Ownership (e.g. Catholic, Methodist, Private, etc.)', type: 'text' },
  { key: 'school_administrator_1', label: 'Administrator 1 name', type: 'text' },
  { key: 'school_administrator_2', label: 'Administrator 2 name', type: 'text' },
  { key: 'comments', label: 'Please provide any additional information or clarifying comments', type: 'textarea' }
];
// Define schema-based field definitions for demographics
const demographicsFields = [
  { key: 'principals_name', label: 'Principal’s name', type: 'text' },
  { key: 'principals_telephone', label: 'Principal’s phone number (WhatsApp preferred)', type: 'number' },
  { key: 'principals_email', label: 'Principal’s email address', type: 'email' },
  { key: 'schools_email', label: 'School’s email address (optional)', type: 'email' },
  { key: 'principals_computer', label: "Does the principal's office have a good working computer that is not rented?", type: 'select', options: ['Yes', 'No'] },
  { key: 'number_of_students', label: 'Total number of students in your school', type: 'number' },
  { key: 'number_of_teachers', label: 'Number of teachers (full or part-time)', type: 'number' },
  { key: 'largest_class_size', label: 'Number of students in your largest classroom', type: 'number' },
  { key: 'number_of_buildings', label: 'Number of buildings at your school (not including storage buildings)', type: 'number' },
  { key: 'number_of_classrooms', label: 'Number of classrooms in your school', type: 'number' },
  { key: 'number_of_computer_labs', label: 'Number of computer rooms in your school (0,1,2,3+)', type: 'select',options: ['0','1','2','3+'] },
  { key: 'minutes_drive_from_road', label: 'How many minutes drive is your school from the main road?', type: 'number' },
  { key: 'power_stability', label: 'Number of times per week the school’s power goes out (0, 1, 2, 3, 4, 5+)', type: 'select',options: ['0','1','2','3','4','5+'] },
  { key: 'has_pta', label: 'Does your school have a PTA or group to help with funding?', type: 'select',options:['Yes','No'] },
  { key: 'has_internet', label: 'Does your school have Internet access?', type: 'select',options:['Yes','No'] },
  { key: 'number_of_classrooms_with_internet', label: 'Number of classrooms with Internet or WiFi', type: 'number' },
  { key: 'internet_provider', label: 'Internet provider (e.g. DigiNet, NextGen, Other)', type: 'selct', option:['DigiNet','NextGen','Other'] },
  { key: 'internet_speed', label: 'Internet speed in Mbps', type: 'select', options: ['Don’t know', '10 to 49 Mbps', '50 to 99 Mbps', '100 to 249 Mbps', '250 to 500 Mbps'] },
  { key: 'connection_method', label: 'Internet connection method', type: 'text' },
  { key: 'internet_stability', label: 'Describe the Internet stability when all students are using devices', type: 'select', options: ['Very stable', 'Mostly OK', 'Comes in and out', 'Unstable'] },
  { key: 'number_of_teachers_that_have_laptops', label: 'How many of your teachers own laptops?', type: 'number' },
  { key: 'number_of_full_time_IT_teachers', label: 'Number of full-time IT teachers', type: 'number' },
  { key: 'number_of_teachers_that_also_teach_IT', label: 'Number of teachers who also teach IT', type: 'number' },
  { key: 'primary_IT_teacher_name', label: 'Name of the main IT teacher', type: 'text' },
  { key: 'primary_IT_teacher_phone', label: 'Phone number of the main IT teacher', type: 'text' },
  { key: 'primary_IT_teacher_email', label: 'Email of the main IT teacher', type: 'email' },
  { key: 'percentage_of_students_who_have_personal_computers', label: 'Estimate of % of students who own computers', type: 'select', options: ['<20%', '20-40%', '40-60%', '60-80%', '80+%'] },
  { key: 'students_computers_outside_school', label: 'Estimate of % of students with computers outside school', type: 'select', options: ['<20%', '20-40%', '40-60%', '60-80%', '80+%'] },
  { key: 'students__phones_for_school_work', label: 'Estimate of % of students who use phones for school work', type: 'select', options: ['<20%', '20-40%', '40-60%', '60-80%', '80+%'] },
  { key: 'comments', label: 'Do you have any comments about the above information', type: 'textarea' }
];

export default function EditPage() {
  const { table } = useParams();
  const navigate = useNavigate();
  const [formData, setFormData] = useState({});
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function fetchData() {
      try {
        const school = JSON.parse(localStorage.getItem('school'));
        if (!school?.id) throw new Error('No school session');
        const res = await fetch(`${API_BASE_URL}/api/${table}?school_id=${school.id}`);
        const raw = await res.json();
        if (!res.ok) {
          alert(raw.error || 'Failed to load data');
          navigate('/main');
          return;
        }
        setFormData(raw);
      } catch (err) {
        console.error('Error fetching table data:', err);
        navigate('/main');
      } finally {
        setLoading(false);
      }
    }
    fetchData();
  }, [table, navigate]);

  const handleChange = (key, value) => {
    setFormData(prev => ({ ...prev, [key]: value }));
  };

  const handleSave = async () => {
    try {
      const payload = { ...formData };
      payload.school_id = JSON.parse(localStorage.getItem('school')).id;
      const res = await fetch(`${API_BASE_URL}/api/${table}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
      });
      const result = await res.json();
      if (result.success) {
        alert('Saved successfully!');
        navigate('/main');
      } else {
        alert(result.error || 'Save failed');
      }
    } catch (err) {
      console.error('Save error:', err);
      alert('An error occurred while saving.');
    }
  };

  if (loading) return <div className="container mt-4">Loading {table}...</div>;

  // Render school_info with schema-driven fields, else generic form
  const isSchoolInfo = table === 'school_info';
const isDemographics = table === 'demographics';
  const fieldsToRender = isSchoolInfo
    ? schoolInfoFields
    : isDemographics
      ? demographicsFields
      : Object.entries(formData)
          .filter(([key]) => !['id','school_id','created_at','updated_at','verified_at','admin_comments'].includes(key))
          .map(([key, value]) => ({ key, label: key.replace(/_/g, ' ').replace(/^./, c => c.toUpperCase()), type: 'text' }));

  return (
    <div className="container mt-4">
      <h3>Edit: {isSchoolInfo ? 'School Information' : table}</h3>
      <form>
        {fieldsToRender.map(field => {
          const value = formData[field.key] ?? '';
          if (field.type === 'select') {
            return (
              <div className="col-md-6 mb-3" key={field.key}>
                <label className="form-label fw-semibold">{field.label}</label>
                <select
                  className="form-select"
                  value={value}
                  onChange={e => handleChange(field.key, e.target.value)}
                >
                  <option value="">-- Select --</option>
                  {field.options.map(opt => <option key={opt} value={opt}>{opt}</option>)}
                </select>
              </div>
            );
          } else if (field.type === 'textarea') {
            return (
              <div className="mb-3" key={field.key}>
                <label className="form-label fw-semibold">{field.label}</label>
                <textarea
                  className="form-control"
                  rows={3}
                  value={value}
                  onChange={e => handleChange(field.key, e.target.value)}
                />
              </div>
            );
          } else {
            return (
              <div className="mb-3" key={field.key}>
                <label className="form-label fw-semibold">{field.label}</label>
                <input
                  className="form-control"
                  type={field.type}
                  value={value}
                  onChange={e => handleChange(field.key, field.type === 'number' ? Number(e.target.value) : e.target.value)}
                />
              </div>
            );
          }
        })}
        <div className="d-flex gap-2">
          <button type="button" className="btn btn-success" onClick={handleSave}>Save</button>
          <button type="button" className="btn btn-secondary" onClick={() => navigate('/main')}>Cancel</button>
        </div>
      </form>
    </div>
  );
}