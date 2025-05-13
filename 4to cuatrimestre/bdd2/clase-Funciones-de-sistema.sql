--1) Creo una función para determinar la edad sin usar funciones del sistema
CREATE FUNCTION dbo.CalcularEdadManual (@AnioNacimiento INT,@AnioActual INT)
RETURNS INT
AS
BEGIN
    RETURN @AnioActual - @AnioNacimiento;
END;

--SELECT dbo.CalcularEdadManual(1990, 2025) AS Edad;
--DROP FUNCTION dbo.CalcularEdadManual; --eliminar funcion

--2) Uso la función predeterminada del sistema GETDATE() y YEAR() para obtener la edad actual

CREATE FUNCTION dbo.CalcularEdadSistema (@AnioNacimiento INT)
RETURNS INT
AS
BEGIN
    RETURN YEAR(GETDATE()) - @AnioNacimiento;
END;


--SELECT dbo.CalcularEdadSistema(1990) AS Edad;
--DROP FUNCTION dbo.CalcularEdadSistema; --eliminar funcion

----------------------------------------------------------------------
--funciones de configuracion

SELECT @@VERSION AS VersionSQL; -- Retorna la fecha, versión y tipo de procesador de SQL Server.
SELECT DB_NAME() AS BaseDatosActual; -- Retorna la base de datos actual
SELECT HOST_NAME() AS Cliente; -- Retorna el nombre del equipo que se conecta

-------------------------------------------------------------------------
--Funciones De agregado

 SELECT COUNT(*) AS CantidadEmpleados FROM [Northwind].[dbo].[Employees]

 SELECT OrderID, SUM(Quantity) AS TotalProductosPorOrden
   FROM [Northwind].[dbo].[Order Details] GROUP BY OrderID;

-----------------------------------------------------------------------
--Funciones de Fecha y Hora
SELECT GETDATE();
SELECT SYSDATETIME();
SELECT DATEADD(day, 1, GETDATE())AS FechaMas1Dias; 
SELECT DATEADD(month, 1, GETDATE())AS FechaMas1Mes; 
SELECT DATEADD(YEAR, -1, GETDATE()) AS FechaMenos1Anio;

SELECT DATEDIFF(month, '2025-01-01', GETDATE())AS MesesDeDiferencia;;
SELECT DATEDIFF(day, '2025-04-01', '2025-04-25') AS DiasDeDiferencia;
SELECT DATEDIFF(year, '2020-01-01', GETDATE()) AS AñosTranscurridos;
----------------------------------------------------------
--Funciones de Conversión
select CONVERT(VARCHAR(10),GETDATE(),103)

DECLARE @dato varchar(2),@dato2 int
SET @dato = '27'
SELECT @dato+'2'
SET @dato2 = cast(@dato AS int)
SELECT @dato2+'2' 

----------------------------------------------------------
--Funciones matemáticas

SELECT ABS(-55) AS ValorAbsoluto;
SELECT ROUND(120.4967, 2) AS ResultadoDecimales;
SELECT ROUND(89.45, 0) AS ResultadoEntero;
--------------------------------------------------
--Funciones para el manejo de cadenas
select substring('Buenas tardes',8,6); 

SELECT CHARINDEX('OM', 'Customer') AS Posicion;
SELECT CHARINDEX('OM', 'Customer',6) AS Posicion;

SELECT position = PATINDEX('%ter%', 'interesting data'); 

select str(123456.67,7,3)
SELECT STR(12345.6789, 7, 3) AS Resultado;

select len('Hola'); 
select char(65); 
select left('buenos dias',8); 
select right('buenos dias',8); 
select lower('HOLA ESTUDIAnte'); 
select upper('HOLA ESTUDIAnte'); 
select ltrim(' Hola '); 
select rtrim('      Hola estudiante  '); 
select replace('zzz.unlam.edu.ar','z','w'); 
select reverse('Hola'); 
select patindex('%Luis%', 'Jorge Luis Borges');
select patindex('%or%', 'Jorge Luis Borges'); 
select patindex('%ar%', 'Jorge Luis Borges'); 
select replicate ('Hola',3); 
select 'Hola'+space(1)+'que tal'; 













