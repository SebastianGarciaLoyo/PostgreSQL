-- Creando la base de datos miscompras

create database miscompras;

use miscompras;

-- Creando la Tabla "categorias"
CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY,
    descripcion VARCHAR(45),
    estado SMALLINT
);

-- Creando la Tabla "productos"
CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(45),
    id_categoria INT,
    codigo_barras VARCHAR(150),
    precio_venta NUMERIC(16,2),
    cantidad_stock INT,
    estado SMALLINT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- Creando la Tabla "clientes"
CREATE TABLE clientes (
    id VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(40),
    apellidos VARCHAR(100),
    celular NUMERIC(10,0),
    direccion VARCHAR(80),
    correo_electronico VARCHAR(70)
);

-- Creando la Tabla "compras"
CREATE TABLE compras (
    id_compra INT PRIMARY KEY,
    id_cliente VARCHAR(20),
    fecha TIMESTAMP,
    medio_pago CHAR(1),
    comentario VARCHAR(300),
    estado CHAR(1),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id)
);

-- Creando la Tabla "compras_productos"
CREATE TABLE compras_productos (
    id_compra INT,
    id_producto INT,
    cantidad INT,
    total NUMERIC(16,2),
    estado SMALLINT,
    PRIMARY KEY (id_compra, id_producto),
    FOREIGN KEY (id_compra) REFERENCES compras(id_compra),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);