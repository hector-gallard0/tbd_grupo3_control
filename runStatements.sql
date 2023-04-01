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

-- INICIO Pregunta 2 --

-- Creamos un CTE (Common Table Expression) llamado Suma_gastos que contiene la suma de los gastos por cliente y peluquería en cada mes y año.
WITH Suma_gastos AS (
  SELECT
    c.id_cliente,
    c.nombre AS nombre_cliente, -- Nombre del cliente
    p.id_peluqueria,
    p.nombre_peluqueria, -- Nombre de la peluquería
    co_c.nombre_comuna AS comuna_cliente, -- Comuna del cliente
    co_p.nombre_comuna AS comuna_peluqueria, -- Comuna de la peluquería
    EXTRACT(MONTH FROM ci.fecha_cita) AS mes, -- Extraemos el mes de la fecha de la cita
    EXTRACT(YEAR FROM ci.fecha_cita) AS anio, -- Extraemos el año de la fecha de la cita
    SUM(d.precio_detalle) AS total_gasto -- Sumamos el total gastado por el cliente en la cita
  FROM
    Cliente c
    INNER JOIN Cliente_peluqueria cp ON c.id_cliente = cp.id_cliente -- Unimos la tabla Cliente con Cliente_peluqueria
    INNER JOIN Peluqueria p ON cp.id_peluqueria = p.id_peluqueria -- Unimos la tabla Cliente_peluqueria con Peluqueria
    INNER JOIN Comuna co_c ON c.id_comuna = co_c.id_comuna -- Unimos la tabla Cliente con Comuna (para obtener la comuna del cliente)
    INNER JOIN Comuna co_p ON p.id_comuna = co_p.id_comuna -- Unimos la tabla Peluqueria con Comuna (para obtener la comuna de la peluquería)
    INNER JOIN Cita ci ON cp.id_cliente_peluqueria = ci.id_cliente_peluqueria -- Unimos la tabla Cliente_peluqueria con Cita
    INNER JOIN Detalle d ON ci.id_cita = d.id_cita -- Unimos la tabla Cita con Detalle
  GROUP BY
    c.id_cliente,
    c.nombre,
    p.id_peluqueria,
    p.nombre_peluqueria,
    co_c.nombre_comuna,
    co_p.nombre_comuna,
    mes,
    anio
),
-- Creamos otro CTE llamado Clientes_max_gasto que contiene el máximo gasto mensual por peluquería
Clientes_max_gasto AS (
  SELECT
    mes,
    anio,
    id_peluqueria,
    MAX(total_gasto) AS max_gasto -- Obtenemos el máximo gasto mensual por peluquería
  FROM
    Suma_gastos
  GROUP BY
    mes,
    anio,
    id_peluqueria
)
-- Seleccionamos la información de los clientes que gastaron el máximo en cada peluquería en cada mes y año
SELECT
  sg.nombre_cliente,
  sg.comuna_cliente,
  sg.comuna_peluqueria,
  sg.total_gasto
FROM
  Suma_gastos sg
  INNER JOIN Clientes_max_gasto cmg ON sg.mes = cmg.mes -- Unimos Suma_gastos con Clientes_max_gasto en función del mes
  AND sg.anio = cmg.anio -- Unimos Suma_gastos con Clientes_max_gasto en función del año
  AND sg.id_peluqueria = cmg.id_peluqueria --
ORDER BY 
  sg.total_gasto DESC -- Ordenamos los gastos de manera descendiente para obtener los clientes que más gastaron

-- FIN Pregunta 2 --