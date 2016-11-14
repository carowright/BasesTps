// Las 10 ciudades con mayor número de crímenes.

function map(){
	if (this.nombre == "Crimen") {
		emit(this.nombre, this.casos_criminales);
	}	
}

function reduce(crime, cases){
    var groupedByCity = groupByCity(cases);
    
    groupedByCity.sort( function(a, b) {
        return (a["count"] >= b["count"]) ? 1 : -1;
    });
    
    return groupedByCity.slice(0, 10).map( function(elem) {
    	return elem.city;
    });
}

function groupByCity(cases) {
	var groups = {};

	for(var i = 0; i < cases.length; i++) {
		var item = cases[i];

		if(!groups[item.lugar]) {
		    groups[item.lugar] = 0;
		}

		groups[item.lugar] = groups[item.lugar] + 1;
	}
	
	var result_cases;
	for (var group in groups) {
  		result_cases.push({city: group, count: groups[group]});
	}
	return
}

db.categorias.mapReduce(map, reduce, {out: "result"})

