--==============STORED PROCEDURES FOR CATEGORY TABLE===========================
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







