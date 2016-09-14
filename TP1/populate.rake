namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    
    [Telefonos, Lineas_Telefonicas, Testimonios, Oficiales_De_Policia, 
     Departamentos, Localidades, Rangos, Eventos, Evidencias, Caso_Criminal_Personas, 
     Roles, Servicios, Casos_Criminales, Personas, Direcciones, Categorias
    ].each(&:delete_all)
    
    def gen_phone_number 
      (0..7).map {rand(10)}.join
    end


    RANGOS      = ['Teniente', 'Sargento', 'General', 'Sheriff', 'Cabo', 'Raso', 'Comisario', 'Detective']
    SERVICIOS   = ['Tráfico', 'Parque', 'Bombero', 'Forense', 'Asuntos Internos', 'Informatica', 'Recolector', 'Banco', 'Frontera', 'Guardia', 'Administrativo', 'Seguridad', 'SIDE']
    LOCALIDADES = ['Abasto', 'Barracas', 'Belgrano', 'Boedo', 'Caballito', 'Centro', 'La Boca', 'Microcentro', 'Monserrat', 'Nueva', 'Pompeya', 'Palermo', 'Puerto', 'Madero', 'Recoleta', 'Retiro', 'San Nicolas', 'San Telmo', 'Agronomía', 'Almagro', 'Balvanera', 'Barrio Norte', 'Chacarita', 'Coghlan', 'Colegiales', 'Constitucion', 'Flores', 'Floresta', 'Liniers', 'Mataderos', 'Monte Castro', 'Nuñez', 'Parque Avellaneda', 'Parque Chacabuco', 'Parque Patricios', 'Paternal', 'Saavedra', 'San Cristobal', 'Velez Sarsfield', 'Versalles', 'Villa Crespo', 'Villa Devoto', 'Villa General Mitre', 'Villa Lugano', 'Villa Luro', 'Villa Ortuzar', 'Villa Pueyrredon', 'Villa Real', 'Villa Riachuelo', 'Villa Santa Rita', 'Villa Soldati', 'Villa Urquiza', 'Villa del Parque']
    CATEGORIAS  = ['Secuestro', 'Homicidio', 'Robo arma blanca', 'Robo mano armada', 'Suicidio', 'Choque', 'Violación', 'Evasión Impositiva', 'Atropellamiento', 'Desacato']
    ROLES       = ['Victima', 'Testigo', 'Acusado']
    EVIDENCIAS  = ["Nombre: #{Faker::Beer.name}", "Stilo: #{Faker::Beer.style}", "Hop: #{Faker::Beer.hop}", "Origen: #{Faker::Beer.yeast}", "Malta: #{Faker::Beer.malts}", "Ibu: #{Faker::Beer.ibu}", "\% de Alcohol: #{Faker::Beer.alcohol}", "Blg: #{Faker::Beer.blg}"]


    RANGOS.each do |name|
      Rango.create(nombre: name)
    end

    SERVICIOS.each do |name|
      Servicio.create(nombre: name)
    end

    LOCALIDADES.each do |name|
      Localidad.create(nombre: name)
    end  

    CATEGORIAS.each do |name|
      Categoria.create(nombre: name)
    end

    ROLES.each do |name|
      Rol.create(nombre: name)
    end


    Departamento.populate 50 do |dp|
      dp.nombre = "DPT_#{Faker::Lorem.word}_#{Faker::Hipster.word}_#{rand(10)}"
      dp.nombre_localidad = LOCALIDADES
      LineasTelefonica.populate 1..3 do |lt|
        lt.numero = gen_phone_number
        lt.nombre_departamento = dp.nombre
      end
    end

    DEPARTAMENTOS = Departamento.all.pluck(:nombre)

    Departamento.all.each do |dp|
      if rand(4) < 3
        dp.update_attributes(supervisado_por_departamento: (DEPARTAMENTOS-[dp.nombre]).sample)
      end
    end





    Direccion.populate 250..350 do |direccion|
      direccion.calle  = Faker::Address.street_name
      direccion.numero = Faker::Address.building_number

      Persona.populate 1..2 do |persona|
        persona.dni = 12000000..46000000
        persona.nombre    = Faker::Name.first_name
        persona.apellido  = Faker::Name.last_name
        persona.fecha_nacimiento =  Faker::Date.between(80.years.ago, Date.today)
        persona.direccion_id = direccion.id
        if rand(3) == 1
          OficialesDePolicia.populate 1 do |oficial|
            oficial.persona_dni          = persona.dni
            oficial.numero_de_placa      = 10000..100000
            oficial.fecha_de_ingreso     = Faker::Date.between(20.years.ago, Date.today)
            oficial.numero_de_escritorio = 0..100000
            oficial.nombre_rango         = RANGOS
            oficial.nombre_departamento  = DEPARTAMENTOS
          end
        end

        Telefono.populate 1..2 do |tel|
          tel.numero = gen_phone_number
          tel.persona_dni = persona.dni
          tel.tipo = ['Domicilio', 'Celular', 'Laboral']
        end

      end
    end    

    DNIS  = Persona.all.pluck(:dni)
    PLACAS = OficialesDePolicia.all.pluck(:numero_de_placa)

    CasosCriminal.populate 135..165 do |cc|
      cc.fecha = Faker::Time.between(5.years.ago, DateTime.now)
      cc.lugar = Faker::Pokemon.location
      cc.descripcion = Faker::Lorem.sentence
      cc.fecha_ingreso = Faker::Date.between(cc.fecha, Date.today)
      cc.nombre_categoria = CATEGORIAS
    end


    CasosCriminal.all.each do |cc|
      DNIS.sample(rand(7)+1).each_with_index do |dni, index|
        CasoCriminalPersona.create(
          caso_id: cc.id,
          persona_dni: dni,
          nombre_rol: (index==0 ? 'Victima' : ROLES.sample)
        )
        Evento.populate 2..5 do |e|
          e.caso_id     = cc.id
          e.persona_dni = dni
          e.descripcion = Faker::Hipster.sentence
          e.fecha       = Faker::Time.between(cc.fecha - 30.days, cc.fecha)
        end

        if rand(3) < 2
          Testimonio.populate 1 do |t|
            t.caso_id = cc.id
            t.persona_dni = dni
            t.texto = Faker::StarWars.quote
            t.fecha = Faker::Time.between(cc.fecha_ingreso, DateTime.now)
            t.nro_placa_policia_a_cargo = PLACAS
          end
        end
      end

      _evidencias = EVIDENCIAS.sample(rand(8))

      Evidencia.populate _evidencias.length do |evi|
        evi.caso_id         = cc.id
        evi.descripcion     = _evidencias.pop
        evi.fecha_encuentro = Faker::Date.between(cc.fecha, Date.today)
        evi.fecha_ingreso   = Faker::Date.between(evi.fecha_encuentro, Date.today)
        evi.fecha_sellado   = Faker::Date.between(evi.fecha_ingreso, Date.today)
      end
    end

  end
end