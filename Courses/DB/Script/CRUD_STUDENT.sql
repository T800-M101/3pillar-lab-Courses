--==============STORED PROCEDURES FOR STUDENT TABLE===========================

--===========================SELECT===========================================
--This procedure returns the firstname, lastname and phone number of a student. 
--It receives a parameter @StudentID which is an int. 
--Example: EXEC spSelectStudent 5

--CREATE PROCEDURE spSelectStudent
--(
--  @StudentID int
--)
--AS
--BEGIN
--     SELECT FirstName,LastName,PhoneNumber
--	 FROM   dbo.Student
--	 WHERE  StudentID = @StudentID
--END
--GO


--EXEC spSelectStudent 5
--GO     

--================================INSERT==================================================
--This procedure 7 parameters @FirstName, @LastName, @PhoneNUmber, @Email, @Age, @Gender, @CountryID 
--The SP show show the record inserted. 
--Example: EXEC spInsertStudentWithTransaction null,'Genaro','Gonzalez','6143068687','gena@xprueba.com',37,'F','MEX'

--CREATE PROCEDURE spInsertStudentWithTransaction
--(
-- @FirstName   varchar(30),
-- @LastName    varchar(30),
-- @PhoneNumber varchar(15),
-- @Email       varchar(50),
-- @Age         tinyint,
-- @Gender      char(1),
-- @CountryID   char(3)
--)
--AS
--BEGIN TRY

--     BEGIN TRAN

--    	 INSERT INTO dbo.Student VALUES(
--										@FirstName, 
--			                            @LastName, 
--				                        @PhoneNumber,
--				                        @Email,
--				                        @Age,
--				                        @Gender,
--				                        @CountryID
--				                        )

		 

--		 SELECT * FROM dbo.Student WHERE StudentID = SCOPE_IDENTITY()

--       COMMIT TRAN
--END TRY
--BEGIN CATCH
--       SELECT ERROR_MESSAGE()
--       ROLLBACK TRAN

--END CATCH
--GO

EXEC spInsertStudentWithTransaction null,'Mariana','Fernandez','6143048687','mariann@xprueba.com',20,'F','MEX'
GO

--====================================UPDATE=====================================================================
--This procedure 8 parameters @StudentID, @FirstName, @LastName, @PhoneNumber, @Email, @Age, @Gender, @CountryID 
--The SP should show the record updated. 
--Example: EXEC spUpdateStudentWithTransaction 12,'Irma','Dorantes','2231256767','dora@testmail.com',31,'F','CHL'

--CREATE PROCEDURE spUpdateStudentWithTransaction
--(
-- @StudentID   int, 
-- @FirstName   varchar(30),
-- @LastName    varchar(30),
-- @PhoneNumber varchar(15),
-- @Email       varchar(50),
-- @Age         tinyint,
-- @Gender      char(1),
-- @CountryID   char(3)
--)
--AS

--BEGIN TRY
--     BEGIN TRAN
--	     UPDATE dbo.Student 
--         SET FirstName = @FirstName,
--		     LastName = @LastName,
--			 PhoneNumber = @PhoneNumber,
--			 Email = @Email,
--			 Age = @Age,
--			 Gender = @Gender,
--			 CountryID = @CountryID

--     	 WHERE StudentID = @StudentID 

--		 SELECT * FROM dbo.Student WHERE StudentID = @StudentID 
--	 COMMIT TRAN
--END TRY
--BEGIN CATCH
--     SELECT ERROR_MESSAGE()
--	 ROLLBACK TRAN
--END CATCH
--GO


--EXEC spUpdateStudentWithTransaction 12,'Irma','Dorantes','2231256767','dora@testmail.com',31,'F','CHL'
--GO

--=========================================DELETE=========================================================
--This procedure receives a parameter @StudentID which is a int. 
--The SP should show: 
-- a) total record in table before transaction 
-- b) the record deleted 
-- c) total records in table after transaction 
--Example: EXEC spDeleteStudentWithTransaction 31

CREATE PROCEDURE spDeleteStudentWithTransaction
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
     SELECT ERROR_MESSAGE()
	 ROLLBACK
END CATCH
GO

EXEC spDeleteStudentWithTransaction 35
GO










