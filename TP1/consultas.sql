CREATE TABLE Testimonio(
id integer PRIMARY KEY,
texto char(15) not null,
hora time not null,
fecha date not null,
FOREIGN KEY (numeroPlacaPolicia) REFERENCES OficialDePolicia(numeroPlacaPolicia)
);

CREATE TABLE Evidencia(
id integer PRIMARY KEY,
fechaIngreso date not null,
descripcion char(128) not null,
fechaEncuentro date not null,
horaEncuentro time not null,
fechaSellado date not null,
horaSellado time not null,
FOREIGN KEY (idCaso) REFERENCES CasoCriminal(idCaso)
);

CREATE TABLE Custodia(
id integer PRIMARY KEY,
fecha date,
hora time,
comentario char(128),
FOREIGN KEY (idEvidencia) REFERENCES Evidencia(idEvidencia),
FOREIGN KEY (numeroPlacaPolicia) REFERENCES OficialDePolicia(numeroPlacaPolicia)
);

CREATE TABLE Direccion(
id integer PRIMARY KEY,
numero integer,
calle char(30)
);

CREATE TABLE CasoCriminal(
id integer PRIMARY KEY,
fechaIngreso date,
fecha date,
hora time,
lugar char(15),
descripcion char(128),
FOREIGN KEY (nombreCategoria) references Categoria(nombreCategoria)
);

CREATE TABLE Congelado(
id integer primary key references CasoCriminal(id),
fecha date,
comentario char(15)
);

CREATE TABLE Descartado(
id integer primary key references CasoCriminal(id),
fecha date,
motivo char(15)
);

CREATE TABLE Resulto(
id integer primary key references CasoCriminal(id),
fecha date,
descripcion char(15),
FOREIGN KEY (numeroPlacaPolicia) REFERENCES OficialDePolicia(numeroPlacaPolicia)
);

CREATE TABLE Pendiente(
pIdCaso integer,
pFecha date,
pComentario char(15)
);

CREATE TABLE Categoria(
nombre char(15) primary key
);

CREATE TABLE Rol(
nombre char(15) primary key
);

CREATE TABLE Persona(
dni integer primary key,
fechaNacimiento date,
nombre char(15),
foreign key (idDireccion) references Direccion(idDireccion)
);

CREATE TABLE Telefono(
dni integer primary key references Persona(dni),
numero integer
);

CREATE TABLE Evento(
id integer primary key,
descripcion char(128),
hora time,
fecha date,
foreign key (nombreRol) references Rol(nombreRol),
foreign key (idCaso) references CasoCriminal(idCaso),
foreign key (dni) references Persona(dni)
);

CREATE TABLE OficialDePolicia(
numeroDePlaca integer primary key,
fechaDeIngreso date,
foreign key (nombreDeRango) references Rango(nombreRango),
foreign key (nombreDeDepartamento) references Departamento(nombreDepartamento),
numeroDeEscritorio integer
);

CREATE TABLE Servicio(
nombre char(15) primary key
);

CREATE TABLE Departamento(
nombre char(15) primary key,
lineaTelefonica integer,
foreign key (nombreLocalidad) references Localidad(nombreLocalidad),
foreign key (nombreSupervisa) references Departamento(nombreSupervisa)
);

CREATE TABLE LineaTelefonica(
numero int primary key,
foreign key (nombreDepartamento) references Departamento(nombreDepartamento)
);

CREATE TABLE Localidad(
nombre char(15) primary key
);

CREATE TABLE Rango(
nombre char(15) primary key
);

CREATE TABLE Declara(
idTestimonio integer primary key references Testimonio(idTestimonio),
idCaso integer primary key references CasoCriminal(idCaso),
dni integer primary key references Persona(dni)
);

CREATE TABLE Tiene(
nombreRol char(15) primary key references Rol(nombreRol),
idCaso integer primary key references CasoCriminal(idCaso),
dni integer primary key references Persona(dni)
);

CREATE TABLE Culpable( 
idCaso integer primary key references CasoCriminal(idCaso),
dni integer primary key references Persona(dni)
);