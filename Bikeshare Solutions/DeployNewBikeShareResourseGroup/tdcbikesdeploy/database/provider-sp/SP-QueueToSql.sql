SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP-QueueToSql] 
	-- Add the parameters for the stored procedure here
	@bikeid nvarchar(max),
	@time datetime,
	@longitude int,
	@latitude int,
    @event_type nvarchar(max),
	@riderId nvarchar(max),
	@gender nvarchar(max),
	@age int,
	@resident int,
	@msgId uniqueidentifier

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
		VALUES (
		    @bikeid
		  , @time
		  , GEOGRAPHY::Point(@latitude, @longitude, 4326)
		  , @event_type
		  , @riderId
		  , @gender
		  , @age
		  , @resident
		  , @msgId);		

		  END
GO

