// DOCUMENTOS

// PERSONA 
{
	{
		dni: 36949514,
		fecha_nacimiento: 10/11/1992,
		nombre: "Carolina",
		apellido: "Wright", 
		domicilio: {
			id: 1,
			numero: 5950,
			calle: "20 de febrero"
		}
	}
}

// PERSONAS DE ROL
{ 
  [
    {
      nombre_rol: "Testigo"
      personas: [
              {
            		dni_persona: 36949514,
            	},
              {
              	dni_persona: 36949515,
            	}
          ]
  },
  {
    nombre_rol: "Culpable"
    personas: [
              {
              	dni_persona: 36949516,
            	},
              {
              	dni_persona: 36949517,
            	}
          ]
  }
  ]
  
}


// INFOMACION DE PERSONAS
{
  [
    {
  		dni_persona: 36949514,
  		
  		caso_y_rol: [
        {
         id: 2,
          fecha_ingreso: 31/10/2016,
    		  fecha: 29/10/2016,
    		  lugar: "Palermo",
    		  descripcion: "Robo de billetera",
    		  nombre_categoria: "Robo",
    		  estado: "Pendiente"
        },
        {
          id: 3,
      	  fecha_ingreso: 31/09/2016,
    		  fecha: 29/11/2016,
    		  lugar: "Belgrano",
    		  descripcion: "Robo de auto",
    		  nombre_categoria: "Robo",
    		  estado: "Pendiente"
        }
        ]
  	},
    {
    	dni_persona: 36949632,
  		
  		caso_y_rol: [
        {
          id: 3,
          fecha_ingreso: 31/10/2016,
    		  fecha: 21/03/2016,
    		  lugar: "Retiro",
    		  descripcion: "Robo de banco",
    		  nombre_categoria: "Robo",
    		  estado: "Resuelto"
        },
        {
          id: 5,
      	  fecha_ingreso: 31/09/2016,
    		  fecha: 22/11/2016,
    		  lugar: "Barracas",
    		  descripcion: "Secuestro",
    		  nombre_categoria: "Robo",
    		  estado: "Resuelto"
        }
        ]
  	}
  
  ]
	
}

// ROL
{
	{
		nombre: "Testigo"
	}
}

// CASO CRIMINAL
{
	{
		  id: 1,
		  fecha_ingreso: 31/10/2016,
		  fecha: 29/10/2016,
		  lugar: "Palermo",
		  descripcion: "Robo de billetera",
		  categoría: "Robo",
		  estado: "Pendiente",
		  evidencias: [
		  	idEvidencia: 1,
		  	idEvidencia: 2,
		  	idEvidencia: 10
		  ]
	}
}

// CATEGORIA
{
	{
		  nombre: "Crimen",
		  casos_criminales: [
		  	id: 4
		  ]
	}
}

// PERSONAS INVOLUCRADAS EN CASO
{
	{
		  id_caso_criminal: 1,
		  personas_involucradas: [
		  	dni_persona: 36949514
		  ]
	}
}

// PERSONAS CULPABLES
{
	{
		  id_caso_criminal: 1,
		  personas_culpables: [
		  	dni_persona: 36949514
		  ]
	}
}
