
-- CONSULTAS BASICAS

--  Obtener el listado de todas las tarjetas de los clientes junto con su cuota de manejo.
SELECT
    ta.id AS tarjeta_id,
    cl.no mbre AS cliente_nombre,
    cu.total_monto AS cuota_manejo
FROM tarjeta AS ta
JOIN cuota_manejo AS cu ON ta.id = cu.tarjeta_id
JOIN cliente AS cl ON cu.cliente_id = cl.id
WHERE cu.total_monto > 0;

-- Consultar el historial de pagos de un cliente específico

SELECT *
from cliente AS cl 
JOIN pago AS pa ON cl.id = ps.cliente_id
JOIN historial_pagoS AS hi ON pa.id = hi.pago_id
WHERE cl.nombre = 'Juan Perez';

-- Obtener el total de cuotas de manejo pagadas durante un mes determinado.

SELECT 
    SUM(hi.total) AS total_cuotas_pagadas
FROM cliente AS cl
JOIN pago AS pa ON cl.id = pa.cliente_id
JOIN historial_pagos AS hi ON pa.id = hi.pago_id
WHERE YEAR(hi.fecha) = 2023;

-- Consultar las cuotas de manejo de los clientes con descuento aplicado.

SELECT 
    cl.nombre AS clienta_nombre,
    cu.total_monto AS monto_cuota,
    cu.descuento AS descuento_aplicado
FROM cliente AS cl
JOIN cuota_manejo AS cu ON cl.id = cu.cliente_id
WHERE cu.descuento > 0;

-- Obtener un reporte mensual de las cuotas de manejo de cada tarjeta.

SELECT  
    ta.id AS tarjeta_id,
    ta.nombre AS tarjeta_nombre,
    SUM(cu.total_monto) AS total_cuotas_manejo,
    MONTH(cu.fecha) AS mes      
FROM tarjeta AS ta
JOIN cuota_manejo AS cu ON ta.id = cu.tarjeta_id
GROUP BY ta.id, ta.nombre, MONTH(cu.fecha)
HAVING MONTH(cu.fecha) = 1; --ESCOJI EL PRIMER MES DEL AÑO

-- Consultas Avanzadas:
-- Obtener los clientes con pagos pendientes durante los últimos tres meses.


