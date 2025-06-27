import React, { useState } from 'react';
import BreitlingChronomat from './watches/BreitlingChronomat';
import { useWatchTime } from '../hooks/useWatchTime';
import { useSupabaseData, useSupabaseConnection } from '../hooks/useSupabaseData';
import { DataMode } from '../types/watch.types';

const WatchDashboard: React.FC = () => {
  const [dataMode, setDataMode] = useState<DataMode>('appointments');
  const [watchSize, setWatchSize] = useState<'small' | 'medium' | 'large'>('medium');
  const [interactiveMode, setInteractiveMode] = useState(true);
  const [realTimeUpdates, setRealTimeUpdates] = useState(true);

  // Custom hooks
  const currentTime = useWatchTime();
  const { metrics, loading, error, lastUpdated, refetch } = useSupabaseData(realTimeUpdates);
  const { isConnected, connectionError } = useSupabaseConnection();

  const handleModeChange = (mode: DataMode) => {
    setDataMode(mode);
  };

  const getStatusColor = () => {
    if (loading) return '#fbbf24'; // yellow
    if (error || connectionError) return '#ef4444'; // red
    if (isConnected && metrics) return '#22c55e'; // green
    return '#6b7280'; // gray
  };

  const getStatusText = () => {
    if (loading) return 'Loading...';
    if (error) return `Error: ${error}`;
    if (connectionError) return `Connection: ${connectionError}`;
    if (isConnected && metrics) return 'Connected';
    return 'Disconnected';
  };

  // Show mock data with loading state while data is being fetched
  const displayMetrics = metrics || {
    appointments: {
      todayCount: 0,
      weeklyUpcoming: 0,
      completionRate: 0,
      averageDuration: 0,
      nextAppointment: null
    },
    patients: {
      totalActive: 0,
      newThisMonth: 0,
      satisfactionAverage: 0,
      returningPercentage: 0,
      patientOfTheDay: 'Loading...'
    },
    services: {
      totalServices: 0,
      yomiProcedures: 0,
      revenuePerService: 0,
      popularService: 'Loading...',
      bookingTrends: 0
    },
    performance: {
      dailyRevenue: 0,
      weeklyTarget: 0,
      staffProductivity: 0,
      testimonialRating: 0,
      performanceStatus: 'Loading...'
    }
  };

  return (
    <div style={{
      minHeight: '100vh',
      background: 'linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #334155 100%)',
      display: 'flex',
      flexDirection: 'column',
      alignItems: 'center',
      padding: '20px',
      fontFamily: 'Arial, sans-serif'
    }}>
      {/* Header */}
      <div style={{
        width: '100%',
        maxWidth: '1200px',
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center',
        marginBottom: '30px',
        padding: '0 20px'
      }}>
        <div>
          <h1 style={{
            color: '#ffffff',
            fontSize: '28px',
            fontWeight: 'bold',
            margin: '0 0 5px 0'
          }}>
            Breitling Watch Dashboard
          </h1>
          <p style={{
            color: '#94a3b8',
            fontSize: '14px',
            margin: 0
          }}>
            Dr. Pedro's Dental Practice Analytics
          </p>
        </div>
        
        {/* Status Indicator */}
        <div style={{
          display: 'flex',
          alignItems: 'center',
          gap: '10px',
          background: 'rgba(0, 0, 0, 0.3)',
          padding: '8px 16px',
          borderRadius: '8px',
          border: '1px solid rgba(255, 255, 255, 0.1)'
        }}>
          <div style={{
            width: '8px',
            height: '8px',
            borderRadius: '50%',
            background: getStatusColor(),
            boxShadow: `0 0 8px ${getStatusColor()}`
          }} />
          <span style={{
            color: '#e2e8f0',
            fontSize: '12px'
          }}>
            {getStatusText()}
          </span>
          {lastUpdated && (
            <span style={{
              color: '#64748b',
              fontSize: '10px',
              marginLeft: '8px'
            }}>
              Updated: {lastUpdated.toLocaleTimeString()}
            </span>
          )}
        </div>
      </div>

      {/* Main Watch Display */}
      <div style={{
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        gap: '20px'
      }}>
        <BreitlingChronomat
          model="chronomat"
          size={watchSize}
          dataMode={dataMode}
          realTimeUpdates={realTimeUpdates}
          interactiveMode={interactiveMode}
          onModeChange={handleModeChange}
          metrics={displayMetrics}
          currentTime={currentTime}
        />

        {/* Control Panel */}
        <div style={{
          display: 'flex',
          gap: '20px',
          alignItems: 'center',
          background: 'rgba(0, 0, 0, 0.3)',
          padding: '15px',
          borderRadius: '12px',
          border: '1px solid rgba(255, 255, 255, 0.1)',
          flexWrap: 'wrap'
        }}>
          {/* Size Control */}
          <div style={{ display: 'flex', flexDirection: 'column', gap: '5px' }}>
            <label style={{ color: '#e2e8f0', fontSize: '12px' }}>Size</label>
            <select
              value={watchSize}
              onChange={(e) => setWatchSize(e.target.value as 'small' | 'medium' | 'large')}
              style={{
                background: '#1e293b',
                color: '#e2e8f0',
                border: '1px solid #475569',
                borderRadius: '4px',
                padding: '4px 8px',
                fontSize: '12px'
              }}
            >
              <option value="small">Small</option>
              <option value="medium">Medium</option>
              <option value="large">Large</option>
            </select>
          </div>

          {/* Data Mode Control */}
          <div style={{ display: 'flex', flexDirection: 'column', gap: '5px' }}>
            <label style={{ color: '#e2e8f0', fontSize: '12px' }}>Data Mode</label>
            <select
              value={dataMode}
              onChange={(e) => setDataMode(e.target.value as DataMode)}
              style={{
                background: '#1e293b',
                color: '#e2e8f0',
                border: '1px solid #475569',
                borderRadius: '4px',
                padding: '4px 8px',
                fontSize: '12px'
              }}
            >
              <option value="appointments">Appointments</option>
              <option value="patients">Patients</option>
              <option value="services">Services</option>
              <option value="performance">Performance</option>
            </select>
          </div>

          {/* Toggle Controls */}
          <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
            <label style={{
              display: 'flex',
              alignItems: 'center',
              gap: '8px',
              color: '#e2e8f0',
              fontSize: '12px',
              cursor: 'pointer'
            }}>
              <input
                type="checkbox"
                checked={interactiveMode}
                onChange={(e) => setInteractiveMode(e.target.checked)}
                style={{ accentColor: '#22c55e' }}
              />
              Interactive Mode
            </label>
            
            <label style={{
              display: 'flex',
              alignItems: 'center',
              gap: '8px',
              color: '#e2e8f0',
              fontSize: '12px',
              cursor: 'pointer'
            }}>
              <input
                type="checkbox"
                checked={realTimeUpdates}
                onChange={(e) => setRealTimeUpdates(e.target.checked)}
                style={{ accentColor: '#22c55e' }}
              />
              Real-time Updates
            </label>
          </div>

          {/* Manual Refresh */}
          <button
            onClick={refetch}
            disabled={loading}
            style={{
              background: loading ? '#374151' : '#22c55e',
              color: '#ffffff',
              border: 'none',
              borderRadius: '6px',
              padding: '8px 12px',
              fontSize: '12px',
              cursor: loading ? 'not-allowed' : 'pointer',
              opacity: loading ? 0.6 : 1,
              transition: 'all 0.2s ease'
            }}
          >
            {loading ? 'Loading...' : 'Refresh Data'}
          </button>
        </div>

        {/* Current Time Display */}
        <div style={{
          background: 'rgba(0, 0, 0, 0.5)',
          color: '#22c55e',
          padding: '8px 16px',
          borderRadius: '8px',
          border: '1px solid rgba(34, 197, 94, 0.3)',
          fontSize: '14px',
          fontFamily: 'monospace',
          fontWeight: 'bold'
        }}>
          Current Time: {currentTime.toLocaleTimeString()}
        </div>

        {/* Instructions */}
        <div style={{
          background: 'rgba(0, 0, 0, 0.2)',
          color: '#94a3b8',
          padding: '12px',
          borderRadius: '8px',
          maxWidth: '600px',
          textAlign: 'center',
          fontSize: '12px',
          lineHeight: '1.5'
        }}>
          <p style={{ margin: '0 0 8px 0' }}>
            <strong>Interactive Features:</strong>
          </p>
          <p style={{ margin: 0 }}>
            • Click mode indicator to switch data views
            • Use chronometer pushers to start/stop/reset timer
            • Crown interaction for time adjustment (when interactive)
            • Real-time data updates from Supabase
          </p>
        </div>
      </div>
    </div>
  );
};

export default WatchDashboard;
