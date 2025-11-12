/*Productos más vendidos (pizza, panzarottis, bebidas, etc.)*/

SELECT p.nombre AS producto, p.tipo AS tipo, SUM(pp.cantidad) AS cantidad_vendida, SUM(pp.cantidad * pp.precio) AS total_vendido
FROM pedido_producto pp
INNER JOIN productos p ON pp.id_producto = p.id_producto
GROUP BY p.id_producto, p.nombre, p.tipo
ORDER BY cantidad_vendida DESC
LIMIT 10;

/*Total de ingresos generados por cada combo*/

SELECT c.nombre AS combo, c.descripcion, SUM(pp.cantidad * pp.precio) AS total_ingresos
FROM pedido_producto pp
INNER JOIN producto_combo pc ON pp.id_producto = pc.id_producto
INNER JOIN combo c ON pc.id_combo = c.id_combo
GROUP BY c.id_combo, c.nombre, c.descripcion
ORDER BY total_ingresos DESC;


/*Pedidos realizados para recoger vs. comer en la pizzería*/

ALTER TABLE pedidos
ADD COLUMN tipo_pedido ENUM('Recoger', 'Comer en el local') NOT NULL DEFAULT 'Recoger';
/*agregarle una nueva columna llamada tipo_pedido*/

SELECT tipo_pedido, COUNT(*) AS cantidad_pedidos
FROM pedidos
GROUP BY tipo_pedido;


/*Adiciones más solicitadas en pedidos personalizados*/

SELECT a.nombre AS adicion, COUNT(pa.id_adicion) AS veces_solicitada
FROM pedido_adicion pa
INNER JOIN adiciones a ON pa.id_adicion = a.id_adiciones
GROUP BY a.id_adiciones, a.nombre
ORDER BY veces_solicitada DESC;

/*Cantidad total de productos vendidos por categoría*/

SELECT p.tipo AS categoria, SUM(pp.cantidad) AS total_vendidos
FROM pedido_producto pp
INNER JOIN productos p ON pp.id_producto = p.id_producto
GROUP BY p.tipo
ORDER BY total_vendidos DESC;

/*Promedio de pizzas pedidas por cliente*/

SELECT c.nombre AS cliente, c.apellido AS apellido, ROUND(AVG(sub.total_pizzas), 2) AS promedio_pizzas
FROM clientes c
INNER JOIN (
    SELECT p.id_cliente, SUM(pp.cantidad) AS total_pizzas
    FROM pedidos p
    INNER JOIN pedido_producto pp ON p.id_pedido = pp.id_pedido
    INNER JOIN productos pr ON pp.id_producto = pr.id_producto
    WHERE pr.tipo = 'Pizza'
    GROUP BY p.id_pedido, p.id_cliente
) AS sub ON c.id_cliente = sub.id_cliente
GROUP BY c.id_cliente, c.nombre, c.apellido
ORDER BY promedio_pizzas DESC;

/*Total de ventas por día de la semana*/

SELECT DAYNAME(fecha) AS dia_semana, SUM(total) AS total_ventas
FROM pedidos
GROUP BY dia_semana
ORDER BY FIELD(dia_semana, 'lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo');

/*Cantidad de panzarottis vendidos con extra queso*/

SELECT COUNT(DISTINCT pp.id_pedido) AS pedidos_panzarotti_queso, SUM(pp.cantidad) AS cantidad_total
FROM pedido_producto pp
INNER JOIN productos p ON pp.id_producto = p.id_producto
INNER JOIN pedido_adicion pa ON pa.id_pedido = pp.id_pedido
INNER JOIN adiciones a ON pa.id_adicion = a.id_adiciones
WHERE p.tipo = 'Panzarotti' 
    AND a.nombre LIKE '%queso%';

/*Pedidos que incluyen bebidas como parte de un combo*/

SELECT 
DISTINCT p.id_pedido, c.nombre AS combo, pr.nombre AS bebida
FROM pedidos p
INNER JOIN pedido_producto pp ON p.id_pedido = pp.id_pedido
INNER JOIN productos pr ON pp.id_producto = pr.id_producto
INNER JOIN producto_combo pc ON pr.id_producto = pc.id_producto
INNER JOIN combo c ON pc.id_combo = c.id_combo
WHERE pr.tipo = 'Bebida';

/*Clientes que han realizado más de 5 pedidos en el último mes*/

SELECT c.id_cliente, c.nombre, c.apellido, COUNT(p.id_pedido) AS total_pedidos
FROM clientes c
INNER JOIN pedidos p ON c.id_cliente = p.id_cliente
WHERE p.fecha >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY c.id_cliente, c.nombre, c.apellido
HAVING total_pedidos > 5
ORDER BY total_pedidos DESC;

SELECT id_pedido, fecha, id_cliente FROM pedidos;
/*verificar la fecha de pedidos*/


/*Ingresos totales generados por productos no elaborados (bebidas, postres, etc.)*/

SELECT p.tipo AS categoria, SUM(pp.cantidad * pp.precio) AS ingresos_totales
FROM pedido_producto pp
INNER JOIN productos p ON pp.id_producto = p.id_producto
WHERE p.tipo NOT IN ('Pizza', 'Panzarotti')
GROUP BY p.tipo;

/*Promedio de adiciones por pedido*/

SELECT ROUND(AVG(cantidad_adiciones), 2) AS promedio_adiciones_por_pedido
FROM (
    SELECT pa.id_pedido, COUNT(pa.id_adicion) AS cantidad_adiciones
    FROM pedido_adicion pa
    GROUP BY pa.id_pedido
) AS subquery;

/*Total de combos vendidos en el último mes*/

SELECT c.nombre AS combo, COUNT(DISTINCT p.id_pedido) AS total_pedidos, SUM(pp.cantidad) AS total_combos_vendidos
FROM pedidos p
INNER JOIN pedido_producto pp ON p.id_pedido = pp.id_pedido
INNER JOIN producto_combo pc ON pp.id_producto = pc.id_producto
INNER JOIN combo c ON pc.id_combo = c.id_combo
WHERE p.fecha >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY c.id_combo, c.nombre
ORDER BY total_combos_vendidos DESC;

/*Clientes con pedidos tanto para recoger como para consumir en el lugar*/

SELECT c.id_cliente, c.nombre, c.apellido
FROM clientes c
INNER JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre, c.apellido
HAVING SUM(CASE WHEN p.tipo_pedido = 'Recoger' THEN 1 ELSE 0 END) > 0
AND
SUM(CASE WHEN p.tipo_pedido = 'Comer en el local' THEN 1 ELSE 0 END) > 0;

/*Total de productos personalizados con adiciones*/

SELECT COUNT(DISTINCT pp.id_pedido, pp.id_producto) AS total_productos_personalizados, SUM(pp.cantidad) AS cantidad_total
FROM pedido_producto pp
INNER JOIN pedido_adicion pa ON pp.id_pedido = pa.id_pedido;

/*Pedidos con más de 3 productos diferentes*/

SELECT pp.id_pedido, COUNT(DISTINCT pp.id_producto) AS cantidad_productos_diferentes
FROM pedido_producto pp
GROUP BY pp.id_pedido
HAVING cantidad_productos_diferentes > 3
ORDER BY cantidad_productos_diferentes DESC;

/*Promedio de ingresos generados por día*/

SELECT fecha, ROUND(SUM(total) / COUNT(DISTINCT fecha), 2) AS promedio_ingresos
FROM pedidos
GROUP BY fecha
ORDER BY fecha;


/*Clientes que han pedido pizzas con adiciones en más del 50% de sus pedidos*/

SELECT c.id_cliente, c.nombre, c.apellido
FROM clientes c
INNER JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre, c.apellido
HAVING 
    SUM(
        CASE 
            WHEN EXISTS (
                SELECT 1
                FROM pedido_producto pp
                INNER JOIN productos pr ON pp.id_producto = pr.id_producto
                INNER JOIN pedido_adicion pa ON pp.id_pedido = pa.id_pedido
                WHERE pp.id_pedido = p.id_pedido
                AND pr.tipo = 'Pizza'
            ) THEN 1
            ELSE 0
        END
    ) / COUNT(p.id_pedido) > 0.5;

/*Porcentaje de ventas provenientes de productos no elaborados*/

SELECT 
    ROUND(
        SUM(CASE WHEN p.tipo NOT IN ('Pizza', 'Panzarotti') THEN pp.cantidad * pp.precio ELSE 0 END) / SUM(pp.cantidad * pp.precio) * 100, 002) 
        AS porcentaje_no_elaborados
FROM pedido_producto pp
INNER JOIN productos p ON pp.id_producto = p.id_producto;

/*Día de la semana con mayor número de pedidos para recoger*/

SELECT DAYNAME(fecha) AS dia_semana, COUNT(*) AS cantidad_pedidos
FROM pedidos
WHERE tipo_pedido = 'Recoger'
GROUP BY dia_semana
ORDER BY cantidad_pedidos DESC
LIMIT 1;