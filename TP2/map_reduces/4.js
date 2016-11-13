// Cantidad de crímenes por localidad y por año.

function map(){
	var year = new Date(Date.parse(this.fecha)).getFullYear();
	emit(this.lugar + year, 1);
}

function reduce(cityAndYear, count){
	return count.length;
}

db.casosCriminales.mapReduce(map, reduce, {out: {inline: 1}})

