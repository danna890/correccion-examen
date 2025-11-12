# Sistema de Gestión de Pizzería

## Descripción del Proyecto

Es un sistema de base de datos diseñado para gestionar eficientemente los productos, combos, pedidos y clientes de una pizzería.  
El sistema permite registrar pizzas, panzarottis, bebidas, postres, adiciones y combos especiales; además de manejar los pedidos realizados por los clientes, ya sean para **consumir en el lugar** o **recoger**.

El objetivo principal es centralizar la información y facilitar consultas sobre ventas, productos más vendidos y comportamiento de los clientes.

## Estructura del Repositorio

```
CampusPizza/
│
├── codigo.sql                      # Contiene toda la estructura (creación de tablas, claves primarias y foráneas)
├── insertar_datos.sql              # Contiene los INSERT con datos de prueba realistas
├── consultas.sql                   # Contiene las 20 consultas SQL del examen
├── drawSQL-image-export-2025-11-12.png  # Imagen del modelo relacional exportado desde drawSQL
└── README.md                       # Documento explicativo con instrucciones y descripción del proyecto
```

## Tecnologías Utilizadas

- **Gestor de Base de Datos:** MySQL 8.0  
- **Lenguaje de Consultas:** SQL  
- **Herramientas de Diseño:** MySQL Workbench / drawSQL / StarUML  
- **Autor:** Danna Valentina Monroy León  

## Instrucciones de Ejecución

1. **Abrir MySQL Workbench** o el cliente de tu preferencia.  
2. Crear la base de datos:
   ```sql
   CREATE DATABASE pizzeria;
   USE pizzeria;

## Modelo de Base de Datos (Resumen)

**Entidades principales:**

-clientes
-roductos
-categorias
-adiciones
-combos
-combo_producto
-pedidos
-pedido_producto
-pedido_adicion

**Relaciones clave:**
-Un cliente puede tener muchos pedidos.
-Un pedido puede contener varios productos y adiciones.
-Un combo puede incluir múltiples productos.
-Cada producto pertenece a una categoría.

