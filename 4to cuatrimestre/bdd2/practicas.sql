USE [AdventureWorks2014]
GO

/*Listar los c�digos y descripciones de todos los productos */
SELECT [ProductID],[Name] FROM [Production].[Product]
GO

/*Listar los datos de la subcategor�a n�mero 17*/
SELECT * FROM [Production].[ProductSubcategory] WHERE ProductSubcategoryID = 17;
GO

/*Listar los productos cuya descripci�n comience con D */
SELECT p.Name, pd.Description
FROM [Production].[Product] p
	JOIN [Production].[ProductModel] pm ON p.ProductModelID = pm.ProductModelID
	JOIN [Production].[ProductModelProductDescriptionCulture] pdpc ON pm.ProductModelID = pdpc.ProductModelID
	JOIN [Production].[ProductDescription] pd ON pdpc.ProductDescriptionID = pd.ProductDescriptionID
WHERE pd.Description LIKE 'D%';

/*Listar las descripciones de los productos cuyo n�mero finalice con 8 (Ayuda: ProductNumber like �%8�)*/
SELECT pd.Description
FROM [Production].[Product] p
	JOIN [Production].[ProductModel] pm ON p.ProductModelID = pm.ProductModelID	
	JOIN [Production].[ProductModelProductDescriptionCulture] pdpc ON pm.ProductModelID = pdpc.ProductModelID
	JOIN [Production].[ProductDescription] pd ON pdpc.ProductDescriptionID = pd.ProductDescriptionID 
WHERE p.ProductNumber LIKE '%8';

/*Listar aquellos productos que posean un color asignado. Se deber�n excluir todos aquellos que no posean ning�n valor*/
SELECT * FROM [Production].[Product] p
WHERE p.Color IS NOT NULL;

/*Listar el c�digo y descripci�n de los productos de color Black (Negro) y que posean el nivel de stock en 500. */
SELECT p.ProductID, pd.Description
FROM [Production].[Product] p
	JOIN [Production].[ProductModel] pm ON p.ProductModelID = pm.ProductModelID	
	JOIN [Production].[ProductModelProductDescriptionCulture] pdpc ON pm.ProductModelID = pdpc.ProductModelID
	JOIN [Production].[ProductDescription] pd ON pdpc.ProductDescriptionID = pd.ProductDescriptionID
WHERE p.Color = 'Black' AND p.SafetyStockLevel = 500;

/*Listar los productos que sean de color Black (Negro) � Silver(Plateado).*/
SELECT * FROM [Production].[Product] p WHERE p.Color = 'Black' OR p.Color = 'Silver';

/*Listar los diferentes colores que posean asignados los productos.*/
SELECT DISTINCT p.Color FROM [Production].[Product] p;

/*Contar la cantidad de categor�as que se encuentren cargadas en la base. (Ayuda: count) */
SELECT COUNT(*) FROM [Production].[ProductCategory];

/*Contar la cantidad de subcategor�as que posee asignada la categor�a 2. */
SELECT COUNT(*) FROM [Production].[ProductSubcategory] WHERE ProductCategoryID = 2;

/*Listar la cantidad de productos que existan por cada uno de los colores*/
SELECT COUNT(*) FROM [Production].[Product] p GROUP BY p.Color;

/*Sumar todos los niveles de stocks aceptables que deben existir para los productos con color Black. */
SELECT SUM(p.SafetyStockLevel) FROM [Production].[Product] p WHERE p.Color = 'Black';

/*Calcular el promedio de stock que se debe tener de todos los productos cuyo c�digo se encuentre entre el 316 y 320.*/
SELECT AVG(p.SafetyStockLevel) FROM [Production].[Product] p WHERE p.ProductID BETWEEN 316 AND 320;

/* Listar el nombre del producto y la descripci�n de la subcategor�a que posea asignada */
SELECT p.Name AS NombreProducto, ps.Name AS DescripcionSubcategoria
FROM [Production].[Product] p
INNER JOIN [Production].[ProductSubcategory] ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID;

/*Listar todas las categor�as que poseen asignado al menos una subcategor�a. Se deber�n excluir aquellas que no posean ninguna.*/
SELECT * FROM [Production].[ProductCategory] pc INNER JOIN [Production].[ProductSubcategory] ps ON pc.ProductCategoryID = ps.ProductCategoryID

/*Listar el c�digo y descripci�n de los productos que posean fotos asignadas.*/
SELECT p.ProductID, pd.Description
FROM [Production].[Product] p
	JOIN [Production].[ProductModel] pm ON p.ProductModelID = pm.ProductModelID		
	JOIN [Production].[ProductModelProductDescriptionCulture] pdpc ON pm.ProductModelID = pdpc.ProductModelID
	JOIN [Production].[ProductDescription] pd ON pdpc.ProductDescriptionID = pd.ProductDescriptionID
	JOIN [Production].[ProductProductPhoto] ppp ON p.ProductID = ppp.ProductID
	JOIN [Production].[ProductPhoto] pp ON ppp.ProductPhotoID = pp.ProductPhotoID	

/*Listar la cantidad de productos que existan por cada una de las Clases */
SELECT COUNT(*), p.Class FROM [Production].[Product] p
GROUP BY p.Class;

/*Listar la descripci�n de los productos y su respectivo color. S�lo nos interesa caracterizar al color con los valores: Black, Silver u Otro. Por lo cual si no es ni silver ni black se debe indicar Otro */
SELECT pd.Description,
	CASE 
		WHEN p.Color = 'Black' THEN 'Black'
		WHEN p.Color = 'Silver' THEN 'Silver'
		ELSE 'Otro'
	END AS ColorCaracterizado
FROM [Production].[Product] p
	JOIN [Production].[ProductModel] pm ON p.ProductModelID = pm.ProductModelID	
	JOIN [Production].[ProductModelProductDescriptionCulture] pdpc ON pm.ProductModelID = pdpc.ProductModelID
	JOIN [Production].[ProductDescription] pd ON pdpc.ProductDescriptionID = pd.ProductDescriptionID

/*Listar el nombre de la categor�a, el nombre de la subcategor�a y la descripci�n del producto*/
SELECT pc.Name AS NombreCategoria, ps.Name AS NombreSubcategoria, pd.Description AS DescripcionProducto
FROM [Production].[Product] p
	JOIN [Production].[ProductSubcategory] ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
	JOIN [Production].[ProductCategory] pc ON ps.ProductCategoryID = pc.ProductCategoryID
	JOIN [Production].[ProductModel] pm ON p.ProductModelID = pm.ProductModelID
	JOIN [Production].[ProductModelProductDescriptionCulture] pdpc ON pm.ProductModelID = pdpc.ProductModelID
	JOIN [Production].[ProductDescription] pd ON pdpc.ProductDescriptionID = pd.ProductDescriptionID

/*Listar la cantidad de subcategor�as que posean asignado los productos.*/
SELECT COUNT(DISTINCT p.ProductSubcategoryID) FROM [Production].[Product] p


/************************************************************************************************************************************************************/

/*Listar los nombres de los productos y el nombre del modelo que posee asignado. Solo listar aquellos que tengan asignado alg�n modelo. */
SELECT p.Name AS NombreProducto, pm.Name AS NombreModelo
FROM [Production].[Product] p JOIN [Production].[ProductModel] pm ON p.ProductModelID = pm.ProductModelID;

/*Mostrar �todos� los productos junto con el modelo que tenga asignado. En el caso que no tenga asignado ning�n modelo, mostrar su nulidad. */
SELECT * FROM [Production].[Product] p LEFT JOIN [Production].[ProductModel] pm ON p.ProductModelID = pm.ProductModelID;

/*�dem, pero en lugar de mostrar nulidad, mostrar la palabra �Sin Modelo� para indicar que el producto no posee un modelo asignado.*/
SELECT p.Name AS NombreProducto, p.ProductID, ISNULL(pm.Name, 'Sin Modelo') AS NombreModelo
FROM [Production].[Product] p LEFT JOIN [Production].[ProductModel] pm ON p.ProductModelID = pm.ProductModelID;

/*Contar la cantidad de productos que poseen asignado cada uno de los modelos */
SELECT pm.Name AS NombreModelo, COUNT(p.ProductID) AS CantidadProductos
FROM [Production].[Product] p JOIN [Production].[ProductModel] pm ON p.ProductModelID = pm.ProductModelID
GROUP BY pm.Name;

/*Contar la cantidad de productos que poseen asignado cada uno de los modelos, pero mostrar solo aquellos modelos que posean asignados 2 o m�s productos */
SELECT COUNT(p.ProductID) AS CantidadProductos
FROM [Production].[Product] p JOIN [Production].[ProductModel] pm ON p.ProductModelID = pm.ProductModelID
GROUP BY pm.Name
HAVING COUNT(p.ProductID) >= 2;

/*Contar la cantidad de Productos que poseen asignado un modelo valido, es decir, que se encuentre cargado en la tabla de modelos.*/
SELECT COUNT(*)
FROM [Production].[Product] p
WHERE EXISTS (SELECT 1
				FROM [Production].[ProductModel] pm
				WHERE p.ProductModelID = pm.ProductModelID )

/*Contar cuantos productos poseen asignado cada uno de los modelos, es decir, se quiere visualizar el nombre del modelo y la cantidad de productos asignados.
Si alg�n modelo no posee asignado ning�n producto, se quiere visualizar 0 (cero). */
SELECT COUNT(*) AS cantProductos, pm.Name AS nombreModelo
FROM [Production].[ProductModel] pm LEFT JOIN [Production].[Product] p ON pm.ProductModelID = p.ProductModelID
GROUP BY pm.Name;

/*Se quiere visualizar, el nombre del producto, el nombre modelo que posee asignado, la ilustraci�n que posee asignada y la fecha de �ltima modificaci�n de dicha ilustraci�n y el
diagrama que tiene asignado la ilustraci�n. Solo nos interesan los productos que cuesten m�s de $150 y que posean alg�n color asignado.*/
SELECT p.Name AS nombreProducto, pm.Name AS nombreModelo, i.IllustrationID, i.ModifiedDate AS fechaUltimaModificacion, i.Diagram
FROM [Production].[Product] p
	JOIN [Production].[ProductModel] pm ON p.ProductModelID = pm.ProductModelID
	JOIN [Production].[ProductModelIllustration] pmi ON pm.ProductModelID = pmi.ProductModelID
	JOIN [Production].[Illustration] i ON pmi.IllustrationID = i.IllustrationID
WHERE p.ListPrice > 150 AND p.Color IS NOT NULL;

/*Mostrar aquellas culturas que no est�n asignadas a ning�n producto/modelo. */
SELECT c.CultureID, c.Name FROM [Production].[Culture] c
WHERE NOT EXISTS (
	SELECT 1
    FROM [Production].[ProductModelProductDescriptionCulture] pdpc
    WHERE pdpc.CultureID = c.CultureID
	);

/*Agregar a la base de datos el tipo de contacto �Ejecutivo de Cuentas�*/
INSERT INTO [Person].[ContactType] (Name) VALUES ('Ejecutivo de Cuentas');

/*Agregar la cultura llamada �nn� � �Cultura Moderna�*/
INSERT INTO [Production].[Culture] (CultureID, Name, ModifiedDate) VALUES ('nn', 'Cultura Moderna', GETDATE());

/*Cambiar la fecha de modificaci�n de las culturas Spanish, French y Thai para indicar que fueron modificadas hoy. */
UPDATE [Production].[Culture] SET ModifiedDate = GETDATE() WHERE Name IN ('Spanish', 'French', 'Thai');

/*En la tabla Production.CultureHis agregar todas las culturas que fueron modificadas hoy */
/*CREATE TABLE [Production].[CultureHis] (
  CultureID nchar(6) PRIMARY KEY,
  Name nvarchar(50),
  ModifiedDate datetime
);
INSERT INTO [Production].[CultureHis] (CultureID, Name, ModifiedDate) SELECT CultureID, Name, ModifiedDate
FROM [Production].[Culture]
WHERE CAST(ModifiedDate AS DATE) = CAST(GETDATE() AS DATE);*/

/* Al contacto con ID 10 colocarle como nombre �Juan Perez�. */
UPDATE [Person].[ContactType] SET Name = 'Juan Perez'
WHERE ContactTypeID = 10;

/*Realice los borrados necesarios para que nos permita eliminar el registro de la moneda con c�digo ARS.*/
DELETE FROM [Sales].[CurrencyRate] WHERE FromCurrencyCode = 'ARS' OR ToCurrencyCode = 'ARS';

/*Eliminar aquellas culturas que no est�n asignadas a ning�n producto */
DELETE FROM [Production].[Culture]
WHERE NOT EXISTS (
	SELECT 1
    FROM [Production].[ProductModelProductDescriptionCulture] pdpc
    WHERE pdpc.CultureID = [Production].[Culture].CultureID
);

/*............................................................................................................................................*/

/*Realizar una consulta que permita devolver la fecha y hora actua*/
SELECT GETDATE() AS FechaHoraActual;

/*Realizar una consulta que permita devolver �nicamente el a�o y mes actual: */
SELECT 
  YEAR(GETDATE()) AS AnioActual,
  MONTH(GETDATE()) AS MesActual;

/*Realizar una consulta que permita saber cu�ntos d�as faltan para el d�a de la primavera (21-Sep)*/
DECLARE @hoy DATE = GETDATE();
DECLARE @anioActual INT = YEAR(@hoy);
DECLARE @primavera DATE = CAST(CAST(@anioActual AS VARCHAR) + '-09-21' AS DATE);

-- Si la primavera ya pas� este a�o, usar la del a�o siguiente
IF @hoy > @primavera
    SET @primavera = DATEADD(YEAR, 1, @primavera);

SELECT DATEDIFF(DAY, @hoy, @primavera) AS DiasHastaPrimavera;

/*Realizar una consulta que permita redondear el n�mero 385,86 con �nicamente 1 decimal.*/
SELECT ROUND(385.86, 1) AS NumeroRedondeado;

/*Realizar una consulta permita saber cu�nto es el mes actual al cuadrado. Por ejemplo, si estamos en Junio, ser�a 6elevado2*/
SELECT POWER(MONTH(GETDATE()), 2) AS MesAlCuadrado;

/*Devolver cu�l es el usuario que se encuentra conectado a la base de datos*/
SELECT SUSER_NAME() AS UsuarioConectado;

/*Realizar una consulta que permita conocer la edad de cada empleado (Ayuda: HumanResources.Employee)*/
SELECT e.BusinessEntityID, p.FirstName, p.LastName, DATEDIFF(YEAR, e.BirthDate, GETDATE()) 
- CASE 
	WHEN MONTH(e.BirthDate) > MONTH(GETDATE()) OR (MONTH(e.BirthDate) = MONTH(GETDATE()) AND DAY(e.BirthDate) > DAY(GETDATE())) 
        THEN 1 
        ELSE 0 
      END AS Edad
FROM HumanResources.Employee e
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID;

/*Realizar una consulta que retorne la longitud de cada apellido de los Contactos, ordenados por apellido. En el caso que se repita el apellido devolver �nicamente uno de ellos. */
SELECT 
  LastName,
  LEN(LastName) AS LongitudApellido
FROM Person.Person
GROUP BY LastName
ORDER BY LastName;

/*Realizar una consulta que permita encontrar el apellido con mayor longitud.*/
SELECT LastName, LEN(LastName) AS Longitud
FROM Person.Person
WHERE LEN(LastName) = (
  SELECT MAX(LEN(LastName))
  FROM Person.Person
);

/*Realizar una consulta que devuelva los nombres y apellidos de los contactos que hayan sido modificados en los �ltimos 3 a�os. */
SELECT FirstName, LastName, ModifiedDate
FROM Person.Person
WHERE ModifiedDate >= DATEADD(YEAR, -3, GETDATE());

/*Se quiere obtener los emails de todos los contactos, pero en may�scula. */
SELECT UPPER(EmailAddress) AS EmailEnMayuscula
FROM Person.EmailAddress;

/*Realizar una consulta que permita particionar el mail de cada contacto, obteniendo lo siguiente: idcontacto 1, email djsa@fd.com, nombre juan, dominio djska*/
SELECT e.BusinessEntityID AS IdContacto, e.EmailAddress AS Email, p.FirstName AS Nombre,
  LEFT(e.EmailAddress, CHARINDEX('@', e.EmailAddress) - 1) AS Dominio
FROM Person.EmailAddress e
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID;

/*Devolver los �ltimos 3 d�gitos del NationalIDNumber de cada empleado*/
SELECT BusinessEntityID, NationalIDNumber,
  RIGHT(NationalIDNumber, 3) AS Ultimos3Digitos
FROM HumanResources.Employee;

/*.Se desea enmascarar el NationalIDNumbre de cada empleado, de la siguiente forma ###-####-##:*/
SELECT BusinessEntityID, NationalIDNumber,
  STUFF(
    STUFF(NationalIDNumber, 4, 0, '-'),
    9, 0, '-') AS NationalID_Enmascarado
FROM HumanResources.Employee;

/*. Listar la direcci�n de cada empleado �supervisor� que haya nacido hace m�s de 30 a�os. Listar todos los datos en may�scula. Los datos a visualizar son: nombre y apellido del empleado, direcci�n y ciudad.*/
SELECT UPPER(p.FirstName) AS Nombre, UPPER(p.LastName) AS Apellido, UPPER(a.AddressLine1) AS Direccion, UPPER(a.City) AS Ciudad
FROM HumanResources.Employee e
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
JOIN Person.BusinessEntityAddress bea ON e.BusinessEntityID = bea.BusinessEntityID
JOIN Person.Address a ON bea.AddressID = a.AddressID
WHERE e.OrganizationLevel = 1
  AND DATEDIFF(YEAR, e.BirthDate, GETDATE()) > 30;

/*Categorizar a los empleados seg�n la cantidad de horas de vacaciones, seg�n el siguiente formato:
Alto = m�s de 50 / medio= entre 20 y 50 / bajo = menos de 20 */
SELECT BusinessEntityID, VacationHours,
  CASE 
    WHEN VacationHours > 50 THEN 'Alto'
    WHEN VacationHours BETWEEN 20 AND 50 THEN 'Medio'
    ELSE 'Bajo'
  END AS CategoriaVacaciones
FROM HumanResources.Employee;


/*.............................................................................*/

/*p_InsertaDatos(): Realizar un sp que permita insertar n�meros pares del 2 al 20 en una tabla con el nombre dbo.NumeroPar (nro smallint), excepto los n�meros 10 y 16. La tabla debe ser creada fuera del procedimiento.
Controlar los errores que pudieran sucederse.*/
CREATE PROCEDURE p_InsertaDatos
AS
BEGIN
  BEGIN TRY
    BEGIN TRAN;

    DECLARE @i SMALLINT = 2;

    WHILE @i <= 20
    BEGIN
      IF @i NOT IN (10, 16)
      BEGIN
        INSERT INTO dbo.NumeroPar (nro) VALUES (@i);
      END;
      SET @i = @i + 2;
    END;

    COMMIT;
  END TRY
  BEGIN CATCH
    ROLLBACK;

    -- Mostrar mensaje de error
    PRINT 'Ocurri� un error: ' + ERROR_MESSAGE();
  END CATCH
END;


/*p_InsertaDatos2(nro): Realiza un sp que inserte a la tabla dbo.NumeroPar el n�mero ingresado por par�metro, pero s�lo se deber� insertar si el n�mero es par. De lo contrario lanzar una excepci�n.*/
CREATE PROCEDURE p_InsertaDatos2
  @nro SMALLINT
AS
BEGIN
  BEGIN TRY
    BEGIN TRAN;

    IF @nro % 2 = 0
    BEGIN
      INSERT INTO dbo.NumeroPar (nro) VALUES (@nro);
    END
    ELSE
    BEGIN
      -- Lanza una excepci�n si el n�mero no es par
      THROW 50001, 'El n�mero ingresado no es par.', 1;
    END;

    COMMIT;
  END TRY
  BEGIN CATCH
    ROLLBACK;
    PRINT 'Error: ' + ERROR_MESSAGE();
  END CATCH
END;


/*p_MuestraNroPares(): Realizar un sp que devuelva los registros insertados en los �tems anteriores. En el caso de que la tabla est� vac�a lanzar una excepci�n indicando dicho error.*/
CREATE PROCEDURE p_MuestraNroPares
AS
BEGIN
  BEGIN TRY
    BEGIN TRAN;

    IF EXISTS (SELECT 1 FROM dbo.NumeroPar)
    BEGIN
      SELECT * FROM dbo.NumeroPar;
    END
    ELSE
    BEGIN
      THROW 50002, 'La tabla dbo.NumeroPar est� vac�a.', 1;
    END;

    COMMIT;
  END TRY
  BEGIN CATCH
    ROLLBACK;
    PRINT 'Error: ' + ERROR_MESSAGE();
  END CATCH
END;

/*p_ActualizaBonus(): Se actualizar� el bonus de todas las personas que se encuentran en la tabla Sales.SalesPerson, teniendo en cuenta las siguientes condiciones: Se calcular� el bonus tomando como % el valor CommissionPct
(%) de su valor SalesQuota. Si el valor de SalesQuota es NULL se colocar� 0 (cero) como bonus. Si el bonus resultante qued� a menos de 3000, se dejar� 3000 como m�nimo valor de bonus (siempre y cuando tenga alg�n
dato en SalesQuota). Controlar errores y manejar todo el ejercicio como una �nica transacci�n.*/
CREATE PROCEDURE p_ActualizaBonus
AS
BEGIN
  BEGIN TRY
    BEGIN TRAN;

    UPDATE Sales.SalesPerson
    SET Bonus =
      CASE
        WHEN SalesQuota IS NULL THEN 0
        WHEN SalesQuota * CommissionPct < 3000 THEN 3000
        ELSE SalesQuota * CommissionPct
      END;

    COMMIT;
  END TRY
  BEGIN CATCH
    ROLLBACK;
    PRINT 'Error al actualizar los bonus: ' + ERROR_MESSAGE();
  END CATCH
END;

/*p_MuestraClientes(tipo): Realizar un procedimiento que muestre los clientes de un determinado tipo. Los tipos ingresados por par�metro posibles
s�lo pueden ser S � I, si se ingresa otro valor como tipo arrojar un error. El sp debe mostrar s�lo los n�meros de cuentas de los tipos seleccionados ordenados en forma descendente. Utilizar en este ejemplo la cl�usula WITH.*/
CREATE PROCEDURE p_MuestraClientes
  @tipo NCHAR(1)
AS
BEGIN
  BEGIN TRY
    BEGIN TRAN;

    IF @tipo NOT IN ('S', 'I')
    BEGIN
      THROW 50003, 'Tipo inv�lido. Debe ser ''S'' o ''I''.', 1;
    END

    ;WITH ClientesFiltrados AS (
      SELECT AccountNumber
      FROM Sales.Customer
      WHERE CustomerType = @tipo
    )
    SELECT AccountNumber
    FROM ClientesFiltrados
    ORDER BY AccountNumber DESC;

    COMMIT;
  END TRY
  BEGIN CATCH
    ROLLBACK;
    PRINT 'Error: ' + ERROR_MESSAGE();
  END CATCH
END;

/*En el p_InsCulture(id,name,date), se deber� agregar el manejo de transacciones y arrojar una excepci�n en el caso de encontrarse que la validaci�n es incorrecta.*/
CREATE PROCEDURE p_InsCulture
  @CultureID NCHAR(6),
  @Name dbo.Name,
  @ModifiedDate DATETIME
AS
BEGIN
  BEGIN TRY
    BEGIN TRAN;

    -- Validaciones
    IF @CultureID IS NULL OR LTRIM(RTRIM(@CultureID)) = ''
      OR @Name IS NULL OR LTRIM(RTRIM(@Name)) = ''
      OR @ModifiedDate IS NULL
    BEGIN
      THROW 50004, 'Ning�n campo puede estar vac�o.', 1;
    END

    IF EXISTS (SELECT 1 FROM Production.Culture WHERE CultureID = @CultureID)
    BEGIN
      THROW 50005, 'Ya existe una cultura con ese CultureID.', 1;
    END

    IF EXISTS (SELECT 1 FROM Production.Culture WHERE Name = @Name)
    BEGIN
      THROW 50006, 'Ya existe una cultura con ese nombre.', 1;
    END

    IF @ModifiedDate < CAST(GETDATE() AS DATE)
    BEGIN
      THROW 50007, 'La fecha no puede ser menor a la actual.', 1;
    END

    -- Inserci�n
    INSERT INTO Production.Culture (CultureID, Name, ModifiedDate)
    VALUES (@CultureID, @Name, @ModifiedDate);

    COMMIT;
  END TRY
  BEGIN CATCH
    ROLLBACK;
    PRINT 'Error: ' + ERROR_MESSAGE();
  END CATCH
END;

/*En el p_SelCulture(id), arrojar una excepci�n si se estar�a buscando un registro que no existe. Devolver con el mensaje �Registro no encontrado�.*/
CREATE PROCEDURE p_SelCulture
  @CultureID NCHAR(6)
AS
BEGIN
  BEGIN TRY
    BEGIN TRAN;

    IF NOT EXISTS (
      SELECT 1 
      FROM Production.Culture 
      WHERE CultureID = @CultureID
    )
    BEGIN
      THROW 50008, 'Registro no encontrado.', 1;
    END

    SELECT CultureID, Name, ModifiedDate
    FROM Production.Culture
    WHERE CultureID = @CultureID;

    COMMIT;
  END TRY
  BEGIN CATCH
    ROLLBACK;
    PRINT 'Error: ' + ERROR_MESSAGE();
  END CATCH
END;

/*Realizar el mismo procedimiento para el p_DelCulture(id). Adem�s, en este caso realizar el manejo de transacciones.*/
CREATE PROCEDURE p_DelCulture
  @CultureID NCHAR(6)
AS
BEGIN
  BEGIN TRY
    BEGIN TRAN;

    -- Validar si el registro existe
    IF NOT EXISTS (
      SELECT 1 
      FROM Production.Culture 
      WHERE CultureID = @CultureID
    )
    BEGIN
      THROW 50009, 'Registro no encontrado.', 1;
    END

    -- Eliminar registro
    DELETE FROM Production.Culture
    WHERE CultureID = @CultureID;

    COMMIT;
  END TRY
  BEGIN CATCH
    ROLLBACK;
    PRINT 'Error: ' + ERROR_MESSAGE();
  END CATCH
END;

/*En el procedimiento p_CrearCultureHis realizar el manejo de transacciones y errores.*/
CREATE PROCEDURE p_CrearCultureHis
AS
BEGIN
  BEGIN TRY
    BEGIN TRAN;

    -- Eliminar si ya existe
    IF OBJECT_ID('Production.CultureHis', 'U') IS NOT NULL
      DROP TABLE Production.CultureHis;

    -- Crear la tabla hist�rica
    CREATE TABLE Production.CultureHis (
      CultureID NCHAR(6) NOT NULL,
      Name dbo.Name NOT NULL,
      ModifiedDate DATETIME NOT NULL 
        CONSTRAINT DF_CultureHis_ModifiedDate DEFAULT (GETDATE()),
      CONSTRAINT PK_CultureHis_IDDate 
        PRIMARY KEY CLUSTERED (CultureID, ModifiedDate)
    );

    COMMIT;
  END TRY
  BEGIN CATCH
    ROLLBACK;
    PRINT 'Error al crear tabla hist�rica: ' + ERROR_MESSAGE();
  END CATCH
END;

/*p_InsCulture(id,name,date): Este sp debe permitir dar de alta un nuevo
registro en la tabla Production.Culture. Los tipos de datos de los par�metros
deben corresponderse con la tabla. Para ayudarse, se podr� ejecutar el
procedimiento sp_help�<esquema.objeto>�.*/
CREATE OR ALTER PROCEDURE p_InsCulture
  @CultureID NCHAR(6),
  @Name dbo.Name,
  @ModifiedDate DATETIME
AS
BEGIN
  BEGIN TRY
    BEGIN TRAN;

    DECLARE @valida BIT;
    EXEC p_ValCulture @CultureID, @Name, @ModifiedDate, 'I', @valida OUTPUT;

    IF @valida = 0
      THROW 60001, 'Validaci�n fallida. No se insert� el registro.', 1;

    INSERT INTO Production.Culture (CultureID, Name, ModifiedDate)
    VALUES (@CultureID, @Name, @ModifiedDate);

    COMMIT;
  END TRY
  BEGIN CATCH
    ROLLBACK;
    THROW;
  END CATCH
END;
GO

/*p_SelCuture(id): Este sp devolver� el registro completo seg�n el id
enviado*/
CREATE OR ALTER PROCEDURE p_SelCulture
  @CultureID NCHAR(6)
AS
BEGIN
  BEGIN TRY
    BEGIN TRAN;

    IF NOT EXISTS (SELECT 1 FROM Production.Culture WHERE CultureID = @CultureID)
      THROW 60002, 'Registro no encontrado.', 1;

    SELECT * FROM Production.Culture WHERE CultureID = @CultureID;

    COMMIT;
  END TRY
  BEGIN CATCH
    ROLLBACK;
    THROW;
  END CATCH
END;
GO

/* p_DelCulture(id): Este sp debe borrar el id enviado por par�metro de la
tabla Production.Culture.*/
CREATE OR ALTER PROCEDURE p_DelCulture
  @CultureID NCHAR(6)
AS
BEGIN
  BEGIN TRY
    BEGIN TRAN;

    IF NOT EXISTS (SELECT 1 FROM Production.Culture WHERE CultureID = @CultureID)
      THROW 60003, 'Registro no encontrado.', 1;

    IF EXISTS (
      SELECT 1 FROM Production.ProductModelProductDescriptionCulture 
      WHERE CultureID = @CultureID)
      THROW 60004, 'La cultura est� referenciada en otra tabla. No se puede eliminar.', 1;

    DELETE FROM Production.Culture WHERE CultureID = @CultureID;

    COMMIT;
  END TRY
  BEGIN CATCH
    ROLLBACK;
    THROW;
  END CATCH
END;
GO

/*p_UpdCulture(id): Dado un id debe permitirme cambiar el campo name
del registro.*/
CREATE OR ALTER PROCEDURE p_UpdCulture
  @CultureID NCHAR(6),
  @NewName dbo.Name
AS
BEGIN
  BEGIN TRY
    BEGIN TRAN;

    DECLARE @valida BIT;
    EXEC p_ValCulture @CultureID, @NewName, GETDATE(), 'U', @valida OUTPUT;

    IF @valida = 0
      THROW 60005, 'Validaci�n fallida. No se actualiz�.', 1;

    -- Guardar historial
    INSERT INTO Production.CultureHis (CultureID, Name, ModifiedDate)
    SELECT CultureID, Name, ModifiedDate
    FROM Production.Culture
    WHERE CultureID = @CultureID;

    UPDATE Production.Culture
    SET Name = @NewName,
        ModifiedDate = GETDATE()
    WHERE CultureID = @CultureID;

    COMMIT;
  END TRY
  BEGIN CATCH
    ROLLBACK;
    THROW;
  END CATCH
END;
GO

/*sp_CantCulture (cant out): Realizar un sp que devuelva la cantidad de
registros en Culture. El resultado deber� colocarlo en una variable de salida.*/
CREATE OR ALTER PROCEDURE sp_CantCulture
  @Cantidad INT OUTPUT
AS
BEGIN
  SELECT @Cantidad = COUNT(*) FROM Production.Culture;
END;
GO

/*sp_CultureAsignadas : Realizar un sp que devuelva solamente las
Culture�s que est�n siendo utilizadas en las tablas (Verificar qu� tabla/s la
est�n referenciando). S�lo debemos devolver id y nombre de la Cultura.*/
CREATE OR ALTER PROCEDURE sp_CultureAsignadas
AS
BEGIN
  SELECT DISTINCT c.CultureID, c.Name
  FROM Production.Culture c
  JOIN Production.ProductModelProductDescriptionCulture pmdc
    ON c.CultureID = pmdc.CultureID;
END;
GO

/*p_ValCulture(id,name,date,operaci�n, valida out): Este sp permitir�
validar los datos enviados por par�metro. En el caso que el registro sea
v�lido devolver� un 1 en el par�metro de salida valida � 0 en caso contrario.
El par�metro operaci�n puede ser �U� (Update), �I� (Insert) � �D� (Delete).
Lo que se debe validar es:
- Si se est� insertando no se podr� agregar un registro con un id
existente, ya que arrojar� un error.
- Tampoco se puede agregar dos registros Cultura con el mismo Name,
ya que el campo Name es un unique index.
- Ninguno de los campos deber�a estar vac�o.
- La fecha ingresada no puede ser menor a la fecha actual.*/
CREATE OR ALTER PROCEDURE p_ValCulture
  @CultureID NCHAR(6),
  @Name dbo.Name,
  @ModifiedDate DATETIME,
  @Operacion CHAR(1),
  @Valida BIT OUTPUT
AS
BEGIN
  SET @Valida = 1;

  IF @CultureID IS NULL OR LTRIM(RTRIM(@CultureID)) = ''
     OR @Name IS NULL OR LTRIM(RTRIM(@Name)) = ''
     OR @ModifiedDate IS NULL OR @ModifiedDate < CAST(GETDATE() AS DATE)
  BEGIN
    SET @Valida = 0;
    RETURN;
  END

  IF @Operacion = 'I' AND EXISTS (SELECT 1 FROM Production.Culture WHERE CultureID = @CultureID)
    SET @Valida = 0;

  IF EXISTS (SELECT 1 FROM Production.Culture WHERE Name = @Name AND CultureID <> @CultureID)
    SET @Valida = 0;
END;
GO

/*p_SelCulture2(id out, name out, date out): A diferencia del sp del punto
2, este debe emitir todos los datos en sus par�metros de salida. �C�mo se
debe realizar la llamada del sp para testear este sp?*/
CREATE OR ALTER PROCEDURE p_SelCulture2
  @CultureID NCHAR(6) OUTPUT,
  @Name dbo.Name OUTPUT,
  @ModifiedDate DATETIME OUTPUT
AS
BEGIN
  SELECT TOP 1
    @CultureID = CultureID,
    @Name = Name,
    @ModifiedDate = ModifiedDate
  FROM Production.Culture;
END;
GO

/*p_UserTables(opcional esquema): Realizar un procedimiento que liste
las tablas que hayan sido creadas dentro de la base de datos con su
nombre, esquema y fecha de creaci�n. En el caso que se ingrese por
par�metro el esquema, entonces mostrar �nicamente dichas tablas, de lo
contrario, mostrar todos los esquemas de la base.*/
CREATE OR ALTER PROCEDURE p_UserTables
  @Esquema NVARCHAR(128) = NULL
AS
BEGIN
  IF @Esquema IS NULL
  BEGIN
    SELECT s.name AS Esquema, t.name AS Tabla, t.create_date
    FROM sys.tables t
    JOIN sys.schemas s ON t.schema_id = s.schema_id;
  END
  ELSE
  BEGIN
    SELECT s.name AS Esquema, t.name AS Tabla, t.create_date
    FROM sys.tables t
    JOIN sys.schemas s ON t.schema_id = s.schema_id
    WHERE s.name = @Esquema;
  END
END;
GO

/*p_GenerarProductoxColor(): Generar un procedimiento que divida los
productos seg�n el color que poseen. Los mismos deben ser insertados en
diferentes tablas seg�n el color del producto. Por ejemplo, las tablas podr�an
ser Product_Black, Product_Silver, etc� Estas tablas deben ser generadas
din�micamente seg�n los colores que existan en los productos, es decir, si
genero un nuevo producto con un nuevo color, al ejecutar el procedimiento
debe generar dicho color. Cada vez que se ejecute este procedimiento se
recrear�n las tablas de colores. Los productos que no posean color
asignados, no se tendr�n en cuenta para la generaci�n de tablas y no se
insertar�n en ninguna tabla de color*/
CREATE OR ALTER PROCEDURE p_GenerarProductoxColor
AS
BEGIN
  DECLARE @color NVARCHAR(15);
  DECLARE @sql NVARCHAR(MAX);

  DECLARE colores CURSOR FOR
  SELECT DISTINCT Color FROM Production.Product WHERE Color IS NOT NULL;

  OPEN colores;
  FETCH NEXT FROM colores INTO @color;

  WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @sql = '
      IF OBJECT_ID(''Production.Product_' + @color + ''', ''U'') IS NOT NULL
        DROP TABLE Production.Product_' + @color + ';

      SELECT *
      INTO Production.Product_' + @color + '
      FROM Production.Product
      WHERE Color = ''' + @color + '''';

    EXEC sp_executesql @sql;
    FETCH NEXT FROM colores INTO @color;
  END;

  CLOSE colores;
  DEALLOCATE colores;
END;
GO

/*p_UltimoProducto(param): Realizar un procedimiento que devuelva en
sus par�metros (output), el �ltimo producto ingresado.*/
CREATE OR ALTER PROCEDURE p_UltimoProducto
  @ProductID INT OUTPUT,
  @Name NVARCHAR(50) OUTPUT,
  @ModifiedDate DATETIME OUTPUT
AS
BEGIN
  SELECT TOP 1 
    @ProductID = ProductID,
    @Name = Name,
    @ModifiedDate = ModifiedDate
  FROM Production.Product
  ORDER BY ProductID DESC;
END;
GO

/*p_TotalVentas(fecha): Realizar un procedimiento que devuelva el total
facturado en un d�a dado. El procedimiento, simplemente debe devolver el
total monetario de lo facturado (Sales).*/
CREATE OR ALTER PROCEDURE p_TotalVentas
  @Fecha DATE
AS
BEGIN
  SELECT SUM(TotalDue) AS TotalFacturado
  FROM Sales.SalesOrderHeader
  WHERE CAST(OrderDate AS DATE) = @Fecha;
END;
GO
