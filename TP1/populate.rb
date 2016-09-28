require 'activerecord-jdbcmysql-adapter'
require 'populator'
require 'faker'

ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'Culpable' , 'Culpable'
  inflect.irregular 'Congelado' , 'Congelado'
  inflect.irregular 'Pendiente' , 'Pendiente'
  inflect.irregular 'Resuelto'  , 'Resuelto'
  inflect.irregular 'Descartado'       , 'Descartado'
  inflect.irregular 'Investiga' , 'Investiga'
  inflect.irregular 'Custodia'  , 'Custodia'
  inflect.irregular 'Telefono' , 'Telefono'
  inflect.irregular 'Linea_Telefonica' , 'Linea_Telefonica' 
  inflect.irregular 'Testimonio'  , 'Testimonio'
  inflect.irregular 'Oficial_De_Policia'  , 'Oficial_De_Policia'
  inflect.irregular 'Departamento'  , 'Departamento'
  inflect.irregular 'Localidad'  , 'Localidad'
  inflect.irregular 'Rango'  , 'Rango'
  inflect.irregular 'Evento'  , 'Evento'
  inflect.irregular 'Evidencia'  , 'Evidencia'
  inflect.irregular 'Involucra'  , 'Involucra'
  inflect.irregular 'Rol'  , 'Rol'
  inflect.irregular 'Servicio'  , 'Servicio'
  inflect.irregular 'Caso_Criminal'  , 'Caso_Criminal'
  inflect.irregular 'Persona'  , 'Persona'
  inflect.irregular 'Domicilio'  , 'Domicilio'
  inflect.irregular 'Categoria'  , 'Categoria'

end


ActiveRecord::Base.establish_connection(
  :adapter  => "mysql",
  :host     => "naix.verisur",
  :username => "adminLTE",
  :password => "adminLTE_pass",
  :database => "bases"
)


def clean
  File.read('tablas.sql').strip.split(";").each do |statement|
    ActiveRecord::Base.connection.execute(statement)
  end
end


RANGOS      = ['Teniente', 'Sargento', 'General', 'Sheriff', 'Cabo', 'Raso', 'Comisario', 'Detective']
SERVICIOS   = ['Tráfico', 'Parque', 'Bombero', 'Forense', 'Asuntos Internos', 'Informatica', 'Recolector', 'Banco', 'Frontera', 'Guardia', 'Administrativo', 'Seguridad', 'SIDE']
LOCALIDADES = ['Abasto', 'Barracas', 'Belgrano', 'Boedo', 'Caballito', 'Centro', 'La Boca', 'Microcentro', 'Monserrat', 'Nueva', 'Pompeya', 'Palermo', 'Puerto', 'Madero', 'Recoleta', 'Retiro', 'San Nicolas', 'San Telmo', 'Agronomía', 'Almagro', 'Balvanera', 'Barrio Norte', 'Chacarita', 'Coghlan', 'Colegiales', 'Constitucion', 'Flores', 'Floresta', 'Liniers', 'Mataderos', 'Monte Castro', 'Nuñez', 'Parque Avellaneda', 'Parque Chacabuco', 'Parque Patricios', 'Paternal', 'Saavedra', 'San Cristobal', 'Velez Sarsfield', 'Versalles', 'Villa Crespo', 'Villa Devoto', 'Villa General Mitre', 'Villa Lugano', 'Villa Luro', 'Villa Ortuzar', 'Villa Pueyrredon', 'Villa Real', 'Villa Riachuelo', 'Villa Santa Rita', 'Villa Soldati', 'Villa Urquiza', 'Villa del Parque']
CATEGORIAS  = ['Secuestro', 'Homicidio', 'Robo arma blanca', 'Robo mano armada', 'Suicidio', 'Choque', 'Violación', 'Evasión Impositiva', 'Atropellamiento', 'Desacato']
ROLES       = ['Victima', 'Testigo', 'Sospechoso']

def gen_evidencias
  [
   "Nombre: #{Faker::Beer.name}", "Stilo: #{Faker::Beer.style}", "Hop: #{Faker::Beer.hop}", 
   "Origen: #{Faker::Beer.yeast}", "Malta: #{Faker::Beer.malts}", "Ibu: #{Faker::Beer.ibu}", 
   "\% de Alcohol: #{Faker::Beer.alcohol}", "Blg: #{Faker::Beer.blg}"
  ]
end


[
 :Culpable,:Congelado,:Pendiente,:Resuelto,
:Descartado,:Investiga,
:Custodia,:Telefono,:Linea_Telefonica,:Testimonio,:Oficial_De_Policia,:Departamento,:Localidad,:Rango,
:Evento,:Evidencia,:Involucra,:Rol,:Servicio,:Caso_Criminal,:Persona,:Domicilio,:Categoria
].each do |class_name|
  Object.const_set(class_name, Class.new(ActiveRecord::Base))
end


def gen_phone_number 
  (0..7).map {rand(10)}.join
end

def populate_statics
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
end

def populate_departamentos
  Departamento.populate 50 do |dp|
    dp.nombre = "DPT_#{Faker::GameOfThrones.house}_#{Faker::Hacker.abbreviation}_#{rand(99)}"
    dp.nombre_localidad = LOCALIDADES
    LineasTelefonica.populate 1..3 do |lt|
      lt.numero = gen_phone_number
      lt.nombre_departamento = dp.nombre
    end
  end

  _departamentos = Departamento.all.pluck(:nombre)

  Departamento.all.each do |dp|
    if rand(4) < 3
      dp.update_attributes(supervisado_por_departamento: (_departamentos-[dp.nombre]).sample)
    end
  end
end

def populate_personas
  _departamentos = Departamento.all.pluck(:nombre)

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
          oficial.nombre_departamento  = _departamentos
        end
      end

      Telefono.populate 1..2 do |tel|
        tel.numero = gen_phone_number
        tel.persona_dni = persona.dni
        tel.tipo = ['Domicilio', 'Celular', 'Laboral']
      end

    end
  end    
end

def populate_casos
  _dnis   = Persona.all.pluck(:dni)
  _placas = OficialesDePolicia.all.pluck(:numero_de_placa)

  CasosCriminal.populate 135..165 do |cc|
    cc.fecha = Faker::Time.between(5.years.ago, DateTime.now)
    cc.lugar = Faker::Pokemon.location
    cc.descripcion = Faker::Lorem.sentence
    cc.fecha_ingreso = Faker::Date.between(cc.fecha, Date.today)
    cc.nombre_categoria = CATEGORIAS
    cc.estado = "TEMP"
  end


  CasosCriminal.all.each do |cc|
    _policias_no_involucrados = _placas-get_placas_involucradas(cc)

    case rand(4)
      when 0
        Congelado.create(
          caso_id: cc.id,
          fecha: Faker::Date.between(cc.fecha_ingreso, Date.today),
          comentario: Faker::ChuckNorris.fact
        )
        cc.update_attributes(estado: "Congelado")
      when 1
        Pendiente.create(
          caso_id: cc.id
        )
        cc.update_attributes(estado: "Pendiente")
      when 2
        Resuelto.create(
          caso_id: cc.id,
          fecha: Faker::Date.between(cc.fecha_ingreso, Date.today),
          descripcion: Faker::ChuckNorris.fact,
          nro_placa_policia_cerro: _policias_no_involucrados.sample
        )
        cc.update_attributes(estado: "Resuelto")
      when 3
        Descartado.create(
          caso_id: cc.id,
          fecha: Faker::Date.between(cc.fecha_ingreso, Date.today),
          motivo: Faker::ChuckNorris.fact
        )
        cc.update_attributes(estado: "Descartado")
    end


    _involucrados = _dnis.sample(rand(7)+1)

    _involucrados.each_with_index do |dni, index|
      Participa.create(
        caso_id: cc.id,
        persona_dni: dni,
        nombre_rol: ROLES.sample
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
          t.nro_placa_policia_a_cargo = _placas
        end
      end

      if cc.estado == "Resuelto" && (rand(3)==0 || _involucrados.length == index+1)
        Culpable.create(
          persona_dni: dni, 
          caso_id: cc.id
        )
      end


    end
    _investigadores = _policias_no_involucrados.sample(rand(5)+1)
    _principal = false

    _investigadores.each_with_index do |placa, index|
      _sera_principal = _principal ? false : ([true, false].sample || (_investigadores.length == index+1))
      
      Investiga.create(
        caso_id: cc.id,
        nro_placa_policia: placa,
        es_investigador_principal: (_sera_principal)
      )
      
      _principal |= _sera_principal
    end



  end
end




def get_placas_involucradas(cc)
  ActiveRecord::Base.connection.execute("select op.numero_de_placa from personas p inner join oficiales_de_policia op inner join participa ccp on p.dni=op.persona_dni and ccp.persona_dni=p.dni and ccp.caso_id=#{cc.id}").map {|_p| _p['numero_de_placa']}
end

def populate_evidencias
  _placas = OficialesDePolicia.all.pluck(:numero_de_placa)
  CasosCriminal.all.each do |cc|


    _placas_policias_involucrados = get_placas_involucradas(cc)

    _evidencias = gen_evidencias.sample(rand(8))

    Evidencia.populate _evidencias.length do |evi|
      evi.caso_id         = cc.id
      evi.descripcion     = _evidencias.pop
      evi.fecha_encuentro = Faker::Date.between(cc.fecha, Date.today)
      evi.fecha_ingreso   = Faker::Date.between(evi.fecha_encuentro, Date.today)
      evi.fecha_sellado   = Faker::Date.between(evi.fecha_ingreso, Date.today)
      Custodia.populate 1..4 do |cstd|
        cstd.fecha = Faker::Time.between(evi.fecha_ingreso, evi.fecha_sellado)
        cstd.comentario = Faker::Hacker.say_something_smart
        cstd.evidencia_id = evi.id
        cstd.nro_placa_policia_a_cargo = [_placas-_placas_policias_involucrados].sample
      end
    end
  end
end



case ARGV[0]
  when 'clean'
    clean
  when 'statics'
    populate_statics
  when 'departamentos'
    populate_departamentos
  when 'personas'
    populate_personas
  when 'casos'
    populate_casos
  when 'evidencias'
    populate_evidencias
  when 'all'
  when nil 
    clean
    populate_statics
    populate_departamentos
    populate_personas
    populate_casos
    populate_evidencias
  else
    puts "Wrong argument"
end




