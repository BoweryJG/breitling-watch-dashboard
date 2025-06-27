-- Insert dental services with YOMI technology procedures
INSERT INTO services (name, description, category, estimated_duration, price_range, is_yomi_technology, created_at) VALUES
('Dental Cleaning', 'Routine dental cleaning and examination', 'Preventive', '1 hour', '{"min": 150, "max": 200}', false, NOW() - INTERVAL '2 years'),
('YOMI Guided Implant Surgery', 'Robot-assisted dental implant placement', 'Surgery', '2 hours', '{"min": 3500, "max": 5000}', true, NOW() - INTERVAL '1 year'),
('Root Canal Treatment', 'Endodontic treatment for infected tooth', 'Restorative', '1.5 hours', '{"min": 800, "max": 1200}', false, NOW() - INTERVAL '1 year 6 months'),
('Teeth Whitening', 'Professional teeth whitening treatment', 'Cosmetic', '1 hour', '{"min": 300, "max": 500}', false, NOW() - INTERVAL '1 year 3 months'),
('YOMI Guided Crown Preparation', 'Robot-assisted crown preparation', 'Restorative', '1.5 hours', '{"min": 1500, "max": 2000}', true, NOW() - INTERVAL '8 months'),
('Dental Filling', 'Composite resin filling for cavities', 'Restorative', '45 minutes', '{"min": 200, "max": 400}', false, NOW() - INTERVAL '2 years'),
('Orthodontic Consultation', 'Initial consultation for braces or aligners', 'Orthodontics', '45 minutes', '{"min": 100, "max": 150}', false, NOW() - INTERVAL '1 year 8 months'),
('Periodontal Cleaning', 'Deep cleaning for gum disease', 'Periodontics', '1.5 hours', '{"min": 400, "max": 600}', false, NOW() - INTERVAL '1 year 4 months'),
('YOMI Guided Extraction', 'Robot-assisted tooth extraction', 'Surgery', '1 hour', '{"min": 800, "max": 1200}', true, NOW() - INTERVAL '6 months'),
('Dental Bridge', 'Fixed bridge to replace missing teeth', 'Restorative', '2 hours', '{"min": 2000, "max": 3500}', false, NOW() - INTERVAL '1 year 9 months'),
('Emergency Dental Care', 'Urgent dental treatment for pain or trauma', 'Emergency', '1 hour', '{"min": 200, "max": 800}', false, NOW() - INTERVAL '2 years'),
('Dental Veneer', 'Porcelain veneer for cosmetic improvement', 'Cosmetic', '2 hours', '{"min": 1000, "max": 1500}', false, NOW() - INTERVAL '10 months'),
('Wisdom Tooth Extraction', 'Surgical removal of wisdom teeth', 'Surgery', '1.5 hours', '{"min": 600, "max": 1000}', false, NOW() - INTERVAL '1 year 2 months'),
('Dental Consultation', 'Initial examination and treatment planning', 'Consultation', '30 minutes', '{"min": 50, "max": 100}', false, NOW() - INTERVAL '2 years'),
('Dental Crown', 'Ceramic crown for damaged tooth', 'Restorative', '1.5 hours', '{"min": 1200, "max": 1800}', false, NOW() - INTERVAL '1 year 5 months');

-- Insert appointments for current week (today's appointments for live demo)
INSERT INTO appointments (patient_id, service_id, appointment_date, appointment_time, status, notes, created_at) VALUES
-- Today's appointments (7 total for demo)
((SELECT id FROM patients WHERE email = 'maria.rodriguez@email.com'), (SELECT id FROM services WHERE name = 'Dental Cleaning'), CURRENT_DATE, '09:00', 'completed', 'Routine cleaning completed successfully', NOW() - INTERVAL '2 hours'),
((SELECT id FROM patients WHERE email = 'john.smith@email.com'), (SELECT id FROM services WHERE name = 'YOMI Guided Implant Surgery'), CURRENT_DATE, '10:30', 'completed', 'YOMI implant surgery completed', NOW() - INTERVAL '4 hours'),
((SELECT id FROM patients WHERE email = 'sarah.johnson@email.com'), (SELECT id FROM services WHERE name = 'Dental Filling'), CURRENT_DATE, '13:00', 'completed', 'Composite filling placed', NOW() - INTERVAL '3 hours'),
((SELECT id FROM patients WHERE email = 'david.brown@email.com'), (SELECT id FROM services WHERE name = 'Root Canal Treatment'), CURRENT_DATE, '14:30', 'scheduled', 'Root canal treatment scheduled', NOW() - INTERVAL '1 day'),
((SELECT id FROM patients WHERE email = 'lisa.garcia@email.com'), (SELECT id FROM services WHERE name = 'Teeth Whitening'), CURRENT_DATE, '16:00', 'scheduled', 'Whitening treatment', NOW() - INTERVAL '2 days'),
((SELECT id FROM patients WHERE email = 'michael.wilson@email.com'), (SELECT id FROM services WHERE name = 'Dental Consultation'), CURRENT_DATE, '17:00', 'scheduled', 'Follow-up consultation', NOW() - INTERVAL '1 day'),
((SELECT id FROM patients WHERE email = 'jennifer.martinez@email.com'), (SELECT id FROM services WHERE name = 'Periodontal Cleaning'), CURRENT_DATE, '18:00', 'scheduled', 'Deep cleaning appointment', NOW() - INTERVAL '3 days'),

-- Tomorrow's appointments (5 total)
((SELECT id FROM patients WHERE email = 'robert.anderson@email.com'), (SELECT id FROM services WHERE name = 'YOMI Guided Crown Preparation'), CURRENT_DATE + INTERVAL '1 day', '09:00', 'scheduled', 'YOMI crown prep scheduled', NOW() - INTERVAL '2 days'),
((SELECT id FROM patients WHERE email = 'amanda.taylor@email.com'), (SELECT id FROM services WHERE name = 'Dental Cleaning'), CURRENT_DATE + INTERVAL '1 day', '10:30', 'scheduled', 'Regular cleaning', NOW() - INTERVAL '1 day'),
((SELECT id FROM patients WHERE email = 'christopher.thomas@email.com'), (SELECT id FROM services WHERE name = 'Orthodontic Consultation'), CURRENT_DATE + INTERVAL '1 day', '13:00', 'scheduled', 'Braces consultation', NOW() - INTERVAL '4 days'),
((SELECT id FROM patients WHERE email = 'jessica.hernandez@email.com'), (SELECT id FROM services WHERE name = 'Dental Veneer'), CURRENT_DATE + INTERVAL '1 day', '14:30', 'scheduled', 'Veneer placement', NOW() - INTERVAL '1 week'),
((SELECT id FROM patients WHERE email = 'daniel.moore@email.com'), (SELECT id FROM services WHERE name = 'YOMI Guided Extraction'), CURRENT_DATE + INTERVAL '1 day', '16:00', 'scheduled', 'YOMI extraction scheduled', NOW() - INTERVAL '3 days'),

-- Rest of week (11 more for 23 total weekly)
((SELECT id FROM patients WHERE email = 'michelle.jackson@email.com'), (SELECT id FROM services WHERE name = 'Dental Bridge'), CURRENT_DATE + INTERVAL '2 days', '09:00', 'scheduled', 'Bridge consultation', NOW() - INTERVAL '1 week'),
((SELECT id FROM patients WHERE email = 'kevin.white@email.com'), (SELECT id FROM services WHERE name = 'Dental Cleaning'), CURRENT_DATE + INTERVAL '2 days', '11:00', 'scheduled', 'Diabetic patient cleaning', NOW() - INTERVAL '5 days'),
((SELECT id FROM patients WHERE email = 'rachel.lewis@email.com'), (SELECT id FROM services WHERE name = 'Dental Filling'), CURRENT_DATE + INTERVAL '2 days', '14:00', 'scheduled', 'Multiple fillings needed', NOW() - INTERVAL '2 days'),
((SELECT id FROM patients WHERE email = 'thomas.lee@email.com'), (SELECT id FROM services WHERE name = 'Emergency Dental Care'), CURRENT_DATE + INTERVAL '3 days', '10:00', 'scheduled', 'Emergency appointment', NOW()),
((SELECT id FROM patients WHERE email = 'nicole.walker@email.com'), (SELECT id FROM services WHERE name = 'Wisdom Tooth Extraction'), CURRENT_DATE + INTERVAL '3 days', '15:00', 'scheduled', 'Wisdom tooth removal', NOW() - INTERVAL '1 week'),
((SELECT id FROM patients WHERE email = 'matthew.hall@email.com'), (SELECT id FROM services WHERE name = 'Dental Crown'), CURRENT_DATE + INTERVAL '4 days', '09:30', 'scheduled', 'Crown placement', NOW() - INTERVAL '2 weeks'),
((SELECT id FROM patients WHERE email = 'stephanie.allen@email.com'), (SELECT id FROM services WHERE name = 'Dental Consultation'), CURRENT_DATE + INTERVAL '4 days', '13:30', 'scheduled', 'New patient consultation', NOW() - INTERVAL '2 days'),
((SELECT id FROM patients WHERE email = 'ryan.young@email.com'), (SELECT id FROM services WHERE name = 'Periodontal Cleaning'), CURRENT_DATE + INTERVAL '5 days', '11:00', 'scheduled', 'Gum disease treatment', NOW() - INTERVAL '1 week'),

-- Additional appointments to reach 23 total
((SELECT id FROM patients WHERE email = 'maria.rodriguez@email.com'), (SELECT id FROM services WHERE name = 'Dental Consultation'), CURRENT_DATE + INTERVAL '5 days', '14:00', 'scheduled', 'Follow-up visit', NOW() - INTERVAL '3 days'),
((SELECT id FROM patients WHERE email = 'john.smith@email.com'), (SELECT id FROM services WHERE name = 'Dental Cleaning'), CURRENT_DATE + INTERVAL '6 days', '10:00', 'scheduled', 'Post-surgery cleaning', NOW() - INTERVAL '4 days'),
((SELECT id FROM patients WHERE email = 'sarah.johnson@email.com'), (SELECT id FROM services WHERE name = 'Teeth Whitening'), CURRENT_DATE + INTERVAL '6 days', '15:00', 'scheduled', 'Touch-up whitening', NOW() - INTERVAL '5 days');

SELECT 'Services and appointments data loaded successfully!' AS result;