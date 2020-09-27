require '../Proyecto final/model'
require '../Proyecto final/control'
require "test/unit"

class Vista
  def mostrarMensaje(resultado)
    puts resultado
  end

  def imprimirmensaje(resultado)
    resultado
  end

end

class Reporte
  attr_accessor :admin, :vista
  def initialize
    @admin = Administrador.new(5) # mover luego para que sea parte del menu
    @vista = Vista.new
  end

  def error_handler(e)
    puts e
    puts "Volviendo al menu principal..."
    sleep 2
    menu_principal
  end

  def menu_principal

    opcion = 0
    until (1..15).member?(opcion)
      begin
        puts "==============================="
        puts "=Sistema de Gestion de Ingreso="
        puts "==============================="
        puts
        puts "Es necesario completar el registro y realizar la evaluacion antes de poder mostrar los datos"
        puts "1. Registrar Alumno."
        puts "2. Listar alumnos por puntaje."
        puts "3. Listar ingresantes por edades."
        puts "4. Busqueda por DNI."
        puts "5. Listar Postlantes por genero."
        puts "6. Listar ingresantes por genero."
        puts "7. Listar no ingresantes por genero."
        puts "8. Mostrar porcentaje de ingresantes por tipo de colegio."
        puts "9. Mostrar porcentaje de no ingresantes por tipo de colegio."
        puts "10. Mostrar resultados de los ingresantes"
        puts "11. Mostrar resultados de los no ingresantes"
        puts "12. Registrar Tutor"
        puts "13. Obtener datos de un tutor"
        puts "14. Iniciar evaluacion"
        puts "15. Salir"
        puts
        print "Seleccionar una opción:\n>>"
        opcion = gets.chomp.to_i
        raise ArgumentError, "Opcion invalida, por favor intentelo de nuevo" if not (1..15).member?(opcion)
      rescue ArgumentError => e
        puts e
        puts
        sleep 2
      end
    end
    case opcion
    when 1
      registroA
    when 2
      lista_alumnos
    when 3
      lista_ingresantes_edades
    when 4
      buscar_alumnos_por_Dni
    when 5
      postulantes_por_genero
    when 6
      ingresantes_por_genero
    when 7
      no_ingresantes_por_genero
    when 8
      porcentaje_nacional_particular_ingresantes
    when 9
      porcentaje_nacional_particular_no_ingresantes
    when 10
      muestra_Resultados_i
    when 11
      muestra_Resultados_n
    when 12
      registroT
    when 13
      buscar_tutor_por_Dni
    when 14
      empieza_evaluacion
    when 15
      salir
    end
  end

  def registroA # maneja el registro de alumnos
    greet = "+++Registro de alumnos+++"
    puts greet
    print "Indique el tipo de alumno. Inserte 1 para alumnos de colegio nacional y 2 para\nalumnos de colegio particular\n>>"
    tipo = gets.chomp.to_i
    begin
      if tipo != 1 && tipo != 2
        raise ArgumentError, "Tipo invalido, por favor intentelo de nuevo"
      end
    rescue ArgumentError => e
      puts e
      registroA
    end

    begin
      puts greet
      print "Ingrese el numero de DNI del alumno:\n>>"
      dni = gets.chomp.to_i
      if !admin.validar_dniA(dni)
        raise ArgumentError, "DNI invalido o ya registrado, por favor intente de nuevo"
      else
        break # breaks out of loop if dni is validated succesfully
      end
    rescue ArgumentError => e
      puts e
    end until admin.validar_dniA(dni)

    puts greet
    print "Ingrese los apellidos del alumno, en una sola linea:\n>>"
    apellidos = gets.chomp
    puts greet
    print "Ingrese los nombres del alumno, en una sola linea:\n>>"
    nombres = gets.chomp
    puts greet
    print "Ingrese la edad del alumno\n>>"
    edad = 0
    until (11..15).member?(edad)
      begin
        edad = gets.to_i
        if not (11..15).member?(edad)
          raise ArgumentError, "Edad invalida, por favor intentelo de nuevo"
        end
      rescue ArgumentError => e
        puts e
        print "Ingrese la edad del alumno\n>>"
      end
    end
    puts greet
    print "Ingrese el genero del participante M/F\n>>"
    genero = ""
    until genero == "M" || genero == "F"
      begin
        genero = gets.chomp
        if genero != "M" && genero != "F"
          raise ArgumentError, "Genero invalido, por favor intentelo de nuevo"
        end
      rescue ArgumentError => e
        puts e
        print "Ingrese el genero del participante M/F\n>>"
      end
    end
    puts greet
    print "Ingrese la cantidad de preguntas\n>>"
    q_preguntas = 0
    until q_preguntas != 0
      begin
        q_preguntas = gets.to_i
        if q_preguntas == 0
          raise ArgumentError, "Cantidad de preguntas invalida, ingrese un numero mayor a 0"
        end
      rescue ArgumentError => e
        puts e
        print "Ingrese la cantidad de preguntas\n>>"
      end
    end
    puts greet
    print "Ingrese el codigo de evaluacion\n>>"
    cod_eval = gets.chomp
    if tipo == 1
      puts greet
      print "Ingrese el tipo de colegio. Ingrese 1 para rural y 2 para urbano\n>>"
      opt = 0
      until opt == 1 || opt == 2
        begin
          opt = gets.chomp.to_i
          if opt == 1
            colegio = "Rural"
          elsif opt == 2
            colegio = "Urbana"
          else
            raise ArgumentError, "Por favor, ingrese 1 para rural, o 2 para urbana"
          end
        rescue ArgumentError => e
          puts e
          print "Ingrese el tipo de colegio.\n>>"
        end
      end
      puts greet
      print "Ingrese el promedio obtenido por el alumno\n>>"
      promedio = 0
      until promedio.between?(1, 20)
        begin
          promedio = gets.chomp.to_i
          if not promedio.between?(0, 20)
            raise ArgumentError, "El promedio ingresado se encuentra fuera del rango"
          end
        rescue ArgumentError => e
          puts e
          print "Ingrese el promedio obtenido por el alumno\n>>"
        end
      end
    else
      puts greet
      print "Ingrese el monto de pension del alumno\n>>"
      monto = 0
      until monto != 0
        begin
          monto = gets.chomp.to_i
          if monto == 0
            raise ArgumentError, "Monto invalido"
          end
        rescue ArgumentError => e
          puts e
          print "Por favor ingrese el moto\n>>"
        end
      end
      puts greet
      print "Ingrese el puesto obtenido en 2do.\n>>"
      puesto = 0
      until puesto != 0
        begin
          puesto = gets.chomp.to_i
          if puesto <= 0
            raise ArgumentError, "Puesto invalido"
          end
        rescue ArgumentError => e
          puts e
          print "Ingrese el puesto obtenido en 2do.\n>>"
        end
      end
    end
    if tipo == 1
      alumno = Factory.datos_alumnos(tipo, dni, apellidos, nombres, edad, genero, q_preguntas, cod_eval, monto, puesto)
    else
      alumno = Factory.datos_alumnos(tipo, dni, apellidos, nombres, edad, genero, q_preguntas, cod_eval, colegio, promedio)
    end
    admin.registrar_alumnos(alumno)
    menu_principal
  end # end registroA

  def lista_alumnos
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    puts "-------------------------------------------------------LISTADO DE ALUMNOS ORDENADOS POR PUNTAJE--------------------------------------------------------------"
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    begin
    alumnos1 = admin.listar_alumnos
    vista.imprimirmensaje(alumnos1)
    rescue RuntimeError => e
      error_handler(e)
    end
    menu_principal
  end # end lista_alumnos


  def lista_ingresantes_edades
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    puts "---------------------------------------------------------------LISTADO DE ALUMNOS INGRESANTES POR EDADES-----------------------------------------------------"
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    begin
    alumnos1 = admin.listar_alumnos_por_edades_i
    vista.mostrarMensaje(alumnos1)
    rescue RuntimeError => e
      error_handler(e)
    end
    menu_principal
  end # end lista_ingresantes

  def buscar_alumnos_por_Dni()
    puts "____________________________________________________________________________________________________________"
    puts "----------------------------------Búsqueda de Alumnos por dni-----------------------------------------------"
    puts "____________________________________________________________________________________________________________"
    print "Ingrese el DNI a consultar\n>>"
    begin
      dni = gets.chomp.to_i
      validacion = admin.validar_dniG(dni)
    rescue ArgumentError => e
      puts e
      print "Ingrese el DNI a consultar\n>>"
    rescue RuntimeError => e
      error_handler(e)
    end while !validacion
    alumnos1 = admin.obtenerdatos(dni)
    vista.imprimirmensaje(alumnos1)
    menu_principal
  end # end of buscar por dni

  def postulantes_por_genero
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    puts "-------------------------------------------------------CANTIDAD DE HOMBRES Y MUJERES POSTULANTES-------------------------------------------------------------"
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    begin
    alumnos1 = admin.cantidad_hombres_mujeres
    vista.mostrarMensaje(alumnos1)
    rescue RuntimeError => e
      error_handler(e)
    end
    menu_principal
  end

  def ingresantes_por_genero
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    puts "-------------------------------------------------------CANTIDAD DE HOMBRES Y MUJERES INGRESANTES-------------------------------------------------------------"
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    begin
      alumnos1 = admin.ingresantes_masculinos_femeninos
      vista.mostrarMensaje(alumnos1)
    rescue RuntimeError => e
      error_handler(e)
    end
    menu_principal
  end

  def no_ingresantes_por_genero
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    puts "-------------------------------------------------------CANTIDAD DE HOMBRES Y MUJERES NO INGRESANTES----------------------------------------------------------"
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    begin
      alumnos1 = admin.no_ingresantes_masculinos_femeninos
      vista.mostrarMensaje(alumnos1)
    rescue RuntimeError => e
      error_handler(e)
    end
    menu_principal
  end

  def porcentaje_nacional_particular_ingresantes
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    puts "----------------------------------------------PORCENTAJE DE INGRESANTES/COLEGIOS PARTICULARES Y NACIONALES---------------------------------------------------"
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    begin
      alumnos1 = admin.admin.porcentaje_ingresantes_nacionales_particulares
      vista.mostrarMensaje(alumnos1)
    rescue RuntimeError => e
      error_handler(e)
    end
    menu_principal
  end

  def porcentaje_nacional_particular_no_ingresantes
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    puts "---------------------------------------------PORCENTAJE DE NO INGRESANTES/COLEGIOS PARTICULARES Y NACIONALES-------------------------------------------------"
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    begin
      alumnos1 = admin.porcentaje_no_ingresantes_nacionales_particulares
      vista.mostrarMensaje(alumnos1)
    rescue RuntimeError => e
      error_handler(e)
    end
    menu_principal
  end

  def muestra_Resultados_i
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    puts "---------------------------------------------------------------Alumnos ingresantes---------------------------------------------------------------------------"
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    begin
      alumnos1 = admin.mostrar_resultados_i
      vista.imprimirmensaje(alumnos1)
    rescue RuntimeError => e
      error_handler(e)
    end
    menu_principal
  end

  def muestra_Resultados_n
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    puts "---------------------------------------------------------------Alumnos no ingresantes------------------------------------------------------------------------"
    puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------"
    begin
      alumnos1 = admin.mostrar_resultados_n
      vista.imprimirmensaje(alumnos1)
    rescue RuntimeError => e
      error_handler(e)
    end
    menu_principal
  end

  def registroT
    greet = "+++Registro de tutores+++"
    puts greet
    begin
      puts greet
      print "Ingrese el numero de DNI del tutor:\n>>"
      dni_tutor = gets.chomp.to_i
      if !admin.validar_dniG(dni_tutor)
        raise ArgumentError, "DNI invalido o ya registrado, por favor intente de nuevo"
      else
        break # breaks out of loop if dni is validated succesfully
      end
    rescue ArgumentError => e
      puts e
    end while !admin.validar_dniG(dni_tutor)
    begin
      puts greet
      print "Ingrese el numero de DNI del alumno:\n>>"
      dni_alumno = gets.chomp.to_i
      if admin.dni_alumno?(dni_alumno)
        break
      else
        raise RuntimeError, "El alumno no se encuentra registrado"
      end
    rescue RuntimeError => e
      puts e
    end while !admin.dni_alumno?(dni_alumno)
    puts greet
    print "Ingrese los apellidos del tutor\n>>"
    apellidos = gets.chomp
    puts greet
    puts "Ingrese los nombres del tutor\n>>"
    nombres = gets.chomp
    puts greet
    print "Ingrese el parentesco con el alumno\n>>"
    parentesco = gets.chomp

    tutor = Factory.datos_tutores(dni_tutor, dni_alumno, apellidos, nombres, parentesco)
    admin.registrar_tutor(tutor)
    menu_principal
  end

  def buscar_tutor_por_Dni()
    puts "____________________________________________________________________________________________________________"
    puts "----------------------------------Búsqueda de Tutor por dni-----------------------------------------------"
    puts "____________________________________________________________________________________________________________"
    print "Ingrese el DNI a consultar\n>>"
    begin
      dni = gets.chomp.to_i
      raise ArgumentError, "DNI Invalido" if !admin.validar_dniG(dni)
    rescue ArgumentError => e
      puts e
      print "Ingrese el DNI a consultar\n>>"
    end while !admin.validar_dniG(dni)
    begin
      alumnos1 = admin.obtenerdatos_tutor(dni)
      vista.imprimirmensaje(alumnos1)
    rescue RuntimeError => e
      error_handler(e)
    end
    menu_principal
  end # end of buscar por dni

  def empieza_evaluacion
    begin
    alumnos1 = administrador.empezar_evaluaciones
    rescue RuntimeError => e
      error_handler(e)
    end
    menu_principal
  end

  def salir()
    system('exit')
  end

end # end class

if $PROGRAM_NAME == __FILE__
  a = Reporte.new()
  a.menu_principal
end