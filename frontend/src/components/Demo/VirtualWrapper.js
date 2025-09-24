import React, { useState, useEffect } from 'react';
import { XMarkIcon, InformationCircleIcon } from '../Icons';

const VirtualWrapper = ({ children }) => {
  const [isActive, setIsActive] = useState(false);
  const [currentStep, setCurrentStep] = useState(0);
  const [hasStarted, setHasStarted] = useState(false);

  // Tour steps for the demo
  const tourSteps = [
    {
      target: '[data-tour="dashboard"]',
      title: 'Welcome to Legal Estate Management',
      content: 'This is your main dashboard where you can overview all your cases, clients, and important metrics.',
      position: 'bottom'
    },
    {
      target: '[data-tour="cases"]',
      title: 'Case Management',
      content: 'Manage all your legal cases with advanced tracking, deadlines, and documentation.',
      position: 'right'
    },
    {
      target: '[data-tour="clients"]',
      title: 'Client Management',
      content: 'Keep track of client information, communications, and case history.',
      position: 'right'
    },
    {
      target: '[data-tour="ai-features"]',
      title: 'AI-Powered Features',
      content: 'Generate legal documents, research case law, and get AI assistance with your work.',
      position: 'bottom'
    },
    {
      target: '[data-tour="reports"]',
      title: 'Advanced Analytics',
      content: 'Generate comprehensive reports and analytics to track your firm\'s performance.',
      position: 'left'
    }
  ];

  // Auto-start tour on first visit
  useEffect(() => {
    const hasSeenTour = localStorage.getItem('demo-tour-completed');
    if (!hasSeenTour) {
      setTimeout(() => {
        setIsActive(true);
        setHasStarted(true);
      }, 2000);
    }
  }, []);

  const nextStep = () => {
    if (currentStep < tourSteps.length - 1) {
      setCurrentStep(currentStep + 1);
    } else {
      completeTour();
    }
  };

  const prevStep = () => {
    if (currentStep > 0) {
      setCurrentStep(currentStep - 1);
    }
  };

  const completeTour = () => {
    setIsActive(false);
    setCurrentStep(0);
    localStorage.setItem('demo-tour-completed', 'true');
  };

  const restartTour = () => {
    setCurrentStep(0);
    setIsActive(true);
    setHasStarted(true);
  };

  const skipTour = () => {
    completeTour();
  };

  // Get current step element position
  const getCurrentStepElement = () => {
    const step = tourSteps[currentStep];
    return document.querySelector(step.target);
  };

  // Calculate tooltip position
  const getTooltipPosition = () => {
    const element = getCurrentStepElement();
    if (!element) return { top: '50%', left: '50%', transform: 'translate(-50%, -50%)' };

    const rect = element.getBoundingClientRect();
    const step = tourSteps[currentStep];
    const tooltipWidth = 384; // max-w-sm is ~384px
    const tooltipHeight = 200; // approximate height

    // Get viewport dimensions
    const viewportWidth = window.innerWidth;
    const viewportHeight = window.innerHeight;

    let position = {};

    switch (step.position) {
      case 'top':
        position = {
          top: rect.top - tooltipHeight - 20,
          left: Math.max(20, Math.min(rect.left + rect.width / 2, viewportWidth - tooltipWidth - 20)),
          transform: 'translateX(-50%)'
        };
        break;
      case 'bottom':
        position = {
          top: rect.bottom + 20,
          left: Math.max(20, Math.min(rect.left + rect.width / 2, viewportWidth - tooltipWidth - 20)),
          transform: 'translateX(-50%)'
        };
        break;
      case 'left':
        position = {
          top: Math.max(20, Math.min(rect.top + rect.height / 2, viewportHeight - tooltipHeight - 20)),
          left: Math.max(20, rect.left - tooltipWidth - 20),
          transform: 'translateY(-50%)'
        };
        break;
      case 'right':
        position = {
          top: Math.max(20, Math.min(rect.top + rect.height / 2, viewportHeight - tooltipHeight - 20)),
          left: Math.min(rect.right + 20, viewportWidth - tooltipWidth - 20),
          transform: 'translateY(-50%)'
        };
        break;
      default:
        position = {
          top: rect.bottom + 20,
          left: Math.max(20, Math.min(rect.left + rect.width / 2, viewportWidth - tooltipWidth - 20)),
          transform: 'translateX(-50%)'
        };
    }

    // Ensure tooltip stays within viewport bounds
    if (position.top < 20) position.top = 20;
    if (position.top > viewportHeight - tooltipHeight - 20) position.top = viewportHeight - tooltipHeight - 20;
    if (position.left < 20) position.left = 20;
    if (position.left > viewportWidth - tooltipWidth - 20) position.left = viewportWidth - tooltipWidth - 20;

    return position;
  };

  return (
    <div className="relative">
      {children}

      {/* Demo Badge */}
      <div className="fixed top-4 right-4 z-50">
        <div className="bg-gradient-to-r from-blue-600 to-purple-600 text-white px-4 py-2 rounded-lg shadow-lg">
          <div className="flex items-center space-x-2">
            <InformationCircleIcon className="h-5 w-5" />
            <span className="font-medium">Demo Mode</span>
            <button
              onClick={restartTour}
              className="text-blue-200 hover:text-white text-sm underline"
            >
              Take Tour
            </button>
          </div>
        </div>
      </div>

      {/* Tour Overlay */}
      {isActive && (
        <div className="fixed inset-0 z-40">
          {/* Dark overlay */}
          <div className="absolute inset-0 bg-black bg-opacity-50" />

          {/* Highlight current element */}
          {getCurrentStepElement() && (
            <div
              className="absolute border-4 border-blue-500 rounded-lg pointer-events-none shadow-lg"
              style={{
                top: getCurrentStepElement().getBoundingClientRect().top - 4,
                left: getCurrentStepElement().getBoundingClientRect().left - 4,
                width: getCurrentStepElement().getBoundingClientRect().width + 8,
                height: getCurrentStepElement().getBoundingClientRect().height + 8,
              }}
            />
          )}

          {/* Tour Tooltip */}
          <div
            className="absolute z-50 bg-white rounded-lg shadow-xl p-6 max-w-sm"
            style={getTooltipPosition()}
          >
            <div className="flex justify-between items-start mb-4">
              <h3 className="text-lg font-semibold text-gray-900">
                {tourSteps[currentStep]?.title}
              </h3>
              <button
                onClick={skipTour}
                className="text-gray-400 hover:text-gray-600"
              >
                <XMarkIcon className="h-5 w-5" />
              </button>
            </div>

            <p className="text-gray-600 mb-6">
              {tourSteps[currentStep]?.content}
            </p>

            <div className="flex justify-between items-center">
              <div className="flex space-x-1">
                {tourSteps.map((_, index) => (
                  <div
                    key={index}
                    className={`w-2 h-2 rounded-full ${
                      index === currentStep ? 'bg-blue-600' : 'bg-gray-300'
                    }`}
                  />
                ))}
              </div>

              <div className="flex space-x-2">
                {currentStep > 0 && (
                  <button
                    onClick={prevStep}
                    className="px-4 py-2 text-gray-600 hover:text-gray-800"
                  >
                    Previous
                  </button>
                )}
                <button
                  onClick={nextStep}
                  className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
                >
                  {currentStep === tourSteps.length - 1 ? 'Finish' : 'Next'}
                </button>
              </div>
            </div>

            <div className="mt-4 text-center">
              <span className="text-sm text-gray-500">
                Step {currentStep + 1} of {tourSteps.length}
              </span>
            </div>
          </div>
        </div>
      )}

      {/* Nightly Reset Notification */}
      <div className="fixed bottom-4 left-4 z-50">
        <div className="bg-yellow-100 border border-yellow-400 text-yellow-800 px-4 py-2 rounded-lg shadow-lg max-w-sm">
          <div className="flex items-start space-x-2">
            <InformationCircleIcon className="h-5 w-5 mt-0.5 flex-shrink-0" />
            <div>
              <p className="text-sm font-medium">Demo Environment</p>
              <p className="text-xs">
                Data resets nightly at 2 AM UTC for fresh demo experience.
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default VirtualWrapper;