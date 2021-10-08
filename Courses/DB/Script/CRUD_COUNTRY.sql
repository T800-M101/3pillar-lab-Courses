
--==============STORED PROCEDURES FOR COUNTRY TABLE===========================

--===========================SELECT===========================================
--This procedure returns the name of a country. It receives a parameter @CountryID
--which is a country code of 3 characteres. 
--Example: EXEC spSelectCountry 'ARG'  (for Argentina).

--CREATE PROCEDURE spSelectCountry
--(
--  @CountryID char(3)
--)
--AS
--BEGIN
--    SELECT * FROM dbo.Country
--	  WHERE CountryID = @CountryID
--END
--GO

--EXEC spSelectCountry 'ARG'
--GO


--===========================INSERT============================================
--This procedure receives 2 parameters. @CountryID and @CountryName
--The SP should show all the record from the Country table with the new record inserted. 
--Example: EXEC spInsertCountry 'CXR','Isla de Pascua'

--CREATE PROCEDURE spInsertCountry
--(
--	@CountryID char(3),
--	@CountryName varchar(50)
--)
--AS
--BEGIN

--	INSERT INTO dbo.Country 
--	VALUES(@CountryID, @CountryName)
	
--	SELECT * FROM  dbo.Country ORDER BY CountryID DESC
--END

--EXEC spInsertCountry 'FLK','Islas Malvinas'
--GO


----------------------------------------------------------------------------------------------------------------
--This procedure receives 2 parameters. @CountryID and @CountryName
--The SP should show the record that was inserted. 
--Example: EXEC spInsertCountryWithTransaction 'ETH','Etiopia'

--CREATE PROCEDURE spInsertCountryWithTransaction
--(
--	@CountryID char(3),
--	@CountryName varchar(50)
--)
--AS
--BEGIN TRY
--     BEGIN TRAN
--	     DECLARE @temp TABLE
--		 (
--		   CountryID char(3)
--		 )
--     	 INSERT INTO dbo.Country OUTPUT INSERTED.CountryId INTO @temp
--     	 VALUES(@CountryID, @CountryName)

--		 SET @CountryID  = (SELECT CountryID FROM @temp)

--		 SELECT * FROM dbo.Country WHERE CountryID = @CountryID
--       COMMIT TRAN;
--END TRY
--BEGIN CATCH
--       SELECT ERROR_MESSAGE()
--       ROLLBACK TRAN

--END CATCH

--EXEC spInsertCountryWithTransaction 'FJI','Fiji'
--GO

--===========================UPDATE===================================================
--This procedure receives 2 parameters. @CountryID and @CountryName
--The SP should show the record that was updated. 
--Example: EXEC spUpdateCountryWithTransaction 'ETH','Etiopia'


--CREATE PROCEDURE spUpdateCountryWithTransaction
--(
--	@CountryID char(3),
--	@CountryName varchar(50)
--)
--AS
--BEGIN TRY
--     BEGIN TRAN

--     	 UPDATE dbo.Country 
--       SET CountryName = @CountryName
--     	 WHERE CountryID = @CountryID 

--		 SELECT * FROM dbo.Country WHERE CountryID = @CountryID
--         COMMIT TRAN;
--     END TRY
--BEGIN CATCH
--       SELECT ERROR_MESSAGE()
--       ROLLBACK TRAN

--END CATCH

--EXEC spUpdateCountryWithTransaction 'ETH','Etiopia'
--GO

--==================================DELETE==============================================
--This procedure receives 2 parameters. @CountryID and @CountryName. 
--The procedure can delete the record as long as one of the parameters is correct.
--The SP should show the record that was deleted. 
--Example: EXEC spDeleteCountryWithTransaction 'COM','Comoras'

--ALTER PROCEDURE spDeleteCountryWithTransaction
--(
--	@CountryID char(3),
--	@CountryName varchar(50)
--)
--AS
--BEGIN TRY
--     BEGIN TRAN
--	     DECLARE @temp TABLE
--		 (
--		   CountryID char(3),
--         CountryName varchar(50) 
--		 )
--     	 DELETE FROM dbo.Country OUTPUT DELETED.CountryId, DELETED.CountryName INTO @temp
--		 WHERE CountryID = @CountryID OR CountryName = @CountryName  

--		 SET @CountryID = (SELECT CountryID FROM @temp)

--		 SELECT CountryID AS 'ID ELIMINADO', CountryName AS 'PAIS ELIMINADO' 
--         FROM @temp 
--         WHERE CountryID = @CountryID 

--         COMMIT TRAN;
--END TRY
--BEGIN CATCH
--       SELECT ERROR_MESSAGE()
--       ROLLBACK TRAN
--END CATCH

--EXEC spDeleteCountryWithTransaction 'ERI','Eritrea'
--GO



