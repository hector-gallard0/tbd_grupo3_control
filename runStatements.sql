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

--- CTE Mes: Extrae los meses y años distintos de las citas en la tabla Cita.
WITH Mes AS (
  SELECT EXTRACT(MONTH FROM fecha_cita) AS mes, EXTRACT(YEAR FROM fecha_cita) AS anio
  FROM Cita
  GROUP BY EXTRACT(MONTH FROM fecha_cita), EXTRACT(YEAR FROM fecha_cita)
),

-- CTE GastoMensualCliente: Calcula el gasto mensual total para cada cliente en cada peluquería.
GastoMensualCliente AS (
  SELECT
    Mes.mes,
    Mes.anio,
    C.id_cliente,
    C.nombre,
    Co.nombre_comuna AS comuna_cliente,
    P.nombre_peluqueria,
    PComuna.nombre_comuna AS comuna_peluqueria,
    SUM(D.precio_detalle) AS total_gastado
  FROM Mes, Cita CI, Cliente_peluqueria CP, Cliente C, Peluqueria P, Comuna Co, Comuna PComuna, Detalle D
  WHERE EXTRACT(MONTH FROM CI.fecha_cita) = Mes.mes
    AND EXTRACT(YEAR FROM CI.fecha_cita) = Mes.anio
    AND CI.id_cliente_peluqueria = CP.id_cliente_peluqueria
    AND CP.id_cliente = C.id_cliente
    AND CP.id_peluqueria = P.id_peluqueria
    AND C.id_comuna = Co.id_comuna
    AND P.id_comuna = PComuna.id_comuna
    AND CI.id_cita = D.id_cita
  GROUP BY Mes.mes, Mes.anio, C.id_cliente, C.nombre, Co.nombre_comuna, P.nombre_peluqueria, PComuna.nombre_comuna
),

-- CTE GastoMensualMaximo: Encuentra el gasto máximo mensual por cliente.
GastoMensualMaximo AS (
  SELECT
    mes,
    anio,
    MAX(total_gastado) AS max_gasto
  FROM GastoMensualCliente
  GROUP BY mes, anio
)

-- Consulta principal: Combina las CTEs GastoMensualCliente y GastoMensualMaximo, filtrando los registros con gasto máximo mensual.
SELECT
  GMC.mes,
  GMC.anio,
  GMC.id_cliente,
  GMC.nombre,
  GMC.comuna_cliente,
  GMC.nombre_peluqueria,
  GMC.comuna_peluqueria,
  GMC.total_gastado
FROM GastoMensualCliente GMC, GastoMensualMaximo GMM
WHERE GMC.mes = GMM.mes
  AND GMC.anio = GMM.anio
  AND GMC.total_gastado = GMM.max_gasto
-- Ordena los resultados por total_gastado en orden descendente.
ORDER BY GMC.total_gastado DESC;

-- FIN Pregunta 2 --