
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP-MoveLatLongEvents] 
	-- Add the parameters for the stored procedure here
	@var1 int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Events(
				   [bike_id]
				  ,[time]
				  ,[location]
				  ,[event_type]
				  ,[rider_id]
				  ,[rider_gender]
				  ,[rider_age]
				  ,[rider_resident]
				  ,[message_id]
				  )
		SELECT 
		   [bike_id]
		  ,[time]
		  ,GEOGRAPHY::Point([Latitude], [Longitude], 4326)
		  ,[event_type]
		  ,[rider_id]
		  ,[rider_gender]
		  ,[rider_age]
		  ,[rider_resident]
		  ,[message_id]		
		FROM EventsLatLongStage
		WHERE [Latitude] IS NOT NULL AND [Longitude] IS NOT NULL

		-- Delete Source Temp Records
		DELETE FROM EventsLatLongStage


		--Grab lat/long=null values and ignore GEO
	INSERT INTO Events(
				   [bike_id]
				  ,[time]
				  ,[event_type]
				  ,[rider_id]
				  ,[rider_gender]
				  ,[rider_age]
				  ,[rider_resident]
				  )
		SELECT 
		   [bike_id]
		  ,[time]
		  ,[event_type]
		  ,[rider_id]
		  ,[rider_gender]
		  ,[rider_age]
		  ,[rider_resident]		
		FROM EventsLatLongStage
		WHERE [Latitude] IS NULL OR [Longitude] IS NULL
		
		DELETE FROM EventsLatLongStage


END
GO


