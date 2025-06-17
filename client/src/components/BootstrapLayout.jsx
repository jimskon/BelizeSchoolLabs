// client/src/components/BootstrapLayout.jsx
import React from 'react';
import NavBar from './NavBar';

export default function BootstrapLayout({ children }) {
  return (
    <div style={{ minHeight: '100vh', display: 'flex', flexDirection: 'column' }}>
      <NavBar />
      <main className="flex-grow-1 p-4">
        {children}
      </main>
    </div>
  );
}
