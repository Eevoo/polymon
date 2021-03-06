SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[fn_IsOfflineTime]
(@OTStart char(5), @OTEnd char(5), @CurrDT datetime)
RETURNS bit AS  
BEGIN 

Declare @QTStart int
Declare @QTEnd int
Declare @CurrTime as integer

set @QTStart=cast(replace(coalesce(@OTStart, '00:00'), ':', '') as int)
set @QTEnd = cast(replace(coalesce(@OTEnd, '00:00'), ':', '') as int)

set @CurrTime =  cast(replace(convert(varchar(5), @CurrDT, 8), ':', '') as integer)

Declare @IsQT bit

set @IsQT=0

if @QTStart<@QTEnd
	begin
	--straight test
	if @CurrTime>=@QTStart and @CurrTime<=@QTEnd
		set @IsQT=1
	end

if @QTStart>@QTEnd
	begin
	--split test over 24:00
	if (@CurrTime>=@QTStart and @CurrTime <=2400) or (@CurrTime<=@QTEnd)
		set @IsQT=1
	end

return @IsQT
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Fred Baptiste
-- Create date: 6/8/2006
-- Description:	Returns Current StatusID for specified Monitor
-- =============================================
CREATE FUNCTION [dbo].[fn_MonitorCurrentStatusID] 
(
	-- Add the parameters for the function here
	@MonitorID int
)
RETURNS tinyint
AS
BEGIN
	DECLARE @Result tinyint


	Declare @LastEventID int

	select @LastEventID = max(EventID)
	from MonitorEvent
	where MonitorID=@MonitorID

	select @Result = MonitorEvent.StatusID
	from MonitorEvent
	where MonitorEvent.EventID = @LastEventID

	-- Return the result of the function
	RETURN @Result

END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Fred Baptiste
-- Create date: 10/5/2006
-- Description:	Returns DT of previous event
-- =============================================
CREATE FUNCTION [dbo].[fn_PrevEventDT] 
(
	-- Add the parameters for the function here
	@MonitorID int,
	@CurrEventID int
)
RETURNS datetime
AS
BEGIN
	Declare @PrevEventID int

	select @PrevEventID=max(EventID) from MonitorEvent where MonitorID=@MonitorID and EventID<@CurrEventID

	Declare @PrevDT datetime
	select @PrevDT = EventDT from MonitorEvent where EventID=@PrevEventID

	-- Return the result of the function
	RETURN @PrevDT

END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Fred Baptiste
-- Create date: 10/5/2006
-- Description:	Calculates lifetime % uptime for specified Monitor
-- =============================================
CREATE FUNCTION [dbo].[fn_LifetimePercUptime] 
(
	-- Add the parameters for the function here
	@MonitorID int
)
RETURNS decimal(6,3)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result decimal(6,3)

	select 	@Result = 
				case 
					when sum(abs(UpDownTimeSecs))=0 then 
						0 
					else 
						cast(100*(1-cast((sum(abs(UpDownTimeSecs))-sum(UpDownTimeSecs))/2 as float) / cast(sum(abs(UpDownTimeSecs)) as float)) as decimal(6,3)) 
				end
	from MonitorEvent
	where MonitorID=@MonitorID

	return coalesce(@Result,0)
END



GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Fred Baptiste
-- Create date: 10/5/2006
-- Description:	Calculates % uptime for specified Monitor and timeframe
-- =============================================
CREATE FUNCTION [dbo].[fn_PercUptime] 
(
	-- Add the parameters for the function here
	@MonitorID int,
	@StartDT datetime,
	@EndDT datetime
)
RETURNS decimal(6,3)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result decimal(6,3)

	select 	@Result = case
			when sum(abs(UpDownTimeSecs))=0 then
				0
			else
				cast(100*(1-cast((sum(abs(UpDownTimeSecs))-sum(UpDownTimeSecs))/2 as float) / cast(sum(abs(UpDownTimeSecs)) as float)) as decimal(6,3))
			end
	from MonitorEvent
	where MonitorID=@MonitorID
	and EventDT between @StartDT and @EndDT
	
	return coalesce(@Result,0)
END



GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Fred Baptiste
-- Create date: 6/8/2006
-- Description:	Returns Current Status of specified Monitor
-- =============================================
CREATE FUNCTION [dbo].[fn_MonitorCurrentStatus] 
(
	-- Add the parameters for the function here
	@MonitorID int
)
RETURNS varchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result varchar(50)


	Declare @LastEventID int

	select @LastEventID = max(EventID)
	from MonitorEvent
	where MonitorID=@MonitorID

	select @Result = LookupEventStatus.Status
	from MonitorEvent
		inner join LookupEventStatus on MonitorEvent.StatusID=LookupEventStatus.StatusID
	where MonitorEvent.EventID = @LastEventID

	-- Return the result of the function
	RETURN @Result

END


