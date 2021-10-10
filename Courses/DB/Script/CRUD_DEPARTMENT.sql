--==============STORED PROCEDURES FOR DEPARTMENT TABLE===========================
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







