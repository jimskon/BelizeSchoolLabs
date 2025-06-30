import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Modal, Button, Carousel } from 'react-bootstrap';

const API_BASE_URL = import.meta.env.VITE_API_URL;

export default function HomePage() {
  const [schoolName, setSchoolName] = useState('');
  const [tables, setTables] = useState([]);
  const [pictures, setPictures] = useState([]);
  const [editingPictureId, setEditingPictureId] = useState(null);
  const [showUpload, setShowUpload] = useState(false);
  const [uploadCategory, setUploadCategory] = useState('');
  const [uploadDescription, setUploadDescription] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('All');
  const [showModal, setShowModal] = useState(false);
  const [modalPic, setModalPic] = useState(null);
  const [uploadFile, setUploadFile] = useState(null);
  const [editingCategory, setEditingCategory] = useState('');
  const [editingDescription, setEditingDescription] = useState('');
  const navigate = useNavigate();

  useEffect(() => {
    const schoolData = JSON.parse(localStorage.getItem('school'));
    if (schoolData && schoolData.id) {
      setSchoolName(schoolData.name);
      fetchTableStatus(schoolData.id);
      fetchPictures();
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

  const fetchPictures = async () => {
    try {
      const res = await fetch(`${API_BASE_URL}/api/pictures/list`);
      const data = await res.json();
      if (data.success) setPictures(data.pictures);
    } catch (err) {
      console.error('Failed to load pictures', err);
    }
  };

  const handleUploadClick = () => {
    setShowUpload(true);
  };

  const handleFileChange = (e) => {
    setUploadFile(e.target.files[0]);
  };

  const handleUploadSubmit = async (e) => {
    e.preventDefault();
    if (!uploadFile) {
      alert('Please select a file to upload.');
      return;
    }
    try {
      const formData = new FormData();
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
        fetchPictures();
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
        fetchPictures();
      } else {
        alert(data.error || 'Update failed');
      }
    } catch (err) {
      console.error('Update error:', err);
      alert('An error occurred while updating.');
    }
  };

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

  const handleLogout = () => {
    localStorage.removeItem('school');
    navigate('/login');
  };

  const categories = ['All', ...Array.from(new Set(pictures.map(p => p.category)))];
  const filteredPictures = selectedCategory === 'All' ? pictures : pictures.filter(p => p.category === selectedCategory);

  return (
    <div className="container-fluid px-4">
      <header className="bg-light py-5 text-center">
        <h1 className="display-5 fw-bold">Welcome, {schoolName}</h1>
        <p className="lead text-muted">Manage your school’s data and upload pictures below.</p>
        <button className="btn btn-primary mt-3" onClick={handleUploadClick}>Upload Picture</button>
      </header>

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

      {filteredPictures.length > 0 && (
        <section className="my-5">
          <h2 className="fw-semibold text-center mb-3">Uploaded Pictures</h2>
          <div className="d-flex justify-content-center align-items-center mb-4">
            <label className="me-2">Filter:</label>
            <select className="form-select w-auto" value={selectedCategory} onChange={e => setSelectedCategory(e.target.value)}>
              {categories.map(cat => <option key={cat} value={cat}>{cat.replace(/_/g, ' ')}</option>)}
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
                  <h5 className="text-capitalize">{pic.category.replace(/_/g, ' ')}</h5>
                  <p>{pic.description}</p>
                </Carousel.Caption>
              </Carousel.Item>
            ))}
          </Carousel>
        </section>
      )}

      <section className="my-5">
        <h2 className="mb-4">Your School Data</h2>
        <div className="row g-4">
          {tables.map(({ table, status, lastUpdated }) => (
            <div key={table} className="col-sm-6 col-md-4 col-lg-3">
              <div className="card h-100">
                <div className="card-body d-flex flex-column">
                  <h5 className="card-title text-capitalize">{table.replace(/_/g, ' ')}</h5>
                  <p className="card-text mb-2">
                    <span className={`badge me-2 ` +
                      (status === 'Input complete' ? 'bg-success' :
                      status === 'Required fields complete' ? 'bg-warning text-dark' :
                      status === 'In progress' ? 'bg-info text-dark' :
                      status === 'Not started' ? 'bg-secondary' : 'bg-secondary')}>{status}</span>
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

      <Modal show={showModal} onHide={() => setShowModal(false)} centered size="lg">
        <Modal.Header closeButton>
          <Modal.Title>{modalPic && modalPic.description}</Modal.Title>
        </Modal.Header>
        <Modal.Body className="text-center">
          <img
            src={modalPic && `${API_BASE_URL}${modalPic.file_url}`}
            alt={modalPic && modalPic.description}
            className="img-fluid"
          />
        </Modal.Body>
        <Modal.Footer>
          <Button variant="secondary" onClick={() => setShowModal(false)}>
            Close
          </Button>
        </Modal.Footer>
      </Modal>
    </div>
  );
}
