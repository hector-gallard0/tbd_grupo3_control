-- 1.	horario con menos citas durante el día por peluquería, identificando la comuna
WITH table1 AS (SELECT t.id_peluqueria, t.nombre_peluqueria, t.hora_inicio, count(*) AS qty
FROM (
	SELECT p.id_peluqueria, p.nombre_peluqueria, c.fecha_cita, h.hora_inicio, co.nombre_comuna
	FROM cita c, cliente_peluqueria cp, peluqueria p, comuna co, horario h
	WHERE c.id_cliente_peluqueria = cp.id_cliente_peluqueria
	AND cp.id_peluqueria = p.id_peluqueria
	AND p.id_comuna = co.id_comuna
	AND c.id_horario = h.id_horario
	ORDER BY p.nombre_peluqueria
) as t
GROUP BY (t.id_peluqueria, t.nombre_peluqueria, t.hora_inicio)
)

SELECT t.id_peluqueria, t.nombre_peluqueria, t.hora_inicio, t.qty
FROM table1 t
WHERE qty = (
	SELECT MIN(qty)
	FROM table1 t2
	WHERE t2.id_peluqueria = t.id_peluqueria 
)
ORDER BY id_peluqueria

