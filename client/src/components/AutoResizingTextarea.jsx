import React, { useRef, useEffect } from 'react';

export default function AutoResizingTextarea({
  value,
  onChange,
  className = '',
  placeholder = '',
  rows = 1,
  ...props
}) {
  const textareaRef = useRef(null);

  const adjustHeight = () => {
    const el = textareaRef.current;
    if (el) {
      el.style.height = 'auto';
      el.style.height = `${el.scrollHeight}px`;
    }
  };

  useEffect(() => {
    adjustHeight();
  }, [value]);

  useEffect(() => {
    adjustHeight();
  }, []);

  return (
    <textarea
      ref={textareaRef}
      value={value}
      onChange={onChange}
      placeholder={placeholder}
      rows={rows}
      className={`form-control ${className}`}
      style={{ overflow: 'hidden', resize: 'vertical' }}
      {...props}
    />
  );
}
