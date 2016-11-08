// Cantidad de crímenes por localidad y por año.

function map(){
	var year = new Date(this.fecha).getFullYear();
	emit(this.lugar + this.year, 1);
}

function reduce(cityAndYear, count){
	return count.length;
}

db.casosCriminales.mapReduce(map, reduce, {out: "result"})

