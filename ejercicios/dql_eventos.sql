--  Obtener el listado de todas las tarjetas de los clientes junto con su cuota de manejo.
SELECT
    ta.id AS tarjeta_id,
    cl.nombre AS cliente_nombre,
    cu.total_monto AS cuota_manejo
FROM tarjeta AS ta
JOIN cuota_manejo AS cu ON ta.id = cu.tarjeta_id
JOIN cliente AS cl ON cu.cliente_id = cl.id
WHERE cu.total_monto > 0;


