--==============STORED PROCEDURES FOR LANGUAGE TABLE===========================
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
--This procedure receives 1 parameter LanguageID which is a char(3)
--Example: EXEC spSelectLanguage 'DEU'  

CREATE OR ALTER PROCEDURE spSelectLanguage
(
  @LanguageID char(3)
)
AS
BEGIN
    SELECT * FROM dbo.Language
	  WHERE LanguageID = @LanguageID
END
GO




--===========================INSERT============================================

--This procedure receives 2 parameters, LanguageID, Language.
--The SP should show the record that was inserted. 
--Example: EXEC spInsertLanguageWithTransaction 'TOT','Totonaca'

CREATE OR ALTER PROCEDURE spInsertLanguageWithTransaction
(
    @LanguageID   char(3),
	@Language varchar(20)
	
)
AS
BEGIN TRY
     BEGIN TRAN
	     SELECT COUNT(*) AS 'TOTAL RECORDS BEFORE TRANSACTION' FROM dbo.Language
	     DECLARE @temp TABLE
		 (
		   LanguageID   char(3),
		   Language     varchar(20)
		 )

     	 INSERT INTO dbo.Language OUTPUT INSERTED.LanguageID, INSERTED.Language INTO @temp
     	 VALUES(@LanguageID, @Language)

		 SET @LanguageID  = (SELECT LanguageID FROM @temp)

		 SELECT * FROM dbo.Language WHERE LanguageID = @LanguageID

		 SELECT COUNT(*) AS 'TOTAL RECORDS AFTER TRANSACTION' FROM dbo.Language
       COMMIT TRAN;
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS

END CATCH
GO



--===========================UPDATE===================================================
--This procedure receives 2 parameters, LanguageID and Language.
--The SP should show the record that was updated. 
--Example: EXEC spUpdateLanguageWithTransaction 'TOT','Taran'


CREATE OR ALTER PROCEDURE spUpdateLanguageWithTransaction
(
	@LanguageID   char(3),
	@Language varchar(20)
)
AS
BEGIN TRY
     BEGIN TRAN

     	   UPDATE dbo.Language
           SET Language = @Language
     	   WHERE LanguageID = @LanguageID 

		   SELECT * FROM dbo.Language WHERE LanguageID = @LanguageID
		  
      COMMIT TRAN
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS

END CATCH
GO




--==================================DELETE==============================================
--This procedure receives 1 parameter, LanguageID which is a char(3).  
--The SP should show the record that was deleted. 
--Example: EXEC spDeleteLanguageWithTransaction 'TOT'

CREATE OR ALTER PROCEDURE spDeleteLanguageWithTransaction
(
	@LanguageID char(3)

)
AS
BEGIN TRY
     BEGIN TRAN
	     SELECT COUNT(*) AS 'TOTAL RECORDS BEFORE TRANSACTION' FROM dbo.Language
	     DECLARE @temp TABLE
		 (
		   LanguageID   char(3),
		   Language varchar(20)
		 )

     	 DELETE FROM dbo.Language OUTPUT DELETED.LanguageId, DELETED.Language INTO @temp
		 WHERE LanguageID = @LanguageID 

		 SET @LanguageID = (SELECT LanguageID FROM @temp)

		 SELECT LanguageID AS 'DELETED ID ', Language AS 'DELETED LANGUAGE' 
         FROM @temp 
         WHERE LanguageID = @LanguageID 
		 SELECT COUNT(*) AS 'TOTAL RECORDS AFTER TRANSACTION' FROM dbo.Language

         COMMIT TRAN;
END TRY
BEGIN CATCH
       ROLLBACK TRAN
       SELECT * FROM SHOW_ERRORS
END CATCH
GO







