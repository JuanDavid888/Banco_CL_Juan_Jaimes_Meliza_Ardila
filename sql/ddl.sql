-- Active: 1750449603061@@127.0.0.1@3307@banco

CREATE DATABASE banco DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE banco;

SHOW TABLES;

-- Borrar tablas

DROP TABLE IF EXISTS cuota_manejo;

DROP TABLE IF EXISTS pago;

DROP TABLE IF EXISTS historial_pagos;

DROP TABLE IF EXISTS historial_cuotas;

DROP TABLE IF EXISTS cliente;

DROP TABLE IF EXISTS cuenta_bancaria;

DROP TABLE IF EXISTS tarjeta;

DROP TABLE IF EXISTS tipo_tarjeta;

DROP TABLE IF EXISTS intereses;

DROP TABLE IF EXISTS descuento;

DROP TABLE IF EXISTS tipo_cuenta;

-- Crear tablas

CREATE TABLE tipo_cuenta (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre ENUM('Ahorros', 'Corriente', 'Inversion') NOT NULL
);

CREATE TABLE descuento (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre ENUM('Basico', 'Platino', 'Diamante') NOT NULL,
    tasa_descuento DECIMAL(5,2) NOT NULL -- Representa el porcentaje (%)
);

CREATE TABLE intereses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    monto_minimo DECIMAL(12,2) NOT NULL,
    monto_maximo DECIMAL(12,2) NOT NULL,
    tasa_interes DECIMAL(5,2) NOT NULL -- Representa el porcentaje (%)
);

CREATE TABLE tipo_tarjeta (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre ENUM('Joven', 'Nomina', 'Visa') NOT NULL,
    descuento_id INT NOT NULL
);

CREATE TABLE tarjeta (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(16) NOT NULL UNIQUE,
    cliente_id INT NOT NULL,
    tipo_tarjeta_id INT NOT NULL,
    cuenta_bancaria_id INT NOT NULL,
    fecha_activacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_expiracion DATETIME NOT NULL,
    estado ENUM('Activa', 'Inactiva', 'Bloqueada', 'Cerrada') DEFAULT 'Activa'
);

CREATE TABLE cuenta_bancaria (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    numero_cuenta VARCHAR(10) NOT NULL UNIQUE,
    tipo_cuenta_id INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    estado ENUM('Activa', 'Inactiva', 'Bloqueada', 'Cerrada') DEFAULT 'Activa',
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cliente (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(10) NOT NULL UNIQUE,
    direccion VARCHAR(100) NOT NULL,
    tarjeta_id INT NOT NULL UNIQUE
);

CREATE TABLE cuota_manejo (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    tarjeta_id INT NOT NULL,
    interes_id INT NOT NULL,
    descuento_id INT NOT NULL,
    total_cuotas INT NOT NULL,
    total_monto DECIMAL(10,2) NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE pago (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    tarjeta_id INT NOT NULL,
    total DECIMAL(10,2) NOT NULL
);

CREATE TABLE historial_pagos (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    pago_id INT NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE historial_cuotas (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cuotas_manejo_id INT NOT NULL,
    total_cuotas INT NOT NULL,
    total_monto DECIMAL(10,2) NOT NULL,
    fecha_cuota DATETIME NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- LLaves foraneas

ALTER TABLE cuota_manejo
    ADD FOREIGN KEY (cliente_id) REFERENCES cliente(id);

ALTER TABLE cuota_manejo
    ADD FOREIGN KEY (tarjeta_id) REFERENCES tarjeta(id);

ALTER TABLE cuota_manejo
    ADD FOREIGN KEY (interes_id) REFERENCES intereses(id);

ALTER TABLE cuota_manejo
    ADD FOREIGN KEY (descuento_id) REFERENCES descuento(id);

ALTER TABLE pago
    ADD FOREIGN KEY (cliente_id) REFERENCES cliente(id);

ALTER TABLE pago
    ADD FOREIGN KEY (tarjeta_id) REFERENCES tarjeta(id);

ALTER TABLE historial_pagos
    ADD FOREIGN KEY (pago_id) REFERENCES pago(id);

ALTER TABLE historial_cuotas
    ADD FOREIGN KEY (cuotas_manejo_id) REFERENCES cuota_manejo(id);

ALTER TABLE tarjeta
    ADD FOREIGN KEY (cliente_id) REFERENCES cliente(id);

ALTER TABLE tarjeta
    ADD FOREIGN KEY (tipo_tarjeta_id) REFERENCES tipo_tarjeta(id);

ALTER TABLE tarjeta
    ADD FOREIGN KEY (cuenta_bancaria_id) REFERENCES cuenta_bancaria(id);

ALTER TABLE tipo_tarjeta
    ADD FOREIGN KEY (descuento_id) REFERENCES descuento(id);

ALTER TABLE cuenta_bancaria
    ADD FOREIGN KEY (tipo_cuenta_id) REFERENCES tipo_cuenta(id);

ALTER TABLE cliente
    ADD FOREIGN KEY (tarjeta_id) REFERENCES tarjeta(id);