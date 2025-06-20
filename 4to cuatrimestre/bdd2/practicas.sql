USE [AdventureWorks2014]
GO

/*Listar los códigos y descripciones de todos los productos */
SELECT [ProductID],[Name] FROM [Production].[Product]
GO

/*Listar los datos de la subcategoría número 17*/
SELECT * FROM [Production].[ProductSubcategory] WHERE ProductSubcategoryID = 17;
GO

/*Listar los productos cuya descripción comience con D */
SELECT p.Name, pd.Description
FROM [Production].[Product] p
	JOIN [Production].[ProductModel] pm ON p.ProductModelID = pm.ProductModelID
	JOIN [Production].[ProductModelProductDescriptionCulture] pdpc ON pm.ProductModelID = pdpc.ProductModelID
	JOIN [Production].[ProductDescription] pd ON pdpc.ProductDescriptionID = pd.ProductDescriptionID
WHERE pd.Description LIKE 'D%';

/*Listar las descripciones de los productos cuyo número finalice con 8 (Ayuda: ProductNumber like ‘%8’)*/
SELECT pd.Description
FROM [Production].[Product] p
	JOIN [Production].[ProductModel] pm ON p.ProductModelID = pm.ProductModelID	
	JOIN [Production].[ProductModelProductDescriptionCulture] pdpc ON pm.ProductModelID = pdpc.ProductModelID
	JOIN [Production].[ProductDescription] pd ON pdpc.ProductDescriptionID = pd.ProductDescriptionID 
WHERE p.ProductNumber LIKE '%8';

/*Listar aquellos productos que posean un color asignado. Se deberán excluir todos aquellos que no posean ningún valor*/
SELECT * FROM [Production].[Product] p
WHERE p.Color IS NOT NULL;

/*Listar el código y descripción de los productos de color Black (Negro) y que posean el nivel de stock en 500. */
SELECT p.ProductID, pd.Description
FROM [Production].[Product] p
	JOIN [Production].[ProductModel] pm ON p.ProductModelID = pm.ProductModelID	
	JOIN [Production].[ProductModelProductDescriptionCulture] pdpc ON pm.ProductModelID = pdpc.ProductModelID
	JOIN [Production].[ProductDescription] pd ON pdpc.ProductDescriptionID = pd.ProductDescriptionID
WHERE p.Color = 'Black' AND p.SafetyStockLevel = 500;

/*Listar los productos que sean de color Black (Negro) ó Silver(Plateado).*/
SELECT * FROM [Production].[Product] p WHERE p.Color = 'Black' OR p.Color = 'Silver';

/*Listar los diferentes colores que posean asignados los productos.*/
SELECT DISTINCT p.Color FROM [Production].[Product] p;

/*Contar la cantidad de categorías que se encuentren cargadas en la base. (Ayuda: count) */
SELECT COUNT(*) FROM [Production].[ProductCategory];

/*Contar la cantidad de subcategorías que posee asignada la categoría 2. */
SELECT COUNT(*) FROM [Production].[ProductSubcategory] WHERE ProductCategoryID = 2;

/*Listar la cantidad de productos que existan por cada uno de los colores*/
SELECT COUNT(*) FROM [Production].[Product] p GROUP BY p.Color;

/*Sumar todos los niveles de stocks aceptables que deben existir para los productos con color Black. */
SELECT SUM(p.SafetyStockLevel) FROM [Production].[Product] p WHERE p.Color = 'Black';

/*Calcular el promedio de stock que se debe tener de todos los productos cuyo código se encuentre entre el 316 y 320.*/
SELECT AVG(p.SafetyStockLevel) FROM [Production].[Product] p WHERE p.ProductID BETWEEN 316 AND 320;

/* Listar el nombre del producto y la descripción de la subcategoría que posea asignada */
SELECT p.Name AS NombreProducto, ps.Name AS DescripcionSubcategoria
FROM [Production].[Product] p
INNER JOIN [Production].[ProductSubcategory] ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID;

/*Listar todas las categorías que poseen asignado al menos una subcategoría. Se deberán excluir aquellas que no posean ninguna.*/
SELECT * FROM [Production].[ProductCategory] pc INNER JOIN [Production].[ProductSubcategory] ps ON pc.ProductCategoryID = ps.ProductCategoryID

/*Listar el código y descripción de los productos que posean fotos asignadas.*/
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

/*Listar la descripción de los productos y su respectivo color. Sólo nos interesa caracterizar al color con los valores: Black, Silver u Otro. Por lo cual si no es ni silver ni black se debe indicar Otro */
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

/*Listar el nombre de la categoría, el nombre de la subcategoría y la descripción del producto*/
SELECT pc.Name AS NombreCategoria, ps.Name AS NombreSubcategoria, pd.Description AS DescripcionProducto
FROM [Production].[Product] p
	JOIN [Production].[ProductSubcategory] ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
	JOIN [Production].[ProductCategory] pc ON ps.ProductCategoryID = pc.ProductCategoryID
	JOIN [Production].[ProductModel] pm ON p.ProductModelID = pm.ProductModelID
	JOIN [Production].[ProductModelProductDescriptionCulture] pdpc ON pm.ProductModelID = pdpc.ProductModelID
	JOIN [Production].[ProductDescription] pd ON pdpc.ProductDescriptionID = pd.ProductDescriptionID

/*Listar la cantidad de subcategorías que posean asignado los productos.*/
SELECT COUNT(DISTINCT p.ProductSubcategoryID) FROM [Production].[Product] p


/************************************************************************************************************************************************************/

/*Listar los nombres de los productos y el nombre del modelo que posee asignado. Solo listar aquellos que tengan asignado algún modelo. */
SELECT p.Name AS NombreProducto, pm.Name AS NombreModelo
FROM [Production].[Product] p JOIN [Production].[ProductModel] pm ON p.ProductModelID = pm.ProductModelID;

/*Mostrar “todos” los productos junto con el modelo que tenga asignado. En el caso que no tenga asignado ningún modelo, mostrar su nulidad. */
SELECT * FROM [Production].[Product] p LEFT JOIN [Production].[ProductModel] pm ON p.ProductModelID = pm.ProductModelID;

/*Ídem, pero en lugar de mostrar nulidad, mostrar la palabra “Sin Modelo” para indicar que el producto no posee un modelo asignado.*/
SELECT p.Name AS NombreProducto, p.ProductID, ISNULL(pm.Name, 'Sin Modelo') AS NombreModelo
FROM [Production].[Product] p LEFT JOIN [Production].[ProductModel] pm ON p.ProductModelID = pm.ProductModelID;

/*Contar la cantidad de productos que poseen asignado cada uno de los modelos */
SELECT pm.Name AS NombreModelo, COUNT(p.ProductID) AS CantidadProductos
FROM [Production].[Product] p JOIN [Production].[ProductModel] pm ON p.ProductModelID = pm.ProductModelID
GROUP BY pm.Name;

/*Contar la cantidad de productos que poseen asignado cada uno de los modelos, pero mostrar solo aquellos modelos que posean asignados 2 o más productos */
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
Si algún modelo no posee asignado ningún producto, se quiere visualizar 0 (cero). */
SELECT COUNT(*) AS cantProductos, pm.Name AS nombreModelo
FROM [Production].[ProductModel] pm LEFT JOIN [Production].[Product] p ON pm.ProductModelID = p.ProductModelID
GROUP BY pm.Name;

/*Se quiere visualizar, el nombre del producto, el nombre modelo que posee asignado, la ilustración que posee asignada y la fecha de última modificación de dicha ilustración y el
diagrama que tiene asignado la ilustración. Solo nos interesan los productos que cuesten más de $150 y que posean algún color asignado.*/
SELECT p.Name AS nombreProducto, pm.Name AS nombreModelo, i.IllustrationID, i.ModifiedDate AS fechaUltimaModificacion, i.Diagram
FROM [Production].[Product] p
	JOIN [Production].[ProductModel] pm ON p.ProductModelID = pm.ProductModelID
	JOIN [Production].[ProductModelIllustration] pmi ON pm.ProductModelID = pmi.ProductModelID
	JOIN [Production].[Illustration] i ON pmi.IllustrationID = i.IllustrationID
WHERE p.ListPrice > 150 AND p.Color IS NOT NULL;

/*Mostrar aquellas culturas que no están asignadas a ningún producto/modelo. */
SELECT c.CultureID, c.Name FROM [Production].[Culture] c
WHERE NOT EXISTS (
	SELECT 1
    FROM [Production].[ProductModelProductDescriptionCulture] pdpc
    WHERE pdpc.CultureID = c.CultureID
	);

/*Agregar a la base de datos el tipo de contacto “Ejecutivo de Cuentas”*/
INSERT INTO [Person].[ContactType] (Name) VALUES ('Ejecutivo de Cuentas');

/*Agregar la cultura llamada “nn” – “Cultura Moderna”*/
INSERT INTO [Production].[Culture] (CultureID, Name, ModifiedDate) VALUES ('nn', 'Cultura Moderna', GETDATE());

/*Cambiar la fecha de modificación de las culturas Spanish, French y Thai para indicar que fueron modificadas hoy. */
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

/* Al contacto con ID 10 colocarle como nombre “Juan Perez”. */
UPDATE [Person].[ContactType] SET Name = 'Juan Perez'
WHERE ContactTypeID = 10;

/*Realice los borrados necesarios para que nos permita eliminar el registro de la moneda con código ARS.*/
DELETE FROM [Sales].[CurrencyRate] WHERE FromCurrencyCode = 'ARS' OR ToCurrencyCode = 'ARS';

/*Eliminar aquellas culturas que no estén asignadas a ningún producto */
DELETE FROM [Production].[Culture]
WHERE NOT EXISTS (
	SELECT 1
    FROM [Production].[ProductModelProductDescriptionCulture] pdpc
    WHERE pdpc.CultureID = [Production].[Culture].CultureID
);