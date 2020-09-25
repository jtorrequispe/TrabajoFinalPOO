require "test/unit"
class Politica_educacion
	attr_accessor :dni, :apellido, :nombres, :edad, :genero, :cantidad_preguntas, :codigo_eva, :puntaje, :ingresa
	def initialize(dni, apellido, nombres, edad, genero, cantidad_preguntas, codigo_eva)
		@dni=dni
		@apellido=apellido
		@nombres=nombres
		@edad=edad
		@genero=genero
		@cantidad_preguntas=cantidad_preguntas
		@codigo_eva=codigo_eva
	end
	
	def calcular_puntaje		
	end
	def dame_tipo
	end
	def correr_puntaje
		@puntaje = (0.2 * calcular_cs + 0.3 * calcular_re + 0.5 * calcular_ec)
	end

	def estado_alumnos
	end

	
#-----------------------------------------------
	def calcular_ec
	puntaje = 0
	preg_correctas = 0
	o = [('A'..'E'),('-'..'-')].map(&:to_a).flatten
	temp = (0...cantidad_preguntas).map { o[rand(o.length)] }.join
		for j in 0..cantidad_preguntas-1
			if cantidad_preguntas <= 10
				if temp[j] == "A" || temp[j] == "B" ||  temp[j] == "C"
					puntaje = puntaje + 10
					preg_correctas += 1
				else
					puntaje = puntaje - 5
				end
			elsif cantidad_preguntas> 10 && cantidad_preguntas<=20
				if temp[j] == "B" || temp[j] == "D" || temp[j] == "A"
					puntaje = puntaje + 5
					preg_correctas = preg_correctas +1
				else
					puntaje = puntaje - 2.5
				end
			end
		end
	return  puntaje
	end
end
#-----------------------------------------------

class Colegio_nacional < Politica_educacion
	attr_accessor :colegio, :promedio
	def initialize (dni, apellido, nombres, edad, genero, cantidad_preguntas, codigo_eva, colegio, promedio)
		@colegio = colegio
		@promedio = promedio
		super(dni, apellido, nombres, edad, genero, cantidad_preguntas, codigo_eva)
	end
	def calcular_cs
		if colegio == "Rural"
			cs = 100.0
		elsif colegio == "Urbana"
			cs = 80.0
		end
		return cs
	end
	def calcular_re
		
		if promedio>=19
			re = 100.0
		elsif promedio>=18 && promedio<19
			re = 80.0
		elsif promedio>=16 && promedio<18
			re = 60.0
		elsif promedio>=14 && promedio<16
			re = 40.0
		elsif promedio>=11 && promedio<14
			re = 20.0
		elsif promedio<11
			re = 0.0
		end
		return re		
		 	 
	end
	def calcular_ec
		super
	end
	def calcular_puntaje
	 super
	end
	def dame_tipo
		return "Colegio nacional"
	end
	def estado_alumnos
		super
	end
	
end

class Colegio_particular < Politica_educacion
	attr_accessor :monto_pension , :puesto_2do
	def initialize (dni, apellido, nombres, edad, genero, cantidad_preguntas, codigo_eva, monto_pension, puesto_2do)
		@monto_pension = monto_pension
		@puesto_2do = puesto_2do
		super(dni, apellido, nombres, edad, genero, cantidad_preguntas, codigo_eva)
	end

	def calcular_cs
		if monto_pension <=200
			cs = 90.0
		elsif monto_pension>200 && monto_pension<=400
			cs = 70.0
		elsif monto_pension>400 && monto_pension<=600
			cs = 50.0
		elsif monto_pension>600
			cs = 40.0
		end
		return cs
	end
	def calcular_re
		if puesto_2do <=3
			re = 100.0
		elsif puesto_2do>= 4 && puesto_2do<=5
			re = 80.0
		elsif puesto_2do>=6 && puesto_2do<=10
			re = 60.0
		elsif puesto_2do>=11 && puesto_2do<=20
			re = 40.0
		elsif puesto_2do>20
			re = 0.0
		end
		return re
					
	end
	def calcular_ec
		super
	end
		
	def calcular_puntaje()
		super
	end
	def dame_tipo
		return "Colegio particular"
	end

	def estado_alumnos
		super
	end
	
end
#---------------------------------------------------------------
class Tutor
	attr_reader :dni_tutor, :dni_alumno
	def initialize(dni_tutor, dni_alumno, apellido_turor, nombre_tutor, parentesco)
		@dni_alumno, @dni_tutor, @apellido_turor, @nombre_tutor, @parentesco = dni_alumno, dni_tutor, apellido_turor, nombre_tutor, parentesco
	end
end

#---------------------------------------------------------------
class Administrador

  attr_accessor :arreglo_alumnos, :arreglo_tutores, :dni_alumnos, :dni_tutores, :vacantes

  def initialize (vacantes)
    @arreglo_alumnos = []
		@arreglo_tutores = []
		@dni_alumnos = []
		@dni_tutores = []
		@vacantes = vacantes
  end
  #---------------------------------------------------------------
  #REGISTRO DE Alumnos
   	def validar_dni(numero)
    tamano = numero.to_s.length
        if  tamano < 8 || tamano > 8
         return false
        else 
        return true
        end
    end

    def registrar_alumnos(alumno)
			begin
				flag = validar_dni(alumno.dni)
					if flag == false
						raise ArgumentError
					else
						if dni_alumnos.include?(alumno.dni)
							raise RuntimeError
							else
							arreglo_alumnos << alumno
							dni_alumnos << alumno.dni
							return "Alumno registrado con exito!!!!"
						end
					end
			rescue ArgumentError
				puts "Error, el DNI #{alumno.dni} es invalido"
			rescue RuntimeError
				puts "Error, el DNI #{alumno.dni} ya se encuentra registrado"
				end
		end

 	 def listar_alumnos
		for a in @arreglo_alumnos
			a.correr_puntaje
		end
		t = @arreglo_alumnos.sort_by {|a| a.puntaje}.reverse
		for a in t
			puts "Código de evaluación: #{a.codigo_eva}".ljust(30) + "Nombre: #{a.nombres}".ljust(25) + "Puntaje final: #{a.puntaje}".ljust(25) + "Estado: #{a.ingresa}"
		end
	 end

	def listar_alumnos_por_edades_i
     	
		cont_11 = 0
		cont_12 = 0
		cont_13 = 0
		cont_14 = 0
		cont_15 = 0

		 for a in @arreglo_alumnos
			if(a.ingresa == "INGRESA")

				if(a.edad == 11)
				cont_11 = cont_11 + 1
				elsif a.edad == 12
				cont_12 = cont_12 + 1
				elsif a.edad == 13
				cont_13 = cont_13 + 1
				elsif a.edad == 14
				cont_14 = cont_14 + 1
				elsif a.edad == 15
				cont_15 = cont_15 + 1
				end
			end
		end
		return  "Cantidad de ingresantes de edad de 11 años: #{cont_11}\n" +"Cantidad de ingresantes de edad de 12 años: #{cont_12}\n"+"Cantidad de ingresantes de edad de 13 años: #{cont_13}\n"+ "Cantidad de ingresantes de edad de 14 años: #{cont_14}\n" + "Cantidad de ingresantes de edad de 15 años: #{cont_15}"
		
	end


	def listar_alumnos_por_edades_n
		cont_11 = 0
		cont_12 = 0
		cont_13 = 0
		cont_14 = 0
		cont_15 = 0

		for a in @arreglo_alumnos
			if(a.ingresa == "NO INGRESA")
				if(a.edad == 11)
				cont_11 = cont_11 + 1
				elsif a.edad == 12
				cont_12 = cont_12 + 1
				elsif a.edad == 13
				cont_13 = cont_13 + 1
				elsif a.edad == 14
				cont_14 = cont_14 + 1
				elsif a.edad == 15
				cont_15 = cont_15 + 1
				end
			end
		end
		return "Cantidad de no ingresantes de edad de 11 años: #{cont_11}\n" + "Cantidad de no ingresantes de edad de 12 años: #{cont_12}\n"+"Cantidad de no ingresantes de edad de 13 años: #{cont_13}\n"+"Cantidad de no ingresantes de edad de 14 años: #{cont_14}\n"+"Cantidad de no ingresantes de edad de 15 años: #{cont_15}"
	end

	def obtenerdatos(dni)
		temp = []
		for datos in arreglo_alumnos
			if datos.dni==dni
				temp.push(datos)
				puts "Tipo de colegio   : #{datos.dame_tipo}\n" + "Nombre            : #{datos.nombres}\n"+ "Apellido          : #{datos.apellido}\n"+"Puntaje obtenido  : #{datos.puntaje}\n"+"Estado final      : #{datos.ingresa}"
			end
		end
	end

	def cantidad_hombres_mujeres
	cont_h = 0
	cont_m = 0
		for a in @arreglo_alumnos
			if(a.genero == "F")
				cont_m = cont_m + 1
			elsif a.genero == "M"
				cont_h = cont_h + 1
			end
		end
	return "Cantidad de postulantes masculinos: #{cont_h}\n" +  "Cantidad de postulantes femeninos: #{cont_m}"
	end

	def ingresantes_masculinos_femeninos
		cont_h = 0
		cont_m = 0
		for a in @arreglo_alumnos
			if(a.ingresa == "INGRESA")
				if(a.genero == "F")
					cont_m = cont_m + 1
				elsif a.genero == "M"
					cont_h = cont_h + 1
				end
			end
			end
		return "Cantidad de ingresantes masculinos: #{cont_h}\n" +  "Cantidad de ingresantes femeninos: #{cont_m}"
	end

	def no_ingresantes_masculinos_femeninos
	cont_h = 0
	cont_m = 0

	for a in @arreglo_alumnos
		if(a.ingresa == "NO INGRESA")
			if(a.genero == "F")
				cont_m = cont_m + 1
			elsif a.genero == "M"
				cont_h = cont_h + 1
			end
		end
	end
	return "Cantidad de no ingresantes masculinos: #{cont_h}\n" + "Cantidad de no ingresantes femeninos: #{cont_m}"
	end

	def porcentaje_ingresantes_nacionales_particulares
		cont_p = 0
		cont_n = 0
		total_i = 0
		for a in arreglo_alumnos
			if(a.ingresa == "INGRESA")
				total_i = total_i + 1
				if a.dame_tipo == "Colegio particular"
					cont_p = cont_p + 1
				elsif a.dame_tipo == "Colegio nacional"
					cont_n = cont_n + 1
				end
			end
		end
		porc_particular = cont_p.to_f / total_i * 100.0
		porc_nacional = cont_n.to_f/ total_i * 100.0
		return  "Porcentaje de ingresantes de colegios nacionales: #{porc_nacional.round(2)} %\n" + "Porcentaje de ingresantes de colegios particulares: #{porc_particular.round(2)} %"
	end

	def porcentaje_no_ingresantes_nacionales_particulares
		cont_p = 0
		cont_n = 0
		total_i = 0
		for a in arreglo_alumnos
			if(a.ingresa == "NO INGRESA")
				total_i = total_i + 1
				if a.dame_tipo == "Colegio particular"
					cont_p = cont_p + 1
				elsif a.dame_tipo == "Colegio nacional"
					cont_n = cont_n + 1
				end
			end
		end
		porc_particular = cont_p.to_f / total_i * 100.0
		porc_nacional = cont_n.to_f/ total_i * 100.0
		return "Porcentaje de no ingresantes de colegios nacionales: #{porc_nacional.round(2)} %\n" + "Porcentaje de no ingresantes de colegios particulares: #{porc_particular.round(2)} %"
	end

	def empezar_evaluaciones
		for a in @arreglo_alumnos
			a.correr_puntaje
		end
		t = @arreglo_alumnos.sort_by {|a| a.puntaje}.reverse
		cc = 0
		for c in t
			cc = cc + 1
			c.ingresa = "INGRESA"
			if(cc>@vacantes)
				c.ingresa = "NO INGRESA"
			end
		end
	end

	def mostrar_resultados_i
		puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
		puts "---------------------------------------------------------------Alumnos ingresantes---------------------------------------------------------------------------"
		puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
		for a in @arreglo_alumnos
			if(a.ingresa == "INGRESA")
				puts ""
				puts "Código de evaluación: #{a.codigo_eva}".ljust(30) + "Nombre: #{a.nombres}".ljust(25) + "Puntaje final: #{a.puntaje}".ljust(25) + "Estado: #{a.ingresa}"
			end
		end
	end

	def mostrar_resultados_n
		puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
		puts "---------------------------------------------------------------Alumnos no ingresantes------------------------------------------------------------------------"
		puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
		for a in @arreglo_alumnos
			if(a.ingresa == "NO INGRESA")
				puts ""
				puts "Código de evaluación: #{a.codigo_eva}".ljust(30) + "Nombre: #{a.nombres}".ljust(25) + "Puntaje final: #{a.puntaje}".ljust(25) + "Estado: #{a.ingresa}"
			end
		end
	end
#----------------------------------------------------------------------------------------------
#REGISTRO DE TUTORES
   def registrar_tutores(tutoria)
		 flag = validar_dni(tutoria.dni_tutor)
		 begin
			 if flag == true
				 if arreglo_tutores.length != 0
					 for tutor in arreglo_tutores
						 if tutoria.dni_alumno == tutor.dni_alumno and tutoria.dni_tutor == tutor.dni_tutor
							 raise RuntimeError
						 end
					 end
					 arreglo_tutores << tutoria
				 else
					 arreglo_tutores << tutoria
				 end
			 else
				 raise ArgumentError
			 end
		 rescue RuntimeError
			 puts "ERROR: La tutoria ya se encuentra registrada"
		 rescue ArgumentError
			 puts "ERROR: El DNI #{tutoria.dni_tutor} es invalido"
		 end
    end

def obtenerdatos_tutor(dni)
	if arreglo_tutores[1] == dni	
		return  "Dni tutor      : #{arreglo_tutores[1]}\n" + "Dni alumno     : #{arreglo_tutores[0]}\n"+"Nombre tutor   : #{arreglo_tutores[3]}\n"+"Apellido tutor : #{arreglo_tutores[2]}\n"+"Dni tutor      : #{arreglo_tutores[1]}\n"+"Dni tutor      : #{arreglo_tutores[1]}\n"+"Parentesco     : #{arreglo_tutores[4]}" 
				
	end
end

	
#---------------------------------------------------------------------------------------------


end
#-----------------------------------------------------------------------------------------------
class Factory
  def self.datos_alumnos(tipo, *arg)
		case tipo
		when 1
			return Colegio_nacional.new(arg[0], arg[1], arg[2], arg[3],arg[4], arg[5], arg[6], arg[7], arg[8])
    when  2
          return Colegio_particular.new(arg[0], arg[1], arg[2], arg[3],arg[4],arg[5], arg[6], arg[7], arg[8])
    end  
	end
	def self.datos_tutores(*arg)
		return Tutor.new(arg[0], arg[1], arg[2], arg[3], arg[4])
	end
end
#-------------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------
# vista

class Vista
  def mostrarMensaje(resultado)
      puts resultado
	end

	def imprimirmensaje(resultado)
		resultado
	end

end
#------------------------------------------------------------------------
class Controlador
   attr_accessor :vista, :administrador
   def initialize(vista, administrador)
     @vista = vista
     @administrador = administrador
   end
   def registra_alumnos(tipo, *arg)
		 alumnos1= Factory.datos_alumnos(tipo, *arg)
		 administrador.registrar_alumnos(alumnos1)
	 end

    def buscar_alumnos_por_Dni(dni)
       #puts"__________________________________________________________________________________________________________________"
       puts "\n----------------------------------Búsqueda de Alumnos por dni-----------------------------------------------"
       alumnos1 = administrador.obtenerdatos(dni)
       vista.imprimirmensaje(alumnos1)
   end

   def obtener_alumnos_ingresantes_por_edades
   	puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    puts "---------------------------------------------------------------LISTADO DE ALUMNOS INGRESANTES POR EDADES-----------------------------------------------------"
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
   	alumnos1 = administrador.listar_alumnos_por_edades_i
   	vista.mostrarMensaje(alumnos1)
   end

    def obtener_alumnos_no_ingresantes_por_edades
 	puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    puts "---------------------------------------------------------------LISTADO DE ALUMNOS NO INGRESANTES POR EDADES--------------------------------------------------"
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
   	alumnos1 = administrador.listar_alumnos_por_edades_n
   	vista.mostrarMensaje(alumnos1)
   end

   def empieza_evaluacion
   	alumnos1 = administrador.empezar_evaluaciones
   end
   def listado_de_alumnos
	puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    puts "-------------------------------------------------------LISTADO DE ALUMNOS ORDENADOS POR PUNTAJE--------------------------------------------------------------"
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
   	alumnos1 = administrador.listar_alumnos
   	vista.imprimirmensaje(alumnos1)
   end  
   def cantidad_de_hombres_y_mujeres
   	puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    puts "-------------------------------------------------------CANTIDAD DE HOMBRES Y MUJERES POSTULANTES-------------------------------------------------------------"
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
   	alumnos1 = administrador.cantidad_hombres_mujeres
   	vista.mostrarMensaje(alumnos1)
   end
   def cantidad_ingresantes_por_genero
   	puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    puts "-------------------------------------------------------CANTIDAD DE HOMBRES Y MUJERES INGRESANTES-------------------------------------------------------------"
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
   	alumnos1 = administrador.ingresantes_masculinos_femeninos
   	vista.mostrarMensaje(alumnos1)
   end
      def cantidad_NO_ingresantes_por_genero
   	puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    puts "-------------------------------------------------------CANTIDAD DE HOMBRES Y MUJERES NO INGRESANTES----------------------------------------------------------"
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
   	alumnos1 = administrador.no_ingresantes_masculinos_femeninos
   	vista.mostrarMensaje(alumnos1)
   end
  	def muestra_Resultados_n
  	alumnos1 = administrador.mostrar_resultados_n
  	vista.imprimirmensaje(alumnos1)
  	end
  	def muestra_Resultados_i
  	alumnos1 = administrador.mostrar_resultados_i
  	vista.imprimirmensaje(alumnos1)
  	end
  	def registro_tutotes(*arg)
			tutoria1 = Factory.datos_tutores(*arg)
			administrador.registrar_tutores(tutoria1)
  		vista.imprimirmensaje(tutoria1)
  	end
  	def porcentaje_nacional_particular_ingresantes
  	puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    puts "----------------------------------------------PORCENTAJE DE INGRESANTES/COLEGIOS PARTICULARES Y NACIONALES---------------------------------------------------"
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
  	alumnos1 = administrador.porcentaje_ingresantes_nacionales_particulares
  	vista.mostrarMensaje(alumnos1)
  	end
 
end


#---------------------------------------------------------------------------------------
class TestDatosAlumnos < Test::Unit::TestCase
  
  def setup
    @admin = Administrador.new(5)
    @vista = Vista.new
    @controlador = Controlador.new(@vista, @admin)
    @controlador.registra_alumnos(1,71111111, "Rodríguez", "Fabián", 13, "M",20, "100", "Urbana", 15)
		@controlador.registra_alumnos(1,72222222, "Fernández", "Fabiola", 12, "F",20, "102", "Urbana", 15 )
		@controlador.registra_alumnos(1,73333333, "López", "Fanny", 11, "F",10, "103", "Rural", 16)
		@controlador.registra_alumnos(1,74444444, "Díaz", "Fátima", 13, "F",20, "104", "Rural", 16)
		@controlador.registra_alumnos(1,75555555, "García", "Fausto", 14, "M",10, "105", "Urbana", 17)
		@controlador.registra_alumnos(1,76666666, "Pérez", "Federico", 11, "M",20, "106", "Urbana", 14)

		@controlador.registra_alumnos(2,72223333, "Sánchez", "Fernando", 12, "M", 10, "107", 330, 2)
		@controlador.registra_alumnos(2,73333222, "Romero", "Filomeno", 15, "M", 10, "108", 200, 8)
		@controlador.registra_alumnos(2,71111222, "Sosa", "Florencio", 15, "M", 20, "109", 600, 7)
		@controlador.registra_alumnos(2,72255555, "Torres", "Florida", 13, "F", 10, "110", 250, 9)
		@controlador.registra_alumnos(2,71118888, "Álvarez", "Flrinda", 13, "F", 10, "111", 350, 10)
		@controlador.registra_alumnos(2,72299999, "Ruiz", "Frida", 11, "F", 10, "112", 400, 1)
		@controlador.registro_tutotes(71111111, 74851444, "Souza", "Fabio", "Profesor de fisica")
		@controlador.empieza_evaluacion
	end

	def testBuscar
		@controlador.buscar_alumnos_por_Dni(72223333)
		@controlador.obtener_alumnos_ingresantes_por_edades
		@controlador.obtener_alumnos_no_ingresantes_por_edades
		@controlador.listado_de_alumnos
		@controlador.cantidad_de_hombres_y_mujeres
		@controlador.cantidad_ingresantes_por_genero
		@controlador.cantidad_NO_ingresantes_por_genero
		@controlador.muestra_Resultados_n
		@controlador.muestra_Resultados_i
		@controlador.porcentaje_nacional_particular_ingresantes
	
	end
end