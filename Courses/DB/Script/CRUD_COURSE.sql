--==============STORED PROCEDURES FOR COURSE TABLE===========================

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












