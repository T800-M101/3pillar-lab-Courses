--==============STORED PROCEDURES FOR COUNTRY TABLE===========================
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
--This procedure receives 1 parameter CountryID which is a country code of 3 characteres. 
--Example: EXEC spSelectCountry 'ARG' 

CREATE OR ALTER PROCEDURE spSelectCountry
(
  @CountryID char(3)
)
AS
BEGIN
    SELECT * FROM dbo.Country
	  WHERE CountryID = @CountryID
END
GO




--===========================INSERT============================================

--This procedure receives 2 parameters. CountryID and CountryName
--The SP should show the record that was inserted. 
--Example: EXEC spInsertCountryWithTransaction 'CPV','Cabo Verde'

CREATE OR ALTER PROCEDURE spInsertCountryWithTransaction
(
	@CountryID char(3),
	@CountryName varchar(50)
)
AS
BEGIN TRY
     BEGIN TRAN
	     SELECT COUNT(*) AS 'TOTAL RECORDS BEFORE TRANSACTION' FROM dbo.Country
	     DECLARE @temp TABLE
		 (
		   CountryID char(3)
		 )
     	 INSERT INTO dbo.Country OUTPUT INSERTED.CountryId INTO @temp
     	 VALUES(@CountryID, @CountryName)

		 SET @CountryID  = (SELECT CountryID FROM @temp)

		 SELECT * FROM dbo.Country WHERE CountryID = @CountryID
		 SELECT COUNT(*) AS 'TOTAL RECORDS AFTER TRANSACTION' FROM dbo.Country
       COMMIT TRAN;
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS

END CATCH
GO


--===========================UPDATE===================================================
--This procedure receives 2 parameters. CountryID and CountryName
--The SP should show the record that was updated. 
--Example: EXEC spUpdateCountryNameWithTransaction 'CPV','Cabo Rojo'


CREATE OR ALTER PROCEDURE spUpdateCountryNameWithTransaction
(
	@CountryID char(3),
	@CountryName varchar(50)
)
AS
BEGIN TRY
     BEGIN TRAN

     	   UPDATE dbo.Country 
           SET CountryName = @CountryName
     	   WHERE CountryID = @CountryID 

		   SELECT * FROM dbo.Country WHERE CountryID = @CountryID
		  
      COMMIT TRAN
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS

END CATCH
GO




--==================================DELETE==============================================
--This procedure receives 1 parameter, CountryID  
--The SP should show the record that was deleted. 
--Example: EXEC spDeleteCountryWithTransaction 'CPV'

CREATE OR ALTER PROCEDURE spDeleteCountryWithTransaction
(
	@CountryID char(3)

)
AS
BEGIN TRY
     BEGIN TRAN
	     SELECT COUNT(*) AS 'TOTAL RECORDS BEFORE TRANSACTION' FROM dbo.Country
	     DECLARE @temp TABLE
		 (
		   CountryID char(3),
		   CountryName varchar(50)
		 )

     	 DELETE FROM dbo.Country OUTPUT DELETED.CountryId, DELETED.CountryName INTO @temp
		 WHERE CountryID = @CountryID 

		 SET @CountryID = (SELECT CountryID FROM @temp)

		 SELECT CountryID AS 'DELETED ID', CountryName AS 'DELETED COUNTRY' 
         FROM @temp 
         WHERE CountryID = @CountryID 
		 SELECT COUNT(*) AS 'TOTAL RECORDS AFTER TRANSACTION' FROM dbo.Country

         COMMIT TRAN;
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS
END CATCH
GO







