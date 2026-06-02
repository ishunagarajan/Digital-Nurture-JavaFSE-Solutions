CREATE DATABASE testdb;
USE testdb;
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(100) NOT NULL,
    registration_date DATE NOT NULL
);
CREATE TABLE Events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    city VARCHAR(100) NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    status ENUM('upcoming','completed','cancelled'),
    organizer_id INT,
    FOREIGN KEY (organizer_id) REFERENCES Users(user_id)
);
CREATE TABLE Sessions (
    session_id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT,
    title VARCHAR(200) NOT NULL,
    speaker_name VARCHAR(100) NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);
CREATE TABLE Registrations (
    registration_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_id INT,
    registration_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);
CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comments TEXT,
    feedback_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);
CREATE TABLE Resources (
    resource_id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT,
    resource_type ENUM('pdf','image','link'),
    resource_url VARCHAR(255) NOT NULL,
    uploaded_at DATETIME NOT NULL,
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);
INSERT INTO Users(full_name,email,city,registration_date)
VALUES
('Alice Johnson','alice@example.com','New York','2024-12-01'),
('Bob Smith','bob@example.com','Los Angeles','2024-12-05'),
('Charlie Lee','charlie@example.com','Chicago','2024-12-10'),
('Diana King','diana@example.com','New York','2025-01-15'),
('Ethan Hunt','ethan@example.com','Los Angeles','2025-02-01');
INSERT INTO Events
(title,description,city,start_date,end_date,status,organizer_id)
VALUES
('Tech Innovators Meetup',
'A meetup for tech enthusiasts.',
'New York',
'2025-06-10 10:00:00',
'2025-06-10 16:00:00',
'upcoming',
1),

('AI & ML Conference',
'Conference on AI and ML advancements.',
'Chicago',
'2025-05-15 09:00:00',
'2025-05-15 17:00:00',
'completed',
3),

('Frontend Development Bootcamp',
'Hands-on training on frontend tech.',
'Los Angeles',
'2025-07-01 10:00:00',
'2025-07-03 16:00:00',
'upcoming',
2);
INSERT INTO Sessions
(event_id,title,speaker_name,start_time,end_time)
VALUES
(1,'Opening Keynote','Dr. Tech',
'2025-06-10 10:00:00',
'2025-06-10 11:00:00'),

(1,'Future of Web Dev','Alice Johnson',
'2025-06-10 11:15:00',
'2025-06-10 12:30:00'),

(2,'AI in Healthcare','Charlie Lee',
'2025-05-15 09:30:00',
'2025-05-15 11:00:00'),

(3,'Intro to HTML5','Bob Smith',
'2025-07-01 10:00:00',
'2025-07-01 12:00:00');
INSERT INTO Registrations(user_id,event_id,registration_date)
VALUES
(1,1,'2025-05-01'),
(2,1,'2025-05-02'),
(3,2,'2025-04-30'),
(4,2,'2025-04-28'),
(5,3,'2025-06-15');
INSERT INTO Feedback
(user_id,event_id,rating,comments,feedback_date)
VALUES
(3,2,4,'Great insights!','2025-05-16'),
(4,2,5,'Very informative.','2025-05-16'),
(2,1,3,'Could be better.','2025-06-11');
INSERT INTO Resources
(event_id,resource_type,resource_url,uploaded_at)
VALUES
(1,'pdf',
'https://portal.com/resources/tech_meetup_agenda.pdf',
'2025-05-01 10:00:00'),

(2,'image',
'https://portal.com/resources/ai_poster.jpg',
'2025-04-20 09:00:00'),

(3,'link',
'https://portal.com/resources/html5_docs',
'2025-06-25 15:00:00');
## 1.user
SELECT u.full_name,
       e.title,
       e.city,
       e.start_date
FROM Users u
JOIN Registrations r
ON u.user_id = r.user_id
JOIN Events e
ON r.event_id = e.event_id
WHERE e.status = 'upcoming'
AND u.city = e.city
ORDER BY e.start_date;
##2.TOP 
SELECT event_id,
       AVG(rating) AS avg_rating
FROM Feedback
GROUP BY event_id
HAVING COUNT(*) >= 10
ORDER BY avg_rating DESC;
## 3.Inactive users
SELECT u.*
FROM Users u
WHERE u.user_id NOT IN (
    SELECT DISTINCT r.user_id
    FROM Registrations r
    WHERE r.registration_date >= DATE_SUB(CURDATE(), INTERVAL 90 DAY)
);
##4.Count of Session
SELECT event_id,
       COUNT(*) AS session_count
FROM Sessions
WHERE HOUR(start_time) BETWEEN 10 AND 11
GROUP BY event_id; 
##5.Active cities
SELECT u.city,
       COUNT(DISTINCT r.user_id) AS user_count
FROM Users u
JOIN Registrations r ON u.user_id = r.user_id
GROUP BY u.city
ORDER BY user_count DESC
LIMIT 5; 
##6. Low Feedback Alerts (< 3 rating)
SELECT u.full_name,
       f.comments,
       e.event_id
FROM Feedback f
JOIN Users u ON f.user_id = u.user_id
JOIN Events e ON f.event_id = e.event_id
WHERE f.rating < 3;
##7.upcoming event
SELECT e.event_id,
       e.title,
       COUNT(s.session_id) AS session_count
FROM Events e
LEFT JOIN Sessions s ON e.event_id = s.event_id
WHERE e.status = 'upcoming'
GROUP BY e.event_id, e.title;
##8.event summary
SELECT organizer_id,
       status,
       COUNT(*) AS total_events
FROM Events
GROUP BY organizer_id, status;
##9.Feedback gap
SELECT DISTINCT e.event_id
FROM Events e
JOIN Registrations r ON e.event_id = r.event_id
LEFT JOIN Feedback f 
    ON e.event_id = f.event_id
WHERE f.event_id IS NULL;
##10.Daily New User Count
SELECT DATE(registration_date) AS reg_date,
       COUNT(*) AS total_users
FROM Users
WHERE registration_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
GROUP BY DATE(registration_date); 
##11.Event with Maximum Sessions 
SELECT event_id
FROM Sessions
GROUP BY event_id
ORDER BY COUNT(*) DESC;
##12.Average Rating per City
SELECT e.city,
       AVG(f.rating) AS avg_rating
FROM Events e
JOIN Feedback f ON e.event_id = f.event_id
GROUP BY e.city;
##13.Most Registered Events (top 3)
SELECT event_id,
       COUNT(user_id) AS total_registrations
FROM Registrations
GROUP BY event_id
ORDER BY total_registrations DESC
LIMIT 3;
##14.Session Time Conflict
SELECT s1.event_id
FROM Sessions s1
JOIN Sessions s2 
  ON s1.event_id = s2.event_id
 AND s1.session_id <> s2.session_id
WHERE s1.start_time < s2.end_time
  AND s1.end_time > s2.start_time;
##15.Unregistered Active Users 
SELECT u.*
FROM Users u
WHERE u.registration_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
AND u.user_id NOT IN (
    SELECT user_id FROM Registrations
);
##16.Multi-Session Speaker 
SELECT speaker_name,
       COUNT(*) AS session_count
FROM Sessions
GROUP BY speaker_name
HAVING COUNT(*) > 1;
##17.Resource Availability Check
SELECT e.title, e.event_id
FROM Events e
LEFT JOIN Resources r ON e.event_id = r.event_id
WHERE r.event_id IS NULL;
##18.Completed Events Feedback Summary
SELECT e.event_id,
       COUNT(r.registration_id) AS total_registrations,
       AVG(f.rating) AS avg_rating
FROM Events e
LEFT JOIN Registrations r ON e.event_id = r.event_id
LEFT JOIN Feedback f ON e.event_id = f.event_id
WHERE e.status = 'completed'
GROUP BY e.event_id; 
##19.User Engagement Index
SELECT u.user_id,
       COUNT(DISTINCT r.event_id) AS events_attended,
       COUNT(f.feedback_id) AS feedbacks_submitted
FROM Users u
LEFT JOIN Registrations r ON u.user_id = r.user_id
LEFT JOIN Feedback f ON u.user_id = f.user_id
GROUP BY u.user_id;
##20.Top Feedback Providers
SELECT user_id,
       COUNT(*) AS feedback_count
FROM Feedback
GROUP BY user_id
ORDER BY feedback_count DESC
LIMIT 5;
##21.Duplicate Registrations Check 
SELECT user_id,
       event_id,
       COUNT(*) AS times_registered
FROM Registrations
GROUP BY user_id, event_id
HAVING COUNT(*) > 1;
##22.Registration Trends
SELECT DATE_FORMAT(registration_date, '%Y-%m') AS month,
       COUNT(*) AS total_registrations
FROM Registrations
WHERE registration_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
GROUP BY DATE_FORMAT(registration_date, '%Y-%m');
##23.Average Session Duration per Event
SELECT event_id,
       AVG(TIMESTAMPDIFF(MINUTE, start_time, end_time)) AS avg_duration
FROM Sessions
GROUP BY event_id;
##24.
SELECT e.event_id, e.title
FROM Events e
LEFT JOIN Sessions s ON e.event_id = s.event_id
WHERE s.session_id IS NULL;
##25.
SELECT e.event_id,
       e.title
FROM Events e
LEFT JOIN Sessions s
    ON e.event_id = s.event_id
WHERE s.session_id IS NULL;