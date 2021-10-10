--==============STORED PROCEDURES FOR ENROLMENT TABLE===========================
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



