// client/src/components/BootstrapLayout.jsx
import React from 'react';
import NavBar from './NavBar';
import { Container } from 'react-bootstrap';

export default function BootstrapLayout({ children }) {
  return (
    <>
      <NavBar />
      <Container className="mt-4">
        {children}
      </Container>
    </>
  );
}

