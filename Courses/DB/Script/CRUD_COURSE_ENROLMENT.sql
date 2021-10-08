--==============STORED PROCEDURES FOR COURSE_ENROLMENT TABLE===========================

--===========================SELECT===========================================
--This procedure returns the CourseID and CourseName. 
--It receives a parameter @EnrolmentID which is an int. 
--Example: EXEC spSelectCourseEnrolment 5

--CREATE PROCEDURE spSelectCourseEnrolment
--(
--  @EnrolmentID int
--)
--AS
--BEGIN
--     SELECT CE.EnrolmentID, CE.CourseID, C.CourseName
--	 FROM   dbo.CourseEnrolment CE
--	 JOIN   dbo.Course C
--	 ON     CE.CourseID = C.CourseID
--	 WHERE  EnrolmentID = @EnrolmentID
--END
--GO


--EXEC spSelectCourseEnrolment 5
--GO     

--================================INSERT==================================================
--This procedure receives 2 parameters EnrolmentID and CourseID 
--The SP should show the record inserted with the name of the course. 
--Example: EXEC spInsertCourseEnrolmentWithTransaction 4,4

--CREATE PROCEDURE spInsertCourseEnrolmentWithTransaction
--(
-- @EnrolmentID int,
-- @CourseID    int
--)
--AS
--BEGIN TRY

--     BEGIN TRAN

--	 DECLARE @temp TABLE
--		 (
--		   EnrolmentID int,
--		   CourseID    int
--		 )
--     	 INSERT INTO dbo.CourseEnrolment OUTPUT INSERTED.EnrolmentID, INSERTED.CourseID INTO @temp
--     	 VALUES(@EnrolmentID, @CourseID)

--		 SELECT T.EnrolmentID, T.CourseID, C.CourseName FROM @temp T JOIN dbo.Course C ON T.CourseID = C.CourseID
   
	   			
--         COMMIT TRAN
--END TRY
--BEGIN CATCH
--       SELECT ERROR_MESSAGE()
--       ROLLBACK TRAN

--END CATCH
--GO

--EXEC spInsertCourseEnrolmentWithTransaction 4,4
--GO

--====================================UPDATE=====================================================================
--This procedure receives 3 parameters EnrolmentID, CourseID to update and the new CourseID 
--The SP should show the previous CourseID and the CourseID updated. 
--Example: EXEC spUpdateCourseEnrolmentWithTransaction 1,7,9

--CREATE PROCEDURE spUpdateCourseEnrolmentWithTransaction
--(
-- @EnrolmentID   int, 
-- @CourseID      int,
-- @NewCourseID   int 
--)
--AS

--BEGIN TRY
--     BEGIN TRAN
	    
--	   	 DECLARE @Updated TABLE
--		 (
--		   EnrolmentID    int,
--		   OldCourseID    int,
--		   NewCourseID    int
--		 )
--     	 UPDATE dbo.CourseEnrolment 
--     	 SET CourseID = @NewCourseID
--		 OUTPUT DELETED.EnrolmentID, DELETED.CourseID, INSERTED.CourseID 
--		 INTO @Updated
--		 WHERE EnrolmentID = @EnrolmentID AND CourseID = @CourseID 

		  

--	      SELECT U.EnrolmentID, 
--		        U.OldCourseID AS 'PREVIOUS COURSE ID',
--				(SELECT CourseName FROM dbo.Course WHERE CourseID = @CourseID) AS 'COURSE NAME',
--				U.NewCourseID AS 'NEW COURSE ID',
--				(SELECT CourseName FROM dbo.Course WHERE CourseID = @NewCourseID ) AS 'COURSE NAME' 
--				FROM @Updated U  

--	 COMMIT TRAN
--END TRY
--BEGIN CATCH
--     SELECT ERROR_MESSAGE()
--	 ROLLBACK TRAN
--END CATCH
--GO


--EXEC spUpdateCourseEnrolmentWithTransaction 1,7,9
--GO

--=========================================DELETE=========================================================
--This procedure receives 2 parameters @EnrolmentID and CourseID 
--The SP should show: 
-- a) total records in table before transaction 
-- b) the record deleted 
-- c) total records in table after transaction 
--Example: EXEC spDeleteCourseEnrolmentWithTransaction 1,7

CREATE PROCEDURE spDeleteCourseEnrolmentWithTransaction
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
     SELECT ERROR_MESSAGE()
	 ROLLBACK
END CATCH
GO

EXEC spDeleteCourseEnrolmentWithTransaction 35
GO

SELECT * FROM CourseEnrolment
SELECT * FROM Course