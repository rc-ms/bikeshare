SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP-BulkInsertFromBlob]
	@filename nvarchar(max) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM OPENROWSET(
        BULK '@filename',
        DATA_SOURCE = 'MyAzureBlobs',
        SINGLE_CLOB) AS DataFile;

        BULK INSERT EventsLatLongStage
        FROM '@filename'
        WITH (DATA_SOURCE = 'MyAzureBlobs',
            FIRSTROW = 2,
            FORMAT = 'CSV');
END
GO
