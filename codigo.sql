CREATE TABLE `clientes`(
    `id_cliente` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(255) NOT NULL,
    `apellido` VARCHAR(255) NOT NULL,
    `direccion` VARCHAR(255) NOT NULL,
    `telefono` VARCHAR(255) NOT NULL
);
CREATE TABLE `productos`(
    `id_producto` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `descripcion` VARCHAR(255) NOT NULL,
    `tipo` VARCHAR(255) NOT NULL,
    `precio` DECIMAL(10,2) NOT NULL,
    `nombre` VARCHAR(255) NOT NULL
);
CREATE TABLE `pedidos`(
    `id_pedido` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `fecha` DATE NOT NULL,
    `hora` TIME NOT NULL,
    `total` DECIMAL(10,2) NOT NULL,
    `id_cliente` INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);
CREATE TABLE `ingrediente`(
    `id_ingrediente` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(255) NOT NULL,
    `unidad` INT NOT NULL
);
CREATE TABLE `adiciones`(
    `id_adiciones` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(255) NOT NULL,
    `precio` DECIMAL(10,2) NOT NULL,
    `id_ingrediente` INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_ingrediente) REFERENCES ingrediente(id_ingrediente)
);
CREATE TABLE `combo`(
    `id_combo` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(255) NOT NULL,
    `descripcion` VARCHAR(255) NOT NULL,
    `precio` DECIMAL(10,2) NOT NULL
);
CREATE TABLE `menu`(
    `id_menu` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `fecha_inicial` DATE NOT NULL,
    `fecha_final` DATE NOT NULL,
    `nombre` VARCHAR(255) NOT NULL
);
CREATE TABLE `pedido_producto`(
    `id_pedido` INT UNSIGNED NOT NULL,
    `id_producto` INT UNSIGNED NOT NULL,
    `cantidad` INT NOT NULL,
    `precio` DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_pedido, id_producto),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
CREATE TABLE `pedido_adicion`(
    `id_pedido` INT UNSIGNED NOT NULL,
    `id_adicion` INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_pedido, id_adicion),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_adicion) REFERENCES adiciones(id_adiciones)
);
CREATE TABLE `producto_ingrediente`(
    `id_producto` INT UNSIGNED NOT NULL,
    `id_ingrediente` INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_producto, id_ingrediente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_ingrediente) REFERENCES ingrediente(id_ingrediente)
);
CREATE TABLE `producto_combo`(
    `id_producto` INT UNSIGNED NOT NULL,
    `id_combo` INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_producto, id_combo),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_combo) REFERENCES combo(id_combo)
);
CREATE TABLE `menu_producto`(
    `id_menu` INT UNSIGNED NOT NULL,
    `id_producto` INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_menu, id_producto),
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
CREATE TABLE `menu_combo`(
    `id_menu` INT UNSIGNED NOT NULL,
    `id_combo` INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_menu, id_combo),
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu),
    FOREIGN KEY (id_combo) REFERENCES combo(id_combo)
);