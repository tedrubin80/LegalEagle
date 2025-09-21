import React, { useState } from 'react';
import { useAuth } from '../../contexts/AuthContext';
import { EyeIcon, EyeSlashIcon } from '../Icons';
import VirtualTour from '../Demo/VirtualTour';

const Login = () => {
  const [formData, setFormData] = useState({
    email: '',
    password: ''
  });
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [showDemoCredentials, setShowDemoCredentials] = useState(false);
  const [showVirtualTour, setShowVirtualTour] = useState(false);

  // Check if we're in demo mode
  const isDemoMode = process.env.REACT_APP_DEMO_MODE === 'true' ||
                     process.env.REACT_APP_PACKAGE_TYPE === 'demo' ||
                     window.location.hostname.includes('demo');

  const { login, user } = useAuth();
  
  // Debug: Check if user is already authenticated
  React.useEffect(() => {
    console.log('🏠 Login page loaded');
    console.log('👤 Current user state:', user);
    console.log('🎫 Token in localStorage:', localStorage.getItem('token'));
  }, [user]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError('');

    console.log('🔐 Login form submitted with:', { email: formData.email, password: '***' });
    
    const result = await login(formData.email, formData.password, 'admin');
    
    console.log('📋 Login result:', result);
    
    if (!result.success) {
      setError(result.error);
      console.error('❌ Login failed:', result.error);
    } else {
      console.log('✅ Login successful, should redirect now');
    }
    
    setLoading(false);
  };

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  // Function to fill demo credentials
  const fillDemoCredentials = (email, password) => {
    setFormData({
      email: email,
      password: password
    });
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-md w-full space-y-8">
        <div>
          <div className="mx-auto h-12 w-12 bg-blue-600 rounded-lg flex items-center justify-center">
            <span className="text-white font-bold text-lg">LE</span>
          </div>
          <h2 className="mt-6 text-center text-3xl font-extrabold text-gray-900">
            {isDemoMode ? 'Legal Estate Demo' : 'Sign in to Legal Estate'}
          </h2>
          <p className="mt-2 text-center text-sm text-gray-600">
            {isDemoMode ? 'Try our Legal Practice Management System' : 'Comprehensive Legal Practice Management'}
          </p>

          {/* Demo Banner */}
          {isDemoMode && (
            <div className="mt-4 p-3 bg-blue-50 border border-blue-200 rounded-md">
              <div className="flex items-center">
                <div className="flex-shrink-0">
                  <svg className="h-5 w-5 text-blue-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                    <path fillRule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clipRule="evenodd" />
                  </svg>
                </div>
                <div className="ml-3">
                  <p className="text-sm text-blue-700">
                    <strong>Live Demo:</strong> Data resets daily at 3 AM UTC
                  </p>
                </div>
              </div>
            </div>
          )}
        </div>

        <form className="mt-8 space-y-6" onSubmit={handleSubmit}>
          <div className="rounded-md shadow-sm -space-y-px">
            <div>
              <label htmlFor="email" className="sr-only">
                Email address
              </label>
              <input
                id="email"
                name="email"
                type="email"
                autoComplete="email"
                required
                className="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-t-md focus:outline-none focus:ring-blue-500 focus:border-blue-500 focus:z-10 sm:text-sm"
                placeholder="Email address"
                value={formData.email}
                onChange={handleChange}
              />
            </div>
            <div className="relative">
              <label htmlFor="password" className="sr-only">
                Password
              </label>
              <input
                id="password"
                name="password"
                type={showPassword ? 'text' : 'password'}
                autoComplete="current-password"
                required
                className="appearance-none rounded-none relative block w-full px-3 py-2 pr-10 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-b-md focus:outline-none focus:ring-blue-500 focus:border-blue-500 focus:z-10 sm:text-sm"
                placeholder="Password"
                value={formData.password}
                onChange={handleChange}
              />
              <button
                type="button"
                className="absolute inset-y-0 right-0 pr-3 flex items-center"
                onClick={() => setShowPassword(!showPassword)}
              >
                {showPassword ? (
                  <EyeSlashIcon className="h-5 w-5 text-gray-400" />
                ) : (
                  <EyeIcon className="h-5 w-5 text-gray-400" />
                )}
              </button>
            </div>
          </div>

          {error && (
            <div className="rounded-md bg-red-50 p-4">
              <div className="text-sm text-red-800">{error}</div>
            </div>
          )}

          <div>
            <button
              type="submit"
              disabled={loading}
              className="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 disabled:opacity-50 disabled:cursor-not-allowed"
            >
              {loading ? (
                <>
                  <svg className="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                    <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                    <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                  </svg>
                  Signing in...
                </>
              ) : (
                'Sign in'
              )}
            </button>
          </div>

          <div className="text-center">
            <p className="text-sm text-gray-600">
              {isDemoMode ? 'Use the demo credentials below to explore the system' : "Don't have an account? Contact your administrator."}
            </p>
          </div>
        </form>

        {/* Demo Credentials Section */}
        {isDemoMode && (
          <div className="mt-6 space-y-4">
            <div className="bg-gradient-to-r from-green-50 to-blue-50 border border-green-200 rounded-lg p-4">
              <div className="flex items-center justify-between mb-3">
                <h3 className="text-sm font-semibold text-gray-800">🎭 Demo Accounts</h3>
                <button
                  type="button"
                  onClick={() => setShowDemoCredentials(!showDemoCredentials)}
                  className="text-xs text-blue-600 hover:text-blue-800 font-medium"
                >
                  {showDemoCredentials ? 'Hide' : 'Show All'}
                </button>
              </div>

              {/* Quick Access Buttons */}
              <div className="grid grid-cols-1 gap-2 mb-3">
                <button
                  type="button"
                  onClick={() => fillDemoCredentials('demo@legalestate.tech', 'demo123')}
                  className="flex items-center justify-between p-3 bg-white border border-gray-200 rounded-md hover:bg-gray-50 transition-colors"
                >
                  <div className="text-left">
                    <div className="text-sm font-medium text-gray-900">👑 Administrator</div>
                    <div className="text-xs text-gray-500">Full system access</div>
                  </div>
                  <div className="text-xs text-blue-600 font-medium">Click to Login</div>
                </button>

                <button
                  type="button"
                  onClick={() => fillDemoCredentials('user@legalestate.tech', 'user123')}
                  className="flex items-center justify-between p-3 bg-white border border-gray-200 rounded-md hover:bg-gray-50 transition-colors"
                >
                  <div className="text-left">
                    <div className="text-sm font-medium text-gray-900">⚖️ Attorney</div>
                    <div className="text-xs text-gray-500">Case and client management</div>
                  </div>
                  <div className="text-xs text-blue-600 font-medium">Click to Login</div>
                </button>

                {showDemoCredentials && (
                  <>
                    <button
                      type="button"
                      onClick={() => fillDemoCredentials('client@demo.tech', 'client123')}
                      className="flex items-center justify-between p-3 bg-white border border-gray-200 rounded-md hover:bg-gray-50 transition-colors"
                    >
                      <div className="text-left">
                        <div className="text-sm font-medium text-gray-900">👤 Client</div>
                        <div className="text-xs text-gray-500">Client portal access</div>
                      </div>
                      <div className="text-xs text-blue-600 font-medium">Click to Login</div>
                    </button>

                    <button
                      type="button"
                      onClick={() => setShowVirtualTour(true)}
                      className="flex items-center justify-center p-3 bg-gradient-to-r from-blue-500 to-purple-600 text-white rounded-md hover:from-blue-600 hover:to-purple-700 transition-colors"
                    >
                      <div className="text-center">
                        <div className="text-sm font-medium">🎭 Take Virtual Tour</div>
                        <div className="text-xs opacity-90">Explore AI-powered features</div>
                      </div>
                    </button>
                  </>
                )}
              </div>

              {/* Detailed Credentials */}
              {showDemoCredentials && (
                <div className="border-t border-gray-200 pt-3">
                  <h4 className="text-xs font-medium text-gray-700 mb-2">Manual Login Credentials:</h4>
                  <div className="text-xs text-gray-600 space-y-1 font-mono bg-gray-50 p-2 rounded">
                    <div>👑 <span className="font-semibold">Admin:</span> demo@legalestate.tech / demo123</div>
                    <div>⚖️ <span className="font-semibold">Attorney:</span> user@legalestate.tech / user123</div>
                    <div>👤 <span className="font-semibold">Client:</span> client@demo.tech / client123</div>
                  </div>
                </div>
              )}
            </div>

            {/* Demo Features Info */}
            <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
              <h4 className="text-sm font-medium text-blue-900 mb-2">🚀 What you can explore:</h4>
              <div className="text-xs text-blue-800 space-y-1">
                <div>• Sample cases with clients and documents</div>
                <div>• AI-powered document generation</div>
                <div>• Task management and team collaboration</div>
                <div>• Time tracking and billing features</div>
                <div>• Advanced analytics dashboard</div>
              </div>
              <div className="mt-3 pt-3 border-t border-blue-200">
                <p className="text-xs text-blue-700">
                  💡 <strong>Need help?</strong> Contact{' '}
                  <a href="mailto:support@legalestate.tech" className="underline hover:text-blue-900">
                    support@legalestate.tech
                  </a>{' '}
                  for a personalized demo!
                </p>
              </div>
            </div>
          </div>
        )}

        {/* Virtual Tour */}
        <VirtualTour
          isActive={showVirtualTour}
          onClose={() => setShowVirtualTour(false)}
          onComplete={() => setShowVirtualTour(false)}
        />
      </div>
    </div>
  );
};

export default Login;