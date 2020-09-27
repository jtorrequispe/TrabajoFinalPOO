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
  attr_reader :dni_tutor, :dni_alumno, :apellido_tutor, :nombre_tutor, :parentesco
  def initialize(dni_tutor, dni_alumno, apellido_tutor, nombre_tutor, parentesco)
    @dni_alumno, @dni_tutor, @apellido_tutor, @nombre_tutor, @parentesco = dni_alumno, dni_tutor, apellido_tutor, nombre_tutor, parentesco
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

  def set_vacante(x)
    @vacantes = x
  end

  # def validar_dniG(dni)
  #   tamano = dni.to_s.length
  #   if  tamano != 8
  #     raise ArgumentError, "DNI invalido, revise la longitud"
  #   elsif not dni_alumnos.include?(dni)
  #     raise RuntimeError, "DNI #{dni} no registrado"
  #   else
  #     true
  #   end
  # end
  def validar_dniG(dni)
    tamano = dni.to_s.length
    if  tamano != 8
      false
    else
      true
    end
  end

  def validar_dniA(dni)
    if validar_dniG(dni) && (not dni_alumnos.include?(dni))
      dni_alumnos << dni
      true
    else
      false
    end
    # tamano = numero.to_s.length
    # if  tamano != 8
    #   return false
    # elsif dni_alumnos.include?(dni)
    #   return false
    # else
    #   dni_alumnos << dni
    #   return true
    # end
  end

  def dni_alumno?(dni)
    if dni_alumnos.include?(dni)
      true
    else
      false
    end
  end

  def registrar_alumnos(alumno)
    arreglo_alumnos << alumno
  end

  def listar_alumnos
    if arreglo_alumnos.length != 0
      for a in arreglo_alumnos
        a.correr_puntaje
      end
      t = arreglo_alumnos.sort_by {|a| a.puntaje}.reverse
      for a in t
        puts "Código de evaluación: #{a.codigo_eva}".ljust(30) + "Nombre: #{a.nombres}".ljust(25) + "Puntaje final: #{a.puntaje}".ljust(25) + "Estado: #{a.ingresa}"
      end
    else
      raise RuntimeError, "No hay alumnos para mostrar"
    end
  end

  def listar_alumnos_por_edades_i
    cont_11 = 0
    cont_12 = 0
    cont_13 = 0
    cont_14 = 0
    cont_15 = 0

    if arreglo_alumnos.length != 0
      for a in arreglo_alumnos
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
    else
      raise RuntimeError, "No hay alumnos para mostrar"
    end
  end

  def obtenerdatos(dni)
    temp = []
    if dni_alumnos.include?(dni) && validar_dniG(dni)
      for datos in arreglo_alumnos
        if datos.dni==dni
          temp.push(datos)
          puts "Tipo de colegio   : #{datos.dame_tipo}\n" + "Nombre            : #{datos.nombres}\n"+ "Apellido          : #{datos.apellido}\n"+"Puntaje obtenido  : #{datos.puntaje}\n"+"Estado final      : #{datos.ingresa}"
          true
        end
      end
    else
      raise RuntimeError, "El DNI es invalido no se encuentra registrado"
    end
  end

  def cantidad_hombres_mujeres
    cont_h = 0
    cont_m = 0
    for a in arreglo_alumnos
      if(a.genero == "F")
        cont_m = cont_m + 1
      elsif a.genero == "M"
        cont_h = cont_h + 1
      end
    end
    if cont_h == 0 && cont_m == 0
      raise RuntimeError, "No hay datos para mostrar"
    else
      "Cantidad de postulantes masculinos: #{cont_h}\n" +  "Cantidad de postulantes femeninos: #{cont_m}"
    end
  end

  def ingresantes_masculinos_femeninos
    cont_h = 0
    cont_m = 0
    for a in arreglo_alumnos
      if(a.ingresa == "INGRESA")
        if(a.genero == "F")
          cont_m = cont_m + 1
        elsif a.genero == "M"
          cont_h = cont_h + 1
        end
      end
    end
    if cont_h == 0 && cont_m == 0
      raise RuntimeError, "No hay datos para mostrar"
    else
      "Cantidad de ingresantes masculinos: #{cont_h}\n" +  "Cantidad de ingresantes femeninos: #{cont_m}"
    end
  end

  def no_ingresantes_masculinos_femeninos
    cont_h = 0
    cont_m = 0

    for a in arreglo_alumnos
      if(a.ingresa == "NO INGRESA")
        if(a.genero == "F")
          cont_m = cont_m + 1
        elsif a.genero == "M"
          cont_h = cont_h + 1
        end
      end
    end
    if cont_h == 0 && cont_m == 0
      raise RuntimeError, "No hay datos para mostrar"
    else
      "Cantidad de ingresantes masculinos: #{cont_h}\n" +  "Cantidad de ingresantes femeninos: #{cont_m}"
    end
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
    if cont_h == 0 && cont_m == 0
      raise RuntimeError, "No hay datos para mostrar"
    else
      porc_particular = cont_p.to_f / total_i * 100.0
      porc_nacional = cont_n.to_f/ total_i * 100.0
      "Porcentaje de ingresantes de colegios nacionales: #{porc_nacional.round(2)} %\n" + "Porcentaje de ingresantes de colegios particulares: #{porc_particular.round(2)} %"
    end
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
    raise RuntimeError, "No hay datos para mostrar" if cont_p == 0 and cont_n == 0
    porc_particular = cont_p.to_f / total_i * 100.0
    porc_nacional = cont_n.to_f/ total_i * 100.0
    return "Porcentaje de no ingresantes de colegios nacionales: #{porc_nacional.round(2)} %\n" + "Porcentaje de no ingresantes de colegios particulares: #{porc_particular.round(2)} %"
  end

  def empezar_evaluaciones
    raise RuntimeError, "No hay datos para mostrar" if arreglo_alumnos.length == 0
    for a in arreglo_alumnos
      a.correr_puntaje
    end
    t = arreglo_alumnos.sort_by {|a| a.puntaje}.reverse
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
    raise RuntimeError, "No hay datos para mostror" if arreglo_alumnos.length == 0
    for a in arreglo_alumnos
      if(a.ingresa == "INGRESA")
        puts ""
        puts "Código de evaluación: #{a.codigo_eva}".ljust(30) + "Nombre: #{a.nombres}".ljust(25) + "Puntaje final: #{a.puntaje}".ljust(25) + "Estado: #{a.ingresa}"
      end
    end
  end

  def mostrar_resultados_n
    raise RuntimeError, "No hay datos para mostror" if arreglo_alumnos.length == 0
    for a in @arreglo_alumnos
      if(a.ingresa == "NO INGRESA")
        puts ""
        puts "Código de evaluación: #{a.codigo_eva}".ljust(30) + "Nombre: #{a.nombres}".ljust(25) + "Puntaje final: #{a.puntaje}".ljust(25) + "Estado: #{a.ingresa}"
      end
    end
  end

  def registrar_tutor(tutor)
    arreglo_tutores << tutor
    dni_tutores << tutor.dni_tutor
  end

  def obtenerdatos_tutor(dni)
    raise RuntimeError, "No hay datos para mostrar" if dni_tutores.length == 0
    if validar_dniG(dni) && dni_tutores.include?(dni)
      for tutor in arreglo_tutores
        if tutor.dni_tutor==dni
          puts "Dni tutor      : #{datos.dni_tutor}\n" + "Dni alumno     : #{datos.dni_alumno}\n"+"Nombre tutor   : #{datos.nombre_tutor}\n"+"Apellido tutor : #{datos.apellido_tutor}\n"+"Parentesco     : #{datos.parentesco}"
          true
        end
      end
    else
      raise RuntimeError, "El DNI es invalido o no se encuentra registrado"
    end
  end

end
