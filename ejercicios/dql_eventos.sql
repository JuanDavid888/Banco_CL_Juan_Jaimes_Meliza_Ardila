--  Obtener el listado de todas las tarjetas de los clientes junto con su cuota de manejo.
SELECT
    ta.id AS tarjeta_id,
    cl.nombre AS cliente_nombre,
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