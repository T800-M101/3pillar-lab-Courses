--==============STORED PROCEDURES FOR ALL TABLES===========================
USE Courses
GO

CREATE OR ALTER VIEW SHOW_ERRORS
AS 
SELECT SUSER_SNAME()     suser_name,
       ERROR_NUMBER()    error_number,
       ERROR_STATE()     error_state,
       ERROR_SEVERITY()  error_severity,
       ERROR_LINE()      error_line,
       ERROR_PROCEDURE() error_procedure,
       ERROR_MESSAGE()   error_message,
       GETDATE()         date


GO

--===========================SELECT===========================================
--This procedure receives 1 parameter CountryID which is a country code of 3 characteres. 
--Example: EXEC spSelectCountry 'ARG' 

CREATE OR ALTER PROCEDURE spSelectCountry
(
  @CountryID char(3)
)
AS
BEGIN
    SELECT * FROM dbo.Country
	  WHERE CountryID = @CountryID
END
GO




--===========================INSERT============================================

--This procedure receives 2 parameters. CountryID and CountryName
--The SP should show the record that was inserted. 
--Example: EXEC spInsertCountryWithTransaction 'CPV','Cabo Verde'

CREATE OR ALTER PROCEDURE spInsertCountryWithTransaction
(
	@CountryID char(3),
	@CountryName varchar(50)
)
AS
BEGIN TRY
     BEGIN TRAN
	     SELECT COUNT(*) AS 'TOTAL RECORDS BEFORE TRANSACTION' FROM dbo.Country
	     DECLARE @temp TABLE
		 (
		   CountryID   char(3),
		   CountryName varchar(50)
		 )
     	 INSERT INTO dbo.Country OUTPUT INSERTED.CountryId, INSERTED.CountryID INTO @temp
     	 VALUES(@CountryID, @CountryName)

		 SET @CountryID  = (SELECT CountryID FROM @temp)

		 SELECT * FROM dbo.Country WHERE CountryID = @CountryID
		 SELECT COUNT(*) AS 'TOTAL RECORDS AFTER TRANSACTION' FROM dbo.Country
       COMMIT TRAN;
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS

END CATCH
GO



--===========================UPDATE===================================================
--This procedure receives 2 parameters. CountryID and CountryName
--The SP should show the record that was updated. 
--Example: EXEC spUpdateCountryNameWithTransaction 'CPV','Cabo Rojo'


CREATE OR ALTER PROCEDURE spUpdateCountryNameWithTransaction
(
	@CountryID char(3),
	@CountryName varchar(50)
)
AS
BEGIN TRY
     BEGIN TRAN

     	   UPDATE dbo.Country 
           SET CountryName = @CountryName
     	   WHERE CountryID = @CountryID 

		   SELECT * FROM dbo.Country WHERE CountryID = @CountryID
		  
      COMMIT TRAN
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS

END CATCH
GO




--==================================DELETE==============================================
--This procedure receives 1 parameter, CountryID  
--The SP should show the record that was deleted. 
--Example: EXEC spDeleteCountryWithTransaction 'CPV'

CREATE OR ALTER PROCEDURE spDeleteCountryWithTransaction
(
	@CountryID char(3)

)
AS
BEGIN TRY
     BEGIN TRAN
	     SELECT COUNT(*) AS 'TOTAL RECORDS BEFORE TRANSACTION' FROM dbo.Country
	     DECLARE @temp TABLE
		 (
		   CountryID char(3),
		   CountryName varchar(50)
		 )

     	 DELETE FROM dbo.Country OUTPUT DELETED.CountryId, DELETED.CountryName INTO @temp
		 WHERE CountryID = @CountryID 

		 SET @CountryID = (SELECT CountryID FROM @temp)

		 SELECT CountryID AS 'DELETED ID', CountryName AS 'DELETED COUNTRY' 
         FROM @temp 
         WHERE CountryID = @CountryID 
		 SELECT COUNT(*) AS 'TOTAL RECORDS AFTER TRANSACTION' FROM dbo.Country

         COMMIT TRAN;
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS
END CATCH
GO

--=======================================================================================
--=======================================================================================
--==============STORED PROCEDURES FOR STUDENT TABLE======================================


--===========================SELECT===========================================
--This procedure receives 1 parameter StudentID which is an int. 
--Example: EXEC spSelectStudent 5

CREATE OR ALTER PROCEDURE spSelectStudent
(
  @StudentID int
)
AS
BEGIN
     SELECT *
	 FROM   dbo.Student
	 WHERE  StudentID = @StudentID
END
GO


    

--================================INSERT==================================================
--This procedure receives 7 parameters FirstName, LastName, PhoneNUmber, Email, Age, Gender, CountryID 
--The SP should show the record inserted. 
--Example: EXEC spInsertStudentWithTransaction 'Genaro','Gonzalez','6143068687','gena@xprueba.com',37,'M','MEX'

CREATE OR ALTER PROCEDURE spInsertStudentWithTransaction
(
 @FirstName   varchar(30),
 @LastName    varchar(30),
 @PhoneNumber varchar(15),
 @Email       varchar(50),
 @Age         tinyint,
 @Gender      char(1),
 @CountryID   char(3)
)
AS
BEGIN TRY

     BEGIN TRAN

    	 INSERT INTO dbo.Student VALUES(
										@FirstName, 
			                            @LastName, 
				                        @PhoneNumber,
				                        @Email,
				                        @Age,
				                        @Gender,
				                        @CountryID
				                        )

		 

		 SELECT * FROM dbo.Student WHERE StudentID = SCOPE_IDENTITY()

       COMMIT TRAN
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS

END CATCH
GO



--====================================UPDATE=====================================================================
--This procedure receives 8 parameters StudentID, FirstName, LastName, PhoneNumber, Email, Age, Gender, CountryID 
--The SP should show the record updated. 
--Example: EXEC spUpdateStudentWithTransaction 28,'Genaro','Martinez','6143068687','gena@xprueba.com',38,'M','MEX'

CREATE OR ALTER PROCEDURE spUpdateStudentWithTransaction
(
 @StudentID   int, 
 @FirstName   varchar(30),
 @LastName    varchar(30),
 @PhoneNumber varchar(15),
 @Email       varchar(50),
 @Age         tinyint,
 @Gender      char(1),
 @CountryID   char(3)
)
AS

BEGIN TRY
     BEGIN TRAN
	     UPDATE dbo.Student 
         SET FirstName = @FirstName,
		     LastName = @LastName,
			 PhoneNumber = @PhoneNumber,
			 Email = @Email,
			 Age = @Age,
			 Gender = @Gender,
			 CountryID = @CountryID

     	 WHERE StudentID = @StudentID 

		 SELECT * FROM dbo.Student WHERE StudentID = @StudentID 
	 COMMIT TRAN
END TRY
BEGIN CATCH
	 ROLLBACK TRAN
   SELECT * FROM SHOW_ERRORS
END CATCH
GO




--=========================================DELETE=========================================================
--This procedure receives 1 parameter StudentID which is a int. 
--The SP should show: 
-- a) total record in table before transaction 
-- b) the record deleted 
-- c) total records in table after transaction 
--Example: EXEC spDeleteStudentWithTransaction 31

CREATE OR ALTER PROCEDURE spDeleteStudentWithTransaction
(
 @StudentID int
)
AS
BEGIN TRY
      SELECT COUNT(*) AS 'TOTAL RECORDS BEFORE TRANSACTION' FROM dbo.Student
      BEGIN TRAN
	  
	  DECLARE @temp TABLE
		  (
		    StudentID   int,
            FirstName   varchar(30),
            LastName    varchar(30),
            PhoneNumber varchar(15),
            Email       varchar(50),
            Age         tinyint,
            Gender      char(1),
            CountryID   char(3)
		  )

		  DECLARE @EnrolmentID int
		  SET @EnrolmentID = (SELECT EnrolmentID FROM dbo.Enrolment WHERE StudentID = @StudentID)

	      IF @EnrolmentID IS NOT NULL
		    BEGIN
	          DELETE FROM dbo.Enrolment WHERE EnrolmentID = @EnrolmentID

	          DELETE FROM dbo.Student OUTPUT DELETED.StudentID, 
		                                     DELETED.FirstName,
										     DELETED.LastName,
										     DELETED.PhoneNumber,
										     DELETED.Email,
										     DELETED.Age,
										     DELETED.Gender,
										     DELETED.CountryID INTO @temp
		            WHERE StudentID = @StudentID
            END

          ELSE
		   BEGIN
		       DELETE FROM dbo.Student OUTPUT DELETED.StudentID, 
		                                      DELETED.FirstName,
										      DELETED.LastName,
										      DELETED.PhoneNumber,
										      DELETED.Email,
										      DELETED.Age,
										      DELETED.Gender,
										      DELETED.CountryID INTO @temp
		         WHERE StudentID = @StudentID
            END
           		 SELECT *  FROM @temp 
				 SELECT COUNT(*) AS 'TOTAL RECORDS AFTER TRANSACTION' FROM dbo.Student
	    COMMIT TRAN
END TRY
BEGIN CATCH
	 ROLLBACK TRAN
     SELECT * FROM SHOW_ERRORS
END CATCH
GO

--=========================================================================================
--=========================================================================================
--==============STORED PROCEDURES FOR ENROLMENT TABLE======================================

--===========================SELECT========================================================
--This procedure returns the EnrolmentID and EnrolmentDate. 
--It receives 1 parameter StudentID which is an int. 
--Example: EXEC spSelectEnrolment 5

CREATE OR ALTER PROCEDURE spSelectEnrolment
(
  @StudentID int
)
AS
BEGIN
     SELECT EnrolmentID, EnrolmentDate
	 FROM   dbo.Enrolment
	 WHERE  StudentID = @StudentID
END
GO


  

--================================INSERT==================================================
--This procedure 1 parameter StudentID 
--The SP should show the record inserted. 
--Example: EXEC spInsertStudentWithTransaction 27

CREATE OR ALTER PROCEDURE spInsertEnrolmentWithTransaction
(
 @StudentID int 
)
AS
BEGIN TRY

     BEGIN TRAN

	         INSERT INTO dbo.Enrolment VALUES(GETDATE(), @StudentID)
		     SELECT * FROM dbo.Enrolment WHERE EnrolmentID = SCOPE_IDENTITY()
			
       COMMIT TRAN
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS

END CATCH
GO



--====================================UPDATE=====================================================================
--This procedure receives 2 parameter EnrolmentID, EnrolmentDate 
--The SP should show the record updated. 
--Example: EXEC spUpdateEnrolmentWithTransaction 27, '2021-11-30'

CREATE OR ALTER PROCEDURE spUpdateEnrolmentWithTransaction
(
 @EnrolmentID   int, 
 @EnrolmentDate date
)
AS

BEGIN TRY
     BEGIN TRAN

	   
	            UPDATE dbo.Enrolment 
                SET   EnrolmentDate = @EnrolmentDate
     	        WHERE EnrolmentID = @EnrolmentID

		        SELECT * FROM dbo.Enrolment WHERE EnrolmentID = @EnrolmentID 

	 COMMIT TRAN
END TRY
BEGIN CATCH
	 ROLLBACK TRAN
   SELECT * FROM SHOW_ERRORS
END CATCH
GO




--=========================================DELETE=========================================================
--This procedure receives 1 parameter EnrolmentID which is an int. 
--The SP should show: 
-- a) total records in table before transaction 
-- b) the record deleted 
-- c) total records in table after transaction 
--Example: EXEC spDeleteEnrolmentWithTransaction 27

CREATE OR ALTER PROCEDURE spDeleteEnrolmentWithTransaction
(
 @EnrolmentID int
)
AS
BEGIN TRY
      SELECT COUNT(*) AS 'TOTAL RECORDS BEFORE TRANSACTION' FROM dbo.Enrolment
      BEGIN TRAN
	 
	    DECLARE @temp TABLE
		     (
		       EnrolmentID   int,
               EnrolmentDate date,
               StudentID     int
		     )

		DECLARE @HayRegistros int
		SELECT  @HayRegistros = CAST(CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END AS BIT) FROM dbo.CourseEnrolment WHERE EnrolmentID = @EnrolmentID

	      IF @HayRegistros = 1
		      BEGIN
	            DELETE FROM dbo.CourseEnrolment WHERE EnrolmentID = @EnrolmentID
			  
	            DELETE FROM dbo.Enrolment OUTPUT DELETED.EnrolmentID, 
		                                         DELETED.EnrolmentDate,
										         DELETED.StudentID INTO @temp
		               WHERE EnrolmentID = @EnrolmentID
             END
          ELSE
		     BEGIN
			    DELETE FROM dbo.Enrolment OUTPUT DELETED.EnrolmentID, 
		                                         DELETED.EnrolmentDate,
										         DELETED.StudentID INTO @temp
		              WHERE EnrolmentID = @EnrolmentID

			 END
           		 SELECT *  FROM @temp 
				 SELECT COUNT(*) AS 'TOTAL RECORDS AFTER TRANSACTION' FROM dbo.Enrolment
	             COMMIT TRAN
END TRY
BEGIN CATCH
	 ROLLBACK TRAN
   SELECT * FROM SHOW_ERRORS
END CATCH
GO


--==================================================================================================
--==================================================================================================
--==============STORED PROCEDURES FOR COURSE_ENROLMENT TABLE=======================================

--===========================SELECT=========================================== 
--It receives 1 parameter EnrolmentID which is an int. 
--Example: EXEC spSelectCourseEnrolment 5

CREATE OR ALTER PROCEDURE spSelectCourseEnrolment
(
  @EnrolmentID int
)
AS
BEGIN
     SELECT CE.EnrolmentID, CE.CourseID, C.CourseName
	 FROM   dbo.CourseEnrolment CE
	 JOIN   dbo.Course C
	 ON     CE.CourseID = C.CourseID
	 WHERE  EnrolmentID = @EnrolmentID
END
GO


     

--================================INSERT==================================================
--This procedure receives 2 parameters EnrolmentID and CourseID 
--The SP should show the record inserted with the name of the course. 
--Example: EXEC spInsertCourseEnrolmentWithTransaction 4,4

CREATE OR ALTER PROCEDURE spInsertCourseEnrolmentWithTransaction
(
 @EnrolmentID int,
 @CourseID    int
)
AS
BEGIN TRY

     BEGIN TRAN

	 DECLARE @temp TABLE
		 (
		   EnrolmentID int,
		   CourseID    int
		 )
     	 INSERT INTO dbo.CourseEnrolment OUTPUT INSERTED.EnrolmentID, INSERTED.CourseID INTO @temp
     	 VALUES(@EnrolmentID, @CourseID)

		 SELECT T.EnrolmentID, T.CourseID, C.CourseName FROM @temp T JOIN dbo.Course C ON T.CourseID = C.CourseID
   
	   			
         COMMIT TRAN
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS

END CATCH
GO



--====================================UPDATE=====================================================================
--This procedure receives 3 parameters EnrolmentID, CourseID to update and the new CourseID 
--The SP should show the previous CourseID and the CourseID updated. 
--Example: EXEC spUpdateCourseEnrolmentWithTransaction 1,7,9

CREATE PROCEDURE spUpdateCourseEnrolmentWithTransaction
(
 @EnrolmentID   int, 
 @CourseID      int,
 @NewCourseID   int 
)
AS

BEGIN TRY
     BEGIN TRAN
	    
	   	 DECLARE @Updated TABLE
		 (
		   EnrolmentID    int,
		   OldCourseID    int,
		   NewCourseID    int
		 )
     	 UPDATE dbo.CourseEnrolment 
     	 SET CourseID = @NewCourseID
		 OUTPUT DELETED.EnrolmentID, DELETED.CourseID, INSERTED.CourseID 
		 INTO @Updated
		 WHERE EnrolmentID = @EnrolmentID AND CourseID = @CourseID 

		  

	      SELECT U.EnrolmentID, 
		        U.OldCourseID AS 'PREVIOUS COURSE ID',
				(SELECT CourseName FROM dbo.Course WHERE CourseID = @CourseID) AS 'COURSE NAME',
				U.NewCourseID AS 'NEW COURSE ID',
				(SELECT CourseName FROM dbo.Course WHERE CourseID = @NewCourseID ) AS 'COURSE NAME' 
				FROM @Updated U  

	 COMMIT TRAN
END TRY
BEGIN CATCH
	 ROLLBACK TRAN
   SELECT * FROM SHOW_ERRORS
END CATCH
GO




--=========================================DELETE=========================================================
--This procedure receives 2 parameters EnrolmentID and CourseID 
--The SP should show: 
-- a) total records in table before transaction 
-- b) the record deleted 
-- c) total records in table after transaction 
--Example: EXEC spDeleteCourseEnrolmentWithTransaction 1,4



CREATE OR ALTER PROCEDURE spDeleteCourseEnrolmentWithTransaction
(
 @EnrolmentID int,
 @CourseID    int
)
AS
BEGIN TRY
      SELECT COUNT(*) AS 'TOTAL RECORDS BEFORE TRANSACTION' FROM dbo.CourseEnrolment
      BEGIN TRAN
	 
	    DECLARE @temp TABLE
		     (
		       EnrolmentID   int,
               CourseID      int
             
		     )
			    DELETE FROM dbo.CourseEnrolment OUTPUT DELETED.EnrolmentID, 
		                                               DELETED.CourseID INTO @temp
		        WHERE EnrolmentID = @EnrolmentID AND CourseID = @CourseID

           		 SELECT *  FROM @temp 
				 SELECT COUNT(*) AS 'TOTAL RECORDS AFTER TRANSACTION' FROM dbo.CourseEnrolment
	             COMMIT TRAN
END TRY
BEGIN CATCH
	 ROLLBACK TRAN
     SELECT * FROM SHOW_ERRORS
END CATCH
GO

--=====================================================================================================
--=====================================================================================================
--==============STORED PROCEDURES FOR DEPARTMENT TABLE=================================================

--===========================SELECT====================================================================
--This procedure receives 1 parameter DepartmentID which is an int. 
--Example: EXEC spSelectDepartment 1.

CREATE OR ALTER PROCEDURE spSelectDepartment
(
  @DepartmentID int
)
AS
BEGIN
    SELECT * FROM dbo.Department
	  WHERE DepartmentID = @DepartmentID
END
GO




--===========================INSERT============================================

--This procedure receives 1 parameter, DepartmentName.
--The SP should show the record that was inserted. 
--Example: EXEC spInsertDepartmentWithTransaction 'Psicology'

CREATE OR ALTER PROCEDURE spInsertDepartmentWithTransaction
(
	@DepartmentName varchar(50)
)
AS
BEGIN TRY
     BEGIN TRAN
	     SELECT COUNT(*) AS 'TOTAL RECORDS BEFORE TRANSACTION' FROM dbo.Department
	 
     	 INSERT INTO dbo.Department VALUES(@DepartmentName)

		 SELECT * FROM dbo.Department WHERE DepartmentID = SCOPE_IDENTITY()
		 SELECT COUNT(*) AS 'TOTAL RECORDS AFTER TRANSACTION' FROM dbo.Department
       COMMIT TRAN;
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS

END CATCH
GO



--===========================UPDATE===================================================
--This procedure receives 2 parameters. DepartmentID and DepartmentName
--The SP should show the record that was updated. 
--Example: EXEC spUpdateDepartmentWithTransaction 9,'Music'


CREATE OR ALTER PROCEDURE spUpdateDepartmentWithTransaction
(
	@DepartmentID   int,
	@DepartmentName varchar(50)
)
AS
BEGIN TRY
     BEGIN TRAN

     	   UPDATE dbo.Department 
           SET DepartmentName = @DepartmentName
     	   WHERE DepartmentID = @DepartmentID 

		   SELECT * FROM dbo.Department WHERE DepartmentID = @DepartmentID
		  
      COMMIT TRAN
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS

END CATCH
GO




--==================================DELETE==============================================
--This procedure receives 1 parameter, DepartmentID which is an int. 
--The SP should show the record that was deleted. 
--Example: EXEC spDeleteDEpartmentWithTransaction 9

CREATE OR ALTER PROCEDURE spDeleteDepartmentWithTransaction
(
	@DepartmentID int

)
AS
BEGIN TRY
     BEGIN TRAN
	     SELECT COUNT(*) AS 'TOTAL RECORDS BEFORE TRANSACTION' FROM dbo.Department
	     DECLARE @temp TABLE
		 (
		   DepartmentID   int,
		   DepartmentName varchar(50)
		 )

     	 DELETE FROM dbo.Department OUTPUT DELETED.DepartmentId, DELETED.DepartmentName INTO @temp
		 WHERE DepartmentID = @DepartmentID 

		 SET @DepartmentID = (SELECT DepartmentID FROM @temp)

		 SELECT DepartmentID AS 'DELETED ID', DepartmentName AS 'DELETED DEPARTMENT' 
         FROM @temp 
         WHERE DepartmentID = @DepartmentID 
		 SELECT COUNT(*) AS 'TOTAL RECORDS AFTER TRANSACTION' FROM dbo.Department

         COMMIT TRAN;
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS
END CATCH
GO

--======================================================================================================
--======================================================================================================

--==============STORED PROCEDURES FOR LANGUAGE TABLE===========================

--===========================SELECT===========================================
--This procedure receives 1 parameter LanguageID which is a char(3)
--Example: EXEC spSelectLanguage 'DEU'  

CREATE OR ALTER PROCEDURE spSelectLanguage
(
  @LanguageID char(3)
)
AS
BEGIN
    SELECT * FROM dbo.Language
	  WHERE LanguageID = @LanguageID
END
GO




--===========================INSERT============================================

--This procedure receives 2 parameters, LanguageID, Language.
--The SP should show the record that was inserted. 
--Example: EXEC spInsertLanguageWithTransaction 'TOT','Totonaca'

CREATE OR ALTER PROCEDURE spInsertLanguageWithTransaction
(
    @LanguageID   char(3),
	@Language varchar(20)
	
)
AS
BEGIN TRY
     BEGIN TRAN
	     SELECT COUNT(*) AS 'TOTAL RECORDS BEFORE TRANSACTION' FROM dbo.Language
	     DECLARE @temp TABLE
		 (
		   LanguageID   char(3),
		   Language     varchar(20)
		 )

     	 INSERT INTO dbo.Language OUTPUT INSERTED.LanguageID, INSERTED.Language INTO @temp
     	 VALUES(@LanguageID, @Language)

		 SET @LanguageID  = (SELECT LanguageID FROM @temp)

		 SELECT * FROM dbo.Language WHERE LanguageID = @LanguageID

		 SELECT COUNT(*) AS 'TOTAL RECORDS AFTER TRANSACTION' FROM dbo.Language
       COMMIT TRAN;
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS

END CATCH
GO



--===========================UPDATE===================================================
--This procedure receives 2 parameters, LanguageID and Language.
--The SP should show the record that was updated. 
--Example: EXEC spUpdateLanguageWithTransaction 'TOT','Taran'


CREATE OR ALTER PROCEDURE spUpdateLanguageWithTransaction
(
	@LanguageID   char(3),
	@Language varchar(20)
)
AS
BEGIN TRY
     BEGIN TRAN

     	   UPDATE dbo.Language
           SET Language = @Language
     	   WHERE LanguageID = @LanguageID 

		   SELECT * FROM dbo.Language WHERE LanguageID = @LanguageID
		  
      COMMIT TRAN
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS

END CATCH
GO




--==================================DELETE==============================================
--This procedure receives 1 parameter, LanguageID which is a char(3).  
--The SP should show the record that was deleted. 
--Example: EXEC spDeleteLanguageWithTransaction 'TOT'

CREATE OR ALTER PROCEDURE spDeleteLanguageWithTransaction
(
	@LanguageID char(3)

)
AS
BEGIN TRY
     BEGIN TRAN
	     SELECT COUNT(*) AS 'TOTAL RECORDS BEFORE TRANSACTION' FROM dbo.Language
	     DECLARE @temp TABLE
		 (
		   LanguageID   char(3),
		   Language varchar(20)
		 )

     	 DELETE FROM dbo.Language OUTPUT DELETED.LanguageId, DELETED.Language INTO @temp
		 WHERE LanguageID = @LanguageID 

		 SET @LanguageID = (SELECT LanguageID FROM @temp)

		 SELECT LanguageID AS 'DELETED ID ', Language AS 'DELETED LANGUAGE' 
         FROM @temp 
         WHERE LanguageID = @LanguageID 
		 SELECT COUNT(*) AS 'TOTAL RECORDS AFTER TRANSACTION' FROM dbo.Language

         COMMIT TRAN;
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS
END CATCH
GO

--==============================================================================================
--==============================================================================================

--==============STORED PROCEDURES FOR CATEGORY TABLE===========================

--===========================SELECT===========================================
--This procedure receives 1 parameter CategoryID which is an int.
--Example: EXEC spSelectCategory 1  

CREATE OR ALTER PROCEDURE spSelectCategory
(
  @CategoryID int
)
AS
BEGIN
    SELECT * FROM dbo.Category
	  WHERE CategoryID = @CategoryID
END
GO


--===========================INSERT============================================

--This procedure receives 1 parameter, CategoryName.
--The SP should show the record that was inserted. 
--Example: EXEC spInsertCategoryWithTransaction 'Music'

CREATE OR ALTER PROCEDURE spInsertCategoryWithTransaction
(
	@CategoryName varchar(50)
	
)
AS
BEGIN TRY
     BEGIN TRAN
	     SELECT COUNT(*) AS 'TOTAL RECORDS BEFORE TRANSACTION' FROM dbo.Category
	     DECLARE @temp TABLE
		 (
		   CategoryID   int,
		   CategoryName varchar(50)
		 )
     	 INSERT INTO dbo.Category OUTPUT INSERTED.CategoryID, INSERTED.CategoryName INTO @temp
     	 VALUES(@CategoryName)

		 DECLARE @CategoryID int
		 SET @CategoryID  = (SELECT CategoryID FROM @temp)

		 SELECT COUNT(*) AS 'TOTAL RECORDS AFTER TRANSACTION' FROM dbo.Category
		 SELECT * FROM dbo.Category WHERE CategoryID = @CategoryID
       COMMIT TRAN;
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS

END CATCH
GO



--===========================UPDATE===================================================
--This procedure receives 2 parameters. CategoryID and CategoryName
--The SP should show the record that was updated. 
--Example: EXEC spUpdateCategoryNameWithTransaction 30,'Teachings & Academics'


CREATE OR ALTER PROCEDURE spUpdateCategoryNameWithTransaction
(
	@CategoryID   int,
	@CategoryName varchar(50)
)
AS
BEGIN TRY
     BEGIN TRAN

     	   UPDATE dbo.Category 
           SET CategoryName = @CategoryName
     	   WHERE CategoryID = @CategoryID 

		   SELECT * FROM dbo.Category WHERE CategoryID = @CategoryID
		  
      COMMIT TRAN
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS

END CATCH
GO




--==================================DELETE==============================================
--This procedure receives 1 parameter, CategoryID which is an int.  
--The SP should show the record that was deleted. 
--Example: EXEC spDeleteCategoryWithTransaction 30

CREATE OR ALTER PROCEDURE spDeleteCategoryWithTransaction
(
	@CategoryID int

)
AS
BEGIN TRY
     BEGIN TRAN
	     SELECT COUNT(*) AS 'TOTAL RECORDS BEFORE TRANSACTION' FROM dbo.Category
	     DECLARE @temp TABLE
		 (
		   CategoryID   int,
		   CategoryName varchar(50)
		 )

     	 DELETE FROM dbo.Category OUTPUT DELETED.CategoryId, DELETED.CategoryName INTO @temp
		 WHERE CategoryID = @CategoryID 

		 SET @CategoryID = (SELECT CategoryID FROM @temp)

		 SELECT CategoryID AS 'DELETED ID ', CategoryName AS 'DELETED CATEGORY' 
         FROM @temp 
         WHERE CategoryID = @CategoryID 
		 SELECT COUNT(*) AS 'TOTAL RECORDS AFTER TRANSACTION' FROM dbo.Category

         COMMIT TRAN;
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS
END CATCH
GO

--=============================================================================================
--=============================================================================================
--==============STORED PROCEDURES FOR INSTRUCTOR TABLE===========================


--===========================SELECT===========================================
--This procedure receives 1 parameter InstructorID which is an int. 
--Example: EXEC spSelectInstructor 5

CREATE OR ALTER PROCEDURE spSelectInstructor
(
  @InstructorID int
)
AS
BEGIN
     SELECT FirstName,LastName,Email
	 FROM   dbo.Instructor
	 WHERE  InstructorID = @InstructorID
END
GO


    

--================================INSERT==================================================
--This procedure receives 5 parameters, FirstName, LastName, Photo, Email, DepartmentID 
--The SP should show the record inserted. 
--Example: EXEC spInsertInstructorWithTransaction 'Mario','Moran',null,'mayo@xprueba.com',4

CREATE OR ALTER PROCEDURE spInsertInstructorWithTransaction
(
 @FirstName    varchar(30),
 @LastName     varchar(30),
 @Photo        varchar(100),
 @Email        varchar(50),
 @DepartmentID int
)
AS
BEGIN TRY

     BEGIN TRAN

    	 INSERT INTO dbo.Instructor VALUES(
										@FirstName, 
			                            @LastName, 
				                        @Photo,
				                        @Email,
				                        @DepartmentID
				                        )

		 

		 SELECT * FROM dbo.Instructor WHERE InstructorID = SCOPE_IDENTITY()

       COMMIT TRAN
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS

END CATCH
GO


--====================================UPDATE=====================================================================
--This procedure receives 6 parameters, InstructorID, FirstName, LastName, Photo, Email,DepartmentID 
--The SP should show the record updated. 
--Example: EXEC spUpdateInstructorWithTransaction 21,'Juan','Moran',null,'mayo@xprueba.com',4



CREATE OR ALTER PROCEDURE spUpdateInstructorWithTransaction
(
 @InstructorID   int, 
 @FirstName      varchar(30),
 @LastName       varchar(30),
 @Photo          varchar(100),
 @Email          varchar(50),
 @DepartmentID   int
)
AS

BEGIN TRY
     BEGIN TRAN
	     UPDATE dbo.Instructor 
         SET FirstName = @FirstName,
		     LastName = @LastName,
			 Photo = @Photo,
			 Email = @Email,
			 DepartmentID = @DepartmentID
     	 WHERE InstructorID = @InstructorID 

		 SELECT * FROM dbo.Instructor WHERE InstructorID = @InstructorID 
	 COMMIT TRAN
END TRY
BEGIN CATCH
	 ROLLBACK TRAN
   SELECT * FROM SHOW_ERRORS
END CATCH
GO





--=========================================DELETE=========================================================
--This procedure receives 1 parameter DepartmentID which is a int. 
--The SP should show: 
-- a) total record in table before transaction 
-- b) the record deleted 
-- c) total records in table after transaction 
--Example: EXEC spDeleteInstructorWithTransaction 21

CREATE OR ALTER PROCEDURE spDeleteInstructorWithTransaction
(
 @InstructorID int
)
AS
BEGIN TRY
      SELECT COUNT(*) AS 'TOTAL RECORDS BEFORE TRANSACTION' FROM dbo.Instructor
      BEGIN TRAN
	  
	  DECLARE @temp TABLE
		  (
		    InstructorID   int,
            FirstName      varchar(30),
            LastName       varchar(30),
            Photo          varchar(100),
			Email          varchar(50),
            DepartmentID   char(3)
		  )

		  DECLARE @Courses int
		  SELECT @Courses = CAST(COUNT(*) AS BIT) FROM dbo.Course WHERE InstructorID = @InstructorID

		  IF @Courses = 1
		    BEGIN
			   DELETE FROM dbo.Course WHERE InstructorID = @InstructorID

	           DELETE FROM dbo.Instructor OUTPUT DELETED.InstructorID, 
		                                         DELETED.FirstName,
										         DELETED.LastName,
										         DELETED.Photo,
										         DELETED.Email,
										         DELETED.DepartmentID INTO @temp
		       WHERE InstructorID = @InstructorID
			END

          ELSE
		   BEGIN
		       DELETE FROM dbo.Instructor OUTPUT DELETED.InstructorID, 
		                                         DELETED.FirstName,
										         DELETED.LastName,
										         DELETED.Photo,
										         DELETED.Email,
										         DELETED.DepartmentID INTO @temp
		       WHERE InstructorID = @InstructorID
            END
           		 SELECT *  FROM @temp 
				 SELECT COUNT(*) AS 'TOTAL RECORDS AFTER TRANSACTION' FROM dbo.Instructor
	    COMMIT TRAN
END TRY
BEGIN CATCH
	 ROLLBACK TRAN
     SELECT * FROM SHOW_ERRORS
END CATCH
GO

--===========================================================================================
--===========================================================================================
--==============STORED PROCEDURES FOR COURSE TABLE===========================

--===========================SELECT===========================================
--This procedure receives 1 parameter CourseID which is an int. 
--Example: EXEC spSelectCourse 5

CREATE OR ALTER PROCEDURE spSelectCourse
(
  @CourseID int
)
AS
BEGIN
     SELECT *
	 FROM   dbo.Course
	 WHERE  CourseID = @CourseID
END
GO


    

--================================INSERT==================================================
--This procedure receives 7 parameters CourseName, Credits, CourseCode, Price, CategoryID, LanguageID, InstructorID 
--The SP should show the record inserted. 
--Example: EXEC spInsertCourseWithTransaction 'Learn and Understand NodeJS',50,'NODE01',200.00,1,'ENG',19

CREATE OR ALTER PROCEDURE spInsertCourseWithTransaction
(
 @CourseName   varchar(100),
 @Credits       int,
 @CourseCode    varchar(10),
 @Price         decimal(19,4),
 @CategoryID    int,
 @LanguageID    char(3),
 @InstructorID  int
)
AS
BEGIN TRY

     BEGIN TRAN

    	 INSERT INTO dbo.Course VALUES(
										@CourseName, 
			                            @Credits, 
				                        @CourseCode,
				                        @Price,
				                        @CategoryID,
				                        @LanguageID,
				                        @InstructorID
				                        )

		 

		 SELECT * FROM dbo.Course WHERE CourseID = SCOPE_IDENTITY()

       COMMIT TRAN
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS

END CATCH
GO



--====================================UPDATE=====================================================================
--This procedure receives 8  parameters CourseID, CourseName, Credits, CourseCode, Price, CategoryID, LanguageID, InstructorID 
--The SP should show the record updated. 
--Example: EXEC spUpdateCourseWithTransaction 20,'Node JS: Advanced Concepts',60,'NODE02',200.00,2,'ESP',20

CREATE OR ALTER PROCEDURE spUpdateCourseWithTransaction
(
 @CourseID      int,
 @CourseName    varchar(100),
 @Credits       int,
 @CourseCode    varchar(10),
 @Price         decimal(19,4),
 @CategoryID    int,
 @LanguageID    char(3),
 @InstructorID  int
)
AS

BEGIN TRY
     BEGIN TRAN
	     UPDATE dbo.Course 
         SET CourseName = @CourseName,
		     Credits = @Credits,
			 CourseCode = @CourseCode,
			 Price = @Price,
			 CategoryID = @CategoryID,
			 LanguageID = @LanguageID,
			 InstructorID = @InstructorID
     	 WHERE CourseID = @CourseID 
		 PRINT 'UPDATED COURSE:'
		 SELECT * FROM dbo.Course WHERE CourseID = @CourseID 
	 COMMIT TRAN
END TRY
BEGIN CATCH
	 ROLLBACK TRAN
   SELECT * FROM SHOW_ERRORS
END CATCH
GO




--=========================================DELETE=========================================================
--This procedure receives 1 parameter CourseID which is a int. 
--The SP should show: 
-- a) total record in table before transaction 
-- b) the record deleted 
-- c) total records in table after transaction 
--Example: EXEC spDeleteCourseWithTransaction 20

CREATE OR ALTER PROCEDURE spDeleteCourseWithTransaction
(
 @CourseID int
)
AS
BEGIN TRY
      SELECT COUNT(*) AS 'TOTAL RECORDS BEFORE TRANSACTION' FROM dbo.Course
      BEGIN TRAN
	  
	  DECLARE @temp TABLE
		  (
		    CourseID     int,
            CourseName   varchar(100),
            Credits      int,
            CourseCode   varchar(10),
            Price        decimal(19,4),
			CategoryID   int,
			LanguageID   char(3),
			InstructorID int
			)

		  
	      

	          DELETE FROM dbo.Course OUTPUT  DELETED.CourseID, 
		                                     DELETED.CourseName,
										     DELETED.Credits,
										     DELETED.CourseCode,
										     DELETED.Price,
										     DELETED.CategoryID,
										     DELETED.LanguageID,
										     DELETED.InstructorID INTO @temp
		            WHERE CourseID = @CourseID
                    SELECT *  FROM @temp 
				 SELECT COUNT(*) AS 'TOTAL RECORDS AFTER TRANSACTION' FROM dbo.Course
	    COMMIT TRAN
END TRY
BEGIN CATCH
	 ROLLBACK TRAN
     SELECT * FROM SHOW_ERRORS
END CATCH
GO

























































