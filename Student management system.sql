-- DATABASE CREATION
CREATE DATABASE Besant_Management;
USE Besant_Management;

-- STUDENTS TABLE CREATION
CREATE TABLE Students (
    Student_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Course VARCHAR(50),
    Completion_Status VARCHAR(20),  -- ('Completed', 'Not Completed', 'Dropped Out')
    Test_Score INT,  -- (0 to 100)
    Certification VARCHAR(10),  -- ('Yes', 'No')
    Placement_Status VARCHAR(20),  -- ('Placed', 'Not Placed')
    Recruiter_Contacted VARCHAR(10),  -- ('Yes', 'No')
    Hiring_Company VARCHAR(100) null,  -- (Company Name or NULL)
    Salary INT null -- (NULL if Not Placed)
);

select * from students;
select * from hiring_companies;


-- Hiring Companies Table Creation
CREATE TABLE Hiring_Companies (
    Company_ID INT PRIMARY KEY,
    Company_Name VARCHAR(100),
    Job_Role VARCHAR(50),
    Total_Hires INT,
    Avg_Salary INT
);

-- Insert Data into Hiring_Companies
INSERT INTO Hiring_Companies 
VALUES 
(1, 'Infosys', 'Data Analyst', 50, 600000),
(2, 'Zoho', 'Software Developer', 35, 550000),
(3, 'TCS', 'Cloud Engineer', 40, 500000),
(4, 'Accenture', 'Marketing Analyst', 25, 450000),
(5, 'Cognizant', 'Data Scientist', 30, 650000);

-- QUERIES
-- 1.  Placement Rate per Course	
SELECT Course, 
       (SUM(CASE WHEN Placement_Status = 'Placed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS Placement_Rate
FROM Students 
GROUP BY Course;

-- 2. Views for Students Who Completed the Course but Are Still Unplaced
CREATE VIEW Unplaced_Completed_Students AS
SELECT Student_ID, Name, Course FROM Students 
WHERE Completion_Status = 'Completed' AND Placement_Status = 'Not Placed';

SELECT * FROM Unplaced_Completed_Students;

-- 3. Course with the Highest Average Test Score
WITH AvgScores AS (
    SELECT Course, AVG(Test_Score) AS Avg_Test_Score FROM Students GROUP BY Course
)
SELECT * FROM AvgScores ORDER BY Avg_Test_Score DESC LIMIT 1;

-- 4. Companies Hiring More Than 10 Students
SELECT H.Company_Name, H.Job_Role, H.Total_Hires 
FROM Hiring_Companies H
WHERE H.Total_Hires > 10;

-- 5. High-Scoring Students Who Are Still Unplaced
SELECT * FROM Students WHERE Test_Score > 85 AND Placement_Status = 'Not Placed';

-- 6. Stored Procedure for Certification Impact on Placement
DELIMITER //

CREATE PROCEDURE Certification_Impact()
BEGIN
    SELECT Certification, COUNT(*) AS Total_Students,
           SUM(CASE WHEN Placement_Status = 'Placed' THEN 1 ELSE 0 END) AS Placed_Students
    FROM Students
    GROUP BY Certification;
END //

DELIMITER ;

CALL Certification_Impact();

-- 7. Courses with the Most Dropouts
SELECT Course, COUNT(*) AS Dropouts 
FROM Students WHERE Completion_Status = 'Dropped Out' 
GROUP BY Course ORDER BY Dropouts DESC;




