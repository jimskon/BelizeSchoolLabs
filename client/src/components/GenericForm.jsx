import React, { useEffect, useState } from 'react';
import AutoResizingTextarea from './AutoResizingTextarea';

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
  const [showOthers, setShowOthers] = useState({});
  const [backendError, setBackendError] = useState('');
  const [dismissed, setDismissed] = useState(false);
  const [hasInternet, setHasInternet] = useState(null);

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
        const options = field.valuelist
          ? field.valuelist.split(',').map(opt => opt.trim())
          : [];
        const staticOptions = options.filter(opt => opt !== 'Other');
        const val = initialData[field.field_name];
        if (!(staticOptions.length === 2 && staticOptions[0] === 'Yes' && staticOptions[1] === 'No')) {
          if (val !== undefined && val !== null && val !== '' && staticOptions.indexOf(val) === -1) {
            initialShowOthers[field.field_name] = true;
          }
        }
      }
    });
    setShowOthers(initialShowOthers);
  }, [initialData, config]);

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

  useEffect(() => {
    if (backendError) setDismissed(false);
  }, [backendError]);

  const handleChange = (key, value) => {
    setFormData(prev => {
      const newData = { ...prev, [key]: value };

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

      try {
        localStorage.setItem(`draft_${tableName}`, JSON.stringify(newData));
      } catch (e) {
        console.warn('Failed to save draft to localStorage', e);
      }

      return newData;
    });
  };

  const handleValidation = () => {
    const missing = config
      .filter(f => f.required && (formData[f.field_name] === null || formData[f.field_name] === undefined || formData[f.field_name] === ''))
      .map(f => f.prompt);
    setErrors(missing);
    return missing.length === 0;
  };

  const handleSubmit = async () => {
    if (handleValidation()) {
      try {
        await onSubmit(formData);
        setBackendError('');
      } catch (err) {
        const msg = err?.response?.data?.sqlMessage || err?.message || 'An error occurred';
        setBackendError(msg);
      }
    }
  };

  const renderField = field => {
    const { field_name, prompt, type, valuelist, field_width = 6 } = field;
    const isInvalid = errors.includes(prompt);
    const options = valuelist ? valuelist.split(',').map(opt => opt.trim()) : [];
    const staticOptions = options.filter(opt => opt !== 'Other');
    const rawValue = formData[field_name] ?? '';
    const internetFields = [
      'internet_classrooms',
      'internet_provider',
      'internet_speed',
      'internet_method',
      'internet_stability'
    ];
    if (internetFields.includes(field_name) && hasInternet === false) return null;

    if (type.startsWith('num')) {
      // parse range from type like 'num(0-120)'
      const rangeMatch = type.match(/num\((\d+)-(\d+)\)/);
      let min = undefined, max = undefined;
      if (rangeMatch) {
        min = Number(rangeMatch[1]);
        max = Number(rangeMatch[2]);
      } else {
        [min, max] = valuelist?.split(',').map(Number) || [undefined, undefined];
      }
      // default min to 0 to prevent negative values
      if (min === undefined || isNaN(min)) min = 0;
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
              if (value === '') { handleChange(field_name, ''); return; }
              if (!/^[0-9]+$/.test(value)) { alert('Please enter a valid non-negative number.'); return; }
              const number = Number(value);
              if (!isNaN(min) && number < min) {
                alert(`${prompt} must be at least ${min}`);
                return;
              }
              if (!isNaN(max) && number > max) {
                alert(`${prompt} must be at most ${max}`);
                return;
              }
              handleChange(field_name, number);
            }}
          />
        </div>
      );
    }

    if (type === 'dropdown' && staticOptions.length === 2 && staticOptions[0] === 'Yes' && staticOptions[1] === 'No') {
      const selectValue = rawValue === 1 || rawValue === '1' ? 'Yes' : rawValue === 0 || rawValue === '0' ? 'No' : '';
      return (
        <div className={`col-md-${field_width}`} key={field_name}>
          <label className="form-label">{prompt}</label>
          <select
            className={`form-select${isInvalid ? ' is-invalid' : ''}`}
            value={selectValue}
            onChange={e => {
              const val = e.target.value;
              const storedVal = val === 'Yes' ? 1 : val === 'No' ? 0 : '';
              handleChange(field_name, storedVal);
            }}
          >
            <option value="">-- Select --</option>
            {staticOptions.map(opt => (<option key={opt} value={opt}>{opt}</option>))}
          </select>
        </div>
      );
    }

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
              if (val === '__other__') { setShowOthers(prev => ({ ...prev, [field_name]: true })); handleChange(field_name, ''); }
              else { setShowOthers(prev => ({ ...prev, [field_name]: false })); handleChange(field_name, val); }
            }}
          >
            <option value="">-- Select --</option>
            {staticOptions.map(opt => (<option key={opt} value={opt}>{opt}</option>))}
            {options.includes('Other') && <option value="__other__">Other</option>}
          </select>
          {isOther && numericOptions ? (
            <input
              type="number"
              min="0"
              className={`form-control mt-2${isInvalid ? ' is-invalid' : ''}`}
              placeholder="Enter a positive number..."
              value={formData[field_name] || ''}
              onChange={e => {
                const val = e.target.value;
                if (val === '') return handleChange(field_name, '');
                if (!/^[0-9]+$/.test(val)) { alert('Please enter a valid non-negative number.'); return; }
                handleChange(field_name, Number(val));
              }}
            />
          ) : isOther ? (
            <input
              className={`form-control mt-2${isInvalid ? ' is-invalid' : ''}`}
              placeholder="Specify..."
              value={formData[field_name] || ''}
              onChange={e => handleChange(field_name, e.target.value)}
            />
          ) : null}

        </div>
      );
    }

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

    if (type === 'text') {
      return (
        <div className={`col-md-${field_width}`} key={field_name}>
          <label className="form-label">{prompt}</label>
          <AutoResizingTextarea
            className={isInvalid ? 'is-invalid' : ''}
            value={rawValue}
            onChange={e => {
              const val = e.target.value;
              if (/^\d+$/.test(val)) { alert('You can only input text, not just numbers.'); return; }
              handleChange(field_name, val);
            }}
            rows={1}
          />
        </div>
      );
    }

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
