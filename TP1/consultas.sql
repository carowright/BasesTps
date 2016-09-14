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
fecha date not null,
hora time not null,
comentario char(128) not null,
FOREIGN KEY (idEvidencia) REFERENCES Evidencia(idEvidencia),
FOREIGN KEY (numeroPlacaPolicia) REFERENCES OficialDePolicia(numeroPlacaPolicia)
);

CREATE TABLE Direccion(
id integer primary key,
numero integer not null,
calle char(30) not null 
);

CREATE TABLE CasoCriminal(
id integer primary key,
fechaIngreso date not null,
fecha date not null,
hora time not null,
lugar char(15) not null,
descripcion char(128) not null,
foreign key (nombreCategoria) references Categoria(nombreCategoria)
);

CREATE TABLE Congelado(
id integer primary key references CasoCriminal(id),
fecha date not null,
comentario char(15) not null
);

CREATE TABLE Descartado(
idCaso integer primary key references CasoCriminal(idCaso),
fecha date not null,
motivo char(15)
);

CREATE TABLE Resulto(
idCaso integer primary key references CasoCriminal(idCaso),
fecha date not null,
descripcion char(15),
FOREIGN KEY (numeroPlacaPolicia) REFERENCES OficialDePolicia(numeroPlacaPolicia)
);

CREATE TABLE Pendiente(
idCaso integer primary key references CasoCriminal(idCaso),
fecha date not null,
comentario char(15)
);

CREATE TABLE Categoria(
nombre char(15) primary key
);

CREATE TABLE Rol(
nombre char(15) primary key
);

CREATE TABLE Persona(
dni integer primary key,
fechaNacimiento date not null,
nombre char(15) not null,
apellido char(15) not null,
foreign key (idDireccion) references Direccion(idDireccion)
);

CREATE TABLE Telefono(
numero integer primary key,
foreign key (dni) references Persona(dni)
);

CREATE TABLE Evento(
id integer primary key,
descripcion char(128) not null,
hora time not null,
fecha date not null,
foreign key (nombreRol) references Rol(nombreRol),
foreign key (idCaso) references CasoCriminal(idCaso),
foreign key (dni) references Persona(dni)
);

CREATE TABLE OficialDePolicia(
numeroDePlaca integer primary key,
fechaDeIngreso date not null,
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
nombreDepartamento char(15) primary key references Departamento(nombreDepartamento)
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
