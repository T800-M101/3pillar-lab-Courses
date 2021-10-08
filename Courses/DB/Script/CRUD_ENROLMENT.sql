--==============STORED PROCEDURES FOR ENROLMENT TABLE===========================

--===========================SELECT===========================================
--This procedure returns the EnrolmentID and EnrolmentDate. 
--It receives a parameter @StudentID which is an int. 
--Example: EXEC spSelectEnrolment 5

--CREATE PROCEDURE spSelectEnrolment
--(
--  @StudentID int
--)
--AS
--BEGIN
--     SELECT EnrolmentID, EnrolmentDate
--	 FROM   dbo.Enrolment
--	 WHERE  StudentID = @StudentID
--END
--GO


--EXEC spSelectEnrolment 5
--GO     

--================================INSERT==================================================
--This procedure 1 parameter StudentID 
--The SP should show the record inserted. 
--Example: EXEC spInsertStudentWithTransaction 33

--CREATE PROCEDURE spInsertEnrolmentWithTransaction
--(
-- @StudentID int 
--)
--AS
--BEGIN TRY

--     BEGIN TRAN


--	 DECLARE @ExisteAlumno int
--		  SELECT @ExisteAlumno = CAST(COUNT(*) AS BIT) FROM dbo.Enrolment WHERE StudentID = @StudentID
		  
--	      IF @ExisteAlumno = 0
--		    BEGIN
--	             INSERT INTO dbo.Enrolment VALUES(GETDATE(), @StudentID)
--		         SELECT * FROM dbo.Enrolment WHERE EnrolmentID = SCOPE_IDENTITY()
--			END	
--          ELSE
--		    BEGIN
--			   PRINT 'The Student ID provided already has an enrolment.'
			   
--			END

--       COMMIT TRAN
--END TRY
--BEGIN CATCH
--       SELECT ERROR_MESSAGE()
--       ROLLBACK TRAN

--END CATCH
--GO

--EXEC spInsertEnrolmentWithTransaction 36
--GO

--====================================UPDATE=====================================================================
--This procedure receives 2 parameter EnrolmentID, EnrolmentDate 
--The SP should show the record updated. 
--Example: EXEC spUpdateEnrolmentWithTransaction 27, '2021-11-30'

--CREATE PROCEDURE spUpdateEnrolmentWithTransaction
--(
-- @EnrolmentID   int, 
-- @EnrolmentDate date
--)
--AS

--BEGIN TRY
--     BEGIN TRAN

	   
--	            UPDATE dbo.Enrolment 
--                SET   EnrolmentDate = @EnrolmentDate
--     	        WHERE EnrolmentID = @EnrolmentID

--		        SELECT * FROM dbo.Enrolment WHERE EnrolmentID = @EnrolmentID 

--	 COMMIT TRAN
--END TRY
--BEGIN CATCH
--     SELECT ERROR_MESSAGE()
--	 ROLLBACK TRAN
--END CATCH
--GO


--EXEC spUpdateEnrolmentWithTransaction 34, '2021-11-15'
--GO

--=========================================DELETE=========================================================
--This procedure receives a parameter @EnrolmentID which is an int. 
--The SP should show: 
-- a) total records in table before transaction 
-- b) the record deleted 
-- c) total records in table after transaction 
--Example: EXEC spDeleteEnrolmentWithTransaction 31

--CREATE PROCEDURE spDeleteEnrolmentWithTransaction
--(
-- @EnrolmentID int
--)
--AS
--BEGIN TRY
--      SELECT COUNT(*) AS 'TOTAL RECORDS BEFORE TRANSACTION' FROM dbo.Enrolment
--      BEGIN TRAN
	 
--	    DECLARE @temp TABLE
--		     (
--		       EnrolmentID   int,
--               EnrolmentDate date,
--               StudentID     int
--		     )

--		DECLARE @HayRegistros int
--		SELECT  @HayRegistros = CAST(CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END AS BIT) FROM dbo.CourseEnrolment WHERE EnrolmentID = @EnrolmentID

--	      IF @HayRegistros = 1
--		      BEGIN
--	            DELETE FROM dbo.CourseEnrolment WHERE EnrolmentID = @EnrolmentID
			  
--	            DELETE FROM dbo.Enrolment OUTPUT DELETED.EnrolmentID, 
--		                                         DELETED.EnrolmentDate,
--										         DELETED.StudentID INTO @temp
--		               WHERE EnrolmentID = @EnrolmentID
--             END
--          ELSE
--		     BEGIN
--			    DELETE FROM dbo.Enrolment OUTPUT DELETED.EnrolmentID, 
--		                                         DELETED.EnrolmentDate,
--										         DELETED.StudentID INTO @temp
--		              WHERE EnrolmentID = @EnrolmentID

--			 END
--           		 SELECT *  FROM @temp 
--				 SELECT COUNT(*) AS 'TOTAL RECORDS AFTER TRANSACTION' FROM dbo.Enrolment
--	             COMMIT TRAN
--END TRY
--BEGIN CATCH
--     SELECT ERROR_MESSAGE()
--	 ROLLBACK
--END CATCH
--GO

--EXEC spDeleteEnrolmentWithTransaction 26
--GO

