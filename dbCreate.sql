-- Eliminar si ya existe
DROP DATABASE IF EXISTS bdd_peluqueria;

-- Crear la base de datos
CREATE DATABASE bdd_peluqueria;

\c bdd_peluqueria;

-- Crear la tabla Comuna
CREATE TABLE Comuna (
  id_comuna int PRIMARY KEY,
  nombre_comuna varchar(255)
);

-- Crear la tabla Cliente
CREATE TABLE Cliente (
  id_cliente int PRIMARY KEY,
  id_comuna int,
  nombre varchar(255),
  sexo char,
  FOREIGN KEY (id_comuna) REFERENCES Comuna(id_comuna)
);

-- Crear la tabla Peluqueria
CREATE TABLE Peluqueria (
  id_peluqueria int PRIMARY KEY,
  id_comuna int,
  nombre_peluqueria varchar(255),
  FOREIGN KEY (id_comuna) REFERENCES Comuna(id_comuna)
);

-- Crear la tabla Cliente_peluqueria
CREATE TABLE Cliente_peluqueria (
  id_cliente_peluqueria int PRIMARY KEY,
  id_cliente int,
  id_peluqueria int,
  FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
  FOREIGN KEY (id_peluqueria) REFERENCES Peluqueria(id_peluqueria)
);


-- Crear la tabla Sueldo
CREATE TABLE Sueldo (
  id_sueldo int PRIMARY KEY,
  sueldo int
);


-- Crear la tabla Empleado
CREATE TABLE Empleado (
  id_empleado int PRIMARY KEY,
  id_comuna int,
  id_peluqueria int,
  id_sueldo int,
  nombre_empleado varchar(255),
  FOREIGN KEY (id_comuna) REFERENCES Comuna(id_comuna),
  FOREIGN KEY (id_peluqueria) REFERENCES Peluqueria(id_peluqueria),
  FOREIGN KEY (id_sueldo) REFERENCES Sueldo(id_sueldo)
);


-- Crear la tabla Pago 
CREATE TABLE Pago(
    id_pago int PRIMARY KEY,
    medio_de_pago varchar(255)
);




-- Crear la tabla Horario
CREATE TABLE Horario (
  id_horario int PRIMARY KEY,
  hora_inicio time
);

-- Crear la tabla Peluquero
CREATE TABLE Peluquero (
  id_peluquero int PRIMARY KEY,
  id_empleado int,
  FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado)
);
  

-- Crear la tabla Cita
CREATE TABLE Cita (
  id_cita int PRIMARY KEY,
  id_cliente_peluqueria int,
  id_horario int,
  id_peluquero int,
  duracion_cita interval,
  fecha_cita date,
  FOREIGN KEY (id_cliente_peluqueria) REFERENCES Cliente_peluqueria(id_cliente_peluqueria),
  FOREIGN KEY (id_horario) REFERENCES Horario(id_horario),
  FOREIGN KEY (id_peluquero) REFERENCES Peluquero(id_peluquero),
  CONSTRAINT unique_cliente_fecha UNIQUE (id_cliente_peluqueria, fecha_cita),
  CONSTRAINT unique_peluquero UNIQUE (id_peluquero, fecha_cita, id_horario)
);


-- Crear la tabla Detalle
CREATE TABLE Detalle (
  id_detalle int PRIMARY KEY,
  id_cita int,
  id_pago int,
  precio_detalle int,
  FOREIGN KEY (id_cita) REFERENCES Cita(id_cita),
  FOREIGN KEY (id_pago) REFERENCES Pago(id_pago)
);


-- Crear la tabla Producto
CREATE TABLE Producto (
  id_producto int PRIMARY KEY,
  nombre_producto varchar(255),
  precio_producto int
);


-- Crear la tabla Servicio
CREATE TABLE Servicio (
  id_servicio int PRIMARY KEY,
  nombre_servicio varchar(255),
  precio_servicio int
);


-- Crear la tabla intermedia entre detalle y producto
CREATE TABLE Detalle_producto (
  id_detalle_producto int PRIMARY KEY,
  id_detalle int,
  id_producto int,
  FOREIGN KEY (id_detalle) REFERENCES Detalle(id_detalle),
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);


-- Crear la tabla intermedia entre detalle y servicio
CREATE TABLE Detalle_servicio (
  id_detalle_servicio int PRIMARY KEY,
  id_detalle int,
  id_servicio int,
  FOREIGN KEY (id_detalle) REFERENCES Detalle(id_detalle),
  FOREIGN KEY (id_servicio) REFERENCES Servicio(id_servicio)
);

