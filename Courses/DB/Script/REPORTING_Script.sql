SELECT * FROM dbo.Category
SELECT * FROM dbo.Language
SELECT * FROM dbo.Department
SELECT * FROM dbo.Country
SELECT * FROM dbo.Student
SELECT * FROM dbo.Instructor
SELECT * FROM dbo.Enrolment
SELECT * FROM dbo.Course
SELECT * FROM dbo.CourseEnrolment



UPDATE dbo.CourseEnrolment SET CourseID = 2 WHERE EnrolmentID = 1
UPDATE dbo.Student SET LastName = 'x' WHERE LastName = 'Morán' OR LastName = 'Avilés'
UPDATE dbo.Student SET LastName = 'Morán' WHERE LastName = 'x' AND FirstName = 'Guillermo'
UPDATE dbo.Student SET LastName = 'Morán' WHERE LastName IN('x','Lopez') 
UPDATE dbo.Student SET Age = 100 WHERE Age < 19
UPDATE dbo.Student SET Age = 18 WHERE Age > 70
UPDATE dbo.Course SET Price = 127.00 WHERE Price <> 127.00


-------------------------- ORDER BY ---------------------------------------------

SELECT FirstName, LastName, Age 
FROM Student
ORDER BY Age ASC

GO

SELECT FirstName, LastName, Age, CountryName 
FROM Student S
JOIN Country O
ON S.CountryID = O.CountryID
ORDER BY Age ASC

GO

SELECT CourseName, Credits
FROM Course
ORDER BY Credits DESC


GO 
-- JOIN - Mostrar los cursos y los alumnos que estan inscritos a él
SELECT CourseName, FirstName, LastName, Age
FROM Course C
JOIN CourseEnrolment CE 
ON C.CourseID = CE.CourseID
JOIN Enrolment E
ON CE.EnrolmentID = E.EnrolmentID
JOIN Student S
ON E.StudentID = S.StudentID
ORDER BY CourseName ASC


-- JOIN - Mostrar alumnos y el pais del que provienen
GO

SELECT FirstName, LastName, Age, CountryName 
FROM Student S
JOIN Country O
ON S.CountryID = O.CountryID
ORDER BY CountryName ASC


----------------- DISTINCT --------------------------------
GO

SELECT DISTINCT CountryName
FROM Country


GO

SELECT DISTINCT Age
FROM Student

GO

------------------- WHERE IS NULL ------------------------
SELECT FirstName, LastName
FROM Instructor
WHERE Photo IS NULL

---------------------- BETWEEN ---------------------------------

GO

SELECT FirstName, LastName, Age, CountryName 
FROM Student S
JOIN Country O
ON S.CountryID = O.CountryID
WHERE Age 
BETWEEN 30 AND 40
ORDER BY Age

GO

SELECT CourseName, Credits
FROM Course
WHERE Credits
BETWEEN 15 AND 30

GO
-- JOIN - Mostrar alumnos y su fecha de inscripcion
SELECT FirstName, LastName, Age, Gender, EnrolmentDate
FROM Student S
JOIN Enrolment E
ON S.StudentID = E.StudentID
WHERE E.EnrolmentDate
BETWEEN '2020-01-01' AND '2020-12-31'
ORDER BY EnrolmentDate


---------------- LIKE ----------------------------
GO

SELECT FirstName, LastName, PhoneNumber
FROM Student
WHERE PhoneNumber 
LIKE '322%'

GO

SELECT CountryName
FROM Country
WHERE CountryName 
LIKE '%ay'

GO

SELECT CourseName
FROM Course
WHERE CourseName
LIKE '%Data%'

SELECT CourseName
FROM Course
WHERE CourseName
LIKE '%#%'

SELECT FirstName, LastName
FROM Student
WHERE FirstName 
LIKE 'S%'
OR LastName
LIKE 'S%'

GO

SELECT COUNT(*) 
FROM Student

------------------ INSERT INTO -----------------------------------------------

GO

INSERT INTO Student 
SELECT FirstName, LastName, PhoneNumber, Age, Gender, CountryID
FROM Student

GO

SELECT COUNT(*) 
FROM Student

----------------------------- GROUP BY ------------------------------
GO

SELECT AVG(Age) AS "Age Average"
FROM Student

GO

SELECT AVG(Credits) AS "Credits Average"
FROM Course


-- JOIN - Mostrar el tipo de curso y el promedio de edad de alumnos inscritos a él
GO

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

SELECT COUNT(Age) AS "Students of 18"
FROM Student
WHERE Age = 18


-- JOIN - Mostrar la ganacia por tipo de curso
GO

SELECT CourseName, SUM(Price)  AS "Profit by Course"
FROM Course C
JOIN CourseEnrolment CE
ON C.CourseID = CE.CourseID
GROUP BY CourseName

GO

SELECT  MAX(Age)
FROM Student

GO

SELECT  MIN(Age)
FROM Student

GO

SELECT COUNT(EnrolmentID) AS "New Enrolments"
FROM Enrolment
WHERE EnrolmentDate
BETWEEN '2020-01-01' 
AND '2020-12-31'


-- RIGHT JOIN - Mostrar los paises de donde ningun alumno se ha inscrito
GO
SELECT *
FROM Student S
RIGHT JOIN Country C
ON S.CountryID = C.CountryID
ORDER BY C.CountryName

--LEFT JOIN - Mostrar los cursos que no tienen alumnos inscritos
GO
SELECT C.CourseName, CE.EnrolmentID
FROM Course C
LEFT JOIN CourseEnrolment CE
ON C.CourseID = CE.CourseID












