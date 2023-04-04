-- INICIO Pregunta 1 --

-- 1.	Horario con menos citas durante el día por peluquería, identificando la comuna
WITH t2 AS (
	SELECT t1.id_peluqueria, t1.nombre_peluqueria, t1.hora_inicio, t1.nombre_comuna, count(*) AS num_citas
	FROM (
		SELECT p.id_peluqueria, p.nombre_peluqueria, c.fecha_cita, h.hora_inicio, co.nombre_comuna
		FROM cita c, cliente_peluqueria cp, peluqueria p, comuna co, horario h
		WHERE c.id_cliente_peluqueria = cp.id_cliente_peluqueria
		AND cp.id_peluqueria = p.id_peluqueria
		AND p.id_comuna = co.id_comuna
		AND c.id_horario = h.id_horario
		ORDER BY p.nombre_peluqueria
	) as t1
	GROUP BY (t1.id_peluqueria, t1.nombre_peluqueria, t1.hora_inicio, t1.nombre_comuna)
)

SELECT t2.id_peluqueria, t2.nombre_peluqueria, t2.hora_inicio, t2.nombre_comuna, t2.num_citas
FROM t2
WHERE t2.num_citas = (
	SELECT MIN(t3.num_citas)
	FROM t2 t3
	WHERE t3.id_peluqueria = t2.id_peluqueria 
)
ORDER BY t2.num_citas;

-- FIN Pregunta 1 --

---------------------------------------------------------------------------------------------------------------------

-- INICIO Pregunta 2 --

-- 2.	Lista de clientes que gastan más dinero mensual por peluquería, indicando comuna del cliente y de peluquería, además de cuanto gasto --

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

---------------------------------------------------------------------------------------------------------------------

-- INICIO Pregunta 3 --

-- 3.	lista de peluqueros que ha ganado más por mes los últimos 3 años, esto por peluquería

-- En vez de considerar el sueldo en esta pregunta decidimos agregar un bono por cita dependiendo de la peluqueria, porque sino, 
-- basándonos netamente en el sueldo, siempre saldría el mismo peluquero por peluquería (aquel con el sueldo más alto)

WITH t2 AS (
	SELECT t1.ano, t1.mes, t1.id_peluqueria, t1.nombre_peluqueria, MAX(t1.total_bono_mes) AS max_total_bono_mes
	FROM
	(SELECT
		EXTRACT(YEAR FROM ci.fecha_cita) as ano,
		EXTRACT(MONTH FROM ci.fecha_cita) as mes,
		p.id_peluqueria,
		p.nombre_peluqueria,
		pe.id_peluquero,
		e.nombre_empleado,
		COUNT(*) * p.bono_cita as total_bono_mes
	FROM peluquero pe
	JOIN cita ci
	ON ci.id_peluquero = pe.id_peluquero
	JOIN empleado e
	ON e.id_empleado = pe.id_empleado
	JOIN cliente_peluqueria cp
	ON ci.id_cliente_peluqueria = cp.id_cliente_peluqueria
	JOIN peluqueria p
	ON cp.id_peluqueria = p.id_peluqueria
	GROUP BY ano, mes, p.id_peluqueria, p.nombre_peluqueria, pe.id_peluquero, e.nombre_empleado
	) as t1
	GROUP BY t1.ano, t1.mes, t1.id_peluqueria, t1.nombre_peluqueria
	ORDER BY  t1.id_peluqueria, t1.ano, t1.mes
)

SELECT t2.ano, t2.mes, t2.id_peluqueria, t2.nombre_peluqueria, t3.id_peluquero, t3.nombre_empleado, t2.max_total_bono_mes
FROM t2
JOIN (
	SELECT
		EXTRACT(YEAR FROM ci.fecha_cita) as ano,
		EXTRACT(MONTH FROM ci.fecha_cita) as mes,
		p.id_peluqueria,
		p.nombre_peluqueria,
		pe.id_peluquero,
		e.nombre_empleado,
		COUNT(*) * p.bono_cita as total_bono_mes
	FROM peluquero pe
	JOIN cita ci
	ON ci.id_peluquero = pe.id_peluquero
	JOIN empleado e
	ON e.id_empleado = pe.id_empleado
	JOIN cliente_peluqueria cp
	ON ci.id_cliente_peluqueria = cp.id_cliente_peluqueria
	JOIN peluqueria p
	ON cp.id_peluqueria = p.id_peluqueria
	GROUP BY ano, mes, p.id_peluqueria, p.nombre_peluqueria, pe.id_peluquero, e.nombre_empleado
) as t3
ON t2.ano = t3.ano
AND t2.mes = t3.mes
AND t2.id_peluqueria = t3.id_peluqueria
AND t2.nombre_peluqueria = t3.nombre_peluqueria
AND t2.max_total_bono_mes = t3.total_bono_mes
WHERE t2.ano >= extract(YEAR from now()) - 2
ORDER BY t2.id_peluqueria, t2.ano, t2.mes;


-- FIN Pregunta 3 --

---------------------------------------------------------------------------------------------------------------------

-- INICIO Pregunta 4 --

-- 4.	lista de clientes hombres que se cortan el pelo y la barba

-- *Para comprobar esta pregunta se hizo una única cita de id 3001 con 2 servicios asociados (corte de pelo y barba) a su detalle para el cliente de id 1

SELECT DISTINCT cl.id_cliente, cl.nombre
FROM  cliente cl
JOIN cliente_peluqueria cp
ON cl.id_cliente = cp.id_cliente
JOIN cita ci
ON cp.id_cliente_peluqueria = ci.id_cliente_peluqueria
JOIN detalle d
ON d.id_cita = ci.id_cita
JOIN servicio s
ON s.id_servicio = 2 OR s.id_servicio = 3
JOIN detalle_servicio ds
ON ds.id_detalle = d.id_detalle
AND ds.id_servicio = s.id_servicio 
JOIN detalle_servicio ds1
ON ds1.id_servicio = 
	(CASE
		WHEN ds.id_servicio = 2 THEN 3
		WHEN ds.id_servicio = 3 THEN 2
	 END
 	)
AND ds.id_detalle = ds1.id_detalle
WHERE cl.sexo = 'M'
order by cl.id_cliente;

-- FIN Pregunta 4 --

---------------------------------------------------------------------------------------------------------------------

-- INICIO Pregunta 5 --

-- 5.	lista de clientes que se tiñen el pelo, indicando la comuna del cliente, la peluquería donde se atendió y el valor que pagó

-- *Considerando que todos los clientes han hecho todos los servicios al menos una vez en distintas peluquerias, se borran
-- los servicios de teñido de pelo asociados al cliente de id 1 a modo de comprobación, es decir, este no aparece en la query 5.

SELECT cl.id_cliente, cl.nombre, co.nombre_comuna, pe.nombre_peluqueria, s.precio_servicio
FROM cliente cl
JOIN cliente_peluqueria cp
ON cl.id_cliente = cp.id_cliente
JOIN cita ci
ON cp.id_cliente_peluqueria = ci.id_cliente_peluqueria
JOIN peluqueria pe
ON pe.id_peluqueria = cp.id_peluqueria
JOIN detalle d
ON d.id_cita = ci.id_cita
JOIN detalle_servicio ds
ON d.id_detalle = ds.id_detalle
JOIN comuna co
ON cl.id_comuna = co.id_comuna
JOIN servicio s
ON s.id_servicio = ds.id_servicio
WHERE ds.id_servicio = 4
GROUP BY cl.id_cliente, cl.nombre, co.nombre_comuna, pe.nombre_peluqueria, s.precio_servicio
ORDER BY cl.id_cliente;

-- FIN Pregunta 5 --

---------------------------------------------------------------------------------------------------------------------

-- INICIO Pregunta 6 --

-- 6.	Identificar el horario más concurrido por peluquería durante el 2018 y 2029, desagregados por mes

WITH t1 AS(
	SELECT t1.nombre_peluqueria, t1.ano, t1.mes, MAX(t1.num_citas) as max_num_citas
	FROM (
		SELECT 
			pe.nombre_peluqueria,
			EXTRACT(YEAR FROM ci.fecha_cita) as ano, 
			EXTRACT(MONTH FROM ci.fecha_cita) as mes,
			h.hora_inicio,
			count(*) as num_citas
		FROM peluqueria pe
		JOIN cliente_peluqueria cp
		ON pe.id_peluqueria = cp.id_peluqueria
		JOIN cita ci
		ON cp.id_cliente_peluqueria = ci.id_cliente_peluqueria
		JOIN horario h
		ON ci.id_horario = h.id_horario
		GROUP BY 
			(pe.nombre_peluqueria,
			EXTRACT(YEAR FROM ci.fecha_cita), 
			EXTRACT(MONTH FROM ci.fecha_cita),
			h.hora_inicio)
		ORDER BY pe.nombre_peluqueria) AS t1
	GROUP BY t1.nombre_peluqueria, t1.ano, t1.mes
)

SELECT DISTINCT ON (t1.nombre_peluqueria, t1.ano, t1.mes)
	t1.nombre_peluqueria, t1.ano, t1.mes, t2.hora_inicio, t1.max_num_citas as num_citas
FROM t1
JOIN (
	SELECT 
			pe.nombre_peluqueria,
			EXTRACT(YEAR FROM ci.fecha_cita) as ano, 
			EXTRACT(MONTH FROM ci.fecha_cita) as mes,
			h.hora_inicio,
			count(*) as num_citas
		FROM peluqueria pe
		JOIN cliente_peluqueria cp
		ON pe.id_peluqueria = cp.id_peluqueria
		JOIN cita ci
		ON cp.id_cliente_peluqueria = ci.id_cliente_peluqueria
		JOIN horario h
		ON ci.id_horario = h.id_horario
		GROUP BY 
			(pe.nombre_peluqueria,
			EXTRACT(YEAR FROM ci.fecha_cita), 
			EXTRACT(MONTH FROM ci.fecha_cita),
			h.hora_inicio)
		ORDER BY pe.nombre_peluqueria) as t2
ON t1.nombre_peluqueria = t2.nombre_peluqueria
AND t1.ano = t2.ano
AND t1.mes = t2.mes
AND t1.max_num_citas = t2.num_citas;

-- FIN Pregunta 6 --

---------------------------------------------------------------------------------------------------------------------

-- INICIO Pregunta 7 --

-- 7.	Identificar al cliente que ha tenido las citas más largas por peluquería, por mes

WITH t2 AS (
	SELECT t1.nombre_peluqueria, t1.ano, t1.mes, MAX(duracion_cita) as max_duracion_cita
	FROM (
		SELECT 
			pe.nombre_peluqueria, 
			EXTRACT(YEAR FROM ci.fecha_cita) AS ano, 
			EXTRACT(MONTH FROM ci.fecha_cita) AS mes,
			cl.nombre,
			ci.duracion_cita
		FROM peluqueria pe
		JOIN cliente_peluqueria cp
		ON pe.id_peluqueria = cp.id_peluqueria
		JOIN cliente cl
		ON cl.id_cliente = cp.id_cliente
		JOIN cita ci
		ON cp.id_cliente_peluqueria = ci.id_cliente_peluqueria
		ORDER BY 
			pe.nombre_peluqueria, 
			EXTRACT(YEAR FROM ci.fecha_cita), 
			EXTRACT(MONTH FROM ci.fecha_cita)) as t1
GROUP BY t1.nombre_peluqueria, t1.ano, t1.mes)

SELECT t2.nombre_peluqueria, t2.ano, t2.mes, t3.id_cliente, t3.nombre, t2.max_duracion_cita
FROM t2
JOIN (
	SELECT 
		pe.nombre_peluqueria, 
		EXTRACT(YEAR FROM ci.fecha_cita) AS ano, 
		EXTRACT(MONTH FROM ci.fecha_cita) AS mes,
		cl.nombre,
		cl.id_cliente,
		ci.duracion_cita
	FROM peluqueria pe
	JOIN cliente_peluqueria cp
	ON pe.id_peluqueria = cp.id_peluqueria
	JOIN cliente cl
	ON cl.id_cliente = cp.id_cliente
	JOIN cita ci
	ON cp.id_cliente_peluqueria = ci.id_cliente_peluqueria
	ORDER BY 
		pe.nombre_peluqueria, 
		EXTRACT(YEAR FROM ci.fecha_cita), 
		EXTRACT(MONTH FROM ci.fecha_cita)
) as t3
ON t2.nombre_peluqueria = t3.nombre_peluqueria
AND t2.ano = t3.ano
AND t2.mes = t3.mes
AND t2.max_duracion_cita = t3.duracion_cita;

-- FIN Pregunta 7 --

---------------------------------------------------------------------------------------------------------------------

-- INICIO Pregunta 8 --

-- 8. Identificar servicio más caro por peluquería

-- *Sobre el mismo cliente al cual se agregaron corte de cabello y barba en un mismo detalle y cita, se agregó el servicio tratamiento facial
-- este es el más caro y solo lo tendrá la peluquería que atendió a dicho cliente, de esta manera se comprueba de mejor manera que se muestra el 
-- servicio más caro por peluquería.

WITH t2 AS
	(SELECT t1.nombre_peluqueria, MAX(precio_servicio) as max_precio_servicio
	FROM
		(SELECT DISTINCT ON(pe.nombre_peluqueria, s.nombre_servicio)
			pe.nombre_peluqueria, s.nombre_servicio, s.precio_servicio
		FROM peluqueria pe
		JOIN cliente_peluqueria cp
		ON pe.id_peluqueria = cp.id_peluqueria
		JOIN cita ci
		ON cp.id_cliente_peluqueria = ci.id_cliente_peluqueria
		JOIN detalle d
		ON ci.id_cita = d.id_cita
		JOIN detalle_servicio ds
		ON ds.id_detalle = d.id_detalle
		JOIN servicio s
		ON s.id_servicio = ds.id_servicio) AS t1
	GROUP BY (t1.nombre_peluqueria))
	
SELECT DISTINCT ON(t2.nombre_peluqueria) 
	t2.nombre_peluqueria, t3.nombre_servicio, t2.max_precio_servicio
FROM t2
JOIN (
	SELECT DISTINCT ON(pe.nombre_peluqueria, s.nombre_servicio)
			pe.nombre_peluqueria, s.nombre_servicio, s.precio_servicio
	FROM peluqueria pe
	JOIN cliente_peluqueria cp
	ON pe.id_peluqueria = cp.id_peluqueria
	JOIN cita ci
	ON cp.id_cliente_peluqueria = ci.id_cliente_peluqueria
	JOIN detalle d
	ON ci.id_cita = d.id_cita
	JOIN detalle_servicio ds
	ON ds.id_detalle = d.id_detalle
	JOIN servicio s
	ON s.id_servicio = ds.id_servicio
) as t3
ON t2.nombre_peluqueria = t3.nombre_peluqueria
AND t2.max_precio_servicio = t3.precio_servicio;

-- FIN Pregunta 8 --

---------------------------------------------------------------------------------------------------------------------

-- INICIO Pregunta 9 --

-- 9.	Identificar al peluquero que ha trabajado más por mes durante el 2021

WITH t1 AS (
	SELECT t2.mes, MAX(t2.duracion_cita_mes) as max_duracion_cita_mes
	FROM
		(SELECT 
			p.id_peluquero, 
		 	e.nombre_empleado,
			EXTRACT(YEAR FROM ci.fecha_cita) as ano,
			EXTRACT(MONTH FROM ci.fecha_cita) as mes, 
			SUM(ci.duracion_cita) AS duracion_cita_mes
		FROM peluqueria pe
		JOIN cliente_peluqueria cp
		ON pe.id_peluqueria = cp.id_peluqueria
		JOIN cita ci
		ON cp.id_cliente_peluqueria = ci.id_cliente_peluqueria
		JOIN peluquero p
		ON p.id_peluquero = ci.id_peluquero
		JOIN empleado e
		 ON p.id_empleado = e.id_empleado
		GROUP BY
			p.id_peluquero,
		 	e.nombre_empleado,
			EXTRACT(MONTH FROM ci.fecha_cita),
			EXTRACT(YEAR FROM ci.fecha_cita) 
		HAVING EXTRACT(YEAR FROM ci.fecha_cita) = '2021'
		ORDER BY p.id_peluquero) AS t2
	GROUP BY t2.mes)

SELECT t1.mes, t2.id_peluquero, t2.nombre_empleado, t1.max_duracion_cita_mes
FROM t1
JOIN (
	(SELECT 
			p.id_peluquero, 
	 		e.nombre_empleado,
			EXTRACT(YEAR FROM ci.fecha_cita) as ano,
			EXTRACT(MONTH FROM ci.fecha_cita) as mes, 
			SUM(ci.duracion_cita) AS duracion_cita_mes
		FROM peluqueria pe
		JOIN cliente_peluqueria cp
		ON pe.id_peluqueria = cp.id_peluqueria
		JOIN cita ci
		ON cp.id_cliente_peluqueria = ci.id_cliente_peluqueria
		JOIN peluquero p
		ON p.id_peluquero = ci.id_peluquero
	 	JOIN empleado e
	 	ON p.id_empleado = e.id_empleado
		GROUP BY
			p.id_peluquero, 
	 		e.nombre_empleado,
			EXTRACT(MONTH FROM ci.fecha_cita),
			EXTRACT(YEAR FROM ci.fecha_cita) 
		HAVING EXTRACT(YEAR FROM ci.fecha_cita) = '2021'
		ORDER BY p.id_peluquero)
) as t2
ON t1.mes = t2.mes
AND t1.max_duracion_cita_mes = duracion_cita_mes
ORDER BY t1.mes;

-- FIN Pregunta 9 --

---------------------------------------------------------------------------------------------------------------------

-- INICIO Pregunta 10 --

-- 10.	Identificar lista de totales por comuna, cantidad de peluquerías, cantidad de clientes residentes en la comuna

WITH t1 as (
SELECT co.nombre_comuna, count(pe.id_peluqueria) AS num_peluquerias
FROM peluqueria pe
RIGHT JOIN comuna co
ON pe.id_comuna = co.id_comuna
GROUP BY co.nombre_comuna)

SELECT t1.nombre_comuna, t1.num_peluquerias, t2.num_clientes
FROM t1
JOIN (
SELECT co.nombre_comuna, count(cl.id_cliente) AS num_clientes
FROM cliente cl
RIGHT JOIN comuna co
ON cl.id_comuna = co.id_comuna
GROUP BY co.nombre_comuna
) as t2
ON t1.nombre_comuna = t2.nombre_comuna;

-- FIN Pregunta 10 --
