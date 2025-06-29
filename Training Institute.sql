
CREATE DATABASE Training Institute:

USE Training Institute:

CREATE TABLE Trainee (
    trainee_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    email VARCHAR(100) UNIQUE,
    background VARCHAR(100)
);

-- Create Trainer Table
CREATE TABLE Trainer (
    trainer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE
);

-- Create Course Table
CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    title VARCHAR(150) NOT NULL UNIQUE,
    category VARCHAR(50),
    duration_hours INT,
    level VARCHAR(20)
);

-- Create Schedule Table
CREATE TABLE Schedule (
    schedule_id INT PRIMARY KEY,
    course_id INT,
    trainer_id INT,
    start_date DATE,
    end_date DATE,
    time_slot VARCHAR(50),
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (trainer_id) REFERENCES Trainer(trainer_id)
);

-- Create Enrollment Table
CREATE TABLE Enrollment (
    enrollment_id INT PRIMARY KEY,
    trainee_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (trainee_id) REFERENCES Trainee(trainee_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

-- Insert data into Trainee table
INSERT INTO Trainee (trainee_id, name, gender, email, background) VALUES
(1, 'Aisha Al-Harthy', 'Female', 'aisha@example.com', 'Engineering'),
(2, 'Sultan Al-Farsi', 'Male', 'sultan@example.com', 'Business'),
(3, 'Mariam Al-Saadi', 'Female', 'mariam@example.com', 'Marketing'),
(4, 'Omar Al-Balushi', 'Male', 'omar@example.com', 'Computer Science'),
(5, 'Fatma Al-Hinai', 'Female', 'fatma@example.com', 'Data Science');

SELECT * FROM Trainee

-- Insert data into Trainer table
INSERT INTO Trainer (trainer_id, name, specialty, phone, email) VALUES
(1, 'Khalid Al-Maawali', 'Databases', '96891234567', 'khalid@example.com'),
(2, 'Noura Al-Kindi', 'Web Development', '96892345678', 'noura@example.com'),
(3, 'Salim Al-Harthy', 'Data Science', '96893456789', 'salim@example.com');

SELECT * FROM Trainer

-- Insert data into Course table
INSERT INTO Course (course_id, title, category, duration_hours, level) VALUES
(1, 'Database Fundamentals', 'Databases', 20, 'Beginner'),
(2, 'Web Development Basics', 'Web', 30, 'Beginner'),
(3, 'Data Science Introduction', 'Data Science', 25, 'Intermediate'),
(4, 'Advanced SQL Queries', 'Databases', 15, 'Advanced');

SELECT * FROM Course

-- Insert data into Schedule table
INSERT INTO Schedule (schedule_id, course_id, trainer_id, start_date, end_date, time_slot) VALUES
(1, 1, 1, '2025-07-01', '2025-07-10', 'Morning'),
(2, 2, 2, '2025-07-05', '2025-07-20', 'Evening'),
(3, 3, 3, '2025-07-10', '2025-07-25', 'Weekend'),
(4, 4, 1, '2025-07-15', '2025-07-22', 'Morning');

SELECT * FROM Schedule

-- Insert data into Enrollment table
INSERT INTO Enrollment (enrollment_id, trainee_id, course_id, enrollment_date) VALUES
(1, 1, 1, '2025-06-01'),
(2, 2, 1, '2025-06-02'),
(3, 3, 2, '2025-06-03'),
(4, 4, 3, '2025-06-04'),
(5, 5, 3, '2025-06-05'),
(6, 1, 4, '2025-06-06');

SELECT * FROM Enrollment

--Trainee Perspective 
--1.Show all available courses (title, level, category) 
SELECT title,level,category
FROM Course;

--Challenge 2: View beginner-level Data Science courses
SELECT title, level, category FROM Course
WHERE level = 'Beginner' AND category = 'Data Science';

--Challenge 3: Show courses this trainee is enrolled in
SELECT c.title FROM Trainee AS t JOIN Enrollment AS e ON t.trainee_id = e.trainee_id
JOIN Course AS c ON e.course_id = c.course_id
WHERE t.trainee_id = 1; -- Filter for Aisha Al-Harthy's ID

--Challenge 4: View the schedule (start_date, time_slot) for the trainee's enrolled courses
SELECT c.title, s.start_date, s.time_slot FROM Enrollment AS e
JOIN Course AS c ON e.course_id = c.course_id
JOIN Schedule AS s ON c.course_id = s.course_id WHERE e.trainee_id = 1;

--Challenge 5: Count how many courses the trainee is enrolled in
SELECT COUNT(course_id) AS courses_enrolled_count
FROM Enrollment WHERE trainee_id = 1;

--Challenge 6: Show course titles, trainer names, and time slots the trainee is attending
SELECT c.title AS course_title,tr.name AS trainer_name, s.time_slot
FROM Enrollment AS e
JOIN Course AS c ON e.course_id = c.course_id
JOIN Schedule AS s ON c.course_id = s.course_id
JOIN Trainer AS tr ON s.trainer_id = tr.trainer_id WHERE e.trainee_id = 1;

--Trainer Perspective
--Challenge 1: List all courses the trainer is assigned to
SELECT c.title FROM Schedule AS s JOIN Course AS c ON s.course_id = c.course_id
WHERE s.trainer_id = 1;

--Challenge 2: Show upcoming sessions (with dates and time slots)
SELECT c.title, s.start_date,s.end_date, s.time_slot FROM Schedule AS s JOIN Course AS c ON s.course_id = c.course_id
WHERE s.trainer_id = 1 AND s.start_date >= '2025-06-29' ORDER BY s.start_date;

--Challenge 3: See how many trainees are enrolled in each of your courses
SELECT c.title, COUNT(e.trainee_id) AS trainee_count
FROM Schedule AS s JOIN Course AS c ON s.course_id = c.course_id
JOIN Enrollment AS e ON c.course_id = e.course_id WHERE s.trainer_id = 1 GROUP BY c.title;

--Challenge 4: List names and emails of trainees in each of your courses
SELECT c.title AS course_title, t.name AS trainee_name, t.email
FROM Schedule AS s JOIN Enrollment AS e ON s.course_id = e.course_id
JOIN Trainee AS t ON e.trainee_id = t.trainee_id JOIN Course AS c ON s.course_id = c.course_id
WHERE s.trainer_id = 1 ORDER BY c.title, t.name;

--Challenge 5: Show the trainer's contact info and assigned courses
SELECT tr.name, tr.phone,tr.email, c.title AS assigned_course
FROM Trainer AS tr JOIN Schedule AS s ON tr.trainer_id = s.trainer_id
JOIN Course AS c ON s.course_id = c.course_id WHERE tr.trainer_id = 1;

--Challenge 6: Count the number of courses the trainer teaches
SELECT COUNT(DISTINCT course_id) AS number_of_courses
FROM Schedule WHERE trainer_id = 1;

--Admin Perspective
--Challenge 1: Add a new course (INSERT statement)
INSERT INTO Course (course_id, title, category, duration_hours, level)
VALUES (5, 'Networking', 'IT ', 25, 'Beginner');

--Challenge 2: Create a new schedule for a trainer
INSERT INTO Schedule (schedule_id, course_id, trainer_id, start_date, end_date, time_slot)
VALUES (5, 5, 3, '2025-07-01', '2025-07-30', 'Evening');

--Challenge 3: View all trainee enrollments with course title and schedule info
SELECT t.name AS trainee_name,c.title AS course_title, s.start_date, s.time_slot
FROM Enrollment AS e JOIN Trainee AS t ON e.trainee_id = t.trainee_id
JOIN Course AS c ON e.course_id = c.course_id JOIN Schedule AS s ON c.course_id = s.course_id
ORDER BY s.start_date;

--Challenge 4: Show how many courses each trainer is assigned to
SELECT tr.name AS trainer_name,COUNT(s.course_id) AS total_courses
FROM Schedule AS s JOIN Trainer AS tr ON s.trainer_id = tr.trainer_id
GROUP BY tr.name ORDER BY total_courses DESC;

--Challenge 5: List all trainees enrolled in "Data Basics"

SELECT t.name, t.email
FROM Trainee AS t
JOIN Enrollment AS e ON t.trainee_id = e.trainee_id
JOIN Course AS c ON e.course_id = c.course_id
WHERE c.title = 'Networking';

--Challenge 6: Identify the course with the highest number of enrollments
SELECT TOP 1 c.title, COUNT(e.trainee_id) AS enrollment_count
FROM Enrollment AS e
JOIN Course AS c ON e.course_id = c.course_id
GROUP BY c.title ORDER BY enrollment_count DESC;

--Challenge 7: Display all schedules sorted by start date
SELECT s.schedule_id, c.title AS course_title, s.start_date,s.time_slot
FROM Schedule AS s
JOIN Course AS c ON s.course_id = c.course_id
ORDER BY s.start_date ASC;
