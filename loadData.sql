INSERT INTO Comuna (id_comuna, nombre_comuna)
VALUES 
(1, 'Cerrillos'),
(2, 'Cerro Navia'),
(3, 'Conchalí'),
(4, 'El Bosque'),
(5, 'Estación Central'),
(6, 'Huechuraba'),
(7, 'Independencia'),
(8, 'La Cisterna'),
(9, 'La Florida'),
(10, 'La Granja'),
(11, 'La Pintana'),
(12, 'La Reina'),
(13, 'Las Condes'),
(14, 'Lo Barnechea'),
(15, 'Lo Espejo'),
(16, 'Lo Prado'),
(17, 'Macul'),
(18, 'Maipú'),
(19, 'Ñuñoa'),
(20, 'Pedro Aguirre Cerda'),
(21, 'Peñalolén'),
(22, 'Providencia'),
(23, 'Pudahuel'),
(24, 'Quilicura'),
(25, 'Quinta Normal'),
(26, 'Recoleta'),
(27, 'Renca'),
(28, 'San Joaquín'),
(29, 'San Miguel'),
(30, 'San Ramón'),
(31, 'Santiago'),
(32, 'Vitacura');

INSERT INTO cliente (id_cliente, id_comuna, nombre, sexo)
VALUES
(1, 1, 'Juan Carvacho', 'M'),
(2, 1, 'María Castro', 'F'),
(3, 2, 'Pedro Roble', 'M'),
(4, 2, 'Ana Fernandez', 'F'),
(5, 3, 'Luis Rojas', 'M'),
(6, 3, 'Fernanda Castillo', 'F'),
(7, 4, 'Pablo Romero', 'M'),
(8, 4, 'Carla Jara', 'F'),
(9, 5, 'Diego Claro', 'M'),
(10, 5, 'Paulina Rodriguez', 'F'),
(11, 6, 'Roberto Lopez', 'M'),
(12, 6, 'Sofía Torres', 'F'),
(13, 7, 'Jorge Medina', 'M'),
(14, 7, 'Valentina Diaz', 'F'),
(15, 8, 'Miguel Torres', 'M'),
(16, 8, 'Isabel Lopez', 'F'),
(17, 9, 'Mario Rodriguez', 'M'),
(18, 9, 'Natalia Garcia', 'F'),
(19, 10, 'Andrés Aguirre', 'M'),
(20, 10, 'Paola Ramirez', 'F'),
(21, 11, 'Gabriel Gomez', 'M'),
(22, 11, 'Renata Benitez', 'F'),
(23, 12, 'Maximiliano Suarez', 'M'),
(24, 12, 'Marcela Suarez', 'F'),
(25, 13, 'Fabián Garcia', 'M'),
(26, 13, 'Antonia Ruiz', 'F'),
(27, 14, 'Alex Ramos', 'M'),
(28, 14, 'Bárbara Gimenez', 'F'),
(29, 15, 'José Gonzalez', 'M'),
(30, 15, 'Camila Herrera', 'F');


INSERT INTO Peluqueria(id_peluqueria, id_comuna, nombre_peluqueria, bono_cita) 
VALUES 
(1, 1, 'Peluqueria 1', 10000),
(2, 2, 'Peluqueria 2', 15000),
(3, 3, 'Peluqueria 3', 23000);


INSERT INTO Cliente_peluqueria(id_cliente_peluqueria, id_cliente, id_peluqueria) 
VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 1),
(7, 7, 1),
(8, 8, 1),
(9, 9, 1),
(10, 10, 1),
(11, 11, 1),
(12, 12, 1),
(13, 13, 1),
(14, 14, 1),
(15, 15, 1),
(16, 16, 2),
(17, 17, 2),
(18, 18, 2),
(19, 19, 2),
(20, 20, 2),
(21, 21, 2),
(22, 22, 2),
(23, 23, 2),
(24, 24, 2),
(25, 25, 2),
(26, 26, 2),
(27, 27, 2),
(28, 28, 2),
(29, 29, 2),
(30, 30, 2),
(31, 15, 3),
(32, 16, 3),
(33, 17, 3),
(34, 18, 3),
(35, 19, 3),
(36, 20, 3),
(37, 21, 3),
(38, 22, 3),
(39, 23, 3),
(40, 24, 3),
(41, 25, 3),
(42, 26, 3),
(43, 27, 3),
(44, 28, 3),
(45, 29, 3);


INSERT INTO Sueldo(id_sueldo, sueldo) 
VALUES
(1, 400000),
(2, 800000),
(3, 1200000);

INSERT INTO Empleado(id_empleado, id_comuna, id_peluqueria, id_sueldo, nombre_empleado)
VALUES
  (1, 7, 1, 1, 'Juan Perez'),
  (2, 18, 1, 2, 'Ana García'),
  (3, 26, 1, 3, 'Pedro Ramirez'),
  (4, 8, 1, 3, 'María Fernández'),
  (5, 15, 1, 2, 'Luisa Rodríguez'),
  (6, 32, 1, 1, 'Carlos Gomez'),
  (7, 24, 1, 1, 'Laura Diaz'),
  (8, 11, 1, 2, 'Pablo Martinez'),
  (9, 30, 1, 3, 'Marta Gonzalez'),
  (10, 13, 1, 3, 'Mario Herrera'),
  (11, 5, 2, 2, 'Fabiola Aguilar'),
  (12, 22, 2, 1, 'Javier Vega'),
  (13, 4, 2, 1, 'Sofía González'),
  (14, 23, 2, 2, 'Ricardo Sánchez'),
  (15, 28, 2, 3, 'Isabel Ramirez'),
  (16, 9, 2, 3, 'Alejandro Torres'),
  (17, 1, 2, 2, 'Carmen Fernandez'),
  (18, 14, 2, 1, 'Diego Rojas'),
  (19, 31, 2, 1, 'Adriana Rodriguez'),
  (20, 25, 2, 2, 'Andres Gómez'),
  (21, 2, 3, 3, 'Estefania Castro'),
  (22, 21, 3, 3, 'Francisco Ortega'),
  (23, 27, 3, 2, 'Silvia Vargas'),
  (24, 16, 3, 1, 'Roberto Molina'),
  (25, 19, 3, 1, 'Paula Medina'),
  (26, 12, 3, 2, 'Cristóbal Castro'),
  (27, 29, 3, 3, 'Valentina Herrera'),
  (28, 6, 3, 3, 'Julio Aguilar'),
  (29, 17, 3, 2, 'Camila Rojas'),
  (30, 10, 3, 1, 'Emilio González');


INSERT INTO Peluquero(id_peluquero, id_empleado)
VALUES
 (1, 1),
 (2, 2),
 (3, 3),
 (4, 4),
 (5, 5),
 (6, 6),
 (7, 7),
 (8, 8),
 (9, 9),
 (10, 10),
 (11, 11),
 (12, 12),
 (13, 13),
 (14, 14),
 (15, 15),
 (16, 16),
 (17, 17),
 (18, 18),
 (19, 19),
 (20, 20),
 (21, 21),
 (22, 22),
 (23, 23),
 (24, 24),
 (25, 25),
 (26, 26),
 (27, 27),
 (28, 28),
 (29, 29),
 (30, 30);


INSERT INTO Pago(id_pago, medio_de_pago)
VALUES
(1, 'Debito'),
(2, 'Credito'),
(3, 'Efectivo');


INSERT INTO Horario(id_horario, hora_inicio)
VALUES
(1, '10:00:00'),
(2, '11:00:00'),
(3, '12:00:00'),
(4, '13:30:00'),
(5, '14:00:00'),
(6, '15:30:00'),
(7, '16:00:00'),
(8, '17:30:00'),
(9, '18:00:00'),
(10, '19:00:00');


-- Crear la secuencia para id_cita
CREATE SEQUENCE cita_id_seq START WITH 1;

INSERT INTO Cita (id_cita, id_cliente_peluqueria, id_horario, id_peluquero, duracion_cita, fecha_cita)
SELECT
  nextval('cita_id_seq'), -- Generar el próximo valor de la secuencia para id_cita
  FLOOR(RANDOM() * 15 + 1),
  FLOOR(RANDOM() * 10 + 1),
  FLOOR(RANDOM() * 10 + 1),
  FLOOR(RANDOM() * (120 - 30 + 1) + 30) * INTERVAL '1 MINUTE' AS duracion_cita,
  TIMESTAMP '2018-01-01' + (RANDOM() * (DATE '2023-02-28' - DATE '2018-01-01' + 1)) * INTERVAL '1 DAY' AS fecha_cita
FROM
  generate_series(1, 1000) as citas
ON CONFLICT DO NOTHING;


INSERT INTO Cita (id_cita, id_cliente_peluqueria, id_horario, id_peluquero, duracion_cita, fecha_cita)
SELECT
  nextval('cita_id_seq'), -- Generar el próximo valor de la secuencia para id_cita
  FLOOR(RANDOM() * 15 + 16),
  FLOOR(RANDOM() * 10 + 1),
  FLOOR(RANDOM() * 10 + 11),
  FLOOR(RANDOM() * (120 - 30 + 1) + 30) * INTERVAL '1 MINUTE' AS duracion_cita,
  TIMESTAMP '2018-01-01' + (RANDOM() * (DATE '2023-12-31' - DATE '2018-01-01' + 1)) * INTERVAL '1 DAY' AS fecha_cita
FROM
  generate_series(1, 1000) as citas
ON CONFLICT DO NOTHING;

INSERT INTO Cita (id_cita, id_cliente_peluqueria, id_horario, id_peluquero, duracion_cita, fecha_cita)
SELECT
  nextval('cita_id_seq'), -- Generar el próximo valor de la secuencia para id_cita
  FLOOR(RANDOM() * 15 + 31),
  FLOOR(RANDOM() * 10 + 1),
  FLOOR(RANDOM() * 10 + 21),
  FLOOR(RANDOM() * (120 - 30 + 1) + 30) * INTERVAL '1 MINUTE' AS duracion_cita,
  TIMESTAMP '2018-01-01' + (RANDOM() * (DATE '2023-12-31' - DATE '2018-01-01' + 1)) * INTERVAL '1 DAY' AS fecha_cita
FROM
  generate_series(1, 1000) as citas
ON CONFLICT DO NOTHING;

INSERT INTO Cita (id_cita, id_cliente_peluqueria, id_horario, id_peluquero, duracion_cita, fecha_cita)
VALUES(
  3001,
  1,
  1,
  1,
  '60 minutes',
  '2023-04-03'
);

-- Crear la secuencia para id_detalle
CREATE SEQUENCE detalle_id_seq START WITH 1;

INSERT INTO Detalle(id_detalle, id_cita, id_pago, precio_detalle)
SELECT
  nextval('detalle_id_seq')-- Generar el próximo valor de la secuencia para id_cita
  id_detalle,
  c.id_cita,
  (FLOOR(RANDOM() * 3) + 1) AS id_pago,
  0
FROM cita c;

INSERT INTO Detalle(id_detalle, id_cita, id_pago, precio_detalle)
VALUES
(
  3001,
  3001,
  1,
  0
);


INSERT INTO Producto(id_producto, nombre_producto, precio_producto)
VALUES
(1, 'Shampoo', 5000),
(2, 'Acondicionador', 5000),
(3, 'Crema para peinar', 10000),
(4, 'Gel para el cabello', 10000);


INSERT INTO Servicio(id_servicio, nombre_servicio, precio_servicio)
VALUES
(1, 'Lavado de cabello', 5000),
(2, 'Corte de barba', 5000),
(3, 'Corte de cabello', 10000),
(4, 'Tinte de cabello', 10000),
(5, 'Tratamiento facial', 12000);

-- Crear la secuencia para detalle_producto
CREATE SEQUENCE detalle_producto_id_seq START WITH 1;

INSERT INTO Detalle_producto(id_detalle_producto, id_detalle, id_producto)
SELECT 
  nextval('detalle_producto_id_seq')-- Generar el próximo valor de la secuencia para id_cita
  id_detalle_producto,
  id_detalle,
  (FLOOR(RANDOM() * 4) + 1) AS id_producto
FROM detalle;

-- Crear la secuencia para detalle_servicio
CREATE SEQUENCE detalle_servicio_id_seq START WITH 1;
INSERT INTO Detalle_servicio(id_detalle_servicio, id_detalle, id_servicio)
SELECT 
  nextval('detalle_servicio_id_seq')-- Generar el próximo valor de la secuencia para id_cita
  id_detalle_servicio,
  id_detalle,
  (FLOOR(RANDOM() * 4) + 1) AS id_servicio
FROM detalle;

INSERT INTO Detalle_servicio(id_detalle_servicio, id_detalle, id_servicio)
VALUES
(
  nextval('detalle_servicio_id_seq'),
  3001,
  3
);

INSERT INTO Detalle_servicio(id_detalle_servicio, id_detalle, id_servicio)
VALUES
(
  nextval('detalle_servicio_id_seq'),
  3001,
  2
);

INSERT INTO Detalle_servicio(id_detalle_servicio, id_detalle, id_servicio)
VALUES
(
  nextval('detalle_servicio_id_seq'),
  3001,
  2
);

INSERT INTO Detalle_servicio(id_detalle_servicio, id_detalle, id_servicio)
VALUES
(
  nextval('detalle_servicio_id_seq'),
  3001,
  5
);

UPDATE detalle d
SET precio_detalle = d.precio_detalle + p.precio_producto
FROM detalle_producto dp
INNER JOIN producto p ON dp.id_producto = p.id_producto
WHERE dp.id_detalle = d.id_detalle;

UPDATE detalle d
SET precio_detalle = d.precio_detalle + s.precio_servicio
FROM detalle_servicio ds
INNER JOIN servicio s ON ds.id_servicio = s.id_servicio
WHERE ds.id_detalle = d.id_detalle;

DELETE FROM Detalle_servicio
WHERE id_detalle IN (
    SELECT id_detalle
    FROM Detalle
    WHERE id_cita IN (
        SELECT id_cita
        FROM Cita
        WHERE id_cliente_peluqueria = 1
    )
) AND id_servicio = 4;
