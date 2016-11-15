// Personas involucradas como testigos en la mayor cantidad de casos.

function map(){
	var witness_cases = this.caso_y_rol.filter( function(caso) {
		return caso.nombre_rol == "Testigo";});
	if (witness_cases.length > 0) 
		emit("acum", {dni: this.dni_persona, amount: witness_cases.length});
}


function reduce(acum, people) {

	var max_involved = [];
	var max_witnesses = 0;
	
	people.forEach( function(person) {
		if (person.amount > max_witnesses) {
			max_witnesses = person.amount;
			max_involved = [];
			max_involved.push(person.dni);
		}
		else if (person.amount == max_witnesses) {
			max_involved.push(person.dni);
		}
	})
	
	return {"result": max_involved};
}

db.informacionDePersonas.mapReduce(map, reduce, {out: {inline: 1}})

