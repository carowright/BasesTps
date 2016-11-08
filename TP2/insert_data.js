db.casosCriminales.insertMany([
	{
		  id: 1,
		  fecha_ingreso: "2016-10-31",
		  fecha: "2016-10-29",
		  lugar: "Palermo",
		  descripcion: "Robo de billetera",
		  categoría: "Robo",
		  estado: "Pendiente".
  	 	  evidencias: [
		  	idEvidencia: 1,
		  	idEvidencia: 2,
		  	idEvidencia: 10
		  ]
	},
	{
		  id: 2,
		  fecha_ingreso: "2016-10-31",
		  fecha: "2016-10-06",
		  lugar: "Palermo",
		  descripcion: "Robo de billetera",
		  categoría: "Robo",
		  estado: "Pendiente".
	 	  evidencias: [
		  	idEvidencia: 3
		  ]
	},
	{
		  id: 3,
		  fecha_ingreso: "2015-10-31",
		  fecha: "2016-10-06",
		  lugar: "Palermo",
		  descripcion: "Robo de billetera",
		  categoría: "Robo",
		  estado: "Pendiente".
	 	  evidencias: [
		  	idEvidencia: 5,
		  	idEvidencia: 9,
		  	idEvidencia: 16
		  ]
	},
	{
		  id: 4,
		  fecha_ingreso: "2015-11-31",
		  fecha: "2016-10-06",
		  lugar: "Villa urquiza",
		  descripcion: "Crimen",
		  categoría: "Crimen",
		  estado: "Resuelto".
	 	  evidencias: [
		  	idEvidencia: 7,
		  	idEvidencia: 8
		  ]
	}
])

db.casosPorCategoria.insertMany([
	{
		  nombre: "Crimen",
		  casos_criminales: [
		  	id: 4
		  ]
	},
	{
		  nombre: "Robo",
		  casos_criminales: [
		  	id: 1,
		  	id: 2,
		  	id: 3
		  ]
	}
])

db.personasInvolucradas.insertMany([
	{
		  id_caso_criminal: 1,
		  personas_involucradas: [
		  	dni_persona: 36949514
		  ]
	},
		{
		  id_caso_criminal: 2,
		  personas_involucradas: [
		  	dni_persona: 36949514,
			dni_persona: 38652114		  	
		  ]
	}
])

db.personasCulpables.insertMany([
	{
		  id_caso_criminal: 4,
		  personas_culpables: [
		  	dni_persona: 36559514
		  ]
	}
])
