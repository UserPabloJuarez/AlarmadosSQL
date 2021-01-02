CREATE PROCEDURE [dbo].[LogErrorAlarmadoCdrs]
	@ErrorLogId int = 0 OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	--
	SET @ErrorLogId = 0;
	
	BEGIN TRY
	
		IF ERROR_NUMBER() IS NULL
			RETURN;
			
		IF XACT_STATE() = -1
		BEGIN
			PRINT 'Cannot log error since the current transaction is in an uncommittable state. '
			+ 'Rollback the transaction before executing LogErrorAlarmadoCdrs in order to successfully log error information.'
			RETURN;
		END
		
		INSERT [dbo].[AlarmadoCdrsQLErrorLog]
		(
			[UserName],
			[ErrorNumber],
			[ErrorSeverity],
			[ErrorState],
			[ErrorProcedure],
			[ErrorLine],
			[ErrorMessage]
		)
		VALUES
		(
			CONVERT(sysname, CURRENT_USER),
			ERROR_NUMBER(),
			ERROR_SEVERITY(),
			ERROR_STATE(),
			ERROR_PROCEDURE(),
			ERROR_LINE(),
			ERROR_MESSAGE()
		);
		
		SET @ErrorLogId = @@IDENTITY;

		
	END TRY
	BEGIN CATCH
		PRINT 'An error occurred in store procedure LogErrorAlarmadoCdrs: ';
		EXECUTE [dbo].[PrintErrorAlarmadoCdrs];
		RETURN -1;
	END CATCH

	
	PRINT N'---------------------------------------';
	
	BEGIN TRY
	BEGIN
		--Llamamos al procedimiento
		exec dbo.Correo_Envia_AlarmadoCdrs
	END

	END TRY
	BEGIN CATCH
		PRINT 'An error occurred in store procedure LogErrorAlarmadoCdrs: ';
		PRINT N'Error Message: ' + ERROR_MESSAGE();
	END CATCH
	END
GO