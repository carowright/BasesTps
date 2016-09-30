# 1 -- Datos de las personas que fueron sospechosas.
select p.dni, p.fecha_nacimiento, p.nombre, p.apellido 
from persona p 
  inner join involucra inv 
  on p.dni = inv.persona_dni 
where inv.nombre_rol ="Sospechoso";

# 2 -- Direcciones donde convivieron personas sospechosas de diferentes casos
select id, numero, calle, count(dni) as dniInvolucrados from domicilio d
inner join persona p on d.id = p.domicilio_id
inner join involucra inv on inv.persona_dni = p.dni
where inv.nombre_rol = "Sospechoso"
group by d.id
having COUNT(dniInvolucrados) > 1

# 3 -- Oficiales que participaron en la cadena de custodia de evidencias para más de un caso.
select numero_de_placa, count(caso_id) as casosInvolucrados
from oficial_de_policia op inner join 
custodia c on c.nro_placa_policia_a_cargo = op.numero_de_placa inner join 
evidencia e on e.id = c.evidencia_id 
group by op.numero_de_placa HAVING casosInvolucrados > 1;

# 4 -- La sucesión de eventos de personas involucradas en un caso.
select e.fecha,  inv.persona_dni as dni, e.descripcion from evento e inner join involucra inv where inv.persona_dni = e.persona_dni and inv.caso_id = "ID DEL CASO" order by e.fecha;

# 5 -- Un ranking de oficiales exitosos, es decir los que cerraron mayor cantidad de casos (resueltos).
select numero_de_placa, count(caso_id) as nroCasosResueltos from resuelto inner join oficial_de_policia on nro_placa_policia_cerro = numero_de_placa group by numero_de_placa order by nroCasosResueltos desc;

# 6 -- Las ubicaciones de todas las evidencias de un caso.
select e.id as evidencia_id, c.localizacion from custodia c inner join evidencia e on e.id = c.evidencia_id where e.caso_id = "ID DEL CASO" and c.fecha = (select max(fecha) from custodia c2 where c2.evidencia_id = e.id);

# 7 -- La lista de oficiales involucrados en un caso.
select op.numero_de_placa, inv.nombre_rol from oficial_de_policia op inner join persona pe on pe.dni = op.persona_dni inner join involucra inv on inv.persona_dni = pe.dni where inv.caso_id = "ID DEL CASO";

# 8 -- Las categorías de casos ordenadas por cantidad de casos
select cat.nombre, count(cc.id) as cantidadDeCasos from categoria cat inner join caso_criminal cc on cc.nombre_categoria = cat.nombre group by cat.nombre order by cantidadDeCasos desc;

# 9 -- Todos los testimonios de un caso dado
select t.fecha, t.persona_dni, t.texto from testimonio t where t.caso_id = "ID DEL CASO";

# 10 -- Para una categoría en particular listar, para cada uno de los casos, los testimonios asociados
select cc.id as casoId, te.texto as Testimonio from categoria cat inner join caso_criminal cc on cc.nombre_categoria = cat.nombre inner join involucra inv on inv.caso_id = cc.id inner join testimonio te on te.caso_id = inv.caso_id and te.persona_dni = inv.persona_dni where cat.nombre = "NOMBRE CATEGORIA";
