--==============STORED PROCEDURES FOR INSTRUCTOR TABLE===========================

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












