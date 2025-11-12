/*combo*/

INSERT INTO combo (nombre, descripcion, precio) VALUES ('Combo Familiar', 'Incluye 2 pizzas grandes y 2 gaseosas', 60000);

select * from combo;


/* clientes */

INSERT INTO clientes (nombre, apellido, direccion, telefono) VALUES ('Laura', 'Gómez', 'Calle 10 #5-23', '3114567890'), ('Carlos', 'Martínez', 'Carrera 12 #8-45', '3123456789'), ('Danna', 'Monroy', 'Av. Principal #9-22', '3109876543');

select * from clientes;

/*ingredientes*/

INSERT INTO ingrediente (nombre, unidad) VALUES ('Queso mozzarella', 100), ('Jamón', 100), ('Piña', 50), ('Pollo', 100), ('Carne', 100), ('Gaseosa', 500);

select * from ingrediente;

/*adiciones*/

INSERT INTO adiciones (nombre, precio, id_ingrediente) VALUES ('Extra queso', 3000, 1), ('Extra jamón', 2500, 2), ('Extra piña', 2000, 3);

select * from adiciones;

/*productos*/

INSERT INTO productos (descripcion, tipo, precio, nombre) VALUES ('Pizza hawaiana grande', 'Pizza', 25000, 'Pizza Hawaiana'), ('Pizza de pollo', 'Pizza', 26000, 'Pizza Pollo'), ('Panzarotti de carne', 'Panzarotti', 18000, 'Panzarotti Carne'), ('Panzarotti de pollo', 'Panzarotti', 18000, 'Panzarotti Pollo'), ('Gaseosa 1.5L', 'Bebida', 5000, 'Gaseosa 1.5L'), ('Agua 600ml', 'Bebida', 4000, 'Agua');

select * from productos;

/*producto_ingrediente*/

INSERT INTO producto_ingrediente (id_producto, id_ingrediente) VALUES (1,1), (1,2), (1,3), -- Pizza Hawaiana (queso, jamón, piña)
(2,1), (2,4), -- Pizza Pollo (queso, pollo)
(3,1), (3,5), -- Panzarotti Carne (queso, carne)
(4,1), (4,4); 

select * from producto_ingrediente;

/*combo*/

INSERT INTO combo (nombre, descripcion, precio) VALUES ('Combo Familiar', 'Incluye 2 pizzas grandes y 2 gaseosas', 60000), ('Combo Pareja', '1 pizza mediana + 2 bebidas', 35000);

/*PRODUCTO - COMBO*/

INSERT INTO producto_combo (id_producto, id_combo) VALUES (1,1), (2,1), (5,1), -- Combo Familiar: 2 pizzas + gaseosa
(1,2), (5,2);  -- Combo Pareja: pizza + gaseosa

select * from producto_combo;

/*menus*/

INSERT INTO menu (fecha_inicial, fecha_final, nombre) VALUES ('2025-11-01', '2025-11-30', 'Menú Noviembre');

select * from menu;

/*menu- producto_menu -combo*/

INSERT INTO menu_producto (id_menu, id_producto) VALUES (1,1), (1,2), (1,3), (1,4), (1,5), (1,6);

INSERT INTO menu_combo (id_menu, id_combo) VALUES (1,1), (1,2);

select * from menu_producto;
select * from menu_combo;

/*pedidos*/

INSERT INTO pedidos (fecha, hora, total, id_cliente) VALUES ('2025-11-10', '12:30:00', 48000, 1), ('2025-11-11', '13:45:00', 60000, 2), ('2025-11-12', '19:15:00', 35000, 3);

select * from pedidos;

/*pedido_producto*/

INSERT INTO pedido_producto (id_pedido, id_producto, cantidad, precio) VALUES (1, 1, 1, 25000), (1, 5, 2, 5000), (2, 1, 2, 25000), (2, 5, 2, 5000), (3, 2, 1, 26000), (3, 6, 1, 4000);

select * from pedido_producto;

/*pedido_adicion*/

INSERT INTO pedido_adicion (id_pedido, id_adicion) VALUES (1, 1), -- Pedido 1 pidió extra queso
(2, 2); -- Pedido 2 pidió extra jamón

select * from pedido_adicion;







