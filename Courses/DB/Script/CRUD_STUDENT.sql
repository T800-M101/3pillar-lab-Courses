--==============STORED PROCEDURES FOR STUDENT TABLE===========================

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












