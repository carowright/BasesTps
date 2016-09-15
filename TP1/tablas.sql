DROP TABLE IF EXISTS `Investiga`;
DROP TABLE IF EXISTS `Custodias`;
DROP TABLE IF EXISTS `Telefonos`;
DROP TABLE IF EXISTS `Lineas_Telefonicas`;
DROP TABLE IF EXISTS `Testimonios`;
DROP TABLE IF EXISTS `Oficiales_De_Policia`;
DROP TABLE IF EXISTS `Departamentos`;
DROP TABLE IF EXISTS `Localidades`;
DROP TABLE IF EXISTS `Rangos`;
DROP TABLE IF EXISTS `Eventos`;
DROP TABLE IF EXISTS `Evidencias`;
DROP TABLE IF EXISTS `Caso_Criminal_Personas`;
DROP TABLE IF EXISTS `Roles`;
DROP TABLE IF EXISTS `Servicios`;
DROP TABLE IF EXISTS `Casos_Criminales`;
DROP TABLE IF EXISTS `Personas`;
DROP TABLE IF EXISTS `Direcciones`;
DROP TABLE IF EXISTS `Categorias`;



CREATE TABLE Direcciones(
  id integer primary key,
  numero integer not null,
  calle varchar(30) not null 
);

CREATE TABLE Personas(
  dni integer primary key,
  fecha_nacimiento date not null,
  nombre varchar(30) not null,
  apellido varchar(30) not null,
  direccion_id integer not null,
  foreign key (direccion_id) references Direcciones(id)
);

CREATE TABLE Telefonos(
  numero integer primary key,
  persona_dni integer not null,
  tipo varchar(30) not null,
  foreign key (persona_dni) references Personas(dni)
);

CREATE TABLE Localidades(
  nombre varchar(30) primary key
);

CREATE TABLE Departamentos(
  nombre varchar(30) primary key,
  nombre_localidad varchar(30) not null,
  supervisado_por_departamento varchar(30),
  foreign key (nombre_localidad) references Localidades(nombre),
  foreign key (supervisado_por_departamento) references Departamentos(nombre)
);

CREATE TABLE Lineas_Telefonicas(
  numero int,
  nombre_departamento varchar(30),
  PRIMARY KEY (numero, nombre_departamento),
  foreign key (nombre_departamento) references Departamentos(nombre)
);

CREATE TABLE Rangos(
  nombre varchar(30) primary key
);

CREATE TABLE Servicios(
  nombre varchar(30) primary key
);

CREATE TABLE Oficiales_De_Policia(
  persona_dni integer not null,
  numero_de_placa integer primary key,
  fecha_de_ingreso date not null,
  numero_de_escritorio integer not null,
  nombre_rango varchar(30) not null,
  nombre_departamento varchar(30) not null,
  foreign key (persona_dni) references Personas(dni),
  foreign key (nombre_rango) references Rangos(nombre),
  foreign key (nombre_departamento) references Departamentos(nombre)
);


CREATE TABLE Categorias(
  nombre varchar(30) primary key
);

CREATE TABLE Roles(
  nombre varchar(30) primary key
);

CREATE TABLE Casos_Criminales(
  id integer primary key,
  fecha_ingreso date not null,
  fecha datetime not null,
  lugar varchar(30) not null,
  descripcion varchar(255) not null,
  nombre_categoria varchar(30) not null,
  foreign key (nombre_categoria) references Categorias(nombre)
);


CREATE TABLE Caso_Criminal_Personas(
  caso_id integer,
  persona_dni integer,
  nombre_rol varchar(30) not null,

  PRIMARY KEY (caso_id, persona_dni),
  foreign key (caso_id)     references Casos_Criminales(id),
  foreign key (persona_dni) references Personas(dni),
  foreign key (nombre_rol)  references Roles(nombre)
);

CREATE TABLE Eventos(
  id integer primary key,
  caso_id integer,
  persona_dni integer,
  descripcion varchar(255) not null,
  fecha datetime not null,

  FOREIGN KEY (caso_id, persona_dni) REFERENCES Caso_Criminal_Personas (caso_id, persona_dni)
);


CREATE TABLE Evidencias(
  id integer PRIMARY KEY,
  fecha_ingreso date not null,
  descripcion char(128) not null,
  fecha_encuentro datetime not null,
  fecha_sellado datetime not null,
  caso_id integer not null,
  FOREIGN KEY (caso_id) REFERENCES Casos_Criminales(id)
);

CREATE TABLE Testimonios(
  id integer PRIMARY KEY,
  caso_id integer,
  persona_dni integer,
  texto varchar(255) not null,
  fecha datetime not null,
  nro_placa_policia_a_cargo integer not null,
  FOREIGN KEY (caso_id, persona_dni) REFERENCES Caso_Criminal_Personas (caso_id, persona_dni),
  FOREIGN KEY (nro_placa_policia_a_cargo) REFERENCES Oficiales_De_Policia(numero_de_placa)
);

CREATE TABLE Custodias(
  id integer PRIMARY KEY,
  fecha datetime not null,
  comentario varchar(255) not null,
  evidencia_id integer not null,
  nro_placa_policia_a_cargo integer not null,
  FOREIGN KEY (evidencia_id) REFERENCES Evidencias(id),
  FOREIGN KEY (nro_placa_policia_a_cargo) REFERENCES Oficiales_De_Policia(numero_de_placa)
);

CREATE TABLE Investiga(
  caso_id integer not null,
  nro_placa_policia integer not null,
  es_investigador_principal boolean not null,
  FOREIGN KEY (caso_id) REFERENCES Casos_Criminales(id),
  FOREIGN KEY (nro_placa_policia) REFERENCES Oficiales_De_Policia(numero_de_placa)
);