CREATE PROCEDURE [dbo].[AlarmadoCdrs]
AS

DECLARE @mailMsg AS VARCHAR(1000)
DECLARE @mail AS VARCHAR(500)
DECLARE @Subj AS VARCHAR(75)
DECLARE @Cliente AS CHAR(12)
DECLARE @Cliente_Fact AS CHAR(12)
DECLARE @precio_fact AS FLOAT
DECLARE @isSendMail as bit

set @isSendMail = 0

SET @mailMsg='
Los siguientes prefijos poseen codigos incorrectos que generan errores los cuales son los siguientes(Son de prueba por el area de Desarrollo):
		Cliente				Cliente Factura		Precio Total
'

DECLARE cur CURSOR FOR
select top 2 Cliente, Cliente_Fact, sum(precio_fact) precio_fact
from cdrs_202011..cdrs_05_telefonia_movil
where ambito_llamada='I' and Original_Dialed != Called_Number and
		LEN(RTRIM(Original_Dialed)) <= 9
		group by Cliente , Cliente_Fact

OPEN cur
FETCH NEXT FROM cur INTO @Cliente,@Cliente_Fact,@precio_fact

WHILE @@FETCH_STATUS=0 BEGIN
	set @mailMsg = @mailMsg + '		   '
	set @mailMsg = @mailMsg + @Cliente + '			        ' + @Cliente_Fact + '		' + convert(nvarchar,round(@precio_fact,2))
	set @mailMsg = @mailMsg +  CHAR(13) + CHAR(10)
	set @isSendMail = 1 --Correo es enviaddo
	FETCH NEXT FROM cur INTO @Cliente,@Cliente_Fact,@precio_fact
END

CLOSE cur
DEALLOCATE cur

--ENVIO DE MAIL
IF @isSendMail = 1
BEGIN
	SET @mailMsg=@mailMsg + CHAR(13) + CHAR(10) + 'Un Cordial Saludo'

	SET @mail=	'pablo.jhim.juarez.castillo@everis.com'
	SET @subj	= 'Se ha ejecutado la AlarmadoCdrs' 
	EXEC	msdb..sp_send_dbmail 
			@profile_name = N'Desarrollo'
			,@recipients = @mail
			,@subject =  @Subj
			,@body =@mailMsg
END
ELSE
BEGIN
	print 'No se Envio Correo'
END



/*-----------------------------------------------------------------------------*/

declare @sql as varchar(8000)

begin

--Cambiamos los cdrs
set @sql='select top 20
    Cliente
  , Cliente_Fact
  --, Numero_Factura
  , sum(precio_fact) precio_fact
from cdrs_202011..cdrs_05_telefonia_movil
where ambito_llamada=''I''
and Original_Dialed != Called_Number
--and id_destino=''russia''
and LEN(RTRIM(Original_Dialed)) <= 9
group by Cliente
       , Cliente_Fact
       --, Numero_Factura'

--print @sql
exec (@sql)


if	(@sql = '')
	begin
		print 'Esta correcto los prefijos';
	end
else
	begin

	execute  msdb..sp_send_dbmail 
		 @profile_name = 'Desarrollo'
		,@recipients = 'pablo.jhim.juarez.castillo@everis.com'        
		,@subject =  'Se ha ejecutado la AlarmadoCdrs'
		,@body ='Se ha ejecutado la AlarmadoCdrs'
		,@query = @sql

	end

end

GO



/*-----------------------------------------------------------------------------*/

USE [nfac]
GO

/****** Object:  StoredProcedure [dbo].[AlarmadoCdrs]    Script Date: 04/12/2020 17:42:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[AlarmadoCdrs]
AS
begin try
BEGIN

	select
Cliente
, Cliente_Fact
--, Numero_Factura
, sum(precio_fact) precio_fact
from cdrs_202011..cdrs_05_telefonia_movil
where ambito_llamada='I'
--and id_destino='russia'
and LEN(RTRIM(Original_Dialed)) <= 9
group by Cliente
, Cliente_Fact
--, Numero_Factura

END;
end try 
		begin catch
			
			PRINT N'Error Message: ' + ERROR_MESSAGE();
			
	end catch
GO


   
	   
	   
	   