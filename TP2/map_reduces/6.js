// Cantidad total de evidencias por caso.

function map(){
	emit(this.id, this.evidencias);
}

function reduce(case_id, evidences){
	return evidences[0].length;
}

db.casosCriminales.mapReduce(map, reduce, {out: {inline: 1}})

