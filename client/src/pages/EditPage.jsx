import React, { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';

const API_BASE_URL = import.meta.env.VITE_API_URL;

// Schema-driven field definitions for each table
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
  { key: 'number_of_computer_labs', label: 'Number of computer rooms in your school (0,1,2,3+)', type: 'select', options: ['0', '1', '2', '3+'] },
  { key: 'minutes_drive_from_road', label: 'How many minutes drive is your school from the main road?', type: 'number' },
  { key: 'power_stability', label: 'Number of times per week the school’s power goes out (0, 1, 2, 3, 4, 5+)', type: 'select', options: ['0', '1', '2', '3', '4', '5+'] },
  { key: 'has_pta', label: 'Does your school have a PTA or group to help with funding?', type: 'select', options: ['Yes', 'No'] },
  { key: 'has_internet', label: 'Does your school have Internet access?', type: 'select', options: ['Yes', 'No'] },
  { key: 'number_of_classrooms_with_internet', label: 'Number of classrooms with Internet or WiFi', type: 'number' },
  { key: 'internet_provider', label: 'Internet provider (e.g. DigiNet, NextGen, Other)', type: 'select', options: ['DigiNet', 'NextGen', 'Other'] },
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

const curriculumFields = [
  { key: 'keyboarding', label: 'Does your school teach general keyboarding?', type: 'select', options: ['Yes', 'No'] },
  { key: 'computer_literacy', label: 'Does your school teach computer literacy?', type: 'select', options: ['Yes', 'No'] },
  { key: 'word', label: 'Does your school teach word processing such as Microsoft Word, LibreOffice/OpenOffice Write or Google Docs?', type: 'select', options: ['Yes', 'No'] },
  { key: 'spread_sheet', label: 'Does your school teach spreadsheets such as Excel, LibreOffice Calc, or Google Sheets?', type: 'select', options: ['Yes', 'No'] },
  { key: 'data_base', label: 'Does your school teach about databases such as MS Access, LibreOffice Base, MySQL?', type: 'select', options: ['Yes', 'No'] },
  { key: 'slide_show', label: 'Does your school teach slide show design such as PowerPoint, LibreOffice Present, Google Slides?', type: 'select', options: ['Yes', 'No'] },
  { key: 'google_workspace', label: 'Does your school also teach Google Workspace such as Google Docs, Sheets, etc.?', type: 'select', options: ['Yes', 'No'] },
  { key: 'software_suite', label: 'Which software suite does your school prefer?', type: 'select', options: ['Do not know', 'Microsoft Office', 'LibreOffice', 'OpenOffice', 'Google WorkSpace', 'Both Office and Workspace', 'No preference'] },
  { key: 'cloud_based_learning_tools', label: 'Does your school use other learning websites such as typing, spelling, math, etc.?', type: 'select', options: ['Yes', 'No'] },
  { key: 'graphics_design', label: 'Does your school teach graphics design tools such as Photoshop, Illustrator, Publisher, Canva, PosterMyWall or equivalent?', type: 'select', options: ['Yes', 'No'] },
  { key: 'graphics_animation', label: 'Does your school teach graphics animation such as Blender or equivalent?', type: 'select', options: ['Yes', 'No'] },
  { key: 'graphics_cad_program', label: 'Does your school teach graphics CAD tools such as AutoCad or equivalent?', type: 'select', options: ['Yes', 'No'] },
  { key: 'robotics', label: 'Does your school teach robotics?', type: 'select', options: ['Yes', 'No'] },
  { key: 'code_dot_org', label: 'Does your school use code.org?', type: 'select', options: ['Yes', 'No'] },
  { key: 'khan_accadamy', label: 'Does your school use Khan Academy or similar online learning platforms?', type: 'select', options: ['Yes', 'No'] },
  { key: 'edpm', label: 'Does your school teach EDPM?', type: 'select', options: ['Yes', 'No'] },
  { key: 'other_online_local_education_tools', label: 'What other online tools does your school use or teach?', type: 'text' },
  { key: 'formal_curriculum', label: 'What formal computer related curriculum does your school use if any?', type: 'text' },
  { key: 'local_curriculum', label: 'What locally generated computer related curriculum does your school use?', type: 'text' },
  { key: 'rachel_server', label: 'Does your school participate in the Rachel server project?', type: 'select', options: ['Yes', 'No'] },
  { key: 'other', label: 'What other computer related teaching tools do you use that were not mentioned above?', type: 'textarea' },
  { key: 'comments', label: 'Any additional comments?', type: 'textarea' }
];

const computerRoomFields = [
  { key: 'wired_for_lab', label: 'Has your computer room been wired expressly for a computer lab?', type: 'select', options: ['Yes', 'No'] },
  { key: 'electrical', label: 'Does your computer room have a dedicated electrical service panel in the computer room?', type: 'select', options: ['Yes', 'No'] },
  { key: 'electrical_ground', label: 'Is there a quality ground wire connected to a ground rod?', type: 'select', options: ['Yes', 'No'] },
  { key: 'electrical_outlets', label: 'How many electrical outlets are in the computer room?', type: 'number' },
  { key: 'air_condition', label: 'How many working air conditioners does your computer lab have?', type: 'number' },
  { key: 'num_of_doors', label: 'How many doors does the computer room have?', type: 'number' },
  { key: 'num_of_doors_secure', label: 'How many doors with burglar bars does the computer room have?', type: 'number' },
  { key: 'partition_security', label: 'Are all 4 walls in your computer room concrete including the partition to the next room?', type: 'select', options: ['Yes', 'No'] },
  { key: 'ceiling_secure', label: 'Is your computer lab ceiling constructed of concrete or steel with no open spaces and secured from a thief climbing over the partitioned wall?', type: 'select', options: ['Yes', 'No'] },
  { key: 'windows_secure', label: 'Are all the windows removed and blocked, or have strong burglar bars installed?', type: 'select', options: ['Yes', 'No'] },
  { key: 'lighting', label: 'Is the lighting in your computer room sufficient (even when all windows are blocked)?', type: 'select', options: ['Yes', 'No'] },
  { key: 'location', label: 'Is your computer room located at the end of your building (i.e. with 3 outside walls)?', type: 'select', options: ['Yes', 'No'] },
  { key: 'location_floor', label: 'Is your computer room located on the first floor?', type: 'select', options: ['Yes', 'No'] },
  { key: 'comments', label: 'Any additional comments?', type: 'textarea' }
];

const resourcesFields = [
  { key: 'number_seats', label: 'How many student computer stations can your lab accommodate?', type: 'number' },
  { key: 'desktop_working', label: 'How many working desktop computers does your main school lab / room have?', type: 'number' },
  { key: 'desktop_not_working', label: 'How many non-working desktops do you have? Please report actual non-working desktops.', type: 'number' },
  { key: 'desktop_age', label: 'Estimate how old your desktops are in years?', type: 'number' },
  { key: 'desktop_ownership', label: 'Approximately how long have you had your desktops in years?', type: 'number' },
  { key: 'desktop_monitors', label: 'How many working monitors does your main school lab / room have?', type: 'number' },
  { key: 'desktop_keyboards', label: 'How many working keyboards does your main school lab / room have?', type: 'number' },
  { key: 'desktop_mice', label: 'How many working mice does your main school lab / room have?', type: 'number' },
  { key: 'desktop_comments', label: 'Comments on the reliability and usefulness of your desktop computers', type: 'text' },
  { key: 'chromebooks_working', label: 'How many working Chromebooks does your school have?', type: 'number' },
  { key: 'chromebooks_broken', label: 'How many Chromebooks broke within their first two years?', type: 'number' },
  { key: 'chromebooks_lost', label: 'How many Chromebooks were lost or stolen in their first two years?', type: 'number' },
  { key: 'chromebooks_comments', label: 'Comments on the reliability and usefulness of the Chromebooks', type: 'text' },
  { key: 'tablets_working', label: 'How many working tablets does your school have?', type: 'number' },
  { key: 'tablets_broken', label: 'How many tablets broke within their first two years?', type: 'number' },
  { key: 'tablets_lost', label: 'How many tablets were lost or stolen in their first two years?', type: 'number' },
  { key: 'tablets_comments', label: 'Comments on the reliability and usefulness of your tablets', type: 'text' },
  { key: 'old_computers_work', label: 'What do you plan to do with your old computers and tablets that still work?', type: 'text' },
  { key: 'old_computers_broken', label: 'What do you plan to do with your broken computers and tablets?', type: 'text' },
  { key: 'comments', label: 'Any additional comments?', type: 'textarea' }
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
      const payload = { ...formData, school_id: JSON.parse(localStorage.getItem('school')).id };
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

  if (loading) {
    return <div className="container mt-4">Loading {table}...</div>;
  }

  const isSchoolInfo = table === 'school_info';
  const isDemographics = table === 'demographics';
  const isCurriculum = table === 'curriculum';
  const isComputerRoom = table === 'computerRoom';
  const isResources = table === 'resources';

  const fieldsToRender = isSchoolInfo
    ? schoolInfoFields
    : isDemographics
      ? demographicsFields
      : isCurriculum
        ? curriculumFields
        : isComputerRoom
          ? computerRoomFields
          : isResources
            ? resourcesFields
            : Object.entries(formData)
                .filter(([key]) => !['id', 'school_id', 'created_at', 'updated_at', 'verified_at', 'admin_comments'].includes(key))
                .map(([key]) => ({
                  key,
                  label: key.replace(/_/g, ' ').replace(/^./, c => c.toUpperCase()),
                  type: 'text'
                }));

  return (
    <div className="container mt-4">
      <div className="row justify-content-center">
        <div className="col-md-8">
          <div className="card shadow-sm">
            <div className="card-header bg-light">
              <h4 className="mb-0">
                Edit:{' '}
                {isSchoolInfo
                  ? 'School Information'
                  : isDemographics
                  ? 'Demographics'
                  : isCurriculum
                  ? 'Curriculum'
                  : isComputerRoom
                  ? 'Computer Room'
                  : isResources
                  ? 'Resources'
                  : table}
              </h4>
            </div>
            <div className="card-body">
              <form>
                <div className="row">
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
                            {field.options.map(opt => (
                              <option key={opt} value={opt}>
                                {opt}
                              </option>
                            ))}
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
                            onChange={e =>
                              handleChange(
                                field.key,
                                field.type === 'number' ? Number(e.target.value) : e.target.value
                              )
                            }
                          />
                        </div>
                      );
                    }
                  })}
                </div>
                <div className="d-flex gap-2">
                  <button type="button" className="btn btn-success" onClick={handleSave}>
                    Save
                  </button>
                  <button type="button" className="btn btn-secondary" onClick={() => navigate('/main')}>
                    Cancel
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}