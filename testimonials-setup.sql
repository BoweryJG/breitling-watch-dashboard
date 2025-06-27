-- Insert patient testimonials (20 reviews for 4.8 star average)
INSERT INTO testimonials (patient_id, service_id, rating, comment, is_approved, created_at) VALUES
((SELECT id FROM patients WHERE email = 'maria.rodriguez@email.com'), (SELECT id FROM services WHERE name = 'Dental Cleaning'), 5, 'Excellent service! Dr. Pedro and his team are amazing. Very professional and gentle.', true, NOW() - INTERVAL '1 day'),
((SELECT id FROM patients WHERE email = 'john.smith@email.com'), (SELECT id FROM services WHERE name = 'YOMI Guided Implant Surgery'), 5, 'The YOMI technology is incredible! Precise, painless surgery. Highly recommend!', true, NOW() - INTERVAL '2 days'),
((SELECT id FROM patients WHERE email = 'sarah.johnson@email.com'), (SELECT id FROM services WHERE name = 'Teeth Whitening'), 4, 'Great results with the whitening treatment. Teeth look much brighter!', true, NOW() - INTERVAL '3 days'),
((SELECT id FROM patients WHERE email = 'david.brown@email.com'), (SELECT id FROM services WHERE name = 'YOMI Guided Implant Surgery'), 5, 'Amazing technology! The robot-assisted surgery was so precise. No pain at all.', true, NOW() - INTERVAL '4 days'),
((SELECT id FROM patients WHERE email = 'lisa.garcia@email.com'), (SELECT id FROM services WHERE name = 'Dental Filling'), 5, 'Quick and painless filling. The office is very modern and clean.', true, NOW() - INTERVAL '5 days'),
((SELECT id FROM patients WHERE email = 'michael.wilson@email.com'), (SELECT id FROM services WHERE name = 'Periodontal Cleaning'), 4, 'Thorough cleaning for my gum issues. Staff was very knowledgeable about diabetes care.', true, NOW() - INTERVAL '6 days'),
((SELECT id FROM patients WHERE email = 'jennifer.martinez@email.com'), (SELECT id FROM services WHERE name = 'YOMI Guided Crown Preparation'), 5, 'The YOMI system made crown prep so much easier. Dr. Pedro is a tech pioneer!', true, NOW() - INTERVAL '7 days'),
((SELECT id FROM patients WHERE email = 'robert.anderson@email.com'), (SELECT id FROM services WHERE name = 'Dental Cleaning'), 5, 'Best dental experience I''ve ever had. Very gentle and thorough.', true, NOW() - INTERVAL '1 week'),
((SELECT id FROM patients WHERE email = 'amanda.taylor@email.com'), (SELECT id FROM services WHERE name = 'Root Canal Treatment'), 4, 'Root canal was much less painful than expected. Great technique!', true, NOW() - INTERVAL '1 week 1 day'),
((SELECT id FROM patients WHERE email = 'christopher.thomas@email.com'), (SELECT id FROM services WHERE name = 'Dental Consultation'), 5, 'Very detailed consultation. Dr. Pedro explained everything clearly.', true, NOW() - INTERVAL '1 week 2 days'),
((SELECT id FROM patients WHERE email = 'jessica.hernandez@email.com'), (SELECT id FROM services WHERE name = 'Orthodontic Consultation'), 5, 'Great advice on orthodontic options. Very patient with my questions.', true, NOW() - INTERVAL '1 week 3 days'),
((SELECT id FROM patients WHERE email = 'daniel.moore@email.com'), (SELECT id FROM services WHERE name = 'Dental Cleaning'), 4, 'Good cleaning service. Office is very professional and modern.', true, NOW() - INTERVAL '1 week 4 days'),
((SELECT id FROM patients WHERE email = 'michelle.jackson@email.com'), (SELECT id FROM services WHERE name = 'Dental Filling'), 5, 'Perfect filling work. Tooth feels completely natural now.', true, NOW() - INTERVAL '1 week 5 days'),
((SELECT id FROM patients WHERE email = 'kevin.white@email.com'), (SELECT id FROM services WHERE name = 'Dental Cleaning'), 5, 'Excellent care for diabetic patients. Very understanding of my health needs.', true, NOW() - INTERVAL '1 week 6 days'),
((SELECT id FROM patients WHERE email = 'rachel.lewis@email.com'), (SELECT id FROM services WHERE name = 'Teeth Whitening'), 4, 'Good whitening results. Staff was friendly and professional.', true, NOW() - INTERVAL '2 weeks'),
((SELECT id FROM patients WHERE email = 'thomas.lee@email.com'), (SELECT id FROM services WHERE name = 'Dental Consultation'), 5, 'Very thorough initial exam. Love the high-tech equipment!', true, NOW() - INTERVAL '2 weeks 1 day'),
((SELECT id FROM patients WHERE email = 'nicole.walker@email.com'), (SELECT id FROM services WHERE name = 'Dental Cleaning'), 5, 'Outstanding service! The team made me feel very comfortable.', true, NOW() - INTERVAL '2 weeks 2 days'),
((SELECT id FROM patients WHERE email = 'matthew.hall@email.com'), (SELECT id FROM services WHERE name = 'Periodontal Cleaning'), 4, 'Good deep cleaning for my gum issues. Noticed improvement immediately.', true, NOW() - INTERVAL '2 weeks 3 days'),
((SELECT id FROM patients WHERE email = 'stephanie.allen@email.com'), (SELECT id FROM services WHERE name = 'Dental Consultation'), 5, 'Excellent first visit! Dr. Pedro is very knowledgeable and caring.', true, NOW() - INTERVAL '2 weeks 4 days'),
((SELECT id FROM patients WHERE email = 'ryan.young@email.com'), (SELECT id FROM services WHERE name = 'Dental Filling'), 5, 'Perfect filling work. No sensitivity afterwards. Highly recommend!', true, NOW() - INTERVAL '2 weeks 5 days');

-- Enable real-time subscriptions for all tables
ALTER PUBLICATION supabase_realtime ADD TABLE patients;
ALTER PUBLICATION supabase_realtime ADD TABLE appointments;
ALTER PUBLICATION supabase_realtime ADD TABLE services;
ALTER PUBLICATION supabase_realtime ADD TABLE testimonials;

-- Create a view for quick metrics (optional)
CREATE OR REPLACE VIEW watch_dashboard_metrics AS
SELECT 
    COUNT(*) FILTER (WHERE appointment_date = CURRENT_DATE) AS today_appointments,
    COUNT(*) FILTER (WHERE appointment_date >= CURRENT_DATE AND appointment_date <= CURRENT_DATE + INTERVAL '7 days') AS weekly_upcoming,
    ROUND((COUNT(*) FILTER (WHERE status = 'completed')::NUMERIC / NULLIF(COUNT(*), 0)) * 100, 2) AS completion_rate,
    COUNT(*) FILTER (WHERE status = 'completed' AND appointment_date = CURRENT_DATE) * 250 AS daily_revenue,
    (SELECT COUNT(*) FROM patients) AS total_patients,
    (SELECT COUNT(*) FROM patients WHERE created_at >= DATE_TRUNC('month', CURRENT_DATE)) AS new_patients_this_month,
    (SELECT ROUND(AVG(rating), 1) FROM testimonials WHERE is_approved = true) AS avg_testimonial_rating,
    (SELECT COUNT(*) FROM services WHERE is_yomi_technology = true) AS yomi_services_count
FROM appointments;

-- Success message
SELECT 'Database setup completed successfully! All tables created and populated with realistic sample data for Dr. Pedro''s dental practice.' AS result;