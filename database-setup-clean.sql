-- Pedro's Dental Practice - Watch Dashboard Database Setup
-- This script creates all required tables and populates them with realistic sample data

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS testimonials CASCADE;
DROP TABLE IF EXISTS appointments CASCADE;
DROP TABLE IF EXISTS services CASCADE;
DROP TABLE IF EXISTS patients CASCADE;

-- Create patients table
CREATE TABLE patients (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    auth_user_id UUID,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    date_of_birth DATE,
    address TEXT,
    medical_history JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create services table
CREATE TABLE services (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    category TEXT NOT NULL,
    estimated_duration INTERVAL,
    price_range JSONB,
    image_url TEXT,
    is_yomi_technology BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create appointments table
CREATE TABLE appointments (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    patient_id UUID REFERENCES patients(id) ON DELETE CASCADE,
    service_id UUID REFERENCES services(id) ON DELETE SET NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status TEXT CHECK (status IN ('scheduled', 'completed', 'cancelled')) DEFAULT 'scheduled',
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create testimonials table
CREATE TABLE testimonials (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    patient_id UUID REFERENCES patients(id) ON DELETE CASCADE,
    service_id UUID REFERENCES services(id) ON DELETE SET NULL,
    rating INTEGER CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    is_approved BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX idx_appointments_date ON appointments(appointment_date);
CREATE INDEX idx_appointments_patient ON appointments(patient_id);
CREATE INDEX idx_appointments_service ON appointments(service_id);
CREATE INDEX idx_testimonials_approved ON testimonials(is_approved);
CREATE INDEX idx_patients_email ON patients(email);

-- Enable Row Level Security (RLS)
ALTER TABLE patients ENABLE ROW LEVEL SECURITY;
ALTER TABLE appointments ENABLE ROW LEVEL SECURITY;
ALTER TABLE services ENABLE ROW LEVEL SECURITY;
ALTER TABLE testimonials ENABLE ROW LEVEL SECURITY;

-- Create RLS policies (allow all operations for now - should be restricted in production)
CREATE POLICY "Allow all operations on patients" ON patients FOR ALL USING (true);
CREATE POLICY "Allow all operations on appointments" ON appointments FOR ALL USING (true);
CREATE POLICY "Allow all operations on services" ON services FOR ALL USING (true);
CREATE POLICY "Allow all operations on testimonials" ON testimonials FOR ALL USING (true);

-- Insert sample patients
INSERT INTO patients (first_name, last_name, email, phone, date_of_birth, address, medical_history, created_at) VALUES
('Maria', 'Rodriguez', 'maria.rodriguez@email.com', '(555) 123-4567', '1985-03-15', '123 Main St, Miami, FL 33101', '{"allergies": ["penicillin"], "conditions": ["diabetes"]}', NOW() - INTERVAL '2 years'),
('John', 'Smith', 'john.smith@email.com', '(555) 234-5678', '1978-07-22', '456 Oak Ave, Miami, FL 33102', '{"allergies": [], "conditions": []}', NOW() - INTERVAL '1 year 6 months'),
('Sarah', 'Johnson', 'sarah.johnson@email.com', '(555) 345-6789', '1990-11-08', '789 Pine St, Miami, FL 33103', '{"allergies": ["latex"], "conditions": []}', NOW() - INTERVAL '8 months'),
('David', 'Brown', 'david.brown@email.com', '(555) 456-7890', '1982-09-14', '321 Elm St, Miami, FL 33104', '{"allergies": [], "conditions": ["hypertension"]}', NOW() - INTERVAL '1 year 2 months'),
('Lisa', 'Garcia', 'lisa.garcia@email.com', '(555) 567-8901', '1995-05-30', '654 Maple Ave, Miami, FL 33105', '{"allergies": [], "conditions": []}', NOW() - INTERVAL '6 months'),
('Michael', 'Wilson', 'michael.wilson@email.com', '(555) 678-9012', '1973-12-03', '987 Cedar St, Miami, FL 33106', '{"allergies": ["iodine"], "conditions": ["diabetes"]}', NOW() - INTERVAL '3 years'),
('Jennifer', 'Martinez', 'jennifer.martinez@email.com', '(555) 789-0123', '1988-08-18', '147 Birch St, Miami, FL 33107', '{"allergies": [], "conditions": []}', NOW() - INTERVAL '4 months'),
('Robert', 'Anderson', 'robert.anderson@email.com', '(555) 890-1234', '1980-01-25', '258 Spruce Ave, Miami, FL 33108', '{"allergies": ["sulfa"], "conditions": []}', NOW() - INTERVAL '1 year 8 months'),
('Amanda', 'Taylor', 'amanda.taylor@email.com', '(555) 901-2345', '1992-06-12', '369 Walnut St, Miami, FL 33109', '{"allergies": [], "conditions": []}', NOW() - INTERVAL '2 months'),
('Christopher', 'Thomas', 'christopher.thomas@email.com', '(555) 012-3456', '1986-04-07', '741 Cherry Ave, Miami, FL 33110', '{"allergies": [], "conditions": ["asthma"]}', NOW() - INTERVAL '10 months'),
('Jessica', 'Hernandez', 'jessica.hernandez@email.com', '(555) 123-7890', '1991-10-16', '852 Poplar St, Miami, FL 33111', '{"allergies": [], "conditions": []}', NOW() - INTERVAL '3 weeks'),
('Daniel', 'Moore', 'daniel.moore@email.com', '(555) 234-8901', '1975-02-28', '963 Sycamore Ave, Miami, FL 33112', '{"allergies": ["penicillin"], "conditions": []}', NOW() - INTERVAL '1 year 4 months'),
('Michelle', 'Jackson', 'michelle.jackson@email.com', '(555) 345-9012', '1987-09-09', '159 Hickory St, Miami, FL 33113', '{"allergies": [], "conditions": []}', NOW() - INTERVAL '7 months'),
('Kevin', 'White', 'kevin.white@email.com', '(555) 456-0123', '1983-12-20', '753 Willow Ave, Miami, FL 33114', '{"allergies": [], "conditions": ["diabetes"]}', NOW() - INTERVAL '1 year 1 month'),
('Rachel', 'Lewis', 'rachel.lewis@email.com', '(555) 567-1234', '1994-07-05', '486 Ash St, Miami, FL 33115', '{"allergies": [], "conditions": []}', NOW() - INTERVAL '5 months'),
('Thomas', 'Lee', 'thomas.lee@email.com', '(555) 678-2345', '1989-03-11', '624 Beech Ave, Miami, FL 33116', '{"allergies": ["latex"], "conditions": []}', NOW() - INTERVAL '1 week'),
('Nicole', 'Walker', 'nicole.walker@email.com', '(555) 789-3456', '1976-11-24', '357 Redwood St, Miami, FL 33117', '{"allergies": [], "conditions": []}', NOW() - INTERVAL '9 months'),
('Matthew', 'Hall', 'matthew.hall@email.com', '(555) 890-4567', '1984-08-02', '791 Fir Ave, Miami, FL 33118', '{"allergies": [], "conditions": ["hypertension"]}', NOW() - INTERVAL '1 year 7 months'),
('Stephanie', 'Allen', 'stephanie.allen@email.com', '(555) 901-5678', '1993-01-17', '135 Sequoia St, Miami, FL 33119', '{"allergies": [], "conditions": []}', NOW() - INTERVAL '4 days'),
('Ryan', 'Young', 'ryan.young@email.com', '(555) 012-6789', '1981-05-26', '468 Magnolia Ave, Miami, FL 33120', '{"allergies": ["iodine"], "conditions": []}', NOW() - INTERVAL '2 years 3 months');

SELECT 'Database schema and patient data loaded successfully!' AS result;