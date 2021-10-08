USE master

GO

DROP DATABASE IF EXISTS Courses

GO

CREATE DATABASE Courses

GO

USE Courses

GO
 

--CREATE TABLE Country
--(
--	CountryID char(3),
--	CountryName varchar(50) not null,
--	PRIMARY KEY(CountryID)
--)


--GO
--CREATE TABLE Language
--(
--	LanguageID char(3),
--	Language varchar(20) not null,
--	PRIMARY KEY(LanguageID)
--)


--GO

--CREATE TABLE Department
--(
--	DepartmentID int IDENTITY(1,1),
--	DepartmentName varchar(50) not null
--	PRIMARY KEY(DepartmentID)
--)

--GO

--CREATE TABLE Instructor
--(
--	InstructorID int IDENTITY(1,1),
--	FirstName varchar(30) not null,
--	LastName varchar(30) not null,
--	Photo varchar(100),
--  Email varchar(50) not null,
--	DepartmentID int,
--	PRIMARY KEY(InstructorID),
--	FOREIGN KEY(DepartmentID) references Department(DepartmentID) 

--)

--GO

--CREATE TABLE Category
--(
--	CategoryID int IDENTITY(1,1),
--	CategoryName varchar(50) not null,
--	PRIMARY KEY(CategoryID)

--)

--GO

--CREATE TABLE Course
--(
--	CourseID int IDENTITY(1,1),
--	CourseName varchar(100) not null,
--	Credits int not null,
--	CourseCode varchar(10) not null,
--	Price decimal(19,4) not null,
--	CategoryID int,
--  LanguageID char(3) not null,
--	InstructorID int,
--	PRIMARY KEY(CourseID),
--	FOREIGN KEY(InstructorID) references Instructor(InstructorID),
--	FOREIGN KEY(CategoryID) references Category(CategoryID),
--	FOREIGN KEY(LanguageID) references Language(LanguageID),

--)


--GO


--CREATE TABLE Student
--(
--	StudentID int IDENTITY(1,1),
--	FirstName varchar(30) not null,
--	LastName varchar(30) not null,
--	PhoneNumber varchar(15) not null,
--  Email varchar(50) not null,
--	Age tinyint not null,
--	Gender char(1),
--	CountryID char(3),
--	PRIMARY KEY(StudentID),
--	FOREIGN KEY(CountryID) references Country(CountryID)

--)



--GO

--CREATE TABLE Enrolment
--(
--	EnrolmentID int IDENTITY(1,1),
--	EnrolmentDate DATE not null,
--	StudentID int,
--	PRIMARY KEY(EnrolmentID),
--	FOREIGN KEY(StudentID) references Student(StudentID) 

--)

--GO

--CREATE TABLE CourseEnrolment
--(
--	EnrolmentID int,
--	CourseID int,
--	FOREIGN KEY(EnrolmentID) references Enrolment(EnrolmentID),
--	FOREIGN KEY(CourseID) references Course(CourseID)


--)


select * from Course
