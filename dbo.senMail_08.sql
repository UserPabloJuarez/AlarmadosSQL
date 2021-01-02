CREATE PROCEDURE [dbo].[senMail_08]
--@asunto as varchar(1000),
--@mensaje as varchar(4000),
--@rc as int output,
@cliente as char(12),
@cliente_fact as char(12)

as 
begin
	DECLARE @destinatario varchar(500)
	DECLARE @sql nvarchar(4000)
	DECLARE @asunto varchar(1000)
	DECLARE @mensaje varchar(4000)
	
	SET @sql = '
	select TOP 1 cliente, cliente_fact, ErrorLine, ErrorMessage  
	from (cdrs_202011..cdrs_05_telefonia_movil CROSS JOIN AlarmadoCdrsErrorLog) order by Fecha_Scoring desc'
	
	SET @mensaje = @mensaje + 'Por favor, asignar a PROV_EVERIS_N2 y a la aplicación Thor
              Se han detectado los siguientes errores de CDRS con tarificación internacional incorrecta:
              [Listado con el resultado de la Query]
             Por favor, asignar a PROV_EVERIS_N2 y a la aplicación Thor' + char(13)

	SET @destinatario = 'pablo.jhim.juarez.castillo@everis.com'

	SET @asunto = 'Alamarmado – CDRS Prefijo Internacional Incorrecto'

exec msdb..sp_send_dbmail
	@profile_name = 'Desarrollo'
	,@recipients = @destinatario
	,@subject = @asunto
	,@body = @mensaje
	,@query = @sql
	
	end
GO