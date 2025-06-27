# 🚀 Live Backend Setup Instructions

## Quick Setup (15 minutes total)

Your Breitling Watch Dashboard is ready to connect to the live Supabase backend. The development server is already running at **http://localhost:3000**.

### Step 1: Execute Database Setup (10 minutes)

1. **Login to Supabase Dashboard**
   - Go to https://supabase.com
   - Login to your account
   - Select project: `tsmtaarwgodklafqlbhm`

2. **Run SQL Scripts in Order** (in SQL Editor)
   
   **First:** Copy and paste [`database-setup-clean.sql`](database-setup-clean.sql) 
   - Creates tables, indexes, RLS policies
   - Adds 20 realistic patient records
   - Click "Run" ✅
   
   **Second:** Copy and paste [`populate-data-clean.sql`](populate-data-clean.sql)
   - Adds 15 dental services (5 YOMI procedures)
   - Creates 23 appointments for this week
   - Click "Run" ✅
   
   **Third:** Copy and paste [`testimonials-setup-clean.sql`](testimonials-setup-clean.sql)
   - Adds 20 patient reviews (4.8★ average)
   - Enables real-time subscriptions
   - Click "Run" ✅

### Step 2: Verify Live Connection (2 minutes)

1. **Check Dashboard Status**
   - Open http://localhost:3000 (should be running)
   - Status indicator should show "Connected" (green dot)
   - Data should populate automatically

2. **Expected Live Metrics**
   - Today's appointments: **7**
   - Weekly upcoming: **23** 
   - Total patients: **20**
   - Patient satisfaction: **4.8★**
   - YOMI procedures: **5** 

### Step 3: Test Data Modes (3 minutes)

Switch between the 4 modes using the dropdown:

- **📅 Appointments**: Shows daily/weekly scheduling metrics
- **👥 Patients**: Shows patient count and satisfaction
- **🔧 Services**: Shows YOMI procedures and revenue  
- **📊 Performance**: Shows daily revenue and productivity

## 🎯 What You'll See

### Live Data Display
```
Status: Connected ● (green)
Today: 7 appointments
Weekly: 23 upcoming
Satisfaction: 4.8/5 stars
Daily Revenue: $1,750
```

### Interactive Features
- ✅ Real-time updates when data changes
- ✅ Smooth watch hand animations
- ✅ Mode switching with dropdown
- ✅ Professional Breitling aesthetics
- ✅ Live connection monitoring

## 🔧 Files Created

- [`database-setup-clean.sql`](database-setup-clean.sql): Schema + patients
- [`populate-data-clean.sql`](populate-data-clean.sql): Services + appointments  
- [`testimonials-setup-clean.sql`](testimonials-setup-clean.sql): Reviews + real-time
- [`.env`](..env): Live backend credentials

## 🚨 Troubleshooting

**If connection shows "Disconnected":**
- Verify all 3 SQL scripts ran successfully
- Check browser console for errors
- Refresh the page

**If no data shows:**
- Ensure patient data was inserted (20 records)
- Check appointments table has data
- Verify real-time subscriptions are enabled

Your luxury watch dashboard is now ready with live dental practice analytics! 🎉