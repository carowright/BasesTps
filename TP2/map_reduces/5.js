// Mayor número de crímenes cometido por alguna persona.

function map(){
	var crimes = this.caso_y_rol.filter( function(caso) {
		return caso.nombre_categoria == "Crimen";
	})
	if (crimes.length > 0) 
		emit("acum", crimes.length;
	}
}

function reduce(acum, crimes_quantities) {
	return Math.max.apply(crimes_quantities);
}

db.informacionDePersonas.mapReduce(map, reduce, {out: {inline: 1}})

