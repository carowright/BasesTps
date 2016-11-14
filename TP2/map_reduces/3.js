// Casos en los que se han visto involucradas el mayor número de personas.

function map(){
	emit("acum", {id: this.id_caso_criminal, count: this.personas_involucradas.length});
}

function reduce(acum_key, cases) {
	var result_cases = [];
	var max_people = 0;
	
	cases.forEach( function(c) {
		if (c.count > max_people) {
			max_people = c.count;
			result_cases = [];
			result_cases.push(c.id);
		}
		else if (c.count == max_people) {
			result_cases.push(c.id);
		}
	});
	return {"result": result_cases};
}

db.personasInvolucradas.mapReduce(map, reduce, {out: {inline: 1}})

