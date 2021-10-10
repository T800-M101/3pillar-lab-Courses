--==============STORED PROCEDURES FOR COURSE_ENROLMENT TABLE===========================
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
   SELECT * FROM SHOW_RECORDS
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


