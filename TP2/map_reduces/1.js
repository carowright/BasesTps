// Número promedio de crímenes cometidos por personas que ya han sido encontradas culpables de algún crimen.

function map(){
	emit("acum", this.personas_culpables);
}

function reduce(acum_key, criminals){
	var amount_of_criminals = 0;
	var amount_of_criminal_cases = criminals.length; 
	
	for (var i = 0; i < amount_of_criminal_cases; i++) {
		amount_of_criminals += criminals[i];
	}

	return amount_of_criminals / amount_of_criminal_cases;
}

db.personasCulpables.mapReduce(map, reduce, {out: "result"})

