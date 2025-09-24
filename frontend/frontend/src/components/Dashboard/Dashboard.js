import React, { useState, useEffect, useMemo } from 'react';
import { Link } from 'react-router-dom';
import { useAuth } from '../../contexts/AuthContext';
import {
  DocumentIcon,
  UserGroupIcon,
  ClipboardDocumentListIcon,
  ClockIcon,
  CurrencyDollarIcon,
  ExclamationTriangleIcon,
  CheckCircleIcon,
  ArrowTrendingUpIcon,
  ArrowTrendingDownIcon,
  CalendarDaysIcon,
  ChartBarIcon,
  BellIcon,
  EyeIcon
} from '../Icons';
import InteractiveChart from '../Charts/InteractiveChart';
import { useRealTimeData } from '../../services/realtimeService';
import { useToast } from '../Common/Toast';
import { endpoints } from '../../utils/api';
import VirtualTour from '../Demo/VirtualTour';
// import ActivityDashboard from '../Activity/ActivityDashboard';
// import ActivityTracker from '../Activity/ActivityTracker';
// import ActivityAnalytics from '../Activity/ActivityAnalytics';

const Dashboard = () => {
  const { user } = useAuth();
  const isDemoMode = localStorage.getItem('demoMode') === 'true';

  // Create demo user if in demo mode
  const effectiveUser = user || (isDemoMode ? {
    firstName: 'Demo',
    name: 'Demo User',
    role: 'DEMO_ADMIN'
  } : null);
  const [selectedView, setSelectedView] = useState('overview');
  const [quickActions, setQuickActions] = useState([]);
  const [showVirtualTour, setShowVirtualTour] = useState(false);
  const toast = useToast();

  const [state, setState] = useState({
    data: null,
    loading: true,
    error: null
  });

  // Safe data with fallbacks to prevent undefined errors
  const safeData = useMemo(() => {
    if (!state.data) {
      return {
        cases: [],
        activities: [],
        stats: {
          totalCases: 0,
          activeCases: 0,
          settledCases: 0,
          totalRevenue: 0,
        }
      };
    }

    return {
      cases: Array.isArray(state.data.cases) ? state.data.cases : [],
      activities: Array.isArray(state.data.activities) ? state.data.activities : [],
      stats: state.data.stats || {
        totalCases: 0,
        activeCases: 0,
        settledCases: 0,
        totalRevenue: 0,
      }
    };
  }, [state.data]);

  // Fetch dashboard data
  useEffect(() => {
    const fetchDashboardData = async () => {
      // In demo mode, use mock data instead of API calls
      if (isDemoMode) {
        console.log('🎭 Demo mode: Using mock dashboard data');

        const mockData = {
          cases: [
            {
              id: '1',
              title: 'Personal Injury Case - Auto Accident',
              status: 'ACTIVE',
              type: 'Personal Injury',
              value: 150000,
              updatedAt: new Date().toISOString()
            },
            {
              id: '2',
              title: 'Contract Dispute - Real Estate',
              status: 'DISCOVERY',
              type: 'Contract Law',
              value: 85000,
              updatedAt: new Date(Date.now() - 86400000).toISOString()
            }
          ],
          activities: [
            {
              id: '1',
              action: 'Document uploaded',
              description: 'Medical records uploaded for Case #1001',
              createdAt: new Date().toISOString(),
              user: { firstName: 'Demo', lastName: 'User' }
            }
          ],
          stats: {
            totalCases: 25,
            activeCases: 18,
            settledCases: 7,
            totalRevenue: 847000,
          }
        };

        setState({
          data: mockData,
          loading: false,
          error: null
        });

        // Auto-start virtual tour for first-time demo users
        const hasSeenTour = localStorage.getItem('demoTourCompleted');
        if (!hasSeenTour) {
          setTimeout(() => {
            setShowVirtualTour(true);
          }, 2000); // Start tour after 2 seconds
        }

        return;
      }

      try {
        setState(prev => ({ ...prev, loading: true, error: null }));

        const response = await fetch('/api/dashboard/stats', {
          headers: {
            'Authorization': `Bearer ${localStorage.getItem('token')}`,
            'Content-Type': 'application/json'
          }
        });

        if (!response.ok) {
          throw new Error(`HTTP ${response.status}: ${response.statusText}`);
        }

        const result = await response.json();

        // Validate and sanitize response structure
        const validatedData = {
          cases: Array.isArray(result.recentCases) ? result.recentCases : [],
          activities: Array.isArray(result.recentActivity) ? result.recentActivity : [],
          stats: {
            totalCases: Number(result.caseStats?.total) || 0,
            activeCases: Number(result.caseStats?.active) || 0,
            settledCases: Number(result.caseStats?.settled) || 0,
            totalRevenue: Number(result.settlementStats?.totalFees) || 0,
          }
        };

        setState({
          data: validatedData,
          loading: false,
          error: null
        });
      } catch (err) {
        console.error('Dashboard fetch error:', err);
        const errorMessage = err instanceof Error ? err.message : 'Failed to load dashboard';

        // Set safe fallback data even on error
        setState({
          data: {
            cases: [],
            activities: [],
            stats: {
              totalCases: 0,
              activeCases: 0,
              settledCases: 0,
              totalRevenue: 0,
            }
          },
          loading: false,
          error: errorMessage
        });
      }
    };

    fetchDashboardData();

    // Only set up interval for non-demo mode
    let interval;
    if (!isDemoMode) {
      interval = setInterval(fetchDashboardData, 30000); // Refresh every 30 seconds
    }

    return () => {
      if (interval) clearInterval(interval);
    };
  }, [isDemoMode]);

  const refreshData = () => {
    setState(prev => ({ ...prev, loading: true }));
    // Trigger refresh logic here
  };

  // Transform safe data into dashboard format
  const data = useMemo(() => {
    const fallbackData = {
      stats: {
        totalCases: 0,
        casesChange: 0,
        activeCases: 0,
        activeCasesChange: 0,
        totalClients: 0,
        clientsChange: 0,
        totalRevenue: 0,
        revenueChange: 0,
        pendingTasks: 0,
        tasksChange: 0,
        documentsUploaded: 0,
        documentsChange: 0,
        billableHours: 0,
        hoursChange: 0,
        avgCaseValue: 0,
        caseValueChange: 0
      },
      recentCases: [],
      upcomingDeadlines: [],
      chartData: {
        casesByMonth: [
          { month: 'Jan', opened: 0, closed: 0, pending: 0 },
          { month: 'Feb', opened: 0, closed: 0, pending: 0 },
          { month: 'Mar', opened: 0, closed: 0, pending: 0 },
          { month: 'Apr', opened: 0, closed: 0, pending: 0 },
          { month: 'May', opened: 0, closed: 0, pending: 0 },
          { month: 'Jun', opened: 0, closed: 0, pending: 0 }
        ],
        revenueByType: [
          { name: 'Personal Injury', value: 0, cases: 0 },
          { name: 'Auto Accident', value: 0, cases: 0 }
        ]
      }
    };

    if (!safeData) return fallbackData;

    return {
      stats: {
        totalCases: safeData.stats.totalCases,
        casesChange: 0, // Calculate from historical data later
        activeCases: safeData.stats.activeCases,
        activeCasesChange: 0,
        totalClients: 0, // Add to API response
        clientsChange: 0,
        totalRevenue: safeData.stats.totalRevenue,
        revenueChange: 0,
        pendingTasks: 0, // Add to API response
        tasksChange: 0,
        documentsUploaded: 0, // Add to API response
        documentsChange: 0,
        billableHours: 0, // Add to API response
        hoursChange: 0,
        avgCaseValue: safeData.stats.totalCases > 0 ? safeData.stats.totalRevenue / safeData.stats.totalCases : 0,
        caseValueChange: 0
      },
      recentCases: safeData.cases.slice(0, 5).map(caseItem => ({
        id: caseItem?.id || Math.random(),
        title: caseItem?.title || `Case #${caseItem?.caseNumber || 'Unknown'}`,
        status: caseItem?.status || 'ACTIVE',
        type: caseItem?.type || 'General',
        value: caseItem?.value || caseItem?.settlementAmount || 0,
        lastActivity: caseItem?.updatedAt || new Date().toISOString().split('T')[0]
      })),
      upcomingDeadlines: [], // Add to API response
      chartData: fallbackData.chartData // Use fallback for now
    };
  }, [safeData]);

  // Format currency
  const formatCurrency = (value) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
      minimumFractionDigits: 0,
      maximumFractionDigits: 0
    }).format(value);
  };

  // Get status color
  const getStatusColor = (status) => {
    const colors = {
      'ACTIVE': 'bg-green-100 text-green-800',
      'PENDING': 'bg-yellow-100 text-yellow-800',
      'DISCOVERY': 'bg-blue-100 text-blue-800',
      'SETTLEMENT': 'bg-purple-100 text-purple-800',
      'CLOSED': 'bg-gray-100 text-gray-800'
    };
    return colors[status] || colors['PENDING'];
  };

  // Get priority color
  const getPriorityColor = (priority) => {
    const colors = {
      'high': 'bg-red-100 text-red-800',
      'medium': 'bg-yellow-100 text-yellow-800',
      'low': 'bg-green-100 text-green-800'
    };
    return colors[priority] || colors['medium'];
  };

  // Stats cards configuration
  const statsCards = [
    {
      title: 'Total Cases',
      value: data.stats.totalCases,
      change: data.stats.casesChange,
      icon: DocumentIcon,
      color: 'text-blue-600',
      bgColor: 'bg-blue-50',
      link: '/app/cases'
    },
    {
      title: 'Active Cases',
      value: data.stats.activeCases,
      change: data.stats.activeCasesChange,
      icon: CheckCircleIcon,
      color: 'text-green-600',
      bgColor: 'bg-green-50',
      link: '/app/cases?status=active'
    },
    {
      title: 'Total Clients',
      value: data.stats.totalClients,
      change: data.stats.clientsChange,
      icon: UserGroupIcon,
      color: 'text-purple-600',
      bgColor: 'bg-purple-50',
      link: '/app/clients'
    },
    {
      title: 'Total Revenue',
      value: formatCurrency(data.stats.totalRevenue),
      change: data.stats.revenueChange,
      icon: CurrencyDollarIcon,
      color: 'text-yellow-600',
      bgColor: 'bg-yellow-50',
      link: '/app/reports'
    },
    {
      title: 'Pending Tasks',
      value: data.stats.pendingTasks,
      change: data.stats.tasksChange,
      icon: ClipboardDocumentListIcon,
      color: 'text-red-600',
      bgColor: 'bg-red-50',
      link: '/app/tasks'
    },
    {
      title: 'Documents',
      value: data.stats.documentsUploaded,
      change: data.stats.documentsChange,
      icon: DocumentIcon,
      color: 'text-indigo-600',
      bgColor: 'bg-indigo-50',
      link: '/app/documents'
    },
    {
      title: 'Billable Hours',
      value: data.stats.billableHours,
      change: data.stats.hoursChange,
      icon: ClockIcon,
      color: 'text-cyan-600',
      bgColor: 'bg-cyan-50',
      link: '/app/time'
    },
    {
      title: 'Avg Case Value',
      value: formatCurrency(data.stats.avgCaseValue),
      change: data.stats.caseValueChange,
      icon: ChartBarIcon,
      color: 'text-pink-600',
      bgColor: 'bg-pink-50',
      link: '/app/reports'
    }
  ];

  if (state.loading) {
    return (
      <div className="dashboard-loading" style={{ 
        display: 'flex', 
        justifyContent: 'center', 
        alignItems: 'center', 
        height: '50vh' 
      }}>
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
        <span className="ml-3">Loading dashboard...</span>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Welcome Header */}
      <div className="bg-white shadow rounded-lg p-6">
        <div className="sm:flex sm:items-center sm:justify-between">
          <div>
            <h1 className="text-2xl font-bold text-gray-900">
              Welcome back, {effectiveUser?.firstName || 'User'}!
            </h1>
            <p className="mt-2 text-sm text-gray-700">
              Here's what's happening with your legal practice today.
            </p>
            <p className="mt-1 text-xs text-gray-500">
              Last updated: {new Date().toLocaleTimeString()}
            </p>
            {state.error && (
              <div className="mt-2 text-sm text-amber-600 bg-amber-50 border border-amber-200 rounded p-2">
                <ExclamationTriangleIcon className="inline h-4 w-4 mr-1" />
                {state.error}
              </div>
            )}
          </div>
          <div className="mt-4 sm:mt-0 flex gap-3">
            {isDemoMode && (
              <button
                onClick={() => setShowVirtualTour(true)}
                className="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-purple-600 hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500"
              >
                🎭 Start Virtual Tour
              </button>
            )}
            <select
              value={selectedView}
              onChange={(e) => setSelectedView(e.target.value)}
              className="block px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
            >
              <option value="overview">Overview</option>
              <option value="analytics">Analytics</option>
              <option value="reports">Reports</option>
            </select>
          </div>
        </div>
      </div>

      {/* Conditional Content Based on Selected View */}
      {selectedView === 'analytics' ? (
        <div>
          <h2 className="text-xl font-bold text-gray-900 mb-4">Advanced Analytics</h2>
          <div className="bg-white rounded-lg shadow p-6">
            <p className="text-gray-600 mb-4">Click below to view the comprehensive analytics dashboard.</p>
            <Link
              to="/app/analytics"
              className="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700"
            >
              <ChartBarIcon className="h-4 w-4 mr-2" />
              View Analytics Dashboard
            </Link>
          </div>
        </div>
      ) : selectedView === 'reports' ? (
        <div>
          <h2 className="text-xl font-bold text-gray-900 mb-4">Reports</h2>
          <div className="bg-white rounded-lg shadow p-6">
            <p className="text-gray-600 mb-4">Access comprehensive reports and insights.</p>
            <Link
              to="/app/reports"
              className="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-green-600 hover:bg-green-700"
            >
              <DocumentIcon className="h-4 w-4 mr-2" />
              View Reports
            </Link>
          </div>
        </div>
      ) : (
        <>
          {/* Stats Grid */}
          <div className="grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-4">
            {statsCards.map((stat, index) => (
              <Link
                key={index}
                to={stat.link}
                className="bg-white overflow-hidden shadow rounded-lg hover:shadow-md transition-shadow duration-200"
              >
                <div className="p-5">
                  <div className="flex items-center">
                    <div className={`flex-shrink-0 p-3 rounded-md ${stat.bgColor}`}>
                      <stat.icon className={`h-6 w-6 ${stat.color}`} />
                    </div>
                    <div className="ml-5 w-0 flex-1">
                      <dl>
                        <dt className="text-sm font-medium text-gray-500 truncate">
                          {stat.title}
                        </dt>
                        <dd className="text-lg font-medium text-gray-900">
                          {stat.value}
                        </dd>
                        <dd className={`text-sm flex items-center ${
                          stat.change >= 0 ? 'text-green-600' : 'text-red-600'
                        }`}>
                          {stat.change >= 0 ? (
                            <ArrowTrendingUpIcon className="h-3 w-3 mr-1" />
                          ) : (
                            <ArrowTrendingDownIcon className="h-3 w-3 mr-1" />
                          )}
                          {Math.abs(stat.change)}% from last month
                        </dd>
                      </dl>
                    </div>
                  </div>
                </div>
              </Link>
            ))}
          </div>

          {/* Charts Row */}
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <InteractiveChart
              data={data.chartData.casesByMonth}
              title="Cases by Month"
              type="bar"
              xAxisKey="month"
              yAxisKeys={['opened', 'closed', 'pending']}
              colors={['#3B82F6', '#10B981', '#F59E0B']}
              height={300}
              allowTypeChange={true}
              formatters={{
                opened: (value) => `${value} cases`,
                closed: (value) => `${value} cases`,
                pending: (value) => `${value} cases`
              }}
            />

            <InteractiveChart
              data={data.chartData.revenueByType}
              title="Revenue by Case Type"
              type="pie"
              xAxisKey="name"
              yAxisKeys={['value']}
              height={300}
              formatters={{
                value: (value) => formatCurrency(value)
              }}
            />
          </div>

          {/* Content Grid */}
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
            {/* Recent Cases */}
            <div className="bg-white shadow rounded-lg">
              <div className="px-4 py-5 sm:p-6">
                <h3 className="text-lg font-medium text-gray-900 mb-4">Recent Cases ({data.recentCases.length})</h3>
                {data.recentCases.length === 0 ? (
                  <div className="text-center py-6 text-gray-500">
                    <DocumentIcon className="mx-auto h-12 w-12 text-gray-400" />
                    <p className="mt-2">No recent cases found</p>
                    <Link to="/app/cases/new" className="mt-1 text-blue-600 hover:text-blue-800">
                      Create your first case
                    </Link>
                  </div>
                ) : (
                  <div className="space-y-3">
                    {data.recentCases.map((case_item, index) => (
                      <Link
                        key={case_item?.id || index}
                        to={`/app/cases/${case_item?.id || ''}`}
                        className="block p-3 border border-gray-200 rounded-lg hover:border-gray-300 transition-colors"
                      >
                        <div className="flex items-center justify-between">
                          <div className="flex-1 min-w-0">
                            <p className="text-sm font-medium text-gray-900 truncate">
                              {case_item?.title || 'Unnamed Case'}
                            </p>
                            <p className="text-sm text-gray-500">
                              {case_item?.type || 'General'} • {formatCurrency(case_item?.value || 0)}
                            </p>
                          </div>
                          <span className={`px-2 py-1 text-xs font-medium rounded-full ${getStatusColor(case_item?.status || 'ACTIVE')}`}>
                            {case_item?.status || 'ACTIVE'}
                          </span>
                        </div>
                      </Link>
                    ))}
                  </div>
                )}
                <div className="mt-4">
                  <Link
                    to="/app/cases"
                    className="text-sm text-blue-600 hover:text-blue-700 font-medium"
                  >
                    View all cases →
                  </Link>
                </div>
              </div>
            </div>

            {/* Recent Activities */}
            <div className="bg-white shadow rounded-lg">
              <div className="px-4 py-5 sm:p-6">
                <h3 className="text-lg font-medium text-gray-900 mb-4">Recent Activities ({safeData.activities.length})</h3>
                {safeData.activities.length === 0 ? (
                  <div className="text-center py-6 text-gray-500">
                    <BellIcon className="mx-auto h-12 w-12 text-gray-400" />
                    <p className="mt-2">No recent activities</p>
                  </div>
                ) : (
                  <div className="space-y-3">
                    {safeData.activities.slice(0, 5).map((activity, index) => (
                      <div
                        key={activity?.id || index}
                        className="p-3 border border-gray-200 rounded-lg"
                      >
                        <div className="flex items-center justify-between mb-1">
                          <h4 className="text-sm font-medium text-gray-900">
                            {activity?.action || activity?.description || 'Activity'}
                          </h4>
                          <span className="text-xs text-gray-500">
                            {activity?.createdAt ? new Date(activity.createdAt).toLocaleDateString() : 'Unknown date'}
                          </span>
                        </div>
                        {activity?.user && (
                          <p className="text-sm text-gray-500">
                            By: {activity.user.firstName} {activity.user.lastName}
                          </p>
                        )}
                      </div>
                    ))}
                  </div>
                )}
                <div className="mt-4">
                  <Link
                    to="/app/tasks"
                    className="text-sm text-blue-600 hover:text-blue-700 font-medium"
                  >
                    View all activities →
                  </Link>
                </div>
              </div>
            </div>

            {/* Quick Actions */}
            <div className="bg-white shadow rounded-lg">
              <div className="px-4 py-5 sm:p-6">
                <h3 className="text-lg font-medium text-gray-900 mb-4">Quick Actions</h3>
                <div className="space-y-3">
                  <Link
                    to="/app/cases/new"
                    className="flex items-center p-3 border border-gray-200 rounded-lg hover:border-blue-300 hover:bg-blue-50 transition-colors"
                  >
                    <DocumentIcon className="h-5 w-5 text-blue-600 mr-3" />
                    <span className="text-sm font-medium text-gray-900">Create New Case</span>
                  </Link>
                  <Link
                    to="/app/clients/new"
                    className="flex items-center p-3 border border-gray-200 rounded-lg hover:border-green-300 hover:bg-green-50 transition-colors"
                  >
                    <UserGroupIcon className="h-5 w-5 text-green-600 mr-3" />
                    <span className="text-sm font-medium text-gray-900">Add New Client</span>
                  </Link>
                  <Link
                    to="/app/documents"
                    className="flex items-center p-3 border border-gray-200 rounded-lg hover:border-purple-300 hover:bg-purple-50 transition-colors"
                  >
                    <DocumentIcon className="h-5 w-5 text-purple-600 mr-3" />
                    <span className="text-sm font-medium text-gray-900">Upload Documents</span>
                  </Link>
                  <Link
                    to="/app/time"
                    className="flex items-center p-3 border border-gray-200 rounded-lg hover:border-yellow-300 hover:bg-yellow-50 transition-colors"
                  >
                    <ClockIcon className="h-5 w-5 text-yellow-600 mr-3" />
                    <span className="text-sm font-medium text-gray-900">Track Time</span>
                  </Link>
                </div>
              </div>
            </div>
          </div>
        </>
      )}

      {/* Virtual Tour for Demo Mode */}
      {isDemoMode && (
        <VirtualTour
          isActive={showVirtualTour}
          onClose={() => setShowVirtualTour(false)}
        />
      )}
    </div>
  );
};

export default Dashboard;