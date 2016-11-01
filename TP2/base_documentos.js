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

// PERSONA DE ROL
{
	{
		dni_persona: 36949514,
		nombre: "Testiguador",
		nombre_rol: "Testigo"
	}
}


// INFOMACION DE PERSONAS
{
	{
		nombre_rol: "Testigo",
		dni_persona: 36949514,
		fecha: 29/10/2016,
		id_caso: 1, 
		tipo: ROBO
	}
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
		  nombre_categoria: "Robo",
		  estado: "Pendiente"
	}
}
