select Testimonio.* from
	Tiene tiene join caso_dado
	on tiene.caso_id = caso_dado.id
	join Personas pers 
	on tiene.persona_dni = pers.dni
	join Testimonios test 
	on tiene.persona_dni = test.dni 
	join Testimonios test2
	on tiene.caso_id = test2.caso_id  