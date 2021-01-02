CREATE TABLE [dbo].[AlarmadoCdrsErrorLog](
	[ErrorLogId] [int] IDENTITY(1,1) NOT NULL,
	[ErrorTime] [datetime] NOT NULL,
	[UserName] [sysname] NOT NULL,
	[ErrorNumber] [int] NOT NULL,
	[ErrorSeverity] [int] NOT NULL,
	[ErrorState] [int] NOT NULL,
	[ErrorProcedure] [nvarchar](126) NOT NULL,
	[ErrorLine] [int] NOT NULL,
	[ErrorMessage] [varchar](2000) NOT NULL,
 CONSTRAINT [PK_AlarmadoCdrsErrorLog] PRIMARY KEY CLUSTERED 
(
	[ErrorLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[AlarmadoCdrsErrorLog] ADD  CONSTRAINT [DF_ErrorLog_ErrorTime]  DEFAULT (getdate()) FOR [ErrorTime]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for AlarmadoCdrsErrorLog records.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AlarmadoCdrsErrorLog', @level2type=N'COLUMN',@level2name=N'ErrorLogId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The date and time at wich the error occurred.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AlarmadoCdrsErrorLog', @level2type=N'COLUMN',@level2name=N'ErrorTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The user who executed the batch in which the error.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AlarmadoCdrsErrorLog', @level2type=N'COLUMN',@level2name=N'UserName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The error number of the error that ocurred.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AlarmadoCdrsErrorLog', @level2type=N'COLUMN',@level2name=N'ErrorNumber'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The severity of the error that ocurred.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AlarmadoCdrsErrorLog', @level2type=N'COLUMN',@level2name=N'ErrorSeverity'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The state number of the error that ocurred.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AlarmadoCdrsErrorLog', @level2type=N'COLUMN',@level2name=N'ErrorState'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The name of the stored procedure or trigger wher.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AlarmadoCdrsErrorLog', @level2type=N'COLUMN',@level2name=N'ErrorProcedure'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The message text of the error that ocurred.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AlarmadoCdrsErrorLog', @level2type=N'COLUMN',@level2name=N'ErrorMessage'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Audit tablet traccking errors in the the adventure.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AlarmadoCdrsErrorLog'
GO