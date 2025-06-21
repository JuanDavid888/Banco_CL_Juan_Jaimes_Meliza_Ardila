-- Active: 1750467929662@@127.0.0.1@3307@banco

SHOW TABLES;

-- Inserts

INSERT INTO tipo_cuenta (nombre)
VALUES('Ahorros'),
('Corriente'),
('Inversion');

INSERT INTO descuento (nombre, tasa_descuento)
VALUES('Basico', 0.10),
('Platino', 0.15),
('Diamante', 0.20);

INSERT INTO intereses (monto_minimo, monto_maximo, tasa_interes) 
VALUES(100000.00, 249999.99, 0.05),
(250000.00, 499999.99, 0.10),
(500000.00, 9999999.99, 0.15);