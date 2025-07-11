// client/src/components/NavBar.jsx
import React from 'react';
import { Navbar, Nav, Container } from 'react-bootstrap';
import { Link, useNavigate, useLocation } from 'react-router-dom';

export default function NavBar() {
  const navigate = useNavigate();
  const location = useLocation();
  // hide NavBar on login and root pages
  if (location.pathname === '/' || location.pathname === '/login') return null;

  const handleLogout = () => {
    localStorage.removeItem('school');
    navigate('/login');
  };

  // Don't show NavBar links on login page
  const isLoginPage = location.pathname === '/login';

  return (
    <Navbar expand="lg" fixed="top" className="navbar-custom shadow-sm">
      <Container fluid>
        <Navbar.Brand as={Link} to="/main" className="text-white">
          Belize School Computer Management System
        </Navbar.Brand>
        <Navbar.Toggle aria-controls="navbar-nav" />
        <Navbar.Collapse id="navbar-nav">
          {!isLoginPage && (
            <Nav className="me-auto">
              <Nav.Link as={Link} to="/main" className="text-white">Home</Nav.Link>
              <Nav.Link onClick={handleLogout} className="text-white">Logout</Nav.Link>
            </Nav>
          )}
        </Navbar.Collapse>
      </Container>
    </Navbar>
  );
}
