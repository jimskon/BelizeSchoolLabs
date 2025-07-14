import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Modal, Button, Carousel } from 'react-bootstrap';
import axios from 'axios'; // Though axios is imported, fetch is used

// Load backend base URL from environment
const API_BASE_URL = import.meta.env.VITE_API_URL;

export default function HomePage() {
  // =========================
  // State Variables
  // =========================
  const [schoolName, setSchoolName] = useState('');
  const [tables, setTables] = useState([]); // Table status data
  const [pictures, setPictures] = useState([]); // Uploaded pictures
  const [editingPictureId, setEditingPictureId] = useState(null); // ID of picture being edited
  const [showUpload, setShowUpload] = useState(false); // Toggle upload UI
  const [uploadCategory, setUploadCategory] = useState('');
  const [uploadDescription, setUploadDescription] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('All'); // Filter category for carousel
  const [showModal, setShowModal] = useState(false); // Modal open/close
  const [modalPic, setModalPic] = useState(null); // Picture to show in modal
  const [uploadFile, setUploadFile] = useState(null); // File to upload
  const [editingCategory, setEditingCategory] = useState('');
  const [editingDescription, setEditingDescription] = useState('');
  const navigate = useNavigate();

  // =========================
  // Load school data and statuses on mount
  // =========================
  useEffect(() => {
    const schoolData = JSON.parse(localStorage.getItem('school'));
    if (schoolData && schoolData.code) {
      setSchoolName(schoolData.name);
      fetchTableStatus(schoolData.code);
      fetchPictures();
    } else {
      navigate('/login');
    }
  }, [navigate]);

  // Fetch form section completion statuses
  const fetchTableStatus = async (code) => {
    try {
      const res = await fetch(`${API_BASE_URL}/api/school/status/${code}`);
      const data = await res.json();
      if (data.success) setTables(data.tables);
    } catch (err) {
      console.error('Failed to fetch table statuses:', err);
    }
  };

  // Fetch pictures for this school
  const fetchPictures = async () => {
    const school = JSON.parse(localStorage.getItem('school'));
    if (!school || !school.code) return;

    try {
      const res = await fetch(`${API_BASE_URL}/api/pictures/list?code=${school.code}`);
      const data = await res.json();
      if (data.success) {
        setPictures(data.pictures);
      }
    } catch (err) {
      console.error('Failed to load pictures', err);
    }
  };

  // =========================
  // Upload handlers
  // =========================
  const handleUploadClick = () => setShowUpload(true);
  const handleFileChange = (e) => setUploadFile(e.target.files[0]);

  const handleUploadSubmit = async (e) => {
    e.preventDefault();
    if (!uploadFile) return alert('Please select a file to upload.');

    const schoolData = JSON.parse(localStorage.getItem('school'));
    if (!schoolData || !schoolData.code) return alert('School code not found. Please log in again.');

    try {
      const formData = new FormData();
      formData.append('code', schoolData.code);
      formData.append('category', uploadCategory);
      formData.append('description', uploadDescription);
      formData.append('file', uploadFile);

      const res = await fetch(`${API_BASE_URL}/api/pictures/upload`, {
        method: 'POST',
        body: formData,
      });

      const data = await res.json();
      if (data.success) {
        setShowUpload(false);
        setUploadCategory('');
        setUploadDescription('');
        setUploadFile(null);
        fetchPictures(); // refresh gallery
      } else {
        alert(data.error || 'Upload failed');
      }
    } catch (err) {
      console.error('Upload error:', err);
      alert('An error occurred during upload.');
    }
  };

  const handleCancelUpload = () => {
    setShowUpload(false);
    setUploadCategory('');
    setUploadDescription('');
    setUploadFile(null);
  };

  // =========================
  // Edit picture metadata
  // =========================
  const handleEditClick = (pic) => {
    setEditingPictureId(pic.id);
    setEditingCategory(pic.category);
    setEditingDescription(pic.description);
  };

  const handleCancelEdit = () => {
    setEditingPictureId(null);
    setEditingCategory('');
    setEditingDescription('');
  };

  const handleSaveEdit = async (id) => {
    try {
      const res = await fetch(`${API_BASE_URL}/api/pictures/${id}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ category: editingCategory, description: editingDescription }),
      });

      const data = await res.json();
      if (data.success) {
        handleCancelEdit();
        fetchPictures(); // refresh list
      } else {
        alert(data.error || 'Update failed');
      }
    } catch (err) {
      console.error('Update error:', err);
      alert('An error occurred while updating.');
    }
  };

  // =========================
  // Delete picture
  // =========================
  const handleDelete = async (id) => {
    if (!window.confirm('Are you sure you want to delete this picture?')) return;

    try {
      const res = await fetch(`${API_BASE_URL}/api/pictures/${id}`, { method: 'DELETE' });
      const data = await res.json();
      if (data.success) fetchPictures();
      else alert(data.error || 'Delete failed');
    } catch (err) {
      console.error('Delete error:', err);
      alert('An error occurred while deleting.');
    }
  };

  // =========================
  // Logout handler
  // =========================
  const handleLogout = () => {
    localStorage.removeItem('school');
    navigate('/login');
  };

  // =========================
  // UI Computed Variables
  // =========================
  const categories = ['All', ...Array.from(new Set(pictures.map(p => p.category || '').filter(c => c !== '')))];
  const filteredPictures = selectedCategory === 'All'
    ? pictures
    : pictures.filter(p => p.category === selectedCategory);

  // =========================
  // JSX Render
  // =========================
  return (
    <div className="container-fluid px-4 homepage-background">
      {/* ---------------------- Header ---------------------- */}
      <header className="home-header py-5 text-center">
        <h1 className="display-5 fw-bold">Welcome, {schoolName}</h1>
        <p className="lead text-muted">Manage your school’s data and upload pictures below.</p>
        <button className="btn btn-primary mt-3" onClick={handleUploadClick}>Upload Picture</button>
      </header>

      {/* ---------------------- Upload Form ---------------------- */}
      {showUpload && (
        <div className="my-4">
          <div className="card">
            <div className="card-header">Upload Picture</div>
            <div className="card-body">
              <form onSubmit={handleUploadSubmit}>
                <div className="mb-3">
                  <label className="form-label">Category</label>
                  <input type="text" className="form-control" value={uploadCategory} onChange={e => setUploadCategory(e.target.value)} required />
                </div>
                <div className="mb-3">
                  <label className="form-label">Description</label>
                  <textarea className="form-control" rows="2" value={uploadDescription} onChange={e => setUploadDescription(e.target.value)}></textarea>
                </div>
                <div className="mb-3">
                  <label className="form-label">Select File</label>
                  <input type="file" className="form-control" accept="image/*" onChange={handleFileChange} required />
                </div>
                <div className="d-flex justify-content-end">
                  <button type="submit" className="btn btn-primary me-2">Upload</button>
                  <button type="button" className="btn btn-secondary" onClick={handleCancelUpload}>Cancel</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      )}

      {/* ---------------------- Carousel ---------------------- */}
      {filteredPictures.length > 0 && (
        <section className="my-5">
          <h2 className="fw-semibold text-center mb-3">Uploaded Pictures</h2>
          <div className="d-flex justify-content-center align-items-center mb-4">
            <label className="me-2">Filter:</label>
            <select className="form-select w-auto" value={selectedCategory} onChange={e => setSelectedCategory(e.target.value)}>
              {categories.map(cat => (
                <option key={cat || 'none'} value={cat || ''}>
                  {typeof cat === 'string' ? cat.replace(/_/g, ' ') : ''}
                </option>
              ))}
            </select>
          </div>
          <Carousel>
            {filteredPictures.map(pic => (
              <Carousel.Item key={pic.id}>
                <img
                  className="d-block w-100"
                  src={`${API_BASE_URL}${pic.file_url}`}
                  alt={pic.description}
                  style={{ maxHeight: '500px', objectFit: 'cover', cursor: 'pointer' }}
                  onClick={() => { setModalPic(pic); setShowModal(true); }}
                />
                <Carousel.Caption>
                  <h5 className="text-capitalize">{pic.category?.replace(/_/g, ' ')}</h5>
                  <p>{pic.description}</p>
                </Carousel.Caption>
              </Carousel.Item>
            ))}
          </Carousel>
        </section>
      )}

      {/* ---------------------- Table Progress Status ---------------------- */}
      <section className="my-5">
        <h2 className="mb-4">Your School Data</h2>
        <div className="row g-4">
          {tables
            .filter(t => t && typeof t.table === 'string')
            .map(({ table, status, lastUpdated }) => (
              <div key={table} className="col-sm-6 col-md-4 col-lg-3">
                <div className="card h-100">
                  <div className="card-body d-flex flex-column">
                    <h5 className="card-title text-capitalize">{table.replace(/_/g, ' ')}</h5>
                    <p className="card-text mb-2">
                      <span className={`badge me-2 fw-bold ` +
                        (status === 'Input complete' ? 'bg-success' :
                          status === 'Required fields complete' ? 'bg-warning' :
                            status === 'In progress' ? 'bg-info' : 'bg-secondary')}>
                        {status === 'Input complete' ? 'complete' : status}
                      </span>
                      <small className="text-muted">{lastUpdated ? new Date(lastUpdated).toLocaleDateString() : '—'}</small>
                    </p>
                    <button className="btn btn-outline-primary mt-auto" onClick={() => navigate(`/${table}/edit`)}>
                      Edit
                    </button>
                  </div>
                </div>
              </div>
            ))}
        </div>
      </section>

      {/* ---------------------- Picture Modal ---------------------- */}
      <Modal show={showModal} onHide={() => setShowModal(false)} centered size="lg">
        <Modal.Header closeButton>
          <Modal.Title>{modalPic?.description}</Modal.Title>
        </Modal.Header>
        <Modal.Body className="text-center">
          {editingPictureId === modalPic?.id ? (
            <div>
              <div className="mb-3 text-start">
                <label className="form-label">Category</label>
                <input type="text" className="form-control" value={editingCategory} onChange={(e) => setEditingCategory(e.target.value)} />
              </div>
              <div className="mb-3 text-start">
                <label className="form-label">Description</label>
                <textarea className="form-control" rows="2" value={editingDescription} onChange={(e) => setEditingDescription(e.target.value)} />
              </div>
            </div>
          ) : (
            <img src={`${API_BASE_URL}${modalPic?.file_url}`} alt={modalPic?.description} className="img-fluid" />
          )}
        </Modal.Body>
        <Modal.Footer>
          {editingPictureId === modalPic?.id ? (
            <>
              <Button variant="primary" onClick={() => handleSaveEdit(modalPic.id)}>Save</Button>
              <Button variant="secondary" onClick={handleCancelEdit}>Cancel</Button>
            </>
          ) : (
            <>
              <Button variant="warning" onClick={() => handleEditClick(modalPic)}>Edit</Button>
              <Button variant="danger" onClick={() => { handleDelete(modalPic.id); setShowModal(false); }}>Delete</Button>
              <Button variant="secondary" onClick={() => setShowModal(false)}>Close</Button>
            </>
          )}
        </Modal.Footer>
      </Modal>
    </div>
  );
}
