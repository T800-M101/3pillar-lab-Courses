--==========================REPORTING ALL TABLES=================================

--===============================================================================
-- VIEW GET_ALL_STUDENTS
-- Description: Shows a report of all the students
-- Example: SELECT * FROM GET_ALL_STUDENTS
--================================================================================

CREATE OR ALTER VIEW GET_ALL_STUDENTS
AS
SELECT FirstName, 
       LastName, 
	   PhoneNumber,
	   Email,
	   Age,
	   Gender 
FROM Student
GO

--===============================================================================
-- VIEW GET_ALL_STUDENTS_COUNTRY 
-- Description: Shows a report of all the students and their country
-- Example: SELECT * FROM GET_ALL_STUDENTS_COUNTRY
--================================================================================

CREATE OR ALTER VIEW GET_ALL_STUDENTS_COUNTRY
AS
SELECT FirstName, 
       LastName, 
	   PhoneNumber,
	   Email,
	   Age,
	   Gender,  
	   CountryName 
FROM Student S
JOIN Country O
ON S.CountryID = O.CountryID
GO

--===============================================================================
-- VIEW GET_CREDITS_BY_COURSE
-- Description: Shows a report of number of credits by course
-- Example: SELECT * FROM GET_CREDITS_BY_COURSE
--================================================================================

CREATE OR ALTER VIEW GET_CREDITS_BY_COURSE
AS
SELECT CourseName AS 'COURSE', Credits AS 'CREDITS'
FROM   Course
GO 

--===============================================================================
-- VIEW GET_STUDENTS_BY_COURSE
-- Description: Shows a report of students and the course they are enroled
-- Example: SELECT * FROM GET_STUDENTS_BY_COURSE
--================================================================================

CREATE OR ALTER VIEW GET_STUDENTS_BY_COURSE
AS
SELECT CourseName, FirstName, LastName, Age
FROM Course C
JOIN CourseEnrolment CE 
ON C.CourseID = CE.CourseID
JOIN Enrolment E
ON CE.EnrolmentID = E.EnrolmentID
JOIN Student S
ON E.StudentID = S.StudentID
GO

--===============================================================================
-- VIEW GET_COUNT_AGE
-- Description: Shows a report counting ages
-- Example: SELECT * FROM GET_COUNT_AGE
--================================================================================

CREATE OR ALTER VIEW GET_COUNT_AGE
AS
SELECT  Age, COUNT(Age) AS 'TOTAL'
FROM Student
GROUP BY Age
GO

--===============================================================================
-- VIEW GET_INSTRUCTOR_NO_PHOTO
-- Description: Shows a report intructors that haven´t provided a photo
-- Example: SELECT * FROM GET_INSTRUCTOR_NO_PHOTO
--================================================================================

CREATE OR ALTER VIEW GET_INSTRUCTOR_NO_PHOTO
AS
SELECT FirstName, 
       LastName
FROM   Instructor
WHERE Photo IS NULL
GO

--===============================================================================
-- VIEW WITH FUNCTION GET_STUDENTS_BY_AGE_RANGE(@LowerAge int,@UpperAge int)
-- Description: Shows a report of students with their country passing as parameters a range of ages
-- Example: SELECT * FROM GET_STUDENTS_BY_AGE_RANGE(18,20)
--================================================================================

CREATE OR ALTER FUNCTION GET_STUDENTS_BY_AGE_RANGE(@LowerAge int, @UpperAge int)
RETURNS TABLE
AS 
RETURN
   SELECT FirstName, LastName, Age, CountryName 
   FROM Student S
   JOIN Country O
   ON S.CountryID = O.CountryID
   WHERE Age
   BETWEEN @LowerAge AND @UpperAge   
GO

--===============================================================================
-- VIEW WITH FUNCTION GET_COURSES_BY_CREDIT_RANGE(@Credit1,@Credit2)
-- Description: Shows a report of courses within a range of credits
-- Example: SELECT * FROM GET_COURSES_BY_CREDIT_RANGE(15,20)
--================================================================================

CREATE OR ALTER FUNCTION GET_COURSES_BY_CREDIT_RANGE(@Credit1 int, @Credit2 int)
RETURNS TABLE
AS
RETURN
SELECT CourseName, Credits
FROM Course
WHERE Credits
BETWEEN @Credit1 AND @Credit2
GO

--===============================================================================
-- VIEW WITH FUNCTION GET_STUDENTS_ENROLMENT_DATE(@Date1 date, @Date2 date)
-- Description: Shows a report the students with their enrolment date
-- Example: SELECT * FROM GET_STUDENTS_ENROLMENT_DATE('2020-01-01','2020-12-31')
--================================================================================

CREATE OR ALTER FUNCTION GET_STUDENTS_ENROLMENT_DATE(@Date1 date, @Date2 date)
RETURNS TABLE
AS
RETURN
SELECT FirstName, LastName, Age, Gender, EnrolmentDate
FROM Student S
JOIN Enrolment E
ON S.StudentID = E.StudentID
WHERE E.EnrolmentDate
BETWEEN @Date1 AND @Date2
GO

--===============================================================================
-- VIEW GET_PHONE_NUMBER_LIKE_322
-- Description: Shows a report of students whose phone number starts with 322
-- Example: SELECT * FROM GET_PHONE_NUMBER_LIKE_322
--================================================================================

CREATE OR ALTER VIEW GET_PHONE_NUMBER_LIKE_322
AS

SELECT FirstName, LastName, PhoneNumber
FROM Student
WHERE PhoneNumber 
LIKE '322%'
GO

--===============================================================================
-- VIEW WITH FUNCTION GET_PHONE_NUMBER_LIKE(@Code char(3))
-- Description: Shows a report of students whose phone number starts with a particular code
-- Example: SELECT * FROM GET_PHONE_NUMBER_LIKE('322')
--================================================================================

CREATE OR ALTER FUNCTION GET_PHONE_NUMBER_LIKE(@Code char(3))
RETURNS TABLE
AS
RETURN
SELECT FirstName, LastName, PhoneNumber
FROM Student
WHERE PhoneNumber 
LIKE '%'+@Code+'%'
GO

--===============================================================================
-- VIEW GET_COURSE_LIKE_DATA
-- Description: Shows a report of courses whose name contains 'data'
-- Example: SELECT * FROM GET_COURSE_LIKE_DATA
--================================================================================

CREATE OR ALTER VIEW GET_COURSE_LIKE_DATA
AS
SELECT CourseName
FROM Course
WHERE CourseName
LIKE '%Data%'
GO

--===============================================================================
-- VIEW GET_TOTAL_STUDENTS_IN_SYSTEM
-- Description: Shows a report of total of students in the system
-- Example: SELECT * FROM GET_TOTAL_STUDENTS_IN_SYSTEM
--================================================================================

CREATE OR ALTER VIEW GET_TOTAL_STUDENTS_IN_SYSTEM
AS
SELECT COUNT(*) AS 'TOTAL STUDENTS IN THE SYSTEM'
FROM Student
GO

--===============================================================================
-- VIEW GET_AVERAGE_AGE_OF_STUDENTS
-- Description: Shows a report of average age of students
-- Example: SELECT * FROM GET_AVERAGE_AGE_OF_STUDENTS
--================================================================================

CREATE OR ALTER VIEW GET_AVERAGE_AGE_OF_STUDENTS
AS
SELECT AVG(Age) AS "Age Average"
FROM Student
GO

--===============================================================================
-- VIEW GET_COURSE_AVERAGE_AGE
-- Description: Shows a report of the courses and the average age of students enroled at it. 
-- Example: SELECT * FROM GET_COURSE_AVERAGE_AGE
--================================================================================

CREATE OR ALTER VIEW GET_COURSE_AVERAGE_AGE
AS
SELECT CourseName, AVG(Age) AS "Age Average by Course"
FROM Course C 
JOIN CourseEnrolment CE
ON C.CourseID = CE.CourseID
JOIN Enrolment E
ON CE.EnrolmentID = E.EnrolmentID
JOIN Student S
ON E.StudentID = S.StudentID
GROUP BY CourseName
GO

--===============================================================================
-- VIEW GET_STUDENTS_OF_18
-- Description: Shows a report of 18 years old students. 
-- Example: SELECT * FROM GET_STUDENTS_OF_18
--================================================================================

CREATE OR ALTER VIEW GET_STUDENTS_OF_18
AS
SELECT COUNT(Age) AS "Students of 18"
FROM Student
WHERE Age = 18
GO

--===============================================================================
-- VIEW GET_PROFIT_BY_COURSE
-- Description: Shows a report of profut by course 
-- Example: SELECT * FROM GET_PROFIT_BY_COURSE
--================================================================================

CREATE OR ALTER VIEW GET_PROFIT_BY_COURSE
AS
SELECT CourseName, SUM(Price)  AS "Profit by Course"
FROM Course C
JOIN CourseEnrolment CE
ON C.CourseID = CE.CourseID
GROUP BY CourseName
GO

--===============================================================================
-- VIEW GET_OLDEST_STUDENT
-- Description: Shows a report of the oldest student 
-- Example: SELECT * FROM GET_OLDEST_STUDENT
--================================================================================

CREATE OR ALTER VIEW GET_OLDEST_STUDENT
AS
SELECT  MAX(Age) AS 'OLDEST STUDENT'
FROM Student
GO

--===============================================================================
-- VIEW WITH FUNCTION GET_NEW_ENROLMENTS(@Date1 date, @Date2 date)
-- Description: Shows a report of new enrolments within a date range
-- Example: SELECT * FROM GET_NEW_ENROLMENTS('2020-01-01', '2020-12-31')
--================================================================================

CREATE OR ALTER FUNCTION GET_NEW_ENROLMENTS(@Date1 date, @Date2 date)
RETURNS TABLE
AS
RETURN
SELECT COUNT(EnrolmentID) AS 'TOTAL OF NEW ENROLMENTS'
FROM Enrolment
WHERE EnrolmentDate
BETWEEN @Date1 
AND @Date2
GO

--===============================================================================
-- VIEW GET_COUNTRIES_WITH_NO_STUDENT
-- Description: Shows a report of countries with no students enroled
-- Example: SELECT * FROM GET_COUNTRIES_WITH_NO_STUDENT
--================================================================================

CREATE OR ALTER VIEW GET_COUNTRIES_WITH_NO_STUDENT
AS
SELECT S.FirstName, S.LastName,C.CountryName
FROM Student S
RIGHT JOIN Country C
ON S.CountryID = C.CountryID
GO

--===============================================================================
-- VIEW GET_COURSES_WITH_NO_ENROLMENTS
-- Description: Shows a report of courses with no enrolments
-- Example: SELECT * FROM GET_COURSES_WITH_NO_ENROLMENTS
--================================================================================

CREATE OR ALTER VIEW GET_COURSES_WITH_NO_ENROLMENTS
AS
SELECT C.CourseName, CE.EnrolmentID
FROM Course C
LEFT JOIN CourseEnrolment CE
ON C.CourseID = CE.CourseID
GO






