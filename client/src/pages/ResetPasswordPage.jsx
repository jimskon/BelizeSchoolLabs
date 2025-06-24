import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';

const API_BASE_URL = import.meta.env.VITE_API_URL;

export default function ResetPasswordPage() {
    const [newPassword, setNewPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');
    const [error, setError] = useState('');
    const [success, setSuccess] = useState(false);
    const navigate = useNavigate();

    const handleSubmit = async () => {
        setError('');
        const stored = JSON.parse(localStorage.getItem('school'));
        const school_id = stored?.id;

        if (!school_id) {
            return setError("Missing school session. Please log in again.");
        }

        if (newPassword !== confirmPassword) {
            return setError("Passwords do not match.");
        }

        try {
            const res = await fetch(`${API_BASE_URL}/api/auth/reset-password`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ school_id, newPassword })
            });

            let data;
            try {
                data = await res.json();
            } catch {
                return setError("Unexpected server response. Please try again.");
            }

            if (data.success) {
                setSuccess(true);
                localStorage.removeItem('school');
                setTimeout(() => navigate('/login'), 2000); // ⏳ redirect after 2 seconds
            } else {
                setError(data.error || 'Failed to reset password');
            }
        } catch (err) {
            console.error('Reset error:', err);
            setError('Something went wrong.');
        }
    };

    return (
        <div className="container mt-5">
            <h3>Reset Your Password</h3>

            {success && (
                <div className="alert alert-success">
                    ✅ Password successfully reset! Redirecting to home...
                </div>
            )}

            {error && <div className="alert alert-danger">{error}</div>}

            <div className="mb-3">
                <label className="form-label">New Password</label>
                <input
                    type="password"
                    className="form-control"
                    value={newPassword}
                    onChange={e => setNewPassword(e.target.value)}
                />
            </div>
            <div className="mb-3">
                <label className="form-label">Confirm Password</label>
                <input
                    type="password"
                    className="form-control"
                    value={confirmPassword}
                    onChange={e => setConfirmPassword(e.target.value)}
                />
            </div>
            <button className="btn btn-primary" onClick={handleSubmit}>
                Set New Password
            </button>
        </div>
    );
}
