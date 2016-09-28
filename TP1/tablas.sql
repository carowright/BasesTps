DROP TABLE IF EXISTS `Culpable`;
DROP TABLE IF EXISTS `Congelado`;
DROP TABLE IF EXISTS `Pendiente`;
DROP TABLE IF EXISTS `Resuelto`;
DROP TABLE IF EXISTS `Descartado`;
DROP TABLE IF EXISTS `Investiga`;
DROP TABLE IF EXISTS `Custodia`;
DROP TABLE IF EXISTS `Telefono`;
DROP TABLE IF EXISTS `Linea_Telefonica`;
DROP TABLE IF EXISTS `Testimonio`;
DROP TABLE IF EXISTS `Oficial_De_Policia`;
DROP TABLE IF EXISTS `Departamento`;
DROP TABLE IF EXISTS `Localidad`;
DROP TABLE IF EXISTS `Rango`;
DROP TABLE IF EXISTS `Evento`;
DROP TABLE IF EXISTS `Evidencia`;
DROP TABLE IF EXISTS `Involucra`;
DROP TABLE IF EXISTS `Rol`;
DROP TABLE IF EXISTS `Servicio`;
DROP TABLE IF EXISTS `Caso_Criminal`;
DROP TABLE IF EXISTS `Persona`;
DROP TABLE IF EXISTS `Domicilio`;
DROP TABLE IF EXISTS `Categoria`;



CREATE TABLE Domicilio(
  id integer primary key,
  numero integer not null,
  calle varchar(30) not null 
);

CREATE TABLE Persona(
  dni integer primary key,
  fecha_nacimiento date not null,
  nombre varchar(30) not null,
  apellido varchar(30) not null,
  domicilio_id integer not null,
  foreign key (domicilio_id) references Domicilio(id)
);

CREATE TABLE Telefono(
  numero integer primary key,
  persona_dni integer not null,
  tipo varchar(30) not null,
  foreign key (persona_dni) references Persona(dni)
);

CREATE TABLE Localidad(
  nombre varchar(30) primary key
);

CREATE TABLE Departamento(
  nombre varchar(30) primary key,
  nombre_localidad varchar(30) not null,
  supervisado_por_departamento varchar(30),
  foreign key (nombre_localidad) references Localidad(nombre),
  foreign key (supervisado_por_departamento) references Departamento(nombre)
);

CREATE TABLE Linea_Telefonica(
  numero int,
  nombre_departamento varchar(30),
  PRIMARY KEY (numero, nombre_departamento),
  foreign key (nombre_departamento) references Departamento(nombre)
);

CREATE TABLE Rango(
  nombre varchar(30) primary key
);

CREATE TABLE Servicio(
  nombre varchar(30) primary key
);

CREATE TABLE Oficial_De_Policia(
  persona_dni integer not null,
  numero_de_placa integer primary key,
  fecha_de_ingreso date not null,
  numero_de_escritorio integer not null,
  nombre_rango varchar(30) not null,
  nombre_departamento varchar(30) not null,
  foreign key (persona_dni) references Persona(dni),
  foreign key (nombre_rango) references Rango(nombre),
  foreign key (nombre_departamento) references Departamento(nombre)
);

CREATE TABLE Categoria(
  nombre varchar(30) primary key
);

CREATE TABLE Rol(
  nombre varchar(30) primary key
);

CREATE TABLE Caso_Criminal(
  id integer primary key,
  fecha_ingreso date not null,
  fecha datetime not null,
  lugar varchar(30) not null,
  descripcion varchar(255) not null,
  nombre_categoria varchar(30) not null,
  estado varchar(30) not null,
  foreign key (nombre_categoria) references Categoria(nombre)
);

CREATE TABLE Involucra(
  caso_id integer,
  persona_dni integer,
  nombre_rol varchar(30) not null,

  PRIMARY KEY (caso_id, persona_dni),
  foreign key (caso_id)     references Caso_Criminal(id),
  foreign key (persona_dni) references Persona(dni),
  foreign key (nombre_rol)  references Rol(nombre)
);

CREATE TABLE Evento(
  id integer primary key,
  caso_id integer,
  persona_dni integer,
  descripcion varchar(255) not null,
  fecha datetime not null,

  FOREIGN KEY (caso_id, persona_dni) REFERENCES Participa (caso_id, persona_dni)
);

CREATE TABLE Evidencia(
  id integer PRIMARY KEY,
  fecha_ingreso date not null,
  descripcion char(128) not null,
  fecha_encuentro datetime not null,
  fecha_sellado datetime not null,
  caso_id integer not null,
  FOREIGN KEY (caso_id) REFERENCES Caso_Criminal(id)
);

CREATE TABLE Testimonio(
  id integer PRIMARY KEY,
  caso_id integer,
  persona_dni integer,
  texto varchar(255) not null,
  fecha datetime not null,
  nro_placa_policia_a_cargo integer not null,
  FOREIGN KEY (caso_id, persona_dni) REFERENCES Participa (caso_id, persona_dni),
  FOREIGN KEY (nro_placa_policia_a_cargo) REFERENCES Oficial_De_Policia(numero_de_placa)
);

CREATE TABLE Custodia(
  id integer PRIMARY KEY,
  fecha datetime not null,
  comentario varchar(255) not null,
  evidencia_id integer not null,
  nro_placa_policia_a_cargo integer not null,
  FOREIGN KEY (evidencia_id) REFERENCES Evidencia(id),
  FOREIGN KEY (nro_placa_policia_a_cargo) REFERENCES Oficial_De_Policia(numero_de_placa)
);

CREATE TABLE Congelado(
  caso_id integer primary key,
  fecha date not null,
  comentario varchar(255) not null,
  FOREIGN KEY (caso_id) references Caso_Criminal(id)
);

CREATE TABLE Descartado(
  caso_id integer primary key,
  fecha date not null,
  motivo varchar(255) not null,
  FOREIGN KEY (caso_id) references Caso_Criminal(id)
);

CREATE TABLE Resuelto(
  caso_id integer primary key,
  fecha date not null,
  descripcion varchar(255) not null,
  nro_placa_policia_cerro integer not null,
  FOREIGN KEY (caso_id) references Caso_Criminal(id),
  FOREIGN KEY (nro_placa_policia_cerro) REFERENCES Oficial_De_Policia(numero_de_placa)
);

CREATE TABLE Pendiente(
  caso_id integer primary key,
  FOREIGN KEY (caso_id) references Caso_Criminal(id)
);

CREATE TABLE Culpable(
  caso_id integer,
  persona_dni integer,

  PRIMARY KEY (caso_id, persona_dni),
  foreign key (caso_id)     references Resuelto(caso_id),
  foreign key (persona_dni) references Persona(dni)
);

CREATE TABLE Investiga(
  caso_id integer not null,
  nro_placa_policia integer not null,
  es_investigador_principal boolean not null,
  FOREIGN KEY (caso_id) REFERENCES Caso_Criminal(id),
  FOREIGN KEY (nro_placa_policia) REFERENCES Oficial_De_Policia(numero_de_placa)
);