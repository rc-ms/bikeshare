SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP-UpdateBulkInsertRights]
	@secret nvarchar(max),
	@location nvarchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE @command varchar(MAX);

SET @command = 'ALTER DATABASE SCOPED CREDENTIAL BlobUploadUser 
     WITH IDENTITY = ''SHARED ACCESS SIGNATURE'',   
     SECRET =''' + @secret + ''''

EXECUTE (@command)

DECLARE @command2 varchar(MAX);
SET @command2 = 'ALTER EXTERNAL DATA SOURCE MyAzureBlobs 
SET  
CREDENTIAL = BlobUploadUser,
LOCATION ='''+ @location+ ''''
         
EXECUTE (@command2)

END

GO


