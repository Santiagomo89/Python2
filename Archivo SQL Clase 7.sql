-- Linea de comentario
-- Sentencias SQL de  estructura
-- CREATE, ALTER, DROP
-- Sentencias SQL de registros
-- La de solo lectura seria Select (no modifica nada)
-- si modifican registros, INSERT INTO, UPDATE, DELETE
Use Neptuno
Select * from Pedidos;
go
-- Ver solo algunos campos
Select Destinatario, FechaPedido from Pedidos;
-- Alias de campo
Select Destinatario as Cliente, FechaPedido from Pedidos;
-- Una función en el sujeto
Select Destinatario as Cliente, YEAR(FechaPedido) as Año
from Pedidos;
-- Ordenación con order by (por defecto es ASC)
Select Destinatario as Cliente, YEAR(FechaPedido) as Año
from Pedidos order by Destinatario;
-- Al reves
Select Destinatario as Cliente, YEAR(FechaPedido) as Año
from Pedidos order by Destinatario desc;
-- Se puede ordenar por mas de un campo
Select * from Pedidos order by PaísDestinatario, 
CiudadDestinatario;
Select * from Pedidos order by PaísDestinatario asc, 
CiudadDestinatario desc;
-- Ver los primeros n registros, usaremos el top
Select top(10) * from Pedidos;
Select top(10) * from Pedidos order by PaísDestinatario;
-- En el sujeto puedo concatenar campos (con el +) e 
-- incluso texto de manera manual
Select CiudadDestinatario+' ('+PaísDestinatario+')' as
Ciudad_Pais from Pedidos;
-- Truco primero poner la tabla en el from, despues
-- regresar al sujeto y me muestra los campos
Select CiudadDestinatario from Pedidos
-- Si una tabla o un campo tiene espacios en blanco
-- tendre problemas, solución poner entre corchetes
-- Operación aritmetica en el sujeto
Select 
	Cantidad,
	PrecioUnidad,
	(Cantidad * PrecioUnidad) as Importe 
from 
	Detalles_de_pedidos;
-- Como filtrar datos, mediante where, 
-- solo los registros de Alemania
Select
	*
from
	Pedidos
where
	PaísDestinatario='Alemania';
-- Cómo filtrar datos de dos países
Select
	*
from
	Pedidos
where
	PaísDestinatario='Alemania'
or
    PaísDestinatario='Argentina';
-- Seleccionar los registros de Argentina y del año 1997
Select
	*
from
	Pedidos
where
	PaísDestinatario='Argentina'
and
    YEAR(FechaPedido)=1997
order by IdPedido;
-- FUNCIONES DE AGREGADO (SUM, AVERAGE, MAX, MIN, COUNT)
-- UNA FUNCIÓN DE AGREGADO NECESITA SIEMPRE UNA CLÁUSULA GROUP BY DONDE PONER LAS DIMENSIONES
-- EXCEPTO EN EL CASO DE COUNT(*) = NÚMERO DE FILAS O REFGISTROS
Select 'El número de filas es ', Count(*) from Pedidos;
-- Vamos a sumar las unidades por país
--Necesitamos combinar dos tablas, lo que se puede hacer con JOIN) implícito sencillo para INNER JOIN
Select Pedidos.PaísDestinatario, SUM
   (Detalles_de_pedidos.Cantidad) as Total_Cantidad
from 
    Detalles_de_pedidos, Pedidos
where
    Pedidos.IdPedido = Detalles_de_pedidos.IdPedido
group by
    Pedidos.PaísDestinatario;
