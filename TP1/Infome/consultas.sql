CREATE TABLE testimonios(
tId integer,
tTexto char(15),
tHora time,
tFecha date,
tNumPlacaPolicia integer
);

ALTER TABLE testimonios ADD CONSTRAINT pktestimonios PRIMARY KEY( tid )

ALTER TABLE testimonios ADD CONSTRAINT fktestimonios FOREIGN KEY(
tNumPlacaPolicia ) REFERENCES oficialesdepolicia ( oNumeroDePlaca )

CREATE TABLE evidencias(
eId integer,
eFechaIngreso date,
eDescripcion char(15),
eFechaEncuentro date,
eHoraEncuentro time,
eFechaSellado date,
eHoraSellado time,
eIdCaso integer
);

ALTER TABLE evidencias ADD CONSTRAINT pkevidencias PRIMARY KEY( eId )

ALTER TABLE evidencias ADD CONSTRAINT fkevidencias FOREIGN KEY(
eIdCaso ) REFERENCES casosCriminales ( cIdCaso )

CREATE TABLE custodias(
cIdCustodia integer,
cFecha date,
cHora time,
cComentario char(15),
cIdEvidencia integer,
cNumPlacaPolicia integer

);

ALTER TABLE custodias ADD CONSTRAINT pkcustodias PRIMARY KEY( eId )

ALTER TABLE custodias ADD CONSTRAINT fk1custodias FOREIGN KEY(
cIdEvidencia ) REFERENCES evidencias ( eId )

ALTER TABLE custodias ADD CONSTRAINT fk2custodias FOREIGN KEY(
cNumPlacaPolicia ) REFERENCES oficialesdepolicia ( oNumeroDePlaca )

CREATE TABLE direcciones(
dIdDireccion integer,
dNumero integer,
dCalle char(15)
);

ALTER TABLE direcciones ADD CONSTRAINT pkdirecciones PRIMARY KEY( dIdDireccion )

CREATE TABLE casoscriminales(
cIdCaso integer,
cFechaIngreso date,
cFecha date,
cHora time,
cLugar char(15),
cDescripcion char(15),
cNombreCategoria char(15)
);

ALTER TABLE casoscriminales ADD CONSTRAINT pkcasoscriminales PRIMARY KEY( cIdCaso )

ALTER TABLE casoscriminales ADD CONSTRAINT fkcasoscriminales FOREIGN KEY(
cNombreCategoria ) REFERENCES categorias ( cNombre )

###########################
CREATE TABLE congelados(
cIdCaso integer,
cFecha date,
cComentario char(15)
);

ALTER TABLE congelados ADD CONSTRAINT pkcongelados PRIMARY KEY( cIdCaso )

CREATE TABLE descartados(
dIdCaso integer,
dFecha date,
dMotivo char(15)
);

ALTER TABLE descartados ADD CONSTRAINT pkdescartados PRIMARY KEY( cIdCaso )

CREATE TABLE resueltos(
rIdCaso integer,
rFecha date,
rDescripcion char(15),
rNumeroPlacaPolicia integer
);

ALTER TABLE resueltos ADD CONSTRAINT pkresueltos PRIMARY KEY( cIdCaso )

CREATE TABLE pendientes(
pIdCaso integer,
pFecha date,
pComentario char(15)
);

ALTER TABLE pendientes ADD CONSTRAINT pkpendientes PRIMARY KEY( cIdCaso )

CREATE TABLE categorias(
cNombre char(15)
);

ALTER TABLE categorias ADD CONSTRAINT pkcategorias PRIMARY KEY( cNombre )

CREATE TABLE roles(
rNombre char(15)
);

ALTER TABLE roles ADD CONSTRAINT roles PRIMARY KEY( cNombre )

CREATE TABLE personas(
pDni integer,
pFechaNacimiento date,
pNombre char(15),
pIdDireccion integer,
);

ALTER TABLE personas ADD CONSTRAINT pkpersonas PRIMARY KEY( pDni )

############# DUDA #######

CREATE TABLE telefonos(
tDni integer,
tNumero integer
);

ALTER TABLE telefonos ADD CONSTRAINT pk1telefonos PRIMARY KEY( tDni )
ALTER TABLE telefonos ADD CONSTRAINT pk2telefonos PRIMARY KEY( tNumero )

ALTER TABLE telefonos ADD CONSTRAINT fktelefonos FOREIGN KEY(
tDni ) REFERENCES personas ( pDni )


############# DUDA #######

CREATE TABLE eventos(
eIdEvento integer,
eDescripcion date,
eHora time,
eFecha date,
eNombreRol char(15),
eIdCaso integer,
eDni integer,

);

ALTER TABLE eventos ADD CONSTRAINT pkeventos PRIMARY KEY( eIdEvento )

ALTER TABLE eventos ADD CONSTRAINT fkeventos FOREIGN KEY(
eNombreRol ) REFERENCES roles ( rNombre )

ALTER TABLE eventos ADD CONSTRAINT fkeventos FOREIGN KEY(
eIdCaso ) REFERENCES casoscriminales ( cIdCaso )

ALTER TABLE eventos ADD CONSTRAINT fkeventos FOREIGN KEY(
eDni ) REFERENCES personas ( pDni )


#########


CREATE TABLE oficialesdepolicia(
oNumeroDePlaca integer,
oFechaDeIngreso date,
oNombreDeRango char(15),
oNombreDeDepartamento char(15),
oNumeroDeEscritorio integer,

);

ALTER TABLE oficialesdepolicia ADD CONSTRAINT pkoficialesdepolicia PRIMARY KEY( oNumeroDePlaca )

ALTER TABLE oficialesdepolicia ADD CONSTRAINT fkoficialesdepolicia FOREIGN KEY(
oNombreDeRango ) REFERENCES rangos ( rNombre )



#########
CREATE TABLE servicios(
sNombre char(15)
);

ALTER TABLE servicios ADD CONSTRAINT pkservicios PRIMARY KEY( sNombre )


CREATE TABLE departamentos(
dNombre char(15),
dLineaTelefonica integer,
dNombreLocalidad char(15),
dNombreSupervisa char(15)

);

ALTER TABLE departamentos ADD CONSTRAINT pkdepartamentos PRIMARY KEY( dNombre )

ALTER TABLE departamentos ADD CONSTRAINT fkdepartamentos FOREIGN KEY(
dNombreLocalidad ) REFERENCES localidadtes ( lNombre )

ALTER TABLE departamentos ADD CONSTRAINT fk2departamentos FOREIGN KEY(
dNombreSupervisa ) REFERENCES departamentos ( dNombre )

CREATE TABLE lineatelefonicas(
sNombreDepartamento char(15),
sNumero char(15)

);

ALTER TABLE lineatelefonicas ADD CONSTRAINT pklineatelefonicas PRIMARY KEY( sNumero )
ALTER TABLE lineatelefonicas ADD CONSTRAINT fklineatelefonicas FOREIGN KEY(
sNombreDepartamento ) REFERENCES departamentos ( dNombre )

CREATE TABLE localidades(
lNombre char(15)
);

ALTER TABLE localidades ADD CONSTRAINT pklocalidades PRIMARY KEY( lNombre )

CREATE TABLE rangos(
rNombre char(15)
);

ALTER TABLE rangos ADD CONSTRAINT pkrangos PRIMARY KEY( rNombre )

CREATE TABLE declara(
dIdTestimonio integer,
dIdCaso integer,
dDNI integer

);

ALTER TABLE declara ADD CONSTRAINT pkdeclara PRIMARY KEY( dIdTestimonio )
ALTER TABLE declara ADD CONSTRAINT pk1declara PRIMARY KEY( dIdCaso )
ALTER TABLE declara ADD CONSTRAINT pk2declara PRIMARY KEY( dDNI )


ALTER TABLE declara ADD CONSTRAINT fkdeclara FOREIGN KEY(
dIdTestimonio ) REFERENCES testimonios ( tId )

ALTER TABLE declara ADD CONSTRAINT fk2declara FOREIGN KEY(
dIdCaso ) REFERENCES casoscriminales ( cIdCaso )

ALTER TABLE declara ADD CONSTRAINT fk2declara FOREIGN KEY(
dDNI ) REFERENCES personas ( pDni )

CREATE TABLE tiene(
tNombreRol integer,
tIdCaso integer,
tDNI integer

);

ALTER TABLE tiene ADD CONSTRAINT pktiene PRIMARY KEY( tNombreRol )
ALTER TABLE tiene ADD CONSTRAINT pk1tiene PRIMARY KEY( tIdCaso )
ALTER TABLE tiene ADD CONSTRAINT pk2tiene PRIMARY KEY( tDNI )

ALTER TABLE tiene ADD CONSTRAINT fktiene FOREIGN KEY(
tNombreRol ) REFERENCES roles ( rNombre )

ALTER TABLE tiene ADD CONSTRAINT fk2tiene FOREIGN KEY(
tIdCaso ) REFERENCES casoscriminales ( cIdCaso )

ALTER TABLE tiene ADD CONSTRAINT fk2tiene FOREIGN KEY(
tDNI ) REFERENCES personas ( pDni )

CREATE TABLE culpable(
cIdCaso integer,
cDNI integer

);

ALTER TABLE culpable ADD CONSTRAINT pk1tiene PRIMARY KEY( cIdCaso )
ALTER TABLE culpable ADD CONSTRAINT pk2tiene PRIMARY KEY( cDNI )

ALTER TABLE culpable ADD CONSTRAINT fk2tiene FOREIGN KEY(
cIdCaso ) REFERENCES casoscriminales ( cIdCaso )

ALTER TABLE culpable ADD CONSTRAINT fk2tiene FOREIGN KEY(
cDNI ) REFERENCES personas ( pDni )