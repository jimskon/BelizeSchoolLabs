// This component dynamically renders and manages a form based on configuration
// It supports dropdowns, numeric ranges, textareas, text fields, and validation

import React, { useEffect, useState } from 'react';
import AutoResizingTextarea from './AutoResizingTextarea';

const API_BASE_URL = import.meta.env.VITE_API_URL;

export default function GenericForm({ tableName, initialData = {}, onSubmit, onCancel }) {
  // Config state contains metadata about the fields to render
  const [config, setConfig] = useState([]);
  const [formData, setFormData] = useState(initialData);
  const [errors, setErrors] = useState([]);
  const [title, setTitle] = useState('');
  const [subtitle, setSubtitle] = useState('');
  const [instructions, setInstructions] = useState('');
  const [footer, setFooter] = useState('');
  const [showOthers, setShowOthers] = useState({}); // Tracks "Other" dropdowns
  const [backendError, setBackendError] = useState('');
  const [dismissed, setDismissed] = useState(false);
  const [hasInternet, setHasInternet] = useState(null); // Used to conditionally render internet fields

  // Initialize formData and showOthers based on initialData and config
  useEffect(() => {
    setFormData(initialData);
    setHasInternet(
      initialData.has_internet === 1 ||
      initialData.has_internet === '1' ||
      initialData.has_internet === 'Yes'
    );

    const initialShowOthers = {};
    config.forEach(field => {
      if (field.type === 'dropdown') {
        const options = field.valuelist ? field.valuelist.split(',').map(opt => opt.trim()) : [];
        const staticOptions = options.filter(opt => opt !== 'Other');
        const val = initialData[field.field_name];
        // If a value is not in the dropdown options, treat it as "Other"
        if (!(staticOptions.length === 2 && staticOptions[0] === 'Yes' && staticOptions[1] === 'No')) {
          if (val !== undefined && val !== null && val !== '' && staticOptions.indexOf(val) === -1) {
            initialShowOthers[field.field_name] = true;
          }
        }
      }
    });
    setShowOthers(initialShowOthers);
  }, [initialData, config]);

  // Load the form config and metadata (title, subtitle, etc.) from the server
  useEffect(() => {
    fetch(`${API_BASE_URL}/api/form-config/${tableName}`)
      .then(res => res.json())
      .then(data => {
        if (data.success) {
          setConfig(data.fields);
          setTitle(data.title || '');
          setSubtitle(data.subtitle || '');
          setInstructions(data.instructions || '');
          setFooter(data.footer || '');
        }
      })
      .catch(err => console.error('Failed to load form config', err));
  }, [tableName]);

  // Reset dismissal state if backend error changes
  useEffect(() => {
    if (backendError) setDismissed(false);
  }, [backendError]);

  // Handles field changes and triggers special behavior for has_internet toggle
  const handleChange = (key, value) => {
    setFormData(prev => {
      const newData = { ...prev, [key]: value };

      // Special case: if has_internet is toggled off, reset internet-related fields
      if (key === 'has_internet') {
        const isYes = value === 1 || value === '1' || value === 'Yes';
        setHasInternet(isYes);

        if (!isYes) {
          const internetReset = {
            internet_classrooms: 0,
            internet_provider: null,
            internet_speed: null,
            internet_method: null,
            internet_stability: null,
          };
          Object.entries(internetReset).forEach(([k, v]) => {
            newData[k] = v;
          });
        }
      }

      // Save to localStorage as a draft
      try {
        localStorage.setItem(`draft_${tableName}`, JSON.stringify(newData));
      } catch (e) {
        console.warn('Failed to save draft to localStorage', e);
      }

      return newData;
    });
  };

  // Validates required fields based on config
  const handleValidation = () => {
    const missing = config
      .filter(f => f.required && (formData[f.field_name] === null || formData[f.field_name] === undefined || formData[f.field_name] === ''))
      .map(f => f.prompt);
    setErrors(missing);
    return missing.length === 0;
  };

  // Handles the Save button click
  const handleSubmit = async () => {
    const valid = handleValidation();
    if (!valid) {
      const proceed = window.confirm(
        'Some required fields are not answered. Do you want to save anyway? You can complete the form later.'
      );
      if (!proceed) return;
    }
    try {
      await onSubmit(formData);
      setBackendError('');
    } catch (err) {
      const msg = err?.response?.data?.sqlMessage || err?.message || 'An error occurred';
      setBackendError(msg);
    }
  };

  // Renders a single form field based on its type
  const renderField = field => {
    const { field_name, prompt, type, valuelist, field_width = 6 } = field;
    const isInvalid = errors.includes(prompt);
    const options = valuelist ? valuelist.split(',').map(opt => opt.trim()) : [];
    const staticOptions = options.filter(opt => opt !== 'Other');
    const rawValue = formData[field_name] ?? '';
    const internetFields = ['internet_classrooms','internet_provider','internet_speed','internet_method','internet_stability'];
    if (internetFields.includes(field_name) && hasInternet === false) return null;

    // Handle numeric field with range
    if (type.startsWith('num')) {
      const rangeMatch = type.match(/num\((\d+)-(\d+)\)/);
      let min = rangeMatch ? Number(rangeMatch[1]) : 0;
      let max = rangeMatch ? Number(rangeMatch[2]) : undefined;
      return (
        <div className={`col-md-${field_width}`} key={field_name}>
          <label className="form-label">{prompt}</label>
          <input
            type="number"
            className={`form-control${isInvalid ? ' is-invalid' : ''}`}
            value={rawValue}
            min={min}
            max={max}
            onChange={e => {
              const value = e.target.value;
              if (value === '') return handleChange(field_name, '');
              if (!/^[0-9]+$/.test(value)) return alert('Please enter a valid non-negative number.');
              const number = Number(value);
              if (!isNaN(min) && number < min) return alert(`${prompt} must be at least ${min}`);
              if (!isNaN(max) && number > max) return alert(`${prompt} must be at most ${max}`);
              handleChange(field_name, number);
            }}
          />
        </div>
      );
    }

    // Boolean-style dropdown (Yes/No)
    if (type === 'dropdown' && staticOptions.length === 2 && staticOptions[0] === 'Yes') {
      const selectValue = rawValue === 1 || rawValue === '1' ? 'Yes' : rawValue === 0 ? 'No' : '';
      return (
        <div className={`col-md-${field_width}`} key={field_name}>
          <label className="form-label">{prompt}</label>
          <select
            className={`form-select${isInvalid ? ' is-invalid' : ''}`}
            value={selectValue}
            onChange={e => handleChange(field_name, e.target.value === 'Yes' ? 1 : 0)}
          >
            <option value="">-- Select --</option>
            {staticOptions.map(opt => <option key={opt}>{opt}</option>)}
          </select>
        </div>
      );
    }

    // Regular dropdown with optional "Other" logic
    if (type === 'dropdown') {
      const isOther = showOthers[field_name];
      const numericOptions = staticOptions.every(opt => !isNaN(Number(opt)));
      return (
        <div className={`col-md-${field_width}`} key={field_name}>
          <label className="form-label">{prompt}</label>
          <select
            className={`form-select${isInvalid ? ' is-invalid' : ''}`}
            value={isOther ? '__other__' : rawValue}
            onChange={e => {
              const val = e.target.value;
              if (val === '__other__') setShowOthers(prev => ({ ...prev, [field_name]: true }));
              else setShowOthers(prev => ({ ...prev, [field_name]: false }));
              handleChange(field_name, val);
            }}
          >
            <option value="">-- Select --</option>
            {staticOptions.map(opt => <option key={opt}>{opt}</option>)}
            {options.includes('Other') && <option value="__other__">Other</option>}
          </select>
          {isOther && (
            numericOptions ? (
              <input
                type="number"
                className="form-control mt-2"
                value={formData[field_name] || ''}
                onChange={e => handleChange(field_name, Number(e.target.value))}
              />
            ) : (
              <input
                className="form-control mt-2"
                value={formData[field_name] || ''}
                onChange={e => handleChange(field_name, e.target.value)}
              />
            )
          )}
        </div>
      );
    }

    // Textarea
    if (type === 'textarea') {
      return (
        <div className={`col-md-${field_width}`} key={field_name}>
          <label className="form-label">{prompt}</label>
          <AutoResizingTextarea
            className={isInvalid ? 'is-invalid' : ''}
            value={rawValue}
            onChange={e => handleChange(field_name, e.target.value)}
          />
        </div>
      );
    }

    // Text field (with validation to disallow purely numeric strings)
    if (type === 'text') {
      return (
        <div className={`col-md-${field_width}`} key={field_name}>
          <label className="form-label">{prompt}</label>
          <AutoResizingTextarea
            className={isInvalid ? 'is-invalid' : ''}
            value={rawValue}
            onChange={e => {
              const val = e.target.value;
              if (/^\d+$/.test(val)) return alert('You can only input text, not just numbers.');
              handleChange(field_name, val);
            }}
          />
        </div>
      );
    }

    // Default fallback for email or phone fields
    const inputType = type === 'email' ? 'email' : type === 'phone' ? 'tel' : 'text';
    return (
      <div className={`col-md-${field_width}`} key={field_name}>
        <label className="form-label">{prompt}</label>
        <input
          type={inputType}
          className={`form-control${isInvalid ? ' is-invalid' : ''}`}
          value={rawValue}
          onChange={e => handleChange(field_name, e.target.value)}
        />
      </div>
    );
  };

  // Main form layout
  return (
    <div className="container my-4">
      {title && <h1 className="text-center display-4 mb-2">{title}</h1>}
      {subtitle && <h3 className="text-center text-secondary mb-3">{subtitle}</h3>}
      {instructions && <p className="text-center mb-4">{instructions}</p>}

      {errors.length > 0 && (
        <div className="alert alert-danger">
          Please fill out: {errors.join(', ')}
        </div>
      )}

      {backendError && !dismissed && (
        <div className="alert alert-danger alert-dismissible fade show" role="alert">
          {backendError}
          <button
            type="button"
            className="btn-close"
            onClick={() => setDismissed(true)}
            aria-label="Close"
          ></button>
        </div>
      )}

      <div className="row g-3">
        {config.filter(f => f.visible).map(renderField)}
      </div>

      {footer && <p className="text-center mt-4">{footer}</p>}

      <div className="mt-4 text-end">
        <button className="btn btn-secondary me-2" onClick={() => onCancel(formData)}>Cancel</button>
        <button className="btn btn-success" onClick={handleSubmit}>Save</button>
      </div>
    </div>
  );
}
