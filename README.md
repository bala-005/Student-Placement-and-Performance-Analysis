# Student Placement & Performance Analysis Using MySQL

## Project Overview
This project analyzes student placement trends at Besant Technologies using MySQL. It provides insights into placement success rates, recruiter hiring patterns, test score analysis, certification impact, and dropout trends. The project helps educational institutes, recruiters, and students make data-driven decisions for better career outcomes.

## Technologies Used
- MySQL – Database creation, advanced queries, views, CTEs, and stored procedures

## Project Objectives
- Analyze placement rates per course
- Identify students who completed courses but remain unplaced
- Determine certification impact on placement
- Extract insights on recruiter hiring trends
- Detect dropout rates across different courses

## Database Schema

### Students Table
```sql
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
    Hiring_Company VARCHAR(100) NULL,  
    Salary INT NULL  
);
```

### Hiring Companies Table
```sql
CREATE TABLE Hiring_Companies (
    Company_ID INT PRIMARY KEY,
    Company_Name VARCHAR(100),
    Job_Role VARCHAR(50),
    Total_Hires INT,
    Avg_Salary INT
);
```

## Key SQL Queries & Techniques Used

### Placement Rate per Course
```sql
SELECT Course,
       (SUM(CASE WHEN Placement_Status = 'Placed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS Placement_Rate
FROM Students
GROUP BY Course;
```

### Identifying Unplaced Students Who Completed Their Courses
```sql
CREATE VIEW Unplaced_Completed_Students AS
SELECT Student_ID, Name, Course
FROM Students
WHERE Completion_Status = 'Completed' AND Placement_Status = 'Not Placed';

SELECT * FROM Unplaced_Completed_Students;
```

### Certification Impact on Placement
```sql
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
```

## Key Insights from the Analysis
- Courses with high placement rates include Data Science and Python
- Courses with low placement rates include AWS and Full-Stack Development
- Students with certifications had a higher placement success rate
- Recruiters engaged with students had a higher hiring rate
- Dropout rates were highest in AWS and Full-Stack Development courses

## Challenges Faced & Solutions
- Handling NULL values in placement data by using COALESCE and CASE WHEN
- Ensuring data integrity by applying FOREIGN KEY constraints
- Optimizing query performance using indexes on frequently queried columns

## How to Explain This Project in an Interview

### Project Summary
"I developed an SQL-based student placement analysis system for Besant Technologies. The goal was to evaluate placement trends, recruiter effectiveness, and student performance using structured queries, views, CTEs, and stored procedures. The project provided insights that can help improve student outcomes and recruiter engagement."

### Why This Project is Important
- Helps educational institutes improve student success rates
- Assists placement teams in identifying high-potential students
- Provides data-driven insights to recruiters for better hiring decisions

### Key SQL Concepts Used
- Joins to merge student, recruiter, and placement data
- Subqueries to identify high-performing students without placement
- Views to create a snapshot of students still unplaced
- CTEs to analyze dropout trends and recruiter engagement
- Stored Procedures to automate placement analysis reports

### Challenges & Solutions
- Handling missing values in placement data by using COALESCE and CASE WHEN
- Query optimization for large datasets by implementing indexes
- Data integrity through FOREIGN KEY constraints

### Real-World Impact
- Educational Institutes: Improve student placement strategies
- Recruiters: Identify high-performing students early
- Students: Understand which courses lead to better job opportunities

## How to Add This Project to Your Resume and LinkedIn

### Resume Section
**Student Placement & Performance Analysis Using MySQL**  
Developed an SQL-based student placement analysis system to evaluate recruiter effectiveness, placement success rates, and student performance trends. Utilized advanced SQL queries, views, CTEs, and stored procedures to generate insights that improve hiring outcomes and student success.

### LinkedIn Projects Section
**Student Placement & Performance Analysis Using MySQL**  
- Designed a MySQL database to track student performance, placement trends, and recruiter effectiveness
- Implemented complex queries, views, and stored procedures to analyze placement rates and dropout trends
- Extracted key insights on recruiter hiring patterns and the impact of certifications on job placements

