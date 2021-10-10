USE Courses
GO

--TEST COUNTRY CRUD
EXEC spSelectCountry 'ARG'
EXEC spInsertCountryWithTransaction 'CPV','Cabo Verde'
EXEC spUpdateCountryNameWithTransaction 'CPV','Cabo Rojo'
EXEC spDeleteCountryWithTransaction 'CPV'
GO

--TEST STUDENT CRUD
EXEC spSelectStudent 5
EXEC spInsertStudentWithTransaction 'Genaro','Gonzalez','6143068687','gena@xprueba.com',37,'M','MEX'
EXEC spUpdateStudentWithTransaction 28,'Genaro','Martinez','6143068687','gena@xprueba.com',38,'M','MEX'
EXEC spDeleteStudentWithTransaction 28
GO

--TEST ENROLMENT
EXEC spSelectEnrolment 5
EXEC spInsertEnrolmentWithTransaction 27
EXEC spUpdateEnrolmentWithTransaction 27, '2021-11-15'
EXEC spDeleteEnrolmentWithTransaction 27
GO

--TEST CRUD COURSE_ENROLMENT
EXEC spSelectCourseEnrolment 5
EXEC spInsertCourseEnrolmentWithTransaction 4,4
EXEC spUpdateCourseEnrolmentWithTransaction 1,7,9
EXEC spDeleteCourseEnrolmentWithTransaction 1,4
GO

--TEST CRUD DEPARTMENT
EXEC spSelectCountry 1
EXEC spInsertDepartmentWithTransaction 'Psicology'
EXEC spUpdateDepartmentWithTransaction 9,'Music'
EXEC spDeleteDepartmentWithTransaction 9
GO

--TEST CRUD LANGUAGE
EXEC spSelectLanguage 'DEU'
EXEC spInsertLanguageWithTransaction 'TOT','Totonaca'
EXEC spUpdateLanguageWithTransaction 'TOT','Taran'
EXEC spDeleteLanguageWithTransaction 'TOT'
GO


--TEST CATEGORY
EXEC spSelectCategory 1
EXEC spInsertCategoryWithTransaction 'Music'
EXEC spUpdateCategoryNameWithTransaction 30,'Teachings & Academics'
EXEC spDeleteCategoryWithTransaction 30
GO

--TEST INSTRUCTOR
EXEC spSelectInstructor 5
EXEC spInsertInstructorWithTransaction 'Mario','Moran',null,'mayo@xprueba.com',4
EXEC spUpdateInstructorWithTransaction 21,'Juan','Moran',null,'mayo@xprueba.com',4
EXEC spDeleteInstructorWithTransaction 21
GO

--TEST COURSE
EXEC spSelectCourse 5
EXEC spInsertCourseWithTransaction 'Learn and Understand NodeJS',50,'NODE01',200.00,1,'ENG',19
EXEC spUpdateCourseWithTransaction 20,'Node JS: Advanced Concepts',60,'NODE02','200.00',2,'ESP',20
EXEC spDeleteCourseWithTransaction 20
GO











