// Demo Configuration
export const DEMO_CONFIG = {
  // Demo mode flag
  isDemoMode: process.env.REACT_APP_DEMO_MODE === 'true',

  // Auto-login credentials for demo
  demoCredentials: {
    email: 'demo@legalestate.tech',
    password: 'demo123',
    userType: 'admin'
  },

  // Features to disable in demo mode
  disabledFeatures: [
    'user-registration',
    'billing-management',
    'real-payments',
    'external-integrations'
  ],

  // Mock data settings
  mockData: {
    clients: 25,
    cases: 18,
    documents: 150,
    settlements: 8
  },

  // Nightly reset configuration
  resetSchedule: {
    time: '02:00',
    timezone: 'UTC',
    enabled: true
  },

  // Tour settings
  tour: {
    autoStart: true,
    delay: 2000,
    showProgress: true,
    allowSkip: true
  },

  // Demo limitations
  limitations: {
    maxClients: 50,
    maxCases: 30,
    maxDocuments: 200,
    maxUsers: 10
  }
};

// Demo utility functions
export const isDemoMode = () => DEMO_CONFIG.isDemoMode;

export const shouldShowFeature = (feature) => {
  if (!isDemoMode()) return true;
  return !DEMO_CONFIG.disabledFeatures.includes(feature);
};

export const getDemoCredentials = () => DEMO_CONFIG.demoCredentials;

export const isAtLimit = (type, current) => {
  if (!isDemoMode()) return false;
  const limit = DEMO_CONFIG.limitations[`max${type.charAt(0).toUpperCase() + type.slice(1)}`];
  return current >= limit;
};

export default DEMO_CONFIG;