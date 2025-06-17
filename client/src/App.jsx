import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import ValidateSchoolPage from './pages/ValidateSchoolPage';
import BootstrapLayout from './components/BootstrapLayout';

function App() {
  return (
    <Router>
      <BootstrapLayout>
        <Routes>
          <Route path="/" element={<ValidateSchoolPage />} />
          {/* Add other routes here */}
        </Routes>
      </BootstrapLayout>
    </Router>
  );
}

export default App;
