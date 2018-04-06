SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP-LogAuditToSqlTimer]
	@json nvarchar(max) 
AS
BEGIN
	SET NOCOUNT ON;

INSERT INTO AuditTable 
SELECT * FROM OPENJSON(@json) 
WITH(email nvarchar(100),
api_called nvarchar(20),
timeuploaded datetime2(7),msgId uniqueidentifier);

END

GO

