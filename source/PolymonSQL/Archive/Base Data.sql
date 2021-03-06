SET NOCOUNT ON


--LookupEventStatus--

delete from LookupEventStatus

insert into LookupEventStatus(StatusID, Status) values(1, 'OK')
insert into LookupEventStatus(StatusID, Status) values(2, 'Warning')
insert into LookupEventStatus(StatusID, Status) values(3, 'Fail')

 

--SysSettings--

delete from SysSettings

insert into SysSettings (Name, IsEnabled, ServiceServer, MainTimerInterval, UseInternalSMTP, SMTPFromName, SMTPFromAddress, ExtSMTPPort, DBVersion) values('PolyMon', 1, '127.0.0.1', 60, 0, 'PolyMon', '<insert you From email address here>', 25, 1.0)

 

--MonitorType--

delete from MonitorType

insert into MonitorType (Name, MonitorAssembly, EditorAssembly, MonitorXMLTemplate) values('Ping Monitor', 'PingMonitor.dll', 'PingMonitorEditor.dll', '<PingMonitor>
	<Host></Host>
	<NumTries>5</NumTries>
	<MaxFail>2</MaxFail>
	<Timeout>2000</Timeout>
	<TTL>32</TTL>
	<DataSize>32</DataSize>
</PingMonitor>')

insert into MonitorType (Name, MonitorAssembly, EditorAssembly, MonitorXMLTemplate) values('SNMP Monitor', 'SNMPMonitor.dll', 'SNMPMonitorEditor.dll', '<SNMPMonitor>
	<Host></Host>
	<Port>161</Port>
	<ReadCommunity>public</ReadCommunity>
	<OID></OID>
	<Timeout></Timeout>
	<Threshold DataType="Numeric" Comparison="&gt;"></Threshold>
</SNMPMonitor>')

insert into MonitorType (Name, MonitorAssembly, EditorAssembly, MonitorXMLTemplate) values('URL Monitor', 'URLMonitor.dll', 'URLMonitorEditor.dll', '<URLMonitor>
	<URL>http://</URL>
	<Timeout>30</Timeout>
   	<WarnLoadTime Enabled="0"></WarnLoadTime>
	<FailCheckContent Enabled="0"></FailCheckContent>
	<WarnCheckContent Enabled="0"></WarnCheckContent>
</URLMonitor>')

insert into MonitorType (Name, MonitorAssembly, EditorAssembly, MonitorXMLTemplate) values('Service Monitor', 'ServiceMonitor.dll', 'ServiceMonitorEditor.dll', '<ServiceMonitor>
	<Host></Host>
	<ServiceName></ServiceName>
	<NominalStateIsRunning>1</NominalStateIsRunning>
</ServiceMonitor>')

insert into MonitorType (Name, MonitorAssembly, EditorAssembly, MonitorXMLTemplate) values('File Monitor', 'FileMonitor.dll', 'FileMonitorEditor.dll', '<FileMonitor>
	<DirPath></DirPath>
	<FilePattern>*.*</FilePattern>
   	<WarnCount Enabled="0"></WarnCount>
	<MaxCount Enabled="0"></MaxCount>
	<MaxAge Enabled="0" AgeType=''minutes'' DateType=''created'' FileType=''oldest''></MaxAge>
   	<EnableCounters>1</EnableCounters>
</FileMonitor>')

insert into MonitorType (Name, MonitorAssembly, EditorAssembly, MonitorXMLTemplate) values('Performance Monitor', 'PerfMonitor.dll', 'PerfMonitorEditor.dll', '<PerfMonitor>
	<Host></Host>
	<Category></Category>
	<Counter></Counter>
	<Instance></Instance>
	<FailThresholds>
        		<Max Enabled="0"></Max>
        		<Min Enabled="0"></Min>
    	</FailThresholds>
    	<WarnThresholds>
        		<Max Enabled="0"></Max>
        		<Min Enabled="0"></Min>
    	</WarnThresholds>
</PerfMonitor>')

insert into MonitorType (Name, MonitorAssembly, EditorAssembly, MonitorXMLTemplate) values('SQL Monitor', 'SQLMonitor.dll', 'GenericXMLEditor.dll', '<SQLMonitor>
    <ConnectionString>...</ConnectionString>
    <SP>
        <Name>...</Name>
        <Parameters>
            <Parameter Name="...">...</Parameter>
        </Parameters>
    </SP>
</SQLMonitor>')

insert into MonitorType (Name, MonitorAssembly, EditorAssembly, MonitorXMLTemplate) values('TcpPortMonitor', 'TcpPortMonitor.dll', 'TcpPortMonitorEditor.dll', '<TcpMonitor>
	<Host></Host>
	<Port></Port>
	<Timeout>2000</Timeout>
</TcpMonitor>')

insert into MonitorType (Name, MonitorAssembly, EditorAssembly, MonitorXMLTemplate) values('URL XML Monitor', 'urlxmlmonitor.dll', 'urlxmlmonitoreditor.dll', '<URLXMLMonitor>
	<URL></URL>
	<Timeout>30</Timeout>
   	<WarnLoadTime Enabled="1">20</WarnLoadTime>
	<FailCheckContent Enabled="1" Negated="1">//node[@attr=''abc'']</FailCheckContent>
	<WarnCheckContent Enabled="1" Negated="1"></WarnCheckContent>
</URLXMLMonitor>')

insert into MonitorType (Name, MonitorAssembly, EditorAssembly, MonitorXMLTemplate) values('WMI Monitor', 'WMIMonitor.dll', 'WMIMonitorEditor.dll', '<WMIMonitor>
	<Host></Host>
	<Query></Query>
	<Failure Enable="0" Operator=">" Value=""/>
	<Warning Enable="0" Operator=">" Value=""/>
</WMIMonitor>')

insert into MonitorType (Name, MonitorAssembly, EditorAssembly, MonitorXMLTemplate) values('CPU Monitor', 'CPUMonitor.dll', 'CPUMonitorEditor.dll', '<CPUMonitor>
	<Host></Host>
	<Fail Enabled="0" Type="All"></Fail>
	<Warn Enabled="0" Type="All"></Warn>
</CPUMonitor>')

insert into MonitorType (Name, MonitorAssembly, EditorAssembly, MonitorXMLTemplate) values('Disk Monitor', 'DiskMonitor.dll', 'DiskMonitorEditor.dll', '<DiskMonitor>
	<Drive></Drive>
	<TempNetMapDrive></TempNetMapDrive>
	<WarnMB>1024</WarnMB>
	<FailMB>512</FailMB>
	<ReportErrorAs>Fail</ReportErrorAs>
</DiskMonitor>')

insert into MonitorType (Name, MonitorAssembly, EditorAssembly, MonitorXMLTemplate) values('PowerShell Monitor', 'powershellmonitor.dll', 'powershellmonitoreditor.dll', '<PowerShellMonitor>
	<Script>
#Set Monitor status as follows:
#   $Status.StatusID=
#   $Status.StatusText=" "
# where StatusID is: 1=OK, 2=Warn, 3=Fail

#Specify Counter values by adding them to the $Counters object as follows:
# $Counters.Add("Counter Name", CounterValue)
# where CounterValue is of type double

# Example
# $Status.StatusText="OK."
# $Status.StatusID=1

# $Counters.Add("Counter 1", 10)
# $Counters.Add("Counter 2", 20)
#$Counters.Add("Counter 3", 30)
	</Script>
</PowerShellMonitor>')


--Executive--

delete from Executive

set IDENTITY_INSERT Executive ON

insert into Executive (ExecutiveID, Server) values(1, '127.0.0.1')

set IDENTITY_INSERT Executive OFF

--Retention Scheme Schedule--

delete from Monitor

declare @MonitorTypeID int

select @MonitorTypeID =MonitorTypeID from MonitorType where Name = 'SQL Monitor'

insert into Monitor (Name, MonitorTypeID, MonitorXML, OfflineTime1Start, OfflineTime1End, OfflineTime2Start, OfflineTime2End,
	MessageSubjectTemplate, MessageBodyTemplate, TriggerMod, IsEnabled, ExecutiveID) 
	values('Retention Scheme Job', @MonitorTypeID, '<SQLMonitor>
    <ConnectionString>Provider=SQLOLEDB.1;Data Source=XPDCFBAPTISTE;Initial Catalog=PolyMon; Integrated Security=SSPI;</ConnectionString>
    <SP>
        <Name>agg_Monitor_ApplyRetentionScheme</Name>
        <Parameters>
        </Parameters>
    </SP>
</SQLMonitor>', '00:00', '00:00', '00:00', '00:00', '<%Monitor%> - <%Status%> - <%MonitorType%>', '<%Monitor%>
==================================
<%MonitorType%>
==================================
Status: <%Status%>
Time: <%EventDT%>
==================================
<%EventMessage%>
==================================

Description: Runs the Retention Management job', 720, 1, 1)




/*Generate TS Lookups*/
set nocount on

Declare @StartDT datetime
Declare @EndDT datetime
set @StartDT = '2006-01-01 00:00:00'
set @EndDT = '2020-12-31 00:00:00'

Declare @StartYear int
Declare @EndYear int
set @StartYear = year(@StartDT)
set @EndYear = year(@EndDT)

Declare @Cnt int
Declare @CurrDate datetime
Declare @CurrYear int
Declare @CurrWeek smallint
Declare @LastWeekNum smallint
Declare @WeekStart datetime
Declare @WeekEnd datetime
Declare @CurrMonth tinyint
Declare @MonthStart datetime
Declare @MonthEnd datetime
Declare @YearStart datetime
Declare @YearEnd datetime


--Daily
Delete from TSDaily
set @Cnt=1
set @CurrDate = @StartDT
while @CurrDate < @EndDT
	begin
	insert into TSDaily (TimespanID, Year, Month, Day, DT)
	values (@Cnt, year(@CurrDate), month(@CurrDate), day(@CurrDate), cast(convert(varchar(10), @CurrDate, 120) + ' 00:00:00' as datetime))
	set @Cnt=@Cnt+1
	set @CurrDate = dateadd(dd, 1, @CurrDate)
	end



--Weekly
SET DATEFIRST 7 --sets first day of week to Sunday.

Delete from TSWeekly

set @CurrYear = @StartYear
set @Cnt=1
while @CurrYear<=@EndYear
	begin
	--For each year, calculate weeks
	set @CurrWeek = 1
	set @LastWeekNum = datepart(week, cast(cast(@CurrYear as varchar(4)) + '-12-31' as datetime))

	set @WeekStart = cast(cast(@CurrYear as varchar(4)) + '-01-01' as datetime)

	while @CurrWeek<=@LastWeekNum
		begin
		set @WeekEnd = dateadd(day, 7 - datepart(dw, @WeekStart), @WeekStart)

		if @WeekStart < cast(cast(@CurrYear as varchar(4)) + '-01-01' as datetime)
			set @WeekStart = cast(cast(@CurrYear as varchar(4)) + '-01-01' as datetime)
		if @WeekEnd > cast(cast(@CurrYear as varchar(4))+ '-12-31' as datetime)
			set @WeekEnd = cast(cast(@CurrYear as varchar(4)) + '-12-31' as datetime)

		insert into TSWeekly (TimespanID, Year, WeekOfYear, StartDT, EndDT)
		values(@Cnt, @CurrYear, datepart(week, @WeekStart), @WeekStart, @WeekEnd)
		

		set @CurrWeek = @CurrWeek + 1
		set @Cnt=@Cnt+1
		set @WeekStart = dateadd(day, 1, @WeekEnd)
		end

	--Move to next year
	set @CurrYear = @CurrYear + 1
	end



--Monthly
Delete from TSMonthly
set @Cnt=1
set @CurrYear = @StartYear


while @CurrYear <= @EndYear 
	begin
	set @CurrMonth = 1
	while @CurrMonth <= 12
		begin
		set @MonthStart = cast(cast(@CurrYear as varchar(4)) + '-' + cast(@CurrMonth as varchar(2)) + '-01'  as datetime)
		set @MonthEnd = dateadd(dd,-1,dateadd(mm,1,@MonthStart))
		insert into TSMonthly (TimespanID, Year, Month, StartDT, EndDT)
		values(@Cnt, @CurrYear, @CurrMonth, @MonthStart, @MonthEnd)
		set @CurrMonth = @CurrMonth + 1
		set @Cnt = @Cnt + 1
		end
	set @CurrYear = @CurrYear+1
	end





