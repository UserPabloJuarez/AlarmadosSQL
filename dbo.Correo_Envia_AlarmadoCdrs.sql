CREATE PROCEDURE [dbo].[Correo_Envia_AlarmadoCdrs]
AS

		declare @id int
		declare @asunto varchar(100)
		declare @destinatario varchar(500)
		declare @mensaje varchar(1000)
		declare @cliente as char(12)
		declare @cliente_fact as char(12)
		--declare @CantidadRegistros int
		declare @mensajeError varchar(1000)
		
		BEGIN TRY
		
					begin
						--Llamamos al procedimiento que envia el correo
						exec nfac.dbo.senMail_08 @cliente, @cliente_fact
					end


				END TRY
				BEGIN CATCH
					--Hay un error, enviamos el mensaje de error
					set @mensajeError='Por favor, asignar a PROV_EVERIS_N2 y a la aplicación Thor
              Se han detectado los siguientes errores de CDRS con tarificación internacional incorrecta:
              [Listado con el resultado de la Query]
             Por favor, asignar a PROV_EVERIS_N2 y a la aplicación Thor' + ERROR_MESSAGE() 
					
					exec msdb..sp_send_dbmail 
					@profile_name = N'Desarrollo'
					,@recipients = 'pablo.jhim.juarez.castillo@everis.com'	--'recipients [ ; ...n ]' ]
					,@subject =  'Alamarmado – CDRS Prefijo Internacional Incorrecto'
					,@body = @mensajeError
					
					
				END CATCH


GO