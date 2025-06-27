import { createClient } from '@supabase/supabase-js';

// Live Supabase backend configuration
const supabaseUrl = process.env.REACT_APP_SUPABASE_URL || 'https://tsmtaarwgodklafqlbhm.supabase.co';
const supabaseAnonKey = process.env.REACT_APP_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRzbXRhYXJ3Z29ka2xhZnFsYmhtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc4NTM2MjAsImV4cCI6MjA2MzQyOTYyMH0.AT_9RXVrI82-oSbvUACmtRgFCm2k-rx4hEozKqMa1Ds';

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

// Real-time subscription helper
export const subscribeToTable = (
  table: string,
  callback: (payload: any) => void,
  filter?: string
) => {
  const subscription = supabase
    .channel(`${table}_changes`)
    .on(
      'postgres_changes',
      {
        event: '*',
        schema: 'public',
        table: table,
        filter: filter,
      },
      callback
    )
    .subscribe();

  return subscription;
};

// Unsubscribe helper
export const unsubscribeFromTable = (subscription: any) => {
  if (subscription) {
    supabase.removeChannel(subscription);
  }
};