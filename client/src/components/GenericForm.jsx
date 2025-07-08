import React, { useEffect, useState } from 'react';

const API_BASE_URL = import.meta.env.VITE_API_URL;

export default function GenericForm({
  tableName,
  initialData = {},
  onSubmit,
  onCancel
}) {
  const [config, setConfig] = useState([]);
  const [formData, setFormData] = useState(initialData);
  const [errors, setErrors] = useState([]);
  const [title, setTitle] = useState('');
  const [subtitle, setSubtitle] = useState('');
  const [instructions, setInstructions] = useState('');
  const [footer, setFooter] = useState('');
  // track which dropdowns are in "Other" mode
  const [showOthers, setShowOthers] = useState({});

  // Sync formData when initialData changes
  useEffect(() => {
    setFormData(initialData);
    // reset other-fields flags
    setShowOthers({});
  }, [initialData]);

  // Load form configuration and page metadata
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

  const handleChange = (key, value) => {
    setFormData(prev => {
      const newData = { ...prev, [key]: value };
      try {
        localStorage.setItem(
          `draft_${tableName}`,
          JSON.stringify(newData)
        );
      } catch (e) {
        console.warn('Failed to save draft to localStorage', e);
      }
      return newData;
    });
  };

  const handleValidation = () => {
    const missing = config
      .filter(
        f =>
          f.required &&
          (formData[f.field_name] === null ||
            formData[f.field_name] === undefined ||
            formData[f.field_name] === '')
      )
      .map(f => f.prompt);
    setErrors(missing);
    return missing.length === 0;
  };

  const handleSubmit = () => {
    if (handleValidation()) {
      onSubmit(formData);
    }
  };

  const renderField = field => {
    const {
      field_name,
      prompt,
      type,
      valuelist,
      field_width = 6
    } = field;
    const options = valuelist
      ? valuelist.split(',').map(opt => opt.trim())
      : [];
      const staticOptions = options.filter(opt => opt !== 'Other');
    const rawValue = formData[field_name] ?? '';

    // Numeric field, e.g. "num(1,100)"
    if (type.startsWith('num(')) {
      const [min, max] = (type.match(/\d+/g) || []).map(Number);
      return (
        <div className={`col-md-${field_width}`} key={field_name}>
          <label className="form-label">{prompt}</label>
          <input
            type="number"
            min={min}
            max={max}
            className="form-control"
            value={rawValue}
            onChange={e => {
              const v = e.target.value;
              handleChange(
                field_name,
                v === '' ? '' : Number(v)
              );
            }}
          />
        </div>
      );
    }

    // Dropdown with optional "Other"
    if (type === 'dropdown') {
      const isOther = showOthers[field_name] === true;
      return (
        <div className={`col-md-${field_width}`} key={field_name}>
          <label className="form-label">{prompt}</label>
          <select
            className="form-select"
            value={isOther ? '__other__' : rawValue}
            onChange={e => {
              const val = e.target.value;
              if (val === '__other__') {
                // switch into "Other" mode
                setShowOthers(prev => ({
                  ...prev,
                  [field_name]: true
                }));
                handleChange(field_name, '');
              } else {
                // normal selection, clear Other mode
                setShowOthers(prev => ({
                  ...prev,
                  [field_name]: false
                }));
                handleChange(field_name, val);
              }
            }}
          >
            <option value="">-- Select --</option>
            {staticOptions.map(opt => (
              <option key={opt} value={opt}>
                {opt}
              </option>
            ))}
            {options.includes('Other') && (
              <option value="__other__">Other</option>
            )}
          </select>

          {isOther && (
            <input
              className="form-control mt-2"
              placeholder="Specify..."
              value={formData[field_name] || ''}
              onChange={e =>
                handleChange(field_name, e.target.value)
              }
            />
          )}
        </div>
      );
    }

    // Default text/email/phone
    const inputType =
      type === 'email'
        ? 'email'
        : type === 'phone'
        ? 'tel'
        : 'text';
    return (
      <div className={`col-md-${field_width}`} key={field_name}>
        <label className="form-label">{prompt}</label>
        <input
          type={inputType}
          className="form-control"
          value={rawValue}
          onChange={e =>
            handleChange(field_name, e.target.value)
          }
        />
      </div>
    );
  };

  return (
    <div className="container my-4">
      {title && (
        <h1 className="text-center display-4 mb-2">{title}</h1>
      )}
      {subtitle && (
        <h3 className="text-center text-secondary mb-3">
          {subtitle}
        </h3>
      )}
      {instructions && (
        <p className="text-center mb-4">{instructions}</p>
      )}

      {errors.length > 0 && (
        <div className="alert alert-danger">
          Please fill out: {errors.join(', ')}
        </div>
      )}

      <div className="row g-3">
        {config.filter(f => f.visible).map(renderField)}
      </div>

      {footer && (
        <p className="text-center mt-4">{footer}</p>
      )}

      <div className="mt-4 text-end">
        <button
          className="btn btn-secondary me-2"
          onClick={() => onCancel(formData)}
        >
          Cancel
        </button>
        <button
          className="btn btn-success"
          onClick={handleSubmit}
        >
          Save
        </button>
      </div>
    </div>
  );
}